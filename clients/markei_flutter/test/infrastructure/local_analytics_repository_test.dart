import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/register_purchase.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/infrastructure/local/local_analytics_repository.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';

void main() {
  test(
    'local analytics repository performs complete Account-scoped load',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final queries = LocalQueryRepository(db);
      final registration = LocalPurchaseRepository(db);
      const account = AccountId('account-1');
      const other = AccountId('account-2');
      final store = await queries.createStore(account, 'Mercado Central');
      final otherStore = await queries.createStore(other, 'Foreign Store');
      final product = await queries.createProduct(
        account,
        const ProductDraft(
          userCode: 'ARROZ-001',
          name: 'Arroz',
          brand: 'Marca A',
          mode: ProductMode.packaged,
          measurementKind: MeasurementKind.mass,
          packageAmount: '1',
          packageUnit: 'kg',
        ),
      );
      final foreignProduct = await queries.createProduct(
        other,
        const ProductDraft(
          userCode: 'OTHER-001',
          name: 'Other',
          brand: 'Marca B',
          mode: ProductMode.packaged,
          measurementKind: MeasurementKind.mass,
          packageAmount: '1',
          packageUnit: 'kg',
        ),
      );
      await registration.registerPurchase(
        RegisterPurchaseCommand(
          accountId: account,
          deviceId: const DeviceId('device-1'),
          storeReference: ExistingStoreReference(store.id),
          occurrenceTime: DateTime.utc(2026, 7, 31, 12),
          currencyCode: 'BRL',
          items: [
            PurchaseItemDraft(
              productReference: ExistingProductReference(product.id),
              packageCount: 1,
              purchasedQuantity: const NormalizedQuantity(
                kind: MeasurementKind.mass,
                unit: CanonicalUnit.kg,
                microunits: NormalizedQuantity.factor,
              ),
              lineTotal: const Money(currencyCode: 'BRL', minorUnits: 1299),
            ),
          ],
        ),
      );
      await registration.registerPurchase(
        RegisterPurchaseCommand(
          accountId: other,
          deviceId: const DeviceId('device-2'),
          storeReference: ExistingStoreReference(otherStore.id),
          occurrenceTime: DateTime.utc(2026, 7, 31, 12),
          currencyCode: 'BRL',
          items: [
            PurchaseItemDraft(
              productReference: ExistingProductReference(foreignProduct.id),
              packageCount: 1,
              purchasedQuantity: const NormalizedQuantity(
                kind: MeasurementKind.mass,
                unit: CanonicalUnit.kg,
                microunits: NormalizedQuantity.factor,
              ),
              lineTotal: const Money(currencyCode: 'BRL', minorUnits: 999),
            ),
          ],
        ),
      );

      final repository = LocalAnalyticsRepository(db);
      final dataset = await repository.loadEvidence(account);

      expect(repository.requestCount, 1);
      expect(dataset.rows, hasLength(1));
      expect(dataset.rows.single.accountId.value, account.value);
      expect(dataset.rows.single.productCode, 'ARROZ-001');
      expect(dataset.rows.single.unitPrice, isNotNull);
    },
  );
}
