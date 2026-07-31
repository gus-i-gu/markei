import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/analytics.dart';
import 'package:markei/application/analytics_workspace.dart';
import 'package:markei/domain/analytics/analytics_models.dart';
import 'package:markei/domain/analytics/analytics_registry.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';

void main() {
  test(
    'workspace loads once and keeps local transitions request-free',
    () async {
      final repository = _CountingRepository(_rows(5));
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: repository,
        registry: localAnalyticsRegistry(),
        clock: () => DateTime.utc(2026, 7, 31, 12),
      );

      await controller.load();
      controller.toggleDeterminantKey('product-0');
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      controller.runAndSave();
      controller.setPresentation(AnalyticsResultPresentation.table);
      controller.setVariablesSearch('product');
      controller.setVariablesSort(AnalyticsVariablesSort.labelAscending);
      controller.toggleItemSelection(const PurchaseItemId('item-1'));
      controller.useSelectedRows();
      controller.showAllVariables();
      controller.resetEvidence();

      expect(repository.requestCount, 1);
      expect(controller.snapshot.repositoryRequestCount, 1);
      expect(controller.snapshot.records, hasLength(1));
      expect(
        controller.snapshot.records.single.entries.single.groupKey.value,
        contains('product-0'),
      );
    },
  );

  test(
    'retry performs one extra local read and preserves immutable record',
    () async {
      final repository = _CountingRepository(_rows(2));
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: repository,
        registry: localAnalyticsRegistry(),
        clock: () => DateTime.utc(2026, 7, 31, 12),
      );

      await controller.load();
      controller.toggleDeterminantKey('product-0');
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      controller.runAndSave();
      final fingerprint = controller.snapshot.records.single.fingerprint;
      await controller.retry();

      expect(repository.requestCount, 2);
      expect(controller.snapshot.records.single.fingerprint, fingerprint);
    },
  );

  test('composer validation reports disabled explanations', () async {
    final controller = AnalyticsWorkspaceController(
      accountId: const AccountId('account-1'),
      repository: _CountingRepository(_rows(1)),
      registry: localAnalyticsRegistry(),
    );
    await controller.load();

    expect(
      controller.snapshot.validation.explanation,
      contains('Choose at least one Product'),
    );
    controller.toggleDeterminantKey('product-0');
    expect(
      controller.snapshot.validation.explanation,
      contains('Choose at least one numeric variable'),
    );
    controller.toggleVariable(AnalyticsVariable.purchasedFor);
    expect(
      controller.snapshot.validation.explanation,
      'Purchased for is unavailable in recorded data.',
    );
  });

  test('duplicate display labels keep stable determinant identities', () async {
    final rows = [
      _row('0', productId: 'product-a', productName: 'Same'),
      _row('1', productId: 'product-b', productName: 'Same'),
    ];
    final controller = AnalyticsWorkspaceController(
      accountId: const AccountId('account-1'),
      repository: _CountingRepository(rows),
      registry: localAnalyticsRegistry(),
    );
    await controller.load();

    final productOptions =
        controller.snapshot.options[AnalyticsDeterminantKind.product]!;
    expect(
      productOptions.map((option) => option.key),
      containsAll(['product-a', 'product-b']),
    );
  });

  test(
    'breakdowns subdivide groups without numeric identifier arithmetic',
    () async {
      final rows = [
        _row(
          '0',
          person: const AnalyticsReference(
            id: 'person-1',
            code: '@001',
            label: 'Alex',
          ),
        ),
        _row(
          '1',
          person: const AnalyticsReference(
            id: 'person-2',
            code: '@002',
            label: 'Alex',
          ),
        ),
      ];
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: _CountingRepository(rows),
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      controller.toggleDeterminantKey('product-0');
      controller.toggleDeterminantKey('product-1');
      controller.toggleVariable(AnalyticsVariable.purchasedBy);
      controller.toggleVariable(AnalyticsVariable.evidenceCount);
      controller.runAndSave();

      final labels = controller.snapshot.selectedRecord!.entries
          .map((entry) => entry.groupKey.breakdownLabels.values.single)
          .toSet();
      expect(labels, containsAll(['@001 Alex', '@002 Alex']));
    },
  );

  test(
    'difference and percentage validate exactly two groups and meanings',
    () async {
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: _CountingRepository(_rows(2)),
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      controller.setOperation(AnalyticsOperation.difference);
      controller.toggleDeterminantKey('product-0');
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      expect(
        controller.snapshot.validation.explanation,
        contains('Difference needs exactly two'),
      );
      controller.toggleDeterminantKey('product-1');
      controller.runAndSave();
      expect(
        (controller.snapshot.selectedRecord!.entries.single.value
                as AnalyticsIntegerResultValue)
            .label,
        contains('minus'),
      );

      controller.setOperation(AnalyticsOperation.percentage);
      controller.runAndSave();
      expect(
        (controller.snapshot.selectedRecord!.entries.single.value
                as AnalyticsBasisPointResultValue)
            .label,
        contains('share of'),
      );
    },
  );

  test(
    'fingerprints are stable enough for records and collections are defensive',
    () async {
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: _CountingRepository(_rows(1)),
        registry: localAnalyticsRegistry(),
        clock: () => DateTime.utc(2026, 7, 31, 12),
      );
      await controller.load();
      controller.toggleDeterminantKey('product-0');
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      controller.runAndSave();

      final record = controller.snapshot.records.single;
      expect(record.fingerprint, matches(RegExp(r'^[0-9A-F]{8,}')));
      expect(
        () => controller.snapshot.records.add(record),
        throwsUnsupportedError,
      );
      expect(() => record.entries.clear(), throwsUnsupportedError);
    },
  );

  test(
    'purchase projection, item selection, search sort and paging are deterministic',
    () async {
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: _CountingRepository(_rows(25, purchaseCount: 5)),
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      controller.setVariablesProjection(AnalyticsVariablesProjection.purchases);
      expect(controller.snapshot.variables.purchaseRows, hasLength(5));
      controller.togglePurchaseSelection(const PurchaseId('purchase-0'));
      expect(controller.snapshot.selectedRowIds, hasLength(5));
      controller.setVariablesProjection(
        AnalyticsVariablesProjection.containedItems,
      );
      controller.setVariablesSearch('Product 1');
      expect(
        controller.snapshot.variables.itemRows.every(
          (row) => row.productName.contains('1'),
        ),
        isTrue,
      );
    },
  );

  test('CSV and PDF builders include metadata results and evidence', () async {
    final dataset = AnalyticsDataset(
      accountId: const AccountId('account-1'),
      rows: _rows(1),
    );
    final controller = AnalyticsWorkspaceController(
      accountId: const AccountId('account-1'),
      repository: _CountingRepository(dataset.rows),
      registry: localAnalyticsRegistry(),
      clock: () => DateTime.utc(2026, 7, 31, 12),
    );
    await controller.load();
    controller.toggleDeterminantKey('product-0');
    controller.toggleVariable(AnalyticsVariable.lineTotal);
    controller.runAndSave();
    final record = controller.snapshot.selectedRecord!;

    final csv = analyticsRecordCsv(record, dataset);
    final pdf = analyticsRecordPdfBytes(record);

    expect(csv, contains('record_fingerprint'));
    expect(csv, contains(record.fingerprint));
    expect(csv, contains('date_time_of_purchase'));
    expect(String.fromCharCodes(pdf.take(8)), '%PDF-1.4');
  });

  test(
    'D44 result matrix preserves selected variables and display scale',
    () async {
      final dataset = AnalyticsDataset(
        accountId: const AccountId('account-1'),
        rows: [
          _row('0', productId: 'product-a', productName: 'Rice'),
          _row('1', productId: 'product-a', productName: 'Rice'),
          _row('2', productId: 'product-b', productName: 'Beans'),
        ],
      );
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: _CountingRepository(dataset.rows),
        registry: localAnalyticsRegistry(),
      );
      await controller.load();

      controller.toggleDeterminantKey('product-a');
      controller.toggleDeterminantKey('product-b');
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      controller.toggleVariable(AnalyticsVariable.quantity);
      controller.setOperation(AnalyticsOperation.mean);
      controller.runAndSave();
      final productRecord = controller.snapshot.selectedRecord!;
      expect(productRecord.draft.variables, {
        AnalyticsVariable.lineTotal,
        AnalyticsVariable.quantity,
      });
      expect(productRecord.entries.map((entry) => entry.measure).toSet(), {
        AnalyticsMeasure.lineTotal,
        AnalyticsMeasure.quantity,
      });
      expect(
        productRecord.entries.map(
          (entry) => analyticsDisplayValue(entry.measure, entry.value).unit,
        ),
        containsAll(['BRL', 'kg']),
      );

      controller.clearDraft();
      controller.setDeterminant(AnalyticsDeterminantKind.store);
      controller.toggleDeterminantKey('store-0');
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      controller.setOperation(AnalyticsOperation.sum);
      controller.runAndSave();
      expect(
        controller.snapshot.selectedRecord!.entries.single.measure,
        AnalyticsMeasure.lineTotal,
      );

      controller.clearDraft();
      controller.setDeterminant(AnalyticsDeterminantKind.timeMonthUtc);
      controller.toggleDeterminantKey('2026-07');
      controller.toggleVariable(AnalyticsVariable.quantity);
      controller.runAndSave();
      expect(
        controller.snapshot.selectedRecord!.entries.single.measure,
        AnalyticsMeasure.quantity,
      );

      controller.clearDraft();
      controller.setDeterminant(AnalyticsDeterminantKind.product);
      controller.toggleDeterminantKey('product-a');
      controller.toggleVariable(AnalyticsVariable.paymentMethod);
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      controller.runAndSave();
      expect(
        controller
            .snapshot
            .selectedRecord!
            .entries
            .first
            .groupKey
            .breakdownLabels,
        contains(AnalyticsRelationalBreakdown.paymentMethod),
      );
    },
  );

  test('Purchase total is counted once per Purchase', () async {
    final controller = AnalyticsWorkspaceController(
      accountId: const AccountId('account-1'),
      repository: _CountingRepository(_rows(5, purchaseCount: 1)),
      registry: localAnalyticsRegistry(),
    );
    await controller.load();
    controller.setDeterminant(AnalyticsDeterminantKind.purchase);
    controller.toggleDeterminantKey('purchase-0');
    controller.toggleVariable(AnalyticsVariable.purchaseTotal);
    controller.setOperation(AnalyticsOperation.sum);
    controller.runAndSave();
    expect(
      (controller.snapshot.selectedRecord!.entries.single.value
              as AnalyticsIntegerResultValue)
          .value,
      100,
    );
    controller.setOperation(AnalyticsOperation.mean);
    controller.runAndSave();
    expect(
      (controller.snapshot.selectedRecord!.entries.single.value
              as AnalyticsIntegerResultValue)
          .value,
      100,
    );
  });

  test('custom one-day range is inclusive and invalid ranges block', () async {
    final controller = AnalyticsWorkspaceController(
      accountId: const AccountId('account-1'),
      repository: _CountingRepository([_row('0')..purchaseOccurrenceTime]),
      registry: localAnalyticsRegistry(),
    );
    await controller.load();
    controller.toggleDeterminantKey('product-0');
    controller.toggleVariable(AnalyticsVariable.lineTotal);
    final localStart = DateTime(2026, 7, 31);
    final localEndExclusive = DateTime(2026, 8, 1);
    controller.setTimeframe(
      AnalyticsTimeframe.custom(
        startUtc: localStart.toUtc(),
        endUtc: localEndExclusive.toUtc(),
        initialLocalDate: '31-07-2026',
        finalLocalDate: '31-07-2026',
      ),
    );
    expect(controller.snapshot.validation.canRun, isTrue);
    controller.runAndSave();
    expect(controller.snapshot.selectedRecord!.eligibleCount, 1);

    controller.setTimeframe(
      const AnalyticsTimeframe.invalid('Initial date must use dd-mm-yyyy.'),
    );
    expect(controller.snapshot.validation.canRun, isFalse);
    expect(
      controller.snapshot.validation.explanation,
      contains('Initial date'),
    );
    controller.setTimeframe(
      const AnalyticsTimeframe.invalid(
        'Final date must be the same as or later than Initial date.',
      ),
    );
    expect(controller.snapshot.validation.explanation, contains('same as'));
  });

  test(
    'incompatible variables keep table evidence and block implicit count',
    () async {
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: _CountingRepository(_rows(1)),
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      controller.toggleDeterminantKey('product-0');
      controller.toggleVariable(AnalyticsVariable.purchasedBy);
      expect(controller.snapshot.validation.canRun, isFalse);
      expect(
        controller.snapshot.validation.explanation,
        contains('numeric variable'),
      );

      controller.toggleVariable(AnalyticsVariable.quantity);
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      controller.runAndSave();
      final record = controller.snapshot.selectedRecord!;
      expect(record.entries, hasLength(2));
      expect(
        controller.snapshot.presentation,
        AnalyticsResultPresentation.table,
      );
      expect(record.entries.map((entry) => entry.measure).toSet(), {
        AnalyticsMeasure.quantity,
        AnalyticsMeasure.lineTotal,
      });
    },
  );

  test(
    'History Purchase scope counts matched rows and only matched rows',
    () async {
      final repository = _CountingRepository(_rows(4, purchaseCount: 2));
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: repository,
        registry: localAnalyticsRegistry(),
        launchContext: const AnalyticsLaunchContext.purchaseSelection(
          AccountId('account-1'),
          {PurchaseId('purchase-0'), PurchaseId('stale-purchase')},
        ),
      );
      await controller.load();
      expect(
        controller.snapshot.historyContextMessage,
        contains('requested 2'),
      );
      expect(controller.snapshot.historyContextMessage, contains('matched 1'));
      controller.setDeterminant(AnalyticsDeterminantKind.purchase);
      controller.toggleDeterminantKey('purchase-0');
      controller.toggleVariable(AnalyticsVariable.evidenceCount);
      controller.runAndSave();
      expect(controller.snapshot.selectedRecord!.eligibleCount, 2);
      expect(repository.requestCount, 1);
    },
  );

  test(
    'saved records are immutable and selected records ignore live draft',
    () async {
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: _CountingRepository(_rows(2)),
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      controller.toggleDeterminantKey('product-0');
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      controller.runAndSave();
      final first = controller.snapshot.selectedRecord!;
      controller.toggleVariable(AnalyticsVariable.quantity);
      expect(first.draft.variables, {AnalyticsVariable.lineTotal});
      controller.toggleDeterminantKey('product-1');
      controller.runAndSave();
      controller.selectOlderRecord();
      expect(
        controller.snapshot.selectedRecord!.fingerprint,
        first.fingerprint,
      );
      expect(
        controller.snapshot.draft.variables,
        contains(AnalyticsVariable.quantity),
      );
    },
  );

  test(
    'CSV PDF and interpretation omit raw fixed-point keys and UUID evidence',
    () async {
      final dataset = AnalyticsDataset(
        accountId: const AccountId('account-1'),
        rows: _rows(1),
      );
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: _CountingRepository(dataset.rows),
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      controller.toggleDeterminantKey('product-0');
      controller.toggleVariable(AnalyticsVariable.quantity);
      controller.runAndSave();
      final record = controller.snapshot.selectedRecord!;
      final csv = analyticsRecordCsv(record, dataset);
      final pdfText = String.fromCharCodes(analyticsRecordPdfBytes(record));
      expect(csv, contains('1.000'));
      expect(csv, isNot(contains('1000000')));
      expect(csv, isNot(contains('quantity:mass:kg')));
      expect(csv, isNot(contains('purchase_id')));
      expect(csv, isNot(contains('product_id')));
      expect(csv, isNot(contains('store_id')));
      expect(pdfText, isNot(contains('quantity:mass:kg')));
      expect(record.interpretation, contains('Quantity'));
    },
  );

  test('ordinary fixture measures 1000 Purchases and 5000 Items', () async {
    final rows = _rows(5000, purchaseCount: 1000);
    final repository = _CountingRepository(rows);
    final controller = AnalyticsWorkspaceController(
      accountId: const AccountId('account-1'),
      repository: repository,
      registry: localAnalyticsRegistry(),
    );

    final loadWatch = Stopwatch()..start();
    await controller.load();
    loadWatch.stop();
    controller.toggleDeterminantKey('product-0');
    controller.toggleVariable(AnalyticsVariable.lineTotal);
    final calcWatch = Stopwatch()..start();
    controller.runAndSave();
    calcWatch.stop();
    final chartWatch = Stopwatch()..start();
    controller.setPresentation(AnalyticsResultPresentation.chart);
    chartWatch.stop();
    final tableWatch = Stopwatch()..start();
    controller.setPresentation(AnalyticsResultPresentation.table);
    tableWatch.stop();
    controller.showAllVariables();

    // ignore: avoid_print
    print(
      'ORDINARY_FIXTURE purchases=1000 items=5000 renderedPageSize=${controller.snapshot.variables.itemRows.length} loadMs=${loadWatch.elapsedMilliseconds} recordCreateGroupedCalcMs=${calcWatch.elapsedMilliseconds} chartBuildMs=${chartWatch.elapsedMilliseconds} tableBuildMs=${tableWatch.elapsedMilliseconds}',
    );
    expect(controller.snapshot.variables.itemRows, hasLength(20));
    expect(loadWatch.elapsedMilliseconds, lessThan(250));
    expect(calcWatch.elapsedMilliseconds, lessThan(250));
  });

  test('stress fixture measures 10000 Purchases and 50000 Items', () async {
    final rows = _rows(50000, purchaseCount: 10000);
    final repository = _CountingRepository(rows);
    final controller = AnalyticsWorkspaceController(
      accountId: const AccountId('account-1'),
      repository: repository,
      registry: localAnalyticsRegistry(),
    );

    final loadWatch = Stopwatch()..start();
    await controller.load();
    loadWatch.stop();
    final selected = {
      for (var i = 0; i < AnalyticsWorkspaceController.selectedScopeCap; i++)
        PurchaseItemId('item-$i'),
    };
    controller.selectRows(selected);
    controller.useSelectedRows();
    controller.toggleDeterminantKey('product-0');
    controller.toggleVariable(AnalyticsVariable.lineTotal);
    final calcWatch = Stopwatch()..start();
    controller.runAndSave();
    calcWatch.stop();
    controller.showAllVariables();

    // ignore: avoid_print
    print(
      'STRESS_FIXTURE purchases=10000 items=50000 renderedPageSize=${controller.snapshot.variables.itemRows.length} selectedScopeSize=${selected.length} loadMs=${loadWatch.elapsedMilliseconds} recordCreateGroupedCalcMs=${calcWatch.elapsedMilliseconds}',
    );
    expect(controller.snapshot.variables.itemRows, hasLength(20));
    expect(controller.snapshot.selectedRowIds, hasLength(500));
    expect(calcWatch.elapsedMilliseconds, lessThan(2500));
  });
}

final class _CountingRepository implements AnalyticsEvidenceRepository {
  _CountingRepository(this.rows);

  final List<AnalyticsEvidenceRow> rows;
  int requestCount = 0;

  @override
  Future<AnalyticsDataset> loadEvidence(AccountId accountId) async {
    requestCount++;
    return AnalyticsDataset(accountId: accountId, rows: rows);
  }
}

List<AnalyticsEvidenceRow> _rows(int count, {int? purchaseCount}) {
  return [
    for (var i = 0; i < count; i++)
      _row(
        '$i',
        purchaseId: 'purchase-${purchaseCount == null ? i : i % purchaseCount}',
      ),
  ];
}

AnalyticsEvidenceRow _row(
  String id, {
  String? productId,
  String? productName,
  String? purchaseId,
  AnalyticsReference? person,
  AnalyticsReference? payment,
}) {
  return AnalyticsEvidenceRow(
    id: PurchaseItemId('item-$id'),
    accountId: const AccountId('account-1'),
    purchaseId: PurchaseId(purchaseId ?? 'purchase-$id'),
    purchaseOccurrenceTime: DateTime.utc(2026, 7, 31, 12, int.parse(id) % 60),
    purchaseTotal: const AnalyticsMoneyAmount(
      currencyCode: 'BRL',
      minorUnits: 100,
    ),
    productId: ProductId(productId ?? 'product-$id'),
    productCode: 'P-$id',
    productName: productName ?? 'Product $id',
    productBrand: '',
    storeId: StoreId('store-${int.parse(id) % 3}'),
    storeName: 'Store',
    purchasedBy: person,
    paymentMethod: payment,
    quantity: const NormalizedQuantity(
      kind: MeasurementKind.mass,
      unit: CanonicalUnit.kg,
      microunits: NormalizedQuantity.factor,
    ),
    lineTotal: const AnalyticsMoneyAmount(currencyCode: 'BRL', minorUnits: 100),
    unitPrice: const AnalyticsUnitPrice(
      currencyCode: 'BRL',
      minorUnitsPerCanonicalUnit: 100,
      kind: MeasurementKind.mass,
      unit: CanonicalUnit.kg,
    ),
  );
}
