import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/design/markei_theme.dart';
import 'package:markei/app/markei_app.dart';
import 'package:markei/app/markei_composition.dart';
import 'package:markei/app/native_auth_closure_runner.dart';
import 'package:markei/app/pages/home_page.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';

void main() {
  test('layout classes resolve exact compact medium and wide boundaries', () {
    expect(MarkeiLayoutClass.fromWidth(599), MarkeiLayoutClass.compact);
    expect(MarkeiLayoutClass.fromWidth(600), MarkeiLayoutClass.medium);
    expect(MarkeiLayoutClass.fromWidth(1023), MarkeiLayoutClass.medium);
    expect(MarkeiLayoutClass.fromWidth(1024), MarkeiLayoutClass.wide);
  });

  testWidgets('compact More exposes stable secondary destinations', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);
    final composition = _composition(db, queries, closure: true);

    await tester.pumpWidget(MarkeiApp(composition: composition));
    await _pumpReady(tester);

    await tester.tap(find.text('More'));
    await _pumpReady(tester);

    for (final label in const [
      'Catalogue',
      'Analytics',
      'Household',
      'Guide',
      'Documentation',
      'Settings',
      'Audit',
    ]) {
      expect(find.text(label), findsWidgets);
    }
    expect(find.text('Closure'), findsNothing);
    expect(find.textContaining('PIN'), findsNothing);

    await tester.tap(find.text('Analytics').last);
    await _pumpReady(tester);
    expect(find.byKey(const Key('analytics.page')), findsOneWidget);
  });

  testWidgets('selected destination survives responsive boundary changes', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(599, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);

    await tester.pumpWidget(MarkeiApp(composition: _composition(db, queries)));
    await _pumpReady(tester);

    await tester.tap(find.text('History'));
    await _pumpReady(tester);
    expect(find.byKey(const Key('history.empty')), findsOneWidget);

    for (final width in const [600.0, 1023.0, 1024.0]) {
      tester.view.physicalSize = Size(width, 900);
      await _pumpReady(tester);
      expect(find.byKey(const Key('history.empty')), findsOneWidget);
    }
  });

  testWidgets('Home primary and secondary actions use stable destinations', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final queries = LocalQueryRepository(db);

    await tester.pumpWidget(MarkeiApp(composition: _composition(db, queries)));
    await _pumpReady(tester);

    await _tapVisible(
      tester,
      find.byKey(const Key('home.action.registerPurchase')),
    );
    await _pumpReady(tester);
    expect(find.byKey(const Key('purchase.localNotice')), findsOneWidget);

    await _tapRailDestination(tester, 'Home');
    await _pumpReady(tester);
    await _tapVisible(tester, find.byKey(const Key('home.action.viewLists')));
    await _pumpReady(tester);
    expect(find.byKey(const Key('lists.page')), findsOneWidget);

    await _tapRailDestination(tester, 'Home');
    await _pumpReady(tester);
    await _tapVisible(
      tester,
      find.byKey(const Key('home.action.browseCatalogue')),
    );
    await _pumpReady(tester);
    expect(find.byKey(const Key('products.empty')), findsOneWidget);

    await _tapRailDestination(tester, 'Home');
    await _pumpReady(tester);
    await _tapVisible(tester, find.byKey(const Key('home.action.openHistory')));
    await _pumpReady(tester);
    expect(find.byKey(const Key('history.empty')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Home remains usable at 200 percent text scale', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await tester.pumpWidget(
      MaterialApp(
        theme: markeiTheme(),
        home: Scaffold(body: HomePage(onNavigate: (_) {})),
      ),
    );
    await _pumpReady(tester);

    expect(find.byKey(const Key('home.page')), findsOneWidget);
    expect(
      find.byKey(const Key('home.action.registerPurchase')),
      findsOneWidget,
    );
    expect(find.byKey(const Key('home.action.viewLists')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Closure feature gate remains absent and does not shift another selected destination',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final queries = LocalQueryRepository(db);

      await tester.pumpWidget(
        MarkeiApp(composition: _composition(db, queries, closure: false)),
      );
      await _pumpReady(tester);
      await tester.tap(find.text('Settings'));
      await _pumpReady(tester);
      expect(find.byKey(const Key('settings.page')), findsOneWidget);

      await tester.pumpWidget(
        MarkeiApp(composition: _composition(db, queries, closure: true)),
      );
      await _pumpReady(tester);
      expect(find.byKey(const Key('settings.page')), findsOneWidget);

      await tester.pumpWidget(
        MarkeiApp(composition: _composition(db, queries, closure: false)),
      );
      await _pumpReady(tester);
      expect(find.byKey(const Key('settings.page')), findsOneWidget);
    },
  );
}

MarkeiComposition _composition(
  LocalDatabase db,
  LocalQueryRepository queries, {
  bool closure = false,
}) {
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
    nativeClosureRunner: const NativeAuthClosureRunner.unavailable(),
    nativeClosureSurfaceEnabled: closure,
  );
}

Future<void> _pumpReady(WidgetTester tester) async {
  for (var i = 0; i < 20; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await Scrollable.ensureVisible(
    tester.element(finder),
    duration: const Duration(milliseconds: 1),
  );
  await _pumpReady(tester);
  await tester.tap(finder);
}

Future<void> _tapRailDestination(WidgetTester tester, String label) async {
  final destination = find.descendant(
    of: find.byKey(const Key('markei.navigationRail')),
    matching: find.text(label),
  );
  await tester.tap(destination);
  await _pumpReady(tester);
}
