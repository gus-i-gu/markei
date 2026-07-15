import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/register_purchase.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_device_identity_repository.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';

void main() {
  const accountId = AccountId('local-account');
  final uuidV4 = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
  );

  test('creates a database-owned UUID v4 device identity', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);

    final deviceId = await LocalDeviceIdentityRepository(
      db,
    ).loadOrCreateDeviceId(accountId);

    expect(deviceId.value, matches(uuidV4));
    expect(deviceId.value, isNot('windows-device'));
  });

  test('reuses the same device identity after close and reopen', () async {
    final temp = await Directory.systemTemp.createTemp('markei_device_');
    addTearDown(() => temp.delete(recursive: true));
    final file = File('${temp.path}/markei.sqlite');

    final firstDb = LocalDatabase.file(file);
    final firstDeviceId = await LocalDeviceIdentityRepository(
      firstDb,
    ).loadOrCreateDeviceId(accountId);
    await firstDb.close();

    final reopenedDb = LocalDatabase.file(file);
    addTearDown(reopenedDb.close);
    final reopenedDeviceId = await LocalDeviceIdentityRepository(
      reopenedDb,
    ).loadOrCreateDeviceId(accountId);

    expect(reopenedDeviceId.value, firstDeviceId.value);
  });

  test(
    'different fresh databases receive different device identities',
    () async {
      final firstDb = LocalDatabase.memory();
      final firstDeviceId = await LocalDeviceIdentityRepository(
        firstDb,
      ).loadOrCreateDeviceId(accountId);
      await firstDb.close();

      final secondDb = LocalDatabase.memory();
      addTearDown(secondDb.close);
      final secondDeviceId = await LocalDeviceIdentityRepository(
        secondDb,
      ).loadOrCreateDeviceId(accountId);

      expect(firstDeviceId.value, isNot(secondDeviceId.value));
    },
  );

  test(
    'device sequence remains monotonic for the persisted identity',
    () async {
      final temp = await Directory.systemTemp.createTemp('markei_device_seq_');
      addTearDown(() => temp.delete(recursive: true));
      final file = File('${temp.path}/markei.sqlite');

      final firstDb = LocalDatabase.file(file);
      final firstDeviceId = await LocalDeviceIdentityRepository(
        firstDb,
      ).loadOrCreateDeviceId(accountId);
      final firstResult = await LocalPurchaseRepository(
        firstDb,
      ).registerPurchase(_command(firstDeviceId, 'LEITE-001'));
      await firstDb.close();

      final reopenedDb = LocalDatabase.file(file);
      addTearDown(reopenedDb.close);
      final reopenedDeviceId = await LocalDeviceIdentityRepository(
        reopenedDb,
      ).loadOrCreateDeviceId(accountId);
      final secondResult = await LocalPurchaseRepository(
        reopenedDb,
      ).registerPurchase(_command(reopenedDeviceId, 'LEITE-002'));

      expect(reopenedDeviceId.value, firstDeviceId.value);
      expect(firstResult.deviceSequence, 1);
      expect(secondResult.deviceSequence, 2);
    },
  );

  test('historical non-UUID devices are preserved but not reused', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final now = DateTime.utc(2026, 7, 12);
    await db
        .into(db.localAccounts)
        .insert(
          LocalAccountsCompanion.insert(
            id: accountId.value,
            defaultCurrencyCode: 'BRL',
            createdAt: now,
          ),
        );
    await db
        .into(db.devices)
        .insert(
          DevicesCompanion.insert(
            id: 'windows-device',
            accountId: accountId.value,
            nextSequence: 7,
            createdAt: now,
          ),
        );

    final deviceId = await LocalDeviceIdentityRepository(
      db,
    ).loadOrCreateDeviceId(accountId);

    final rows = await db.select(db.devices).get();
    expect(deviceId.value, matches(uuidV4));
    expect(rows.map((row) => row.id), contains('windows-device'));
    expect(rows, hasLength(2));
  });

  test('ambiguous UUID devices fail without selecting earliest', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final now = DateTime.utc(2026, 7, 12);
    await db
        .into(db.localAccounts)
        .insert(
          LocalAccountsCompanion.insert(
            id: accountId.value,
            defaultCurrencyCode: 'BRL',
            createdAt: now,
          ),
        );
    for (final id in [
      '22222222-2222-4222-8222-222222222222',
      '33333333-3333-4333-8333-333333333333',
    ]) {
      await db
          .into(db.devices)
          .insert(
            DevicesCompanion.insert(
              id: id,
              accountId: accountId.value,
              nextSequence: 1,
              createdAt: now,
            ),
          );
    }

    await expectLater(
      LocalDeviceIdentityRepository(db).loadOrCreateDeviceId(accountId),
      throwsA(isA<StateError>()),
    );
  });
}

RegisterPurchaseCommand _command(DeviceId deviceId, String productCode) {
  return RegisterPurchaseCommand(
    accountId: const AccountId('local-account'),
    deviceId: deviceId,
    storeName: 'Mercado Central',
    occurrenceTime: DateTime.utc(2026, 7, 12, 10),
    currencyCode: 'BRL',
    items: [
      PurchaseItemDraft(
        productReference: NewProductReference(
          ProductDraft(
            userCode: productCode,
            name: 'Leite Integral',
            brand: 'Marca A',
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
        lineTotal: const Money(currencyCode: 'BRL', minorUnits: 499),
      ),
    ],
  );
}
