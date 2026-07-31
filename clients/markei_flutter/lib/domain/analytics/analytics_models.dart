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
  purchasedBy,
  purchasedFor,
  paymentMethod,
  quantity,
  unitPrice,
  lineTotal,
  purchaseTotal,
  evidenceCount,
}

enum AnalyticsMeasure {
  quantity,
  unitPrice,
  lineTotal,
  purchaseTotal,
  evidenceCount,
}

enum AnalyticsRelationalBreakdown { purchasedBy, paymentMethod, purchasedFor }

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
  contradiction,
}

enum AnalyticsTimeframeKind { allRecordedTime, customUtc }

enum AnalyticsResultPresentation { chart, table }

enum AnalyticsVariablesProjection { purchases, containedItems }

enum AnalyticsVariablesSort {
  timeAscending,
  timeDescending,
  labelAscending,
  totalDescending,
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

final class AnalyticsReference {
  const AnalyticsReference({
    required this.id,
    required this.label,
    this.code,
    this.archived = false,
  });

  final String id;
  final String? code;
  final String label;
  final bool archived;

  String get displayLabel {
    final prefix = code == null ? '' : '$code ';
    final suffix = archived ? ' (archived)' : '';
    return '$prefix$label$suffix';
  }
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
  final AnalyticsReference? purchasedBy;
  final AnalyticsReference? paymentMethod;
  final NormalizedQuantity quantity;
  final AnalyticsMoneyAmount lineTotal;
  final AnalyticsUnitPrice? unitPrice;

  String? get purchasedByLabel => purchasedBy?.displayLabel;
  String? get paymentMethodLabel => paymentMethod?.displayLabel;
}

final class AnalyticsDataset {
  AnalyticsDataset({
    required this.accountId,
    required List<AnalyticsEvidenceRow> rows,
  }) : rows = List.unmodifiable(rows);

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

typedef AnalyticsRecordId = AnalyticsCardId;

typedef AnalyticsRecordFingerprint = String;

final class AnalyticsTimeframe {
  const AnalyticsTimeframe.all()
    : kind = AnalyticsTimeframeKind.allRecordedTime,
      startUtc = null,
      endUtc = null,
      initialLocalDate = null,
      finalLocalDate = null,
      invalidDraft = null;

  const AnalyticsTimeframe.custom({
    required DateTime this.startUtc,
    required DateTime this.endUtc,
    this.initialLocalDate,
    this.finalLocalDate,
  }) : kind = AnalyticsTimeframeKind.customUtc,
       invalidDraft = null;

  const AnalyticsTimeframe.invalid(this.invalidDraft)
    : kind = AnalyticsTimeframeKind.customUtc,
      startUtc = null,
      endUtc = null,
      initialLocalDate = null,
      finalLocalDate = null;

  final AnalyticsTimeframeKind kind;
  final DateTime? startUtc;
  final DateTime? endUtc;
  final String? initialLocalDate;
  final String? finalLocalDate;
  final String? invalidDraft;

  bool get isValid {
    if (kind == AnalyticsTimeframeKind.allRecordedTime) return true;
    final start = startUtc;
    final end = endUtc;
    return start != null && end != null && end.isAfter(start);
  }

  List<AnalyticsCondition> toConditions() {
    if (kind == AnalyticsTimeframeKind.allRecordedTime || !isValid) {
      return const [];
    }
    return [
      AnalyticsUtcPeriodCondition(
        start: startUtc!.toUtc(),
        end: endUtc!.toUtc(),
      ),
    ];
  }

  String get label {
    if (kind == AnalyticsTimeframeKind.allRecordedTime) {
      return 'All recorded time';
    }
    if (!isValid) return invalidDraft ?? 'Invalid custom timeframe';
    if (initialLocalDate != null && finalLocalDate != null) {
      return '$initialLocalDate to $finalLocalDate';
    }
    return 'Custom dates';
  }
}

final class AnalyticsOption {
  const AnalyticsOption({required this.key, required this.label});

  final String key;
  final String label;
}

final class AnalyticsComposerDraft {
  const AnalyticsComposerDraft({
    this.determinant = AnalyticsDeterminantKind.product,
    this.selectedDeterminantKeys = const {},
    this.variables = const {},
    this.breakdowns = const {},
    this.measures = const {},
    this.operation = AnalyticsOperation.sum,
    this.timeframe = const AnalyticsTimeframe.all(),
    this.scope = const FilteredAnalyticsEvidenceScope(),
  });

  final AnalyticsDeterminantKind determinant;
  final Set<String> selectedDeterminantKeys;
  final Set<AnalyticsVariable> variables;
  final Set<AnalyticsRelationalBreakdown> breakdowns;
  final Set<AnalyticsMeasure> measures;
  final AnalyticsOperation operation;
  final AnalyticsTimeframe timeframe;
  final AnalyticsEvidenceScope scope;

  AnalyticsComposerDraft copyWith({
    AnalyticsDeterminantKind? determinant,
    Set<String>? selectedDeterminantKeys,
    Set<AnalyticsVariable>? variables,
    Set<AnalyticsRelationalBreakdown>? breakdowns,
    Set<AnalyticsMeasure>? measures,
    AnalyticsOperation? operation,
    AnalyticsTimeframe? timeframe,
    AnalyticsEvidenceScope? scope,
  }) {
    return AnalyticsComposerDraft(
      determinant: determinant ?? this.determinant,
      selectedDeterminantKeys:
          selectedDeterminantKeys ?? this.selectedDeterminantKeys,
      variables: variables ?? this.variables,
      breakdowns: breakdowns ?? _breakdownsFor(variables ?? this.variables),
      measures: measures ?? _measuresFor(variables ?? this.variables),
      operation: operation ?? this.operation,
      timeframe: timeframe ?? this.timeframe,
      scope: scope ?? this.scope,
    );
  }

  static Set<AnalyticsRelationalBreakdown> _breakdownsFor(
    Set<AnalyticsVariable> variables,
  ) {
    return {
      if (variables.contains(AnalyticsVariable.purchasedBy))
        AnalyticsRelationalBreakdown.purchasedBy,
      if (variables.contains(AnalyticsVariable.purchasedFor))
        AnalyticsRelationalBreakdown.purchasedFor,
      if (variables.contains(AnalyticsVariable.paymentMethod))
        AnalyticsRelationalBreakdown.paymentMethod,
    };
  }

  static Set<AnalyticsMeasure> _measuresFor(Set<AnalyticsVariable> variables) {
    return {
      if (variables.contains(AnalyticsVariable.quantity))
        AnalyticsMeasure.quantity,
      if (variables.contains(AnalyticsVariable.unitPrice))
        AnalyticsMeasure.unitPrice,
      if (variables.contains(AnalyticsVariable.lineTotal))
        AnalyticsMeasure.lineTotal,
      if (variables.contains(AnalyticsVariable.purchaseTotal))
        AnalyticsMeasure.purchaseTotal,
      if (variables.contains(AnalyticsVariable.evidenceCount))
        AnalyticsMeasure.evidenceCount,
    };
  }
}

final class AnalyticsDraftValidation {
  const AnalyticsDraftValidation({
    required this.canRun,
    required this.explanation,
  });

  final bool canRun;
  final String explanation;
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

final class AnalyticsDisplayValue {
  const AnalyticsDisplayValue({required this.value, required this.unit});

  final String value;
  final String unit;
}

AnalyticsDisplayValue analyticsDisplayValue(
  AnalyticsMeasure measure,
  AnalyticsResultValue result,
) {
  return switch (result) {
    AnalyticsIntegerResultValue() => _integerDisplayValue(measure, result),
    AnalyticsBasisPointResultValue() => AnalyticsDisplayValue(
      value: '${(result.basisPoints / 100).toStringAsFixed(2)}%',
      unit: 'percent',
    ),
    AnalyticsUnavailableResultValue() => AnalyticsDisplayValue(
      value: result.message,
      unit: '',
    ),
  };
}

AnalyticsDisplayValue _integerDisplayValue(
  AnalyticsMeasure measure,
  AnalyticsIntegerResultValue result,
) {
  final key = result.compatibilityKey.value;
  return switch (measure) {
    AnalyticsMeasure.quantity => AnalyticsDisplayValue(
      value: (result.value / NormalizedQuantity.factor).toStringAsFixed(3),
      unit: _lastKeyPart(key),
    ),
    AnalyticsMeasure.unitPrice => AnalyticsDisplayValue(
      value: _minorUnits(result.value),
      unit: '${_keyPart(key, 1)} per ${_keyPart(key, 3)}',
    ),
    AnalyticsMeasure.lineTotal ||
    AnalyticsMeasure.purchaseTotal => AnalyticsDisplayValue(
      value: _minorUnits(result.value),
      unit: _keyPart(key, 1),
    ),
    AnalyticsMeasure.evidenceCount => AnalyticsDisplayValue(
      value: result.value.toString(),
      unit: 'item rows',
    ),
  };
}

String _minorUnits(int value) {
  final sign = value < 0 ? '-' : '';
  final abs = value.abs();
  final whole = abs ~/ 100;
  final cents = (abs % 100).toString().padLeft(2, '0');
  return '$sign$whole.$cents';
}

String _keyPart(String key, int index) {
  final parts = key.split(':');
  if (index >= parts.length) return '';
  return parts[index];
}

String _lastKeyPart(String key) {
  final parts = key.split(':');
  return parts.isEmpty ? '' : parts.last;
}

final class AnalyticsGroupKey {
  AnalyticsGroupKey({
    required this.value,
    required this.determinantLabel,
    Map<AnalyticsRelationalBreakdown, String> breakdownLabels = const {},
  }) : breakdownLabels = Map.unmodifiable(breakdownLabels);

  final String value;
  final String determinantLabel;
  final Map<AnalyticsRelationalBreakdown, String> breakdownLabels;
}

final class AnalyticsGroupedResultEntry {
  AnalyticsGroupedResultEntry({
    required this.groupKey,
    required this.measure,
    required this.operation,
    required this.compatibilityKey,
    required this.value,
    required this.eligibleCount,
    required this.totalCount,
    required this.excludedCount,
    Set<AnalyticsEvidenceRowId> contributingRowIds = const {},
  }) : contributingRowIds = Set.unmodifiable(contributingRowIds);

  final AnalyticsGroupKey groupKey;
  final AnalyticsMeasure measure;
  final AnalyticsOperation operation;
  final AnalyticsCompatibilityKey compatibilityKey;
  final AnalyticsResultValue value;
  final int eligibleCount;
  final int totalCount;
  final int excludedCount;
  final Set<AnalyticsEvidenceRowId> contributingRowIds;

  bool get isPlottable => value is AnalyticsIntegerResultValue;
}

final class AnalyticsResultEnvelope {
  AnalyticsResultEnvelope({
    required this.registryIdentifier,
    required this.registryVersion,
    required this.configuration,
    required List<AnalyticsResultValue> values,
    required Set<AnalyticsEvidenceRowId> contributingRowIds,
    required this.eligibleCount,
    required this.totalCount,
    required this.excludedCount,
    required this.periodStartUtc,
    required this.periodEndUtc,
    required this.interpretation,
  }) : values = List.unmodifiable(values),
       contributingRowIds = Set.unmodifiable(contributingRowIds);

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

final class AnalyticsRecord {
  AnalyticsRecord({
    required this.id,
    required this.fingerprint,
    required this.executedAtUtc,
    required this.registryIdentifier,
    required this.registryVersion,
    required this.draft,
    required List<AnalyticsOption> selectedValues,
    required List<AnalyticsGroupedResultEntry> entries,
    required Set<AnalyticsEvidenceRowId> contributingRowIds,
    required this.eligibleCount,
    required this.totalCount,
    required this.excludedCount,
    required this.interpretation,
  }) : selectedValues = List.unmodifiable(selectedValues),
       entries = List.unmodifiable(entries),
       contributingRowIds = Set.unmodifiable(contributingRowIds);

  final AnalyticsRecordId id;
  final AnalyticsRecordFingerprint fingerprint;
  final DateTime executedAtUtc;
  final String registryIdentifier;
  final int registryVersion;
  final AnalyticsComposerDraft draft;
  final List<AnalyticsOption> selectedValues;
  final List<AnalyticsGroupedResultEntry> entries;
  final Set<AnalyticsEvidenceRowId> contributingRowIds;
  final int eligibleCount;
  final int totalCount;
  final int excludedCount;
  final String interpretation;
}

final class AnalyticsPurchaseProjectionRow {
  AnalyticsPurchaseProjectionRow({
    required this.purchaseId,
    required this.occurrenceTime,
    required this.storeId,
    required this.storeName,
    required this.purchasedBy,
    required this.paymentMethod,
    required this.itemCount,
    required this.purchaseTotal,
    required Set<AnalyticsEvidenceRowId> itemIds,
    this.unavailableReason,
  }) : itemIds = Set.unmodifiable(itemIds);

  final PurchaseId purchaseId;
  final DateTime occurrenceTime;
  final StoreId storeId;
  final String storeName;
  final AnalyticsReference? purchasedBy;
  final AnalyticsReference? paymentMethod;
  final int itemCount;
  final AnalyticsMoneyAmount purchaseTotal;
  final Set<AnalyticsEvidenceRowId> itemIds;
  final AnalyticsUnavailableResultValue? unavailableReason;
}

final class AnalyticsVariablesState {
  AnalyticsVariablesState({
    required this.projection,
    required this.search,
    required this.sort,
    required this.pageIndex,
    required this.pageSize,
    required List<AnalyticsPurchaseProjectionRow> purchaseRows,
    required List<AnalyticsEvidenceRow> itemRows,
    required Set<AnalyticsEvidenceRowId> selectedRowIds,
    this.focusedRecord,
    this.message,
  }) : purchaseRows = List.unmodifiable(purchaseRows),
       itemRows = List.unmodifiable(itemRows),
       selectedRowIds = Set.unmodifiable(selectedRowIds);

  final AnalyticsVariablesProjection projection;
  final String search;
  final AnalyticsVariablesSort sort;
  final int pageIndex;
  final int pageSize;
  final List<AnalyticsPurchaseProjectionRow> purchaseRows;
  final List<AnalyticsEvidenceRow> itemRows;
  final Set<AnalyticsEvidenceRowId> selectedRowIds;
  final AnalyticsRecord? focusedRecord;
  final String? message;

  int get selectedCount => selectedRowIds.length;
  bool get hasPrevious => pageIndex > 0;
  bool get hasNext {
    final length = projection == AnalyticsVariablesProjection.purchases
        ? purchaseRows.length
        : itemRows.length;
    return (pageIndex + 1) * pageSize < length;
  }
}
