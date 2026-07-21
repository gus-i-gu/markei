import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../application/sync/sync_ports.dart';
import '../../../domain/shared/ids.dart';
import '../../../domain/sync/canonical_json.dart';
import '../../../domain/sync/sync_event.dart' show SyncOutcome, SyncStatusCode;
import '../local_database.dart';

final class DriftSyncOutboxRepository implements SyncOutboxRepository {
  DriftSyncOutboxRepository(this._db, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid(),
      _accountId = null,
      _deviceId = null;

  DriftSyncOutboxRepository.scoped(
    this._db, {
    required AccountId accountId,
    required DeviceId deviceId,
    Uuid? uuid,
  }) : _uuid = uuid ?? const Uuid(),
       _accountId = accountId.value,
       _deviceId = deviceId.value;

  final LocalDatabase _db;
  final Uuid _uuid;
  final String? _accountId;
  final String? _deviceId;

  @override
  Future<SyncUploadSubmission?> leasePending({required int limit}) {
    return _db.transaction(() async {
      final now = DateTime.now().toUtc();
      final accountId = _accountId;
      final deviceId = _deviceId;
      var pendingPredicate = _db.pendingEvents.state.equals('pending');
      if (accountId != null && deviceId != null) {
        pendingPredicate =
            pendingPredicate &
            _db.syncEvents.accountId.equals(accountId) &
            _db.syncEvents.deviceId.equals(deviceId);
      }
      final pendingQuery =
          _db.select(_db.pendingEvents).join([
              innerJoin(
                _db.syncEvents,
                _db.syncEvents.id.equalsExp(_db.pendingEvents.eventId),
              ),
            ])
            ..where(pendingPredicate)
            ..orderBy([
              OrderingTerm.asc(_db.syncEvents.deviceSequence),
              OrderingTerm.asc(_db.syncEvents.id),
            ])
            ..limit(limit);
      final events = (await pendingQuery.get())
          .map((row) => row.readTable(_db.syncEvents))
          .toList(growable: false);
      if (events.isEmpty) {
        Expression<bool> unknownPredicate = _db.syncSubmissions.state.equals(
          'unknown',
        );
        if (accountId != null && deviceId != null) {
          unknownPredicate =
              unknownPredicate &
              _db.syncSubmissions.accountId.equals(accountId) &
              _db.syncSubmissions.deviceId.equals(deviceId);
        }
        final unknownQuery = _db.select(_db.syncSubmissions)
          ..where((table) => unknownPredicate)
          ..orderBy([(table) => OrderingTerm.asc(table.createdAt)])
          ..limit(1);
        final unknown = await unknownQuery.getSingleOrNull();
        if (unknown == null) {
          return null;
        }
        final members =
            await (_db.select(_db.syncSubmissionEvents)
                  ..where((table) => table.submissionId.equals(unknown.id))
                  ..orderBy([(table) => OrderingTerm.asc(table.position)]))
                .get();
        final rows =
            await (_db.select(_db.syncEvents)..where(
                  (table) =>
                      table.id.isIn(members.map((row) => row.eventId).toList()),
                ))
                .get();
        final rowsById = {for (final row in rows) row.id: row};
        final orderedRows = [
          for (final member in members) rowsById[member.eventId],
        ].nonNulls.toList(growable: false);
        _preflightOrThrow(orderedRows);
        return SyncUploadSubmission(
          id: unknown.id,
          deviceId: unknown.deviceId,
          requestHash: unknown.requestHash,
          events: orderedRows
              .map((row) => jsonDecode(row.payloadJson) as Map<String, Object?>)
              .toList(growable: false),
        );
      }
      _preflightOrThrow(events);
      final eventIds = events.map((row) => row.id).toList(growable: false);
      final leaseDeviceId = events.first.deviceId;
      final submissionId = _uuid.v4();
      final eventJson = events
          .map((row) => jsonDecode(row.payloadJson) as Map<String, Object?>)
          .toList(growable: false);
      final requestHash = canonicalUtf8Sha256({
        'deviceId': leaseDeviceId,
        'events': eventJson,
        'submissionId': submissionId,
      });
      await _db
          .into(_db.syncSubmissions)
          .insert(
            SyncSubmissionsCompanion.insert(
              id: submissionId,
              accountId: events.first.accountId,
              deviceId: leaseDeviceId,
              requestHash: requestHash,
              state: 'uploading',
              attemptCount: const Value(1),
              leaseUntil: Value(now.add(const Duration(minutes: 5))),
              createdAt: now,
              updatedAt: now,
            ),
          );
      for (var i = 0; i < eventIds.length; i++) {
        await _db
            .into(_db.syncSubmissionEvents)
            .insert(
              SyncSubmissionEventsCompanion.insert(
                submissionId: submissionId,
                eventId: eventIds[i],
                position: i,
              ),
            );
        await (_db.update(_db.pendingEvents)
              ..where((table) => table.eventId.equals(eventIds[i])))
            .write(const PendingEventsCompanion(state: Value('uploading')));
      }
      return SyncUploadSubmission(
        id: submissionId,
        deviceId: leaseDeviceId,
        requestHash: requestHash,
        events: eventJson,
      );
    });
  }

  @override
  Future<void> persistUploadResult(String submissionId, SyncResult result) {
    return _db.transaction(() async {
      if (_accountId != null && _deviceId != null) {
        final submission =
            await (_db.select(_db.syncSubmissions)..where(
                  (table) =>
                      table.id.equals(submissionId) &
                      table.accountId.equals(_accountId) &
                      table.deviceId.equals(_deviceId),
                ))
                .getSingleOrNull();
        if (submission == null) {
          return;
        }
      }
      final state = switch (result.code) {
        SyncStatusCode.serverAccepted ||
        SyncStatusCode.duplicateIgnored => 'accepted',
        SyncStatusCode.unknownOutcome => 'unknown',
        _ => 'failed',
      };
      await (_db.update(
        _db.syncSubmissions,
      )..where((table) => table.id.equals(submissionId))).write(
        SyncSubmissionsCompanion(
          state: Value(state),
          outcome: Value(result.outcome.name),
          responseCode: Value(result.code.name),
          errorCode: Value(result.protocolCode),
          updatedAt: Value(DateTime.now().toUtc()),
        ),
      );
      final members = await (_db.select(
        _db.syncSubmissionEvents,
      )..where((table) => table.submissionId.equals(submissionId))).get();
      for (final member in members) {
        await (_db.update(_db.pendingEvents)
              ..where((table) => table.eventId.equals(member.eventId)))
            .write(PendingEventsCompanion(state: Value(state)));
      }
    });
  }

  @override
  Future<SyncResult> recoverFailedNotApplied(String submissionId) {
    return _db.transaction(() async {
      final now = DateTime.now().toUtc();
      final submission = await (_db.select(
        _db.syncSubmissions,
      )..where((table) => table.id.equals(submissionId))).getSingleOrNull();
      if (submission == null ||
          submission.state != 'failed' ||
          submission.outcome != SyncOutcome.notApplied.name) {
        return _recoveryBlocked();
      }
      if (_accountId != null &&
          (submission.accountId != _accountId ||
              submission.deviceId != _deviceId)) {
        return _recoveryBlocked();
      }
      final members =
          await (_db.select(_db.syncSubmissionEvents)
                ..where((table) => table.submissionId.equals(submissionId))
                ..orderBy([(table) => OrderingTerm.asc(table.position)]))
              .get();
      if (members.isEmpty) return _recoveryBlocked();
      final rows =
          await (_db.select(_db.syncEvents)..where(
                (table) =>
                    table.id.isIn(members.map((member) => member.eventId)),
              ))
              .get();
      final rowsById = {for (final row in rows) row.id: row};
      final orderedRows = [
        for (final member in members) rowsById[member.eventId],
      ].nonNulls.toList(growable: false);
      if (orderedRows.length != members.length ||
          !_preflightValid(orderedRows, requireCanonicalOrder: false)) {
        return _recoveryBlocked();
      }
      final canonicalRows = [...orderedRows]
        ..sort((a, b) {
          final sequence = a.deviceSequence.compareTo(b.deviceSequence);
          return sequence != 0 ? sequence : a.id.compareTo(b.id);
        });
      if (!_preflightValid(canonicalRows)) return _recoveryBlocked();
      final memberIds = canonicalRows.map((row) => row.id).toSet();
      final states = await (_db.select(
        _db.pendingEvents,
      )..where((table) => table.eventId.isIn(memberIds))).get();
      if (states.length != memberIds.length ||
          states.any((row) => row.state == 'accepted')) {
        return _recoveryBlocked();
      }
      if (states.any((row) => row.state == 'pending')) {
        return const SyncResult(
          code: SyncStatusCode.waitingUpload,
          outcome: SyncOutcome.notApplied,
          retryable: true,
          protocolCode: 'failed-recovery-available',
        );
      }
      final activeMembers =
          await (_db.select(_db.syncSubmissionEvents).join([
                innerJoin(
                  _db.syncSubmissions,
                  _db.syncSubmissions.id.equalsExp(
                    _db.syncSubmissionEvents.submissionId,
                  ),
                ),
              ])..where(
                _db.syncSubmissionEvents.eventId.isIn(memberIds) &
                    (_db.syncSubmissions.state.equals('uploading') |
                        _db.syncSubmissions.state.equals('unknown')),
              ))
              .get();
      if (activeMembers.isNotEmpty) return _recoveryBlocked();
      await (_db.update(
        _db.syncSubmissions,
      )..where((table) => table.id.equals(submissionId))).write(
        SyncSubmissionsCompanion(
          state: const Value('superseded'),
          updatedAt: Value(now),
        ),
      );
      for (final row in canonicalRows) {
        await (_db.update(
          _db.pendingEvents,
        )..where((table) => table.eventId.equals(row.id))).write(
          PendingEventsCompanion(
            state: const Value('pending'),
            enqueuedAt: Value(now),
          ),
        );
      }
      return const SyncResult(
        code: SyncStatusCode.waitingUpload,
        outcome: SyncOutcome.notApplied,
        retryable: true,
        protocolCode: 'failed-recovery-available',
      );
    });
  }

  bool _sameScopedIdentity(List<SyncEvent> events) {
    if (events.isEmpty) return false;
    final accountId = _accountId;
    final deviceId = _deviceId;
    if (accountId == null || deviceId == null) return true;
    return events.every(
      (event) => event.accountId == accountId && event.deviceId == deviceId,
    );
  }

  void _preflightOrThrow(List<SyncEvent> events) {
    if (!_preflightValid(events)) {
      throw const SyncBatchPreflightException(
        SyncResult(
          code: SyncStatusCode.localBatchInvalid,
          outcome: SyncOutcome.notApplied,
          retryable: false,
          protocolCode: 'local-batch-invalid',
        ),
      );
    }
  }

  bool _preflightValid(
    List<SyncEvent> events, {
    bool requireCanonicalOrder = true,
  }) {
    if (!_sameScopedIdentity(events)) return false;
    final eventIds = <String>{};
    final sequences = <int>{};
    final accountId = events.first.accountId;
    final deviceId = events.first.deviceId;
    var previousSequence = events.first.deviceSequence - 1;
    for (final event in events) {
      if (event.accountId != accountId || event.deviceId != deviceId) {
        return false;
      }
      if (!eventIds.add(event.id) || !sequences.add(event.deviceSequence)) {
        return false;
      }
      if (requireCanonicalOrder &&
          event.deviceSequence != previousSequence + 1) {
        return false;
      }
      final payload = jsonDecode(event.payloadJson) as Map<String, Object?>;
      final eventContent = Map<String, Object?>.from(payload)
        ..remove('contentHash');
      if (payload['eventId'] != event.id ||
          payload['accountId'] != event.accountId ||
          payload['deviceId'] != event.deviceId ||
          payload['deviceSequence'] != event.deviceSequence ||
          payload['contentHash'] != event.contentHash ||
          canonicalUtf8Sha256(eventContent) != event.contentHash) {
        return false;
      }
      previousSequence = event.deviceSequence;
    }
    return true;
  }

  SyncResult _recoveryBlocked() => const SyncResult(
    code: SyncStatusCode.failedRecoveryBlocked,
    outcome: SyncOutcome.notApplied,
    retryable: false,
    protocolCode: 'failed-recovery-blocked',
  );
}
