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

      final metadata = await _db.select(_db.installationMetadata).get();
      if (metadata.isNotEmpty) {
        final current = metadata.single;
        if (current.accountId != accountId.value) {
          throw StateError('Current Installation belongs to another Account.');
        }
        final device =
            await (_db.select(_db.devices)..where(
                  (table) =>
                      table.id.equals(current.currentDeviceId) &
                      table.accountId.equals(accountId.value),
                ))
                .getSingleOrNull();
        if (device == null) {
          throw StateError('Current Installation references a missing Device.');
        }
        return DeviceId(device.id);
      }

      final devices = await (_db.select(
        _db.devices,
      )..where((table) => table.accountId.equals(accountId.value))).get();
      final usable = devices
          .where((device) => _uuidV4Pattern.hasMatch(device.id))
          .toList(growable: false);
      if (usable.length > 1) {
        throw StateError('Ambiguous current Device; no Device was selected.');
      }
      if (usable.length == 1) {
        await _db
            .into(_db.installationMetadata)
            .insert(
              InstallationMetadataCompanion.insert(
                id: 'current',
                accountId: accountId.value,
                currentDeviceId: usable.single.id,
                createdAt: now,
                updatedAt: now,
              ),
            );
        return DeviceId(usable.single.id);
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
      await _db
          .into(_db.installationMetadata)
          .insert(
            InstallationMetadataCompanion.insert(
              id: 'current',
              accountId: accountId.value,
              currentDeviceId: deviceId.value,
              createdAt: now,
              updatedAt: now,
            ),
          );
      return deviceId;
    });
  }
}

final _uuidV4Pattern = RegExp(
  r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
);
