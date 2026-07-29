import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/register_purchase.dart';
import 'package:markei/application/sync/sync_ports.dart';
import 'package:markei/application/sync/sync_use_cases.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/catalogue/product_code.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/domain/sync/canonical_json.dart';
import 'package:markei/domain/sync/sync_event.dart';
import 'package:markei/infrastructure/local/local_database.dart' hide Product;
import 'package:markei/infrastructure/local/local_device_identity_repository.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/sync/remote_purchase_event_applier.dart';

void main() {
  test('fresh remote target materializes purchase facts', () async {
    final source = LocalDatabase.memory();
    final target = LocalDatabase.memory();
    addTearDown(source.close);
    addTearDown(target.close);
    final event = await _sourceEvent(source, sequence: 1);

    final result = await DriftRemoteEventApplier.scoped(
      target,
      accountId: _account,
    ).applyPage(_page(event, cursor: 1));

    expect(result.code, SyncStatusCode.downloadedApplied);
    expect(await target.select(target.stores).get(), hasLength(1));
    expect(await target.select(target.products).get(), hasLength(1));
    expect(await target.select(target.purchases).get(), hasLength(1));
    expect(await target.select(target.purchaseItems).get(), hasLength(1));
    expect(await target.select(target.syncInbox).get(), hasLength(1));
  });

  test('same Product UUID with coherent facts replays idempotently', () async {
    final target = LocalDatabase.memory();
    addTearDown(target.close);
    final event = _event(
      eventId: 'event-1',
      purchaseId: 'purchase-1',
      storeId: 'store-1',
      productId: 'product-1',
      productCode: 'RICE-001',
      productName: 'Synthetic rice',
      productBrand: 'Fixture',
      cursor: 1,
    );

    final applier = DriftRemoteEventApplier.scoped(target, accountId: _account);
    expect(
      (await applier.applyPage(_page(event, cursor: 1))).code,
      SyncStatusCode.downloadedApplied,
    );
    expect(
      (await applier.applyPage(_page(event, cursor: 1))).code,
      SyncStatusCode.duplicateIgnored,
    );
    expect(await target.select(target.products).get(), hasLength(1));
    expect(await target.select(target.purchases).get(), hasLength(1));
  });

  test(
    'different Product and Store UUIDs converge by natural identity',
    () async {
      final source = LocalDatabase.memory();
      final target = LocalDatabase.memory();
      addTearDown(source.close);
      addTearDown(target.close);
      await _register(target, deviceId: _targetDevice);
      final localProduct = (await target.select(target.products).get()).single;
      final localStore = (await target.select(target.stores).get()).single;
      final localPurchaseIds = (await target.select(target.purchases).get())
          .map((purchase) => purchase.id)
          .toSet();
      final event = await _sourceEvent(source, sequence: 1);

      final result = await DriftRemoteEventApplier.scoped(
        target,
        accountId: _account,
      ).applyPage(_page(event, cursor: 1));

      expect(result.code, SyncStatusCode.downloadedApplied);
      expect(await target.select(target.products).get(), hasLength(1));
      expect(await target.select(target.stores).get(), hasLength(1));
      final remotePurchase = (await target.select(target.purchases).get())
          .where((purchase) => !localPurchaseIds.contains(purchase.id))
          .single;
      expect(remotePurchase.storeId, localStore.id);
      final remoteItem = (await target.select(target.purchaseItems).get()).last;
      expect(remoteItem.productId, localProduct.id);
    },
  );

  test(
    'new Product UUID reuses exact identity despite different code',
    () async {
      final source = LocalDatabase.memory();
      final target = LocalDatabase.memory();
      addTearDown(source.close);
      addTearDown(target.close);
      await _register(
        target,
        deviceId: _targetDevice,
        productCode: 'LOCAL-RICE',
      );
      final localProduct = (await target.select(target.products).get()).single;
      final event = await _sourceEvent(source, sequence: 1);

      final result = await DriftRemoteEventApplier.scoped(
        target,
        accountId: _account,
      ).applyPage(_page(event, cursor: 1));

      expect(result.code, SyncStatusCode.downloadedApplied);
      final products = await target.select(target.products).get();
      expect(products, hasLength(1));
      expect(products.single.id, localProduct.id);
      expect(products.single.userProductCode, 'LOCAL-RICE');
      final item = (await target.select(target.purchaseItems).get()).last;
      expect(item.productId, localProduct.id);
    },
  );

  test(
    'same code with different exact identity returns typed conflict',
    () async {
      final source = LocalDatabase.memory();
      final target = LocalDatabase.memory();
      addTearDown(source.close);
      addTearDown(target.close);
      await _register(
        target,
        deviceId: _targetDevice,
        productName: 'Different rice facts',
      );
      final event = await _sourceEvent(source, sequence: 1);

      final result = await DriftRemoteEventApplier.scoped(
        target,
        accountId: _account,
      ).applyPage(_page(event, cursor: 1));

      expect(result.code, SyncStatusCode.conflict);
      expect(
        result.protocolCode,
        'remote-product-same-code-different-identity',
      );
    },
  );

  test('split product natural keys return typed conflict', () async {
    final source = LocalDatabase.memory();
    final target = LocalDatabase.memory();
    addTearDown(source.close);
    addTearDown(target.close);
    await _register(
      target,
      deviceId: _targetDevice,
      productName: 'Different rice facts',
      productCode: 'RICE-001',
    );
    await _register(
      target,
      deviceId: _targetDevice,
      productName: 'Synthetic rice',
      productCode: 'LOCAL-RICE',
      occurrenceMinute: 13,
    );
    final event = await _sourceEvent(source, sequence: 1);

    final result = await DriftRemoteEventApplier.scoped(
      target,
      accountId: _account,
    ).applyPage(_page(event, cursor: 1));

    expect(result.code, SyncStatusCode.conflict);
    expect(result.protocolCode, 'remote-product-split-key-conflict');
  });

  test('two events sharing catalogue identities remap each item', () async {
    final source = LocalDatabase.memory();
    final target = LocalDatabase.memory();
    addTearDown(source.close);
    addTearDown(target.close);
    await _register(target, deviceId: _targetDevice);
    final localProduct = (await target.select(target.products).get()).single;
    final first = await _sourceEvent(source, sequence: 1);
    final second = await _sourceEvent(source, sequence: 2);

    final result =
        await DriftRemoteEventApplier.scoped(
          target,
          accountId: _account,
        ).applyPage(
          DownloadPage(
            nextCursor: 'c10b:2',
            events: [
              DownloadedEvent(event: first, serverCursor: 'c10b:1'),
              DownloadedEvent(event: second, serverCursor: 'c10b:2'),
            ],
          ),
        );

    expect(result.code, SyncStatusCode.downloadedApplied);
    final remoteItems = (await target.select(target.purchaseItems).get()).where(
      (item) => item.productId == localProduct.id,
    );
    expect(remoteItems, hasLength(3));
  });

  test('contradictory Product natural identity rolls back the page', () async {
    final source = LocalDatabase.memory();
    final target = LocalDatabase.memory();
    addTearDown(source.close);
    addTearDown(target.close);
    await _register(
      target,
      deviceId: _targetDevice,
      productName: 'Different rice facts',
    );
    final before = await _counts(target);
    final event = await _sourceEvent(source, sequence: 1);

    final result = await DriftRemoteEventApplier.scoped(
      target,
      accountId: _account,
    ).applyPage(_page(event, cursor: 1));

    expect(result.code, SyncStatusCode.conflict);
    expect(result.protocolCode, 'remote-product-same-code-different-identity');
    expect(await _counts(target), before);
    expect(
      await DriftRemoteEventApplier.scoped(
        target,
        accountId: _account,
      ).greatestContiguousAppliedCursor(),
      isNull,
    );
  });

  test('mid-page conflict rolls back facts inbox and cursor', () async {
    final target = LocalDatabase.memory();
    addTearDown(target.close);
    await _register(
      target,
      deviceId: _targetDevice,
      productName: 'Different rice facts',
    );
    final before = await _counts(target);
    final fresh = _event(
      eventId: 'event-fresh',
      purchaseId: 'purchase-fresh',
      storeId: 'store-fresh',
      productId: 'product-fresh',
      productCode: 'BEANS-001',
      productName: 'Beans',
      productBrand: 'Fixture',
      cursor: 1,
    );
    final conflict = _event(
      eventId: 'event-conflict',
      purchaseId: 'purchase-conflict',
      storeId: 'store-conflict',
      productId: 'product-conflict',
      productCode: 'RICE-001',
      productName: 'Synthetic rice',
      productBrand: 'Fixture',
      cursor: 2,
    );

    final result =
        await DriftRemoteEventApplier.scoped(
          target,
          accountId: _account,
        ).applyPage(
          DownloadPage(
            nextCursor: 'c10b:2',
            events: [
              DownloadedEvent(event: fresh, serverCursor: 'c10b:1'),
              DownloadedEvent(event: conflict, serverCursor: 'c10b:2'),
            ],
          ),
        );

    expect(result.code, SyncStatusCode.conflict);
    expect(await _counts(target), before);
  });

  test('SQLite local apply failure is sanitized and unacknowledged', () async {
    final target = LocalDatabase.memory();
    addTearDown(target.close);
    final event = _event(
      eventId: 'event-sqlite',
      purchaseId: 'purchase-sqlite',
      storeId: 'store-sqlite',
      productId: 'product-sqlite',
      productCode: 'SQL-001',
      productName: 'SQLite proof',
      productBrand: 'Fixture',
      cursor: 1,
      itemPurchaseId: 'missing-purchase',
    );
    final transport = _DownloadTransport(_page(event, cursor: 1));
    final applier = DriftRemoteEventApplier.scoped(target, accountId: _account);
    final diagnostics = _RecordingDiagnostics();
    final download = DownloadAndApplyEvents(transport, applier);

    final result = await download(null, diagnostics: diagnostics);
    final ack = await AcknowledgeAppliedCursor(transport, applier)(
      diagnostics: diagnostics,
    );

    expect(result.code, SyncStatusCode.unknownOutcome);
    expect(result.protocolCode, 'local-sqlite-apply-failed');
    expect(result.sanitizedExceptionClass, 'sqlite-drift-database-failure');
    expect(ack, isNull);
    expect(transport.acknowledgements, 0);
    final localApply = diagnostics.events.lastWhere(
      (event) => event.phase == 'download-local-apply',
    );
    expect(localApply.code, 'MKS-LDB-001');
    expect(localApply.trustedResponseState, 'received');
    expect(localApply.localMutationState, 'rolled-back');
    expect(localApply.resultPersistenceState, 'not-started');
    expect(await target.select(target.syncInbox).get(), isEmpty);
    expect(await target.select(target.purchases).get(), isEmpty);
  });

  test('non-SQL apply exception rolls back and remains bounded', () async {
    final target = LocalDatabase.memory();
    addTearDown(target.close);
    final event = _event(
      eventId: 'event-shape',
      purchaseId: 'purchase-shape',
      storeId: 'store-shape',
      productId: 'product-shape',
      productCode: 'SHAPE-001',
      productName: 'Shape proof',
      productBrand: 'Fixture',
      cursor: 1,
    );
    final payload = event['payload'] as Map<String, Object?>;
    final snapshots = payload['productSnapshots'] as List<Object?>;
    final brokenProduct = Map<String, Object?>.from(
      snapshots.single as Map<String, Object?>,
    )..remove('identityKey');
    final brokenPayload = Map<String, Object?>.from(payload)
      ..['productSnapshots'] = [brokenProduct];
    final brokenEvent = Map<String, Object?>.from(event)
      ..['payload'] = brokenPayload;
    brokenEvent['contentHash'] = canonicalUtf8Sha256(
      Map<String, Object?>.from(brokenEvent)..remove('contentHash'),
    );
    final transport = _DownloadTransport(_page(brokenEvent, cursor: 1));
    final applier = DriftRemoteEventApplier.scoped(target, accountId: _account);
    final diagnostics = _RecordingDiagnostics();

    final result = await DownloadAndApplyEvents(transport, applier)(
      null,
      diagnostics: diagnostics,
    );
    final ack = await AcknowledgeAppliedCursor(transport, applier)(
      diagnostics: diagnostics,
    );

    expect(result.code, SyncStatusCode.conflict);
    expect(result.protocolCode, 'remote-payload-shape-invalid');
    expect(result.sanitizedExceptionClass, 'payload-shape-failure');
    expect(ack, isNull);
    expect(transport.acknowledgements, 0);
    expect(await _counts(target), {
      'stores': 0,
      'products': 0,
      'purchases': 0,
      'items': 0,
      'inbox': 0,
      'state': 0,
    });
    final localApply = diagnostics.events.lastWhere(
      (event) => event.phase == 'download-local-apply',
    );
    expect(localApply.trustedResponseState, 'received');
    expect(localApply.localMutationState, 'rolled-back');
    expect(localApply.sanitizedExceptionClass, 'payload-shape-failure');
  });
}

const _account = AccountId('11111111-1111-4111-8111-111111111111');
const _sourceDevice = DeviceId('22222222-2222-4222-8222-222222222222');
const _targetDevice = DeviceId('33333333-3333-4333-8333-333333333333');

Future<Map<String, Object?>> _sourceEvent(
  LocalDatabase db, {
  required int sequence,
}) async {
  await _register(db, deviceId: _sourceDevice);
  final rows = await db.select(db.syncEvents).get();
  return jsonDecode(rows.last.payloadJson) as Map<String, Object?>;
}

Future<void> _register(
  LocalDatabase db, {
  required DeviceId deviceId,
  String productName = 'Synthetic rice',
  String productCode = 'RICE-001',
  int occurrenceMinute = 0,
}) async {
  final device = await LocalDeviceIdentityRepository(
    db,
  ).loadOrCreateDeviceId(_account);
  await LocalPurchaseRepository(db).registerPurchase(
    _command(
      deviceId.value == _sourceDevice.value ? device : deviceId,
      productName: productName,
      productCode: productCode,
      occurrenceMinute: occurrenceMinute,
    ),
  );
}

RegisterPurchaseCommand _command(
  DeviceId deviceId, {
  required String productName,
  required String productCode,
  required int occurrenceMinute,
}) {
  return RegisterPurchaseCommand(
    accountId: _account,
    deviceId: deviceId,
    storeName: 'test-store',
    occurrenceTime: DateTime.utc(2026, 7, 14, 12, occurrenceMinute),
    currencyCode: 'BRL',
    items: [
      PurchaseItemDraft(
        productReference: NewProductReference(
          ProductDraft(
            userCode: productCode,
            name: productName,
            brand: 'Fixture',
            mode: ProductMode.packaged,
            measurementKind: MeasurementKind.mass,
            packageAmount: '1',
            packageUnit: 'kg',
          ),
        ),
        packageCount: 1,
        purchasedQuantity: NormalizedQuantity.fromDecimalString(
          kind: MeasurementKind.mass,
          unit: CanonicalUnit.kg,
          decimal: '1',
        ),
        lineTotal: const Money(currencyCode: 'BRL', minorUnits: 1299),
      ),
    ],
  );
}

DownloadPage _page(Map<String, Object?> event, {required int cursor}) {
  return DownloadPage(
    nextCursor: 'c10b:$cursor',
    events: [DownloadedEvent(event: event, serverCursor: 'c10b:$cursor')],
  );
}

Map<String, Object?> _event({
  required String eventId,
  required String purchaseId,
  required String storeId,
  required String productId,
  required String productCode,
  required String productName,
  required String productBrand,
  required int cursor,
  String? itemPurchaseId,
}) {
  final product = Product(
    id: ProductId(productId),
    accountId: _account,
    userProductCode: normalizeProductCode(productCode),
    normalizationVersion: productNormalizationVersion,
    displayName: productName,
    displayBrand: productBrand,
    normalizedName: normalizeSemanticIdentityText(productName),
    normalizedBrand: normalizeSemanticIdentityText(productBrand),
    mode: ProductMode.packaged,
    measurementKind: MeasurementKind.mass,
    packageQuantity: NormalizedQuantity.fromDecimalString(
      kind: MeasurementKind.mass,
      unit: CanonicalUnit.kg,
      decimal: '1',
    ),
  );
  final content = <String, Object?>{
    'eventId': eventId,
    'accountId': _account.value,
    'deviceId': _sourceDevice.value,
    'deviceSequence': cursor,
    'eventType': 'purchase.registered',
    'payloadVersion': 3,
    'occurrenceTime': DateTime.utc(2026, 7, 14, 12, cursor).toIso8601String(),
    'payload': {
      'purchase': {
        'id': purchaseId,
        'accountId': _account.value,
        'store': {
          'id': storeId,
          'accountId': _account.value,
          'displayName': 'test-store',
        },
        'personId': null,
        'paymentMethodId': null,
        'occurrenceTime': DateTime.utc(
          2026,
          7,
          14,
          12,
          cursor,
        ).toIso8601String(),
        'currencyCode': 'BRL',
        'totalMinorUnits': 1299,
        'items': [
          {
            'id': 'item-$eventId',
            'purchaseId': itemPurchaseId ?? purchaseId,
            'productId': productId,
            'packageCount': 1,
            'purchasedQuantity': {
              'kind': 'MASS',
              'unit': 'KG',
              'amount': '1.000000',
              'scale': 6,
            },
            'lineTotal': {'currencyCode': 'BRL', 'minorUnits': 1299},
          },
        ],
      },
      'productSnapshots': [product.toJson()],
    },
  };
  return {...content, 'contentHash': canonicalUtf8Sha256(content)};
}

Future<Map<String, int>> _counts(LocalDatabase db) async {
  return {
    'stores': (await db.select(db.stores).get()).length,
    'products': (await db.select(db.products).get()).length,
    'purchases': (await db.select(db.purchases).get()).length,
    'items': (await db.select(db.purchaseItems).get()).length,
    'inbox': (await db.select(db.syncInbox).get()).length,
    'state': (await db.select(db.syncState).get()).length,
  };
}

final class _DownloadTransport implements SyncTransport {
  _DownloadTransport(this.page);

  final DownloadPage page;
  var acknowledgements = 0;

  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) async {
    acknowledgements++;
    return const SyncResult(
      code: SyncStatusCode.acknowledged,
      outcome: SyncOutcome.applied,
      retryable: false,
    );
  }

  @override
  Future<DownloadPage> downloadAfter(
    String? cursor, {
    required int limit,
  }) async {
    return page;
  }

  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) {
    throw UnimplementedError();
  }
}

final class _RecordingDiagnostics implements SyncDiagnosticPhaseRecorder {
  final events = <SyncDiagnosticPhaseEvidence>[];
  var _ordinal = 0;

  @override
  Future<SyncDiagnosticChildIdentity> recordPhase(
    SyncDiagnosticPhaseEvidence evidence,
  ) async {
    events.add(evidence);
    _ordinal++;
    return SyncDiagnosticChildIdentity(
      correlationId: 'correlation-$_ordinal',
      correlationFingerprint: 'corr$_ordinal',
      ordinal: _ordinal,
    );
  }
}
