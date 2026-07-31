import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../../application/export_destination.dart';

final class LocalExportDestination implements ExportDestinationPort {
  LocalExportDestination({
    this.downloadsDirectoryOverride,
    this.platformOverride,
    DateTime Function()? clock,
    this.maxCollisionAttempts = 100,
  }) : _clock = clock ?? (() => DateTime.now().toUtc());

  final Directory? downloadsDirectoryOverride;
  final String? platformOverride;
  final DateTime Function() _clock;
  final int maxCollisionAttempts;

  @override
  Future<ExportDestinationResult> write(
    ExportDestinationRequest request,
  ) async {
    final platform = platformOverride ?? _currentPlatform();
    if (platform == 'android') {
      return const ExportDestinationFailure(
        kind: ExportDestinationFailureKind.unsupportedPlatform,
        message:
            'Public Downloads export is unavailable on this Android build. No file was created.',
      );
    }
    if (platform != 'windows') {
      return const ExportDestinationFailure(
        kind: ExportDestinationFailureKind.unsupportedPlatform,
        message:
            'Downloads export is unavailable on this platform. No file was created.',
      );
    }
    final directory =
        downloadsDirectoryOverride ?? await getDownloadsDirectory();
    if (directory == null) {
      return const ExportDestinationFailure(
        kind: ExportDestinationFailureKind.destinationUnavailable,
        message: 'Downloads is unavailable. No file was created.',
      );
    }
    try {
      await directory.create(recursive: true);
    } on FileSystemException {
      return const ExportDestinationFailure(
        kind: ExportDestinationFailureKind.destinationUnavailable,
        message: 'Downloads is unavailable. No file was created.',
      );
    }

    final stem = _safeStem(request.baseNameCue);
    final extension = _safeExtension(request.extension);
    final stamp = _timestamp(_clock().toUtc());
    for (var attempt = 0; attempt < maxCollisionAttempts; attempt++) {
      final suffix = attempt == 0 ? '' : '-${attempt + 1}';
      final path =
          '${directory.path}${Platform.pathSeparator}$stem-$stamp$suffix.$extension';
      final file = File(path);
      try {
        await file.create(exclusive: true);
        try {
          await file.writeAsBytes(request.bytes, flush: true);
        } on Object {
          if (await file.exists()) {
            await file.delete();
          }
          return const ExportDestinationFailure(
            kind: ExportDestinationFailureKind.writeFailed,
            message:
                'The export could not be completed. No completed file is available.',
          );
        }
        return ExportDestinationSuccess(
          destinationLabel: 'Downloads',
          path: path,
          bytesWritten: request.bytes.length,
        );
      } on FileSystemException catch (error) {
        if (await file.exists()) {
          continue;
        }
        final text = error.toString().toLowerCase();
        if (text.contains('denied') || text.contains('permission')) {
          return const ExportDestinationFailure(
            kind: ExportDestinationFailureKind.permissionDenied,
            message:
                'Markei could not write to Downloads. Check access and try again.',
          );
        }
        return const ExportDestinationFailure(
          kind: ExportDestinationFailureKind.writeFailed,
          message:
              'The export could not be completed. No completed file is available.',
        );
      }
    }
    return const ExportDestinationFailure(
      kind: ExportDestinationFailureKind.safeNameExhausted,
      message:
          'A safe export name could not be created. No existing file was replaced.',
    );
  }

  String _currentPlatform() {
    if (Platform.isWindows) return 'windows';
    if (Platform.isAndroid) return 'android';
    return 'unsupported';
  }

  String _safeStem(String value) {
    final sanitized = value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    return sanitized.isEmpty ? 'markei-export' : sanitized;
  }

  String _safeExtension(String value) {
    final sanitized = value.trim().toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9]'),
      '',
    );
    return sanitized.isEmpty ? 'dat' : sanitized;
  }

  String _timestamp(DateTime value) {
    return '${value.year.toString().padLeft(4, '0')}'
        '${value.month.toString().padLeft(2, '0')}'
        '${value.day.toString().padLeft(2, '0')}T'
        '${value.hour.toString().padLeft(2, '0')}'
        '${value.minute.toString().padLeft(2, '0')}'
        '${value.second.toString().padLeft(2, '0')}Z';
  }
}
