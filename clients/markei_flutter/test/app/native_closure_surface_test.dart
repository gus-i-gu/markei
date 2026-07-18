import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  testWidgets('native closure surface requires explicit development flag', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final composition = _composition(enabled: true);
    addTearDown(composition.database.close);

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Closure'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('nativeClosure.page')), findsOneWidget);
    expect(find.text('closure-disabled'), findsOneWidget);
    await tester.tap(find.byKey(const Key('nativeClosure.Status')));
    await tester.pumpAndSettle();
    expect(find.text('configuration-missing'), findsOneWidget);
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
