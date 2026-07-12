import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../application/register_purchase.dart';
import '../../domain/catalogue/product.dart' as domain;
import '../../domain/purchase/purchase.dart' as domain_purchase;
import '../../domain/shared/ids.dart';
import '../../domain/store/store.dart' as domain_store;
import '../../domain/sync/sync_event.dart' as domain_sync;
import 'local_database.dart';

class LocalPurchaseRepository implements PurchaseRegistrationRepository {
  LocalPurchaseRepository(this._db, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  final LocalDatabase _db;
  final Uuid _uuid;

  @override
  Future<PurchaseRegistrationResult> registerPurchase(
    RegisterPurchaseCommand command,
  ) {
    return _db.transaction(() async {
      if (command.items.isEmpty) {
        throw ArgumentError('Purchase requires at least one Item.');
      }

      final now = DateTime.now().toUtc();
      await _db
          .into(_db.localAccounts)
          .insertOnConflictUpdate(
            LocalAccountsCompanion.insert(
              id: command.accountId.value,
              defaultCurrencyCode: command.currencyCode,
              createdAt: now,
            ),
          );
      await _db
          .into(_db.syncState)
          .insertOnConflictUpdate(
            SyncStateCompanion.insert(
              accountId: command.accountId.value,
              accountCursor: const Value(null),
              updatedAt: now,
            ),
          );
      await _db
          .into(_db.devices)
          .insertOnConflictUpdate(
            DevicesCompanion.insert(
              id: command.deviceId.value,
              accountId: command.accountId.value,
              nextSequence: 1,
              createdAt: now,
            ),
          );

      final store = await _resolveStore(command, now);
      final purchaseId = PurchaseId(_uuid.v4());
      final itemModels = <domain_purchase.PurchaseItem>[];

      for (final draft in command.items) {
        final product = domain.normalizeProductDraft(
          accountId: command.accountId,
          draft: draft.productDraft,
        );
        await _upsertProduct(product, now);
        final item = domain_purchase.PurchaseItem(
          id: PurchaseItemId(_uuid.v4()),
          purchaseId: purchaseId,
          productId: product.id,
          packageCount: draft.packageCount,
          purchasedQuantity: draft.purchasedQuantity,
          lineTotal: draft.lineTotal,
        );
        item.validate();
        itemModels.add(item);
      }

      final purchase = domain_purchase.Purchase(
        id: purchaseId,
        accountId: command.accountId,
        store: store,
        occurrenceTime: command.occurrenceTime,
        currencyCode: command.currencyCode,
        items: itemModels,
      )..validate();

      await _db
          .into(_db.purchases)
          .insert(
            PurchasesCompanion.insert(
              id: purchase.id.value,
              accountId: command.accountId.value,
              storeId: store.id.value,
              occurrenceTime: command.occurrenceTime.toUtc(),
              currencyCode: command.currencyCode,
              totalMinorUnits: purchase.totalMinorUnits,
              createdAt: now,
            ),
          );

      for (final item in purchase.items) {
        await _db
            .into(_db.purchaseItems)
            .insert(
              PurchaseItemsCompanion.insert(
                id: item.id.value,
                purchaseId: item.purchaseId.value,
                productId: item.productId.value,
                packageCount: item.packageCount,
                measurementKind: item.purchasedQuantity.kind.name.toUpperCase(),
                purchasedAmount: item.purchasedQuantity.decimalText,
                purchasedUnit: item.purchasedQuantity.unit.name.toUpperCase(),
                currencyCode: item.lineTotal.currencyCode,
                lineTotalMinorUnits: item.lineTotal.minorUnits,
              ),
            );
      }

      final sequence = await _allocateDeviceSequence(command.deviceId);
      final event = domain_sync.SyncEvent(
        id: EventId(_uuid.v4()),
        accountId: command.accountId,
        deviceId: command.deviceId,
        deviceSequence: sequence,
        eventType: 'purchase.registered',
        payloadVersion: 1,
        occurrenceTime: command.occurrenceTime,
        purchase: purchase,
      );
      final payload = jsonEncode(event.toJson());
      final contentHash = sha256.convert(utf8.encode(payload)).toString();

      await _db
          .into(_db.syncEvents)
          .insert(
            SyncEventsCompanion.insert(
              id: event.id.value,
              accountId: command.accountId.value,
              deviceId: command.deviceId.value,
              deviceSequence: sequence,
              eventType: event.eventType,
              payloadVersion: event.payloadVersion,
              occurrenceTime: command.occurrenceTime.toUtc(),
              payloadJson: payload,
              contentHash: contentHash,
              createdAt: now,
            ),
          );
      await _db
          .into(_db.pendingEvents)
          .insert(
            PendingEventsCompanion.insert(
              eventId: event.id.value,
              state: domain_sync.PendingEventState.pending.name,
              enqueuedAt: now,
            ),
          );

      return PurchaseRegistrationResult(
        purchaseId: purchase.id,
        eventId: event.id,
        deviceSequence: sequence,
      );
    });
  }

  Future<domain_store.Store> _resolveStore(
    RegisterPurchaseCommand command,
    DateTime now,
  ) async {
    final name = command.storeName.trim();
    if (name.isEmpty) {
      throw ArgumentError('Store display name is required.');
    }
    final existing =
        await (_db.select(_db.stores)..where(
              (table) =>
                  table.accountId.equals(command.accountId.value) &
                  table.displayName.equals(name),
            ))
            .getSingleOrNull();
    if (existing != null) {
      return domain_store.Store(
        id: StoreId(existing.id),
        accountId: command.accountId,
        displayName: existing.displayName,
      );
    }
    final store = domain_store.Store(
      id: StoreId(_uuid.v4()),
      accountId: command.accountId,
      displayName: name,
    );
    await _db
        .into(_db.stores)
        .insert(
          StoresCompanion.insert(
            id: store.id.value,
            accountId: command.accountId.value,
            displayName: store.displayName,
            createdAt: now,
          ),
        );
    return store;
  }

  Future<void> _upsertProduct(domain.Product product, DateTime now) async {
    await _db
        .into(_db.products)
        .insertOnConflictUpdate(
          ProductsCompanion.insert(
            id: product.id.value,
            accountId: product.accountId.value,
            normalizationVersion: product.normalizationVersion,
            normalizedName: product.normalizedName,
            normalizedBrand: product.normalizedBrand,
            mode: product.mode.name.toUpperCase(),
            measurementKind: product.measurementKind.name.toUpperCase(),
            packageAmount: Value(product.packageQuantity?.decimalText),
            packageUnit: Value(
              product.packageQuantity?.unit.name.toUpperCase(),
            ),
            exactIdentityKey: product.identityKey,
            createdAt: now,
          ),
        );
  }

  Future<int> _allocateDeviceSequence(DeviceId deviceId) async {
    final device = await (_db.select(
      _db.devices,
    )..where((table) => table.id.equals(deviceId.value))).getSingle();
    final sequence = device.nextSequence;
    await (_db.update(_db.devices)
          ..where((table) => table.id.equals(deviceId.value)))
        .write(DevicesCompanion(nextSequence: Value(sequence + 1)));
    return sequence;
  }
}
