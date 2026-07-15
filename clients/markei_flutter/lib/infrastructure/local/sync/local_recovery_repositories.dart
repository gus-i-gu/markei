import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:crypto/crypto.dart';

import '../../../application/sync/sync_ports.dart';
import '../../../domain/sync/sync_event.dart';
import '../local_database.dart' hide RecoveryChunk, RecoverySession;

final class DriftLocalRecoveryGuard implements LocalRecoveryGuard {
  DriftLocalRecoveryGuard(this.db);

  final LocalDatabase db;

  @override
  Future<SyncResult> ensureRebootstrapAllowed() async {
    final rows =
        await (db.select(db.pendingEvents)..where(
              (table) =>
                  table.state.equals('pending') |
                  table.state.equals('uploading') |
                  table.state.equals('unknown'),
            ))
            .get();
    if (rows.isNotEmpty) {
      return const SyncResult(
        code: SyncStatusCode.localChangesBlockRebootstrap,
        outcome: SyncOutcome.notApplied,
        retryable: false,
      );
    }
    return const SyncResult(
      code: SyncStatusCode.fullRebootstrapRequired,
      outcome: SyncOutcome.duplicateEquivalent,
      retryable: false,
    );
  }
}

final class DriftRecoveryProgressRepository
    implements RecoveryProgressRepository {
  DriftRecoveryProgressRepository(this.db);

  final LocalDatabase db;

  @override
  Future<void> saveSession(RecoverySession session) async {
    final now = DateTime.now().toUtc();
    await db
        .into(db.recoverySessions)
        .insertOnConflictUpdate(
          RecoverySessionsCompanion.insert(
            id: session.id,
            accountId: session.manifest.accountId,
            snapshotId: session.manifest.snapshotId,
            phase: _phaseWire(session.phase),
            formatVersion: session.manifest.formatVersion,
            manifestHash: session.manifest.manifestHash,
            coveredThroughCursor: session.manifest.coveredThroughCursor,
            expiresAt: now.add(const Duration(minutes: 10)),
            updatedAt: now,
          ),
        );
  }

  @override
  Future<void> saveChunk(String sessionId, RecoveryChunk chunk) async {
    await db
        .into(db.recoveryChunks)
        .insertOnConflictUpdate(
          RecoveryChunksCompanion.insert(
            sessionId: sessionId,
            chunkIndex: chunk.index,
            byteLength: chunk.length,
            contentHash: chunk.hash,
            bytes: Uint8List.fromList(chunk.bytes),
            verifiedAt: DateTime.now().toUtc(),
          ),
        );
  }

  @override
  Future<List<RecoveryChunk>> loadedChunks(String sessionId) async {
    final rows =
        await (db.select(db.recoveryChunks)
              ..where((table) => table.sessionId.equals(sessionId))
              ..orderBy([(table) => OrderingTerm.asc(table.chunkIndex)]))
            .get();
    return rows
        .map(
          (row) => RecoveryChunk(
            index: row.chunkIndex,
            length: row.byteLength,
            hash: row.contentHash,
            bytes: row.bytes,
          ),
        )
        .toList(growable: false);
  }
}

final class DriftSnapshotFactApplier implements SnapshotFactApplier {
  DriftSnapshotFactApplier(this.db);

  final LocalDatabase db;

  @override
  Future<SyncResult> applySnapshotFacts({
    required RecoveryManifest manifest,
    required List<RecoveryChunk> chunks,
  }) async {
    final ordered = [...chunks]..sort((a, b) => a.index.compareTo(b.index));
    if (ordered.length != manifest.chunks.length) {
      return _conflict();
    }
    final bytes = <int>[];
    for (var i = 0; i < ordered.length; i++) {
      final chunk = ordered[i];
      final expected = manifest.chunks[i];
      if (chunk.index != expected.index ||
          chunk.length != expected.length ||
          chunk.hash != expected.hash ||
          _rawSha256(chunk.bytes) != expected.hash) {
        return _conflict();
      }
      bytes.addAll(chunk.bytes);
    }
    if (bytes.length != manifest.totalBytes ||
        _rawSha256(bytes) != manifest.totalHash) {
      return _conflict();
    }
    final facts = jsonDecode(utf8.decode(bytes)) as Map<String, Object?>;
    await db.transaction(() async {
      await _applyAccount(facts['account'] as Map<String, Object?>);
      for (final store
          in (facts['stores'] as List<Object?>).cast<Map<String, Object?>>()) {
        await _applyStore(store);
      }
      for (final product
          in (facts['products'] as List<Object?>)
              .cast<Map<String, Object?>>()) {
        await _applyProduct(product);
      }
      for (final purchase
          in (facts['purchases'] as List<Object?>)
              .cast<Map<String, Object?>>()) {
        await _applyPurchase(purchase);
      }
      for (final item
          in (facts['purchaseItems'] as List<Object?>)
              .cast<Map<String, Object?>>()) {
        await _applyPurchaseItem(item);
      }
      await db
          .into(db.syncState)
          .insertOnConflictUpdate(
            SyncStateCompanion.insert(
              accountId: manifest.accountId,
              accountCursor: Value(manifest.coveredThroughCursor),
              updatedAt: DateTime.now().toUtc(),
            ),
          );
    });
    return const SyncResult(
      code: SyncStatusCode.downloadedApplied,
      outcome: SyncOutcome.applied,
      retryable: false,
    );
  }

  Future<void> _applyAccount(Map<String, Object?> account) async {
    await db
        .into(db.localAccounts)
        .insertOnConflictUpdate(
          LocalAccountsCompanion.insert(
            id: account['id']! as String,
            defaultCurrencyCode: account['defaultCurrencyCode']! as String,
            createdAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<void> _applyStore(Map<String, Object?> store) async {
    await db
        .into(db.stores)
        .insertOnConflictUpdate(
          StoresCompanion.insert(
            id: store['id']! as String,
            accountId: store['accountId']! as String,
            displayName: store['displayName']! as String,
            createdAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<void> _applyProduct(Map<String, Object?> product) async {
    final packageQuantity = product['packageQuantity'] as Map<String, Object?>?;
    await db
        .into(db.products)
        .insertOnConflictUpdate(
          ProductsCompanion.insert(
            id: product['id']! as String,
            accountId: product['accountId']! as String,
            userProductCode:
                (product['userProductCode']!
                        as Map<String, Object?>)['displayValue']!
                    as String,
            normalizedUserProductCode:
                (product['userProductCode']!
                        as Map<String, Object?>)['normalizedKey']!
                    as String,
            normalizationVersion: product['normalizationVersion']! as int,
            displayName: Value(product['displayName'] as String?),
            displayBrand: Value(product['displayBrand'] as String?),
            normalizedName: product['normalizedName']! as String,
            normalizedBrand: product['normalizedBrand']! as String,
            mode: product['mode']! as String,
            measurementKind: product['measurementKind']! as String,
            packageAmount: Value(packageQuantity?['amount'] as String?),
            packageUnit: Value(packageQuantity?['unit'] as String?),
            exactIdentityKey: product['identityKey']! as String,
            createdAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<void> _applyPurchase(Map<String, Object?> purchase) async {
    final store = purchase['store']! as Map<String, Object?>;
    await db
        .into(db.purchases)
        .insertOnConflictUpdate(
          PurchasesCompanion.insert(
            id: purchase['id']! as String,
            accountId: purchase['accountId']! as String,
            storeId: store['id']! as String,
            personId: Value(purchase['personId'] as String?),
            paymentMethodId: Value(purchase['paymentMethodId'] as String?),
            occurrenceTime: DateTime.parse(
              purchase['occurrenceTime']! as String,
            ),
            currencyCode: purchase['currencyCode']! as String,
            totalMinorUnits: purchase['totalMinorUnits']! as int,
            createdAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<void> _applyPurchaseItem(Map<String, Object?> item) async {
    final quantity = item['purchasedQuantity']! as Map<String, Object?>;
    final total = item['lineTotal']! as Map<String, Object?>;
    await db
        .into(db.purchaseItems)
        .insertOnConflictUpdate(
          PurchaseItemsCompanion.insert(
            id: item['id']! as String,
            purchaseId: item['purchaseId']! as String,
            productId: item['productId']! as String,
            packageCount: Value(item['packageCount'] as int?),
            measurementKind: quantity['kind']! as String,
            purchasedAmount: quantity['amount']! as String,
            purchasedUnit: quantity['unit']! as String,
            currencyCode: total['currencyCode']! as String,
            lineTotalMinorUnits: total['minorUnits']! as int,
          ),
        );
  }

  SyncResult _conflict() => const SyncResult(
    code: SyncStatusCode.conflict,
    outcome: SyncOutcome.notApplied,
    retryable: false,
  );
}

String _phaseWire(RecoveryPhase phase) => switch (phase) {
  RecoveryPhase.fullRebootstrapRequired => 'full-rebootstrap-required',
  RecoveryPhase.preparing => 'preparing',
  RecoveryPhase.downloading => 'downloading',
  RecoveryPhase.downloaded => 'downloaded',
  RecoveryPhase.applying => 'applying',
  RecoveryPhase.catchingUp => 'catching-up',
  RecoveryPhase.recoveryCompleted => 'recovery-completed',
  RecoveryPhase.recoveryInterrupted => 'recovery-interrupted',
};

String _rawSha256(List<int> bytes) => sha256.convert(bytes).toString();
