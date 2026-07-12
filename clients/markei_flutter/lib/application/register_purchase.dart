import '../domain/purchase/purchase.dart';
import '../domain/shared/ids.dart';

final class RegisterPurchaseCommand {
  const RegisterPurchaseCommand({
    required this.accountId,
    required this.deviceId,
    required this.storeName,
    required this.occurrenceTime,
    required this.currencyCode,
    required this.items,
  });

  final AccountId accountId;
  final DeviceId deviceId;
  final String storeName;
  final DateTime occurrenceTime;
  final String currencyCode;
  final List<PurchaseItemDraft> items;
}

abstract interface class PurchaseRegistrationRepository {
  Future<PurchaseRegistrationResult> registerPurchase(
    RegisterPurchaseCommand command,
  );
}

final class PurchaseRegistrationResult {
  const PurchaseRegistrationResult({
    required this.purchaseId,
    required this.eventId,
    required this.deviceSequence,
  });

  final PurchaseId purchaseId;
  final EventId eventId;
  final int deviceSequence;
}
