import 'sync_ports.dart';

final class UploadPendingEvents {
  const UploadPendingEvents(this.outbox, this.transport);

  final SyncOutboxRepository outbox;
  final SyncTransport transport;

  Future<SyncResult?> call({int limit = 25}) async {
    final SyncUploadSubmission? submission;
    try {
      submission = await outbox.leasePending(limit: limit);
    } on SyncBatchPreflightException catch (failure) {
      return failure.result;
    }
    if (submission == null) {
      return null;
    }
    final result = await transport.uploadSubmission(submission);
    await outbox.persistUploadResult(submission.id, result);
    return result;
  }
}

final class DownloadAndApplyEvents {
  const DownloadAndApplyEvents(this.transport, this.applier);

  final SyncTransport transport;
  final RemoteEventApplier applier;

  Future<SyncResult> call(String? cursor, {int limit = 100}) async {
    final page = await transport.downloadAfter(cursor, limit: limit);
    return applier.applyPage(page);
  }
}

final class AcknowledgeAppliedCursor {
  const AcknowledgeAppliedCursor(this.transport, this.applier);

  final SyncTransport transport;
  final RemoteEventApplier applier;

  Future<SyncResult?> call() async {
    final cursor = await applier.greatestContiguousAppliedCursor();
    if (cursor == null) {
      return null;
    }
    return transport.acknowledge(cursor);
  }
}
