import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/sync_privacy.dart';
import 'package:markei/infrastructure/platform/file_sync_privacy.dart';

void main() {
  late Directory directory;
  late File file;

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('marc-privacy-test-');
    file = File('${directory.path}/marc-privacy.json');
  });
  tearDown(() => directory.delete(recursive: true));

  test(
    'a dangling preference link fails closed and is never followed on save',
    () async {
      final target = File('${directory.path}/missing-target.json');
      if (!await _createLinkOrSkip(file.path, target.path)) return;
      final policy = FileSyncPrivacyPolicy.atFile(file);
      await expectLater(
        policy.readPaused(),
        throwsA(isA<SyncPrivacyChoiceUnavailable>()),
      );
      await expectLater(
        policy.setPaused(true),
        throwsA(isA<SyncPrivacyChoiceUnavailable>()),
      );
      expect(await target.exists(), isFalse);
      expect(
        await FileSystemEntity.type(file.path, followLinks: false),
        FileSystemEntityType.link,
      );
    },
  );

  test(
    'a preference link to an allowed choice is rejected without changing its target',
    () async {
      final target = File('${directory.path}/other-choice.json');
      const content = '{"version":1,"syncPaused":false}';
      await target.writeAsString(content);
      if (!await _createLinkOrSkip(file.path, target.path)) return;
      final policy = FileSyncPrivacyPolicy.atFile(file);
      var calls = 0;
      await expectLater(
        policy.runWhenAllowed(() async {
          calls++;
          return true;
        }, () => false),
        throwsA(isA<SyncPrivacyChoiceUnavailable>()),
      );
      await expectLater(
        policy.setPaused(true),
        throwsA(isA<SyncPrivacyChoiceUnavailable>()),
      );
      expect(calls, 0);
      expect(await target.readAsString(), content);
      expect(
        await FileSystemEntity.type(file.path, followLinks: false),
        FileSystemEntityType.link,
      );
    },
  );

  test(
    'a temporary-file link cannot overwrite its target during an explicit save',
    () async {
      final target = File('${directory.path}/other-document.txt');
      const content = 'Unrelated document';
      await target.writeAsString(content);
      final temporary = File('${file.path}.tmp');
      if (!await _createLinkOrSkip(temporary.path, target.path)) return;
      final policy = FileSyncPrivacyPolicy.atFile(file);
      await expectLater(
        policy.readPaused(),
        throwsA(isA<SyncPrivacyChoiceUnavailable>()),
      );
      await expectLater(
        policy.setPaused(true),
        throwsA(isA<SyncPrivacyChoiceUnavailable>()),
      );
      expect(await target.readAsString(), content);
      expect(await file.exists(), isFalse);
      expect(
        await FileSystemEntity.type(temporary.path, followLinks: false),
        FileSystemEntityType.link,
      );
    },
  );

  test(
    'manual Sync remains available on first use; pause survives restart',
    () async {
      final first = FileSyncPrivacyPolicy(directory: () async => directory);
      expect(await first.readPaused(), isFalse);
      expect(await file.exists(), isFalse);
      await first.setPaused(true);
      expect(jsonDecode(await file.readAsString()), {
        'version': 1,
        'syncPaused': true,
      });
      expect(await File('${file.path}.tmp').exists(), isFalse);

      final restarted = FileSyncPrivacyPolicy.atFile(file);
      expect(await restarted.readPaused(), isTrue);
      expect(
        await restarted.runWhenAllowed(() async => 'ran', () => 'blocked'),
        'blocked',
      );
      await restarted.setPaused(false);
      final resumed = FileSyncPrivacyPolicy.atFile(file);
      expect(await resumed.readPaused(), isFalse);
      expect(
        await resumed.runWhenAllowed(() async => 'ran', () => 'blocked'),
        'ran',
      );
    },
  );

  test(
    'malformed and unsupported saved choices never permit an action',
    () async {
      for (final value in [
        '{',
        'null',
        '[]',
        '{"version":1,"syncPaused":"false"}',
        '{"version":2,"syncPaused":false}',
        '{"syncPaused":false}',
      ]) {
        await file.writeAsString(value);
        final policy = FileSyncPrivacyPolicy.atFile(file);
        var calls = 0;
        await expectLater(
          policy.readPaused(),
          throwsA(isA<SyncPrivacyChoiceUnavailable>()),
        );
        await expectLater(
          policy.runWhenAllowed(() async {
            calls++;
            return true;
          }, () => false),
          throwsA(isA<SyncPrivacyChoiceUnavailable>()),
        );
        expect(calls, 0);
        // Repairing a file externally is not an explicit user decision to resume.
        await file.writeAsString('{"version":1,"syncPaused":false}');
        await expectLater(
          policy.readPaused(),
          throwsA(isA<SyncPrivacyChoiceUnavailable>()),
        );
        await policy.setPaused(true);
        expect(await policy.readPaused(), isTrue);
      }
    },
  );

  test(
    'a non-file preference and interrupted atomic saves fail closed',
    () async {
      await Directory(file.path).create();
      await expectLater(
        FileSyncPrivacyPolicy.atFile(file).readPaused(),
        throwsA(isA<SyncPrivacyChoiceUnavailable>()),
      );
      await Directory(file.path).delete();
      final temporary = File('${file.path}.tmp');
      await temporary.writeAsString('{"version":1,"syncPaused":true}');
      final policy = FileSyncPrivacyPolicy.atFile(file);
      await expectLater(
        policy.readPaused(),
        throwsA(isA<SyncPrivacyChoiceUnavailable>()),
      );
      await policy.setPaused(true);
      expect(await policy.readPaused(), isTrue);
      expect(await temporary.exists(), isFalse);
    },
  );

  test(
    'removing a previously known choice never silently resumes Sync',
    () async {
      final policy = FileSyncPrivacyPolicy.atFile(file);
      await policy.setPaused(true);
      await file.delete();
      await expectLater(
        policy.readPaused(),
        throwsA(isA<SyncPrivacyChoiceUnavailable>()),
      );
      await expectLater(
        policy.runWhenAllowed(() async => 'ran', () => 'blocked'),
        throwsA(isA<SyncPrivacyChoiceUnavailable>()),
      );
    },
  );

  test(
    'failed preference save blocks subsequent actions and redacts errors',
    () async {
      final obstruction = File('${directory.path}/not-a-directory');
      await obstruction.writeAsString('fixture');
      final policy = FileSyncPrivacyPolicy.atFile(
        File('${obstruction.path}/marc-privacy.json'),
      );
      await expectLater(
        policy.setPaused(true),
        throwsA(
          isA<SyncPrivacyChoiceUnavailable>().having(
            (error) => error.toString(),
            'safe error',
            'sync-choice-unavailable',
          ),
        ),
      );
      var calls = 0;
      await expectLater(
        policy.runWhenAllowed(() async {
          calls++;
          return true;
        }, () => false),
        throwsA(isA<SyncPrivacyChoiceUnavailable>()),
      );
      expect(calls, 0);
    },
  );

  test(
    'pause waits for active work and rejects queued and later callbacks',
    () async {
      final policy = FileSyncPrivacyPolicy.atFile(file);
      final started = Completer<void>();
      final release = Completer<void>();
      var calls = 0;
      final active = policy.runWhenAllowed(() async {
        calls++;
        started.complete();
        await release.future;
        return 'completed';
      }, () => 'blocked');
      await started.future;
      final queued = policy.runWhenAllowed(() async {
        calls++;
        return 'queued';
      }, () => 'blocked');
      var pauseCompleted = false;
      final pause = policy.setPaused(true).then((_) {
        pauseCompleted = true;
      });
      final later = policy.runWhenAllowed(() async {
        calls++;
        return 'later';
      }, () => 'blocked');
      expect(await later, 'blocked');
      expect(pauseCompleted, isFalse);
      expect(await file.exists(), isFalse);
      release.complete();
      expect(await active, 'completed');
      expect(await queued, 'blocked');
      await pause;
      expect(pauseCompleted, isTrue);
      expect(calls, 1);
      expect(await FileSyncPrivacyPolicy.atFile(file).readPaused(), isTrue);
    },
  );

  test(
    'provider exceptions release the gate without changing the preference',
    () async {
      final policy = FileSyncPrivacyPolicy.atFile(file);
      await expectLater(
        policy.runWhenAllowed<String>(() async {
          throw StateError('fixture');
        }, () => 'blocked'),
        throwsStateError,
      );
      await policy.setPaused(true);
      expect(await policy.readPaused(), isTrue);
      await policy.setPaused(false);
      expect(
        await policy.runWhenAllowed(() async => 'next', () => 'blocked'),
        'next',
      );
    },
  );

  test(
    'ordered explicit resume cannot let a queued action bypass a pending pause',
    () async {
      final policy = FileSyncPrivacyPolicy.atFile(file);
      final pause = policy.setPaused(true);
      final resume = policy.setPaused(false);
      var calls = 0;
      final during = policy.runWhenAllowed(() async {
        calls++;
        return 'ran';
      }, () => 'blocked');
      expect(await during, 'blocked');
      await pause;
      await resume;
      expect(calls, 0);
      expect(
        await policy.runWhenAllowed(() async => 'ran', () => 'blocked'),
        'ran',
      );
    },
  );
}

Future<bool> _createLinkOrSkip(String linkPath, String targetPath) async {
  try {
    await Link(linkPath).create(targetPath);
    return true;
  } on FileSystemException {
    if (!Platform.isWindows) rethrow;
    markTestSkipped(
      'Windows symbolic-link creation is unavailable for this test process.',
    );
    return false;
  }
}
