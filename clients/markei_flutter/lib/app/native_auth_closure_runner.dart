// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../application/hosted_auth_ports.dart';
import '../application/closure_diagnostics.dart';
import '../application/failed_not_applied_recovery_coordinator.dart';
import '../application/hosted_enrollment_coordinator.dart';
import '../application/hosted_connection_check.dart';
import '../application/hosted_sync_coordinator.dart';
import '../application/sync/sync_ports.dart';

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
  final bool _unavailable;
  final Uuid? _uuid;
  static const ordinarySyncClientDeadline = Duration(seconds: 35);

  int get ordinarySyncClientDeadlineMs =>
      ordinarySyncClientDeadline.inMilliseconds;

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
    final attemptId = await recorder.beginDiagnosticAttempt(
      operationKind: 'ordinary-sync',
      latestStage: 'started',
      resultCode: 'sync-started',
      outcomeClass: 'in-progress',
      correlationFingerprint: operationFingerprint,
    );
    final diagnostics = _DiagnosticOperationRecorder(
      recorder: recorder,
      attemptId: attemptId,
      operationId: operationId,
      operationFingerprint: operationFingerprint,
      uuid: _uuid,
    );
    try {
      final outcome = await withSyncOperation(
        operationId: operationId,
        operationFingerprint: operationFingerprint,
        body: () =>
            coordinator.run(_environmentAlias, diagnostics: diagnostics),
      );
      await diagnostics.recordTerminal(outcome.state);
      await recorder.completeSyncAttempt(
        attemptId,
        resultCode: outcome.state,
        outcomeClass: _syncOutcomeClass(outcome.state),
        phase: _syncPhase(outcome.state),
        recoveryCode: _syncRecoveryCode(outcome.state),
      );
      return NativeClosureStatus(outcome.state);
    } on Object catch (error) {
      await diagnostics.recordPhase(
        SyncDiagnosticPhaseEvidence(
          code: 'MKS-UI-006',
          nativeCode: 'closure-runner-exception',
          severity: 'ERROR',
          operationKind: 'ordinary-sync',
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
      await recorder.completeSyncAttempt(
        attemptId,
        resultCode: 'sync-failed',
        outcomeClass: 'failed',
        phase: 'unexpected-terminal',
        recoveryCode: 'local-exception-redacted',
      );
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
  });

  final SyncAttemptRecorder recorder;
  final int attemptId;
  final String operationId;
  final String operationFingerprint;
  final Uuid uuid;
  int _ordinal = 0;
  int? _causalOrdinal;

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
    await recorder.recordDiagnosticEvent(
      SyncDiagnosticEnvelope(
        attemptId: attemptId,
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
        lastProvedPhase: 'terminal',
        outcome: state == 'sync-completed' || state == 'sync-no-new-events'
            ? 'applied'
            : state == 'sync-rejected'
            ? 'notApplied'
            : 'unknown',
        providerTransactionState: 'see-causal-event',
        trustedResponseState: 'see-causal-event',
        resultPersistenceState: 'see-causal-event',
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
