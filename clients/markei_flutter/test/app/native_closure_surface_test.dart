import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/build_provenance.dart';
import 'package:markei/app/markei_app.dart';
import 'package:markei/app/markei_composition.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';

void main() {
  testWidgets('native closure surface is absent by default', (tester) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final composition = _composition(enabled: false);
    addTearDown(composition.database.close);

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await tester.pumpAndSettle();

    expect(find.text('Closure'), findsNothing);
    expect(find.byKey(const Key('nativeClosure.page')), findsNothing);
  });

  testWidgets(
    'native closure surface is absent with development flag enabled',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 1600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final composition = _composition(enabled: true);
      addTearDown(composition.database.close);

      await tester.pumpWidget(MarkeiApp(composition: composition));
      await tester.pumpAndSettle();

      expect(find.text('Closure'), findsNothing);
      expect(find.byKey(const Key('nativeClosure.page')), findsNothing);
      expect(find.byKey(const Key('nativeClosure.Diagnostics')), findsNothing);
    },
  );

  testWidgets('MarkeiApp does not expose Closure boot identity', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final composition = _composition(enabled: true);
    addTearDown(composition.database.close);

    await tester.pumpWidget(
      MarkeiApp(
        composition: composition,
        buildProvenance: BuildProvenance.fromRaw(
          sourceRevision: 'abcdef123456abcdef123456abcdef123456abcd',
          sourceTreeSha256:
              'fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Closure'), findsNothing);
    expect(find.text('Source revision #abcdef123456'), findsNothing);
    expect(
      find.text(
        'Source tree SHA-256 '
        'fedcba9876543210fedcba9876543210fedcba9876543210fedcba9876543210',
      ),
      findsNothing,
    );
  });
}

MarkeiComposition _composition({required bool enabled}) {
  final db = LocalDatabase.memory();
  final queries = LocalQueryRepository(db);
  return MarkeiComposition(
    database: db,
    purchaseRegistration: LocalPurchaseRepository(db),
    catalogueQueries: queries,
    purchaseHistory: queries,
    references: queries,
    preferences: queries,
    productLists: queries,
    purchaseExports: queries,
    accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
    deviceId: const DeviceId('22222222-2222-4222-8222-222222222222'),
    nativeClosureSurfaceEnabled: enabled,
  );
}
