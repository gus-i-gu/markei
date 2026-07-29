import '../../domain/sync/sync_event.dart';
import 'sync_ports.dart';

final class UploadPendingEvents {
  const UploadPendingEvents(this.outbox, this.transport);

  final SyncOutboxRepository outbox;
  final SyncTransport transport;

  Future<SyncResult?> call({
    int limit = 25,
    SyncDiagnosticPhaseRecorder? diagnostics,
  }) async {
    await diagnostics?.recordPhase(
      const SyncDiagnosticPhaseEvidence(
        code: 'MKS-QUE-001',
        nativeCode: 'upload-lease-entered',
        operationKind: 'ordinary-sync',
        phase: 'upload-lease',
        lastProvedPhase: 'upload-lease',
        outcome: 'unknown',
        safeAction: 'continue ordinary Sync',
      ),
    );
    final SyncUploadSubmission? submission;
    try {
      submission = await outbox.leasePending(limit: limit);
    } on SyncBatchPreflightException catch (failure) {
      await diagnostics?.recordPhase(
        SyncDiagnosticPhaseEvidence(
          code: _diagnosticCodeForUploadResult(failure.result),
          nativeCode: failure.result.protocolCode ?? failure.result.code.name,
          severity: 'ERROR',
          operationKind: 'ordinary-sync',
          phase: 'upload-lease',
          lastProvedPhase: 'upload-lease',
          outcome: failure.result.outcome.name,
          localMutationState: 'none',
          safeAction: 'preserve local queue and inspect diagnostics',
          retryable: failure.result.retryable,
        ),
      );
      return failure.result;
    }
    if (submission == null) {
      await diagnostics?.recordPhase(
        const SyncDiagnosticPhaseEvidence(
          code: 'MKS-QUE-001',
          nativeCode: 'no-pending-events',
          operationKind: 'ordinary-sync',
          phase: 'upload-lease',
          lastProvedPhase: 'upload-lease',
          outcome: 'applied',
          safeAction: 'continue ordinary Sync',
        ),
      );
      return null;
    }
    final leasedSubmission = submission;
    await diagnostics?.recordPhase(
      const SyncDiagnosticPhaseEvidence(
        code: 'MKS-QUE-001',
        nativeCode: 'upload-lease-committed',
        operationKind: 'ordinary-sync',
        phase: 'upload-lease',
        lastProvedPhase: 'upload-lease',
        outcome: 'unknown',
        localMutationState: 'committed',
        resultPersistenceState: 'not-started',
        safeAction: 'persist a trusted or unknown upload result',
      ),
    );
    late final SyncResult result;
    final transportIdentity = await diagnostics?.recordPhase(
      const SyncDiagnosticPhaseEvidence(
        code: 'MKS-TRN-001',
        nativeCode: 'upload-request-started',
        operationKind: 'ordinary-sync',
        phase: 'upload-transport',
        lastProvedPhase: 'upload-transport',
        outcome: 'unknown',
        localMutationState: 'committed',
        providerContactState: 'request-started',
        trustedResponseState: 'not-received',
        resultPersistenceState: 'not-started',
        safeAction:
            'preserve submission identity until provider outcome is trusted',
      ),
    );
    try {
      result = await (transportIdentity == null
          ? transport.uploadSubmission(leasedSubmission)
          : withSyncCorrelation(
              transportIdentity.correlationId,
              () => transport.uploadSubmission(leasedSubmission),
            ));
    } on Object {
      result = const SyncResult(
        code: SyncStatusCode.unknownOutcome,
        outcome: SyncOutcome.unknown,
        retryable: true,
        protocolCode: 'transport-exception-redacted',
      );
    }
    await diagnostics?.recordPhase(
      SyncDiagnosticPhaseEvidence(
        code: _diagnosticCodeForUploadResult(result),
        nativeCode: result.protocolCode ?? result.code.name,
        severity: result.outcome == SyncOutcome.applied ? 'INFO' : 'ERROR',
        operationKind: 'ordinary-sync',
        phase: 'upload-provider',
        lastProvedPhase: result.outcome == SyncOutcome.unknown
            ? 'upload-transport'
            : 'upload-provider',
        outcome: result.outcome.name,
        localMutationState: 'committed',
        providerContactState: 'request-started',
        providerTransactionState: result.outcome == SyncOutcome.unknown
            ? 'unknown'
            : result.outcome == SyncOutcome.applied ||
                  result.outcome == SyncOutcome.duplicateEquivalent
            ? 'committed'
            : 'not-started-or-rolled-back',
        trustedResponseState: result.outcome == SyncOutcome.unknown
            ? 'not-received'
            : 'received',
        resultPersistenceState: 'not-started',
        safeAction: result.outcome == SyncOutcome.unknown
            ? 'preserve submission identity and inspect diagnostics'
            : 'persist the provider result locally',
        retryable: result.retryable,
      ),
    );
    await diagnostics?.recordPhase(
      const SyncDiagnosticPhaseEvidence(
        code: 'MKS-QUE-010',
        nativeCode: 'upload-result-persistence-entered',
        operationKind: 'ordinary-sync',
        phase: 'upload-result-persistence',
        lastProvedPhase: 'upload-result-persistence',
        outcome: 'unknown',
        localMutationState: 'committed',
        providerContactState: 'request-started',
        resultPersistenceState: 'started',
        safeAction: 'persist provider result separately from provider outcome',
      ),
    );
    try {
      await outbox.persistUploadResult(submission.id, result);
    } on SyncPersistenceInvariantException catch (failure) {
      await diagnostics?.recordPhase(
        SyncDiagnosticPhaseEvidence(
          code: 'MKS-QUE-010',
          nativeCode: failure.result.protocolCode ?? failure.result.code.name,
          severity: 'ERROR',
          operationKind: 'ordinary-sync',
          phase: 'upload-result-persistence',
          lastProvedPhase: 'upload-result-persistence',
          outcome: failure.result.outcome.name,
          localMutationState: 'failed',
          providerContactState: 'request-started',
          providerTransactionState: result.outcome == SyncOutcome.unknown
              ? 'unknown'
              : 'proved-separately',
          trustedResponseState: result.outcome == SyncOutcome.unknown
              ? 'not-received'
              : 'received',
          resultPersistenceState: 'failed',
          safeAction: 'preserve provider result and inspect local persistence',
          retryable: false,
        ),
      );
      return failure.result;
    }
    await diagnostics?.recordPhase(
      SyncDiagnosticPhaseEvidence(
        code: 'MKS-QUE-010',
        nativeCode: 'upload-result-persisted',
        operationKind: 'ordinary-sync',
        phase: 'upload-result-persistence',
        lastProvedPhase: 'upload-result-persistence',
        outcome: result.outcome.name,
        localMutationState: 'committed',
        providerContactState: 'request-started',
        providerTransactionState: result.outcome == SyncOutcome.unknown
            ? 'unknown'
            : 'proved-separately',
        trustedResponseState: result.outcome == SyncOutcome.unknown
            ? 'not-received'
            : 'received',
        resultPersistenceState: 'committed',
        safeAction: result.outcome == SyncOutcome.unknown
            ? 'preserve submission identity and inspect diagnostics'
            : 'continue ordinary Sync',
        retryable: result.retryable,
      ),
    );
    return result;
  }
}

final class RecoverFailedNotApplied {
  const RecoverFailedNotApplied(this.outbox);

  final SyncOutboxRepository outbox;

  Future<SyncResult> call() => outbox.recoverOneFailedNotApplied();
}

final class DownloadAndApplyEvents {
  const DownloadAndApplyEvents(this.transport, this.applier);

  final SyncTransport transport;
  final RemoteEventApplier applier;

  Future<SyncResult> call(
    String? cursor, {
    int limit = 100,
    SyncDiagnosticPhaseRecorder? diagnostics,
  }) async {
    final identity = await _recordPhase(
      diagnostics,
      const SyncDiagnosticPhaseEvidence(
        code: 'MKS-TRN-001',
        nativeCode: 'download-request-started',
        operationKind: 'ordinary-sync',
        phase: 'download-transport',
        lastProvedPhase: 'download-transport',
        outcome: 'unknown',
        providerContactState: 'request-started',
        safeAction: 'await trusted download response',
      ),
    );
    final page = await (identity == null
        ? transport.downloadAfter(cursor, limit: limit)
        : withSyncCorrelation(
            identity.correlationId,
            () => transport.downloadAfter(cursor, limit: limit),
          ));
    await _recordPhase(
      diagnostics,
      const SyncDiagnosticPhaseEvidence(
        code: 'MKS-DNL-001',
        nativeCode: 'download-response-received',
        operationKind: 'ordinary-sync',
        phase: 'download-provider',
        lastProvedPhase: 'download-provider',
        outcome: 'applied',
        providerContactState: 'request-started',
        trustedResponseState: 'received',
        providerTransactionState: 'not-applicable',
        safeAction: 'apply trusted download page locally',
      ),
    );
    final result = await applier.applyPage(page);
    await _recordPhase(
      diagnostics,
      SyncDiagnosticPhaseEvidence(
        code: _diagnosticCodeForDownloadResult(result),
        nativeCode: result.protocolCode ?? result.code.name,
        severity: result.outcome == SyncOutcome.applied ? 'INFO' : 'ERROR',
        operationKind: 'ordinary-sync',
        phase: 'download-local-apply',
        lastProvedPhase: 'download-local-apply',
        outcome: result.outcome.name,
        localMutationState: _localMutationStateForDownloadResult(result),
        providerContactState: 'request-started',
        trustedResponseState: 'received',
        providerTransactionState: 'not-applicable',
        resultPersistenceState: result.outcome == SyncOutcome.applied
            ? 'committed'
            : 'not-started',
        safeAction: result.outcome == SyncOutcome.applied
            ? 'continue ordinary Sync'
            : 'preserve local state and inspect diagnostics',
        retryable: result.retryable,
        sanitizedExceptionClass: result.sanitizedExceptionClass,
      ),
    );
    return result;
  }
}

final class AcknowledgeAppliedCursor {
  const AcknowledgeAppliedCursor(this.transport, this.applier);

  final SyncTransport transport;
  final RemoteEventApplier applier;

  Future<SyncResult?> call({SyncDiagnosticPhaseRecorder? diagnostics}) async {
    final cursor = await applier.greatestContiguousAppliedCursor();
    if (cursor == null) {
      await diagnostics?.recordPhase(
        const SyncDiagnosticPhaseEvidence(
          code: 'MKS-ACK-001',
          nativeCode: 'no-applied-cursor',
          operationKind: 'ordinary-sync',
          phase: 'acknowledgement',
          lastProvedPhase: 'acknowledgement',
          outcome: 'applied',
          safeAction: 'finish ordinary Sync',
        ),
      );
      return null;
    }
    final identity = await diagnostics?.recordPhase(
      const SyncDiagnosticPhaseEvidence(
        code: 'MKS-ACK-001',
        nativeCode: 'acknowledgement-request-started',
        operationKind: 'ordinary-sync',
        phase: 'acknowledgement',
        lastProvedPhase: 'acknowledgement',
        outcome: 'unknown',
        providerContactState: 'request-started',
        trustedResponseState: 'not-received',
        safeAction: 'await acknowledgement response',
      ),
    );
    final result = await (identity == null
        ? transport.acknowledge(cursor)
        : withSyncCorrelation(
            identity.correlationId,
            () => transport.acknowledge(cursor),
          ));
    await diagnostics?.recordPhase(
      SyncDiagnosticPhaseEvidence(
        code: _diagnosticCodeForAcknowledgementResult(result),
        nativeCode: result.protocolCode ?? result.code.name,
        severity: result.outcome == SyncOutcome.applied ? 'INFO' : 'ERROR',
        operationKind: 'ordinary-sync',
        phase: 'acknowledgement',
        lastProvedPhase: 'acknowledgement',
        outcome: result.outcome.name,
        providerContactState: 'request-started',
        providerTransactionState: result.outcome == SyncOutcome.unknown
            ? 'unknown'
            : result.outcome == SyncOutcome.applied ||
                  result.outcome == SyncOutcome.duplicateEquivalent
            ? 'committed'
            : 'not-started-or-rolled-back',
        trustedResponseState: result.outcome == SyncOutcome.unknown
            ? 'not-received'
            : 'received',
        safeAction: result.outcome == SyncOutcome.applied
            ? 'finish ordinary Sync'
            : 'preserve acknowledgement evidence',
        retryable: result.retryable,
      ),
    );
    return result;
  }
}

String _diagnosticCodeForUploadResult(SyncResult result) {
  return switch (result.code) {
    SyncStatusCode.unknownOutcome => 'MKS-OBS-001',
    SyncStatusCode.serviceUnavailable => 'MKS-TRN-001',
    SyncStatusCode.wrongAccount => 'MKS-BND-001',
    SyncStatusCode.hashMismatch => 'MKS-UPL-004',
    SyncStatusCode.sequenceGap => 'MKS-UPL-005',
    SyncStatusCode.localBatchInvalid => 'MKS-UPL-006',
    SyncStatusCode.failedRecoveryBlocked => 'MKS-REC-012',
    _ => 'MKS-UPL-001',
  };
}

String _diagnosticCodeForDownloadResult(SyncResult result) {
  if (result.protocolCode == 'local-sqlite-apply-failed') {
    return 'MKS-LDB-001';
  }
  return switch (result.code) {
    SyncStatusCode.cursorExpired => 'MKS-DNL-004',
    SyncStatusCode.conflict => 'MKS-DNL-006',
    SyncStatusCode.unknownOutcome => 'MKS-OBS-001',
    _ => 'MKS-DNL-001',
  };
}

String _localMutationStateForDownloadResult(SyncResult result) {
  if (result.outcome == SyncOutcome.applied) {
    return 'committed';
  }
  if (result.protocolCode == 'local-sqlite-apply-failed' ||
      result.protocolCode == 'unexpected-local-apply-failed' ||
      result.protocolCode == 'remote-payload-shape-invalid' ||
      result.protocolCode == 'local-apply-invariant-failed' ||
      result.code == SyncStatusCode.conflict) {
    return 'rolled-back';
  }
  return 'none';
}

String _diagnosticCodeForAcknowledgementResult(SyncResult result) {
  return switch (result.code) {
    SyncStatusCode.cursorExpired => 'MKS-ACK-003',
    SyncStatusCode.serviceUnavailable => 'MKS-ACK-004',
    SyncStatusCode.unknownOutcome => 'MKS-OBS-001',
    _ => 'MKS-ACK-001',
  };
}

Future<SyncDiagnosticChildIdentity?> _recordPhase(
  SyncDiagnosticPhaseRecorder? diagnostics,
  SyncDiagnosticPhaseEvidence evidence,
) async {
  try {
    return await diagnostics?.recordPhase(evidence);
  } on Object {
    return null;
  }
}
