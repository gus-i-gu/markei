// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';

import '../application/hosted_auth_ports.dart';
import '../application/closure_diagnostics.dart';
import '../application/hosted_enrollment_coordinator.dart';
import '../application/hosted_connection_check.dart';
import '../application/hosted_sync_coordinator.dart';

final class NativeAuthClosureRunner {
  NativeAuthClosureRunner({
    required ExternalAuthenticationSession authenticationSession,
    required HostedEnrollmentCoordinator enrollmentCoordinator,
    required String environmentAlias,
    required Future<DeviceEnrollmentCommand> Function() commandFactory,
    required ClosureDiagnosticsQuery diagnosticsQuery,
    required SyncAttemptRecorder syncAttemptRecorder,
    required HostedSyncCoordinator hostedSyncCoordinator,
    required HostedConnectionCheckPort hostedConnectionCheck,
  }) : _authenticationSession = authenticationSession,
       _enrollmentCoordinator = enrollmentCoordinator,
       _environmentAlias = environmentAlias,
       _commandFactory = commandFactory,
       _diagnosticsQuery = diagnosticsQuery,
       _syncAttemptRecorder = syncAttemptRecorder,
       _hostedSyncCoordinator = hostedSyncCoordinator,
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
  final HostedConnectionCheckPort? _hostedConnectionCheck;
  final bool _unavailable;
  final Uuid? _uuid;

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
    final attemptId = await recorder.beginSyncAttempt();
    try {
      final outcome = await coordinator.run(_environmentAlias);
      await recorder.completeSyncAttempt(
        attemptId,
        resultCode: outcome.state,
        outcomeClass: _syncOutcomeClass(outcome.state),
        phase: _syncPhase(outcome.state),
        recoveryCode: _syncRecoveryCode(outcome.state),
      );
      return NativeClosureStatus(outcome.state);
    } on Object {
      await recorder.completeSyncAttempt(
        attemptId,
        resultCode: 'sync-unavailable',
        outcomeClass: 'unavailable',
        phase: 'unexpected-terminal',
        recoveryCode: 'local-exception-redacted',
      );
      return const NativeClosureStatus('sync-unavailable');
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
    final operationFingerprint = _operationFingerprint();
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
          ordinal: 1,
          code: inspection.diagnosticCode,
          nativeCode: inspection.state,
          severity: inspection.eligible ? 'INFO' : 'ERROR',
          outcome: inspection.eligible ? 'not-applied' : 'blocked',
          operationKind: 'failed-not-applied-inspection',
          phase: 'failed-recovery-preflight',
          operationFingerprint: operationFingerprint,
          correlationFingerprint: operationFingerprint,
          localMutationState: 'none',
          providerContactState: 'not-started',
          providerTransactionState: 'not-started',
          trustedResponseState: 'not-received',
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
      await recorder.recordDiagnosticEvent(
        SyncDiagnosticEnvelope(
          attemptId: attemptId,
          ordinal: 1,
          code: 'MKS-UI-006',
          nativeCode: 'closure-runner-exception',
          severity: 'ERROR',
          outcome: 'unknown',
          operationKind: 'failed-not-applied-inspection',
          phase: 'presentation',
          operationFingerprint: operationFingerprint,
          correlationFingerprint: operationFingerprint,
          localMutationState: 'none',
          providerContactState: 'not-started',
          providerTransactionState: 'not-started',
          trustedResponseState: 'not-received',
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

  String _operationFingerprint() {
    final seed =
        '${DateTime.now().toUtc().microsecondsSinceEpoch}:${_uuid!.v4()}';
    return sha256.convert(utf8.encode(seed)).toString().substring(0, 12);
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
      'sync-interrupted' => 'unknown',
      'authentication-required' => 'blocked',
      'device-enrollment-required' || 'device-revoked' => 'blocked',
      _ => 'unavailable',
    };
  }

  static String _syncPhase(String state) {
    return switch (state) {
      'sync-completed' || 'sync-no-new-events' => 'completed',
      'sync-interrupted' => 'transport-or-closure',
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
      'sync-interrupted' => 'retry-after-local-review',
      _ => 'provider-evidence-unavailable',
    };
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
