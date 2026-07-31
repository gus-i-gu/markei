import 'package:drift/drift.dart';

import '../../application/analytics.dart';
import '../../domain/analytics/analytics_models.dart';
import '../../domain/shared/ids.dart';
import '../../domain/shared/quantity.dart';
import 'local_database.dart';

final class LocalAnalyticsRepository implements AnalyticsEvidenceRepository {
  LocalAnalyticsRepository(this._db);

  final LocalDatabase _db;
  int requestCount = 0;

  @override
  Future<AnalyticsDataset> loadEvidence(AccountId accountId) async {
    requestCount++;
    final query =
        _db.select(_db.purchaseItems).join([
            innerJoin(
              _db.purchases,
              _db.purchases.id.equalsExp(_db.purchaseItems.purchaseId),
            ),
            innerJoin(
              _db.products,
              _db.products.id.equalsExp(_db.purchaseItems.productId),
            ),
            innerJoin(
              _db.stores,
              _db.stores.id.equalsExp(_db.purchases.storeId),
            ),
            leftOuterJoin(
              _db.people,
              _db.people.id.equalsExp(_db.purchases.personId),
            ),
            leftOuterJoin(
              _db.paymentMethods,
              _db.paymentMethods.id.equalsExp(_db.purchases.paymentMethodId),
            ),
          ])
          ..where(_db.purchases.accountId.equals(accountId.value))
          ..orderBy([
            OrderingTerm.asc(_db.purchases.occurrenceTime),
            OrderingTerm.asc(_db.purchases.id),
            OrderingTerm.asc(_db.purchaseItems.id),
          ]);
    final rows = await query.get();
    return AnalyticsDataset(
      accountId: accountId,
      rows: rows
          .map((row) {
            final item = row.readTable(_db.purchaseItems);
            final purchase = row.readTable(_db.purchases);
            final product = row.readTable(_db.products);
            final store = row.readTable(_db.stores);
            final person = row.readTableOrNull(_db.people);
            final payment = row.readTableOrNull(_db.paymentMethods);
            final quantity = NormalizedQuantity(
              kind: _measurementKind(item.measurementKind),
              unit: _canonicalUnit(item.purchasedUnit),
              microunits: _parseMicrounits(item.purchasedAmount),
            );
            return AnalyticsEvidenceRow(
              id: PurchaseItemId(item.id),
              accountId: AccountId(purchase.accountId),
              purchaseId: PurchaseId(purchase.id),
              purchaseOccurrenceTime: purchase.occurrenceTime.toUtc(),
              purchaseTotal: AnalyticsMoneyAmount(
                currencyCode: purchase.currencyCode,
                minorUnits: purchase.totalMinorUnits,
              ),
              productId: ProductId(product.id),
              productCode: product.userProductCode,
              productName: product.displayName ?? product.normalizedName,
              productBrand: product.displayBrand ?? '',
              storeId: StoreId(store.id),
              storeName: store.displayName,
              purchasedBy: _reference(
                id: person?.id,
                visibleCode: person?.visibleCode,
                nickname: person?.nickname,
                active: person?.active,
              ),
              paymentMethod: _reference(
                id: payment?.id,
                visibleCode: payment?.visibleCode,
                nickname: payment?.nickname,
                active: payment?.active,
              ),
              quantity: quantity,
              lineTotal: AnalyticsMoneyAmount(
                currencyCode: item.currencyCode,
                minorUnits: item.lineTotalMinorUnits,
              ),
              unitPrice: quantity.microunits <= 0
                  ? null
                  : AnalyticsUnitPrice(
                      currencyCode: item.currencyCode,
                      minorUnitsPerCanonicalUnit:
                          (item.lineTotalMinorUnits *
                              NormalizedQuantity.factor) ~/
                          quantity.microunits,
                      kind: quantity.kind,
                      unit: quantity.unit,
                    ),
            );
          })
          .toList(growable: false),
    );
  }
}

MeasurementKind _measurementKind(String value) {
  return MeasurementKind.values.firstWhere(
    (kind) => kind.name.toUpperCase() == value.toUpperCase(),
  );
}

CanonicalUnit _canonicalUnit(String value) {
  return CanonicalUnit.values.firstWhere(
    (unit) => unit.name.toUpperCase() == value.toUpperCase(),
  );
}

int _parseMicrounits(String value) => parseDisplayDecimalMicrounits(value);

AnalyticsReference? _reference({
  required String? id,
  required String? visibleCode,
  required String? nickname,
  required bool? active,
}) {
  if (id == null || visibleCode == null || nickname == null) return null;
  return AnalyticsReference(
    id: id,
    code: visibleCode,
    label: nickname,
    archived: active == false,
  );
}
