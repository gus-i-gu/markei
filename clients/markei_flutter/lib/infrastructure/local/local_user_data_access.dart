import 'dart:convert';

import 'package:drift/drift.dart';

import '../../application/user_data_access.dart';
import '../../domain/shared/ids.dart';
import 'local_database.dart';

/// A fixed field allowlist keeps auth state, configuration, raw exception text
/// and encoded queue/recovery payloads outside the access report.
final class LocalUserDataAccessRepository implements UserDataAccessRepository {
  LocalUserDataAccessRepository(this._db, {DateTime Function()? clock})
    : _clock = clock ?? (() => DateTime.now().toUtc());

  final LocalDatabase _db;
  final DateTime Function() _clock;

  @override
  Future<UserDataInventory> inventory(AccountId accountId) =>
      _db.transaction(() async {
        final counts = <String, int>{};
        for (final dataset in _datasets) {
          final row = await _db
              .customSelect(
                'SELECT COUNT(*) AS record_count FROM (${dataset.query})',
                variables: [Variable<String>(accountId.value)],
              )
              .getSingle();
          counts[dataset.name] = row.read<int>('record_count');
        }
        return UserDataInventory(accountId: accountId, counts: counts);
      });

  @override
  Future<UserDataExport> exportAccountData(
    AccountId accountId,
  ) => _db.transaction(() async {
    final data = <String, List<Map<String, Object?>>>{};
    final counts = <String, int>{};
    for (final dataset in _datasets) {
      final rows = await _db
          .customSelect(
            dataset.query,
            variables: [Variable<String>(accountId.value)],
          )
          .get();
      data[dataset.name] = [for (final row in rows) dataset.convert(row.data)];
      counts[dataset.name] = rows.length;
    }
    final inventory = UserDataInventory(accountId: accountId, counts: counts);
    final document = <String, Object?>{
      'format': 'marc-local-account-access',
      'format_version': 1,
      'generated_at_utc': _clock().toUtc().toIso8601String(),
      'account_id': accountId.value,
      'local_schema_version': _db.schemaVersion,
      'scope': 'This Account on this Device; one consistent local snapshot.',
      'counts': counts,
      'total_records': inventory.totalRecords,
      'field_conventions': {
        'names': 'Dataset and field names follow the local schema.',
        'timestamps': 'ISO 8601 UTC, ending in Z.',
        'money':
            'Integer minor units with a separate currency_code. For BRL, 100 minor units is R\$1.00.',
        'quantities':
            'Decimal strings plus measurement_kind and unit. package_count is an integer.',
        'identity':
            'Record identifiers link related datasets; they are not access credentials.',
        'notes':
            'tags and replaces are JSON arrays decoded from stored revisions.',
      },
      'limitations': [
        'Local stored data only; this is not a complete hosted data response or an importable database backup.',
        'Hosted service and Auth0 records, authentication tokens/state, provider configuration, logs and backups are excluded.',
        'Current Purchase drafts and session-only saved Analytics are not stored in these datasets; export Analytics from its own page.',
        'Device-wide language/privacy preferences and the global migration ledger are outside this Account report.',
        'Sync event payloads and recovery chunk bytes are excluded; their Account-scoped metadata is included without replayable payloads.',
        'Raw diagnostic operation/correlation identifiers, provider aliases and free-form exception/action text are excluded.',
        'Recipient copies and files previously exported or shared are not collected by this report.',
        'Relations inconsistent with the Account boundary are omitted. This report does not certify the truth of manual entries.',
      ],
      'datasets': data,
    };
    return UserDataExport(
      jsonBytes: utf8.encode(
        const JsonEncoder.withIndent('  ').convert(document),
      ),
      inventory: inventory,
    );
  });

  @override
  Future<LocalDiagnosticsClearResult> clearLocalDiagnostics(
    AccountId accountId,
  ) => _db.transaction(() async {
    // Explicit child deletion also works when foreign-key cascades are disabled
    // by a caller. Either both statements commit, or neither does.
    final events = await _db.customUpdate(
      'DELETE FROM sync_diagnostic_events WHERE attempt_id IN '
      '(SELECT id FROM sync_attempts WHERE account_id = ?)',
      variables: [Variable<String>(accountId.value)],
      updates: {_db.syncDiagnosticEvents},
      updateKind: UpdateKind.delete,
    );
    final attempts = await _db.customUpdate(
      'DELETE FROM sync_attempts WHERE account_id = ?',
      variables: [Variable<String>(accountId.value)],
      updates: {_db.syncAttempts},
      updateKind: UpdateKind.delete,
    );
    return LocalDiagnosticsClearResult(
      attemptsRemoved: attempts,
      diagnosticEventsRemoved: events,
    );
  });
}

final class _Dataset {
  const _Dataset(
    this.name,
    this.query, {
    this.timestamps = const {},
    this.booleans = const {},
    this.jsonFields = const {},
  });
  final String name;
  final String query;
  final Set<String> timestamps;
  final Set<String> booleans;
  final Map<String, String> jsonFields;

  Map<String, Object?> convert(Map<String, Object?> row) => {
    for (final entry in row.entries)
      jsonFields[entry.key] ?? entry.key: _value(entry.key, entry.value),
  };

  Object? _value(String key, Object? value) {
    if (value == null) return null;
    if (timestamps.contains(key)) {
      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(
          value * 1000,
          isUtc: true,
        ).toIso8601String();
      }
      throw StateError('Unsupported local timestamp encoding.');
    }
    if (booleans.contains(key)) return value == 1;
    if (jsonFields.containsKey(key)) return jsonDecode(value as String);
    return value;
  }
}

const _datasets = [
  _Dataset(
    'local_accounts',
    'SELECT id, default_currency_code, created_at FROM local_accounts WHERE id = ? ORDER BY id',
    timestamps: {'created_at'},
  ),
  _Dataset(
    'devices',
    'SELECT id, account_id, next_sequence, created_at FROM devices WHERE account_id = ? ORDER BY id',
    timestamps: {'created_at'},
  ),
  _Dataset(
    'products',
    'SELECT id, account_id, user_product_code, normalized_user_product_code, normalization_version, display_name, display_brand, normalized_name, normalized_brand, mode, measurement_kind, package_amount, package_unit, exact_identity_key, created_at FROM products WHERE account_id = ? ORDER BY id',
    timestamps: {'created_at'},
  ),
  _Dataset(
    'stores',
    'SELECT id, account_id, display_name, created_at FROM stores WHERE account_id = ? ORDER BY id',
    timestamps: {'created_at'},
  ),
  _Dataset(
    'people',
    'SELECT id, account_id, visible_code, nickname, normalized_nickname, active, created_at, updated_at, archived_at FROM people WHERE account_id = ? ORDER BY id',
    timestamps: {'created_at', 'updated_at', 'archived_at'},
    booleans: {'active'},
  ),
  _Dataset(
    'payment_methods',
    '''SELECT p.id, p.account_id, p.visible_code, p.nickname, p.normalized_nickname, p.active, p.created_at, p.updated_at, p.archived_at,
    CASE WHEN EXISTS(SELECT 1 FROM people x WHERE x.id = p.assigned_person_id AND x.account_id = p.account_id) THEN p.assigned_person_id ELSE NULL END AS assigned_person_id
    FROM payment_methods p WHERE p.account_id = ? ORDER BY p.id''',
    timestamps: {'created_at', 'updated_at', 'archived_at'},
    booleans: {'active'},
  ),
  _Dataset(
    'account_preferences',
    'SELECT account_id, shortage_threshold_days, next_person_code, next_payment_method_code, updated_at FROM account_preferences WHERE account_id = ? ORDER BY account_id',
    timestamps: {'updated_at'},
  ),
  _Dataset(
    'purchases',
    '''SELECT p.id, p.account_id, p.store_id,
    CASE WHEN EXISTS(SELECT 1 FROM people x WHERE x.id = p.person_id AND x.account_id = p.account_id) THEN p.person_id ELSE NULL END AS person_id,
    CASE WHEN EXISTS(SELECT 1 FROM payment_methods x WHERE x.id = p.payment_method_id AND x.account_id = p.account_id) THEN p.payment_method_id ELSE NULL END AS payment_method_id,
    p.occurrence_time, p.currency_code, p.total_minor_units, p.created_at
    FROM purchases p JOIN stores s ON s.id = p.store_id AND s.account_id = p.account_id
    WHERE p.account_id = ? ORDER BY p.id''',
    timestamps: {'occurrence_time', 'created_at'},
  ),
  _Dataset(
    'purchase_items',
    '''SELECT i.id, i.purchase_id, i.product_id, i.package_count, i.measurement_kind, i.purchased_amount, i.purchased_unit, i.currency_code, i.line_total_minor_units
    FROM purchase_items i JOIN purchases p ON p.id = i.purchase_id
    JOIN products x ON x.id = i.product_id AND x.account_id = p.account_id
    JOIN stores s ON s.id = p.store_id AND s.account_id = p.account_id
    WHERE p.account_id = ? ORDER BY i.id''',
  ),
  _Dataset(
    'list_note_revisions',
    '''SELECT n.account_id, n.event_id, n.product_id, n.note, n.tags_json, n.replaces_json
    FROM list_note_revisions n JOIN products p ON p.id = n.product_id AND p.account_id = n.account_id
    WHERE n.account_id = ? ORDER BY n.event_id''',
    jsonFields: {'tags_json': 'tags', 'replaces_json': 'replaces'},
  ),
  _Dataset(
    'sync_events',
    '''SELECT e.id, e.account_id, e.device_id, e.device_sequence, e.event_type, e.payload_version, e.occurrence_time, e.content_hash, e.created_at
    FROM sync_events e JOIN devices d ON d.id = e.device_id AND d.account_id = e.account_id
    WHERE e.account_id = ? ORDER BY e.id''',
    timestamps: {'occurrence_time', 'created_at'},
  ),
  _Dataset(
    'pending_events',
    '''SELECT p.event_id, p.state, p.enqueued_at FROM pending_events p
    JOIN sync_events e ON e.id = p.event_id JOIN devices d ON d.id = e.device_id AND d.account_id = e.account_id
    WHERE e.account_id = ? ORDER BY p.event_id''',
    timestamps: {'enqueued_at'},
  ),
  _Dataset(
    'sync_state',
    'SELECT account_id, account_cursor, updated_at FROM sync_state WHERE account_id = ? ORDER BY account_id',
    timestamps: {'updated_at'},
  ),
  _Dataset(
    'installation_metadata',
    '''SELECT m.id, m.account_id, m.current_device_id, m.created_at, m.updated_at FROM installation_metadata m
    JOIN devices d ON d.id = m.current_device_id AND d.account_id = m.account_id WHERE m.account_id = ? ORDER BY m.id''',
    timestamps: {'created_at', 'updated_at'},
  ),
  _Dataset(
    'sync_submissions',
    '''SELECT s.id, s.account_id, s.device_id, s.request_hash, s.state, s.attempt_count, s.next_attempt_at, s.lease_until, s.created_at, s.updated_at
    FROM sync_submissions s JOIN devices d ON d.id = s.device_id AND d.account_id = s.account_id
    WHERE s.account_id = ? ORDER BY s.id''',
    timestamps: {'next_attempt_at', 'lease_until', 'created_at', 'updated_at'},
  ),
  _Dataset(
    'sync_submission_events',
    '''SELECT m.submission_id, m.event_id, m.position FROM sync_submission_events m
    JOIN sync_submissions s ON s.id = m.submission_id JOIN sync_events e ON e.id = m.event_id AND e.account_id = s.account_id
    JOIN devices d ON d.id = s.device_id AND d.account_id = s.account_id
    JOIN devices ed ON ed.id = e.device_id AND ed.account_id = e.account_id
    WHERE s.account_id = ? ORDER BY m.submission_id, m.position, m.event_id''',
  ),
  _Dataset(
    'sync_inbox',
    'SELECT account_id, event_id, content_hash, server_cursor, state, applied_at FROM sync_inbox WHERE account_id = ? ORDER BY server_cursor, event_id',
    timestamps: {'applied_at'},
  ),
  _Dataset(
    'recovery_sessions',
    'SELECT id, account_id, snapshot_id, phase, format_version, manifest_hash, covered_through_cursor, expires_at, updated_at FROM recovery_sessions WHERE account_id = ? ORDER BY id',
    timestamps: {'expires_at', 'updated_at'},
  ),
  _Dataset(
    'recovery_chunks',
    '''SELECT c.session_id, c.chunk_index, c.byte_length, c.content_hash, c.verified_at FROM recovery_chunks c
    JOIN recovery_sessions s ON s.id = c.session_id WHERE s.account_id = ? ORDER BY c.session_id, c.chunk_index''',
    timestamps: {'verified_at'},
  ),
  _Dataset(
    'sync_attempts',
    'SELECT id, account_id, operation_kind, started_at, completed_at, phase, latest_stage, result_code, outcome_class, recovery_code, correlation_fingerprint, elapsed_band, http_status, response_headers_received FROM sync_attempts WHERE account_id = ? ORDER BY id',
    timestamps: {'started_at', 'completed_at'},
    booleans: {'response_headers_received'},
  ),
  _Dataset(
    'sync_diagnostic_events',
    '''SELECT e.id, e.attempt_id, e.diagnostic_version, e.ordinal, e.code, e.severity, e.outcome, e.operation_kind, e.phase, e.last_proved_phase,
    e.operation_fingerprint, e.correlation_fingerprint, e.account_fingerprint, e.device_fingerprint, e.submission_fingerprint,
    e.local_mutation_state, e.provider_contact_state, e.provider_transaction_state, e.trusted_response_state, e.result_persistence_state,
    e.queue_scope, e.pending_count, e.uploading_count, e.failed_count, e.unknown_count, e.member_count,
    e.first_device_sequence, e.last_device_sequence, e.next_device_sequence, e.http_status, e.response_headers_received, e.retryable, e.recorded_at
    FROM sync_diagnostic_events e JOIN sync_attempts a ON a.id = e.attempt_id WHERE a.account_id = ? ORDER BY e.id''',
    timestamps: {'recorded_at'},
    booleans: {'response_headers_received', 'retryable'},
  ),
];
