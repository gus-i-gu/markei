import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/analytics/analytics_models.dart';
import 'package:markei/domain/analytics/analytics_registry.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';

void main() {
  test('local analytics registry exposes versioned operation definitions', () {
    final registry = localAnalyticsRegistry();

    expect(registry.requireDefinition('local.sum', 1).version, 1);
    expect(registry.requireDefinition('local.mean', 1).version, 1);
    expect(registry.requireDefinition('local.difference', 1).version, 1);
    expect(registry.requireDefinition('local.percentage', 1).version, 1);
  });

  test('operation compatibility matches PH02 contract', () {
    final registry = localAnalyticsRegistry();

    expect(
      registry.supports(AnalyticsOperation.sum, AnalyticsVariable.unitPrice),
      isFalse,
    );
    expect(
      registry.supports(
        AnalyticsOperation.mean,
        AnalyticsVariable.evidenceCount,
      ),
      isFalse,
    );
    expect(
      registry.supports(
        AnalyticsOperation.percentage,
        AnalyticsVariable.unitPrice,
      ),
      isFalse,
    );
    expect(
      registry.supports(
        AnalyticsOperation.difference,
        AnalyticsVariable.unitPrice,
      ),
      isTrue,
    );
  });

  test('difference is comparison B minus baseline A', () {
    final registry = localAnalyticsRegistry();
    final rows = [_row('a', 100), _row('b', 175)];
    final result = executeAnalyticsCard(
      registry: registry,
      configuration: AnalyticsCardConfiguration(
        id: const AnalyticsCardId(1),
        revision: const AnalyticsCardRevision(1),
        determinant: AnalyticsDeterminantKind.purchase,
        variables: {AnalyticsVariable.lineTotal},
        operation: AnalyticsOperation.difference,
        scope: ComparisonAnalyticsEvidenceScope(
          baselineLabel: 'A',
          baselineRowIds: {rows[0].id},
          comparisonLabel: 'B',
          comparisonRowIds: {rows[1].id},
        ),
      ),
      dataset: AnalyticsDataset(
        accountId: const AccountId('account-1'),
        rows: rows,
      ),
    );

    final value = result.values.single as AnalyticsIntegerResultValue;
    expect(value.value, 75);
  });

  test('percentage is part of named whole and blocks zero denominator', () {
    final registry = localAnalyticsRegistry();
    final rows = [_row('a', 0)];
    final result = executeAnalyticsCard(
      registry: registry,
      configuration: AnalyticsCardConfiguration(
        id: const AnalyticsCardId(1),
        revision: const AnalyticsCardRevision(1),
        determinant: AnalyticsDeterminantKind.purchase,
        variables: {AnalyticsVariable.lineTotal},
        operation: AnalyticsOperation.percentage,
        scope: PercentageAnalyticsEvidenceScope(
          partLabel: 'part',
          partRowIds: {rows[0].id},
          wholeLabel: 'whole',
          wholeRowIds: {rows[0].id},
        ),
      ),
      dataset: AnalyticsDataset(
        accountId: const AccountId('account-1'),
        rows: rows,
      ),
    );

    expect(result.values.single, isA<AnalyticsUnavailableResultValue>());
  });

  test('overflow returns typed unavailable result without wrapping', () {
    final registry = localAnalyticsRegistry();
    final rows = [_row('a', 9223372036854775807), _row('b', 1)];
    final result = executeAnalyticsCard(
      registry: registry,
      configuration: const AnalyticsCardConfiguration(
        id: AnalyticsCardId(1),
        revision: AnalyticsCardRevision(1),
        determinant: AnalyticsDeterminantKind.product,
        variables: {AnalyticsVariable.lineTotal},
        operation: AnalyticsOperation.sum,
      ),
      dataset: AnalyticsDataset(
        accountId: const AccountId('account-1'),
        rows: rows,
      ),
    );

    final value = result.values.single as AnalyticsUnavailableResultValue;
    expect(value.reason, AnalyticsUnavailableReason.overflow);
  });
}

AnalyticsEvidenceRow _row(String id, int minorUnits) {
  return AnalyticsEvidenceRow(
    id: PurchaseItemId('item-$id'),
    accountId: const AccountId('account-1'),
    purchaseId: PurchaseId('purchase-$id'),
    purchaseOccurrenceTime: DateTime.utc(2026, 7, 31),
    purchaseTotal: AnalyticsMoneyAmount(
      currencyCode: 'BRL',
      minorUnits: minorUnits,
    ),
    productId: ProductId('product-$id'),
    productCode: 'P-$id',
    productName: 'Product $id',
    productBrand: 'Brand',
    storeId: StoreId('store-$id'),
    storeName: 'Store',
    purchasedBy: null,
    paymentMethod: null,
    quantity: const NormalizedQuantity(
      kind: MeasurementKind.mass,
      unit: CanonicalUnit.kg,
      microunits: NormalizedQuantity.factor,
    ),
    lineTotal: AnalyticsMoneyAmount(
      currencyCode: 'BRL',
      minorUnits: minorUnits,
    ),
    unitPrice: AnalyticsUnitPrice(
      currencyCode: 'BRL',
      minorUnitsPerCanonicalUnit: minorUnits,
      kind: MeasurementKind.mass,
      unit: CanonicalUnit.kg,
    ),
  );
}
