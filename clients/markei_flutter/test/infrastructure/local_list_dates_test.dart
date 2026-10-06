import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/product_lists.dart';
import 'package:markei/domain/catalogue/product.dart' as domain;
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';

void main() {
  test('List registration order and date-to-today are independent of forecasts', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final repository = LocalQueryRepository(db);
    const account = AccountId('11111111-1111-4111-8111-111111111111');
    final store = await repository.createStore(account, 'Market');
    final product = await repository.createProduct(account, const domain.ProductDraft(
      userCode: 'RICE', name: 'Rice', brand: 'Marc',
      mode: domain.ProductMode.bulk, measurementKind: MeasurementKind.mass,
    ));
    Future<void> record(String id, DateTime occurrence, DateTime entered, int price) async {
      await db.into(db.purchases).insert(PurchasesCompanion.insert(
        id: id, accountId: account.value, storeId: store.id.value,
        occurrenceTime: occurrence, currencyCode: 'BRL',
        totalMinorUnits: price, createdAt: entered,
      ));
      await db.into(db.purchaseItems).insert(PurchaseItemsCompanion.insert(
        id: '$id-item', purchaseId: id, productId: product.id.value,
        measurementKind: 'MASS', purchasedAmount: '1.000000',
        purchasedUnit: 'KG', currencyCode: 'BRL', lineTotalMinorUnits: price,
      ));
    }
    await record('a', DateTime(2026, 10, 1), DateTime(2026, 10, 1), 100);
    await record('b', DateTime(2026, 10, 3), DateTime(2026, 10, 2), 200);
    await record('c', DateTime(2027, 1, 1), DateTime(2026, 10, 3), 300);
    await record('d', DateTime(2026, 9, 1), DateTime(2026, 10, 4), 400);
    final item = (await repository.productListProjection(
      accountId: account, view: ProductListView.all, today: DateTime(2026, 10, 5),
    )).items.single;
    expect(item.lastRegisteredPurchaseDate, DateTime(2026, 9, 1));
    expect(item.lastPurchaseUpToDate, DateTime(2026, 10, 3));
    expect(item.latestLineTotalMinorUnits, 300);
    expect(item.daysSinceLastPurchase, lessThan(0));
    expect(await db.select(db.purchases).get(), hasLength(4));
  });
}
