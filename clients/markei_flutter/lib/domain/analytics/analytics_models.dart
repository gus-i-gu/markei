import '../shared/ids.dart';
import '../shared/quantity.dart';

typedef AnalyticsEvidenceRowId = PurchaseItemId;

enum AnalyticsDeterminantKind {
  product,
  purchase,
  store,
  timeDayUtc,
  timeMonthUtc,
}

enum AnalyticsVariable {
  quantity,
  unitPrice,
  lineTotal,
  purchaseTotal,
  evidenceCount,
}

enum AnalyticsOperation { sum, mean, difference, percentage }

enum AnalyticsUnavailableReason {
  unavailableField,
  invalidCombination,
  insufficientEvidence,
  incompatible,
  zeroDenominator,
  overflow,
  staleContext,
  calculationFailure,
}

final class AnalyticsCompatibilityKey {
  const AnalyticsCompatibilityKey(this.value);

  final String value;
}

final class AnalyticsMoneyAmount {
  const AnalyticsMoneyAmount({
    required this.currencyCode,
    required this.minorUnits,
  });

  final String currencyCode;
  final int minorUnits;
}

final class AnalyticsUnitPrice {
  const AnalyticsUnitPrice({
    required this.currencyCode,
    required this.minorUnitsPerCanonicalUnit,
    required this.kind,
    required this.unit,
  });

  final String currencyCode;
  final int minorUnitsPerCanonicalUnit;
  final MeasurementKind kind;
  final CanonicalUnit unit;
}

final class AnalyticsEvidenceRow {
  const AnalyticsEvidenceRow({
    required this.id,
    required this.accountId,
    required this.purchaseId,
    required this.purchaseOccurrenceTime,
    required this.purchaseTotal,
    required this.productId,
    required this.productCode,
    required this.productName,
    required this.productBrand,
    required this.storeId,
    required this.storeName,
    required this.purchasedBy,
    required this.paymentMethod,
    required this.quantity,
    required this.lineTotal,
    required this.unitPrice,
  });

  final AnalyticsEvidenceRowId id;
  final AccountId accountId;
  final PurchaseId purchaseId;
  final DateTime purchaseOccurrenceTime;
  final AnalyticsMoneyAmount purchaseTotal;
  final ProductId productId;
  final String productCode;
  final String productName;
  final String productBrand;
  final StoreId storeId;
  final String storeName;
  final String? purchasedBy;
  final String? paymentMethod;
  final NormalizedQuantity quantity;
  final AnalyticsMoneyAmount lineTotal;
  final AnalyticsUnitPrice? unitPrice;
}

final class AnalyticsDataset {
  const AnalyticsDataset({required this.accountId, required this.rows});

  final AccountId accountId;
  final List<AnalyticsEvidenceRow> rows;

  Set<PurchaseId> get purchaseIds => {for (final row in rows) row.purchaseId};
}

sealed class AnalyticsCondition {
  const AnalyticsCondition();
}

final class AnalyticsUtcPeriodCondition extends AnalyticsCondition {
  const AnalyticsUtcPeriodCondition({required this.start, required this.end});

  final DateTime start;
  final DateTime end;

  bool contains(DateTime value) {
    final utc = value.toUtc();
    return !utc.isBefore(start.toUtc()) && utc.isBefore(end.toUtc());
  }
}

final class AnalyticsFieldCondition extends AnalyticsCondition {
  const AnalyticsFieldCondition({required this.field, required this.value});

  final AnalyticsDeterminantKind field;
  final String value;
}

sealed class AnalyticsEvidenceScope {
  const AnalyticsEvidenceScope();
}

final class FilteredAnalyticsEvidenceScope extends AnalyticsEvidenceScope {
  const FilteredAnalyticsEvidenceScope();
}

final class SelectedAnalyticsEvidenceScope extends AnalyticsEvidenceScope {
  const SelectedAnalyticsEvidenceScope(this.rowIds);

  final Set<AnalyticsEvidenceRowId> rowIds;
}

final class ComparisonAnalyticsEvidenceScope extends AnalyticsEvidenceScope {
  const ComparisonAnalyticsEvidenceScope({
    required this.baselineLabel,
    required this.baselineRowIds,
    required this.comparisonLabel,
    required this.comparisonRowIds,
  });

  final String baselineLabel;
  final Set<AnalyticsEvidenceRowId> baselineRowIds;
  final String comparisonLabel;
  final Set<AnalyticsEvidenceRowId> comparisonRowIds;
}

final class PercentageAnalyticsEvidenceScope extends AnalyticsEvidenceScope {
  const PercentageAnalyticsEvidenceScope({
    required this.partLabel,
    required this.partRowIds,
    required this.wholeLabel,
    required this.wholeRowIds,
  });

  final String partLabel;
  final Set<AnalyticsEvidenceRowId> partRowIds;
  final String wholeLabel;
  final Set<AnalyticsEvidenceRowId> wholeRowIds;
}

final class AnalyticsCardId {
  const AnalyticsCardId(this.value);

  final int value;
}

final class AnalyticsCardRevision {
  const AnalyticsCardRevision(this.value);

  final int value;
}

final class AnalyticsCardConfiguration {
  const AnalyticsCardConfiguration({
    required this.id,
    required this.revision,
    required this.determinant,
    required this.variables,
    required this.operation,
    this.conditions = const [],
    this.scope = const FilteredAnalyticsEvidenceScope(),
  });

  final AnalyticsCardId id;
  final AnalyticsCardRevision revision;
  final AnalyticsDeterminantKind determinant;
  final Set<AnalyticsVariable> variables;
  final AnalyticsOperation operation;
  final List<AnalyticsCondition> conditions;
  final AnalyticsEvidenceScope scope;

  AnalyticsCardConfiguration copyWith({
    AnalyticsCardRevision? revision,
    AnalyticsDeterminantKind? determinant,
    Set<AnalyticsVariable>? variables,
    AnalyticsOperation? operation,
    List<AnalyticsCondition>? conditions,
    AnalyticsEvidenceScope? scope,
  }) {
    return AnalyticsCardConfiguration(
      id: id,
      revision: revision ?? this.revision,
      determinant: determinant ?? this.determinant,
      variables: variables ?? this.variables,
      operation: operation ?? this.operation,
      conditions: conditions ?? this.conditions,
      scope: scope ?? this.scope,
    );
  }
}

sealed class AnalyticsResultValue {
  const AnalyticsResultValue();
}

final class AnalyticsIntegerResultValue extends AnalyticsResultValue {
  const AnalyticsIntegerResultValue({
    required this.label,
    required this.value,
    required this.compatibilityKey,
    this.unitLabel,
  });

  final String label;
  final int value;
  final AnalyticsCompatibilityKey compatibilityKey;
  final String? unitLabel;
}

final class AnalyticsBasisPointResultValue extends AnalyticsResultValue {
  const AnalyticsBasisPointResultValue({
    required this.label,
    required this.basisPoints,
    required this.part,
    required this.whole,
    required this.compatibilityKey,
  });

  final String label;
  final int basisPoints;
  final int part;
  final int whole;
  final AnalyticsCompatibilityKey compatibilityKey;
}

final class AnalyticsUnavailableResultValue extends AnalyticsResultValue {
  const AnalyticsUnavailableResultValue({
    required this.label,
    required this.reason,
    required this.message,
  });

  final String label;
  final AnalyticsUnavailableReason reason;
  final String message;
}

final class AnalyticsResultEnvelope {
  const AnalyticsResultEnvelope({
    required this.registryIdentifier,
    required this.registryVersion,
    required this.configuration,
    required this.values,
    required this.contributingRowIds,
    required this.eligibleCount,
    required this.totalCount,
    required this.excludedCount,
    required this.periodStartUtc,
    required this.periodEndUtc,
    required this.interpretation,
  });

  final String registryIdentifier;
  final int registryVersion;
  final AnalyticsCardConfiguration configuration;
  final List<AnalyticsResultValue> values;
  final Set<AnalyticsEvidenceRowId> contributingRowIds;
  final int eligibleCount;
  final int totalCount;
  final int excludedCount;
  final DateTime? periodStartUtc;
  final DateTime? periodEndUtc;
  final String interpretation;
}
