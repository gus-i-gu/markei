import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/analytics.dart';
import 'package:markei/application/analytics_workspace.dart';
import 'package:markei/domain/analytics/analytics_models.dart';
import 'package:markei/domain/analytics/analytics_registry.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';

void main() {
  test(
    'date ranges derive temporal groups within comparison filters',
    () async {
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account'),
        repository: _Repository([
          row('1', 'Nescau', 'Condor', 1, 1000),
          row('2', 'Nescau', 'Condor', 2, 1400),
          row('3', 'Nescau', 'Condor', 3, 1800),
          row('4', 'Coffee', 'Other', 4, 2000),
        ]),
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      controller.setDeterminant(AnalyticsDeterminantKind.timeMonthUtc);
      controller.setAxis(
        0,
        const AnalyticsAxis(
          kind: AnalyticsDeterminantKind.product,
          selectedKeys: {'Nescau'},
        ),
      );
      expect(controller.snapshot.draft.selectedDeterminantKeys, {
        '2026-01',
        '2026-02',
        '2026-03',
      });
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      controller.setOperation(AnalyticsOperation.difference);
      controller.setTimeframe(
        AnalyticsTimeframe.custom(
          startUtc: DateTime(2026, 1, 1).toUtc(),
          endUtc: DateTime(2026, 3, 1).toUtc(),
          initialLocalDate: '01-01-2026',
          finalLocalDate: '28-02-2026',
        ),
      );
      expect(controller.snapshot.draft.selectedDeterminantKeys, {
        '2026-01',
        '2026-02',
      });
      expect(controller.snapshot.validation.canRun, isTrue);
      controller.runAndSave();
      final record = controller.snapshot.records.single;
      expect(
        (record.entries.single.value as AnalyticsIntegerResultValue).value,
        400,
      );
      controller.setTimeframe(
        AnalyticsTimeframe.custom(
          startUtc: DateTime(2026, 2, 1).toUtc(),
          endUtc: DateTime(2026, 3, 1).toUtc(),
        ),
      );
      expect(controller.snapshot.draft.selectedDeterminantKeys, {'2026-02'});
      expect(controller.snapshot.validation.canRun, isFalse);
      expect(
        controller.snapshot.validation.explanation,
        contains('exactly two'),
      );
      expect(record.draft.selectedDeterminantKeys, {'2026-01', '2026-02'});

      controller.setOperation(AnalyticsOperation.sum);
      controller.setTimeframe(const AnalyticsTimeframe.all());
      controller.selectRows({const PurchaseItemId('3')});
      controller.useSelectedRows();
      expect(controller.snapshot.draft.selectedDeterminantKeys, {'2026-03'});
      expect(controller.snapshot.validation.canRun, isTrue);
      controller.setTimeframe(
        AnalyticsTimeframe.custom(
          startUtc: DateTime(2027, 1, 1).toUtc(),
          endUtc: DateTime(2027, 2, 1).toUtc(),
        ),
      );
      expect(controller.snapshot.validation.canRun, isFalse);
      expect(
        controller.snapshot.validation.explanation,
        contains('No recorded purchases'),
      );
    },
  );

  test(
    'range normalization preserves explicit draft measures and breakdowns',
    () async {
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account'),
        repository: _Repository([row('1', 'Nescau', 'Condor', 1, 1000)]),
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      for (final kind in [
        AnalyticsDeterminantKind.product,
        AnalyticsDeterminantKind.timeMonthUtc,
      ]) {
        controller.updateDraft(
          AnalyticsComposerDraft(
            determinant: kind,
            selectedDeterminantKeys: const {'Nescau'},
            measures: const {AnalyticsMeasure.lineTotal},
            breakdowns: const {AnalyticsRelationalBreakdown.paymentMethod},
          ),
        );
        expect(controller.snapshot.draft.measures, {
          AnalyticsMeasure.lineTotal,
        });
        expect(controller.snapshot.draft.breakdowns, {
          AnalyticsRelationalBreakdown.paymentMethod,
        });
        expect(controller.snapshot.validation.canRun, isTrue);
      }
    },
  );

  test(
    'monthly product/store mean produces comparison contexts, frozen records and exports',
    () async {
      final repository = _Repository([
        row('1', 'Nescau', 'Condor', 1, 1000),
        row('2', 'Nescau', 'Condor', 1, 1400),
        row('3', 'Nescau', 'Condor', 2, 1800),
        row('4', 'Coffee', 'Condor', 1, 2000),
        row('5', 'Nescau', 'Other', 1, 900),
      ]);
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account'),
        repository: repository,
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      controller.setDeterminant(AnalyticsDeterminantKind.timeMonthUtc);
      controller.selectAllDeterminants();
      final selected = {'Nescau'};
      controller.setAxis(
        0,
        AnalyticsAxis(
          kind: AnalyticsDeterminantKind.product,
          selectedKeys: selected,
        ),
      );
      controller.setAxis(
        1,
        const AnalyticsAxis(
          kind: AnalyticsDeterminantKind.store,
          selectedKeys: {'Condor'},
        ),
      );
      controller.toggleVariable(AnalyticsVariable.unitPrice);
      controller.setOperation(AnalyticsOperation.mean);
      expect(controller.snapshot.validation.canRun, isTrue);
      controller.runAndSave();
      final record = controller.snapshot.records.single;
      expect(record.entries, hasLength(2));
      expect(
        record.entries.map(
          (e) => (e.value as AnalyticsIntegerResultValue).value,
        ),
        [1200, 1800],
      );
      expect(
        record.entries.every(
          (e) =>
              e.groupKey.contextLabel.contains('Nescau') &&
              e.groupKey.contextLabel.contains('Condor'),
        ),
        isTrue,
      );
      expect(record.contributingRowIds.map((id) => id.value).toSet(), {
        '1',
        '2',
        '3',
      });
      selected.add('Coffee');
      controller.setAxis(
        0,
        const AnalyticsAxis(
          kind: AnalyticsDeterminantKind.product,
          selectedKeys: {'Coffee'},
        ),
      );
      expect(record.draft.analytics01.selectedKeys, {'Nescau'});
      final csv = analyticsRecordCsv(
        record,
        await repository.loadEvidence(const AccountId('account')),
      );
      expect(csv, contains('analytics_01,product'));
      expect(csv, contains('12.00'));
      expect(csv, isNot(contains('Coffee')));
      final pdf = ascii.decode(analyticsRecordPdfBytes(record));
      expect(pdf, startsWith('%PDF-1.4'));
      expect(pdf, contains('Comparison chart'));
      expect(pdf, contains('/Count 2'));
      expect(
        pdf,
        contains(r'Caf\351'),
      ); // Latin labels remain renderable in the PDF.
      expect(
        repository.calls,
        2,
      ); // One controller read plus the explicit export fixture read.
    },
  );

  test(
    'multiple comparison selections yield distinct series and difference pairs within each series',
    () async {
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account'),
        repository: _Repository([
          row('1', 'Nescau', 'Condor', 1, 1000),
          row('2', 'Nescau', 'Condor', 2, 1400),
          row('3', 'Coffee', 'Condor', 1, 2000),
          row('4', 'Coffee', 'Condor', 2, 2600),
        ]),
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      controller.setDeterminant(AnalyticsDeterminantKind.timeMonthUtc);
      controller.selectAllDeterminants();
      controller.setAxis(
        0,
        const AnalyticsAxis(kind: AnalyticsDeterminantKind.product),
      );
      controller.setAxis(
        1,
        const AnalyticsAxis(kind: AnalyticsDeterminantKind.store),
      );
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      controller.runAndSave();
      expect(controller.snapshot.records.single.entries, hasLength(4));
      controller.setOperation(AnalyticsOperation.difference);
      controller.runAndSave();
      expect(
        controller.snapshot.records.first.entries
            .map((e) => (e.value as AnalyticsIntegerResultValue).value)
            .toSet(),
        {400, 600},
      );
      controller.setAxis(
        1,
        const AnalyticsAxis(kind: AnalyticsDeterminantKind.product),
      );
      expect(controller.snapshot.validation.canRun, isFalse);
    },
  );
}

class _Repository implements AnalyticsEvidenceRepository {
  _Repository(this.rows);
  final List<AnalyticsEvidenceRow> rows;
  int calls = 0;
  @override
  Future<AnalyticsDataset> loadEvidence(AccountId accountId) async {
    calls++;
    return AnalyticsDataset(accountId: accountId, rows: rows);
  }
}

AnalyticsEvidenceRow row(
  String id,
  String product,
  String store,
  int month,
  int price,
) => AnalyticsEvidenceRow(
  id: PurchaseItemId(id),
  accountId: const AccountId('account'),
  purchaseId: PurchaseId('purchase-$id'),
  purchaseOccurrenceTime: DateTime.utc(2026, month, 10),
  purchaseTotal: AnalyticsMoneyAmount(currencyCode: 'BRL', minorUnits: price),
  productId: ProductId(product),
  productCode: 'CODE-$product',
  productName: product,
  productBrand: 'Café',
  storeId: StoreId(store),
  storeName: store,
  purchasedBy: null,
  paymentMethod: null,
  quantity: const NormalizedQuantity(
    kind: MeasurementKind.mass,
    unit: CanonicalUnit.kg,
    microunits: 1000000,
  ),
  lineTotal: AnalyticsMoneyAmount(currencyCode: 'BRL', minorUnits: price),
  unitPrice: AnalyticsUnitPrice(
    currencyCode: 'BRL',
    minorUnitsPerCanonicalUnit: price,
    kind: MeasurementKind.mass,
    unit: CanonicalUnit.kg,
  ),
);
