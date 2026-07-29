import 'package:drift/drift.dart';

import '../local_database.dart';

final class RemotePurchaseFactWriter {
  const RemotePurchaseFactWriter(this._db);

  final LocalDatabase _db;

  Future<void> applyPurchaseRegistered(Map<String, Object?> event) async {
    final payload = event['payload'] as Map<String, Object?>;
    final purchase = payload['purchase'] as Map<String, Object?>;
    final accountId = event['accountId'] as String;
    if (purchase['personId'] != null || purchase['paymentMethodId'] != null) {
      throw StateError('Remote reference snapshots are required.');
    }
    await _db
        .into(_db.localAccounts)
        .insert(
          LocalAccountsCompanion.insert(
            id: accountId,
            defaultCurrencyCode: purchase['currencyCode'] as String,
            createdAt: DateTime.now().toUtc(),
          ),
          mode: InsertMode.insertOrIgnore,
        );
    final storeId = await _resolveStore(
      purchase['store'] as Map<String, Object?>,
    );
    final products = (payload['productSnapshots'] as List<Object?>)
        .cast<Map<String, Object?>>();
    final productIdMap = <String, String>{};
    for (final product in products) {
      final incomingId = product['id'] as String;
      productIdMap[incomingId] = await _resolveProduct(product);
    }
    await _applyPurchase(
      purchase,
      storeId: storeId,
      productIdMap: productIdMap,
    );
  }

  Future<String> _resolveStore(Map<String, Object?> store) async {
    final id = store['id'] as String;
    final accountId = store['accountId'] as String;
    final displayName = store['displayName'] as String;
    final existing = await (_db.select(
      _db.stores,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (existing != null) {
      if (existing.accountId != accountId ||
          existing.displayName != displayName) {
        throw const RemoteIdentityConflict('remote-store-identity-conflict');
      }
      return existing.id;
    }
    final equivalent =
        await (_db.select(_db.stores)..where(
              (table) =>
                  table.accountId.equals(accountId) &
                  table.displayName.equals(displayName),
            ))
            .getSingleOrNull();
    if (equivalent != null) {
      return equivalent.id;
    }
    await _db
        .into(_db.stores)
        .insert(
          StoresCompanion.insert(
            id: id,
            accountId: accountId,
            displayName: displayName,
            createdAt: DateTime.now().toUtc(),
          ),
        );
    return id;
  }

  Future<String> _resolveProduct(Map<String, Object?> product) async {
    final id = product['id'] as String;
    final accountId = product['accountId'] as String;
    final userCode = product['userProductCode'] as Map<String, Object?>;
    final normalizedCode = userCode['normalizedKey'] as String;
    final identityKey = product['identityKey'] as String;
    final packageQuantity = product['packageQuantity'] as Map<String, Object?>?;
    final existing = await (_db.select(
      _db.products,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (existing != null) {
      if (!_coherentProduct(existing, product)) {
        throw const RemoteIdentityConflict('remote-product-identity-conflict');
      }
      await _assertNoDistinctNaturalMatch(
        id: existing.id,
        accountId: accountId,
        normalizedCode: normalizedCode,
        identityKey: identityKey,
      );
      return existing.id;
    }
    final byCode =
        await (_db.select(_db.products)..where(
              (table) =>
                  table.accountId.equals(accountId) &
                  table.normalizedUserProductCode.equals(normalizedCode),
            ))
            .get();
    final byIdentity =
        await (_db.select(_db.products)..where(
              (table) =>
                  table.accountId.equals(accountId) &
                  table.exactIdentityKey.equals(identityKey),
            ))
            .get();
    final selected = _selectNaturalProduct(byCode, byIdentity, product);
    if (selected != null) {
      return selected.id;
    }
    await _db
        .into(_db.products)
        .insert(
          ProductsCompanion.insert(
            id: id,
            accountId: accountId,
            userProductCode: userCode['displayValue'] as String,
            normalizedUserProductCode: normalizedCode,
            normalizationVersion: product['normalizationVersion'] as int,
            displayName: Value(product['displayName'] as String?),
            displayBrand: Value(product['displayBrand'] as String?),
            normalizedName: product['normalizedName'] as String,
            normalizedBrand: product['normalizedBrand'] as String,
            mode: product['mode'] as String,
            measurementKind: product['measurementKind'] as String,
            packageAmount: Value(packageQuantity?['amount'] as String?),
            packageUnit: Value(packageQuantity?['unit'] as String?),
            exactIdentityKey: identityKey,
            createdAt: DateTime.now().toUtc(),
          ),
        );
    return id;
  }

  Future<void> _assertNoDistinctNaturalMatch({
    required String id,
    required String accountId,
    required String normalizedCode,
    required String identityKey,
  }) async {
    final rows =
        await (_db.select(_db.products)..where(
              (table) =>
                  table.accountId.equals(accountId) &
                  (table.normalizedUserProductCode.equals(normalizedCode) |
                      table.exactIdentityKey.equals(identityKey)),
            ))
            .get();
    for (final row in rows) {
      if (row.id != id) {
        throw const RemoteIdentityConflict(
          'remote-product-natural-identity-conflict',
        );
      }
    }
  }

  Product? _selectNaturalProduct(
    List<Product> byCode,
    List<Product> byIdentity,
    Map<String, Object?> product,
  ) {
    if (byCode.length > 1) {
      throw const RemoteIdentityConflict('remote-product-ambiguous-code-match');
    }
    if (byIdentity.length > 1) {
      throw const RemoteIdentityConflict(
        'remote-product-ambiguous-exact-identity-match',
      );
    }
    final code = byCode.singleOrNull;
    final identity = byIdentity.singleOrNull;
    if (code != null && identity != null && code.id != identity.id) {
      throw const RemoteIdentityConflict('remote-product-split-key-conflict');
    }
    if (code != null && identity == null) {
      throw const RemoteIdentityConflict(
        'remote-product-same-code-different-identity',
      );
    }
    final selected = code ?? identity;
    if (selected == null) return null;
    if (!_coherentProductIdentity(selected, product)) {
      throw const RemoteIdentityConflict(
        'remote-product-natural-identity-conflict',
      );
    }
    return selected;
  }

  bool _coherentProduct(Product existing, Map<String, Object?> product) {
    final userCode = product['userProductCode'] as Map<String, Object?>;
    return _coherentProductIdentity(existing, product) &&
        existing.userProductCode == userCode['displayValue'] &&
        existing.normalizedUserProductCode == userCode['normalizedKey'] &&
        existing.displayName == product['displayName'] &&
        existing.displayBrand == product['displayBrand'];
  }

  bool _coherentProductIdentity(
    Product existing,
    Map<String, Object?> product,
  ) {
    final packageQuantity = product['packageQuantity'] as Map<String, Object?>?;
    return existing.accountId == product['accountId'] &&
        existing.normalizationVersion == product['normalizationVersion'] &&
        existing.normalizedName == product['normalizedName'] &&
        existing.normalizedBrand == product['normalizedBrand'] &&
        existing.mode == product['mode'] &&
        existing.measurementKind == product['measurementKind'] &&
        existing.packageAmount == packageQuantity?['amount'] &&
        existing.packageUnit == packageQuantity?['unit'] &&
        existing.exactIdentityKey == product['identityKey'];
  }

  Future<void> _applyPurchase(
    Map<String, Object?> purchase, {
    required String storeId,
    required Map<String, String> productIdMap,
  }) async {
    final id = purchase['id'] as String;
    final existing = await (_db.select(
      _db.purchases,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (existing != null) {
      if (existing.totalMinorUnits != purchase['totalMinorUnits'] ||
          existing.storeId != storeId) {
        throw const RemoteIdentityConflict('remote-purchase-identity-conflict');
      }
      return;
    }
    await _db
        .into(_db.purchases)
        .insert(
          PurchasesCompanion.insert(
            id: id,
            accountId: purchase['accountId'] as String,
            storeId: storeId,
            personId: const Value(null),
            paymentMethodId: const Value(null),
            occurrenceTime: DateTime.parse(
              purchase['occurrenceTime'] as String,
            ),
            currencyCode: purchase['currencyCode'] as String,
            totalMinorUnits: purchase['totalMinorUnits'] as int,
            createdAt: DateTime.now().toUtc(),
          ),
        );
    for (final item
        in (purchase['items'] as List<Object?>).cast<Map<String, Object?>>()) {
      await _applyItem(item, productIdMap: productIdMap);
    }
  }

  Future<void> _applyItem(
    Map<String, Object?> item, {
    required Map<String, String> productIdMap,
  }) async {
    final quantity = item['purchasedQuantity'] as Map<String, Object?>;
    final money = item['lineTotal'] as Map<String, Object?>;
    final incomingProductId = item['productId'] as String;
    final localProductId = productIdMap[incomingProductId];
    if (localProductId == null) {
      throw const RemoteIdentityConflict('remote-product-reference-missing');
    }
    await _db
        .into(_db.purchaseItems)
        .insert(
          PurchaseItemsCompanion.insert(
            id: item['id'] as String,
            purchaseId: item['purchaseId'] as String,
            productId: localProductId,
            packageCount: Value(item['packageCount'] as int?),
            measurementKind: quantity['kind'] as String,
            purchasedAmount: quantity['amount'] as String,
            purchasedUnit: quantity['unit'] as String,
            currencyCode: money['currencyCode'] as String,
            lineTotalMinorUnits: money['minorUnits'] as int,
          ),
        );
  }
}

final class RemoteIdentityConflict implements Exception {
  const RemoteIdentityConflict(this.protocolCode);

  final String protocolCode;
}
