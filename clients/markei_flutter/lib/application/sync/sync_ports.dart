import 'dart:async';

import '../../domain/sync/sync_event.dart';

typedef SubmissionIdFactory = String Function();

final Object _syncCorrelationZoneKey = Object();
final Object _syncOperationZoneKey = Object();
final Object _syncOperationFingerprintZoneKey = Object();

String? currentSyncCorrelationId() =>
    Zone.current[_syncCorrelationZoneKey] as String?;

String? currentSyncOperationId() =>
    Zone.current[_syncOperationZoneKey] as String?;

String? currentSyncOperationFingerprint() =>
    Zone.current[_syncOperationFingerprintZoneKey] as String?;

Future<T> withSyncCorrelation<T>(
  String correlationId,
  Future<T> Function() body,
) {
  return runZoned(body, zoneValues: {_syncCorrelationZoneKey: correlationId});
}

Future<T> withSyncOperation<T>({
  required String operationId,
  required String operationFingerprint,
  required Future<T> Function() body,
}) {
  return runZoned(
    body,
    zoneValues: {
      _syncOperationZoneKey: operationId,
      _syncOperationFingerprintZoneKey: operationFingerprint,
    },
  );
}

final class SyncDiagnosticChildIdentity {
  const SyncDiagnosticChildIdentity({
    required this.correlationId,
    required this.correlationFingerprint,
    required this.ordinal,
  });

  final String correlationId;
  final String correlationFingerprint;
  final int ordinal;
}

final class SyncDiagnosticPhaseEvidence {
  const SyncDiagnosticPhaseEvidence({
    required this.code,
    required this.nativeCode,
    required this.operationKind,
    required this.phase,
    required this.lastProvedPhase,
    required this.outcome,
    required this.safeAction,
    this.severity = 'INFO',
    this.localMutationState = 'none',
    this.providerContactState = 'not-started',
    this.providerTransactionState = 'not-started',
    this.trustedResponseState = 'not-received',
    this.resultPersistenceState = 'not-started',
    this.retryable = false,
    this.httpStatus,
    this.responseHeadersReceived = false,
    this.sanitizedExceptionClass,
    this.serverSqlstateClass,
    this.queueScope,
    this.pendingCount,
    this.uploadingCount,
    this.failedCount,
    this.unknownCount,
    this.memberCount,
    this.firstDeviceSequence,
    this.lastDeviceSequence,
    this.nextDeviceSequence,
    this.submissionFingerprint,
  });

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
}

abstract interface class SyncDiagnosticPhaseRecorder {
  Future<SyncDiagnosticChildIdentity> recordPhase(
    SyncDiagnosticPhaseEvidence evidence,
  );
}

final class SyncUploadSubmission {
  const SyncUploadSubmission({
    required this.id,
    required this.deviceId,
    required this.requestHash,
    required this.events,
  });

  final String id;
  final String deviceId;
  final String requestHash;
  final List<Map<String, Object?>> events;
}

final class FailedNotAppliedRecoveryConfirmation {
  const FailedNotAppliedRecoveryConfirmation({
    required this.candidateFingerprint,
    required this.memberCount,
    required this.firstDeviceSequence,
    required this.lastDeviceSequence,
    required this.nextDeviceSequence,
    required this.pendingCount,
    required this.uploadingCount,
    required this.failedCount,
    required this.unknownCount,
  });

  final String candidateFingerprint;
  final int memberCount;
  final int firstDeviceSequence;
  final int lastDeviceSequence;
  final int nextDeviceSequence;
  final int pendingCount;
  final int uploadingCount;
  final int failedCount;
  final int unknownCount;
}

final class FailedNotAppliedRecoveredBatch {
  const FailedNotAppliedRecoveredBatch({
    required this.submissionId,
    required this.candidateFingerprint,
    required this.memberCount,
    required this.firstDeviceSequence,
    required this.lastDeviceSequence,
    required this.nextDeviceSequence,
  });

  final String submissionId;
  final String candidateFingerprint;
  final int memberCount;
  final int firstDeviceSequence;
  final int lastDeviceSequence;
  final int nextDeviceSequence;
}

final class SyncResult {
  const SyncResult({
    required this.code,
    required this.outcome,
    required this.retryable,
    this.protocolCode,
  });

  final SyncStatusCode code;
  final SyncOutcome outcome;
  final bool retryable;
  final String? protocolCode;
}

final class SyncBatchPreflightException implements Exception {
  const SyncBatchPreflightException(this.result);

  final SyncResult result;
}

final class SyncPersistenceInvariantException implements Exception {
  const SyncPersistenceInvariantException(this.result);

  final SyncResult result;
}

final class DownloadedEvent {
  const DownloadedEvent({required this.event, required this.serverCursor});

  final Map<String, Object?> event;
  final String serverCursor;
}

final class DownloadPage {
  const DownloadPage({required this.nextCursor, required this.events});

  final String? nextCursor;
  final List<DownloadedEvent> events;
}

abstract interface class SyncTransport {
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission);
  Future<DownloadPage> downloadAfter(String? cursor, {required int limit});
  Future<SyncResult> acknowledge(String greatestContiguousCursor);
}

abstract interface class SyncOutboxRepository {
  Future<SyncUploadSubmission?> leasePending({required int limit});
  Future<FailedNotAppliedRecoveredBatch> recoverExactFailedNotAppliedCandidate(
    FailedNotAppliedRecoveryConfirmation confirmation,
  );
  Future<SyncUploadSubmission> leaseExactRecoveredBatch(
    FailedNotAppliedRecoveredBatch batch,
  );
  Future<void> persistUploadResult(String submissionId, SyncResult result);
  Future<SyncResult> recoverFailedNotApplied(String submissionId);
  Future<SyncResult> recoverOneFailedNotApplied();
}

abstract interface class RemoteEventApplier {
  Future<SyncResult> applyPage(DownloadPage page);
  Future<String?> greatestContiguousAppliedCursor();
}

final class RecoveryManifest {
  const RecoveryManifest({
    required this.accountId,
    required this.snapshotId,
    required this.formatVersion,
    required this.coveredThroughCursor,
    required this.chunks,
    required this.totalBytes,
    required this.totalHash,
    required this.manifestHash,
  });

  final String accountId;
  final String snapshotId;
  final int formatVersion;
  final String coveredThroughCursor;
  final List<RecoveryChunkDescriptor> chunks;
  final int totalBytes;
  final String totalHash;
  final String manifestHash;
}

final class RecoveryChunkDescriptor {
  const RecoveryChunkDescriptor({
    required this.index,
    required this.length,
    required this.hash,
  });

  final int index;
  final int length;
  final String hash;
}

final class RecoveryChunk {
  const RecoveryChunk({
    required this.index,
    required this.length,
    required this.hash,
    required this.bytes,
  });

  final int index;
  final int length;
  final String hash;
  final List<int> bytes;
}

final class RecoverySession {
  const RecoverySession({
    required this.id,
    required this.phase,
    required this.manifest,
  });

  final String id;
  final RecoveryPhase phase;
  final RecoveryManifest manifest;
}

abstract interface class RecoveryTransport {
  Future<RecoverySession> startRecovery({
    required String recoverySessionId,
    required String requestHash,
  });
  Future<RecoverySession> queryRecovery(String recoverySessionId);
  Future<RecoveryChunk> downloadChunk(String recoverySessionId, int index);
  Future<SyncResult> completeRecovery({
    required String recoverySessionId,
    required String snapshotId,
    required String manifestHash,
    required String committedCatchUpCursor,
  });
}

abstract interface class RecoveryProgressRepository {
  Future<void> saveSession(RecoverySession session);
  Future<void> saveChunk(String sessionId, RecoveryChunk chunk);
  Future<List<RecoveryChunk>> loadedChunks(String sessionId);
}

abstract interface class SnapshotFactApplier {
  Future<SyncResult> applySnapshotFacts({
    required RecoveryManifest manifest,
    required List<RecoveryChunk> chunks,
  });
}

abstract interface class LocalRecoveryGuard {
  Future<SyncResult> ensureRebootstrapAllowed();
}
