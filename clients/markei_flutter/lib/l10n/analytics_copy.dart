import '../domain/analytics/analytics_models.dart';
import 'marc_messages.dart';

String localizedAnalyticsInterpretation(
  AnalyticsRecord record,
  MarcMessages messages,
) {
  if (record.evidenceRows.isNotEmpty) {
    return analyticsContextualInterpretation(
      draft: record.draft,
      selectedValues: record.selectedValues,
      selectedAxisValues: record.selectedAxisValues,
      entries: record.entries,
      evidenceRows: record.evidenceRows,
      eligibleCount: record.eligibleCount,
      excludedCount: record.excludedCount,
      messages: messages,
    );
  }
  if (messages.language == 'en') return record.interpretation;
  // Translate known developer labels; preserve the frozen interpretation's
  // counts and grouping rather than recalculating or inferring new claims.
  String labels(String text) =>
      text.split(', ').map(messages.display).join(', ');
  final grouped = RegExp(
    r'^(.+?) (.+?) grouped by (.+?)\. Calculated from (\d+) contained items across (\d+) group\(s\)\.(?: (\d+) incompatible or unavailable values are listed in Table\.)?$',
  ).firstMatch(record.interpretation);
  if (grouped != null) {
    final base = messages.message(
      '{p0} {p1} grouped by {p2}. Calculated from {p3} contained items across {p4} group(s).',
      [
        messages.display(grouped[1]!),
        labels(grouped[2]!),
        messages.display(grouped[3]!),
        grouped[4],
        grouped[5],
      ],
    );
    return grouped[6] == null
        ? base
        : messages.message(
            '{p0} {p1} incompatible or unavailable values are listed in Table.',
            [base, grouped[6]],
          );
  }
  final aggregate = RegExp(
    r'^(.+?) of (.+?)\. Based on (\d+) of (\d+) evidence rows\.$',
  ).firstMatch(record.interpretation);
  if (aggregate != null) {
    return messages
        .message('{p0} of {p1}. Based on {p2} of {p3} evidence rows.', [
          messages.display(aggregate[1]!),
          labels(aggregate[2]!),
          aggregate[3],
          aggregate[4],
        ]);
  }
  return messages.display(record.interpretation);
}

String analyticsContextualInterpretation({
  required AnalyticsComposerDraft draft,
  required List<AnalyticsOption> selectedValues,
  required List<List<AnalyticsOption>> selectedAxisValues,
  required List<AnalyticsGroupedResultEntry> entries,
  required List<AnalyticsEvidenceRow> evidenceRows,
  required int eligibleCount,
  required int excludedCount,
  MarcMessages messages = MarcMessages.english,
}) {
  String dimension(int index) {
    final axis = draft.axes[index];
    if (axis.kind == null) return messages.display('None');
    final labels = selectedAxisValues.length > index
        ? selectedAxisValues[index].map((value) => value.label).join(', ')
        : messages.display('All recorded values');
    return '${messages.display(analyticsDimensionLabel(axis.kind!))} ($labels)';
  }

  final measures = draft.measures
      .map(
        (measure) => messages.display(switch (measure) {
          AnalyticsMeasure.quantity => 'Quantity',
          AnalyticsMeasure.unitPrice => 'Unit price',
          AnalyticsMeasure.lineTotal => 'Price paid',
          AnalyticsMeasure.purchaseTotal => 'Purchase total',
          AnalyticsMeasure.evidenceCount => 'Evidence count',
        }),
      )
      .join(', ');
  final operation = messages.display(switch (draft.operation) {
    AnalyticsOperation.sum => 'Sum',
    AnalyticsOperation.mean => 'Mean',
    AnalyticsOperation.difference => 'Difference',
    AnalyticsOperation.percentage => 'Percentage',
  });
  final units = entries
      .where((entry) => entry.value is! AnalyticsUnavailableResultValue)
      .map(
        (entry) => messages.display(
          analyticsDisplayValue(entry.measure, entry.value).unit,
        ),
      )
      .toSet()
      .join(', ');
  final parts = [
    messages.message('{p0} of {p1}, grouped by {p2} ({p3}).', [
      operation,
      measures,
      messages.display(analyticsDimensionLabel(draft.determinant)),
      selectedValues.map((value) => value.label).join(', '),
    ]),
    messages.message('Analytics: {p0}. Analytics constraint: {p1}.', [
      dimension(0),
      dimension(1),
    ]),
    messages.message(
      'Timeframe: {p0}. Evidence: {p1} contained items from {p2} distinct purchases; {p3} eligible, {p4} excluded.',
      [
        messages.display(draft.timeframe.label),
        evidenceRows.length,
        evidenceRows.map((row) => row.purchaseId.value).toSet().length,
        eligibleCount,
        excludedCount,
      ],
    ),
    messages.message(
      'Units: {p0}. Units and currencies are calculated separately.',
      [units.isEmpty ? messages.display('Unavailable') : units],
    ),
    messages.display(
      'Each result reports its own sample count; counts across measures or groups must not be added.',
    ),
    if (draft.operation == AnalyticsOperation.mean)
      messages.display(
        'Mean uses eligible item values; Purchase total uses each distinct purchase once within each group.',
      ),
    if (draft.measures.contains(AnalyticsMeasure.purchaseTotal))
      messages.display(
        'For Purchase total, a purchase can appear in multiple groups; group totals are not additive.',
      ),
    if (draft.determinant == AnalyticsDeterminantKind.quantity ||
        draft.determinant == AnalyticsDeterminantKind.unitPrice ||
        draft.determinant == AnalyticsDeterminantKind.pricePaid ||
        draft.determinant == AnalyticsDeterminantKind.purchaseTotal ||
        draft.axes.any(
          (axis) => [
            AnalyticsDeterminantKind.quantity,
            AnalyticsDeterminantKind.unitPrice,
            AnalyticsDeterminantKind.pricePaid,
            AnalyticsDeterminantKind.purchaseTotal,
          ].contains(axis.kind),
        ))
      messages.display(
        'Numeric dimensions group exact recorded values, including their unit or currency.',
      ),
    if (draft.breakdowns.isNotEmpty)
      messages.message(
        'Additional constraints break down the result by: {p0}.',
        [
          draft.breakdowns
              .map(
                (value) => messages.display(switch (value) {
                  AnalyticsRelationalBreakdown.purchasedBy => 'Purchased by',
                  AnalyticsRelationalBreakdown.paymentMethod =>
                    'Payment method',
                  AnalyticsRelationalBreakdown.purchasedFor => 'Purchased for',
                }),
              )
              .join(', '),
        ],
      ),
  ];
  if (selectedValues.length == 2) {
    if (draft.operation == AnalyticsOperation.difference) {
      parts.add(
        messages.message('Difference: {p1} minus {p0}.', [
          selectedValues[0].label,
          selectedValues[1].label,
        ]),
      );
      if (draft.measures.contains(AnalyticsMeasure.unitPrice)) {
        parts.add(
          messages.display('Unit price compares the mean price in each group.'),
        );
      }
    }
    if (draft.operation == AnalyticsOperation.percentage) {
      parts.add(
        messages.message(
          'Percentage: {p0} divided by {p1}, multiplied by 100. This compares the two groups; it does not assert a part-whole relationship.',
          [selectedValues[0].label, selectedValues[1].label],
        ),
      );
    }
  }
  final unavailable = entries
      .where((entry) => entry.value is AnalyticsUnavailableResultValue)
      .length;
  if (unavailable > 0) {
    parts.add(
      messages.message('{p0} unavailable results are explained in Table.', [
        unavailable,
      ]),
    );
  }
  return parts.join(' ');
}
