import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/analytics.dart';
import 'package:markei/application/analytics_workspace.dart';
import 'package:markei/domain/analytics/analytics_models.dart';
import 'package:markei/domain/analytics/analytics_registry.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';

void main() {
  test(
    'workspace loads once and does not reread for local transitions',
    () async {
      final repository = _CountingRepository(_rows(5));
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: repository,
        registry: localAnalyticsRegistry(),
      );

      await controller.load();
      controller.selectRows({PurchaseItemId('item-1')});
      controller.addCard(
        determinant: AnalyticsDeterminantKind.product,
        variables: {AnalyticsVariable.lineTotal},
        operation: AnalyticsOperation.sum,
      );
      controller.focusSupportingEvidence(const AnalyticsCardId(1));
      controller.showAllEvidence();
      controller.resetEvidence();
      controller.moveCardEarlier(const AnalyticsCardId(1));

      expect(repository.requestCount, 1);
      expect(controller.snapshot.repositoryRequestCount, 1);
    },
  );

  test(
    'workspace retry performs one extra local read and preserves card',
    () async {
      final repository = _CountingRepository(_rows(1));
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: repository,
        registry: localAnalyticsRegistry(),
      );

      await controller.load();
      controller.addCard(
        determinant: AnalyticsDeterminantKind.product,
        variables: {AnalyticsVariable.lineTotal},
        operation: AnalyticsOperation.sum,
      );
      await controller.retry();

      expect(repository.requestCount, 2);
      expect(controller.snapshot.cards, hasLength(1));
    },
  );

  test('workspace caps selected scope at 500 row IDs', () async {
    final repository = _CountingRepository(_rows(501));
    final controller = AnalyticsWorkspaceController(
      accountId: const AccountId('account-1'),
      repository: repository,
      registry: localAnalyticsRegistry(),
    );
    await controller.load();

    controller.selectRows({
      for (var i = 0; i < 501; i++) PurchaseItemId('item-$i'),
    });

    expect(controller.snapshot.selectedRowIds, isEmpty);
    expect(controller.snapshot.message, contains('Select up to 500'));
  });

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
    final calcWatch = Stopwatch()..start();
    controller.addCard(
      determinant: AnalyticsDeterminantKind.product,
      variables: {AnalyticsVariable.lineTotal},
      operation: AnalyticsOperation.sum,
    );
    calcWatch.stop();

    // ignore: avoid_print
    print(
      'ORDINARY_FIXTURE purchases=1000 items=5000 renderedPageSize=${controller.snapshot.visibleRows.length} selectedScopeSize=0 loadMs=${loadWatch.elapsedMilliseconds} calcMs=${calcWatch.elapsedMilliseconds}',
    );
    expect(controller.snapshot.visibleRows, hasLength(100));
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
    final calcWatch = Stopwatch()..start();
    controller.addCard(
      determinant: AnalyticsDeterminantKind.product,
      variables: {AnalyticsVariable.lineTotal},
      operation: AnalyticsOperation.sum,
    );
    calcWatch.stop();

    // ignore: avoid_print
    print(
      'STRESS_FIXTURE purchases=10000 items=50000 renderedPageSize=${controller.snapshot.visibleRows.length} selectedScopeSize=${selected.length} loadMs=${loadWatch.elapsedMilliseconds} calcMs=${calcWatch.elapsedMilliseconds}',
    );
    expect(controller.snapshot.visibleRows, hasLength(100));
    expect(controller.snapshot.selectedRowIds, hasLength(500));
    expect(calcWatch.elapsedMilliseconds, lessThan(1000));
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
      AnalyticsEvidenceRow(
        id: PurchaseItemId('item-$i'),
        accountId: const AccountId('account-1'),
        purchaseId: PurchaseId(
          'purchase-${purchaseCount == null ? i : i % purchaseCount}',
        ),
        purchaseOccurrenceTime: DateTime.utc(2026, 7, 31),
        purchaseTotal: const AnalyticsMoneyAmount(
          currencyCode: 'BRL',
          minorUnits: 100,
        ),
        productId: ProductId('product-$i'),
        productCode: 'P-$i',
        productName: 'Product $i',
        productBrand: '',
        storeId: StoreId('store-$i'),
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
          minorUnits: 100,
        ),
        unitPrice: const AnalyticsUnitPrice(
          currencyCode: 'BRL',
          minorUnitsPerCanonicalUnit: 100,
          kind: MeasurementKind.mass,
          unit: CanonicalUnit.kg,
        ),
      ),
  ];
}
