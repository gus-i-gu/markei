// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../application/hosted_auth_ports.dart';
import '../application/closure_diagnostics.dart';
import '../application/failed_not_applied_recovery_coordinator.dart';
import '../application/hosted_enrollment_coordinator.dart';
import '../application/hosted_connection_check.dart';
import '../application/hosted_sync_coordinator.dart';
import '../application/sync/sync_ports.dart';

typedef NativeClosureLifecycleSink = void Function(String line);

final class NativeAuthClosureRunner {
  NativeAuthClosureRunner({
    required ExternalAuthenticationSession authenticationSession,
    required HostedEnrollmentCoordinator enrollmentCoordinator,
    required String environmentAlias,
    required Future<DeviceEnrollmentCommand> Function() commandFactory,
    required ClosureDiagnosticsQuery diagnosticsQuery,
    required SyncAttemptRecorder syncAttemptRecorder,
    required HostedSyncCoordinator hostedSyncCoordinator,
    required FailedNotAppliedRecoveryCoordinator
    failedNotAppliedRecoveryCoordinator,
    required HostedConnectionCheckPort hostedConnectionCheck,
    NativeClosureLifecycleSink? lifecycleSink,
  }) : _authenticationSession = authenticationSession,
       _enrollmentCoordinator = enrollmentCoordinator,
       _environmentAlias = environmentAlias,
       _commandFactory = commandFactory,
       _diagnosticsQuery = diagnosticsQuery,
       _syncAttemptRecorder = syncAttemptRecorder,
       _hostedSyncCoordinator = hostedSyncCoordinator,
       _failedNotAppliedRecoveryCoordinator =
           failedNotAppliedRecoveryCoordinator,
       _hostedConnectionCheck = hostedConnectionCheck,
       _lifecycleSink = lifecycleSink ?? _terminalLifecycleSink,
       _unavailable = false,
       _uuid = const Uuid();

  const NativeAuthClosureRunner.unavailable()
    : _authenticationSession = null,
      _enrollmentCoordinator = null,
      _environmentAlias = '',
      _commandFactory = null,
      _diagnosticsQuery = null,
      _syncAttemptRecorder = null,
      _hostedSyncCoordinator = null,
      _failedNotAppliedRecoveryCoordinator = null,
      _hostedConnectionCheck = null,
      _lifecycleSink = null,
      _unavailable = true,
      _uuid = null;

  final ExternalAuthenticationSession? _authenticationSession;
  final HostedEnrollmentCoordinator? _enrollmentCoordinator;
  final String _environmentAlias;
  final Future<DeviceEnrollmentCommand> Function()? _commandFactory;
  final ClosureDiagnosticsQuery? _diagnosticsQuery;
  final SyncAttemptRecorder? _syncAttemptRecorder;
  final HostedSyncCoordinator? _hostedSyncCoordinator;
  final FailedNotAppliedRecoveryCoordinator?
  _failedNotAppliedRecoveryCoordinator;
  final HostedConnectionCheckPort? _hostedConnectionCheck;
  final NativeClosureLifecycleSink? _lifecycleSink;
  final bool _unavailable;
  final Uuid? _uuid;
  static const ordinarySyncClientDeadline = Duration(seconds: 35);

  int get ordinarySyncClientDeadlineMs =>
      ordinarySyncClientDeadline.inMilliseconds;

  @visibleForTesting
  static SyncDiagnosticPhaseEvidence debugMergeDiagnosticEvidenceForTest(
    Iterable<SyncDiagnosticPhaseEvidence> events,
  ) {
    var state = _CumulativeDiagnosticState.initial();
    for (final event in events) {
      state = state.merge(event);
    }
    return state.snapshot();
  }

  Future<NativeClosureStatus> status() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    final state = await _authenticationSession!.currentState();
    return NativeClosureStatus(_stateName(state));
  }

  Future<NativeClosureStatus> signIn() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    final state = await _authenticationSession!.signIn();
    return NativeClosureStatus(_stateName(state));
  }

  Future<NativeClosureStatus> enrollOrQueryDevice() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    final outcome = await _enrollmentCoordinator!.enroll(
      environmentAlias: _environmentAlias,
      command: await _commandFactory!(),
    );
    return NativeClosureStatus(_outcomeName(outcome));
  }

  Future<NativeClosureStatus> queryEnrollment() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    final outcome = await _enrollmentCoordinator!.replay(
      environmentAlias: _environmentAlias,
    );
    return NativeClosureStatus(_outcomeName(outcome));
  }

  Future<NativeClosureStatus> hostedSyncProbe() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    final recorder = _syncAttemptRecorder!;
    final coordinator = _hostedSyncCoordinator!;
    final operationId = _uuid!.v4();
    final operationFingerprint = _fingerprint(operationId);
    final stopwatch = Stopwatch()..start();
    _emitLifecycle(_lifecycleSink, {
      'timestamp': DateTime.now().toUtc().toIso8601String(),
      'event': 'operation-started',
      'declarationScope': 'client-operation',
      'operationKind': 'ordinary-sync',
      'resultCode': 'sync-started',
      'lastProvedPhase': 'started',
      'operationFingerprint': operationFingerprint,
      'correlationFingerprint': operationFingerprint,
      'configuredDeadlineMs': ordinarySyncClientDeadline.inMilliseconds,
      'elapsedBand': _elapsedBand(stopwatch.elapsed),
      'providerContactState': 'not-started',
      'trustedResponseState': 'not-received',
      'localMutationState': 'none',
      'resultPersistenceState': 'not-started',
      ..._planeLifecycleFields(
        _CumulativeDiagnosticState.initial().snapshot(),
        false,
      ),
      'safeNextActionCode': 'continue ordinary Sync',
    });
    int? attemptId;
    try {
      attemptId = await recorder.beginDiagnosticAttempt(
        operationKind: 'ordinary-sync',
        latestStage: 'started',
        resultCode: 'sync-started',
        outcomeClass: 'in-progress',
        correlationFingerprint: operationFingerprint,
      );
    } on Object {
      attemptId = null;
    }
    final diagnostics = _DiagnosticOperationRecorder(
      recorder: recorder,
      attemptId: attemptId,
      operationId: operationId,
      operationFingerprint: operationFingerprint,
      uuid: _uuid,
      lifecycleSink: _lifecycleSink,
      stopwatch: stopwatch,
      initialPersistenceDegraded: attemptId == null,
    );
    try {
      final outcome = await withSyncOperation(
        operationId: operationId,
        operationFingerprint: operationFingerprint,
        body: () =>
            coordinator.run(_environmentAlias, diagnostics: diagnostics),
      );
      await diagnostics.recordTerminal(outcome.state);
      final cumulative = diagnostics.strongestEvidence;
      if (attemptId != null) {
        try {
          await recorder.completeSyncAttempt(
            attemptId,
            resultCode: outcome.state,
            outcomeClass: _syncOutcomeClass(outcome.state),
            phase: _syncPhase(outcome.state),
            recoveryCode: _syncRecoveryCode(outcome.state),
          );
        } on Object {
          diagnostics.markPersistenceDegraded();
        }
      }
      _emitLifecycle(_lifecycleSink, {
        'timestamp': DateTime.now().toUtc().toIso8601String(),
        'event':
            outcome.state == 'sync-completed' ||
                outcome.state == 'sync-no-new-events'
            ? 'operation-completed'
            : 'operation-failed',
        'declarationScope': 'client-operation',
        'operationKind': 'ordinary-sync',
        'resultCode': outcome.state,
        'diagnosticCode': 'MKS-OBS-001',
        'lastProvedPhase':
            cumulative?.lastProvedPhase ?? _syncPhase(outcome.state),
        'operationFingerprint': operationFingerprint,
        'correlationFingerprint': operationFingerprint,
        'configuredDeadlineMs': ordinarySyncClientDeadline.inMilliseconds,
        'elapsedBand': _elapsedBand(stopwatch.elapsed),
        'providerContactState':
            cumulative?.providerContactState ?? 'see-causal-phase',
        'trustedResponseState':
            cumulative?.trustedResponseState ?? 'see-causal-phase',
        'localMutationState':
            cumulative?.localMutationState ?? 'see-causal-phase',
        'resultPersistenceState': diagnostics.persistenceDegraded
            ? 'diagnostics-persistence-degraded'
            : cumulative?.resultPersistenceState ?? 'committed',
        ..._planeLifecycleFields(cumulative, diagnostics.persistenceDegraded),
        'safeNextActionCode':
            _syncRecoveryCode(outcome.state) ?? 'no-further-action-required',
      });
      return NativeClosureStatus(outcome.state);
    } on Object catch (error) {
      final strongest = diagnostics.strongestEvidence;
      await diagnostics.recordPhase(
        SyncDiagnosticPhaseEvidence(
          code: 'MKS-UI-006',
          nativeCode: 'closure-runner-exception',
          severity: 'ERROR',
          operationKind: 'ordinary-sync',
          phase: 'terminal',
          lastProvedPhase: strongest?.lastProvedPhase ?? 'terminal',
          outcome: 'unknown',
          localMutationState: strongest?.localMutationState ?? 'unknown',
          providerContactState: strongest?.providerContactState ?? 'unknown',
          providerTransactionState:
              strongest?.providerTransactionState ?? 'unknown',
          trustedResponseState:
              strongest?.trustedResponseState ?? 'not-received',
          resultPersistenceState: 'failed',
          uploadRequestState: strongest?.uploadRequestState,
          uploadTrustedResponseState: strongest?.uploadTrustedResponseState,
          uploadProviderOutcome: strongest?.uploadProviderOutcome,
          uploadLeaseLocalState: strongest?.uploadLeaseLocalState,
          uploadResultPersistenceState: strongest?.uploadResultPersistenceState,
          downloadRequestState: strongest?.downloadRequestState,
          downloadTrustedResponseState: strongest?.downloadTrustedResponseState,
          inboundApplyState: strongest?.inboundApplyState,
          committedCursorProofState: strongest?.committedCursorProofState,
          acknowledgementRequestState: strongest?.acknowledgementRequestState,
          acknowledgementTrustedResponseState:
              strongest?.acknowledgementTrustedResponseState,
          acknowledgementOutcome: strongest?.acknowledgementOutcome,
          safeAction: 'preserve evidence and inspect diagnostics',
          retryable: false,
          sanitizedExceptionClass: _sanitizeExceptionClass(error),
        ),
      );
      final cumulative = diagnostics.strongestEvidence;
      if (attemptId != null) {
        try {
          await recorder.completeSyncAttempt(
            attemptId,
            resultCode: 'sync-failed',
            outcomeClass: 'failed',
            phase: cumulative?.lastProvedPhase ?? 'unexpected-terminal',
            recoveryCode: 'local-exception-redacted',
          );
        } on Object {
          diagnostics.markPersistenceDegraded();
        }
      }
      _emitLifecycle(_lifecycleSink, {
        'timestamp': DateTime.now().toUtc().toIso8601String(),
        'event': 'operation-failed',
        'declarationScope': 'client-operation',
        'operationKind': 'ordinary-sync',
        'resultCode': 'sync-failed',
        'diagnosticCode': 'MKS-UI-006',
        'lastProvedPhase': cumulative?.lastProvedPhase ?? 'unexpected-terminal',
        'operationFingerprint': operationFingerprint,
        'correlationFingerprint': operationFingerprint,
        'configuredDeadlineMs': ordinarySyncClientDeadline.inMilliseconds,
        'elapsedBand': _elapsedBand(stopwatch.elapsed),
        'providerContactState': cumulative?.providerContactState ?? 'unknown',
        'trustedResponseState':
            cumulative?.trustedResponseState ?? 'not-received',
        'localMutationState': cumulative?.localMutationState ?? 'unknown',
        'resultPersistenceState': diagnostics.persistenceDegraded
            ? 'diagnostics-persistence-degraded'
            : cumulative?.resultPersistenceState ?? 'failed',
        ..._planeLifecycleFields(cumulative, diagnostics.persistenceDegraded),
        'safeNextActionCode': 'preserve-evidence-and-inspect-diagnostics',
      });
      return const NativeClosureStatus('sync-failed');
    }
  }

  Future<NativeClosureStatus> checkHostedConnection() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    final check = _hostedConnectionCheck!;
    final recorder = _syncAttemptRecorder!;
    final correlation = check.createCorrelation();
    final attemptId = await recorder.beginDiagnosticAttempt(
      operationKind: 'hosted-connection-check',
      latestStage: 'preflight-passed',
      resultCode: 'hosted-connection-check-started',
      outcomeClass: 'in-progress',
      correlationFingerprint: correlation.fingerprint,
    );
    try {
      final result = await check.check(correlation);
      await recorder.completeDiagnosticAttempt(
        attemptId,
        operationKind: 'hosted-connection-check',
        latestStage: result.latestStage,
        resultCode: result.resultCode,
        outcomeClass: result.outcomeClass,
        recoveryCode: result.recoveryCode,
        correlationFingerprint: result.correlationFingerprint,
        elapsedBand: result.elapsedBand,
        httpStatus: result.httpStatus,
        responseHeadersReceived: result.responseHeadersReceived,
      );
      return NativeClosureStatus(result.resultCode);
    } on Object {
      await recorder.completeDiagnosticAttempt(
        attemptId,
        operationKind: 'hosted-connection-check',
        latestStage: 'closure-failed',
        resultCode: 'closure-failed',
        outcomeClass: 'unavailable',
        recoveryCode: 'local-exception-redacted',
        correlationFingerprint: correlation.fingerprint,
        elapsedBand: 'not-recorded',
        responseHeadersReceived: false,
      );
      return const NativeClosureStatus('closure-failed');
    }
  }

  Future<UnknownSubmissionRetryPreflight> unknownRetryPreflight() async {
    if (_unavailable) {
      return const UnknownSubmissionRetryPreflight.blocked(
        state: 'configuration-missing',
        guidance: 'configuration-required',
      );
    }
    final auth = await _authenticationSession!.currentState();
    return _diagnosticsQuery!.unknownSubmissionRetryPreflight(
      authenticationState: _stateName(auth),
    );
  }

  Future<NativeClosureFailedInspection>
  inspectFailedNotAppliedRecovery() async {
    if (_unavailable) {
      return const NativeClosureFailedInspection(
        state: 'configuration-missing',
        diagnosticCode: 'MKS-CFG-001',
        operationFingerprint: 'unavailable',
        inspection: null,
      );
    }
    final uuid = _uuid!;
    final operationFingerprint = _operationFingerprint();
    final operationId = uuid.v4();
    final childId = uuid.v4();
    final childFingerprint = _fingerprint(childId);
    final recorder = _syncAttemptRecorder!;
    final attemptId = await recorder.beginDiagnosticAttempt(
      operationKind: 'failed-not-applied-inspection',
      latestStage: 'failed-recovery-preflight',
      resultCode: 'failed-not-applied-inspection-started',
      outcomeClass: 'in-progress',
      correlationFingerprint: operationFingerprint,
    );
    try {
      final auth = await _authenticationSession!.currentState();
      final inspection = await _diagnosticsQuery!
          .inspectFailedNotAppliedRecovery(
            authenticationState: _stateName(auth),
            operationFingerprint: operationFingerprint,
          );
      await recorder.recordDiagnosticEvent(
        SyncDiagnosticEnvelope(
          attemptId: attemptId,
          diagnosticVersion: 1,
          ordinal: 1,
          operationId: operationId,
          correlationId: childId,
          code: inspection.diagnosticCode,
          nativeCode: inspection.state,
          severity: inspection.eligible ? 'INFO' : 'ERROR',
          outcome: inspection.eligible ? 'not-applied' : 'blocked',
          operationKind: 'failed-not-applied-inspection',
          phase: 'failed-recovery-preflight',
          lastProvedPhase: 'failed-recovery-preflight',
          operationFingerprint: operationFingerprint,
          correlationFingerprint: childFingerprint,
          accountFingerprint: null,
          deviceFingerprint: null,
          submissionFingerprint: inspection.candidateFingerprint,
          localMutationState: 'none',
          providerContactState: 'not-started',
          providerTransactionState: 'not-started',
          trustedResponseState: 'not-received',
          resultPersistenceState: 'not-started',
          queueScope: 'current-device',
          pendingCount: inspection.queueCounts.pending,
          uploadingCount: inspection.queueCounts.uploading,
          failedCount: inspection.queueCounts.failed,
          unknownCount: inspection.queueCounts.unknown,
          memberCount: inspection.memberCount,
          firstDeviceSequence: inspection.firstDeviceSequence,
          lastDeviceSequence: inspection.lastDeviceSequence,
          nextDeviceSequence: inspection.nextDeviceSequence,
          httpStatus: null,
          responseHeadersReceived: false,
          safeAction: inspection.eligible
              ? 'hold for Gate 12.7 reconciliation; do not execute recovery'
              : 'preserve evidence and inspect diagnostics',
          retryable: false,
          sanitizedExceptionClass: null,
          serverSqlstateClass: null,
        ),
      );
      await recorder.completeDiagnosticAttempt(
        attemptId,
        operationKind: 'failed-not-applied-inspection',
        latestStage: 'failed-recovery-preflight',
        resultCode: inspection.state,
        outcomeClass: inspection.eligible ? 'completed' : 'blocked',
        recoveryCode: inspection.eligible
            ? 'gate-12-7-held-for-reconciliation'
            : 'review-local-sync-state-before-retry',
        correlationFingerprint: operationFingerprint,
        elapsedBand: 'local-only',
        responseHeadersReceived: false,
      );
      return NativeClosureFailedInspection(
        state: inspection.state,
        diagnosticCode: inspection.diagnosticCode,
        operationFingerprint: operationFingerprint,
        inspection: inspection,
      );
    } on Object catch (error) {
      final childId = uuid.v4();
      await recorder.recordDiagnosticEvent(
        SyncDiagnosticEnvelope(
          attemptId: attemptId,
          diagnosticVersion: 1,
          ordinal: 1,
          operationId: operationId,
          correlationId: childId,
          code: 'MKS-UI-006',
          nativeCode: 'closure-runner-exception',
          severity: 'ERROR',
          outcome: 'unknown',
          operationKind: 'failed-not-applied-inspection',
          phase: 'presentation',
          lastProvedPhase: 'presentation',
          operationFingerprint: operationFingerprint,
          correlationFingerprint: _fingerprint(childId),
          accountFingerprint: null,
          deviceFingerprint: null,
          submissionFingerprint: null,
          localMutationState: 'none',
          providerContactState: 'not-started',
          providerTransactionState: 'not-started',
          trustedResponseState: 'not-received',
          resultPersistenceState: 'failed',
          queueScope: 'current-device',
          pendingCount: null,
          uploadingCount: null,
          failedCount: null,
          unknownCount: null,
          memberCount: null,
          firstDeviceSequence: null,
          lastDeviceSequence: null,
          nextDeviceSequence: null,
          httpStatus: null,
          responseHeadersReceived: false,
          safeAction: 'preserve evidence and inspect diagnostics',
          retryable: false,
          sanitizedExceptionClass: error.runtimeType.toString(),
          serverSqlstateClass: null,
        ),
      );
      await recorder.completeDiagnosticAttempt(
        attemptId,
        operationKind: 'failed-not-applied-inspection',
        latestStage: 'presentation',
        resultCode: 'closure-runner-exception',
        outcomeClass: 'unknown',
        recoveryCode: 'local-exception-redacted',
        correlationFingerprint: operationFingerprint,
        elapsedBand: 'local-only',
        responseHeadersReceived: false,
      );
      return NativeClosureFailedInspection(
        state: 'closure-runner-exception',
        diagnosticCode: 'MKS-UI-006',
        operationFingerprint: operationFingerprint,
        inspection: null,
      );
    }
  }

  Future<NativeClosureStatus> retryUnresolvedSubmission() async {
    final preflight = await unknownRetryPreflight();
    if (!preflight.eligible) {
      return NativeClosureStatus(preflight.state);
    }
    return hostedSyncProbe();
  }

  Future<NativeClosureFailedRecovery> recoverFailedNotAppliedCandidate(
    FailedNotAppliedRecoveryInspection confirmedInspection,
  ) async {
    if (_unavailable) {
      return const NativeClosureFailedRecovery(
        state: 'configuration-missing',
        diagnosticCode: 'MKS-CFG-001',
        operationFingerprint: 'unavailable',
      );
    }
    final uuid = _uuid!;
    final operationId = uuid.v4();
    final operationFingerprint = _fingerprint(operationId);
    final stopwatch = Stopwatch()..start();
    final recorder = _syncAttemptRecorder!;
    final attemptId = await recorder.beginDiagnosticAttempt(
      operationKind: 'failed-not-applied-recovery',
      latestStage: 'authorization-preflight',
      resultCode: 'failed-not-applied-recovery-started',
      outcomeClass: 'in-progress',
      correlationFingerprint: operationFingerprint,
    );
    final diagnostics = _DiagnosticOperationRecorder(
      recorder: recorder,
      attemptId: attemptId,
      operationId: operationId,
      operationFingerprint: operationFingerprint,
      uuid: uuid,
      lifecycleSink: _lifecycleSink,
      stopwatch: stopwatch,
    );
    try {
      final outcome = await _failedNotAppliedRecoveryCoordinator!.run(
        environmentAlias: _environmentAlias,
        confirmedInspection: confirmedInspection,
        operationFingerprint: operationFingerprint,
        diagnostics: diagnostics,
      );
      await recorder.completeDiagnosticAttempt(
        attemptId,
        operationKind: 'failed-not-applied-recovery',
        latestStage: 'upload-result-persistence',
        resultCode: outcome.state,
        outcomeClass: outcome.state.contains('persisted')
            ? 'completed'
            : outcome.state.contains('blocked')
            ? 'blocked'
            : 'unknown',
        recoveryCode: 'stop-after-upload-result-persistence',
        correlationFingerprint: operationFingerprint,
        elapsedBand: 'local-or-one-upload',
        responseHeadersReceived: false,
      );
      return NativeClosureFailedRecovery(
        state: outcome.state,
        diagnosticCode: 'MKS-OBS-001',
        operationFingerprint: operationFingerprint,
      );
    } on Object catch (error) {
      await diagnostics.recordPhase(
        SyncDiagnosticPhaseEvidence(
          code: 'MKS-UI-006',
          nativeCode: 'closure-runner-exception',
          severity: 'ERROR',
          operationKind: 'failed-not-applied-recovery',
          phase: 'terminal',
          lastProvedPhase: 'terminal',
          outcome: 'unknown',
          localMutationState: 'unknown',
          providerContactState: 'unknown',
          providerTransactionState: 'unknown',
          trustedResponseState: 'not-received',
          resultPersistenceState: 'failed',
          safeAction: 'preserve evidence and inspect diagnostics',
          retryable: false,
          sanitizedExceptionClass: error.runtimeType.toString(),
        ),
      );
      await recorder.completeDiagnosticAttempt(
        attemptId,
        operationKind: 'failed-not-applied-recovery',
        latestStage: 'terminal',
        resultCode: 'closure-runner-exception',
        outcomeClass: 'unknown',
        recoveryCode: 'local-exception-redacted',
        correlationFingerprint: operationFingerprint,
        elapsedBand: 'local-or-one-upload',
        responseHeadersReceived: false,
      );
      return NativeClosureFailedRecovery(
        state: 'closure-runner-exception',
        diagnosticCode: 'MKS-UI-006',
        operationFingerprint: operationFingerprint,
      );
    }
  }

  String _operationFingerprint() {
    final seed =
        '${DateTime.now().toUtc().microsecondsSinceEpoch}:${_uuid!.v4()}';
    return sha256.convert(utf8.encode(seed)).toString().substring(0, 12);
  }

  String _fingerprint(String value) {
    return sha256.convert(utf8.encode(value)).toString().substring(0, 12);
  }

  Future<NativeClosureStatus> logout() async {
    if (_unavailable) {
      return const NativeClosureStatus('configuration-missing');
    }
    await _authenticationSession!.logout();
    return const NativeClosureStatus('signed-out-cleared');
  }

  Future<ClosureDiagnosticsSnapshot?> diagnostics() async {
    if (_unavailable) return null;
    final auth = await _authenticationSession!.currentState();
    return _diagnosticsQuery!.snapshot(authenticationState: _stateName(auth));
  }

  Future<void> clearDiagnosticHistory() async {
    if (_unavailable) return;
    await _diagnosticsQuery!.clearAttemptHistory();
  }

  static String _stateName(ExternalAuthenticationState state) {
    return switch (state) {
      SignedOut() => 'signed-out',
      SigningIn() => 'signing-in',
      SignInCancelled() => 'sign-in-cancelled',
      SignedIn() => 'authenticated',
      TokenExpired() => 'token-expired',
      AuthenticationRejected(:final code) => code,
      ProviderUnavailable() => 'provider-unavailable',
    };
  }

  static String _outcomeName(HostedEnrollmentOutcome outcome) {
    return switch (outcome.status) {
      'hosted-restart-required' => 'hosted-restart-required',
      'applied' => 'device-enrolled',
      'duplicate-equivalent' => 'device-enrolled',
      'unknown' => 'sync-interrupted',
      _ => outcome.reason ?? 'sync-unavailable',
    };
  }

  static String _syncOutcomeClass(String state) {
    return switch (state) {
      'sync-completed' || 'sync-no-new-events' => 'completed',
      'sync-rejected' => 'rejected',
      'sync-server-timeout' => 'timeout',
      'sync-failed' => 'failed',
      'authentication-required' => 'blocked',
      'device-enrollment-required' || 'device-revoked' => 'blocked',
      _ => 'failed',
    };
  }

  static String _syncPhase(String state) {
    return switch (state) {
      'sync-completed' || 'sync-no-new-events' => 'completed',
      'sync-server-timeout' => 'server-timeout',
      'sync-failed' => 'terminal',
      'sync-rejected' => 'rejected',
      'authentication-required' => 'authentication',
      'device-enrollment-required' || 'device-revoked' => 'enrollment',
      _ => 'sync',
    };
  }

  static String? _syncRecoveryCode(String state) {
    return switch (state) {
      'sync-completed' || 'sync-no-new-events' => null,
      'authentication-required' => 'sign-in-required',
      'device-enrollment-required' => 'enroll-or-query-device',
      'device-revoked' => 'device-not-allowed',
      'sync-rejected' => 'preserve-evidence-and-review-rejection',
      'sync-server-timeout' => 'preserve-evidence-and-review-server-deadline',
      'sync-failed' => 'preserve-evidence-and-inspect-diagnostics',
      _ => 'provider-evidence-unavailable',
    };
  }
}

final class _DiagnosticOperationRecorder
    implements SyncDiagnosticPhaseRecorder {
  _DiagnosticOperationRecorder({
    required this.recorder,
    required this.attemptId,
    required this.operationId,
    required this.operationFingerprint,
    required this.uuid,
    required this.lifecycleSink,
    required this.stopwatch,
    bool initialPersistenceDegraded = false,
  }) : _persistenceDegraded = initialPersistenceDegraded;

  final SyncAttemptRecorder recorder;
  final int? attemptId;
  final String operationId;
  final String operationFingerprint;
  final Uuid uuid;
  final NativeClosureLifecycleSink? lifecycleSink;
  final Stopwatch stopwatch;
  int _ordinal = 0;
  int? _causalOrdinal;
  _CumulativeDiagnosticState? _state;
  bool _persistenceDegraded;

  SyncDiagnosticPhaseEvidence? get strongestEvidence => _state?.snapshot();

  bool get persistenceDegraded => _persistenceDegraded;

  void markPersistenceDegraded() {
    _persistenceDegraded = true;
  }

  @override
  Future<SyncDiagnosticChildIdentity> recordPhase(
    SyncDiagnosticPhaseEvidence evidence,
  ) async {
    final correlationId = uuid.v4();
    final fingerprint = _fingerprint(correlationId);
    final ordinal = ++_ordinal;
    if (evidence.severity != 'INFO' && _causalOrdinal == null) {
      _causalOrdinal = ordinal;
    }
    _state = (_state ?? _CumulativeDiagnosticState.initial()).merge(evidence);
    final id = attemptId;
    if (id != null) {
      try {
        await recorder.recordDiagnosticEvent(
          SyncDiagnosticEnvelope(
            attemptId: id,
            diagnosticVersion: 1,
            ordinal: ordinal,
            operationId: operationId,
            correlationId: correlationId,
            code: evidence.code,
            nativeCode: evidence.nativeCode,
            severity: evidence.severity,
            outcome: evidence.outcome,
            operationKind: evidence.operationKind,
            phase: evidence.phase,
            lastProvedPhase: evidence.lastProvedPhase,
            operationFingerprint: operationFingerprint,
            correlationFingerprint: fingerprint,
            accountFingerprint: null,
            deviceFingerprint: null,
            submissionFingerprint: evidence.submissionFingerprint,
            localMutationState: evidence.localMutationState,
            providerContactState: evidence.providerContactState,
            providerTransactionState: evidence.providerTransactionState,
            trustedResponseState: evidence.trustedResponseState,
            resultPersistenceState: evidence.resultPersistenceState,
            queueScope: evidence.queueScope,
            pendingCount: evidence.pendingCount,
            uploadingCount: evidence.uploadingCount,
            failedCount: evidence.failedCount,
            unknownCount: evidence.unknownCount,
            memberCount: evidence.memberCount,
            firstDeviceSequence: evidence.firstDeviceSequence,
            lastDeviceSequence: evidence.lastDeviceSequence,
            nextDeviceSequence: evidence.nextDeviceSequence,
            httpStatus: evidence.httpStatus,
            responseHeadersReceived: evidence.responseHeadersReceived,
            safeAction: evidence.safeAction,
            retryable: evidence.retryable,
            sanitizedExceptionClass: evidence.sanitizedExceptionClass,
            serverSqlstateClass: evidence.serverSqlstateClass,
          ),
        );
      } on Object {
        markPersistenceDegraded();
      }
    }
    _emitLifecycle(lifecycleSink, {
      'timestamp': DateTime.now().toUtc().toIso8601String(),
      'event': evidence.phase == 'terminal'
          ? 'phase-terminal'
          : 'phase-completed',
      'declarationScope': 'client-phase',
      'operationKind': evidence.operationKind,
      'resultCode': evidence.nativeCode,
      'diagnosticCode': evidence.code,
      'lastProvedPhase': evidence.lastProvedPhase,
      'operationFingerprint': operationFingerprint,
      'correlationFingerprint': fingerprint,
      'configuredDeadlineMs': evidence.operationKind == 'ordinary-sync'
          ? NativeAuthClosureRunner.ordinarySyncClientDeadline.inMilliseconds
          : null,
      'elapsedBand': _elapsedBand(stopwatch.elapsed),
      'providerContactState':
          strongestEvidence?.providerContactState ??
          evidence.providerContactState,
      'trustedResponseState':
          strongestEvidence?.trustedResponseState ??
          evidence.trustedResponseState,
      'localMutationState':
          strongestEvidence?.localMutationState ?? evidence.localMutationState,
      'resultPersistenceState': _persistenceDegraded
          ? 'diagnostics-persistence-degraded'
          : strongestEvidence?.resultPersistenceState ??
                evidence.resultPersistenceState,
      ..._planeLifecycleFields(strongestEvidence, _persistenceDegraded),
      'safeNextActionCode':
          strongestEvidence?.safeAction ?? evidence.safeAction,
    });
    return SyncDiagnosticChildIdentity(
      correlationId: correlationId,
      correlationFingerprint: fingerprint,
      ordinal: ordinal,
    );
  }

  Future<void> recordTerminal(String state) async {
    await recordPhase(
      SyncDiagnosticPhaseEvidence(
        code: 'MKS-OBS-001',
        nativeCode:
            'client-operation-declaration:$state:scope-client-operation:'
            'deadline-ms-${NativeAuthClosureRunner.ordinarySyncClientDeadline.inMilliseconds}:'
            'causal-ordinal-${_causalOrdinal ?? 'none'}',
        operationKind: 'ordinary-sync',
        phase: 'terminal',
        lastProvedPhase: strongestEvidence?.lastProvedPhase ?? 'terminal',
        outcome: state == 'sync-completed' || state == 'sync-no-new-events'
            ? 'applied'
            : state == 'sync-rejected'
            ? 'notApplied'
            : 'unknown',
        localMutationState:
            strongestEvidence?.localMutationState ?? 'see-causal-event',
        providerContactState:
            strongestEvidence?.providerContactState ?? 'see-causal-event',
        providerTransactionState:
            strongestEvidence?.providerTransactionState ?? 'see-causal-event',
        trustedResponseState:
            strongestEvidence?.trustedResponseState ?? 'see-causal-event',
        resultPersistenceState: _persistenceDegraded
            ? 'diagnostics-persistence-degraded'
            : strongestEvidence?.resultPersistenceState ?? 'see-causal-event',
        uploadRequestState: strongestEvidence?.uploadRequestState,
        uploadTrustedResponseState:
            strongestEvidence?.uploadTrustedResponseState,
        uploadProviderOutcome: strongestEvidence?.uploadProviderOutcome,
        uploadLeaseLocalState: strongestEvidence?.uploadLeaseLocalState,
        uploadResultPersistenceState:
            strongestEvidence?.uploadResultPersistenceState,
        downloadRequestState: strongestEvidence?.downloadRequestState,
        downloadTrustedResponseState:
            strongestEvidence?.downloadTrustedResponseState,
        inboundApplyState: strongestEvidence?.inboundApplyState,
        committedCursorProofState: strongestEvidence?.committedCursorProofState,
        acknowledgementRequestState:
            strongestEvidence?.acknowledgementRequestState,
        acknowledgementTrustedResponseState:
            strongestEvidence?.acknowledgementTrustedResponseState,
        acknowledgementOutcome: strongestEvidence?.acknowledgementOutcome,
        safeAction:
            'client declaration only; inspect causal diagnostic before action',
        retryable: false,
      ),
    );
  }

  String _fingerprint(String value) {
    return sha256.convert(utf8.encode(value)).toString().substring(0, 12);
  }
}

final class _CumulativeDiagnosticState {
  const _CumulativeDiagnosticState({
    required this.code,
    required this.nativeCode,
    required this.severity,
    required this.outcome,
    required this.operationKind,
    required this.phase,
    required this.lastProvedPhase,
    required this.localMutationState,
    required this.providerContactState,
    required this.providerTransactionState,
    required this.trustedResponseState,
    required this.resultPersistenceState,
    required this.uploadRequestState,
    required this.uploadTrustedResponseState,
    required this.uploadProviderOutcome,
    required this.uploadLeaseLocalState,
    required this.uploadResultPersistenceState,
    required this.downloadRequestState,
    required this.downloadTrustedResponseState,
    required this.inboundApplyState,
    required this.committedCursorProofState,
    required this.acknowledgementRequestState,
    required this.acknowledgementTrustedResponseState,
    required this.acknowledgementOutcome,
    required this.safeAction,
    required this.retryable,
    required this.httpStatus,
    required this.responseHeadersReceived,
    required this.sanitizedExceptionClass,
    required this.serverSqlstateClass,
    required this.queueScope,
    required this.pendingCount,
    required this.uploadingCount,
    required this.failedCount,
    required this.unknownCount,
    required this.memberCount,
    required this.firstDeviceSequence,
    required this.lastDeviceSequence,
    required this.nextDeviceSequence,
    required this.submissionFingerprint,
  });

  factory _CumulativeDiagnosticState.initial() =>
      const _CumulativeDiagnosticState(
        code: 'MKS-OBS-001',
        nativeCode: 'operation-state-initialized',
        severity: 'INFO',
        outcome: 'unknown',
        operationKind: 'ordinary-sync',
        phase: 'started',
        lastProvedPhase: 'started',
        localMutationState: 'none',
        providerContactState: 'not-started',
        providerTransactionState: 'not-started',
        trustedResponseState: 'not-received',
        resultPersistenceState: 'not-started',
        uploadRequestState: 'not-started',
        uploadTrustedResponseState: 'not-received',
        uploadProviderOutcome: 'not-started',
        uploadLeaseLocalState: 'not-started',
        uploadResultPersistenceState: 'not-started',
        downloadRequestState: 'not-started',
        downloadTrustedResponseState: 'not-received',
        inboundApplyState: 'not-started',
        committedCursorProofState: 'unknown',
        acknowledgementRequestState: 'not-started',
        acknowledgementTrustedResponseState: 'not-received',
        acknowledgementOutcome: 'not-started',
        safeAction: 'continue ordinary Sync',
        retryable: false,
        httpStatus: null,
        responseHeadersReceived: false,
        sanitizedExceptionClass: null,
        serverSqlstateClass: null,
        queueScope: null,
        pendingCount: null,
        uploadingCount: null,
        failedCount: null,
        unknownCount: null,
        memberCount: null,
        firstDeviceSequence: null,
        lastDeviceSequence: null,
        nextDeviceSequence: null,
        submissionFingerprint: null,
      );

  final String code;
  final String nativeCode;
  final String severity;
  final String outcome;
  final String operationKind;
  final String phase;
  final String lastProvedPhase;
  final String localMutationState;
  final String providerContactState;
  final String providerTransactionState;
  final String trustedResponseState;
  final String resultPersistenceState;
  final String uploadRequestState;
  final String uploadTrustedResponseState;
  final String uploadProviderOutcome;
  final String uploadLeaseLocalState;
  final String uploadResultPersistenceState;
  final String downloadRequestState;
  final String downloadTrustedResponseState;
  final String inboundApplyState;
  final String committedCursorProofState;
  final String acknowledgementRequestState;
  final String acknowledgementTrustedResponseState;
  final String acknowledgementOutcome;
  final String safeAction;
  final bool retryable;
  final int? httpStatus;
  final bool responseHeadersReceived;
  final String? sanitizedExceptionClass;
  final String? serverSqlstateClass;
  final String? queueScope;
  final int? pendingCount;
  final int? uploadingCount;
  final int? failedCount;
  final int? unknownCount;
  final int? memberCount;
  final int? firstDeviceSequence;
  final int? lastDeviceSequence;
  final int? nextDeviceSequence;
  final String? submissionFingerprint;

  _CumulativeDiagnosticState merge(SyncDiagnosticPhaseEvidence evidence) {
    final mergedUploadProvider = _mergePlaneOutcome(
      uploadProviderOutcome,
      evidence.uploadProviderOutcome,
      commitValues: const {'committed'},
      rejectValues: const {'rejected'},
    );
    final mergedUploadLease = _mergePlaneOutcome(
      uploadLeaseLocalState,
      evidence.uploadLeaseLocalState,
      commitValues: const {'committed'},
      rejectValues: const {'failed'},
    );
    final mergedUploadResultPersistence = _mergePlaneOutcome(
      uploadResultPersistenceState,
      evidence.uploadResultPersistenceState,
      commitValues: const {'committed'},
      rejectValues: const {'failed'},
      startedValue: 'started',
    );
    final mergedInboundApply = _mergePlaneOutcome(
      inboundApplyState,
      evidence.inboundApplyState,
      commitValues: const {'committed'},
      rejectValues: const {'rolled-back'},
    );
    final mergedAcknowledgementOutcome = _mergePlaneOutcome(
      acknowledgementOutcome,
      evidence.acknowledgementOutcome,
      commitValues: const {'applied'},
      rejectValues: const {'rejected'},
    );
    final mergedCursorProof = _mergeCursorProof(
      committedCursorProofState,
      evidence.committedCursorProofState,
    );
    final mergedAcknowledgementRequest = _mergeRequestState(
      acknowledgementRequestState,
      evidence.acknowledgementRequestState,
    );
    final invariant =
        mergedUploadProvider == 'diagnostic-invariant-conflict' ||
        mergedUploadLease == 'diagnostic-invariant-conflict' ||
        mergedUploadResultPersistence == 'diagnostic-invariant-conflict' ||
        mergedInboundApply == 'diagnostic-invariant-conflict' ||
        mergedAcknowledgementOutcome == 'diagnostic-invariant-conflict' ||
        _isInvalidAcknowledgementStart(
          inboundApply: mergedInboundApply,
          cursorProof: mergedCursorProof,
          acknowledgementRequest: mergedAcknowledgementRequest,
        );
    final mergedGenericMutation = _projectLegacyLocalMutation(
      uploadLease: mergedUploadLease,
      uploadResultPersistence: mergedUploadResultPersistence,
      inboundApply: mergedInboundApply,
    );
    final mergedGenericTransaction = _projectLegacyProviderTransaction(
      uploadProvider: mergedUploadProvider,
      acknowledgementOutcome: mergedAcknowledgementOutcome,
    );
    final mergedGenericTrustedResponse = _projectLegacyTrustedResponse(
      uploadTrustedResponse: _mergeTrustedResponse(
        uploadTrustedResponseState,
        evidence.uploadTrustedResponseState ?? 'not-received',
      ),
      downloadTrustedResponse: _mergeTrustedResponse(
        downloadTrustedResponseState,
        evidence.downloadTrustedResponseState ?? 'not-received',
      ),
      acknowledgementTrustedResponse: _mergeTrustedResponse(
        acknowledgementTrustedResponseState,
        evidence.acknowledgementTrustedResponseState ?? 'not-received',
      ),
    );
    return _CumulativeDiagnosticState(
      code: invariant ? 'MKS-OBS-001' : evidence.code,
      nativeCode: invariant
          ? 'diagnostic-causal-invariant-conflict'
          : evidence.nativeCode,
      severity: invariant
          ? 'ERROR'
          : _mergeSeverity(severity, evidence.severity),
      outcome: invariant ? 'unknown' : _mergeOutcome(outcome, evidence.outcome),
      operationKind: evidence.operationKind,
      phase: evidence.phase,
      lastProvedPhase: _mergeLastProvedPhase(
        lastProvedPhase,
        evidence.lastProvedPhase,
      ),
      localMutationState: invariant
          ? 'diagnostic-invariant-conflict'
          : mergedGenericMutation,
      providerContactState: _mergeProviderContact(
        providerContactState,
        evidence.providerContactState,
      ),
      providerTransactionState: invariant
          ? 'diagnostic-invariant-conflict'
          : mergedGenericTransaction,
      trustedResponseState: mergedGenericTrustedResponse,
      resultPersistenceState: _mergeResultPersistence(
        resultPersistenceState,
        evidence.resultPersistenceState,
      ),
      uploadRequestState: _mergeRequestState(
        uploadRequestState,
        evidence.uploadRequestState,
      ),
      uploadTrustedResponseState: _mergeTrustedResponse(
        uploadTrustedResponseState,
        evidence.uploadTrustedResponseState ?? 'not-received',
      ),
      uploadProviderOutcome: mergedUploadProvider,
      uploadLeaseLocalState: mergedUploadLease,
      uploadResultPersistenceState: mergedUploadResultPersistence,
      downloadRequestState: _mergeRequestState(
        downloadRequestState,
        evidence.downloadRequestState,
      ),
      downloadTrustedResponseState: _mergeTrustedResponse(
        downloadTrustedResponseState,
        evidence.downloadTrustedResponseState ?? 'not-received',
      ),
      inboundApplyState: mergedInboundApply,
      committedCursorProofState: mergedCursorProof,
      acknowledgementRequestState: mergedAcknowledgementRequest,
      acknowledgementTrustedResponseState: _mergeTrustedResponse(
        acknowledgementTrustedResponseState,
        evidence.acknowledgementTrustedResponseState ?? 'not-received',
      ),
      acknowledgementOutcome: mergedAcknowledgementOutcome,
      safeAction: invariant
          ? 'preserve evidence and inspect diagnostics'
          : evidence.safeAction,
      retryable: invariant ? false : retryable || evidence.retryable,
      httpStatus: evidence.httpStatus ?? httpStatus,
      responseHeadersReceived:
          responseHeadersReceived || evidence.responseHeadersReceived,
      sanitizedExceptionClass:
          evidence.sanitizedExceptionClass ?? sanitizedExceptionClass,
      serverSqlstateClass: evidence.serverSqlstateClass ?? serverSqlstateClass,
      queueScope: evidence.queueScope ?? queueScope,
      pendingCount: evidence.pendingCount ?? pendingCount,
      uploadingCount: evidence.uploadingCount ?? uploadingCount,
      failedCount: evidence.failedCount ?? failedCount,
      unknownCount: evidence.unknownCount ?? unknownCount,
      memberCount: evidence.memberCount ?? memberCount,
      firstDeviceSequence: evidence.firstDeviceSequence ?? firstDeviceSequence,
      lastDeviceSequence: evidence.lastDeviceSequence ?? lastDeviceSequence,
      nextDeviceSequence: evidence.nextDeviceSequence ?? nextDeviceSequence,
      submissionFingerprint:
          evidence.submissionFingerprint ?? submissionFingerprint,
    );
  }

  SyncDiagnosticPhaseEvidence snapshot() => SyncDiagnosticPhaseEvidence(
    code: code,
    nativeCode: nativeCode,
    severity: severity,
    outcome: outcome,
    operationKind: operationKind,
    phase: phase,
    lastProvedPhase: lastProvedPhase,
    localMutationState: localMutationState,
    providerContactState: providerContactState,
    providerTransactionState: providerTransactionState,
    trustedResponseState: trustedResponseState,
    resultPersistenceState: resultPersistenceState,
    uploadRequestState: uploadRequestState,
    uploadTrustedResponseState: uploadTrustedResponseState,
    uploadProviderOutcome: uploadProviderOutcome,
    uploadLeaseLocalState: uploadLeaseLocalState,
    uploadResultPersistenceState: uploadResultPersistenceState,
    downloadRequestState: downloadRequestState,
    downloadTrustedResponseState: downloadTrustedResponseState,
    inboundApplyState: inboundApplyState,
    committedCursorProofState: committedCursorProofState,
    acknowledgementRequestState: acknowledgementRequestState,
    acknowledgementTrustedResponseState: acknowledgementTrustedResponseState,
    acknowledgementOutcome: acknowledgementOutcome,
    safeAction: safeAction,
    retryable: retryable,
    httpStatus: httpStatus,
    responseHeadersReceived: responseHeadersReceived,
    sanitizedExceptionClass: sanitizedExceptionClass,
    serverSqlstateClass: serverSqlstateClass,
    queueScope: queueScope,
    pendingCount: pendingCount,
    uploadingCount: uploadingCount,
    failedCount: failedCount,
    unknownCount: unknownCount,
    memberCount: memberCount,
    firstDeviceSequence: firstDeviceSequence,
    lastDeviceSequence: lastDeviceSequence,
    nextDeviceSequence: nextDeviceSequence,
    submissionFingerprint: submissionFingerprint,
  );
}

Map<String, Object?> _planeLifecycleFields(
  SyncDiagnosticPhaseEvidence? evidence,
  bool persistenceDegraded,
) {
  final snapshot = evidence ?? _CumulativeDiagnosticState.initial().snapshot();
  return {
    'uploadRequestState': snapshot.uploadRequestState ?? 'not-started',
    'uploadTrustedResponseState':
        snapshot.uploadTrustedResponseState ?? 'not-received',
    'uploadProviderOutcome': snapshot.uploadProviderOutcome ?? 'not-started',
    'uploadLeaseLocalState': snapshot.uploadLeaseLocalState ?? 'not-started',
    'uploadResultPersistenceState':
        snapshot.uploadResultPersistenceState ?? 'not-started',
    'downloadRequestState': snapshot.downloadRequestState ?? 'not-started',
    'downloadTrustedResponseState':
        snapshot.downloadTrustedResponseState ?? 'not-received',
    'inboundApplyState': snapshot.inboundApplyState ?? 'not-started',
    'committedCursorProofState':
        snapshot.committedCursorProofState ?? 'unknown',
    'acknowledgementRequestState':
        snapshot.acknowledgementRequestState ?? 'not-started',
    'acknowledgementTrustedResponseState':
        snapshot.acknowledgementTrustedResponseState ?? 'not-received',
    'acknowledgementOutcome': snapshot.acknowledgementOutcome ?? 'not-started',
    'diagnosticPersistenceState': persistenceDegraded ? 'degraded' : 'durable',
  };
}

String _mergeSeverity(String previous, String candidate) {
  if (previous == 'ERROR' || candidate == 'ERROR') return 'ERROR';
  return candidate;
}

String _mergeOutcome(String previous, String candidate) {
  if (candidate != 'unknown') return candidate;
  return previous;
}

String _mergeLastProvedPhase(String previous, String candidate) {
  if (candidate == 'terminal' && previous != 'started') return previous;
  if (candidate == 'acknowledgement' && previous == 'download-local-apply') {
    return previous;
  }
  return candidate;
}

String _mergeTrustedResponse(String previous, String candidate) {
  if (previous == 'received') return previous;
  if (candidate == 'received') return candidate;
  if (candidate == 'see-causal-event' || candidate == 'see-causal-phase') {
    return previous;
  }
  if (previous != 'not-received' && previous != 'unknown') return previous;
  return candidate;
}

String _mergeRequestState(String previous, String? candidate) {
  if (candidate == null ||
      candidate == 'see-causal-event' ||
      candidate == 'see-causal-phase') {
    return previous;
  }
  if (previous == 'request-started' || previous == 'started') return previous;
  if (candidate == 'request-started' || candidate == 'started') {
    return candidate;
  }
  if (previous != 'not-started' && previous != 'unknown') return previous;
  return candidate;
}

String _mergePlaneOutcome(
  String previous,
  String? candidate, {
  required Set<String> commitValues,
  required Set<String> rejectValues,
  String? startedValue,
}) {
  if (previous == 'diagnostic-invariant-conflict') return previous;
  if (candidate == null ||
      candidate == 'see-causal-event' ||
      candidate == 'see-causal-phase') {
    return previous;
  }
  final previousCommitted = commitValues.contains(previous);
  final previousRejected = rejectValues.contains(previous);
  final candidateCommitted = commitValues.contains(candidate);
  final candidateRejected = rejectValues.contains(candidate);
  if ((previousCommitted && candidateRejected) ||
      (previousRejected && candidateCommitted)) {
    return 'diagnostic-invariant-conflict';
  }
  if (previousCommitted || previousRejected) return previous;
  if (candidateCommitted || candidateRejected) return candidate;
  if (startedValue != null && candidate == startedValue) return candidate;
  if (previous != 'not-started' && previous != 'unknown') return previous;
  return candidate;
}

String _mergeCursorProof(String previous, String? candidate) {
  if (candidate == null ||
      candidate == 'see-causal-event' ||
      candidate == 'see-causal-phase') {
    return previous;
  }
  if (previous == 'available') return previous;
  if (candidate == 'available') return candidate;
  if (previous != 'unknown') return previous;
  return candidate;
}

bool _isInvalidAcknowledgementStart({
  required String inboundApply,
  required String cursorProof,
  required String acknowledgementRequest,
}) {
  if (acknowledgementRequest != 'request-started') return false;
  return inboundApply != 'committed' || cursorProof != 'available';
}

String _projectLegacyLocalMutation({
  required String uploadLease,
  required String uploadResultPersistence,
  required String inboundApply,
}) {
  if (inboundApply == 'committed') return 'committed';
  if (inboundApply == 'rolled-back') return 'rolled-back';
  if (uploadResultPersistence == 'committed' || uploadLease == 'committed') {
    return 'committed';
  }
  if (uploadResultPersistence == 'failed' || uploadLease == 'failed') {
    return 'failed';
  }
  return 'none';
}

String _projectLegacyProviderTransaction({
  required String uploadProvider,
  required String acknowledgementOutcome,
}) {
  if (acknowledgementOutcome == 'applied') return 'committed';
  if (acknowledgementOutcome == 'rejected') return 'not-started-or-rolled-back';
  if (uploadProvider == 'committed') return 'committed';
  if (uploadProvider == 'rejected') return 'not-started-or-rolled-back';
  if (uploadProvider == 'unknown' || acknowledgementOutcome == 'unknown') {
    return 'unknown';
  }
  return 'not-started';
}

String _projectLegacyTrustedResponse({
  required String uploadTrustedResponse,
  required String downloadTrustedResponse,
  required String acknowledgementTrustedResponse,
}) {
  if (acknowledgementTrustedResponse == 'received' ||
      downloadTrustedResponse == 'received' ||
      uploadTrustedResponse == 'received') {
    return 'received';
  }
  return 'not-received';
}

String _mergeProviderContact(String previous, String candidate) {
  if (previous == 'request-started') return previous;
  if (candidate == 'request-started') return candidate;
  if (candidate == 'see-causal-event' || candidate == 'see-causal-phase') {
    return previous;
  }
  if (previous != 'not-started' && previous != 'unknown') return previous;
  return candidate;
}

String _mergeResultPersistence(String previous, String candidate) {
  if (previous == 'diagnostics-persistence-degraded') return previous;
  if (candidate == 'diagnostics-persistence-degraded') return candidate;
  if (previous == 'committed') return previous;
  if (candidate == 'committed') return candidate;
  if (candidate == 'see-causal-event' || candidate == 'see-causal-phase') {
    return previous;
  }
  if (previous != 'not-started' && previous != 'unknown') return previous;
  return candidate;
}

String _sanitizeExceptionClass(Object error) {
  final sanitized = error.runtimeType
      .toString()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9._:-]+'), '-')
      .replaceAll(RegExp('-+'), '-')
      .replaceAll(RegExp('^-|-\$'), '');
  if (sanitized.isEmpty) return 'unexpected-local-exception';
  return sanitized.length <= 64 ? sanitized : sanitized.substring(0, 64);
}

void _terminalLifecycleSink(String line) {
  debugPrint(line);
}

void _emitLifecycle(
  NativeClosureLifecycleSink? sink,
  Map<String, Object?> fields,
) {
  if (sink == null) return;
  final sanitized = <String, Object?>{};
  for (final entry in fields.entries) {
    final value = entry.value;
    if (value == null) continue;
    sanitized[entry.key] = value;
  }
  try {
    sink(jsonEncode(sanitized));
  } on Object {
    // Lifecycle observability must not change Closure behavior.
  }
}

String _elapsedBand(Duration elapsed) {
  final elapsedMs = elapsed.inMilliseconds;
  if (elapsedMs < 250) return 'lt-250ms';
  if (elapsedMs < 1000) return 'lt-1s';
  if (elapsedMs < 3000) return 'lt-3s';
  if (elapsedMs < 10000) return 'lt-10s';
  if (elapsedMs < 30000) return 'lt-30s';
  return 'gte-30s';
}

final class NativeClosureStatus {
  const NativeClosureStatus(this.state);

  final String state;
}

final class NativeClosureFailedInspection {
  const NativeClosureFailedInspection({
    required this.state,
    required this.diagnosticCode,
    required this.operationFingerprint,
    required this.inspection,
  });

  final String state;
  final String diagnosticCode;
  final String operationFingerprint;
  final FailedNotAppliedRecoveryInspection? inspection;
}

final class NativeClosureFailedRecovery {
  const NativeClosureFailedRecovery({
    required this.state,
    required this.diagnosticCode,
    required this.operationFingerprint,
  });

  final String state;
  final String diagnosticCode;
  final String operationFingerprint;
}
