// ignore_for_file: prefer_initializing_formals

import '../domain/sync/sync_event.dart';
import 'closure_diagnostics.dart';
import 'hosted_auth_ports.dart';
import 'sync/sync_ports.dart';

final class FailedNotAppliedRecoveryCoordinator {
  const FailedNotAppliedRecoveryCoordinator({
    required ExternalAuthenticationSession authenticationSession,
    required HostedSyncGuard syncGuard,
    required ClosureDiagnosticsQuery diagnosticsQuery,
    required SyncOutboxRepository outbox,
    required SyncTransport transport,
  }) : _authenticationSession = authenticationSession,
       _syncGuard = syncGuard,
       _diagnosticsQuery = diagnosticsQuery,
       _outbox = outbox,
       _transport = transport;

  final ExternalAuthenticationSession _authenticationSession;
  final HostedSyncGuard _syncGuard;
  final ClosureDiagnosticsQuery _diagnosticsQuery;
  final SyncOutboxRepository _outbox;
  final SyncTransport _transport;

  Future<FailedNotAppliedRecoveryOutcome> run({
    required String environmentAlias,
    required FailedNotAppliedRecoveryInspection confirmedInspection,
    required String operationFingerprint,
    SyncDiagnosticPhaseRecorder? diagnostics,
  }) async {
    if (!confirmedInspection.eligible) {
      await _recordBlocked(
        diagnostics,
        confirmedInspection,
        'failed-not-applied-confirmation-not-eligible',
      );
      return const FailedNotAppliedRecoveryOutcome.blocked(
        'failed-not-applied-recovery-blocked',
      );
    }
    await diagnostics?.recordPhase(
      _evidence(
        code: 'MKS-AUT-001',
        nativeCode: 'authentication-check-entered',
        phase: 'authorization-preflight',
        outcome: 'unknown',
        safeAction: 'verify authentication before bounded recovery',
      ),
    );
    final authState = await _authenticationSession.currentState();
    final authenticationState = _stateName(authState);
    if (authState is! SignedIn) {
      await diagnostics?.recordPhase(
        _evidence(
          code: 'MKS-AUT-001',
          nativeCode: 'authentication-required',
          severity: 'ERROR',
          phase: 'authorization-preflight',
          outcome: 'blocked',
          safeAction: 'sign in before recovery',
        ),
      );
      return const FailedNotAppliedRecoveryOutcome.blocked(
        'authentication-required',
      );
    }
    await diagnostics?.recordPhase(
      _evidence(
        code: 'MKS-BND-001',
        nativeCode: 'binding-check-entered',
        phase: 'binding',
        outcome: 'unknown',
        safeAction: 'verify current Account and Device binding',
      ),
    );
    final decision = await _syncGuard.evaluate(environmentAlias);
    final blocker = decision.blockedReason;
    if (blocker != null) {
      await diagnostics?.recordPhase(
        _evidence(
          code: 'MKS-BND-001',
          nativeCode: blocker,
          severity: 'ERROR',
          phase: 'binding',
          outcome: 'blocked',
          safeAction: 'preserve local state and inspect enrollment',
        ),
      );
      return const FailedNotAppliedRecoveryOutcome.blocked(
        'device-enrollment-required',
      );
    }
    final inspection = await _diagnosticsQuery.inspectFailedNotAppliedRecovery(
      authenticationState: authenticationState,
      operationFingerprint: operationFingerprint,
    );
    await diagnostics?.recordPhase(
      _inspectionEvidence(inspection, outcome: 'not-applied'),
    );
    if (!inspection.eligible ||
        !_sameInspection(confirmedInspection, inspection)) {
      await _recordBlocked(
        diagnostics,
        inspection,
        inspection.eligible
            ? 'failed-not-applied-confirmation-drift'
            : inspection.state,
      );
      return const FailedNotAppliedRecoveryOutcome.blocked(
        'failed-not-applied-recovery-blocked',
      );
    }

    final confirmation = FailedNotAppliedRecoveryConfirmation(
      candidateFingerprint: inspection.candidateFingerprint!,
      memberCount: inspection.memberCount!,
      firstDeviceSequence: inspection.firstDeviceSequence!,
      lastDeviceSequence: inspection.lastDeviceSequence!,
      nextDeviceSequence: inspection.nextDeviceSequence!,
      pendingCount: inspection.queueCounts.pending,
      uploadingCount: inspection.queueCounts.uploading,
      failedCount: inspection.queueCounts.failed,
      unknownCount: inspection.queueCounts.unknown,
    );
    await diagnostics?.recordPhase(
      _inspectionEvidence(
        inspection,
        phase: 'failed-recovery-local-transition',
        outcome: 'unknown',
        nativeCode: 'failed-recovery-local-transition-entered',
        safeAction: 'atomically recover only the confirmed candidate',
      ),
    );
    late final FailedNotAppliedRecoveredBatch batch;
    try {
      batch = await _outbox.recoverExactFailedNotAppliedCandidate(confirmation);
    } on SyncBatchPreflightException catch (failure) {
      await _recordFailure(diagnostics, inspection, failure.result);
      return const FailedNotAppliedRecoveryOutcome.blocked(
        'failed-not-applied-recovery-blocked',
      );
    }
    await diagnostics?.recordPhase(
      _batchEvidence(
        batch,
        code: 'MKS-REC-001',
        nativeCode: 'failed-recovery-local-transition-committed',
        phase: 'failed-recovery-local-transition',
        outcome: 'not-applied',
        localMutationState: 'committed',
        resultPersistenceState: 'committed',
        safeAction: 'lease only the recovered member set',
      ),
    );
    await diagnostics?.recordPhase(
      _batchEvidence(
        batch,
        code: 'MKS-QUE-001',
        nativeCode: 'recovered-batch-validation-entered',
        phase: 'recovered-batch-validation',
        outcome: 'unknown',
        localMutationState: 'committed',
        resultPersistenceState: 'committed',
        safeAction: 'validate exact recovered batch before upload lease',
      ),
    );
    late final SyncUploadSubmission submission;
    try {
      submission = await _outbox.leaseExactRecoveredBatch(batch);
    } on SyncBatchPreflightException catch (failure) {
      await _recordFailure(diagnostics, inspection, failure.result);
      return const FailedNotAppliedRecoveryOutcome.blocked(
        'failed-not-applied-recovery-blocked',
      );
    }
    await diagnostics?.recordPhase(
      _batchEvidence(
        batch,
        code: 'MKS-QUE-001',
        nativeCode: 'exact-recovered-batch-leased',
        phase: 'upload-lease',
        outcome: 'unknown',
        localMutationState: 'committed',
        resultPersistenceState: 'not-started',
        safeAction: 'send exactly one upload request for the recovered batch',
      ),
    );
    final transportIdentity = await diagnostics?.recordPhase(
      _batchEvidence(
        batch,
        code: 'MKS-TRN-001',
        nativeCode: 'recovery-upload-request-started',
        phase: 'upload-transport',
        outcome: 'unknown',
        localMutationState: 'committed',
        providerContactState: 'request-started',
        providerTransactionState: 'unknown',
        trustedResponseState: 'not-received',
        resultPersistenceState: 'not-started',
        safeAction:
            'preserve recovered submission identity until response is trusted',
      ),
    );
    late final SyncResult uploadResult;
    try {
      uploadResult = await (transportIdentity == null
          ? _transport.uploadSubmission(submission)
          : withSyncCorrelation(
              transportIdentity.correlationId,
              () => _transport.uploadSubmission(submission),
            ));
    } on Object {
      uploadResult = const SyncResult(
        code: SyncStatusCode.unknownOutcome,
        outcome: SyncOutcome.unknown,
        retryable: false,
        protocolCode: 'transport-exception-redacted',
      );
    }
    await diagnostics?.recordPhase(
      _batchEvidence(
        batch,
        code: _diagnosticCode(uploadResult),
        nativeCode: uploadResult.protocolCode ?? uploadResult.code.name,
        severity: uploadResult.outcome == SyncOutcome.applied
            ? 'INFO'
            : 'ERROR',
        phase: 'upload-provider',
        outcome: uploadResult.outcome.name,
        localMutationState: 'committed',
        providerContactState: 'request-started',
        providerTransactionState: uploadResult.outcome == SyncOutcome.unknown
            ? 'unknown'
            : uploadResult.outcome == SyncOutcome.applied ||
                  uploadResult.outcome == SyncOutcome.duplicateEquivalent
            ? 'committed'
            : 'not-started-or-rolled-back',
        trustedResponseState: uploadResult.outcome == SyncOutcome.unknown
            ? 'not-received'
            : 'received',
        resultPersistenceState: 'not-started',
        safeAction: 'persist upload result and stop bounded recovery action',
        retryable: uploadResult.retryable,
      ),
    );
    await diagnostics?.recordPhase(
      _batchEvidence(
        batch,
        code: 'MKS-QUE-010',
        nativeCode: 'upload-result-persistence-entered',
        phase: 'upload-result-persistence',
        outcome: 'unknown',
        localMutationState: 'committed',
        providerContactState: 'request-started',
        providerTransactionState: 'proved-separately',
        trustedResponseState: uploadResult.outcome == SyncOutcome.unknown
            ? 'not-received'
            : 'received',
        resultPersistenceState: 'started',
        safeAction: 'persist provider result locally and stop',
      ),
    );
    try {
      await _outbox.persistUploadResult(submission.id, uploadResult);
    } on SyncPersistenceInvariantException catch (failure) {
      await _recordFailure(diagnostics, inspection, failure.result);
      return const FailedNotAppliedRecoveryOutcome.blocked(
        'failed-not-applied-recovery-persistence-failed',
      );
    }
    await diagnostics?.recordPhase(
      _batchEvidence(
        batch,
        code: 'MKS-OBS-001',
        nativeCode: 'failed-not-applied-recovery-terminal',
        phase: 'terminal',
        outcome: uploadResult.outcome.name,
        localMutationState: 'committed',
        providerContactState: 'request-started',
        providerTransactionState: uploadResult.outcome == SyncOutcome.unknown
            ? 'unknown'
            : 'proved-separately',
        trustedResponseState: uploadResult.outcome == SyncOutcome.unknown
            ? 'not-received'
            : 'received',
        resultPersistenceState: 'committed',
        safeAction: 'stop after upload-result persistence; do not Sync',
        retryable: false,
      ),
    );
    return FailedNotAppliedRecoveryOutcome(
      state: switch (uploadResult.outcome) {
        SyncOutcome.applied || SyncOutcome.duplicateEquivalent =>
          'failed-not-applied-recovery-upload-persisted',
        SyncOutcome.unknown => 'failed-not-applied-recovery-unknown',
        SyncOutcome.notApplied => 'failed-not-applied-recovery-not-applied',
      },
    );
  }

  Future<void> _recordBlocked(
    SyncDiagnosticPhaseRecorder? diagnostics,
    FailedNotAppliedRecoveryInspection inspection,
    String nativeCode,
  ) {
    return diagnostics?.recordPhase(
          _inspectionEvidence(
            inspection,
            nativeCode: nativeCode,
            severity: 'ERROR',
            outcome: 'blocked',
            safeAction:
                'preserve evidence; do not retry, Sync, or recover automatically',
          ),
        ) ??
        Future.value();
  }

  Future<void> _recordFailure(
    SyncDiagnosticPhaseRecorder? diagnostics,
    FailedNotAppliedRecoveryInspection inspection,
    SyncResult result,
  ) {
    return diagnostics?.recordPhase(
          _inspectionEvidence(
            inspection,
            code: _diagnosticCode(result),
            nativeCode: result.protocolCode ?? result.code.name,
            severity: 'ERROR',
            outcome: result.outcome.name,
            safeAction: 'preserve evidence and stop bounded recovery',
            retryable: false,
          ),
        ) ??
        Future.value();
  }

  SyncDiagnosticPhaseEvidence _inspectionEvidence(
    FailedNotAppliedRecoveryInspection inspection, {
    String code = 'MKS-REC-001',
    String? nativeCode,
    String severity = 'INFO',
    String phase = 'failed-recovery-preflight',
    String outcome = 'blocked',
    String safeAction = 'continue bounded recovery only after confirmation',
    bool retryable = false,
  }) {
    return _evidence(
      code: code,
      nativeCode: nativeCode ?? inspection.state,
      severity: severity,
      phase: phase,
      outcome: outcome,
      queueScope: 'current-device',
      pendingCount: inspection.queueCounts.pending,
      uploadingCount: inspection.queueCounts.uploading,
      failedCount: inspection.queueCounts.failed,
      unknownCount: inspection.queueCounts.unknown,
      memberCount: inspection.memberCount,
      firstDeviceSequence: inspection.firstDeviceSequence,
      lastDeviceSequence: inspection.lastDeviceSequence,
      nextDeviceSequence: inspection.nextDeviceSequence,
      submissionFingerprint: inspection.candidateFingerprint,
      safeAction: safeAction,
      retryable: retryable,
    );
  }

  SyncDiagnosticPhaseEvidence _batchEvidence(
    FailedNotAppliedRecoveredBatch batch, {
    required String code,
    required String nativeCode,
    required String phase,
    required String outcome,
    String severity = 'INFO',
    String localMutationState = 'none',
    String providerContactState = 'not-started',
    String providerTransactionState = 'not-started',
    String trustedResponseState = 'not-received',
    String resultPersistenceState = 'not-started',
    required String safeAction,
    bool retryable = false,
  }) {
    return _evidence(
      code: code,
      nativeCode: nativeCode,
      severity: severity,
      phase: phase,
      outcome: outcome,
      localMutationState: localMutationState,
      providerContactState: providerContactState,
      providerTransactionState: providerTransactionState,
      trustedResponseState: trustedResponseState,
      resultPersistenceState: resultPersistenceState,
      queueScope: 'current-device',
      pendingCount: phase == 'upload-lease' ? batch.memberCount : null,
      uploadingCount: phase == 'upload-lease' ? 0 : null,
      failedCount: phase == 'upload-lease' ? 0 : null,
      unknownCount: phase == 'upload-lease' ? 0 : null,
      memberCount: batch.memberCount,
      firstDeviceSequence: batch.firstDeviceSequence,
      lastDeviceSequence: batch.lastDeviceSequence,
      nextDeviceSequence: batch.nextDeviceSequence,
      submissionFingerprint: batch.candidateFingerprint,
      safeAction: safeAction,
      retryable: retryable,
    );
  }

  SyncDiagnosticPhaseEvidence _evidence({
    required String code,
    required String nativeCode,
    String severity = 'INFO',
    required String phase,
    required String outcome,
    String localMutationState = 'none',
    String providerContactState = 'not-started',
    String providerTransactionState = 'not-started',
    String trustedResponseState = 'not-received',
    String resultPersistenceState = 'not-started',
    String? queueScope,
    int? pendingCount,
    int? uploadingCount,
    int? failedCount,
    int? unknownCount,
    int? memberCount,
    int? firstDeviceSequence,
    int? lastDeviceSequence,
    int? nextDeviceSequence,
    String? submissionFingerprint,
    required String safeAction,
    bool retryable = false,
  }) {
    return SyncDiagnosticPhaseEvidence(
      code: code,
      nativeCode: nativeCode,
      severity: severity,
      operationKind: 'failed-not-applied-recovery',
      phase: phase,
      lastProvedPhase: phase,
      outcome: outcome,
      localMutationState: localMutationState,
      providerContactState: providerContactState,
      providerTransactionState: providerTransactionState,
      trustedResponseState: trustedResponseState,
      resultPersistenceState: resultPersistenceState,
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
      safeAction: safeAction,
      retryable: retryable,
    );
  }

  bool _sameInspection(
    FailedNotAppliedRecoveryInspection expected,
    FailedNotAppliedRecoveryInspection actual,
  ) {
    return expected.eligible == actual.eligible &&
        expected.candidateFingerprint == actual.candidateFingerprint &&
        expected.memberCount == actual.memberCount &&
        expected.firstDeviceSequence == actual.firstDeviceSequence &&
        expected.lastDeviceSequence == actual.lastDeviceSequence &&
        expected.nextDeviceSequence == actual.nextDeviceSequence &&
        expected.queueCounts.pending == actual.queueCounts.pending &&
        expected.queueCounts.uploading == actual.queueCounts.uploading &&
        expected.queueCounts.failed == actual.queueCounts.failed &&
        expected.queueCounts.unknown == actual.queueCounts.unknown &&
        expected.requestHashMatches == actual.requestHashMatches &&
        expected.membershipContiguous == actual.membershipContiguous &&
        expected.deviceScopeMatches == actual.deviceScopeMatches &&
        expected.eventStatesCompatible == actual.eventStatesCompatible &&
        expected.noAcceptedMembers == actual.noAcceptedMembers &&
        expected.noActiveOverlap == actual.noActiveOverlap;
  }

  String _diagnosticCode(SyncResult result) {
    return switch (result.code) {
      SyncStatusCode.failedRecoveryBlocked => 'MKS-REC-012',
      SyncStatusCode.localBatchInvalid => 'MKS-QUE-001',
      SyncStatusCode.serviceUnavailable => 'MKS-TRN-001',
      SyncStatusCode.unknownOutcome => 'MKS-OBS-001',
      SyncStatusCode.wrongAccount => 'MKS-UPL-003',
      SyncStatusCode.hashMismatch => 'MKS-UPL-004',
      SyncStatusCode.sequenceGap => 'MKS-UPL-005',
      _ => 'MKS-UPL-001',
    };
  }

  String _stateName(ExternalAuthenticationState state) {
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
}

final class FailedNotAppliedRecoveryOutcome {
  const FailedNotAppliedRecoveryOutcome({required this.state});

  const FailedNotAppliedRecoveryOutcome.blocked(String state)
    : this(state: state);

  final String state;
}
