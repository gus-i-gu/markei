// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';

import '../../application/audit.dart';
import '../../application/closure_diagnostics.dart';
import '../../domain/shared/ids.dart';
import '../../domain/sync/canonical_json.dart';
import '../../domain/sync/sync_diagnostic_registry.g.dart';
import 'local_database.dart';

final class DriftClosureDiagnosticsRepository
    implements ClosureDiagnosticsQuery, SyncAttemptRecorder, AuditReadPort {
  DriftClosureDiagnosticsRepository(
    this._db, {
    required AccountId accountId,
    required DeviceId deviceId,
    required String environmentAlias,
    DateTime Function()? now,
  }) : _accountId = accountId.value,
       _deviceId = deviceId.value,
       _environmentAlias = environmentAlias,
       _now = now ?? (() => DateTime.now().toUtc());

  final LocalDatabase _db;
  final String _accountId;
  final String _deviceId;
  final String _environmentAlias;
  final DateTime Function() _now;

  @override
  Future<AuditPageResult> loadPage(AuditPageRequest request) async {
    final limit = request.limit.clamp(1, AuditPageRequest.maxLimit);
    final cursor = request.cursor;
    final attemptsQuery = _db.select(_db.syncAttempts)
      ..where((table) {
        final cursorPredicate = cursor == null
            ? const Constant(true)
            : table.startedAt.isSmallerThanValue(cursor.startedAtUtc) |
                  (table.startedAt.equals(cursor.startedAtUtc) &
                      table.id.isSmallerThanValue(cursor.attemptId.value));
        return table.accountId.equals(request.accountId.value) &
            table.environmentAlias.equals(request.environmentAlias) &
            cursorPredicate;
      })
      ..orderBy([
        (table) => OrderingTerm.desc(table.startedAt),
        (table) => OrderingTerm.desc(table.id),
      ])
      ..limit(limit + 1);
    final attemptRows = await attemptsQuery.get();
    final retainedAttempts = attemptRows.take(limit).toList(growable: false);
    final attemptIds = retainedAttempts.map((row) => row.id).toList();
    final eventRows = attemptIds.isEmpty
        ? <SyncDiagnosticEvent>[]
        : await (_db.select(_db.syncDiagnosticEvents)
                ..where((table) => table.attemptId.isIn(attemptIds))
                ..orderBy([
                  (table) => OrderingTerm.asc(table.attemptId),
                  (table) => OrderingTerm.asc(table.recordedAt),
                  (table) => OrderingTerm.asc(table.id),
                ]))
              .get();
    final eventsByAttempt = <int, List<SyncDiagnosticEvent>>{};
    for (final event in eventRows) {
      eventsByAttempt.putIfAbsent(event.attemptId, () => []).add(event);
    }
    final records = [
      for (final row in retainedAttempts)
        AuditAttemptProjection(
          id: AuditAttemptId(row.id),
          startedAtUtc: row.startedAt.toUtc(),
          completedAtUtc: row.completedAt?.toUtc(),
          operationKind: _safeAuditCode(row.operationKind ?? 'sync'),
          resultCode: _safeAuditCode(row.resultCode),
          outcomeClass: _safeAuditCode(row.outcomeClass),
          latestStage: _safeAuditCode(row.latestStage ?? row.phase),
          correlationReference: _shortReference(row.correlationFingerprint),
          deviceReference: null,
          events: [
            for (final event
                in eventsByAttempt[row.id] ?? const <SyncDiagnosticEvent>[])
              _auditEvent(event),
          ],
        ),
    ];
    return AuditPageResult(
      records: records,
      nextCursor: attemptRows.length > limit && records.isNotEmpty
          ? AuditCursor(
              startedAtUtc: records.last.startedAtUtc,
              attemptId: records.last.id,
            )
          : null,
      loadedAtUtc: _now().toUtc(),
      isPartialWindow: attemptRows.length > limit,
      queryCount: 2,
      networkCallCount: 0,
      writeCallCount: 0,
    );
  }

  AuditEventProjection _auditEvent(SyncDiagnosticEvent row) {
    final definition = syncDiagnosticByCode(row.code);
    return AuditEventProjection(
      id: AuditEventId(row.id),
      recordedAtUtc: row.recordedAt.toUtc(),
      code: _safeAuditCode(row.code),
      title: _safeAuditText(definition?.title ?? row.code),
      meaning: _safeAuditText(
        definition?.meaning ?? 'Diagnostic meaning unavailable.',
      ),
      guidance: _safeAuditText(definition?.safeAction ?? row.safeAction),
      severity: _safeAuditCode(row.severity),
      outcome: _safeAuditCode(row.outcome),
      phase: _safeAuditCode(row.phase),
    );
  }

  @override
  Future<int> beginSyncAttempt() async {
    return _db
        .into(_db.syncAttempts)
        .insert(
          SyncAttemptsCompanion.insert(
            accountId: _accountId,
            environmentAlias: _environmentAlias,
            operationKind: const Value('sync'),
            startedAt: _now(),
            phase: 'started',
            latestStage: const Value('preflight-passed'),
            resultCode: 'sync-started',
            outcomeClass: 'in-progress',
            responseHeadersReceived: const Value(false),
          ),
        );
  }

  @override
  Future<int> beginDiagnosticAttempt({
    required String operationKind,
    required String latestStage,
    required String resultCode,
    required String outcomeClass,
    required String correlationFingerprint,
  }) async {
    return _db
        .into(_db.syncAttempts)
        .insert(
          SyncAttemptsCompanion.insert(
            accountId: _accountId,
            environmentAlias: _environmentAlias,
            operationKind: Value(_sanitizeCode(operationKind)),
            startedAt: _now(),
            phase: _sanitizeCode(latestStage),
            latestStage: Value(_sanitizeCode(latestStage)),
            resultCode: _sanitizeCode(resultCode),
            outcomeClass: _sanitizeCode(outcomeClass),
            correlationFingerprint: Value(
              _sanitizeFingerprint(correlationFingerprint),
            ),
            responseHeadersReceived: const Value(false),
          ),
        );
  }

  @override
  Future<void> completeSyncAttempt(
    int attemptId, {
    required String resultCode,
    required String outcomeClass,
    required String phase,
    String? recoveryCode,
  }) async {
    await (_db.update(_db.syncAttempts)..where(
          (table) =>
              table.id.equals(attemptId) &
              table.accountId.equals(_accountId) &
              table.environmentAlias.equals(_environmentAlias) &
              table.completedAt.isNull(),
        ))
        .write(
          SyncAttemptsCompanion(
            completedAt: Value(_now()),
            phase: Value(_sanitizeCode(phase)),
            latestStage: Value(_sanitizeCode(phase)),
            resultCode: Value(_sanitizeCode(resultCode)),
            outcomeClass: Value(_sanitizeCode(outcomeClass)),
            recoveryCode: Value(
              recoveryCode == null ? null : _sanitizeCode(recoveryCode),
            ),
          ),
        );
  }

  @override
  Future<void> completeDiagnosticAttempt(
    int attemptId, {
    required String operationKind,
    required String latestStage,
    required String resultCode,
    required String outcomeClass,
    required String recoveryCode,
    required String correlationFingerprint,
    required String elapsedBand,
    int? httpStatus,
    required bool responseHeadersReceived,
  }) async {
    await (_db.update(_db.syncAttempts)..where(
          (table) =>
              table.id.equals(attemptId) &
              table.accountId.equals(_accountId) &
              table.environmentAlias.equals(_environmentAlias) &
              table.completedAt.isNull(),
        ))
        .write(
          SyncAttemptsCompanion(
            completedAt: Value(_now()),
            operationKind: Value(_sanitizeCode(operationKind)),
            phase: Value(_sanitizeCode(latestStage)),
            latestStage: Value(_sanitizeCode(latestStage)),
            resultCode: Value(_sanitizeCode(resultCode)),
            outcomeClass: Value(_sanitizeCode(outcomeClass)),
            recoveryCode: Value(_sanitizeCode(recoveryCode)),
            correlationFingerprint: Value(
              _sanitizeFingerprint(correlationFingerprint),
            ),
            elapsedBand: Value(_sanitizeCode(elapsedBand)),
            httpStatus: Value(httpStatus),
            responseHeadersReceived: Value(responseHeadersReceived),
          ),
        );
  }

  @override
  Future<void> clearAttemptHistory() async {
    await (_db.delete(_db.syncAttempts)..where(
          (table) =>
              table.accountId.equals(_accountId) &
              table.environmentAlias.equals(_environmentAlias),
        ))
        .go();
  }

  @override
  Future<int> recordDiagnosticEvent(SyncDiagnosticEnvelope diagnostic) {
    return _db
        .into(_db.syncDiagnosticEvents)
        .insert(
          SyncDiagnosticEventsCompanion.insert(
            attemptId: diagnostic.attemptId,
            diagnosticVersion: Value(diagnostic.diagnosticVersion),
            ordinal: diagnostic.ordinal,
            operationId: Value(
              diagnostic.operationId == null
                  ? null
                  : _sanitizeIdentifier(diagnostic.operationId!),
            ),
            correlationId: Value(
              diagnostic.correlationId == null
                  ? null
                  : _sanitizeIdentifier(diagnostic.correlationId!),
            ),
            code: _sanitizeMksCode(diagnostic.code),
            nativeCode: Value(
              diagnostic.nativeCode == null
                  ? null
                  : _sanitizeCode(diagnostic.nativeCode!),
            ),
            severity: _sanitizeCode(diagnostic.severity),
            outcome: _sanitizeCode(diagnostic.outcome),
            operationKind: _sanitizeCode(diagnostic.operationKind),
            phase: _sanitizeCode(diagnostic.phase),
            lastProvedPhase: Value(_sanitizeCode(diagnostic.lastProvedPhase)),
            operationFingerprint: Value(
              diagnostic.operationFingerprint == null
                  ? null
                  : _sanitizeFingerprint(diagnostic.operationFingerprint!),
            ),
            correlationFingerprint: Value(
              diagnostic.correlationFingerprint == null
                  ? null
                  : _sanitizeFingerprint(diagnostic.correlationFingerprint!),
            ),
            accountFingerprint: Value(
              diagnostic.accountFingerprint == null
                  ? null
                  : _sanitizeFingerprint(diagnostic.accountFingerprint!),
            ),
            deviceFingerprint: Value(
              diagnostic.deviceFingerprint == null
                  ? null
                  : _sanitizeFingerprint(diagnostic.deviceFingerprint!),
            ),
            submissionFingerprint: Value(
              diagnostic.submissionFingerprint == null
                  ? null
                  : _sanitizeFingerprint(diagnostic.submissionFingerprint!),
            ),
            localMutationState: _sanitizeCode(diagnostic.localMutationState),
            providerContactState: _sanitizeCode(
              diagnostic.providerContactState,
            ),
            providerTransactionState: _sanitizeCode(
              diagnostic.providerTransactionState,
            ),
            trustedResponseState: _sanitizeCode(
              diagnostic.trustedResponseState,
            ),
            resultPersistenceState: Value(
              _sanitizeCode(diagnostic.resultPersistenceState),
            ),
            queueScope: Value(
              diagnostic.queueScope == null
                  ? null
                  : _sanitizeCode(diagnostic.queueScope!),
            ),
            pendingCount: Value(diagnostic.pendingCount),
            uploadingCount: Value(diagnostic.uploadingCount),
            failedCount: Value(diagnostic.failedCount),
            unknownCount: Value(diagnostic.unknownCount),
            memberCount: Value(diagnostic.memberCount),
            firstDeviceSequence: Value(diagnostic.firstDeviceSequence),
            lastDeviceSequence: Value(diagnostic.lastDeviceSequence),
            nextDeviceSequence: Value(diagnostic.nextDeviceSequence),
            httpStatus: Value(diagnostic.httpStatus),
            responseHeadersReceived: Value(diagnostic.responseHeadersReceived),
            safeAction: _sanitizeSummary(diagnostic.safeAction),
            retryable: Value(diagnostic.retryable),
            sanitizedExceptionClass: Value(
              diagnostic.sanitizedExceptionClass == null
                  ? null
                  : _sanitizeCode(diagnostic.sanitizedExceptionClass!),
            ),
            serverSqlstateClass: Value(
              diagnostic.serverSqlstateClass == null
                  ? null
                  : _sanitizeCode(diagnostic.serverSqlstateClass!),
            ),
            recordedAt: _now(),
          ),
        );
  }

  @override
  Future<FailedNotAppliedRecoveryInspection> inspectFailedNotAppliedRecovery({
    required String authenticationState,
    required String operationFingerprint,
  }) {
    return _db.transaction(() async {
      final counts = await _queueCountsForDevice();
      FailedNotAppliedRecoveryInspection blocked(String state) =>
          FailedNotAppliedRecoveryInspection.blocked(
            diagnosticCode: 'MKS-REC-012',
            state: state,
            queueCounts: counts,
          );

      if (authenticationState != 'authenticated') {
        return blocked('failed-not-applied-authentication-required');
      }
      final hosted =
          await (_db.select(_db.hostedAuthStates)..where(
                (table) => table.environmentAlias.equals(_environmentAlias),
              ))
              .getSingleOrNull();
      if (hosted == null ||
          !_activeEnrollmentStates.contains(hosted.enrollmentState) ||
          hosted.accountId != _accountId ||
          hosted.serverDeviceId != _deviceId) {
        return blocked('failed-not-applied-device-enrollment-required');
      }
      final device =
          await (_db.select(_db.devices)..where(
                (table) =>
                    table.id.equals(_deviceId) &
                    table.accountId.equals(_accountId),
              ))
              .getSingleOrNull();
      if (device == null) {
        return blocked('failed-not-applied-device-enrollment-required');
      }
      if (counts.pending > 0 || counts.uploading > 0 || counts.unknown > 0) {
        return blocked('failed-not-applied-active-work-overlap');
      }
      final submissions =
          await (_db.select(_db.syncSubmissions)
                ..where(
                  (table) =>
                      table.accountId.equals(_accountId) &
                      table.deviceId.equals(_deviceId) &
                      table.state.equals('failed') &
                      table.outcome.equals('notApplied'),
                )
                ..orderBy([
                  (table) => OrderingTerm.asc(table.createdAt),
                  (table) => OrderingTerm.asc(table.id),
                ]))
              .get();
      if (submissions.length != 1) {
        return blocked(
          submissions.isEmpty
              ? 'failed-not-applied-no-candidate'
              : 'failed-not-applied-ambiguous-candidates',
        );
      }
      final submission = submissions.single;
      final members =
          await (_db.select(_db.syncSubmissionEvents)
                ..where((table) => table.submissionId.equals(submission.id))
                ..orderBy([(table) => OrderingTerm.asc(table.position)]))
              .get();
      final membershipContiguous =
          members.isNotEmpty && _positionsAreContiguous(members);
      if (!membershipContiguous) {
        return FailedNotAppliedRecoveryInspection.blocked(
          diagnosticCode: 'MKS-REC-012',
          state: 'failed-not-applied-membership-invalid',
          queueCounts: counts,
          candidateFingerprint: _fingerprint(submission.id),
          membershipContiguous: false,
        );
      }
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
      final deviceScopeMatches =
          orderedRows.length == members.length &&
          orderedRows.every(
            (row) => row.accountId == _accountId && row.deviceId == _deviceId,
          );
      if (!deviceScopeMatches ||
          !_unknownRetryRowsValid(
            [...orderedRows]
              ..sort((a, b) => a.deviceSequence.compareTo(b.deviceSequence)),
          )) {
        return FailedNotAppliedRecoveryInspection.blocked(
          diagnosticCode: 'MKS-REC-012',
          state: 'failed-not-applied-event-lineage-invalid',
          queueCounts: counts,
          candidateFingerprint: _fingerprint(submission.id),
          memberCount: members.length,
          membershipContiguous: membershipContiguous,
          deviceScopeMatches: deviceScopeMatches,
        );
      }
      final canonicalRows = [...orderedRows]
        ..sort((a, b) {
          final sequence = a.deviceSequence.compareTo(b.deviceSequence);
          return sequence != 0 ? sequence : a.id.compareTo(b.id);
        });
      final pendingRows =
          await (_db.select(_db.pendingEvents)..where(
                (table) =>
                    table.eventId.isIn(canonicalRows.map((row) => row.id)),
              ))
              .get();
      final pendingStates = pendingRows.map((row) => row.state).toSet();
      final noAcceptedMembers = !pendingStates.contains('accepted');
      final eventStatesCompatible =
          pendingRows.length == canonicalRows.length &&
          pendingStates.length == 1 &&
          pendingStates.single == 'failed';
      final activeMembers =
          await (_db.select(_db.syncSubmissionEvents).join([
                innerJoin(
                  _db.syncSubmissions,
                  _db.syncSubmissions.id.equalsExp(
                    _db.syncSubmissionEvents.submissionId,
                  ),
                ),
              ])..where(
                _db.syncSubmissionEvents.eventId.isIn(
                      canonicalRows.map((row) => row.id),
                    ) &
                    _db.syncSubmissions.id.isNotValue(submission.id) &
                    (_db.syncSubmissions.state.equals('uploading') |
                        _db.syncSubmissions.state.equals('unknown')),
              ))
              .get();
      final noActiveOverlap = activeMembers.isEmpty;
      final eventJson = canonicalRows
          .map((row) => jsonDecode(row.payloadJson) as Map<String, Object?>)
          .toList(growable: false);
      final requestHashMatches =
          canonicalUtf8Sha256({
            'deviceId': submission.deviceId,
            'events': eventJson,
            'submissionId': submission.id,
          }) ==
          submission.requestHash;
      final nextSequenceMatches =
          device.nextSequence == canonicalRows.last.deviceSequence + 1;
      final eligible =
          requestHashMatches &&
          eventStatesCompatible &&
          noAcceptedMembers &&
          noActiveOverlap &&
          nextSequenceMatches &&
          counts.failed == canonicalRows.length;
      if (!eligible) {
        return FailedNotAppliedRecoveryInspection.blocked(
          diagnosticCode: 'MKS-REC-012',
          state: 'failed-not-applied-candidate-invalid',
          queueCounts: counts,
          candidateFingerprint: _fingerprint(submission.id),
          memberCount: canonicalRows.length,
          firstDeviceSequence: canonicalRows.first.deviceSequence,
          lastDeviceSequence: canonicalRows.last.deviceSequence,
          nextDeviceSequence: device.nextSequence,
          requestHashMatches: requestHashMatches,
          membershipContiguous: membershipContiguous,
          deviceScopeMatches: deviceScopeMatches,
          eventStatesCompatible: eventStatesCompatible,
          noAcceptedMembers: noAcceptedMembers,
          noActiveOverlap: noActiveOverlap,
        );
      }
      return FailedNotAppliedRecoveryInspection.eligible(
        diagnosticCode: 'MKS-REC-001',
        candidateFingerprint: _fingerprint(submission.id),
        memberCount: canonicalRows.length,
        firstDeviceSequence: canonicalRows.first.deviceSequence,
        lastDeviceSequence: canonicalRows.last.deviceSequence,
        nextDeviceSequence: device.nextSequence,
        queueCounts: counts,
        requestHashMatches: true,
        membershipContiguous: true,
        deviceScopeMatches: true,
        eventStatesCompatible: true,
        noAcceptedMembers: true,
        noActiveOverlap: true,
      );
    });
  }

  @override
  Future<UnknownSubmissionRetryPreflight> unknownSubmissionRetryPreflight({
    required String authenticationState,
  }) {
    return _db.transaction(() async {
      if (authenticationState != 'authenticated') {
        return const UnknownSubmissionRetryPreflight.blocked(
          state: 'unknown-retry-authentication-required',
          guidance: 'sign-in-required',
        );
      }
      final hosted =
          await (_db.select(_db.hostedAuthStates)..where(
                (table) => table.environmentAlias.equals(_environmentAlias),
              ))
              .getSingleOrNull();
      if (hosted == null ||
          !_activeEnrollmentStates.contains(hosted.enrollmentState) ||
          hosted.accountId != _accountId ||
          hosted.serverDeviceId != _deviceId) {
        return const UnknownSubmissionRetryPreflight.blocked(
          state: 'unknown-retry-device-enrollment-required',
          guidance: 'enroll-or-query-device',
        );
      }
      final device =
          await (_db.select(_db.devices)..where(
                (table) =>
                    table.id.equals(_deviceId) &
                    table.accountId.equals(_accountId),
              ))
              .getSingleOrNull();
      if (device == null) {
        return const UnknownSubmissionRetryPreflight.blocked(
          state: 'unknown-retry-device-enrollment-required',
          guidance: 'enroll-or-query-device',
        );
      }
      final counts = await _queueCountsForDevice();
      if (counts.pending > 0 || counts.uploading > 0 || counts.failed > 0) {
        return const UnknownSubmissionRetryPreflight.blocked(
          state: 'unknown-retry-queue-not-isolated',
          guidance: 'review-local-sync-state-before-retry',
        );
      }
      final submissions =
          await (_db.select(_db.syncSubmissions)
                ..where(
                  (table) =>
                      table.accountId.equals(_accountId) &
                      table.deviceId.equals(_deviceId) &
                      table.state.equals('unknown'),
                )
                ..orderBy([
                  (table) => OrderingTerm.asc(table.createdAt),
                  (table) => OrderingTerm.asc(table.id),
                ]))
              .get();
      if (submissions.isEmpty) {
        return const UnknownSubmissionRetryPreflight.blocked(
          state: 'unknown-retry-no-unresolved-submission',
          guidance: 'no-local-sync-action-needed',
        );
      }
      if (submissions.length != 1) {
        return const UnknownSubmissionRetryPreflight.blocked(
          state: 'unknown-retry-ambiguous-unresolved-submission',
          guidance: 'review-local-sync-state-before-retry',
        );
      }
      final submission = submissions.single;
      final members =
          await (_db.select(_db.syncSubmissionEvents)
                ..where((table) => table.submissionId.equals(submission.id))
                ..orderBy([(table) => OrderingTerm.asc(table.position)]))
              .get();
      if (members.isEmpty || !_positionsAreContiguous(members)) {
        return _malformedUnknownRetry();
      }
      final rows =
          await (_db.select(_db.syncEvents)..where(
                (table) => table.id.isIn(
                  members.map((member) => member.eventId).toList(),
                ),
              ))
              .get();
      final rowsById = {for (final row in rows) row.id: row};
      final orderedRows = [
        for (final member in members) rowsById[member.eventId],
      ].nonNulls.toList(growable: false);
      if (orderedRows.length != members.length ||
          !_unknownRetryRowsValid(orderedRows)) {
        return _malformedUnknownRetry();
      }
      final memberIds = orderedRows.map((row) => row.id).toList();
      final pendingRows = await (_db.select(
        _db.pendingEvents,
      )..where((table) => table.eventId.isIn(memberIds))).get();
      if (pendingRows.length != memberIds.length ||
          pendingRows.any((row) => row.state != 'unknown')) {
        return _malformedUnknownRetry();
      }
      final eventJson = orderedRows
          .map((row) => jsonDecode(row.payloadJson) as Map<String, Object?>)
          .toList(growable: false);
      final requestHash = canonicalUtf8Sha256({
        'deviceId': submission.deviceId,
        'events': eventJson,
        'submissionId': submission.id,
      });
      if (requestHash != submission.requestHash ||
          device.nextSequence != orderedRows.last.deviceSequence + 1) {
        return _malformedUnknownRetry();
      }
      return UnknownSubmissionRetryPreflight.eligible(
        submissionFingerprint: _fingerprint(submission.id),
        eventCount: orderedRows.length,
        firstDeviceSequence: orderedRows.first.deviceSequence,
        lastDeviceSequence: orderedRows.last.deviceSequence,
        nextLocalDeviceSequence: device.nextSequence,
      );
    });
  }

  @override
  Future<ClosureDiagnosticsSnapshot> snapshot({
    required String authenticationState,
  }) async {
    final hosted =
        await (_db.select(_db.hostedAuthStates)..where(
              (table) => table.environmentAlias.equals(_environmentAlias),
            ))
            .getSingleOrNull();
    final devices =
        await (_db.select(_db.devices)
              ..where((table) => table.accountId.equals(_accountId))
              ..orderBy([
                (table) => OrderingTerm.desc(table.id.equals(_deviceId)),
                (table) => OrderingTerm.asc(table.createdAt),
                (table) => OrderingTerm.asc(table.id),
              ]))
            .get();
    final currentDevice = devices
        .where((device) => device.id == _deviceId)
        .firstOrNull;
    final counts = await _queueCounts();
    final attempts = await _recentAttempts();
    final diagnostics = await _recentDiagnosticEvents();
    final events = await _recentActionableEvents();
    final lastSuccess = await _lastSuccessfulSync();
    final enrollmentState = hosted?.enrollmentState ?? 'enrollment-required';
    final readiness = _readiness(authenticationState, enrollmentState, counts);
    final lastResult = attempts.isEmpty
        ? 'no-recorded-attempts'
        : attempts.first.resultCode;
    return ClosureDiagnosticsSnapshot(
      authenticationState: authenticationState,
      enrollmentState: enrollmentState,
      syncReadiness: readiness,
      lastResult: lastResult,
      queueCounts: counts,
      nextDeviceSequence: currentDevice?.nextSequence,
      lastSuccessfulSyncAt: lastSuccess,
      recoveryGuidance: _guidance(authenticationState, enrollmentState, counts),
      recentAttempts: attempts,
      recentDiagnostics: diagnostics,
      devices: [
        for (final device in devices)
          ClosureDeviceSummary(
            fingerprint: _fingerprint(device.id),
            isCurrent: device.id == _deviceId,
            enrollmentState: device.id == hosted?.serverDeviceId
                ? enrollmentState
                : 'local-only',
            nextSequence: device.nextSequence,
          ),
      ],
      actionableEvents: events,
      refreshedAt: _now(),
    );
  }

  Future<ClosureQueueCounts> _queueCounts() async {
    final rows = await (_db.select(_db.pendingEvents).join([
      innerJoin(
        _db.syncEvents,
        _db.syncEvents.id.equalsExp(_db.pendingEvents.eventId),
      ),
    ])..where(_db.syncEvents.accountId.equals(_accountId))).get();
    var pending = 0;
    var uploading = 0;
    var failed = 0;
    var unknown = 0;
    for (final row in rows) {
      switch (row.readTable(_db.pendingEvents).state) {
        case 'pending':
          pending++;
        case 'uploading':
          uploading++;
        case 'failed':
          failed++;
        case 'unknown':
          unknown++;
      }
    }
    return ClosureQueueCounts(
      pending: pending,
      uploading: uploading,
      failed: failed,
      unknown: unknown,
    );
  }

  Future<ClosureQueueCounts> _queueCountsForDevice() async {
    final rows =
        await (_db.select(_db.pendingEvents).join([
              innerJoin(
                _db.syncEvents,
                _db.syncEvents.id.equalsExp(_db.pendingEvents.eventId),
              ),
            ])..where(
              _db.syncEvents.accountId.equals(_accountId) &
                  _db.syncEvents.deviceId.equals(_deviceId),
            ))
            .get();
    return _countPendingRows(rows);
  }

  ClosureQueueCounts _countPendingRows(List<TypedResult> rows) {
    var pending = 0;
    var uploading = 0;
    var failed = 0;
    var unknown = 0;
    for (final row in rows) {
      switch (row.readTable(_db.pendingEvents).state) {
        case 'pending':
          pending++;
        case 'uploading':
          uploading++;
        case 'failed':
          failed++;
        case 'unknown':
          unknown++;
      }
    }
    return ClosureQueueCounts(
      pending: pending,
      uploading: uploading,
      failed: failed,
      unknown: unknown,
    );
  }

  Future<List<ClosureSyncAttemptSummary>> _recentAttempts() async {
    final rows =
        await (_db.select(_db.syncAttempts)
              ..where(
                (table) =>
                    table.accountId.equals(_accountId) &
                    table.environmentAlias.equals(_environmentAlias),
              )
              ..orderBy([
                (table) => OrderingTerm.desc(table.startedAt),
                (table) => OrderingTerm.desc(table.id),
              ])
              ..limit(20))
            .get();
    return [
      for (final row in rows)
        ClosureSyncAttemptSummary(
          fingerprint: _fingerprint('attempt:${row.id}'),
          startedAt: row.startedAt,
          completedAt: row.completedAt,
          duration: row.completedAt?.difference(row.startedAt),
          operationKind: row.operationKind ?? 'sync',
          phase: row.phase,
          latestStage: row.latestStage ?? row.phase,
          resultCode: row.resultCode,
          outcomeClass: row.outcomeClass,
          recoveryCode: row.recoveryCode,
          correlationFingerprint: row.correlationFingerprint,
          elapsedBand: row.elapsedBand,
          httpStatus: row.httpStatus,
          responseHeadersReceived: row.responseHeadersReceived,
        ),
    ];
  }

  Future<List<ClosureActionableEventSummary>> _recentActionableEvents() async {
    final rows =
        await (_db.select(_db.pendingEvents).join([
                innerJoin(
                  _db.syncEvents,
                  _db.syncEvents.id.equalsExp(_db.pendingEvents.eventId),
                ),
              ])
              ..where(
                _db.syncEvents.accountId.equals(_accountId) &
                    _db.pendingEvents.state.isIn([
                      'pending',
                      'failed',
                      'unknown',
                    ]),
              )
              ..orderBy([
                OrderingTerm.desc(_db.pendingEvents.enqueuedAt),
                OrderingTerm.asc(_db.syncEvents.deviceSequence),
                OrderingTerm.asc(_db.syncEvents.id),
              ])
              ..limit(20))
            .get();
    return [
      for (final row in rows)
        ClosureActionableEventSummary(
          fingerprint: _fingerprint(row.readTable(_db.syncEvents).id),
          eventType: row.readTable(_db.syncEvents).eventType,
          deviceSequence: row.readTable(_db.syncEvents).deviceSequence,
          state: row.readTable(_db.pendingEvents).state,
          enqueuedAt: row.readTable(_db.pendingEvents).enqueuedAt,
          occurredAt: row.readTable(_db.syncEvents).occurrenceTime,
        ),
    ];
  }

  Future<List<ClosureDiagnosticEventSummary>> _recentDiagnosticEvents() async {
    final rows =
        await (_db.select(_db.syncDiagnosticEvents).join([
                innerJoin(
                  _db.syncAttempts,
                  _db.syncAttempts.id.equalsExp(
                    _db.syncDiagnosticEvents.attemptId,
                  ),
                ),
              ])
              ..where(
                _db.syncAttempts.accountId.equals(_accountId) &
                    _db.syncAttempts.environmentAlias.equals(_environmentAlias),
              )
              ..orderBy([
                OrderingTerm.desc(_db.syncDiagnosticEvents.recordedAt),
                OrderingTerm.desc(_db.syncDiagnosticEvents.id),
              ])
              ..limit(30))
            .get();
    return [
      for (final row in rows)
        ClosureDiagnosticEventSummary(
          attemptFingerprint: _fingerprint(
            'attempt:${row.readTable(_db.syncAttempts).id}',
          ),
          diagnosticVersion: row
              .readTable(_db.syncDiagnosticEvents)
              .diagnosticVersion,
          ordinal: row.readTable(_db.syncDiagnosticEvents).ordinal,
          code: row.readTable(_db.syncDiagnosticEvents).code,
          nativeCode: row.readTable(_db.syncDiagnosticEvents).nativeCode,
          severity: row.readTable(_db.syncDiagnosticEvents).severity,
          outcome: row.readTable(_db.syncDiagnosticEvents).outcome,
          operationKind: row.readTable(_db.syncDiagnosticEvents).operationKind,
          phase: row.readTable(_db.syncDiagnosticEvents).phase,
          lastProvedPhase: row
              .readTable(_db.syncDiagnosticEvents)
              .lastProvedPhase,
          operationFingerprint: row
              .readTable(_db.syncDiagnosticEvents)
              .operationFingerprint,
          correlationFingerprint: row
              .readTable(_db.syncDiagnosticEvents)
              .correlationFingerprint,
          localMutationState: row
              .readTable(_db.syncDiagnosticEvents)
              .localMutationState,
          providerContactState: row
              .readTable(_db.syncDiagnosticEvents)
              .providerContactState,
          providerTransactionState: row
              .readTable(_db.syncDiagnosticEvents)
              .providerTransactionState,
          trustedResponseState: row
              .readTable(_db.syncDiagnosticEvents)
              .trustedResponseState,
          resultPersistenceState: row
              .readTable(_db.syncDiagnosticEvents)
              .resultPersistenceState,
          queueScope: row.readTable(_db.syncDiagnosticEvents).queueScope,
          pendingCount: row.readTable(_db.syncDiagnosticEvents).pendingCount,
          uploadingCount: row
              .readTable(_db.syncDiagnosticEvents)
              .uploadingCount,
          failedCount: row.readTable(_db.syncDiagnosticEvents).failedCount,
          unknownCount: row.readTable(_db.syncDiagnosticEvents).unknownCount,
          memberCount: row.readTable(_db.syncDiagnosticEvents).memberCount,
          firstDeviceSequence: row
              .readTable(_db.syncDiagnosticEvents)
              .firstDeviceSequence,
          lastDeviceSequence: row
              .readTable(_db.syncDiagnosticEvents)
              .lastDeviceSequence,
          nextDeviceSequence: row
              .readTable(_db.syncDiagnosticEvents)
              .nextDeviceSequence,
          httpStatus: row.readTable(_db.syncDiagnosticEvents).httpStatus,
          responseHeadersReceived: row
              .readTable(_db.syncDiagnosticEvents)
              .responseHeadersReceived,
          safeAction: row.readTable(_db.syncDiagnosticEvents).safeAction,
          retryable: row.readTable(_db.syncDiagnosticEvents).retryable,
          sanitizedExceptionClass: row
              .readTable(_db.syncDiagnosticEvents)
              .sanitizedExceptionClass,
        ),
    ];
  }

  Future<DateTime?> _lastSuccessfulSync() async {
    final row =
        await (_db.select(_db.syncAttempts)
              ..where(
                (table) =>
                    table.accountId.equals(_accountId) &
                    table.environmentAlias.equals(_environmentAlias) &
                    table.operationKind.equals('ordinary-sync') &
                    table.outcomeClass.equals('completed') &
                    table.resultCode.isIn([
                      'sync-completed',
                      'sync-no-new-events',
                    ]) &
                    table.completedAt.isNotNull(),
              )
              ..orderBy([
                (table) => OrderingTerm.desc(table.completedAt),
                (table) => OrderingTerm.desc(table.id),
              ])
              ..limit(1))
            .getSingleOrNull();
    return row?.completedAt;
  }

  String _readiness(
    String authenticationState,
    String enrollmentState,
    ClosureQueueCounts counts,
  ) {
    if (authenticationState != 'authenticated') {
      return 'authentication-required';
    }
    if (!_activeEnrollmentStates.contains(enrollmentState)) {
      return 'device-enrollment-required';
    }
    if (counts.unknown > 0) return 'unknown-work-needs-review';
    if (counts.failed > 0) return 'failed-work-needs-review';
    if (counts.uploading > 0) return 'upload-in-progress-or-interrupted';
    if (counts.pending > 0) return 'ready-with-pending-work';
    return 'ready-no-local-work';
  }

  String _guidance(
    String authenticationState,
    String enrollmentState,
    ClosureQueueCounts counts,
  ) {
    if (authenticationState != 'authenticated') return 'sign-in-required';
    if (!_activeEnrollmentStates.contains(enrollmentState)) {
      return 'enroll-or-query-device';
    }
    if (counts.unknown > 0 || counts.failed > 0) {
      return 'review-local-sync-state-before-retry';
    }
    if (counts.pending > 0) return 'sync-can-upload-local-work';
    return 'no-local-sync-action-needed';
  }

  bool _positionsAreContiguous(List<SyncSubmissionEvent> members) {
    final positions = <int>{};
    for (var i = 0; i < members.length; i++) {
      if (!positions.add(members[i].position) || members[i].position != i) {
        return false;
      }
    }
    return true;
  }

  bool _unknownRetryRowsValid(List<SyncEvent> rows) {
    if (rows.isEmpty) return false;
    final eventIds = <String>{};
    final sequences = <int>{};
    var previousSequence = rows.first.deviceSequence - 1;
    for (final row in rows) {
      if (row.accountId != _accountId ||
          row.deviceId != _deviceId ||
          !eventIds.add(row.id) ||
          !sequences.add(row.deviceSequence) ||
          row.deviceSequence != previousSequence + 1) {
        return false;
      }
      final payload = jsonDecode(row.payloadJson) as Map<String, Object?>;
      final content = Map<String, Object?>.from(payload)..remove('contentHash');
      if (payload['eventId'] != row.id ||
          payload['accountId'] != row.accountId ||
          payload['deviceId'] != row.deviceId ||
          payload['deviceSequence'] != row.deviceSequence ||
          payload['contentHash'] != row.contentHash ||
          canonicalUtf8Sha256(content) != row.contentHash) {
        return false;
      }
      previousSequence = row.deviceSequence;
    }
    return true;
  }

  UnknownSubmissionRetryPreflight _malformedUnknownRetry() {
    return const UnknownSubmissionRetryPreflight.blocked(
      state: 'unknown-retry-state-invalid',
      guidance: 'preserve-local-evidence-and-stop',
    );
  }
}

const _activeEnrollmentStates = {'device-enrolled', 'duplicate-equivalent'};

String _fingerprint(String value) {
  final digest = sha256.convert(utf8.encode(value)).toString();
  return digest.substring(0, 8);
}

String _sanitizeCode(String value) {
  final sanitized = value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9._:-]+'), '-')
      .replaceAll(RegExp('-+'), '-')
      .replaceAll(RegExp('^-|-\$'), '');
  if (sanitized.isEmpty) {
    return 'unavailable';
  }
  return sanitized.length <= 64 ? sanitized : sanitized.substring(0, 64);
}

String _sanitizeFingerprint(String value) {
  final sanitized = value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '')
      .trim();
  if (sanitized.isEmpty) return 'unavailable';
  return sanitized.length <= 16 ? sanitized : sanitized.substring(0, 16);
}

String _sanitizeIdentifier(String value) {
  final sanitized = value
      .replaceAll(RegExp(r'[^A-Za-z0-9._:-]+'), '-')
      .replaceAll(RegExp('-+'), '-')
      .replaceAll(RegExp('^-|-\$'), '')
      .trim();
  if (sanitized.isEmpty) return 'unavailable';
  return sanitized.length <= 96 ? sanitized : sanitized.substring(0, 96);
}

String _sanitizeMksCode(String value) {
  final match = RegExp(r'^MKS-[A-Z]+-[0-9]{3}$').firstMatch(value);
  return match == null ? 'MKS-INV-001' : value;
}

String _sanitizeSummary(String value) {
  final sanitized = value
      .replaceAll(RegExp(r'[\r\n\t]+'), ' ')
      .replaceAll(RegExp(r'[^A-Za-z0-9 ._:/#-]+'), '')
      .trim();
  if (sanitized.isEmpty) return 'preserve evidence and inspect diagnostics';
  return sanitized.length <= 160 ? sanitized : sanitized.substring(0, 160);
}

String _safeAuditCode(String value) {
  final sanitized = value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9._:-]+'), '-')
      .replaceAll(RegExp('-+'), '-')
      .replaceAll(RegExp('^-|-\$'), '')
      .trim();
  if (sanitized.isEmpty) return 'unavailable';
  return sanitized.length <= 64 ? sanitized : sanitized.substring(0, 64);
}

String _safeAuditText(String value) {
  final redacted = value
      .replaceAll(RegExp(r'https?://\S+', caseSensitive: false), '[url]')
      .replaceAll(RegExp(r'[A-Za-z]:\\[^\s]+'), '[path]')
      .replaceAll(RegExp(r'(/[A-Za-z0-9._-]+){2,}'), '[path]')
      .replaceAll(RegExp(r'\b[A-Fa-f0-9]{17,}\b'), '[reference]')
      .replaceAll(
        RegExp(r'\b(token|credential|secret|password)\b', caseSensitive: false),
        'redacted',
      )
      .replaceAll(
        RegExp(
          r'\bselect\b|\binsert\b|\bupdate\b|\bdelete\b',
          caseSensitive: false,
        ),
        'statement',
      )
      .replaceAll(RegExp(r'[\r\n\t]+'), ' ')
      .trim();
  if (redacted.isEmpty) return 'This technical detail was not recorded.';
  return redacted.length <= 180 ? redacted : redacted.substring(0, 180);
}

String? _shortReference(String? value) {
  if (value == null || value.trim().isEmpty) return null;
  final sanitized = value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '')
      .trim();
  if (sanitized.isEmpty) return null;
  final shortened = sanitized.length <= 8
      ? sanitized
      : sanitized.substring(0, 8);
  return '#$shortened';
}
