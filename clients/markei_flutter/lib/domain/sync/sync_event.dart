import '../purchase/purchase.dart';
import '../shared/ids.dart';

enum PendingEventState { pending, uploading, accepted, failed }

final class SyncEvent {
  const SyncEvent({
    required this.id,
    required this.accountId,
    required this.deviceId,
    required this.deviceSequence,
    required this.eventType,
    required this.payloadVersion,
    required this.occurrenceTime,
    required this.purchase,
  });

  final EventId id;
  final AccountId accountId;
  final DeviceId deviceId;
  final int deviceSequence;
  final String eventType;
  final int payloadVersion;
  final DateTime occurrenceTime;
  final Purchase purchase;

  Map<String, Object?> toJson() => {
    'id': id.value,
    'accountId': accountId.value,
    'deviceId': deviceId.value,
    'deviceSequence': deviceSequence,
    'eventType': eventType,
    'payloadVersion': payloadVersion,
    'occurrenceTime': occurrenceTime.toUtc().toIso8601String(),
    'purchase': purchase.toJson(),
  };
}
