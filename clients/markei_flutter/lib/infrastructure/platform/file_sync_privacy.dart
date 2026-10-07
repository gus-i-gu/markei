import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../application/sync_privacy.dart';

/// Keep one instance shared by Settings and the native Closure runner.
/// The choice is installation-local, outside the business/sync schema.
final class FileSyncPrivacyPolicy implements SyncPrivacyPolicy {
  FileSyncPrivacyPolicy({Future<Directory> Function()? directory})
    : _resolveFile = (() async => File(
        path.join(
          (await (directory ?? getApplicationSupportDirectory)()).path,
          'marc-privacy.json',
        ),
      ));

  FileSyncPrivacyPolicy.atFile(File file) : _resolveFile = (() async => file);

  final Future<File> Function() _resolveFile;
  Future<void> _tail = Future<void>.value();
  int _pendingPauses = 0;
  bool _unavailable = false;
  bool _hasPersistedChoice = false;

  Future<T> _ordered<T>(Future<T> Function() action) {
    final operation = _tail.then((_) => action());
    // An error is delivered to the caller without poisoning the operation
    // queue. The separate unavailable latch remains closed until explicit save.
    _tail = operation.then<void>((_) {}, onError: (Object _, StackTrace _) {});
    return operation;
  }

  @override
  Future<bool> readPaused() => _ordered(_readPaused);

  Future<bool> _readPaused() async {
    if (_unavailable) throw const SyncPrivacyChoiceUnavailable();
    try {
      final file = await _resolveFile();
      final temporary = File('${file.path}.tmp');
      // An interrupted atomic save is not evidence that Sync was allowed.
      if (await FileSystemEntity.type(temporary.path, followLinks: false) !=
          FileSystemEntityType.notFound) {
        throw const SyncPrivacyChoiceUnavailable();
      }
      final type = await FileSystemEntity.type(file.path, followLinks: false);
      if (type == FileSystemEntityType.notFound) {
        if (_hasPersistedChoice) {
          throw const SyncPrivacyChoiceUnavailable();
        }
        // Existing installations keep explicit manual Sync available until
        // the user chooses to pause. No provider request occurs just by reading.
        return false;
      }
      if (type != FileSystemEntityType.file) {
        throw const SyncPrivacyChoiceUnavailable();
      }
      final saved = jsonDecode(await file.readAsString());
      if (saved is! Map<String, dynamic> ||
          saved['version'] != 1 ||
          saved['syncPaused'] is! bool) {
        throw const SyncPrivacyChoiceUnavailable();
      }
      _hasPersistedChoice = true;
      return saved['syncPaused'] as bool;
    } on Object {
      _unavailable = true;
      throw const SyncPrivacyChoiceUnavailable();
    }
  }

  @override
  Future<void> setPaused(bool paused) {
    // Latch before entering the queue: even an already queued operation must
    // not start after the user's pause request.
    if (paused) _pendingPauses++;
    return _ordered(() async {
      try {
        final file = await _resolveFile();
        final temporary = File('${file.path}.tmp');
        // Never follow a link to read or overwrite a different preference (or
        // another file). An explicit save may replace a stale regular .tmp,
        // but cannot authorize an indirect or non-file destination.
        for (final candidate in [file, temporary]) {
          final type = await FileSystemEntity.type(
            candidate.path,
            followLinks: false,
          );
          if (type != FileSystemEntityType.notFound &&
              type != FileSystemEntityType.file) {
            throw const SyncPrivacyChoiceUnavailable();
          }
        }
        await file.parent.create(recursive: true);
        await temporary.writeAsString(
          jsonEncode({'version': 1, 'syncPaused': paused}),
          flush: true,
        );
        await temporary.rename(file.path);
        _hasPersistedChoice = true;
        _unavailable = false;
      } on Object {
        _unavailable = true;
        throw const SyncPrivacyChoiceUnavailable();
      } finally {
        if (paused) _pendingPauses--;
      }
    });
  }

  @override
  Future<T> runWhenAllowed<T>(
    Future<T> Function() action,
    T Function() blocked,
  ) {
    if (_pendingPauses > 0) return Future<T>.sync(blocked);
    return _ordered(() async {
      if (_pendingPauses > 0) return blocked();
      final paused = await _readPaused();
      // A pause may arrive while the filesystem read is awaiting completion.
      if (_pendingPauses > 0 || paused) return blocked();
      return action();
    });
  }
}
