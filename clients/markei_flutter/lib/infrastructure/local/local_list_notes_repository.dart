import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../application/list_notes.dart';
import '../../domain/shared/ids.dart';
import '../../domain/sync/canonical_json.dart';
import 'local_database.dart';
import 'local_query_repository.dart';

final class LocalListNotesRepository implements ListNotesRepository {
  const LocalListNotesRepository(this.db);
  final LocalDatabase db;

  @override
  Future<Map<String, List<ListNoteRevision>>> read(AccountId accountId) async {
    final rows = await db
        .customSelect(
          'SELECT * FROM list_note_revisions WHERE account_id = ?',
          variables: [Variable(accountId.value)],
        )
        .get();
    final grouped = <String, List<ListNoteRevision>>{};
    for (final row in rows) {
      final productId = row.read<String>('product_id');
      grouped
          .putIfAbsent(productId, () => [])
          .add(
            ListNoteRevision(
              id: row.read<String>('event_id'),
              productId: productId,
              note: row.read<String>('note'),
              tags: (jsonDecode(row.read<String>('tags_json')) as List)
                  .cast<String>(),
              replaces: (jsonDecode(row.read<String>('replaces_json')) as List)
                  .cast<String>(),
            ),
          );
    }
    return {
      for (final entry in grouped.entries)
        entry.key: activeListNotes(entry.value),
    };
  }

  @override
  Future<void> save({
    required AccountId accountId,
    required DeviceId deviceId,
    required ProductId productId,
    required String note,
    required List<String> tags,
    required Set<String> observedRevisionIds,
  }) async {
    final trimmed = note.trim();
    if (trimmed.length > 2000) {
      throw const FormatException('Keep the note within 2,000 characters.');
    }
    final normalizedTags = normalizeListTags(tags);
    if (observedRevisionIds.length > 100) {
      throw const FormatException(
        'Too many concurrent edits. Sync and resolve them first.',
      );
    }
    await db.transaction(() async {
      final product = (await LocalQueryRepository(db).listProducts(
        accountId,
      )).where((p) => p.id.value == productId.value).firstOrNull;
      if (product == null) {
        throw const FormatException(
          'This product is no longer available in this Account.',
        );
      }
      final now = DateTime.now().toUtc();
      await db
          .into(db.devices)
          .insert(
            DevicesCompanion.insert(
              id: deviceId.value,
              accountId: accountId.value,
              nextSequence: 1,
              createdAt: now,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      final device = await (db.select(
        db.devices,
      )..where((t) => t.id.equals(deviceId.value))).getSingle();
      if (device.accountId != accountId.value) {
        throw StateError('device-account-mismatch');
      }
      final eventId = const Uuid().v4();
      final revision = {
        'id': eventId,
        'productId': productId.value,
        'note': trimmed,
        'tags': normalizedTags,
        'replaces': observedRevisionIds.toList()..sort(),
      };
      final content = <String, Object?>{
        'eventId': eventId,
        'accountId': accountId.value,
        'deviceId': deviceId.value,
        'deviceSequence': device.nextSequence,
        'eventType': listNoteEventType,
        'payloadVersion': 1,
        'occurrenceTime': now.toIso8601String(),
        'payload': {
          'listNote': revision,
          'productSnapshots': [product.toJson()],
        },
      };
      final hash = canonicalUtf8Sha256(content);
      await (db.update(
        db.devices,
      )..where((t) => t.id.equals(deviceId.value))).write(
        DevicesCompanion(nextSequence: Value(device.nextSequence + 1)),
      );
      await insertListNoteRevision(
        db,
        accountId.value,
        productId.value,
        revision,
      );
      await db
          .into(db.syncEvents)
          .insert(
            SyncEventsCompanion.insert(
              id: eventId,
              accountId: accountId.value,
              deviceId: deviceId.value,
              deviceSequence: device.nextSequence,
              eventType: listNoteEventType,
              payloadVersion: 1,
              occurrenceTime: now,
              payloadJson: canonicalJson({...content, 'contentHash': hash}),
              contentHash: hash,
              createdAt: now,
            ),
          );
      await db
          .into(db.pendingEvents)
          .insert(
            PendingEventsCompanion.insert(
              eventId: eventId,
              state: 'pending',
              enqueuedAt: now,
            ),
          );
    });
  }
}

Future<void> insertListNoteRevision(
  LocalDatabase db,
  String accountId,
  String productId,
  Map<String, Object?> revision,
) async {
  final id = revision['id'];
  final note = revision['note'];
  final tags = revision['tags'];
  final replaces = revision['replaces'];
  if (id is! String ||
      note is! String ||
      note.length > 2000 ||
      tags is! List ||
      tags.any((tag) => tag is! String) ||
      replaces is! List ||
      replaces.length > 100 ||
      replaces.any((value) => value is! String || value == id)) {
    throw const FormatException('Invalid list note revision.');
  }
  final normalizedTags = normalizeListTags(tags.cast<String>());
  await db.customStatement(
    'INSERT INTO list_note_revisions(account_id,event_id,product_id,note,tags_json,replaces_json) VALUES(?,?,?,?,?,?) ON CONFLICT(account_id,event_id) DO NOTHING',
    [
      accountId,
      id,
      productId,
      note,
      jsonEncode(normalizedTags),
      jsonEncode(replaces),
    ],
  );
}
