import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_user_data_access.dart';

void main() {
  const account = AccountId('account-a');
  const otherAccount = AccountId('account-b');
  final now = DateTime.utc(2026, 10, 7, 15, 12, 30);
  late LocalDatabase db;
  late LocalUserDataAccessRepository repository;

  setUp(() {
    db = LocalDatabase.memory();
    repository = LocalUserDataAccessRepository(db, clock: () => now);
  });
  tearDown(() => db.close());

  test(
    'empty Account export and inventory do not create business records',
    () async {
      final exported = await repository.exportAccountData(account);
      final document = _document(exported.jsonBytes);
      final inventory = await repository.inventory(account);
      expect(inventory.totalRecords, 0);
      expect(exported.inventory.totalRecords, 0);
      expect(inventory.counts, exported.inventory.counts);
      expect(inventory.counts, hasLength(21));
      expect(document['generated_at_utc'], '2026-10-07T15:12:30.000Z');
      expect(document['local_schema_version'], 14);
      expect(await db.select(db.localAccounts).get(), isEmpty);
      expect(await db.select(db.devices).get(), isEmpty);
      expect(await db.select(db.hostedAuthStates).get(), isEmpty);
      expect(await db.select(db.migrationLedger).get(), hasLength(1));
    },
  );

  test(
    'access report contains complete local business fields and Account-scoped metadata',
    () async {
      await _seed(db, 'a');
      await _seed(db, 'b');
      final exported = await repository.exportAccountData(account);
      final document = _document(exported.jsonBytes);
      final data = document['datasets'] as Map<String, dynamic>;
      expect(document['format'], 'marc-local-account-access');
      expect(document['format_version'], 1);
      expect(document['account_id'], account.value);
      expect(exported.inventory.totalRecords, 21);
      expect(exported.inventory.counts.values, everyElement(1));
      expect(
        (await repository.inventory(account)).counts,
        exported.inventory.counts,
      );
      final purchase = (data['purchases'] as List).single as Map;
      expect(purchase['total_minor_units'], 1234);
      expect(purchase['currency_code'], 'BRL');
      expect(purchase['person_id'], 'person-a');
      expect(purchase['payment_method_id'], 'payment-a');
      expect(purchase['occurrence_time'], '2026-10-01T10:20:30.000Z');
      final item = (data['purchase_items'] as List).single as Map;
      expect(item['purchased_amount'], '1.500000');
      expect(item['purchased_unit'], 'KG');
      expect(item['package_count'], isNull);
      final person = (data['people'] as List).single as Map;
      expect(person['active'], false);
      expect(person['nickname'], 'Archived person a');
      expect(person['archived_at'], '2026-10-01T10:20:30.000Z');
      final note = (data['list_note_revisions'] as List).single as Map;
      expect(note['note'], 'User note a');
      expect(note['tags'], ['@person-a', '#payment-a']);
      expect(note['replaces'], ['previous-a']);
      expect(note.containsKey('tags_json'), false);
      expect(note.containsKey('replaces_json'), false);
      final bytesText = utf8.decode(exported.jsonBytes);
      expect(bytesText, isNot(contains('account-b')));
      expect(bytesText, isNot(contains('product-b')));
      expect(bytesText, isNot(contains('User note b')));
      expect(bytesText, isNot(contains('secret-auth-state')));
      expect(bytesText, isNot(contains('secret-queue-payload')));
      expect(bytesText, isNot(contains('secret-recovery-content')));
      expect(bytesText, isNot(contains('secret-exception')));
      expect(bytesText, isNot(contains('secret-native-code')));
      expect(bytesText, isNot(contains('secret-correlation')));
      expect(data.containsKey('hosted_auth_states'), false);
      expect(data.containsKey('migration_ledger'), false);
      expect(
        (data['sync_events'] as List).single,
        isNot(contains('payload_json')),
      );
      expect(
        (data['recovery_chunks'] as List).single,
        isNot(contains('bytes')),
      );
      final limitations = document['limitations'] as List;
      expect(limitations.join(' '), contains('session-only saved Analytics'));
      expect(limitations.join(' '), contains('Hosted service and Auth0'));
      expect(
        (document['field_conventions'] as Map)['money'],
        contains('Integer minor units'),
      );
      // Reads neither change the queue nor erase the separately stored identity.
      expect(await db.select(db.pendingEvents).get(), hasLength(2));
      expect(await db.select(db.hostedAuthStates).get(), hasLength(2));
      expect(await db.select(db.purchaseItems).get(), hasLength(2));
    },
  );

  test('relational rows require both sides of an Account boundary', () async {
    await _seed(db, 'a');
    await _seed(db, 'b');
    // These cross-Account relations satisfy ordinary SQLite FKs, so scope must
    // be proven through both parents, not merely one owning row.
    await db.customStatement(
      '''INSERT INTO purchase_items
      (id,purchase_id,product_id,measurement_kind,purchased_amount,purchased_unit,currency_code,line_total_minor_units)
      VALUES ('cross-item','purchase-a','product-b','MASS','9.000000','KG','BRL',900)''',
    );
    await db.customStatement('''INSERT INTO sync_submission_events
      (submission_id,event_id,position) VALUES ('submission-a','event-b',1)''');
    await db.customStatement(
      '''INSERT INTO list_note_revisions
      (account_id,event_id,product_id,note,tags_json,replaces_json)
      VALUES ('account-a','cross-note','product-b','Foreign product note','[]','[]')''',
    );
    await db.customStatement(
      "UPDATE payment_methods SET assigned_person_id = 'person-b' WHERE id = 'payment-a'",
    );
    await db.customStatement(
      "UPDATE purchases SET person_id = 'person-b', payment_method_id = 'payment-b' WHERE id = 'purchase-a'",
    );
    final document = _document(
      (await repository.exportAccountData(account)).jsonBytes,
    );
    final data = document['datasets'] as Map<String, dynamic>;
    expect(data['purchase_items'], hasLength(1));
    expect(data['sync_submission_events'], hasLength(1));
    expect(data['list_note_revisions'], hasLength(1));
    expect(
      (data['payment_methods'] as List).single['assigned_person_id'],
      isNull,
    );
    expect((data['purchases'] as List).single['person_id'], isNull);
    expect((data['purchases'] as List).single['payment_method_id'], isNull);
    expect(
      (data['recovery_chunks'] as List).single['session_id'],
      'recovery-a',
    );
    expect((data['pending_events'] as List).single['event_id'], 'event-a');
    expect(jsonEncode(document), isNot(contains('Foreign product note')));
    expect(jsonEncode(document), isNot(contains('person-b')));
  });

  test(
    'clearing local diagnostics is scoped, preserves records and is idempotent',
    () async {
      await _seed(db, 'a');
      await _seed(db, 'b');
      final before = _document(
        (await repository.exportAccountData(account)).jsonBytes,
      );
      final cleared = await repository.clearLocalDiagnostics(account);
      expect(cleared.attemptsRemoved, 1);
      expect(cleared.diagnosticEventsRemoved, 1);
      final after = _document(
        (await repository.exportAccountData(account)).jsonBytes,
      );
      final beforeData = before['datasets'] as Map<String, dynamic>;
      final afterData = after['datasets'] as Map<String, dynamic>;
      for (final name in beforeData.keys.where(
        (name) => name != 'sync_attempts' && name != 'sync_diagnostic_events',
      )) {
        expect(
          afterData[name],
          beforeData[name],
          reason: '$name must be preserved',
        );
      }
      expect(afterData['sync_attempts'], isEmpty);
      expect(afterData['sync_diagnostic_events'], isEmpty);
      final foreignInventory = await repository.inventory(otherAccount);
      expect(foreignInventory.count('sync_attempts'), 1);
      expect(foreignInventory.count('sync_diagnostic_events'), 1);
      expect(await db.select(db.hostedAuthStates).get(), hasLength(2));
      expect(await db.select(db.syncState).get(), hasLength(2));
      final repeat = await repository.clearLocalDiagnostics(account);
      expect(repeat.attemptsRemoved, 0);
      expect(repeat.diagnosticEventsRemoved, 0);
    },
  );

  test('failed diagnostic clear rolls back its child deletion', () async {
    await _seed(db, 'a');
    await db.customStatement(
      '''CREATE TRIGGER prevent_attempt_delete BEFORE DELETE ON sync_attempts
      BEGIN SELECT RAISE(ABORT, 'fixture deletion failure'); END''',
    );
    await expectLater(
      repository.clearLocalDiagnostics(account),
      throwsA(isA<Exception>()),
    );
    final inventory = await repository.inventory(account);
    expect(inventory.count('sync_attempts'), 1);
    expect(inventory.count('sync_diagnostic_events'), 1);
    expect(inventory.count('pending_events'), 1);
    expect(await db.select(db.hostedAuthStates).get(), hasLength(1));
  });

  test(
    'malformed stored note prevents a partial JSON export and leaves data unchanged',
    () async {
      await _seed(db, 'a');
      await db.customStatement(
        "UPDATE list_note_revisions SET tags_json = 'not valid json' WHERE account_id = 'account-a'",
      );
      await expectLater(
        repository.exportAccountData(account),
        throwsFormatException,
      );
      expect((await repository.inventory(account)).totalRecords, 21);
      expect(await db.select(db.pendingEvents).get(), hasLength(1));
      expect(await db.select(db.purchases).get(), hasLength(1));
    },
  );
}

Map<String, dynamic> _document(List<int> bytes) =>
    jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;

Future<void> _seed(LocalDatabase db, String suffix) async {
  final stamp =
      DateTime.utc(2026, 10, 1, 10, 20, 30).millisecondsSinceEpoch ~/ 1000;
  final account = 'account-$suffix';
  Future<void> insert(
    String table,
    Map<String, Object?> values,
  ) => db.customStatement(
    'INSERT INTO $table (${values.keys.join(',')}) VALUES (${List.filled(values.length, '?').join(',')})',
    values.values.toList(),
  );
  await db.transaction(() async {
    await insert('local_accounts', {
      'id': account,
      'default_currency_code': 'BRL',
      'created_at': stamp,
    });
    await insert('devices', {
      'id': 'device-$suffix',
      'account_id': account,
      'next_sequence': 2,
      'created_at': stamp,
    });
    await insert('products', {
      'id': 'product-$suffix',
      'account_id': account,
      'user_product_code': 'RICE',
      'normalized_user_product_code': 'rice',
      'normalization_version': 1,
      'display_name': 'Rice $suffix',
      'display_brand': 'Brand $suffix',
      'normalized_name': 'rice $suffix',
      'normalized_brand': 'brand $suffix',
      'mode': 'BULK',
      'measurement_kind': 'MASS',
      'package_amount': null,
      'package_unit': null,
      'exact_identity_key': 'rice-key-$suffix',
      'created_at': stamp,
    });
    await insert('stores', {
      'id': 'store-$suffix',
      'account_id': account,
      'display_name': 'Market $suffix',
      'created_at': stamp,
    });
    await insert('people', {
      'id': 'person-$suffix',
      'account_id': account,
      'visible_code': '@001',
      'nickname': 'Archived person $suffix',
      'normalized_nickname': 'person $suffix',
      'active': 0,
      'created_at': stamp,
      'updated_at': stamp,
      'archived_at': stamp,
    });
    await insert('payment_methods', {
      'id': 'payment-$suffix',
      'account_id': account,
      'visible_code': '#001',
      'nickname': 'Cash $suffix',
      'normalized_nickname': 'cash $suffix',
      'active': 1,
      'created_at': stamp,
      'updated_at': stamp,
      'archived_at': null,
      'assigned_person_id': 'person-$suffix',
    });
    await insert('account_preferences', {
      'account_id': account,
      'shortage_threshold_days': 7,
      'next_person_code': 2,
      'next_payment_method_code': 2,
      'updated_at': stamp,
    });
    await insert('purchases', {
      'id': 'purchase-$suffix',
      'account_id': account,
      'store_id': 'store-$suffix',
      'person_id': 'person-$suffix',
      'payment_method_id': 'payment-$suffix',
      'occurrence_time': stamp,
      'currency_code': 'BRL',
      'total_minor_units': 1234,
      'created_at': stamp,
    });
    await insert('purchase_items', {
      'id': 'item-$suffix',
      'purchase_id': 'purchase-$suffix',
      'product_id': 'product-$suffix',
      'package_count': null,
      'measurement_kind': 'MASS',
      'purchased_amount': '1.500000',
      'purchased_unit': 'KG',
      'currency_code': 'BRL',
      'line_total_minor_units': 1234,
    });
    await insert('list_note_revisions', {
      'account_id': account,
      'event_id': 'note-$suffix',
      'product_id': 'product-$suffix',
      'note': 'User note $suffix',
      'tags_json': jsonEncode(['@person-$suffix', '#payment-$suffix']),
      'replaces_json': jsonEncode(['previous-$suffix']),
    });
    await insert('sync_events', {
      'id': 'event-$suffix',
      'account_id': account,
      'device_id': 'device-$suffix',
      'device_sequence': 1,
      'event_type': 'purchase.recorded',
      'payload_version': 3,
      'occurrence_time': stamp,
      'payload_json': '{"private":"secret-queue-payload"}',
      'content_hash': 'hash-$suffix',
      'created_at': stamp,
    });
    await insert('pending_events', {
      'event_id': 'event-$suffix',
      'state': 'pending',
      'enqueued_at': stamp,
    });
    await insert('sync_state', {
      'account_id': account,
      'account_cursor': 'cursor-$suffix',
      'updated_at': stamp,
    });
    await insert('installation_metadata', {
      'id': 'installation-$suffix',
      'account_id': account,
      'current_device_id': 'device-$suffix',
      'created_at': stamp,
      'updated_at': stamp,
    });
    await insert('sync_submissions', {
      'id': 'submission-$suffix',
      'account_id': account,
      'device_id': 'device-$suffix',
      'request_hash': 'request-hash-$suffix',
      'state': 'pending',
      'attempt_count': 1,
      'next_attempt_at': null,
      'lease_until': null,
      'outcome': null,
      'response_code': 'secret-response-code',
      'error_code': 'secret-error-code',
      'created_at': stamp,
      'updated_at': stamp,
    });
    await insert('sync_submission_events', {
      'submission_id': 'submission-$suffix',
      'event_id': 'event-$suffix',
      'position': 0,
    });
    await insert('sync_inbox', {
      'account_id': account,
      'event_id': 'remote-event-$suffix',
      'content_hash': 'remote-hash-$suffix',
      'server_cursor': 'remote-cursor-$suffix',
      'state': 'applied',
      'applied_at': stamp,
    });
    await insert('recovery_sessions', {
      'id': 'recovery-$suffix',
      'account_id': account,
      'snapshot_id': 'snapshot-$suffix',
      'phase': 'downloaded',
      'format_version': 2,
      'manifest_hash': 'manifest-$suffix',
      'covered_through_cursor': 'cursor-$suffix',
      'expires_at': stamp + 3600,
      'updated_at': stamp,
    });
    await insert('recovery_chunks', {
      'session_id': 'recovery-$suffix',
      'chunk_index': 0,
      'byte_length': 23,
      'content_hash': 'chunk-hash-$suffix',
      'bytes': utf8.encode('secret-recovery-content'),
      'verified_at': stamp,
    });
    await insert('hosted_auth_states', {
      'environment_alias': 'secret-auth-state-$suffix',
      'installation_id': 'secret-installation-$suffix',
      'enrollment_request_id': 'secret-enrollment-$suffix',
      'enrollment_state': 'enrolled',
      'account_id': account,
      'server_device_id': 'device-$suffix',
      'generation': 1,
      'updated_at': stamp,
    });
    final attemptId = suffix == 'a' ? 1 : 2;
    await insert('sync_attempts', {
      'id': attemptId,
      'account_id': account,
      'environment_alias': 'secret-provider-alias',
      'operation_kind': 'sync',
      'started_at': stamp,
      'completed_at': stamp,
      'phase': 'finished',
      'latest_stage': 'finished',
      'result_code': 'sync-completed',
      'outcome_class': 'applied',
      'recovery_code': null,
      'correlation_fingerprint': 'short-hash',
      'elapsed_band': 'under-1s',
      'http_status': 200,
      'response_headers_received': 1,
    });
    await insert('sync_diagnostic_events', {
      'id': attemptId,
      'attempt_id': attemptId,
      'diagnostic_version': 1,
      'ordinal': 1,
      'operation_id': 'secret-operation',
      'correlation_id': 'secret-correlation',
      'code': 'MKS-SYNC-001',
      'native_code': 'secret-native-code',
      'severity': 'info',
      'outcome': 'success',
      'operation_kind': 'sync',
      'phase': 'finished',
      'last_proved_phase': 'finished',
      'operation_fingerprint': 'operation-short',
      'correlation_fingerprint': 'correlation-short',
      'account_fingerprint': 'account-short',
      'device_fingerprint': 'device-short',
      'submission_fingerprint': 'submission-short',
      'local_mutation_state': 'applied',
      'provider_contact_state': 'contacted',
      'provider_transaction_state': 'committed',
      'trusted_response_state': 'trusted',
      'result_persistence_state': 'recorded',
      'queue_scope': 'account',
      'pending_count': 0,
      'uploading_count': 0,
      'failed_count': 0,
      'unknown_count': 0,
      'member_count': 1,
      'first_device_sequence': 1,
      'last_device_sequence': 1,
      'next_device_sequence': 2,
      'http_status': 200,
      'response_headers_received': 1,
      'safe_action': 'secret-action',
      'retryable': 0,
      'sanitized_exception_class': 'secret-exception',
      'server_sqlstate_class': 'secret-sqlstate',
      'recorded_at': stamp,
    });
  });
}
