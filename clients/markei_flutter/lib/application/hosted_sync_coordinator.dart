import 'dart:async';

import 'hosted_auth_ports.dart';
import '../domain/sync/sync_event.dart';
import 'sync/sync_ports.dart';
import 'sync/sync_use_cases.dart';

final class HostedSyncCoordinator {
  const HostedSyncCoordinator({
    required this._authenticationSession,
    required this._syncGuard,
    required this._applier,
    required this.recoverFailedNotApplied,
    required this._uploadPendingEvents,
    required this._downloadAndApplyEvents,
    required this._acknowledgeAppliedCursor,
  });

  final ExternalAuthenticationSession _authenticationSession;
  final HostedSyncGuard _syncGuard;
  final RemoteEventApplier _applier;
  final RecoverFailedNotApplied recoverFailedNotApplied;
  final UploadPendingEvents _uploadPendingEvents;
  final DownloadAndApplyEvents _downloadAndApplyEvents;
  final AcknowledgeAppliedCursor _acknowledgeAppliedCursor;

  Future<HostedSyncOutcome> run(
    String environmentAlias, {
    SyncDiagnosticPhaseRecorder? diagnostics,
  }) async {
    await diagnostics?.recordPhase(
      const SyncDiagnosticPhaseEvidence(
        code: 'MKS-AUT-001',
        nativeCode: 'authentication-check-entered',
        operationKind: 'ordinary-sync',
        phase: 'authentication',
        lastProvedPhase: 'authentication',
        outcome: 'unknown',
        safeAction: 'continue ordinary Sync authentication check',
      ),
    );
    if (await _authenticationSession.currentState() is! SignedIn) {
      await diagnostics?.recordPhase(
        const SyncDiagnosticPhaseEvidence(
          code: 'MKS-AUT-001',
          nativeCode: 'authentication-required',
          severity: 'ERROR',
          operationKind: 'ordinary-sync',
          phase: 'authentication',
          lastProvedPhase: 'authentication',
          outcome: 'blocked',
          safeAction: 'sign in before Sync',
        ),
      );
      return const HostedSyncOutcome.authenticationRequired();
    }
    await diagnostics?.recordPhase(
      const SyncDiagnosticPhaseEvidence(
        code: 'MKS-AUT-001',
        nativeCode: 'authenticated',
        operationKind: 'ordinary-sync',
        phase: 'authentication',
        lastProvedPhase: 'authentication',
        outcome: 'applied',
        safeAction: 'continue ordinary Sync',
      ),
    );
    await diagnostics?.recordPhase(
      const SyncDiagnosticPhaseEvidence(
        code: 'MKS-BND-001',
        nativeCode: 'binding-check-entered',
        operationKind: 'ordinary-sync',
        phase: 'binding',
        lastProvedPhase: 'binding',
        outcome: 'unknown',
        safeAction: 'verify current Account and Device binding',
      ),
    );
    final decision = await _syncGuard.evaluate(environmentAlias);
    final deviceBlocker = decision.blockedReason;
    if (deviceBlocker != null) {
      await diagnostics?.recordPhase(
        SyncDiagnosticPhaseEvidence(
          code: 'MKS-BND-001',
          nativeCode: deviceBlocker,
          severity: 'ERROR',
          operationKind: 'ordinary-sync',
          phase: 'binding',
          lastProvedPhase: 'binding',
          outcome: 'blocked',
          safeAction: 'preserve local state and inspect enrollment',
        ),
      );
      if (deviceBlocker == 'device-revoked' ||
          deviceBlocker == 'device-expired') {
        return const HostedSyncOutcome.deviceRevoked();
      }
      return const HostedSyncOutcome.deviceEnrollmentRequired();
    }
    await diagnostics?.recordPhase(
      const SyncDiagnosticPhaseEvidence(
        code: 'MKS-BND-001',
        nativeCode: 'binding-accepted',
        operationKind: 'ordinary-sync',
        phase: 'binding',
        lastProvedPhase: 'binding',
        outcome: 'applied',
        safeAction: 'continue ordinary Sync',
      ),
    );

    try {
      final upload = await _uploadPendingEvents(diagnostics: diagnostics);
      final uploadBlocker = _blockedBy(upload);
      if (uploadBlocker != null) return uploadBlocker;

      final cursor = await _applier.greatestContiguousAppliedCursor();
      final download = await _downloadAndApplyEvents(
        cursor,
        diagnostics: diagnostics,
      );
      final downloadBlocker = _blockedBy(download);
      if (downloadBlocker != null) return downloadBlocker;

      final acknowledgement = await _acknowledgeAppliedCursor(
        diagnostics: diagnostics,
      );
      final acknowledgementBlocker = _blockedBy(acknowledgement);
      if (acknowledgementBlocker != null) return acknowledgementBlocker;

      if (upload == null &&
          download.code == SyncStatusCode.downloadReceived &&
          acknowledgement == null) {
        await diagnostics?.recordPhase(
          const SyncDiagnosticPhaseEvidence(
            code: 'MKS-OBS-001',
            nativeCode: 'sync-no-new-events',
            operationKind: 'ordinary-sync',
            phase: 'terminal',
            lastProvedPhase: 'terminal',
            outcome: 'applied',
            safeAction: 'no further action required',
          ),
        );
        return const HostedSyncOutcome.noNewEvents();
      }
      await diagnostics?.recordPhase(
        const SyncDiagnosticPhaseEvidence(
          code: 'MKS-OBS-001',
          nativeCode: 'sync-completed',
          operationKind: 'ordinary-sync',
          phase: 'terminal',
          lastProvedPhase: 'terminal',
          outcome: 'applied',
          safeAction: 'no further action required',
        ),
      );
      return const HostedSyncOutcome.completed();
    } on TimeoutException catch (error) {
      await diagnostics?.recordPhase(
        SyncDiagnosticPhaseEvidence(
          code: 'MKS-TRN-001',
          nativeCode: 'timeout',
          severity: 'ERROR',
          operationKind: 'ordinary-sync',
          phase: 'terminal',
          lastProvedPhase: 'upload-transport',
          outcome: 'unknown',
          providerContactState: 'request-started',
          providerTransactionState: 'unknown',
          trustedResponseState: 'not-received',
          uploadRequestState: 'started',
          uploadTrustedResponseState: 'not-received',
          uploadProviderOutcome: 'unknown',
          safeAction: 'preserve evidence and inspect diagnostics',
          retryable: false,
          sanitizedExceptionClass: error.runtimeType.toString(),
        ),
      );
      return const HostedSyncOutcome.failed();
    } on StateError catch (error) {
      if (error.message == 'auth-required' ||
          error.message == 'token-expired' ||
          error.message == 'signed-out') {
        await diagnostics?.recordPhase(
          SyncDiagnosticPhaseEvidence(
            code: 'MKS-AUT-001',
            nativeCode: error.message,
            severity: 'ERROR',
            operationKind: 'ordinary-sync',
            phase: 'terminal',
            lastProvedPhase: 'authentication',
            outcome: 'blocked',
            safeAction: 'sign in before Sync',
            sanitizedExceptionClass: error.runtimeType.toString(),
          ),
        );
        return const HostedSyncOutcome.authenticationRequired();
      }
      if (error.message == 'cursor-expired') {
        await diagnostics?.recordPhase(
          SyncDiagnosticPhaseEvidence(
            code: 'MKS-DNL-004',
            nativeCode: error.message,
            severity: 'ERROR',
            operationKind: 'ordinary-sync',
            phase: 'terminal',
            lastProvedPhase: 'download-provider',
            outcome: 'unknown',
            providerContactState: 'request-started',
            trustedResponseState: 'received',
            downloadRequestState: 'started',
            downloadTrustedResponseState: 'received',
            safeAction: 'preserve evidence and inspect diagnostics',
            retryable: false,
            sanitizedExceptionClass: error.runtimeType.toString(),
          ),
        );
        return const HostedSyncOutcome.failed();
      }
      await diagnostics?.recordPhase(
        SyncDiagnosticPhaseEvidence(
          code: 'MKS-LDB-001',
          nativeCode: 'state-error-redacted',
          severity: 'ERROR',
          operationKind: 'ordinary-sync',
          phase: 'terminal',
          lastProvedPhase: 'terminal',
          outcome: 'unknown',
          safeAction: 'preserve evidence and inspect diagnostics',
          retryable: false,
          sanitizedExceptionClass: error.runtimeType.toString(),
        ),
      );
      return const HostedSyncOutcome.failed();
    }
  }

  HostedSyncOutcome? _blockedBy(SyncResult? result) {
    if (result == null) return null;
    return switch (result.code) {
      SyncStatusCode.authRequired =>
        const HostedSyncOutcome.authenticationRequired(),
      SyncStatusCode.deviceEnrollmentRequired =>
        const HostedSyncOutcome.deviceEnrollmentRequired(),
      SyncStatusCode.deviceRevoked ||
      SyncStatusCode.deviceExpired => const HostedSyncOutcome.deviceRevoked(),
      SyncStatusCode.unknownOutcome => const HostedSyncOutcome.failed(),
      SyncStatusCode.noRecoverableFailure ||
      SyncStatusCode.failedRecoveryAvailable => null,
      SyncStatusCode.conflict ||
      SyncStatusCode.sequenceGap ||
      SyncStatusCode.wrongAccount ||
      SyncStatusCode.hashMismatch ||
      SyncStatusCode.localBatchInvalid ||
      SyncStatusCode.failedRecoveryBlocked ||
      SyncStatusCode.serviceUnavailable ||
      SyncStatusCode.cursorExpired ||
      SyncStatusCode.recoveryUnavailable ||
      SyncStatusCode.fullRebootstrapRequired ||
      SyncStatusCode.localChangesBlockRebootstrap ||
      SyncStatusCode.protocolUpgradeRequired =>
        result.protocolCode == 'server-timeout'
            ? const HostedSyncOutcome.serverTimeout()
            : const HostedSyncOutcome.rejected(),
      _ => null,
    };
  }
}

final class HostedSyncOutcome {
  const HostedSyncOutcome._(this.state);

  const HostedSyncOutcome.authenticationRequired()
    : this._('authentication-required');

  const HostedSyncOutcome.deviceEnrollmentRequired()
    : this._('device-enrollment-required');

  const HostedSyncOutcome.noNewEvents() : this._('sync-no-new-events');

  const HostedSyncOutcome.completed() : this._('sync-completed');

  const HostedSyncOutcome.failed() : this._('sync-failed');

  const HostedSyncOutcome.rejected() : this._('sync-rejected');

  const HostedSyncOutcome.serverTimeout() : this._('sync-server-timeout');

  const HostedSyncOutcome.deviceRevoked() : this._('device-revoked');

  final String state;
}
