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
  });

  final SyncStatusCode code;
  final SyncOutcome outcome;
  final bool retryable;
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
}

abstract interface class RemoteEventApplier {
  Future<SyncResult> applyPage(DownloadPage page);
  Future<String?> greatestContiguousAppliedCursor();
}
