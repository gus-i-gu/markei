import '../domain/references/local_reference.dart';
import '../domain/shared/ids.dart';

abstract interface class HouseholdQueryRepository {
  Future<List<HouseholdPersonSummary>> householdPeople(AccountId accountId);
}

final class HouseholdPersonSummary {
  const HouseholdPersonSummary({
    required this.person,
    this.paymentMethods = const [],
    this.latestPurchase,
  });

  final LocalReference person;
  final List<LocalReference> paymentMethods;
  final HouseholdPurchaseSummary? latestPurchase;
}

final class HouseholdPurchaseSummary {
  const HouseholdPurchaseSummary({
    required this.purchaseId,
    required this.storeName,
    required this.occurrenceTime,
    required this.currencyCode,
    required this.totalMinorUnits,
  });

  final PurchaseId purchaseId;
  final String storeName;
  final DateTime occurrenceTime;
  final String currencyCode;
  final int totalMinorUnits;
}
