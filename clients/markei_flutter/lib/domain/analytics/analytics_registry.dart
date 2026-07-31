import 'analytics_models.dart';

typedef AnalyticsExecutor =
    AnalyticsResultEnvelope Function(
      AnalyticsCardConfiguration configuration,
      AnalyticsDataset dataset,
      List<AnalyticsEvidenceRow> filteredRows,
    );

final class AnalyticDefinition {
  const AnalyticDefinition({
    required this.identifier,
    required this.version,
    required this.operation,
    required this.supports,
    required this.execute,
  });

  final String identifier;
  final int version;
  final AnalyticsOperation operation;
  final bool Function(AnalyticsVariable variable) supports;
  final AnalyticsExecutor execute;
}

final class AnalyticsRegistry {
  AnalyticsRegistry(Iterable<AnalyticDefinition> definitions)
    : _definitions = {
        for (final definition in definitions)
          '${definition.identifier}@${definition.version}': definition,
      },
      _byOperation = {
        for (final definition in definitions) definition.operation: definition,
      };

  final Map<String, AnalyticDefinition> _definitions;
  final Map<AnalyticsOperation, AnalyticDefinition> _byOperation;

  AnalyticDefinition requireDefinition(String identifier, int version) {
    final definition = _definitions['$identifier@$version'];
    if (definition == null) {
      throw ArgumentError('Unknown analytic definition $identifier@$version.');
    }
    return definition;
  }

  AnalyticDefinition definitionFor(AnalyticsOperation operation) {
    final definition = _byOperation[operation];
    if (definition == null) {
      throw ArgumentError('Unsupported analytic operation ${operation.name}.');
    }
    return definition;
  }

  bool supports(AnalyticsOperation operation, AnalyticsVariable variable) {
    return definitionFor(operation).supports(variable);
  }
}

AnalyticsRegistry localAnalyticsRegistry() => AnalyticsRegistry([
  AnalyticDefinition(
    identifier: 'local.sum',
    version: 1,
    operation: AnalyticsOperation.sum,
    supports: (variable) => switch (variable) {
      AnalyticsVariable.quantity ||
      AnalyticsVariable.lineTotal ||
      AnalyticsVariable.purchaseTotal ||
      AnalyticsVariable.evidenceCount => true,
      AnalyticsVariable.unitPrice => false,
    },
    execute: _sum,
  ),
  AnalyticDefinition(
    identifier: 'local.mean',
    version: 1,
    operation: AnalyticsOperation.mean,
    supports: (variable) => switch (variable) {
      AnalyticsVariable.quantity ||
      AnalyticsVariable.unitPrice ||
      AnalyticsVariable.lineTotal ||
      AnalyticsVariable.purchaseTotal => true,
      AnalyticsVariable.evidenceCount => false,
    },
    execute: _mean,
  ),
  AnalyticDefinition(
    identifier: 'local.difference',
    version: 1,
    operation: AnalyticsOperation.difference,
    supports: (_) => true,
    execute: _difference,
  ),
  AnalyticDefinition(
    identifier: 'local.percentage',
    version: 1,
    operation: AnalyticsOperation.percentage,
    supports: (variable) => switch (variable) {
      AnalyticsVariable.quantity ||
      AnalyticsVariable.lineTotal ||
      AnalyticsVariable.purchaseTotal ||
      AnalyticsVariable.evidenceCount => true,
      AnalyticsVariable.unitPrice => false,
    },
    execute: _percentage,
  ),
]);

AnalyticsRegistry minimalAnalyticsRegistry() => localAnalyticsRegistry();

AnalyticsResultEnvelope executeAnalyticsCard({
  required AnalyticsRegistry registry,
  required AnalyticsCardConfiguration configuration,
  required AnalyticsDataset dataset,
}) {
  final definition = registry.definitionFor(configuration.operation);
  final filteredRows = _applyConditions(dataset.rows, configuration.conditions);
  for (final variable in configuration.variables) {
    if (!definition.supports(variable)) {
      return _singleUnavailable(
        definition,
        configuration,
        filteredRows,
        AnalyticsUnavailableReason.invalidCombination,
        'This determinant, variable and operation cannot be combined.',
      );
    }
  }
  try {
    return definition.execute(configuration, dataset, filteredRows);
  } on AnalyticsOverflow {
    return _singleUnavailable(
      definition,
      configuration,
      filteredRows,
      AnalyticsUnavailableReason.overflow,
      'This result could not be calculated. The evidence and card were preserved.',
    );
  }
}

AnalyticsResultEnvelope _sum(
  AnalyticsCardConfiguration configuration,
  AnalyticsDataset dataset,
  List<AnalyticsEvidenceRow> filteredRows,
) {
  final definition = localAnalyticsRegistry().definitionFor(
    AnalyticsOperation.sum,
  );
  final scoped = _scopeRows(configuration.scope, filteredRows);
  final values = <AnalyticsResultValue>[];
  for (final variable in configuration.variables) {
    values.addAll(_aggregateRows(variable, scoped, mean: false));
  }
  return _envelope(definition, configuration, scoped, filteredRows, values);
}

AnalyticsResultEnvelope _mean(
  AnalyticsCardConfiguration configuration,
  AnalyticsDataset dataset,
  List<AnalyticsEvidenceRow> filteredRows,
) {
  final definition = localAnalyticsRegistry().definitionFor(
    AnalyticsOperation.mean,
  );
  final scoped = _scopeRows(configuration.scope, filteredRows);
  final values = <AnalyticsResultValue>[];
  for (final variable in configuration.variables) {
    values.addAll(_aggregateRows(variable, scoped, mean: true));
  }
  return _envelope(definition, configuration, scoped, filteredRows, values);
}

AnalyticsResultEnvelope _difference(
  AnalyticsCardConfiguration configuration,
  AnalyticsDataset dataset,
  List<AnalyticsEvidenceRow> filteredRows,
) {
  final definition = localAnalyticsRegistry().definitionFor(
    AnalyticsOperation.difference,
  );
  final scope = configuration.scope;
  if (scope is! ComparisonAnalyticsEvidenceScope) {
    return _singleUnavailable(
      definition,
      configuration,
      filteredRows,
      AnalyticsUnavailableReason.insufficientEvidence,
      'Not enough comparable evidence for this operation.',
    );
  }
  final baseline = _scopeRows(
    SelectedAnalyticsEvidenceScope(scope.baselineRowIds),
    filteredRows,
  );
  final comparison = _scopeRows(
    SelectedAnalyticsEvidenceScope(scope.comparisonRowIds),
    filteredRows,
  );
  final values = <AnalyticsResultValue>[];
  for (final variable in configuration.variables) {
    final a = _aggregateRows(variable, baseline, mean: false);
    final b = _aggregateRows(variable, comparison, mean: false);
    values.addAll(
      _combineDifference(
        variable,
        scope.baselineLabel,
        a,
        scope.comparisonLabel,
        b,
      ),
    );
  }
  return _envelope(
    definition,
    configuration,
    [...baseline, ...comparison],
    filteredRows,
    values,
  );
}

AnalyticsResultEnvelope _percentage(
  AnalyticsCardConfiguration configuration,
  AnalyticsDataset dataset,
  List<AnalyticsEvidenceRow> filteredRows,
) {
  final definition = localAnalyticsRegistry().definitionFor(
    AnalyticsOperation.percentage,
  );
  final scope = configuration.scope;
  if (scope is! PercentageAnalyticsEvidenceScope ||
      !scope.wholeRowIds.containsAll(scope.partRowIds)) {
    return _singleUnavailable(
      definition,
      configuration,
      filteredRows,
      AnalyticsUnavailableReason.insufficientEvidence,
      'Not enough comparable evidence for this operation.',
    );
  }
  final part = _scopeRows(
    SelectedAnalyticsEvidenceScope(scope.partRowIds),
    filteredRows,
  );
  final whole = _scopeRows(
    SelectedAnalyticsEvidenceScope(scope.wholeRowIds),
    filteredRows,
  );
  final values = <AnalyticsResultValue>[];
  for (final variable in configuration.variables) {
    final partValues = _aggregateRows(variable, part, mean: false);
    final wholeValues = _aggregateRows(variable, whole, mean: false);
    values.addAll(
      _combinePercentage(
        variable,
        scope.partLabel,
        partValues,
        scope.wholeLabel,
        wholeValues,
      ),
    );
  }
  return _envelope(definition, configuration, whole, filteredRows, values);
}

List<AnalyticsEvidenceRow> _applyConditions(
  List<AnalyticsEvidenceRow> rows,
  List<AnalyticsCondition> conditions,
) {
  return rows
      .where((row) {
        for (final condition in conditions) {
          switch (condition) {
            case AnalyticsUtcPeriodCondition():
              if (!condition.contains(row.purchaseOccurrenceTime)) return false;
            case AnalyticsFieldCondition():
              final value = switch (condition.field) {
                AnalyticsDeterminantKind.product => row.productId.value,
                AnalyticsDeterminantKind.purchase => row.purchaseId.value,
                AnalyticsDeterminantKind.store => row.storeId.value,
                AnalyticsDeterminantKind.timeDayUtc => _utcDay(
                  row.purchaseOccurrenceTime,
                ),
                AnalyticsDeterminantKind.timeMonthUtc => _utcMonth(
                  row.purchaseOccurrenceTime,
                ),
              };
              if (value != condition.value) return false;
          }
        }
        return true;
      })
      .toList(growable: false);
}

List<AnalyticsEvidenceRow> _scopeRows(
  AnalyticsEvidenceScope scope,
  List<AnalyticsEvidenceRow> filteredRows,
) {
  return switch (scope) {
    FilteredAnalyticsEvidenceScope() => filteredRows,
    SelectedAnalyticsEvidenceScope(:final rowIds) =>
      filteredRows
          .where((row) => rowIds.any((id) => id.value == row.id.value))
          .toList(growable: false),
    ComparisonAnalyticsEvidenceScope() => filteredRows,
    PercentageAnalyticsEvidenceScope() => filteredRows,
  };
}

List<AnalyticsIntegerResultValue> _aggregateRows(
  AnalyticsVariable variable,
  List<AnalyticsEvidenceRow> rows, {
  required bool mean,
}) {
  final buckets =
      <String, ({AnalyticsCompatibilityKey key, int total, int count})>{};
  final purchaseSeen = <String>{};
  for (final row in rows) {
    final values = _valueFor(variable, row, purchaseSeen);
    for (final entry in values.entries) {
      final existing = buckets[entry.key.value];
      buckets[entry.key.value] = (
        key: entry.key,
        total: _checkedAdd(existing?.total ?? 0, entry.value),
        count: (existing?.count ?? 0) + 1,
      );
    }
  }
  if (buckets.isEmpty) {
    return [
      AnalyticsIntegerResultValue(
        label: '${_variableLabel(variable)} unavailable',
        value: 0,
        compatibilityKey: const AnalyticsCompatibilityKey('none'),
      ),
    ];
  }
  return [
    for (final bucket in buckets.values)
      AnalyticsIntegerResultValue(
        label: _variableLabel(variable),
        value: mean ? bucket.total ~/ bucket.count : bucket.total,
        compatibilityKey: bucket.key,
        unitLabel: mean ? _contributionUnit(variable) : null,
      ),
  ];
}

Map<AnalyticsCompatibilityKey, int> _valueFor(
  AnalyticsVariable variable,
  AnalyticsEvidenceRow row,
  Set<String> purchaseSeen,
) {
  return switch (variable) {
    AnalyticsVariable.quantity => {
      AnalyticsCompatibilityKey(
        'quantity:${row.quantity.kind.name}:${row.quantity.unit.name}',
      ): row.quantity.microunits,
    },
    AnalyticsVariable.unitPrice when row.unitPrice != null => {
      AnalyticsCompatibilityKey(
        'unitPrice:${row.unitPrice!.currencyCode}:${row.unitPrice!.kind.name}:${row.unitPrice!.unit.name}',
      ): row.unitPrice!.minorUnitsPerCanonicalUnit,
    },
    AnalyticsVariable.unitPrice => const {},
    AnalyticsVariable.lineTotal => {
      AnalyticsCompatibilityKey('money:${row.lineTotal.currencyCode}'):
          row.lineTotal.minorUnits,
    },
    AnalyticsVariable.purchaseTotal
        when purchaseSeen.add(row.purchaseId.value) =>
      {
        AnalyticsCompatibilityKey(
          'purchaseTotal:${row.purchaseTotal.currencyCode}',
        ): row.purchaseTotal.minorUnits,
      },
    AnalyticsVariable.purchaseTotal => const {},
    AnalyticsVariable.evidenceCount => {
      const AnalyticsCompatibilityKey('evidenceCount:itemRow'): 1,
    },
  };
}

List<AnalyticsResultValue> _combineDifference(
  AnalyticsVariable variable,
  String baselineLabel,
  List<AnalyticsIntegerResultValue> baseline,
  String comparisonLabel,
  List<AnalyticsIntegerResultValue> comparison,
) {
  final values = <AnalyticsResultValue>[];
  for (final b in comparison) {
    final a = baseline
        .where(
          (item) => item.compatibilityKey.value == b.compatibilityKey.value,
        )
        .firstOrNull;
    if (a == null) {
      values.add(
        AnalyticsUnavailableResultValue(
          label: _variableLabel(variable),
          reason: AnalyticsUnavailableReason.incompatible,
          message: 'Not enough comparable evidence for this operation.',
        ),
      );
    } else {
      values.add(
        AnalyticsIntegerResultValue(
          label:
              '$comparisonLabel minus $baselineLabel ${_variableLabel(variable)}',
          value: _checkedSubtract(b.value, a.value),
          compatibilityKey: b.compatibilityKey,
        ),
      );
    }
  }
  return values;
}

List<AnalyticsResultValue> _combinePercentage(
  AnalyticsVariable variable,
  String partLabel,
  List<AnalyticsIntegerResultValue> part,
  String wholeLabel,
  List<AnalyticsIntegerResultValue> whole,
) {
  final values = <AnalyticsResultValue>[];
  for (final denominator in whole) {
    final numerator = part
        .where(
          (item) =>
              item.compatibilityKey.value == denominator.compatibilityKey.value,
        )
        .firstOrNull;
    if (denominator.value == 0) {
      values.add(
        const AnalyticsUnavailableResultValue(
          label: 'Percentage',
          reason: AnalyticsUnavailableReason.zeroDenominator,
          message: 'Percentage unavailable - the total is zero.',
        ),
      );
      continue;
    }
    if (numerator == null) {
      continue;
    }
    values.add(
      AnalyticsBasisPointResultValue(
        label: '$partLabel share of $wholeLabel ${_variableLabel(variable)}',
        basisPoints: (numerator.value * 10000) ~/ denominator.value,
        part: numerator.value,
        whole: denominator.value,
        compatibilityKey: denominator.compatibilityKey,
      ),
    );
  }
  return values;
}

AnalyticsResultEnvelope _singleUnavailable(
  AnalyticDefinition definition,
  AnalyticsCardConfiguration configuration,
  List<AnalyticsEvidenceRow> rows,
  AnalyticsUnavailableReason reason,
  String message,
) {
  return _envelope(definition, configuration, const [], rows, [
    AnalyticsUnavailableResultValue(
      label: configuration.operation.name,
      reason: reason,
      message: message,
    ),
  ]);
}

AnalyticsResultEnvelope _envelope(
  AnalyticDefinition definition,
  AnalyticsCardConfiguration configuration,
  List<AnalyticsEvidenceRow> contributingRows,
  List<AnalyticsEvidenceRow> filteredRows,
  List<AnalyticsResultValue> values,
) {
  final period = _period(contributingRows);
  return AnalyticsResultEnvelope(
    registryIdentifier: definition.identifier,
    registryVersion: definition.version,
    configuration: configuration,
    values: List.unmodifiable(values),
    contributingRowIds: {for (final row in contributingRows) row.id},
    eligibleCount: contributingRows.length,
    totalCount: filteredRows.length,
    excludedCount: filteredRows.length - contributingRows.length,
    periodStartUtc: period?.$1,
    periodEndUtc: period?.$2,
    interpretation:
        '${_operationLabel(configuration.operation)} of ${configuration.variables.map(_variableLabel).join(', ')}. Based on ${contributingRows.length} of ${filteredRows.length} evidence rows.',
  );
}

(DateTime, DateTime)? _period(List<AnalyticsEvidenceRow> rows) {
  if (rows.isEmpty) return null;
  var start = rows.first.purchaseOccurrenceTime.toUtc();
  var end = start;
  for (final row in rows.skip(1)) {
    final time = row.purchaseOccurrenceTime.toUtc();
    if (time.isBefore(start)) start = time;
    if (time.isAfter(end)) end = time;
  }
  return (start, end);
}

int _checkedAdd(int left, int right) {
  final value = left + right;
  if ((right > 0 && value < left) || (right < 0 && value > left)) {
    throw const AnalyticsOverflow();
  }
  return value;
}

int _checkedSubtract(int left, int right) => _checkedAdd(left, -right);

String _variableLabel(AnalyticsVariable variable) => switch (variable) {
  AnalyticsVariable.quantity => 'Quantity',
  AnalyticsVariable.unitPrice => 'Unit price',
  AnalyticsVariable.lineTotal => 'Line total',
  AnalyticsVariable.purchaseTotal => 'Purchase total',
  AnalyticsVariable.evidenceCount => 'Evidence count',
};

String _operationLabel(AnalyticsOperation operation) => switch (operation) {
  AnalyticsOperation.sum => 'Sum',
  AnalyticsOperation.mean => 'Mean',
  AnalyticsOperation.difference => 'Difference',
  AnalyticsOperation.percentage => 'Percentage',
};

String _contributionUnit(AnalyticsVariable variable) {
  return variable == AnalyticsVariable.purchaseTotal
      ? 'per Purchase'
      : 'per Purchase Item';
}

String _utcDay(DateTime value) {
  final utc = value.toUtc();
  return '${utc.year.toString().padLeft(4, '0')}-${utc.month.toString().padLeft(2, '0')}-${utc.day.toString().padLeft(2, '0')}';
}

String _utcMonth(DateTime value) {
  final utc = value.toUtc();
  return '${utc.year.toString().padLeft(4, '0')}-${utc.month.toString().padLeft(2, '0')}';
}

final class AnalyticsOverflow implements Exception {
  const AnalyticsOverflow();
}
