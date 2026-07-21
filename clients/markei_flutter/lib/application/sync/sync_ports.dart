import '../../domain/sync/sync_event.dart';

typedef SubmissionIdFactory = String Function();

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
