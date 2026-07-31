import '../domain/analytics/analytics_models.dart';
import '../domain/shared/ids.dart';

abstract interface class AnalyticsEvidenceRepository {
  Future<AnalyticsDataset> loadEvidence(AccountId accountId);
}

sealed class AnalyticsLaunchContext {
  const AnalyticsLaunchContext();

  const factory AnalyticsLaunchContext.purchaseSelection(
    AccountId accountId,
    Set<PurchaseId> purchaseIds,
  ) = AnalyticsPurchaseSelectionLaunchContext;
}

final class AnalyticsPurchaseSelectionLaunchContext
    extends AnalyticsLaunchContext {
  const AnalyticsPurchaseSelectionLaunchContext(
    this.accountId,
    this.purchaseIds,
  );

  final AccountId accountId;
  final Set<PurchaseId> purchaseIds;
}
