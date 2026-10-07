import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_plus/share_plus.dart';
import 'package:markei/application/content_sharing.dart';
import 'package:markei/application/export_destination.dart';
import 'package:markei/infrastructure/platform/native_content_sharing.dart';

void main() {
  test(
    'native file handoff retains bytes and uses an owned cache directory',
    () async {
      final temp = await Directory.systemTemp.createTemp('marc-sharing-test-');
      addTearDown(() => temp.delete(recursive: true));
      final unrelated = File('${temp.path}/keep.txt');
      await unrelated.writeAsString('preserve');
      ShareParams? captured;
      final sharing = NativeContentSharing(
        platformOverride: 'android',
        temporaryDirectory: () async => temp,
        invoke: (params) async {
          captured = params;
          return const ShareResult('', ShareResultStatus.success);
        },
      );
      final result = await sharing.share(
        ContentShareRequest(
          title: 'São João',
          file: ExportDestinationRequest(
            baseNameCue: 'marc-history',
            extension: 'pdf',
            mediaType: 'application/pdf',
            bytes: [37, 80, 68, 70],
          ),
        ),
      );
      expect(result, ContentShareResult.handedOff);
      expect(captured!.subject, 'São João');
      final file = captured!.files!.single;
      expect(
        file.path,
        startsWith(
          '${temp.path}${Platform.pathSeparator}marc-shares${Platform.pathSeparator}',
        ),
      );
      expect(await File(file.path).readAsBytes(), [37, 80, 68, 70]);
      expect(file.mimeType, 'application/pdf');
      expect(await unrelated.readAsString(), 'preserve');
      expect(
        contentShareMessage(result),
        contains('Delivery is not confirmed'),
      );
    },
  );
  test(
    'JSON access report retains UTF-8 bytes and application/json on native handoff',
    () async {
      final temp = await Directory.systemTemp.createTemp('marc-json-sharing-');
      addTearDown(() => temp.delete(recursive: true));
      final bytes = utf8.encode(
        jsonEncode({
          'format': 'marc-local-account-access',
          'account_id': 'synthetic-account',
          'datasets': {
            'list_note_revisions': [
              {'note': 'Café da manhã'},
            ],
          },
        }),
      );
      ShareParams? captured;
      final sharing = NativeContentSharing(
        platformOverride: 'android',
        temporaryDirectory: () async => temp,
        invoke: (params) async {
          captured = params;
          return const ShareResult('', ShareResultStatus.success);
        },
      );
      final result = await sharing.share(
        ContentShareRequest(
          title: 'Marc local data export',
          file: ExportDestinationRequest(
            baseNameCue: 'marc-my-local-data',
            extension: 'json',
            mediaType: 'application/json',
            bytes: bytes,
          ),
        ),
      );
      expect(result, ContentShareResult.handedOff);
      expect(captured!.text, isNull);
      expect(captured!.title, 'Marc local data export');
      final file = captured!.files!.single;
      expect(file.path, endsWith('marc-my-local-data.json'));
      expect(file.mimeType, 'application/json');
      expect(await File(file.path).readAsBytes(), bytes);
      final actual = jsonDecode(await File(file.path).readAsString());
      expect(
        actual['datasets']['list_note_revisions'].single['note'],
        'Café da manhã',
      );
      expect(
        contentShareMessage(result),
        contains('Delivery is not confirmed'),
      );
    },
  );
  test(
    'JSON with a mismatched MIME type is rejected before cache access or native invocation',
    () async {
      var directoryReads = 0;
      var invocations = 0;
      final sharing = NativeContentSharing(
        platformOverride: 'android',
        temporaryDirectory: () async {
          directoryReads++;
          throw StateError('No directory should be requested');
        },
        invoke: (_) async {
          invocations++;
          return const ShareResult('', ShareResultStatus.success);
        },
      );
      final result = await sharing.share(
        ContentShareRequest(
          title: 'Local data',
          file: ExportDestinationRequest(
            baseNameCue: 'marc-my-local-data',
            extension: 'json',
            mediaType: 'text/plain',
            bytes: utf8.encode('{"format":"marc-local-account-access"}'),
          ),
        ),
      );
      expect(result, ContentShareResult.failed);
      expect(directoryReads, 0);
      expect(invocations, 0);
    },
  );
  test(
    'cancel, unknown outcome, exceptions and duplicate actions are distinct',
    () async {
      final completion = Completer<ShareResult>();
      var calls = 0;
      final sharing = NativeContentSharing(
        platformOverride: 'windows',
        invoke: (_) {
          calls++;
          return completion.future;
        },
      );
      const request = ContentShareRequest(title: 'List', text: 'Coffee');
      final first = sharing.share(request);
      expect(await sharing.share(request), ContentShareResult.busy);
      completion.complete(const ShareResult('', ShareResultStatus.dismissed));
      expect(await first, ContentShareResult.dismissed);
      expect(calls, 1);
      final unknown = NativeContentSharing(
        platformOverride: 'windows',
        invoke: (_) async =>
            const ShareResult('', ShareResultStatus.unavailable),
      );
      expect(await unknown.share(request), ContentShareResult.unconfirmed);
      final failure = NativeContentSharing(
        platformOverride: 'windows',
        invoke: (_) async => throw StateError('private details'),
      );
      expect(await failure.share(request), ContentShareResult.failed);
      expect(
        contentShareMessage(ContentShareResult.failed),
        isNot(contains('private details')),
      );
    },
  );
  test(
    'unsafe filenames, empty payloads and unsupported platforms never hand off',
    () async {
      var calls = 0;
      final sharing = NativeContentSharing(
        platformOverride: 'android',
        invoke: (_) async {
          calls++;
          return const ShareResult('', ShareResultStatus.success);
        },
      );
      expect(
        await sharing.share(
          ContentShareRequest(
            title: 'Bad',
            file: ExportDestinationRequest(
              baseNameCue: '../outside',
              extension: 'csv',
              mediaType: 'text/csv',
              bytes: [1],
            ),
          ),
        ),
        ContentShareResult.failed,
      );
      expect(
        await sharing.share(
          const ContentShareRequest(title: 'Empty', text: ' '),
        ),
        ContentShareResult.failed,
      );
      expect(calls, 0);
      expect(
        await NativeContentSharing(
          platformOverride: 'linux',
        ).share(const ContentShareRequest(title: 'No', text: 'text')),
        ContentShareResult.failed,
      );
    },
  );
}
