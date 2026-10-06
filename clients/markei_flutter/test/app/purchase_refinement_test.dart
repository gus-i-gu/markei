import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/design/markei_theme.dart';
import 'package:markei/app/pages/purchase_page.dart';
import 'package:markei/app/widgets/quantity_unit_picker.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/infrastructure/local/local_database.dart' hide Product;
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';

const account = AccountId('11111111-1111-4111-8111-111111111111');
const device = DeviceId('22222222-2222-4222-8222-222222222222');

void main() {
  testWidgets(
    'future purchase review preserves draft and confirmation writes once',
    (tester) async {
      final queries = await openPurchase(tester, now: DateTime(2026, 10, 5));
      await enter(tester, 'product.code', 'FUTURE');
      await enter(tester, 'product.name', 'Coffee');
      await enter(tester, 'item.lineTotal', '10');
      await tap(tester, 'product.createAnyway');
      await tap(tester, 'purchase.store.select');
      await tester.tap(find.text('Test Market').last);
      await settle(tester);
      await enter(tester, 'purchase.date', '05102027');
      await enter(tester, 'purchase.time', '0930');
      await tap(tester, 'purchase.review');
      await tap(tester, 'purchase.register');
      expect(
        find.byKey(const Key('purchase.futureConfirmation')),
        findsOneWidget,
      );
      expect(await queries.listRecentPurchases(account), isEmpty);
      await tap(tester, 'purchase.reviewFuture');
      expect(text(tester, 'purchase.date'), '05/10/2027');
      expect(
        find.byKey(const Key('purchase.futureConfirmation')),
        findsNothing,
      );
      await tap(tester, 'purchase.review');
      await tap(tester, 'purchase.register');
      await tap(tester, 'purchase.confirmFuture');
      expect(await queries.listRecentPurchases(account), hasLength(1));
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'complete invalid dates and missing price are explained before staging',
    (tester) async {
      final queries = await openPurchase(tester);
      await enter(tester, 'purchase.date', '31022026');
      expect(find.text('Enter a valid calendar date.'), findsOneWidget);
      await enter(tester, 'purchase.time', '2590');
      expect(find.text('Use a time from 00:00 to 23:59.'), findsOneWidget);
      await enter(tester, 'product.code', 'COFFEE');
      await enter(tester, 'product.name', 'Coffee');
      await tap(tester, 'product.createAnyway');
      expect(
        find.text(
          'Enter either a unit price or a total price. Marc calculates the other.',
        ),
        findsOneWidget,
      );
      expect(await queries.listProducts(account), isEmpty);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'two 500g packages derive quantity, both prices and persisted purchase',
    (tester) async {
      final queries = await openPurchase(tester);
      await enter(tester, 'product.code', 'COFFEE-500');
      await enter(tester, 'product.name', 'Coffee');
      await enter(tester, 'product.brand', 'Brand');
      await enter(tester, 'product.packageAmount', '500');
      await tap(tester, 'product.packageUnit');
      for (final unit in [
        'mL — millilitres',
        'mg — milligrams',
        'g — grams',
        'L — litres',
        'kg — kilograms',
        'un — individual units',
      ]) {
        expect(find.text(unit), findsOneWidget);
      }
      await tester.tap(find.text('g — grams'));
      await settle(tester);
      await enter(tester, 'item.packageCount', '2');
      await enter(tester, 'item.pricePerUnit', '11');
      expect(text(tester, 'item.quantity'), '1.000000');
      expect(text(tester, 'item.lineTotal'), '22.00');
      expect(text(tester, 'item.comparablePrice'), '22.00');
      await enter(tester, 'item.packageCount', '3');
      expect(text(tester, 'item.lineTotal'), '33.00');
      expect(text(tester, 'item.quantity'), '1.500000');
      await enter(tester, 'item.packageCount', '2');
      await enter(tester, 'item.lineTotal', '24');
      expect(text(tester, 'item.pricePerUnit'), '12.00');
      await tap(tester, 'product.createAnyway');
      await tap(tester, 'purchase.store.select');
      await tester.tap(find.text('Test Market').last);
      await settle(tester);
      await enter(tester, 'purchase.date', '05102026');
      await enter(tester, 'purchase.time', '0930');
      expect(text(tester, 'purchase.date'), '05/10/2026');
      expect(text(tester, 'purchase.time'), '09:30');
      await tap(tester, 'purchase.review');
      await tap(tester, 'purchase.register');
      expect(
        find.text(
          'Purchase saved on this device. Sync it to share it with your other devices.',
        ),
        findsOneWidget,
      );
      final purchases = await queries.listRecentPurchases(account);
      final detail = await queries.getPurchaseDetail(
        account,
        purchases.single.purchaseId,
      );
      expect(detail!.items.single.packageCount, 2);
      expect(detail.items.single.purchasedAmount, '1.000000');
      expect(detail.items.single.lineTotalMinorUnits, 2400);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'bulk supports both price directions and catalogue fixes measurement kind',
    (tester) async {
      final queries = await openPurchase(tester, bulkProduct: true);
      await enter(tester, 'product.code', 'BULK-TEST');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await settle(tester);
      expect(find.text('Mode: BULK · mass'), findsOneWidget);
      await enter(tester, 'item.quantity', '2');
      await enter(tester, 'item.pricePerUnit', '10');
      expect(text(tester, 'item.lineTotal'), '20.00');
      await enter(tester, 'item.lineTotal', '25');
      expect(text(tester, 'item.pricePerUnit'), '12.50');
      await enter(tester, 'item.quantity', '2.5');
      expect(text(tester, 'item.lineTotal'), '25');
      expect(text(tester, 'item.pricePerUnit'), '10.00');
      await tap(tester, 'item.unit');
      expect(find.text('mg — milligrams'), findsOneWidget);
      expect(find.text('un — individual units'), findsNothing);
      expect(find.text('L — litres'), findsNothing);
      await tester.tap(find.text('g — grams'));
      await settle(tester);
      await enter(tester, 'item.quantity', '2500');
      expect(text(tester, 'item.pricePerUnit'), '0.01');
      expect(text(tester, 'item.comparablePrice'), '10.00');
      await tap(tester, 'product.useSelected');
      await tap(tester, 'purchase.line.edit.1');
      expect(text(tester, 'item.lineTotal'), '25.00');
      expect(text(tester, 'item.quantity'), '2.500000');
      expect(text(tester, 'item.pricePerUnit'), '10.00');
      expect(
        (await queries.listProducts(account)).single.mode,
        ProductMode.bulk,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'last edited total is preserved for repeating rate and zero count is explained',
    (tester) async {
      await openPurchase(tester);
      await enter(tester, 'item.packageCount', '3');
      await enter(tester, 'item.lineTotal', '10');
      expect(text(tester, 'item.pricePerUnit'), '3.333333');
      await enter(tester, 'item.packageCount', '6');
      expect(text(tester, 'item.lineTotal'), '10');
      expect(text(tester, 'item.pricePerUnit'), '1.666667');
      await enter(tester, 'item.packageCount', '0');
      expect(
        find.text('Units bought must be greater than zero.'),
        findsOneWidget,
      );
      expect(text(tester, 'item.pricePerUnit'), isEmpty);
      expect(text(tester, 'item.quantity'), isEmpty);
      await enter(tester, 'item.packageCount', '1.5');
      expect(find.text('Units bought must be a whole number.'), findsOneWidget);
      expect(text(tester, 'item.packageCount'), '1.5');
    },
  );

  testWidgets(
    'compact form presents optional blue and required green without overflow',
    (tester) async {
      await openPurchase(tester, size: const Size(360, 900));
      expect(find.text('Purchase details'), findsOneWidget);
      final date = tester.widget<TextField>(
        find.byKey(const Key('purchase.date')),
      );
      expect(date.style!.color, MarkeiColors.green);
      expect(date.style!.fontWeight, FontWeight.w600);
      final person = tester.widget<DropdownButton>(
        find.byKey(const Key('purchase.person.select')),
      );
      expect(person.style!.color, MarkeiColors.information);
      expect(person.style!.fontWeight, FontWeight.w400);
      await tester.scrollUntilVisible(
        find.byKey(const Key('item.unitGuide')),
        300,
        scrollable: find
            .descendant(
              of: find.byKey(const Key('purchase.page')),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await settle(tester);
      expect(tester.takeException(), isNull);
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('item.comparablePrice')))
            .readOnly,
        isTrue,
      );
      expect(
        tester
            .widget<QuantityUnitPicker>(
              find.byKey(const Key('product.packageUnit')),
            )
            .onChanged,
        isNotNull,
      );
    },
  );
}

Future<LocalQueryRepository> openPurchase(
  WidgetTester tester, {
  bool bulkProduct = false,
  Size size = const Size(1200, 1800),
  DateTime? now,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  final db = LocalDatabase.memory();
  addTearDown(db.close);
  final queries = LocalQueryRepository(db);
  await queries.createStore(account, 'Test Market');
  if (bulkProduct) {
    await queries.createProduct(
      account,
      const ProductDraft(
        userCode: 'BULK-TEST',
        name: 'Rice',
        brand: 'Brand',
        mode: ProductMode.bulk,
        measurementKind: MeasurementKind.mass,
      ),
    );
  }
  await tester.pumpWidget(
    MaterialApp(
      theme: markeiTheme(),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: PurchasePage(
            accountId: account,
            deviceId: device,
            registration: LocalPurchaseRepository(db),
            catalogueQueries: queries,
            references: queries,
            refreshSignal: 0,
            onRegistered: () {},
            now: () => now ?? DateTime(2026, 10, 6),
          ),
        ),
      ),
    ),
  );
  await settle(tester);
  return queries;
}

Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 20; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> enter(WidgetTester tester, String key, String value) async {
  final finder = find.byKey(Key(key));
  await tester.ensureVisible(finder);
  await settle(tester);
  await tester.enterText(finder, value);
  await settle(tester);
}

Future<void> tap(WidgetTester tester, String key) async {
  final finder = find.byKey(Key(key));
  await tester.ensureVisible(finder);
  await settle(tester);
  await tester.tap(finder);
  await settle(tester);
}

String text(WidgetTester tester, String key) =>
    tester.widget<TextField>(find.byKey(Key(key))).controller!.text;
