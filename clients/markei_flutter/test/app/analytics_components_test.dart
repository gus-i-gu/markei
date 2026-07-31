import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/widgets/analytics_components.dart';
import 'package:markei/domain/analytics/analytics_models.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';

void main() {
  testWidgets(
    'Chart and Table consume one frozen record without mutation actions',
    (tester) async {
      final record = _record();
      var presentation = AnalyticsResultPresentation.chart;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnalyticsResultView(
              record: record,
              presentation: presentation,
              onPresentationChanged: (value) => presentation = value,
              onExportCsv: () {},
              onExportPdf: () {},
            ),
          ),
        ),
      );

      expect(find.byKey(const Key('analytics.chart.summary')), findsOneWidget);
      expect(find.textContaining('Record #ABC12345'), findsOneWidget);
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
    expect(find.textContaining('Store'), findsOneWidget);
    expect(find.textContaining('purchase-1'), findsNothing);
    expect(find.textContaining('BRL 12.00'), findsOneWidget);
  });

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
