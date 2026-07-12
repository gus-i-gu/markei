import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../domain/shared/ids.dart';
import 'local_database.dart';

class LocalDeviceIdentityRepository {
  LocalDeviceIdentityRepository(this._db, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  final LocalDatabase _db;
  final Uuid _uuid;

  Future<DeviceId> loadOrCreateDeviceId(AccountId accountId) {
    return _db.transaction(() async {
      final now = DateTime.now().toUtc();
      await _db
          .into(_db.localAccounts)
          .insert(
            LocalAccountsCompanion.insert(
              id: accountId.value,
              defaultCurrencyCode: 'BRL',
              createdAt: now,
            ),
            mode: InsertMode.insertOrIgnore,
          );

      final devices =
          await (_db.select(_db.devices)
                ..where((table) => table.accountId.equals(accountId.value))
                ..orderBy([(table) => OrderingTerm.asc(table.createdAt)])
                ..limit(20))
              .get();
      Device? existing;
      for (final device in devices) {
        if (_uuidV4Pattern.hasMatch(device.id)) {
          existing = device;
          break;
        }
      }
      if (existing != null) {
        return DeviceId(existing.id);
      }

      final deviceId = DeviceId(_uuid.v4());
      await _db
          .into(_db.devices)
          .insert(
            DevicesCompanion.insert(
              id: deviceId.value,
              accountId: accountId.value,
              nextSequence: 1,
              createdAt: now,
            ),
          );
      return deviceId;
    });
  }
}

final _uuidV4Pattern = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
);
