import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/export_destination.dart';
import 'package:markei/infrastructure/platform/local_export_destination.dart';

void main() {
  test(
    'Windows export writes one final Downloads file without overwrite',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'markei-export-destination-',
      );
      addTearDown(() async {
        if (await directory.exists()) {
          await directory.delete(recursive: true);
        }
      });
      final request = ExportDestinationRequest(
        baseNameCue: 'History Selected Purchases',
        extension: 'csv',
        mediaType: 'text/csv',
        bytes: [49, 50, 51],
      );
      final destination = LocalExportDestination(
        downloadsDirectoryOverride: directory,
        platformOverride: 'windows',
        clock: () => DateTime.utc(2026, 7, 31, 12, 30),
      );

      final first = await destination.write(request);
      final second = await destination.write(request);

      expect(first, isA<ExportDestinationSuccess>());
      expect(second, isA<ExportDestinationSuccess>());
      final firstPath = (first as ExportDestinationSuccess).path;
      final secondPath = (second as ExportDestinationSuccess).path;
      expect(firstPath, isNot(secondPath));
      expect(await File(firstPath).readAsBytes(), [49, 50, 51]);
      expect(await File(secondPath).readAsBytes(), [49, 50, 51]);
      expect(await directory.list().length, 2);
    },
  );

  test(
    'Android public Downloads export is typed unavailable with zero writes',
    () async {
      final directory = await Directory.systemTemp.createTemp(
        'markei-export-android-',
      );
      addTearDown(() async {
        if (await directory.exists()) {
          await directory.delete(recursive: true);
        }
      });
      final destination = LocalExportDestination(
        downloadsDirectoryOverride: directory,
        platformOverride: 'android',
      );

      final result = await destination.write(
        ExportDestinationRequest(
          baseNameCue: 'analytics',
          extension: 'pdf',
          mediaType: 'application/pdf',
          bytes: [37, 80, 68, 70],
        ),
      );

      expect(result, isA<ExportDestinationFailure>());
      expect(
        (result as ExportDestinationFailure).kind,
        ExportDestinationFailureKind.unsupportedPlatform,
      );
      expect(await directory.list().isEmpty, isTrue);
    },
  );
}
