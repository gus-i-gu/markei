import 'package:flutter/material.dart';

import '../../domain/analytics/analytics_models.dart';
import '../design/markei_theme.dart';
import 'markei_components.dart';

class AnalyticsComposerView extends StatelessWidget {
  const AnalyticsComposerView({
    required this.draft,
    required this.validation,
    required this.options,
    required this.onDeterminantChanged,
    required this.onToggleDeterminantKey,
    required this.onToggleVariable,
    required this.onOperationChanged,
    required this.onTimeframeChanged,
    required this.onRun,
    required this.onClear,
    super.key,
  });

  final AnalyticsComposerDraft draft;
  final AnalyticsDraftValidation validation;
  final Map<AnalyticsDeterminantKind, List<AnalyticsOption>> options;
  final ValueChanged<AnalyticsDeterminantKind> onDeterminantChanged;
  final ValueChanged<String> onToggleDeterminantKey;
  final ValueChanged<AnalyticsVariable> onToggleVariable;
  final ValueChanged<AnalyticsOperation> onOperationChanged;
  final ValueChanged<AnalyticsTimeframe> onTimeframeChanged;
  final VoidCallback onRun;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final determinantOptions =
        options[draft.determinant] ?? const <AnalyticsOption>[];
    return MarkeiSection(
      key: const Key('analytics.composer'),
      title: 'Create analysis',
      subtitle:
          'Choose local evidence, variables and an operation before calculation.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: MarkeiSpacing.sm,
            runSpacing: MarkeiSpacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _ChoiceMenu<AnalyticsDeterminantKind>(
                key: const Key('analytics.groupBy'),
                label: 'Group by',
                value: draft.determinant,
                values: AnalyticsDeterminantKind.values,
                onChanged: onDeterminantChanged,
                labelFor: _determinantLabel,
              ),
              _ChoiceMenu<AnalyticsOperation>(
                key: const Key('analytics.operation'),
                label: 'Operation',
                value: draft.operation,
                values: AnalyticsOperation.values,
                onChanged: onOperationChanged,
                labelFor: _operationLabel,
              ),
            ],
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          Text('Choose', style: MarkeiText.metadata),
          const SizedBox(height: MarkeiSpacing.xs),
          Wrap(
            spacing: MarkeiSpacing.xs,
            runSpacing: MarkeiSpacing.xs,
            children: [
              for (final option in determinantOptions)
                FilterChip(
                  key: Key('analytics.choose.${option.key}'),
                  label: Text(option.label),
                  selected: draft.selectedDeterminantKeys.contains(option.key),
                  onSelected: (_) => onToggleDeterminantKey(option.key),
                ),
            ],
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          Text('Variables', style: MarkeiText.metadata),
          const SizedBox(height: MarkeiSpacing.xs),
          Wrap(
            spacing: MarkeiSpacing.xs,
            runSpacing: MarkeiSpacing.xs,
            children: [
              for (final variable in AnalyticsVariable.values)
                FilterChip(
                  key: Key('analytics.variable.${variable.name}'),
                  label: Text(_variableLabel(variable)),
                  selected: draft.variables.contains(variable),
                  onSelected: variable == AnalyticsVariable.purchasedFor
                      ? null
                      : (_) => onToggleVariable(variable),
                  tooltip: variable == AnalyticsVariable.purchasedFor
                      ? 'Purchased for is unavailable in recorded data.'
                      : null,
                ),
            ],
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          Text('Timeframe', style: MarkeiText.metadata),
          const SizedBox(height: MarkeiSpacing.xs),
          Wrap(
            spacing: MarkeiSpacing.sm,
            runSpacing: MarkeiSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ChoiceChip(
                key: const Key('analytics.timeframe.all'),
                label: const Text('All recorded time'),
                selected:
                    draft.timeframe.kind ==
                    AnalyticsTimeframeKind.allRecordedTime,
                onSelected: (_) =>
                    onTimeframeChanged(const AnalyticsTimeframe.all()),
              ),
              ChoiceChip(
                key: const Key('analytics.timeframe.customDates'),
                label: const Text('Custom dates'),
                selected:
                    draft.timeframe.kind == AnalyticsTimeframeKind.customUtc,
                onSelected: (_) => onTimeframeChanged(
                  const AnalyticsTimeframe.invalid(
                    'Enter both Initial date and Final date as dd-mm-yyyy.',
                  ),
                ),
              ),
              SizedBox(
                width: 180,
                child: TextField(
                  key: const Key('analytics.timeframe.initialDate'),
                  decoration: const InputDecoration(
                    labelText: 'Initial date',
                    hintText: 'dd-mm-yyyy',
                  ),
                  onChanged: (value) => onTimeframeChanged(
                    _parseTimeframeDraft(
                      value,
                      draft.timeframe.finalLocalDate ?? '',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 180,
                child: TextField(
                  key: const Key('analytics.timeframe.finalDate'),
                  decoration: const InputDecoration(
                    labelText: 'Final date',
                    hintText: 'dd-mm-yyyy',
                  ),
                  onChanged: (value) => onTimeframeChanged(
                    _parseTimeframeDraft(
                      draft.timeframe.initialLocalDate ?? '',
                      value,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          Semantics(
            liveRegion: true,
            child: Text(
              validation.explanation,
              key: const Key('analytics.disabledReason'),
              style: MarkeiText.metadata,
            ),
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          Wrap(
            spacing: MarkeiSpacing.sm,
            runSpacing: MarkeiSpacing.xs,
            children: [
              FilledButton.icon(
                key: const Key('analytics.runSave'),
                onPressed: validation.canRun ? onRun : null,
                icon: const Icon(Icons.play_arrow),
                label: const Text('Run & save analysis'),
              ),
              OutlinedButton.icon(
                key: const Key('analytics.clearDraft'),
                onPressed: onClear,
                icon: const Icon(Icons.clear),
                label: const Text('Clear draft'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SavedAnalysisBrowser extends StatelessWidget {
  const SavedAnalysisBrowser({
    required this.records,
    required this.selected,
    required this.onOlder,
    required this.onNewer,
    super.key,
  });

  final List<AnalyticsRecord> records;
  final AnalyticsRecord? selected;
  final VoidCallback onOlder;
  final VoidCallback onNewer;

  @override
  Widget build(BuildContext context) {
    if (records.isEmpty) {
      return const MarkeiSection(
        key: Key('analytics.records'),
        title: 'Saved analyses — this session',
        subtitle:
            'Immutable analysis records are retained only while this workspace lives.',
        child: MarkeiStatePanel(
          key: Key('analytics.records.empty'),
          title: 'No saved analyses this session',
          message:
              'Run & save analysis creates immutable records until this workspace closes.',
          icon: Icons.bookmark_border,
        ),
      );
    }
    final selectedIndex = selected == null
        ? -1
        : records.indexWhere((record) => record.id.value == selected!.id.value);
    return MarkeiSection(
      key: const Key('analytics.records'),
      title: 'Saved analyses — this session',
      subtitle:
          'Record fingerprints distinguish session records; they are not security or authenticity proofs.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: MarkeiSpacing.sm,
            children: [
              IconButton(
                key: const Key('analytics.record.older'),
                tooltip: selectedIndex == records.length - 1
                    ? 'No older saved analysis'
                    : 'Select older saved analysis',
                onPressed:
                    selectedIndex >= 0 && selectedIndex < records.length - 1
                    ? onOlder
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              IconButton(
                key: const Key('analytics.record.newer'),
                tooltip: selectedIndex <= 0
                    ? 'No newer saved analysis'
                    : 'Select newer saved analysis',
                onPressed: selectedIndex > 0 ? onNewer : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final record in records)
                  SizedBox(
                    width: 280,
                    child: MarkeiCard(
                      key: Key('analytics.record.${record.fingerprint}'),
                      child: Semantics(
                        selected: selected?.id.value == record.id.value,
                        label:
                            'Saved record ${record.fingerprint}, group by ${_determinantLabel(record.draft.determinant)}',
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Record #${record.fingerprint}',
                              style: MarkeiText.sectionTitle,
                            ),
                            Text(
                              record.executedAtUtc.toIso8601String(),
                              style: MarkeiText.metadata,
                            ),
                            const SizedBox(height: MarkeiSpacing.xs),
                            Text(
                              'Group by: ${_determinantLabel(record.draft.determinant)}',
                            ),
                            Text(
                              'Variables: ${record.draft.variables.map(_variableLabel).join(', ')}',
                            ),
                            Text('Timeframe: ${record.draft.timeframe.label}'),
                            const SizedBox(height: MarkeiSpacing.xs),
                            const Row(
                              children: [
                                Icon(Icons.lock_outline, size: 16),
                                SizedBox(width: MarkeiSpacing.xs),
                                Text('Saved record'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnalyticsResultView extends StatelessWidget {
  const AnalyticsResultView({
    required this.record,
    required this.presentation,
    required this.onPresentationChanged,
    required this.onExportCsv,
    required this.onExportPdf,
    super.key,
  });

  final AnalyticsRecord? record;
  final AnalyticsResultPresentation presentation;
  final ValueChanged<AnalyticsResultPresentation> onPresentationChanged;
  final VoidCallback onExportCsv;
  final VoidCallback onExportPdf;

  @override
  Widget build(BuildContext context) {
    final record = this.record;
    if (record == null) {
      return const MarkeiStatePanel(
        key: Key('analytics.result.empty'),
        title: 'No selected result',
        message: 'Run & save analysis to create a session record.',
        icon: Icons.insert_chart_outlined,
      );
    }
    final chartAvailable = _chartAvailable(record);
    final effectivePresentation = chartAvailable
        ? presentation
        : AnalyticsResultPresentation.table;
    return MarkeiSection(
      key: const Key('analytics.result'),
      title:
          '${_determinantLabel(record.draft.determinant)} · ${record.draft.variables.map(_variableLabel).join(', ')} · Record #${record.fingerprint}',
      subtitle:
          '${record.executedAtUtc.toIso8601String()} · ${record.draft.timeframe.label} · ${record.eligibleCount}/${record.totalCount} evidence rows',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: MarkeiSpacing.sm,
            children: [
              SegmentedButton<AnalyticsResultPresentation>(
                key: const Key('analytics.presentation'),
                segments: const [
                  ButtonSegment(
                    value: AnalyticsResultPresentation.chart,
                    label: Text('Chart'),
                    icon: Icon(Icons.bar_chart),
                  ),
                  ButtonSegment(
                    value: AnalyticsResultPresentation.table,
                    label: Text('Table'),
                    icon: Icon(Icons.table_chart),
                  ),
                ],
                selected: {effectivePresentation},
                onSelectionChanged: (value) =>
                    onPresentationChanged(value.single),
              ),
              OutlinedButton.icon(
                key: const Key('analytics.export.csv'),
                onPressed: onExportCsv,
                icon: const Icon(Icons.download),
                label: const Text('Export CSV'),
              ),
              OutlinedButton.icon(
                key: const Key('analytics.export.pdf'),
                onPressed: onExportPdf,
                icon: const Icon(Icons.picture_as_pdf),
                label: const Text('Export PDF'),
              ),
            ],
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          if (effectivePresentation == AnalyticsResultPresentation.chart &&
              chartAvailable)
            AnalyticsChartProjection(record: record)
          else
            AnalyticsResultTable(record: record),
          const SizedBox(height: MarkeiSpacing.sm),
          Text(
            record.interpretation,
            key: const Key('analytics.result.interpretation'),
          ),
        ],
      ),
    );
  }

  bool _chartAvailable(AnalyticsRecord record) {
    final plottable = record.entries.where((entry) => entry.isPlottable);
    if (plottable.isEmpty) return false;
    return {
          for (final entry in plottable) entry.compatibilityKey.value,
        }.length ==
        1;
  }
}

class AnalyticsChartProjection extends StatelessWidget {
  const AnalyticsChartProjection({required this.record, super.key});

  final AnalyticsRecord record;

  @override
  Widget build(BuildContext context) {
    final values = [
      for (final entry in record.entries)
        if (entry.value is AnalyticsIntegerResultValue)
          (
            label: entry.groupKey.determinantLabel,
            value: (entry.value as AnalyticsIntegerResultValue).value,
            unit: analyticsDisplayValue(entry.measure, entry.value).unit,
            display: analyticsDisplayValue(entry.measure, entry.value).value,
            series: _measureLabel(entry.measure),
          ),
    ];
    final summary =
        'Chart for Record ${record.fingerprint}. Categories: ${values.map((v) => v.label).join(', ')}. Series: ${values.map((v) => '${v.series} ${v.display} ${v.unit}').toSet().join(', ')}. Evidence count ${record.eligibleCount}.';
    return Semantics(
      key: const Key('analytics.chart.summary'),
      label: summary,
      child: SizedBox(
        height: 260,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: CustomPaint(
            size: Size((values.length * 88).clamp(360, 2400).toDouble(), 240),
            painter: _AnalyticsBarChartPainter(
              values: values,
              signed: record.draft.operation == AnalyticsOperation.difference,
            ),
          ),
        ),
      ),
    );
  }
}

class _AnalyticsBarChartPainter extends CustomPainter {
  const _AnalyticsBarChartPainter({required this.values, required this.signed});

  final List<
    ({String display, String label, String series, String unit, int value})
  >
  values;
  final bool signed;

  @override
  void paint(Canvas canvas, Size size) {
    final axis = Paint()
      ..color = Colors.black87
      ..strokeWidth = 1;
    final fill = Paint()..color = Colors.teal.shade600;
    final stroke = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final maxAbs = values.fold<int>(
      1,
      (max, value) => value.value.abs() > max ? value.value.abs() : max,
    );
    final zeroY = signed ? size.height / 2 : size.height - 34;
    canvas.drawLine(Offset(24, zeroY), Offset(size.width - 12, zeroY), axis);
    final barWidth = 28.0;
    for (var i = 0; i < values.length; i++) {
      final entry = values[i];
      final x = 48 + i * 88.0;
      final height = (entry.value.abs() / maxAbs) * (signed ? 88 : 170);
      final top = entry.value >= 0 ? zeroY - height : zeroY;
      final rect = Rect.fromLTWH(x, top, barWidth, height);
      canvas.drawRect(rect, fill);
      canvas.drawRect(rect, stroke);
      canvas.drawCircle(Offset(x + barWidth / 2, top), 3, stroke);
    }
  }

  @override
  bool shouldRepaint(covariant _AnalyticsBarChartPainter oldDelegate) {
    return values != oldDelegate.values || signed != oldDelegate.signed;
  }
}

class AnalyticsResultTable extends StatelessWidget {
  const AnalyticsResultTable({required this.record, super.key});

  final AnalyticsRecord record;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        key: const Key('analytics.result.table'),
        columns: const [
          DataColumn(label: Text('Group')),
          DataColumn(label: Text('Breakdowns')),
          DataColumn(label: Text('Measure')),
          DataColumn(label: Text('Operation')),
          DataColumn(label: Text('Value')),
          DataColumn(label: Text('Unit/currency')),
          DataColumn(label: Text('Eligible')),
          DataColumn(label: Text('Excluded')),
          DataColumn(label: Text('Unavailable reason')),
        ],
        rows: [
          for (final entry in record.entries)
            DataRow(
              cells: [
                DataCell(Text(entry.groupKey.determinantLabel)),
                DataCell(
                  Text(entry.groupKey.breakdownLabels.values.join(', ')),
                ),
                DataCell(Text(_measureLabel(entry.measure))),
                DataCell(Text(_operationLabel(entry.operation))),
                DataCell(
                  Text(analyticsDisplayValue(entry.measure, entry.value).value),
                ),
                DataCell(
                  Text(analyticsDisplayValue(entry.measure, entry.value).unit),
                ),
                DataCell(Text(entry.eligibleCount.toString())),
                DataCell(Text(entry.excludedCount.toString())),
                DataCell(
                  Text(
                    entry.value is AnalyticsUnavailableResultValue
                        ? (entry.value as AnalyticsUnavailableResultValue)
                              .reason
                              .name
                        : '',
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class AnalyticsVariablesView extends StatelessWidget {
  const AnalyticsVariablesView({
    required this.state,
    required this.wide,
    required this.onProjectionChanged,
    required this.onSearchChanged,
    required this.onSortChanged,
    required this.onPreviousPage,
    required this.onNextPage,
    required this.onTogglePurchase,
    required this.onToggleItem,
    required this.onUseSelectedRows,
    required this.onShowAll,
    super.key,
  });

  final AnalyticsVariablesState state;
  final bool wide;
  final ValueChanged<AnalyticsVariablesProjection> onProjectionChanged;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<AnalyticsVariablesSort> onSortChanged;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;
  final ValueChanged<String> onTogglePurchase;
  final ValueChanged<AnalyticsEvidenceRowId> onToggleItem;
  final VoidCallback onUseSelectedRows;
  final VoidCallback onShowAll;

  @override
  Widget build(BuildContext context) {
    return MarkeiSection(
      key: const Key('analytics.variables'),
      title: 'Variables',
      subtitle: 'Registered Purchase evidence available locally for analysis.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.message != null) ...[
            Text(state.message!, key: const Key('analytics.variables.focus')),
            TextButton(
              key: const Key('analytics.variables.showAll'),
              onPressed: onShowAll,
              child: const Text('Show all variables'),
            ),
          ],
          Wrap(
            spacing: MarkeiSpacing.sm,
            runSpacing: MarkeiSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SegmentedButton<AnalyticsVariablesProjection>(
                key: const Key('analytics.variables.projection'),
                segments: const [
                  ButtonSegment(
                    value: AnalyticsVariablesProjection.purchases,
                    label: Text('Purchases'),
                  ),
                  ButtonSegment(
                    value: AnalyticsVariablesProjection.containedItems,
                    label: Text('Contained items'),
                  ),
                ],
                selected: {state.projection},
                onSelectionChanged: (value) =>
                    onProjectionChanged(value.single),
              ),
              SizedBox(
                width: 260,
                child: TextField(
                  key: const Key('analytics.variables.search'),
                  decoration: const InputDecoration(labelText: 'Search'),
                  onChanged: onSearchChanged,
                ),
              ),
              _ChoiceMenu<AnalyticsVariablesSort>(
                label: 'Sort',
                value: state.sort,
                values: AnalyticsVariablesSort.values,
                onChanged: onSortChanged,
                labelFor: _sortLabel,
              ),
            ],
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          Text('${state.selectedCount} selected row(s)'),
          const SizedBox(height: MarkeiSpacing.xs),
          if (state.projection == AnalyticsVariablesProjection.purchases)
            _PurchasesProjection(
              rows: state.purchaseRows,
              selectedRowIds: state.selectedRowIds,
              wide: wide,
              onTogglePurchase: onTogglePurchase,
            )
          else
            _ItemsProjection(
              rows: state.itemRows,
              selectedRowIds: state.selectedRowIds,
              wide: wide,
              onToggleItem: onToggleItem,
            ),
          const SizedBox(height: MarkeiSpacing.sm),
          Wrap(
            spacing: MarkeiSpacing.sm,
            children: [
              OutlinedButton.icon(
                key: const Key('analytics.variables.previous'),
                onPressed: state.hasPrevious ? onPreviousPage : null,
                icon: const Icon(Icons.chevron_left),
                label: const Text('Previous page'),
              ),
              OutlinedButton.icon(
                key: const Key('analytics.variables.next'),
                onPressed: state.hasNext ? onNextPage : null,
                icon: const Icon(Icons.chevron_right),
                label: const Text('Next page'),
              ),
              FilledButton.icon(
                key: const Key('analytics.variables.useSelected'),
                onPressed: state.selectedCount > 0 ? onUseSelectedRows : null,
                icon: const Icon(Icons.input),
                label: const Text('Use selected rows'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PurchasesProjection extends StatelessWidget {
  const _PurchasesProjection({
    required this.rows,
    required this.selectedRowIds,
    required this.wide,
    required this.onTogglePurchase,
  });

  final List<AnalyticsPurchaseProjectionRow> rows;
  final Set<AnalyticsEvidenceRowId> selectedRowIds;
  final bool wide;
  final ValueChanged<String> onTogglePurchase;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return const MarkeiStatePanel(
        key: Key('analytics.variables.empty'),
        message: 'No variables match these filters.',
        icon: Icons.search_off,
      );
    }
    if (!wide) {
      return Column(
        children: [
          for (final row in rows)
            MarkeiCard(
              key: Key('analytics.purchase.card.${row.purchaseId.value}'),
              child: CheckboxListTile(
                value: row.itemIds.every(
                  (id) => selectedRowIds.any(
                    (selected) => selected.value == id.value,
                  ),
                ),
                onChanged: (_) => onTogglePurchase(row.purchaseId.value),
                title: Text(_formatLocal(row.occurrenceTime)),
                subtitle: Text(
                  '${row.storeName} · ${_money(row.purchaseTotal)} · ${row.itemCount} item(s)',
                ),
              ),
            ),
        ],
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        key: const Key('analytics.purchases.table'),
        columns: const [
          DataColumn(label: Text('Select')),
          DataColumn(label: Text('Date-Time of purchase')),
          DataColumn(label: Text('Store name')),
          DataColumn(label: Text('Purchased by')),
          DataColumn(label: Text('Purchased for')),
          DataColumn(label: Text('Payment method')),
          DataColumn(label: Text('Item count')),
          DataColumn(label: Text('Purchase total')),
        ],
        rows: [
          for (final row in rows)
            DataRow(
              cells: [
                DataCell(
                  Checkbox(
                    value: row.itemIds.every(
                      (id) => selectedRowIds.any(
                        (selected) => selected.value == id.value,
                      ),
                    ),
                    onChanged: (_) => onTogglePurchase(row.purchaseId.value),
                  ),
                ),
                DataCell(Text(_formatLocal(row.occurrenceTime))),
                DataCell(Text(row.storeName)),
                DataCell(Text(row.purchasedBy?.displayLabel ?? 'Not assigned')),
                const DataCell(Text('Unavailable in recorded data')),
                DataCell(
                  Text(row.paymentMethod?.displayLabel ?? 'Not assigned'),
                ),
                DataCell(Text(row.itemCount.toString())),
                DataCell(Text(_money(row.purchaseTotal))),
              ],
            ),
        ],
      ),
    );
  }
}

class _ItemsProjection extends StatelessWidget {
  const _ItemsProjection({
    required this.rows,
    required this.selectedRowIds,
    required this.wide,
    required this.onToggleItem,
  });

  final List<AnalyticsEvidenceRow> rows;
  final Set<AnalyticsEvidenceRowId> selectedRowIds;
  final bool wide;
  final ValueChanged<AnalyticsEvidenceRowId> onToggleItem;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return const MarkeiStatePanel(
        key: Key('analytics.variables.empty'),
        message: 'No variables match these filters.',
        icon: Icons.search_off,
      );
    }
    if (!wide) {
      return Column(
        children: [
          for (final row in rows)
            MarkeiCard(
              key: Key('analytics.item.card.${row.id.value}'),
              child: CheckboxListTile(
                value: _contains(row.id),
                onChanged: (_) => onToggleItem(row.id),
                title: Text('${row.productCode} - ${row.productName}'),
                subtitle: Text(
                  '${_formatLocal(row.purchaseOccurrenceTime)} · ${row.storeName} · ${_money(row.lineTotal)}',
                ),
              ),
            ),
        ],
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        key: const Key('analytics.items.table'),
        columns: const [
          DataColumn(label: Text('Select')),
          DataColumn(label: Text('Date-Time of purchase')),
          DataColumn(label: Text('Product code / Product name / Brand')),
          DataColumn(label: Text('Store name')),
          DataColumn(label: Text('Purchased by')),
          DataColumn(label: Text('Purchased for')),
          DataColumn(label: Text('Payment method')),
          DataColumn(label: Text('Quantity and unit')),
          DataColumn(label: Text('Unit price')),
          DataColumn(label: Text('Line total')),
          DataColumn(label: Text('Promotion')),
        ],
        rows: [
          for (final row in rows)
            DataRow(
              cells: [
                DataCell(
                  Checkbox(
                    value: _contains(row.id),
                    onChanged: (_) => onToggleItem(row.id),
                  ),
                ),
                DataCell(Text(_formatLocal(row.purchaseOccurrenceTime))),
                DataCell(
                  Text(
                    '${row.productCode} · ${row.productName} · ${row.productBrand.isEmpty ? 'Unavailable' : row.productBrand}',
                  ),
                ),
                DataCell(Text(row.storeName)),
                DataCell(Text(row.purchasedBy?.displayLabel ?? 'Not assigned')),
                const DataCell(Text('Unavailable in recorded data')),
                DataCell(
                  Text(row.paymentMethod?.displayLabel ?? 'Not assigned'),
                ),
                DataCell(
                  Text('${row.quantity.decimalText} ${row.quantity.unit.name}'),
                ),
                DataCell(Text(_unitPrice(row))),
                DataCell(Text(_money(row.lineTotal))),
                const DataCell(Text('Unavailable in recorded data')),
              ],
            ),
        ],
      ),
    );
  }

  bool _contains(AnalyticsEvidenceRowId id) {
    return selectedRowIds.any((selected) => selected.value == id.value);
  }
}

class _ChoiceMenu<T> extends StatelessWidget {
  const _ChoiceMenu({
    required this.label,
    required this.value,
    required this.values,
    required this.onChanged,
    required this.labelFor,
    super.key,
  });

  final String label;
  final T value;
  final List<T> values;
  final ValueChanged<T> onChanged;
  final String Function(T) labelFor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: DropdownButton<T>(
        value: value,
        isExpanded: true,
        underline: const SizedBox.shrink(),
        items: [
          for (final item in values)
            DropdownMenuItem(
              value: item,
              child: Text(
                '$label: ${labelFor(item)}',
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }
}

String _operationLabel(AnalyticsOperation operation) => switch (operation) {
  AnalyticsOperation.sum => 'Sum',
  AnalyticsOperation.mean => 'Mean',
  AnalyticsOperation.difference => 'Difference',
  AnalyticsOperation.percentage => 'Percentage',
};

String _measureLabel(AnalyticsMeasure measure) => switch (measure) {
  AnalyticsMeasure.quantity => 'Quantity',
  AnalyticsMeasure.unitPrice => 'Unit price',
  AnalyticsMeasure.lineTotal => 'Price paid',
  AnalyticsMeasure.purchaseTotal => 'Purchase total',
  AnalyticsMeasure.evidenceCount => 'Evidence count',
};

String _variableLabel(AnalyticsVariable variable) => switch (variable) {
  AnalyticsVariable.purchasedBy => 'Purchased by',
  AnalyticsVariable.purchasedFor => 'Purchased for',
  AnalyticsVariable.paymentMethod => 'Payment method',
  AnalyticsVariable.quantity => 'Quantity',
  AnalyticsVariable.unitPrice => 'Unit price',
  AnalyticsVariable.lineTotal => 'Price paid',
  AnalyticsVariable.purchaseTotal => 'Purchase total',
  AnalyticsVariable.evidenceCount => 'Evidence count',
};

String _determinantLabel(AnalyticsDeterminantKind determinant) =>
    switch (determinant) {
      AnalyticsDeterminantKind.product => 'Product',
      AnalyticsDeterminantKind.purchase => 'Purchase',
      AnalyticsDeterminantKind.store => 'Store',
      AnalyticsDeterminantKind.timeDayUtc => 'Time',
      AnalyticsDeterminantKind.timeMonthUtc => 'Time by month',
    };

String _sortLabel(AnalyticsVariablesSort sort) => switch (sort) {
  AnalyticsVariablesSort.timeAscending => 'Oldest first',
  AnalyticsVariablesSort.timeDescending => 'Newest first',
  AnalyticsVariablesSort.labelAscending => 'Label',
  AnalyticsVariablesSort.totalDescending => 'Total',
};

String _money(AnalyticsMoneyAmount money) {
  return '${money.currencyCode} ${(money.minorUnits / 100).toStringAsFixed(2)}';
}

String _unitPrice(AnalyticsEvidenceRow row) {
  final price = row.unitPrice;
  if (price == null) return 'Unavailable';
  return '${price.currencyCode} ${(price.minorUnitsPerCanonicalUnit / 100).toStringAsFixed(2)} per ${price.unit.name}';
}

String _formatLocal(DateTime value) {
  final local = value.toLocal();
  return '${local.day.toString().padLeft(2, '0')}-${local.month.toString().padLeft(2, '0')}-${local.year.toString().padLeft(4, '0')} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
}

AnalyticsTimeframe _parseTimeframeDraft(String initial, String finalDate) {
  final startText = initial.trim();
  final endText = finalDate.trim();
  if (startText.isEmpty && endText.isEmpty) {
    return const AnalyticsTimeframe.all();
  }
  if (startText.isEmpty || endText.isEmpty) {
    return const AnalyticsTimeframe.invalid(
      'Enter both Initial date and Final date as dd-mm-yyyy.',
    );
  }
  final start = _parseLocalDate(startText);
  if (start == null) {
    return AnalyticsTimeframe.invalid('Initial date must use dd-mm-yyyy.');
  }
  final end = _parseLocalDate(endText);
  if (end == null) {
    return AnalyticsTimeframe.invalid('Final date must use dd-mm-yyyy.');
  }
  if (end.isBefore(start)) {
    return const AnalyticsTimeframe.invalid(
      'Final date must be the same as or later than Initial date.',
    );
  }
  final endExclusive = DateTime(end.year, end.month, end.day + 1);
  return AnalyticsTimeframe.custom(
    startUtc: start.toUtc(),
    endUtc: endExclusive.toUtc(),
    initialLocalDate: startText,
    finalLocalDate: endText,
  );
}

DateTime? _parseLocalDate(String value) {
  final match = RegExp(r'^(\d{2})-(\d{2})-(\d{4})$').firstMatch(value);
  if (match == null) return null;
  final day = int.parse(match.group(1)!);
  final month = int.parse(match.group(2)!);
  final year = int.parse(match.group(3)!);
  final parsed = DateTime(year, month, day);
  if (parsed.year != year || parsed.month != month || parsed.day != day) {
    return null;
  }
  return parsed;
}
