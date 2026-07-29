import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';

import '../../../application/sync/sync_ports.dart';
import '../../../domain/shared/ids.dart';
import '../../../domain/sync/canonical_json.dart';
import '../../../domain/sync/sync_event.dart';
import '../local_database.dart';
import 'remote_purchase_fact_writer.dart';

final class DriftRemoteEventApplier implements RemoteEventApplier {
  DriftRemoteEventApplier(this._db)
    : _accountId = null,
      _debugThrowBeforeApply = null;

  DriftRemoteEventApplier.scoped(this._db, {required AccountId accountId})
    : _accountId = accountId.value,
      _debugThrowBeforeApply = null;

  @visibleForTesting
  DriftRemoteEventApplier.scopedWithApplyFailureForTest(
    this._db, {
    required AccountId accountId,
    required Object Function() throwBeforeApply,
  }) : _accountId = accountId.value,
       _debugThrowBeforeApply = throwBeforeApply;

  final LocalDatabase _db;
  final String? _accountId;
  final Object Function()? _debugThrowBeforeApply;
  late final RemotePurchaseFactWriter _facts = RemotePurchaseFactWriter(_db);

  @override
  Future<SyncResult> applyPage(DownloadPage page) async {
    try {
      return await _db.transaction(() async {
        if (page.events.isEmpty) {
          return const SyncResult(
            code: SyncStatusCode.downloadReceived,
            outcome: SyncOutcome.duplicateEquivalent,
            retryable: false,
          );
        }
        final validation = await _validatePage(page);
        if (validation != null) {
          if (validation.code == SyncStatusCode.duplicateIgnored) {
            await _advanceCursorForPage(page);
          }
          return validation;
        }
        final debugFailure = _debugThrowBeforeApply;
        if (debugFailure != null) throw debugFailure();
        for (final item in page.events) {
          final eventId = item.event['eventId'] as String;
          final accountId = item.event['accountId'] as String;
          final hash = item.event['contentHash'] as String;
          if (await _isEquivalentInbox(accountId, eventId, hash)) {
            continue;
          }
          await _facts.applyPurchaseRegistered(item.event);
          await _db
              .into(_db.syncInbox)
              .insert(
                SyncInboxCompanion.insert(
                  accountId: accountId,
                  eventId: eventId,
                  contentHash: hash,
                  serverCursor: item.serverCursor,
                  state: 'applied',
                  appliedAt: Value(DateTime.now().toUtc()),
                ),
              );
        }
        await _advanceCursorForPage(page);
        return const SyncResult(
          code: SyncStatusCode.downloadedApplied,
          outcome: SyncOutcome.applied,
          retryable: false,
        );
      });
    } on RemoteIdentityConflict catch (failure) {
      return SyncResult(
        code: SyncStatusCode.conflict,
        outcome: SyncOutcome.notApplied,
        retryable: false,
        protocolCode: failure.protocolCode,
      );
    } on Object catch (error) {
      if (_isSqliteFailure(error)) {
        return const SyncResult(
          code: SyncStatusCode.unknownOutcome,
          outcome: SyncOutcome.unknown,
          retryable: false,
          protocolCode: 'local-sqlite-apply-failed',
          sanitizedExceptionClass: 'sqlite-drift-database-failure',
        );
      }
      if (error is TypeError || error is FormatException) {
        return const SyncResult(
          code: SyncStatusCode.conflict,
          outcome: SyncOutcome.notApplied,
          retryable: false,
          protocolCode: 'remote-payload-shape-invalid',
          sanitizedExceptionClass: 'payload-shape-failure',
        );
      }
      if (error is StateError || error is ArgumentError) {
        return const SyncResult(
          code: SyncStatusCode.conflict,
          outcome: SyncOutcome.notApplied,
          retryable: false,
          protocolCode: 'local-apply-invariant-failed',
          sanitizedExceptionClass: 'local-invariant-failure',
        );
      }
      return const SyncResult(
        code: SyncStatusCode.unknownOutcome,
        outcome: SyncOutcome.unknown,
        retryable: false,
        protocolCode: 'unexpected-local-apply-failed',
        sanitizedExceptionClass: 'unexpected-local-apply-failure',
      );
    }
  }

  @override
  Future<String?> greatestContiguousAppliedCursor() async {
    final accountId = _accountId;
    Expression<bool> predicate = _db.syncState.accountCursor.isNotNull();
    if (accountId != null) {
      predicate = predicate & _db.syncState.accountId.equals(accountId);
    }
    final query = _db.select(_db.syncState)
      ..where((table) => predicate)
      ..limit(1);
    final row = await query.getSingleOrNull();
    return row?.accountCursor;
  }

  Future<SyncResult?> _validatePage(DownloadPage page) async {
    final accountId = page.events.first.event['accountId'] as String?;
    if (accountId == null) {
      return _conflict();
    }
    final scopedAccountId = _accountId;
    if (scopedAccountId != null && accountId != scopedAccountId) {
      return _conflict();
    }
    final state = await (_db.select(
      _db.syncState,
    )..where((table) => table.accountId.equals(accountId))).getSingleOrNull();
    final current = _cursorNumber(state?.accountCursor);
    var expected = current + 1;
    var duplicateOnly = true;
    for (final item in page.events) {
      final event = item.event;
      final eventId = event['eventId'] as String?;
      final hash = event['contentHash'] as String?;
      if (eventId == null ||
          hash == null ||
          event['accountId'] != accountId ||
          event['eventType'] != 'purchase.registered' ||
          event['payloadVersion'] != 3) {
        return _conflict();
      }
      final content = Map<String, Object?>.from(event)..remove('contentHash');
      if (canonicalUtf8Sha256(content) != hash) {
        return _conflict();
      }
      final cursor = _cursorNumber(item.serverCursor);
      final existing =
          await (_db.select(_db.syncInbox)..where(
                (table) =>
                    table.accountId.equals(accountId) &
                    table.eventId.equals(eventId),
              ))
              .getSingleOrNull();
      if (existing != null) {
        if (existing.contentHash != hash) {
          return _conflict();
        }
        continue;
      }
      duplicateOnly = false;
      if (cursor != expected) {
        return _conflict();
      }
      expected++;
    }
    if (duplicateOnly) {
      return const SyncResult(
        code: SyncStatusCode.duplicateIgnored,
        outcome: SyncOutcome.duplicateEquivalent,
        retryable: false,
      );
    }
    return null;
  }

  Future<void> _advanceCursorForPage(DownloadPage page) async {
    if (page.events.isEmpty) return;
    final last = page.events.last;
    await _db
        .into(_db.syncState)
        .insertOnConflictUpdate(
          SyncStateCompanion.insert(
            accountId: _accountId ?? (last.event['accountId'] as String),
            accountCursor: Value(page.nextCursor ?? last.serverCursor),
            updatedAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<bool> _isEquivalentInbox(
    String accountId,
    String eventId,
    String hash,
  ) async {
    final existing =
        await (_db.select(_db.syncInbox)..where(
              (table) =>
                  table.accountId.equals(accountId) &
                  table.eventId.equals(eventId),
            ))
            .getSingleOrNull();
    return existing != null && existing.contentHash == hash;
  }

  int _cursorNumber(String? cursor) {
    if (cursor == null || cursor == 'c10b:0') {
      return 0;
    }
    final parts = cursor.split(':');
    if (parts.length != 2 || parts.first != 'c10b') {
      throw StateError('Unsupported cursor token.');
    }
    return int.parse(parts.last);
  }

  SyncResult _conflict() => const SyncResult(
    code: SyncStatusCode.conflict,
    outcome: SyncOutcome.notApplied,
    retryable: false,
  );
}

bool _isSqliteFailure(Object error) {
  if (error is SqliteException) return true;
  if (error is DriftWrappedException && error.cause is SqliteException) {
    return true;
  }
  final typeName = error.runtimeType.toString().toLowerCase();
  return typeName.contains('databaseexception');
}
