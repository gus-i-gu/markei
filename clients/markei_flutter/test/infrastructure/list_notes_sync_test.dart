import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/list_notes.dart';
import 'package:markei/application/sync/sync_ports.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/domain/sync/canonical_json.dart';
import 'package:markei/domain/sync/sync_event.dart';
import 'package:markei/infrastructure/local/local_database.dart'
    hide Product, RecoveryChunk, RecoverySession;
import 'package:markei/infrastructure/local/local_list_notes_repository.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';
import 'package:markei/infrastructure/local/sync/local_recovery_repositories.dart';
import 'package:markei/infrastructure/local/sync/local_sync_repositories.dart';
import 'package:markei/infrastructure/local/sync/remote_purchase_event_applier.dart';

const account = AccountId('11111111-1111-4111-8111-111111111111');
const deviceA = DeviceId('22222222-2222-4222-8222-222222222222');
const deviceB = DeviceId('33333333-3333-4333-8333-333333333333');

void main() {
  test(
    'notes queue atomically, share product facts and replay without duplicates',
    () async {
      final a = LocalDatabase.memory();
      final b = LocalDatabase.memory();
      addTearDown(a.close);
      addTearDown(b.close);
      final product = await seed(a);
      await save(
        a,
        product.id,
        'Bring coffee',
        ['@Alex', '#Debit'],
        {},
        deviceA,
      );
      final event = await lastEvent(a);
      final pending = await a.select(a.pendingEvents).get();
      expect(pending.single.state, 'pending');
      final submission = await DriftSyncOutboxRepository.scoped(
        a,
        accountId: account,
        deviceId: deviceA,
      ).leasePending(limit: 25);
      expect(submission!.events.single['eventType'], listNoteEventType);
      expect((await a.select(a.devices).get()).single.nextSequence, 2);
      final applier = DriftRemoteEventApplier.scoped(b, accountId: account);
      expect(
        (await applier.applyPage(page([event], 1))).outcome,
        SyncOutcome.applied,
      );
      final notes = await LocalListNotesRepository(b).read(account);
      expect(notes[product.id.value]!.single.note, 'Bring coffee');
      expect(notes[product.id.value]!.single.tags, ['@Alex', '#Debit']);
      expect(await b.select(b.products).get(), hasLength(1));
      expect(
        (await applier.applyPage(page([event], 1))).outcome,
        SyncOutcome.duplicateEquivalent,
      );
      expect(await b.select(b.syncInbox).get(), hasLength(1));
      expect(
        await LocalListNotesRepository(
          b,
        ).read(const AccountId('other-account')),
        isEmpty,
      );
      final wrong = LocalDatabase.memory();
      addTearDown(wrong.close);
      expect(
        (await DriftRemoteEventApplier.scoped(
          wrong,
          accountId: const AccountId('other-account'),
        ).applyPage(page([event], 1))).outcome,
        SyncOutcome.notApplied,
      );
      expect(await wrong.select(wrong.products).get(), isEmpty);
    },
  );

  test(
    'concurrent offline edits survive on both peers and explicit merge converges',
    () async {
      final a = LocalDatabase.memory();
      final b = LocalDatabase.memory();
      addTearDown(a.close);
      addTearDown(b.close);
      final product = await seed(a);
      await save(a, product.id, 'First', [], {}, deviceA);
      final first = await lastEvent(a);
      final applyA = DriftRemoteEventApplier.scoped(a, accountId: account);
      final applyB = DriftRemoteEventApplier.scoped(b, accountId: account);
      await applyA.applyPage(page([first], 1));
      await applyB.applyPage(page([first], 1));
      final parents = {first['eventId'] as String};
      await save(a, product.id, 'Windows edit', ['@Alex'], parents, deviceA);
      await save(b, product.id, 'Android edit', ['#Card'], parents, deviceB);
      final edits = [await lastEvent(a), await lastEvent(b)];
      expect(
        (await applyA.applyPage(page(edits, 2))).outcome,
        SyncOutcome.applied,
      );
      expect(
        (await applyB.applyPage(page(edits, 2))).outcome,
        SyncOutcome.applied,
      );
      final before = (await LocalListNotesRepository(
        a,
      ).read(account))[product.id.value]!;
      expect(before.map((r) => r.note).toSet(), {
        'Windows edit',
        'Android edit',
      });
      await save(
        a,
        product.id,
        'Combined',
        ['@Alex', '#Card'],
        before.map((r) => r.id).toSet(),
        deviceA,
      );
      final combined = await lastEvent(a);
      await applyB.applyPage(page([combined], 4));
      expect(
        (await LocalListNotesRepository(
          a,
        ).read(account))[product.id.value]!.single.note,
        'Combined',
      );
      expect(
        (await LocalListNotesRepository(
          b,
        ).read(account))[product.id.value]!.single.note,
        'Combined',
      );
      await save(b, product.id, '', [], {
        combined['eventId'] as String,
      }, deviceB);
      await applyA.applyPage(page([combined, await lastEvent(b)], 4));
      expect(
        (await LocalListNotesRepository(
          a,
        ).read(account))[product.id.value]!.single.note,
        isEmpty,
      );
    },
  );

  test(
    'malformed note rolls back product, cursor and inbox; snapshot restores notes',
    () async {
      final source = LocalDatabase.memory();
      final target = LocalDatabase.memory();
      addTearDown(source.close);
      addTearDown(target.close);
      final product = await seed(source);
      await save(source, product.id, 'Café', ['@Alex'], {}, deviceA);
      final event = await lastEvent(source);
      final malformed = jsonDecode(jsonEncode(event)) as Map<String, Object?>;
      ((malformed['payload'] as Map)['listNote'] as Map)['tags'] = [42];
      final content = {...malformed}..remove('contentHash');
      malformed['contentHash'] = canonicalUtf8Sha256(content);
      final failed = await DriftRemoteEventApplier.scoped(
        target,
        accountId: account,
      ).applyPage(page([malformed], 1));
      expect(failed.outcome, SyncOutcome.notApplied);
      expect(await target.select(target.products).get(), isEmpty);
      expect(await target.select(target.syncInbox).get(), isEmpty);
      expect(await target.select(target.syncState).get(), isEmpty);
      final payload = event['payload'] as Map<String, Object?>;
      final bytes = utf8.encode(
        jsonEncode({
          'account': {'id': account.value, 'defaultCurrencyCode': 'BRL'},
          'stores': [],
          'products': payload['productSnapshots'],
          'purchases': [],
          'purchaseItems': [],
          'listNotes': [payload['listNote']],
        }),
      );
      final hash = sha256.convert(bytes).toString();
      final restored = await DriftSnapshotFactApplier(target)
          .applySnapshotFacts(
            manifest: RecoveryManifest(
              accountId: account.value,
              snapshotId: 'snapshot-notes',
              formatVersion: 2,
              coveredThroughCursor: 'c10b:1',
              chunks: [
                RecoveryChunkDescriptor(
                  index: 0,
                  length: bytes.length,
                  hash: hash,
                ),
              ],
              totalBytes: bytes.length,
              totalHash: hash,
              manifestHash: 'fixture',
            ),
            chunks: [
              RecoveryChunk(
                index: 0,
                length: bytes.length,
                hash: hash,
                bytes: bytes,
              ),
            ],
          );
      expect(restored.outcome, SyncOutcome.applied);
      expect(
        (await LocalListNotesRepository(
          target,
        ).read(account))[product.id.value]!.single.note,
        'Café',
      );
    },
  );

  test('invalid note leaves device sequence and outbox unchanged', () async {
    final db = LocalDatabase.memory();
    addTearDown(db.close);
    final product = await seed(db);
    await expectLater(
      save(db, product.id, 'x' * 2001, [], {}, deviceA),
      throwsFormatException,
    );
    expect(await db.select(db.syncEvents).get(), isEmpty);
    expect(await db.select(db.devices).get(), isEmpty);
  });
}

Future<Product> seed(LocalDatabase db) =>
    LocalQueryRepository(db).createProduct(
      account,
      const ProductDraft(
        userCode: 'COFFEE',
        name: 'Coffee',
        brand: 'Café',
        mode: ProductMode.bulk,
        measurementKind: MeasurementKind.mass,
      ),
    );
Future<void> save(
  LocalDatabase db,
  ProductId product,
  String text,
  List<String> tags,
  Set<String> parents,
  DeviceId device,
) => LocalListNotesRepository(db).save(
  accountId: account,
  deviceId: device,
  productId: product,
  note: text,
  tags: tags,
  observedRevisionIds: parents,
);
Future<Map<String, Object?>> lastEvent(LocalDatabase db) async =>
    jsonDecode((await db.select(db.syncEvents).get()).last.payloadJson)
        as Map<String, Object?>;
DownloadPage page(List<Map<String, Object?>> events, int start) => DownloadPage(
  nextCursor: 'c10b:${start + events.length - 1}',
  events: [
    for (var i = 0; i < events.length; i++)
      DownloadedEvent(event: events[i], serverCursor: 'c10b:${start + i}'),
  ],
);
