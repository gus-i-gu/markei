import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/register_purchase.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';

void main() {
  test('History export uses two set-based Account-scoped reads', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    var exportReads = 0;
    final queries = LocalQueryRepository(db, onExportRead: () => exportReads++);
    final registration = LocalPurchaseRepository(db);
    final account = const AccountId('account-1');
    final foreign = const AccountId('account-2');
    final store = await queries.createStore(account, 'Store');
    final foreignStore = await queries.createStore(foreign, 'Foreign Store');
    final product = await queries.createProduct(
      account,
      const ProductDraft(
        userCode: 'P-1',
        name: 'Product',
        brand: 'Brand',
        mode: ProductMode.packaged,
        measurementKind: MeasurementKind.mass,
        packageAmount: '1',
        packageUnit: 'kg',
      ),
    );
    final foreignProduct = await queries.createProduct(
      foreign,
      const ProductDraft(
        userCode: 'P-2',
        name: 'Foreign Product',
        brand: 'Brand',
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
        occurrenceTime: DateTime.utc(2026, 7, 31),
        currencyCode: 'BRL',
        items: [
          PurchaseItemDraft(
            productReference: ExistingProductReference(product.id),
            packageCount: 1,
            purchasedQuantity: NormalizedQuantity.fromDecimalString(
              kind: MeasurementKind.mass,
              unit: CanonicalUnit.kg,
              decimal: '1',
            ),
            lineTotal: const Money(currencyCode: 'BRL', minorUnits: 100),
          ),
        ],
      ),
    );
    await registration.registerPurchase(
      RegisterPurchaseCommand(
        accountId: foreign,
        deviceId: const DeviceId('device-2'),
        storeReference: ExistingStoreReference(foreignStore.id),
        occurrenceTime: DateTime.utc(2026, 7, 31),
        currencyCode: 'BRL',
        items: [
          PurchaseItemDraft(
            productReference: ExistingProductReference(foreignProduct.id),
            packageCount: 1,
            purchasedQuantity: NormalizedQuantity.fromDecimalString(
              kind: MeasurementKind.mass,
              unit: CanonicalUnit.kg,
              decimal: '1',
            ),
            lineTotal: const Money(currencyCode: 'BRL', minorUnits: 200),
          ),
        ],
      ),
    );
    final purchases = await queries.listRecentPurchases(account);

    final bundle = await queries.exportBundle(account, {
      purchases.single.purchaseId,
      const PurchaseId('foreign-id'),
    });

    expect(exportReads, 2);
    expect(bundle.purchases, hasLength(1));
    expect(bundle.purchases.single.entry.storeName, 'Store');
    expect(bundle.purchases.single.items, hasLength(1));
  });
}
