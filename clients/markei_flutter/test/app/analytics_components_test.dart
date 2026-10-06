import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/widgets/analytics_components.dart';
import 'package:markei/domain/analytics/analytics_models.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/application/analytics.dart';

void main() {
  test(
    'legacy records retain results without exporting current evidence as frozen proof',
    () {
      final record = _record();
      final csv = analyticsRecordCsv(
        record,
        AnalyticsDataset(accountId: const AccountId('account'), rows: const []),
      );
      expect(csv, contains('Raw evidence snapshot unavailable'));
      expect(csv, contains('12.00,BRL'));
      expect(record.interpretation, 'Sum Price paid grouped by Product.');
    },
  );
  testWidgets(
    'saved cards directly select the immutable result and use two text lines',
    (tester) async {
      final record = _record();
      AnalyticsRecordId? selected;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SavedAnalysisBrowser(
              records: [record],
              selected: null,
              onOlder: () {},
              onNewer: () {},
              onSelected: (id) => selected = id,
            ),
          ),
        ),
      );
      final card = find.byKey(const Key('analytics.record.ABC12345'));
      expect(
        find.descendant(of: card, matching: find.byType(Text)),
        findsNWidgets(2),
      );
      await tester.tap(card);
      expect(selected!.value, record.id.value);
    },
  );

  testWidgets(
    'recorded values dropdown scrolls beyond five visible rows and includes Use all records',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 1500);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      var allCalls = 0;
      final toggled = <String>[];
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AnalyticsComposerView(
                draft: const AnalyticsComposerDraft(),
                validation: const AnalyticsDraftValidation(
                  canRun: false,
                  explanation: 'Choose values',
                ),
                options: {
                  AnalyticsDeterminantKind.product: [
                    for (var i = 0; i < 12; i++)
                      AnalyticsOption(key: 'row-$i', label: 'Product $i'),
                  ],
                },
                onDeterminantChanged: (_) {},
                onToggleDeterminantKey: toggled.add,
                onToggleVariable: (_) {},
                onOperationChanged: (_) {},
                onTimeframeChanged: (_) {},
                onRun: () {},
                onClear: () {},
                onSelectAllDeterminants: () => allCalls++,
              ),
            ),
          ),
        ),
      );
      expect(find.byKey(const Key('analytics.choose.row-0')), findsNothing);
      await tester.tap(find.byKey(const Key('analytics.choose.dropdown')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('analytics.choose.row-0')));
      expect(toggled, ['row-0']);
      final choiceList = find.descendant(
        of: find.byKey(const Key('analytics.choose.dropdown')),
        matching: find.byType(ListView),
      );
      final list = tester.widget<ListView>(choiceList);
      expect(list.itemExtent, 56);
      expect(tester.getSize(choiceList).height, 280);
      await tester.drag(choiceList, const Offset(0, -400));
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('analytics.choose.row-8')), findsOneWidget);
      await tester.tap(find.byKey(const Key('analytics.choose.row-8')));
      expect(toggled, contains('row-8'));
      await tester.tap(find.text('Use all records'));
      expect(allCalls, 1);
      for (final field
          in tester.widgetList<DropdownButton<AnalyticsDeterminantKind>>(
            find.byType(DropdownButton<AnalyticsDeterminantKind>),
          )) {
        expect(
          field.items!.map((item) => item.value),
          containsAll(AnalyticsDeterminantKind.values),
        );
        expect(
          field.items!
              .singleWhere(
                (item) => item.value == AnalyticsDeterminantKind.purchasedFor,
              )
              .enabled,
          isFalse,
        );
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Chart and Table consume one frozen record without mutation actions',
    (tester) async {
      final record = _record();
      var presentation = AnalyticsResultPresentation.chart;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AnalyticsResultView(
                record: record,
                presentation: presentation,
                onPresentationChanged: (value) => presentation = value,
                onExportCsv: () {},
                onExportPdf: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('analytics.chart.summary')), findsOneWidget);
      expect(find.textContaining('Record #ABC12345'), findsOneWidget);
      expect(find.text('Statistics: Price paid'), findsOneWidget);
      expect(find.text('Result interpretation'), findsOneWidget);
      expect(find.byTooltip('Delete card'), findsNothing);
      expect(find.byTooltip('Move card earlier'), findsNothing);

      await tester.tap(find.text('Table'));
      await tester.pump();
      expect(presentation, AnalyticsResultPresentation.table);
    },
  );

  testWidgets('Variables compact projection exposes Purchase and Item facts', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnalyticsVariablesView(
            state: AnalyticsVariablesState(
              projection: AnalyticsVariablesProjection.purchases,
              search: '',
              sort: AnalyticsVariablesSort.timeDescending,
              pageIndex: 0,
              pageSize: 20,
              purchaseRows: [
                AnalyticsPurchaseProjectionRow(
                  purchaseId: const PurchaseId('purchase-1'),
                  occurrenceTime: DateTime.utc(2026, 7, 31),
                  storeId: const StoreId('store-1'),
                  storeName: 'Store',
                  purchasedBy: const AnalyticsReference(
                    id: 'person-1',
                    code: '@001',
                    label: 'Alex',
                  ),
                  paymentMethod: null,
                  itemCount: 1,
                  purchaseTotal: const AnalyticsMoneyAmount(
                    currencyCode: 'BRL',
                    minorUnits: 1200,
                  ),
                  itemIds: const {PurchaseItemId('item-1')},
                ),
              ],
              itemRows: const [],
              selectedRowIds: const {},
            ),
            wide: false,
            onProjectionChanged: (_) {},
            onSearchChanged: (_) {},
            onSortChanged: (_) {},
            onPreviousPage: () {},
            onNextPage: () {},
            onTogglePurchase: (_) {},
            onToggleItem: (_) {},
            onUseSelectedRows: () {},
            onShowAll: () {},
          ),
        ),
      ),
    );

    expect(find.text('Variables'), findsOneWidget);
    expect(find.text('Store name'), findsOneWidget);
    expect(find.text('Store'), findsOneWidget);
    expect(find.textContaining('Alex'), findsOneWidget);
    expect(find.byKey(const Key('analytics.purchases.table')), findsOneWidget);
    expect(find.textContaining('purchase-1'), findsNothing);
    expect(find.textContaining('BRL 12.00'), findsOneWidget);
  });

  testWidgets(
    'compact Variables rows scroll through all item facts and preserve selection',
    (tester) async {
      tester.view.physicalSize = const Size(390, 1000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      PurchaseItemId? toggled;
      var applied = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: AnalyticsVariablesView(
                state: AnalyticsVariablesState(
                  projection: AnalyticsVariablesProjection.containedItems,
                  search: '',
                  sort: AnalyticsVariablesSort.timeDescending,
                  pageIndex: 0,
                  pageSize: 20,
                  purchaseRows: const [],
                  itemRows: [
                    AnalyticsEvidenceRow(
                      id: const PurchaseItemId('item-internal-id'),
                      accountId: const AccountId('account-internal-id'),
                      purchaseId: const PurchaseId('purchase-internal-id'),
                      purchaseOccurrenceTime: DateTime.utc(2026, 7, 31),
                      purchaseTotal: const AnalyticsMoneyAmount(
                        currencyCode: 'BRL',
                        minorUnits: 3500,
                      ),
                      productId: const ProductId('product-internal-id'),
                      productCode: 'P-001',
                      productName: 'Cocoa',
                      productBrand: 'Brand',
                      storeId: const StoreId('store-internal-id'),
                      storeName: 'Market',
                      purchasedBy: const AnalyticsReference(
                        id: 'person-internal-id',
                        code: '@001',
                        label: 'Alex',
                      ),
                      paymentMethod: const AnalyticsReference(
                        id: 'payment-internal-id',
                        code: '#001',
                        label: 'Debit',
                      ),
                      quantity: const NormalizedQuantity(
                        kind: MeasurementKind.mass,
                        unit: CanonicalUnit.kg,
                        microunits: 3 * NormalizedQuantity.factor,
                      ),
                      lineTotal: const AnalyticsMoneyAmount(
                        currencyCode: 'BRL',
                        minorUnits: 1200,
                      ),
                      unitPrice: const AnalyticsUnitPrice(
                        currencyCode: 'BRL',
                        minorUnitsPerCanonicalUnit: 400,
                        kind: MeasurementKind.mass,
                        unit: CanonicalUnit.kg,
                      ),
                    ),
                  ],
                  selectedRowIds: const {PurchaseItemId('item-internal-id')},
                ),
                wide: false,
                onProjectionChanged: (_) {},
                onSearchChanged: (_) {},
                onSortChanged: (_) {},
                onPreviousPage: () {},
                onNextPage: () {},
                onTogglePurchase: (_) {},
                onToggleItem: (id) => toggled = id,
                onUseSelectedRows: () => applied = true,
                onShowAll: () {},
              ),
            ),
          ),
        ),
      );

      final table = find.byKey(const Key('analytics.items.table'));
      final rowScroller = find.byKey(const Key('analytics.items.scroll'));
      final horizontal = find.descendant(
        of: rowScroller,
        matching: find.byType(SingleChildScrollView),
      );
      final scrollbar = tester.widget<Scrollbar>(
        find.descendant(of: rowScroller, matching: find.byType(Scrollbar)),
      );
      expect(scrollbar.thumbVisibility, isTrue);
      expect(scrollbar.trackVisibility, isTrue);
      expect(scrollbar.controller!.position.maxScrollExtent, greaterThan(0));
      for (final header in [
        'Product code',
        'Product name',
        'Purchased by',
        'Purchased for',
        'Payment method',
        'Quantity and unit',
        'Unit price',
        'Price paid',
        'Purchase total',
      ]) {
        expect(find.text(header), findsOneWidget);
      }
      for (final value in [
        'P-001',
        'Cocoa',
        '3.000000 kg',
        'BRL 4.00 per kg',
        'BRL 12.00',
        'BRL 35.00',
      ]) {
        expect(find.text(value), findsOneWidget);
      }
      expect(find.textContaining('Alex'), findsOneWidget);
      expect(find.textContaining('Debit'), findsOneWidget);
      expect(find.textContaining('internal-id'), findsNothing);
      expect(find.text('Promotion'), findsNothing);

      await tester.drag(horizontal, const Offset(-5000, 0));
      await tester.pumpAndSettle();
      expect(scrollbar.controller!.offset, greaterThan(0));
      expect(
        tester
            .getRect(find.text('BRL 35.00'))
            .overlaps(tester.getRect(horizontal)),
        isTrue,
      );
      scrollbar.controller!.jumpTo(0);
      await tester.pump();
      await tester.tap(
        find.descendant(of: table, matching: find.byType(Checkbox)),
      );
      expect(toggled!.value, 'item-internal-id');
      await tester.tap(
        find.byKey(const Key('analytics.variables.useSelected')),
      );
      expect(applied, isTrue);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Variables wide projection hides UUIDs and keeps Date-Time Store',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2)),
            child: Scaffold(
              body: SingleChildScrollView(
                child: AnalyticsVariablesView(
                  state: AnalyticsVariablesState(
                    projection: AnalyticsVariablesProjection.containedItems,
                    search: '',
                    sort: AnalyticsVariablesSort.timeDescending,
                    pageIndex: 0,
                    pageSize: 20,
                    purchaseRows: const [],
                    itemRows: [
                      AnalyticsEvidenceRow(
                        id: const PurchaseItemId('item-uuid-1'),
                        accountId: const AccountId('account-1'),
                        purchaseId: const PurchaseId('purchase-uuid-1'),
                        purchaseOccurrenceTime: DateTime.utc(2026, 7, 31),
                        purchaseTotal: const AnalyticsMoneyAmount(
                          currencyCode: 'BRL',
                          minorUnits: 1200,
                        ),
                        productId: const ProductId('product-uuid-1'),
                        productCode: 'P-1',
                        productName: 'Product',
                        productBrand: 'Brand',
                        storeId: const StoreId('store-uuid-1'),
                        storeName: 'Store',
                        purchasedBy: null,
                        paymentMethod: null,
                        quantity: const NormalizedQuantity(
                          kind: MeasurementKind.mass,
                          unit: CanonicalUnit.kg,
                          microunits: NormalizedQuantity.factor,
                        ),
                        lineTotal: const AnalyticsMoneyAmount(
                          currencyCode: 'BRL',
                          minorUnits: 1200,
                        ),
                        unitPrice: null,
                      ),
                    ],
                    selectedRowIds: const {},
                  ),
                  wide: true,
                  onProjectionChanged: (_) {},
                  onSearchChanged: (_) {},
                  onSortChanged: (_) {},
                  onPreviousPage: () {},
                  onNextPage: () {},
                  onTogglePurchase: (_) {},
                  onToggleItem: (_) {},
                  onUseSelectedRows: () {},
                  onShowAll: () {},
                ),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      expect(find.text('Date-Time of purchase'), findsOneWidget);
      expect(find.text('Store name'), findsOneWidget);
      expect(find.text('Price paid'), findsOneWidget);
      expect(find.text('Purchase total'), findsOneWidget);
      expect(find.textContaining('2026'), findsOneWidget);
      expect(find.textContaining('Store'), findsWidgets);
      expect(find.textContaining('purchase-uuid-1'), findsNothing);
      expect(find.textContaining('product-uuid-1'), findsNothing);
      expect(find.textContaining('store-uuid-1'), findsNothing);
    },
  );
}

AnalyticsRecord _record() {
  return AnalyticsRecord(
    id: const AnalyticsRecordId(1),
    fingerprint: 'ABC12345',
    executedAtUtc: DateTime.utc(2026, 7, 31, 12),
    registryIdentifier: 'local.sum',
    registryVersion: 1,
    draft: const AnalyticsComposerDraft(
      selectedDeterminantKeys: {'product-1'},
      measures: {AnalyticsMeasure.lineTotal},
    ),
    selectedValues: const [AnalyticsOption(key: 'product-1', label: 'Product')],
    entries: [
      AnalyticsGroupedResultEntry(
        groupKey: AnalyticsGroupKey(
          value: 'product-1',
          determinantLabel: 'Product',
        ),
        measure: AnalyticsMeasure.lineTotal,
        operation: AnalyticsOperation.sum,
        compatibilityKey: const AnalyticsCompatibilityKey('money:BRL'),
        value: const AnalyticsIntegerResultValue(
          label: 'Price paid',
          value: 1200,
          compatibilityKey: AnalyticsCompatibilityKey('money:BRL'),
        ),
        eligibleCount: 1,
        totalCount: 1,
        excludedCount: 0,
        contributingRowIds: const {PurchaseItemId('item-1')},
      ),
    ],
    contributingRowIds: const {PurchaseItemId('item-1')},
    eligibleCount: 1,
    totalCount: 1,
    excludedCount: 0,
    interpretation: 'Sum Price paid grouped by Product.',
  );
}
