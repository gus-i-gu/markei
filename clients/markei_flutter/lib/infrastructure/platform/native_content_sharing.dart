import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

import '../../application/content_sharing.dart';

/// Uses OS sharing with app-owned temporary files and no storage permission.
final class NativeContentSharing implements ContentSharingPort {
  NativeContentSharing({
    Future<ShareResult> Function(ShareParams)? invoke,
    Future<Directory> Function()? temporaryDirectory,
    this.platformOverride,
  }) : _invoke = invoke ?? SharePlus.instance.share,
       _temporaryDirectory = temporaryDirectory ?? getTemporaryDirectory;

  final Future<ShareResult> Function(ShareParams) _invoke;
  final Future<Directory> Function() _temporaryDirectory;
  final String? platformOverride;
  var _busy = false;

  @override
  Future<ContentShareResult> share(ContentShareRequest request) async {
    if (_busy) return ContentShareResult.busy;
    _busy = true;
    try {
      final platform = platformOverride ?? Platform.operatingSystem;
      if (platform != 'android' && platform != 'windows') {
        return ContentShareResult.failed;
      }
      final files = <XFile>[];
      final content = request.file;
      if (content != null) {
        if (content.bytes.isEmpty ||
            content.bytes.length > 25 * 1024 * 1024 ||
            !RegExp(r'^[a-zA-Z0-9_-]{1,100}$').hasMatch(content.baseNameCue) ||
            !const {'pdf', 'csv', 'txt', 'json'}.contains(content.extension) ||
            (content.extension == 'json' &&
                content.mediaType != 'application/json')) {
          return ContentShareResult.failed;
        }
        final root = Directory(
          p.join((await _temporaryDirectory()).path, 'marc-shares'),
        );
        await root.create(recursive: true);
        // Keep recent files because recipient apps may read them asynchronously.
        final cutoff = DateTime.now().subtract(const Duration(days: 1));
        await for (final entity in root.list(followLinks: false)) {
          if (entity is Directory &&
              RegExp(r'^[a-f0-9-]{36}$').hasMatch(p.basename(entity.path))) {
            if ((await entity.stat()).modified.isBefore(cutoff)) {
              try {
                await entity.delete(recursive: true);
              } on FileSystemException {
                /* In use. */
              }
            }
          }
        }
        final directory = Directory(p.join(root.path, const Uuid().v4()));
        await directory.create();
        final file = File(
          p.join(directory.path, '${content.baseNameCue}.${content.extension}'),
        );
        await file.writeAsBytes(Uint8List.fromList(content.bytes), flush: true);
        files.add(XFile(file.path, mimeType: content.mediaType));
      } else if (request.text == null || request.text!.trim().isEmpty) {
        return ContentShareResult.failed;
      }
      final result = await _invoke(
        ShareParams(
          title: request.title,
          subject: request.title,
          text: request.text,
          files: files.isEmpty ? null : files,
        ),
      );
      return switch (result.status) {
        ShareResultStatus.success => ContentShareResult.handedOff,
        ShareResultStatus.dismissed => ContentShareResult.dismissed,
        ShareResultStatus.unavailable => ContentShareResult.unconfirmed,
      };
    } on Object {
      return ContentShareResult.failed;
    } finally {
      _busy = false;
    }
  }
}
