import '../../l10n/marc_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../domain/analytics/analytics_models.dart';
import '../../l10n/analytics_copy.dart';
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
    this.onAxisChanged,
    this.onSelectAllDeterminants,
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
  final void Function(int, AnalyticsAxis)? onAxisChanged;
  final VoidCallback? onSelectAllDeterminants;

  @override
  Widget build(BuildContext context) {
    final determinantOptions =
        options[draft.determinant] ?? const <AnalyticsOption>[];
    return MarkeiSection(
      key: const Key('analytics.composer'),
      title: 'Create analysis',
      subtitle:
          'Set the rows, up to two comparison dimensions, then choose a value and statistic.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth >= 850
                  ? (constraints.maxWidth - 32) / 3
                  : constraints.maxWidth;
              return Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField<AnalyticsDeterminantKind>(
                          key: const Key('analytics.groupBy'),
                          decoration: InputDecoration(
                            labelText: 'Determinant',
                          ).localized(context),
                          initialValue: draft.determinant,
                          isExpanded: true,
                          style: MarkeiText.label.copyWith(
                            color: MarkeiColors.ink,
                          ),
                          items: [
                            for (final kind in AnalyticsDeterminantKind.values)
                              DropdownMenuItem(
                                value: kind,
                                enabled:
                                    kind !=
                                    AnalyticsDeterminantKind.purchasedFor,
                                child: MarcText(_determinantLabel(kind)),
                              ),
                          ],
                          onChanged: (value) {
                            if (value != null) onDeterminantChanged(value);
                          },
                        ),
                        if (_isTimeDimension(draft.determinant))
                          const Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: MarcText(
                              'Rows include the recorded dates within the timeframe below.',
                              style: MarkeiText.metadata,
                            ),
                          )
                        else ...[
                          _AnalyticsSearchChoice(
                            key: ValueKey(
                              'determinant.${draft.determinant.name}',
                            ),
                            options: determinantOptions,
                            selected: draft.selectedDeterminantKeys,
                            keyPrefix: 'analytics.choose',
                            onToggle: onToggleDeterminantKey,
                            onSelectAll: onSelectAllDeterminants,
                            label: 'Search code or name',
                          ),
                        ],
                      ],
                    ),
                  ),
                  for (var i = 0; i < 2; i++)
                    SizedBox(
                      width: width,
                      child: _AnalyticsAxisView(
                        index: i,
                        axis: draft.axes[i],
                        options: options,
                        excluded: {
                          draft.determinant,
                          if (draft.axes[1 - i].kind != null)
                            draft.axes[1 - i].kind!,
                        },
                        onChanged: (axis) => onAxisChanged?.call(i, axis),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          _ChoiceMenu<AnalyticsOperation>(
            key: const Key('analytics.operation'),
            label: 'Operation',
            value: draft.operation,
            values: AnalyticsOperation.values,
            onChanged: onOperationChanged,
            labelFor: _operationLabel,
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          MarcText(
            'Filter Pills / Breakdown / Additional constraints',
            style: MarkeiText.metadata,
          ),
          const SizedBox(height: MarkeiSpacing.xs),
          Wrap(
            spacing: MarkeiSpacing.xs,
            runSpacing: MarkeiSpacing.xs,
            children: [
              for (final variable in AnalyticsVariable.values)
                FilterChip(
                  key: Key('analytics.variable.${variable.name}'),
                  label: MarcText(_variableLabel(variable)),
                  selected: draft.variables.contains(variable),
                  onSelected: variable == AnalyticsVariable.purchasedFor
                      ? null
                      : (_) => onToggleVariable(variable),
                  tooltip: variable == AnalyticsVariable.purchasedFor
                      ? 'Purchased for will use tags in a future update; recorded data has no recipient tags yet.'
                      : null,
                ),
            ],
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          _AnalyticsTimeframeRange(
            timeframe: draft.timeframe,
            onChanged: onTimeframeChanged,
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          Semantics(
            liveRegion: true,
            child: MarcText(
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
                label: const MarcText('Run & save analysis'),
              ),
              OutlinedButton.icon(
                key: const Key('analytics.clearDraft'),
                onPressed: onClear,
                icon: const Icon(Icons.clear),
                label: const MarcText('Clear draft'),
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
    this.onSelected,
    super.key,
  });

  final List<AnalyticsRecord> records;
  final AnalyticsRecord? selected;
  final VoidCallback onOlder;
  final VoidCallback onNewer;
  final ValueChanged<AnalyticsRecordId>? onSelected;

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
      subtitle: 'Select a saved analysis to restore its result.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: MarkeiSpacing.sm,
            children: [
              IconButton(
                key: const Key('analytics.record.older'),
                tooltip: context.tr(
                  selectedIndex == records.length - 1
                      ? 'No older saved analysis'
                      : 'Select older saved analysis',
                ),
                onPressed:
                    selectedIndex >= 0 && selectedIndex < records.length - 1
                    ? onOlder
                    : null,
                icon: const Icon(Icons.chevron_left),
              ),
              IconButton(
                key: const Key('analytics.record.newer'),
                tooltip: context.tr(
                  selectedIndex <= 0
                      ? 'No newer saved analysis'
                      : 'Select newer saved analysis',
                ),
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
                    width: 260,
                    child: MarkeiCard(
                      key: Key('analytics.record.${record.fingerprint}'),
                      padding: const EdgeInsets.all(10),
                      borderColor: selected?.id.value == record.id.value
                          ? MarkeiColors.lavender
                          : null,
                      child: Semantics(
                        selected: selected?.id.value == record.id.value,
                        button: true,
                        label: context.tr(
                          'Saved record ${record.fingerprint}, group by ${context.tr(_determinantLabel(record.draft.determinant))}',
                        ),
                        child: InkWell(
                          onTap: onSelected == null
                              ? null
                              : () => onSelected!(record.id),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '#${record.fingerprint} · ${_formatLocal(record.executedAtUtc)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: MarkeiText.label,
                              ),
                              Text(
                                '${context.tr(_operationLabel(record.draft.operation))} · ${record.draft.selectedVariables.map((v) => context.tr(_variableLabel(v))).join(', ')}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: MarkeiText.metadata,
                              ),
                            ],
                          ),
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
    this.onShare,
    super.key,
  });

  final AnalyticsRecord? record;
  final AnalyticsResultPresentation presentation;
  final ValueChanged<AnalyticsResultPresentation> onPresentationChanged;
  final VoidCallback onExportCsv;
  final VoidCallback onExportPdf;
  final ValueChanged<String>? onShare;

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
      title: context.message('Statistics: {p0}', [
        record.draft.selectedVariables
            .map((v) => context.tr(_variableLabel(v)))
            .join(', '),
      ]),
      subtitle: context
          .message('Record #{p0} · {p1} · {p2}/{p3} evidence rows', [
            record.fingerprint,
            context.tr(record.draft.timeframe.label),
            record.eligibleCount,
            record.totalCount,
          ]),
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
                    label: MarcText('Chart'),
                    icon: Icon(Icons.bar_chart),
                  ),
                  ButtonSegment(
                    value: AnalyticsResultPresentation.table,
                    label: MarcText('Table'),
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
                label: const MarcText('Export CSV'),
              ),
              OutlinedButton.icon(
                key: const Key('analytics.export.pdf'),
                onPressed: onExportPdf,
                icon: const Icon(Icons.picture_as_pdf),
                label: const MarcText('Export PDF'),
              ),
              if (onShare != null)
                PopupMenuButton<String>(
                  key: const Key('analytics.share'),
                  enabled: onShare != null,
                  tooltip: context.tr('Share saved result'),
                  onSelected: onShare,
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'PDF',
                      child: Text(context.tr('Share PDF')),
                    ),
                    PopupMenuItem(
                      value: 'CSV',
                      child: Text(context.tr('Share CSV')),
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.share_outlined),
                        const SizedBox(width: 8),
                        Text(context.tr('Share saved result')),
                      ],
                    ),
                  ),
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
          const MarcText(
            'Result interpretation',
            style: MarkeiText.sectionTitle,
          ),
          const SizedBox(height: MarkeiSpacing.xs),
          MarcText(
            localizedAnalyticsInterpretation(
              record,
              MarcLocalizations.of(context),
            ),
            key: const Key('analytics.result.interpretation'),
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          const MarcText(
            'Other basic chart compositions will be added in future updates.',
            style: MarkeiText.metadata,
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

class AnalyticsChartProjection extends StatefulWidget {
  const AnalyticsChartProjection({required this.record, super.key});

  final AnalyticsRecord record;

  @override
  State<AnalyticsChartProjection> createState() =>
      _AnalyticsChartProjectionState();
}

class _AnalyticsChartProjectionState extends State<AnalyticsChartProjection> {
  int _page = 0;
  static const _pageSize = 36;
  @override
  void didUpdateWidget(covariant AnalyticsChartProjection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.record.fingerprint != widget.record.fingerprint) _page = 0;
  }

  @override
  Widget build(BuildContext context) {
    final record = widget.record;
    final values = [
      for (final entry in record.entries)
        if (entry.value is AnalyticsIntegerResultValue)
          (
            label: entry.groupKey.determinantLabel,
            value: (entry.value as AnalyticsIntegerResultValue).value,
            unit: context.tr(
              analyticsDisplayValue(entry.measure, entry.value).unit,
            ),
            display: MarcLocalizations.of(context).numericCopy(
              analyticsDisplayValue(entry.measure, entry.value).value,
            ),
            series:
                '${entry.groupKey.contextLabel} ${context.tr(_measureLabel(entry.measure))}'
                    .trim(),
          ),
    ];
    final summary =
        'Chart for Record ${record.fingerprint}. Categories: ${values.map((v) => v.label).join(', ')}. Series: ${values.map((v) => '${v.series} ${v.display} ${v.unit}').toSet().join(', ')}. Evidence count ${record.eligibleCount}.';
    final pageCount = (values.length / _pageSize).ceil().clamp(1, 100000);
    final visible = values.skip(_page * _pageSize).take(_pageSize).toList();
    final maxAbs = values.fold<int>(
      1,
      (max, value) => value.value.abs() > max ? value.value.abs() : max,
    );
    return Semantics(
      key: const Key('analytics.chart.summary'),
      label: context.tr(summary),
      child: Column(
        children: [
          if (pageCount > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  key: const Key('analytics.chart.previous'),
                  tooltip: context.tr('Previous chart page'),
                  onPressed: _page > 0 ? () => setState(() => _page--) : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                MarcText('Chart page ${_page + 1} of $pageCount'),
                IconButton(
                  key: const Key('analytics.chart.next'),
                  tooltip: context.tr('Next chart page'),
                  onPressed: _page + 1 < pageCount
                      ? () => setState(() => _page++)
                      : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          SizedBox(
            height: 350,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CustomPaint(
                size: Size(
                  (visible.length * 130).clamp(360, 5000).toDouble(),
                  330,
                ),
                painter: _AnalyticsBarChartPainter(
                  values: visible,
                  maxAbs: maxAbs,
                  seriesKeys: values.map((v) => v.series).toSet().toList(),
                  signed:
                      record.draft.operation == AnalyticsOperation.difference,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsBarChartPainter extends CustomPainter {
  const _AnalyticsBarChartPainter({
    required this.values,
    required this.signed,
    required this.maxAbs,
    required this.seriesKeys,
  });

  final List<
    ({String display, String label, String series, String unit, int value})
  >
  values;
  final bool signed;
  final int maxAbs;
  final List<String> seriesKeys;

  @override
  void paint(Canvas canvas, Size size) {
    final axis = Paint()
      ..color = Colors.black87
      ..strokeWidth = 1;
    const palette = [
      MarkeiColors.lavender,
      MarkeiColors.information,
      MarkeiColors.green,
      MarkeiColors.warning,
    ];
    final series = seriesKeys;
    final fill = Paint();
    final stroke = Paint()
      ..color = Colors.black87
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final zeroY = signed ? 138.0 : size.height - 105;
    canvas.drawLine(Offset(24, zeroY), Offset(size.width - 12, zeroY), axis);
    final barWidth = 28.0;
    for (var i = 0; i < values.length; i++) {
      final entry = values[i];
      final x = 48 + i * 130.0;
      final height = (entry.value.abs() / maxAbs) * (signed ? 88 : 170);
      final top = entry.value >= 0 ? zeroY - height : zeroY;
      final rect = Rect.fromLTWH(x, top, barWidth, height);
      fill.color = palette[series.indexOf(entry.series) % palette.length];
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(3)),
        fill,
      );
      void label(String text, double y, {Color color = MarkeiColors.ink}) {
        final painter = TextPainter(
          text: TextSpan(
            text: text,
            style: MarkeiText.metadata.copyWith(fontSize: 11, color: color),
          ),
          textDirection: TextDirection.ltr,
          maxLines: 3,
          ellipsis: '…',
        )..layout(maxWidth: 120);
        painter.paint(canvas, Offset(x - 12, y));
      }

      label(
        '${entry.display} ${entry.unit}',
        entry.value < 0 ? top + height + 2 : top - 32,
      );
      label(entry.label, signed ? 265 : zeroY + 5);
      label(entry.series, signed ? 288 : zeroY + 30, color: fill.color);
      canvas.drawRect(rect, stroke);
      canvas.drawCircle(Offset(x + barWidth / 2, top), 3, stroke);
    }
  }

  @override
  bool shouldRepaint(covariant _AnalyticsBarChartPainter oldDelegate) {
    return values != oldDelegate.values ||
        signed != oldDelegate.signed ||
        maxAbs != oldDelegate.maxAbs;
  }
}

class AnalyticsResultTable extends StatelessWidget {
  const AnalyticsResultTable({required this.record, super.key});

  final AnalyticsRecord record;

  @override
  Widget build(BuildContext context) {
    return _HorizontalAnalyticsTable(
      key: const Key('analytics.result.scroll'),
      child: DataTable(
        key: const Key('analytics.result.table'),
        columns: const [
          DataColumn(label: MarcText('Group')),
          DataColumn(label: MarcText('Analytics 01 / 02')),
          DataColumn(label: MarcText('Measure')),
          DataColumn(label: MarcText('Operation')),
          DataColumn(label: MarcText('Value')),
          DataColumn(label: MarcText('Unit/currency')),
          DataColumn(label: MarcText('Eligible')),
          DataColumn(label: MarcText('Excluded')),
          DataColumn(label: MarcText('Unavailable reason')),
        ],
        rows: [
          for (final entry in record.entries)
            DataRow(
              cells: [
                DataCell(Text(entry.groupKey.determinantLabel)),
                DataCell(Text(entry.groupKey.contextLabel)),
                DataCell(MarcText(_measureLabel(entry.measure))),
                DataCell(MarcText(_operationLabel(entry.operation))),
                DataCell(
                  MarcText(
                    analyticsDisplayValue(entry.measure, entry.value).value,
                  ),
                ),
                DataCell(
                  MarcText(
                    analyticsDisplayValue(entry.measure, entry.value).unit,
                  ),
                ),
                DataCell(MarcText(entry.eligibleCount.toString())),
                DataCell(MarcText(entry.excludedCount.toString())),
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
            MarcText(
              state.message!,
              key: const Key('analytics.variables.focus'),
            ),
            TextButton(
              key: const Key('analytics.variables.showAll'),
              onPressed: onShowAll,
              child: const MarcText('Show all variables'),
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
                    label: MarcText('Purchases'),
                  ),
                  ButtonSegment(
                    value: AnalyticsVariablesProjection.containedItems,
                    label: MarcText('Contained items'),
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
                  decoration: InputDecoration(
                    labelText: 'Search',
                  ).localized(context),
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
          MarcText('${state.selectedCount} selected row(s)'),
          const SizedBox(height: MarkeiSpacing.xs),
          const MarcText(
            'Each row is a recorded purchase or item. Scroll horizontally to inspect all values.',
            style: MarkeiText.metadata,
          ),
          if (state.projection ==
              AnalyticsVariablesProjection.containedItems) ...[
            const SizedBox(height: MarkeiSpacing.xs),
            const MarcText(
              'Price paid is the item total; Purchase total covers the whole purchase and may repeat across its items.',
              style: MarkeiText.metadata,
            ),
          ],
          const SizedBox(height: MarkeiSpacing.sm),
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
                label: const MarcText('Previous page'),
              ),
              OutlinedButton.icon(
                key: const Key('analytics.variables.next'),
                onPressed: state.hasNext ? onNextPage : null,
                icon: const Icon(Icons.chevron_right),
                label: const MarcText('Next page'),
              ),
              FilledButton.icon(
                key: const Key('analytics.variables.useSelected'),
                onPressed: state.selectedCount > 0 ? onUseSelectedRows : null,
                icon: const Icon(Icons.input),
                label: const MarcText('Use selected rows'),
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
    return _HorizontalAnalyticsTable(
      key: const Key('analytics.purchases.scroll'),
      child: DataTable(
        key: const Key('analytics.purchases.table'),
        horizontalMargin: wide ? 24 : 12,
        columnSpacing: wide ? 40 : 24,
        headingTextStyle: MarkeiText.tableLabel,
        dataTextStyle: wide
            ? MarkeiText.body
            : MarkeiText.body.copyWith(fontSize: 12),
        columns: const [
          DataColumn(label: MarcText('Select')),
          DataColumn(label: MarcText('Date-Time of purchase')),
          DataColumn(label: MarcText('Store name')),
          DataColumn(label: MarcText('Purchased by')),
          DataColumn(label: MarcText('Purchased for')),
          DataColumn(label: MarcText('Payment method')),
          DataColumn(label: MarcText('Item count')),
          DataColumn(label: MarcText('Purchase total')),
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
                DataCell(MarcText(_formatLocal(row.occurrenceTime))),
                DataCell(Text(row.storeName)),
                DataCell(
                  Text(
                    row.purchasedBy?.displayLabel ?? context.tr('Not assigned'),
                  ),
                ),
                const DataCell(MarcText('Unavailable in recorded data')),
                DataCell(
                  Text(
                    row.paymentMethod?.displayLabel ??
                        context.tr('Not assigned'),
                  ),
                ),
                DataCell(MarcText(row.itemCount.toString())),
                DataCell(MarcText(_money(row.purchaseTotal))),
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
    return _HorizontalAnalyticsTable(
      key: const Key('analytics.items.scroll'),
      child: DataTable(
        key: const Key('analytics.items.table'),
        horizontalMargin: wide ? 24 : 12,
        columnSpacing: wide ? 40 : 24,
        headingTextStyle: MarkeiText.tableLabel,
        dataTextStyle: wide
            ? MarkeiText.body
            : MarkeiText.body.copyWith(fontSize: 12),
        columns: const [
          DataColumn(label: MarcText('Select')),
          DataColumn(label: MarcText('Date-Time of purchase')),
          DataColumn(label: MarcText('Product code')),
          DataColumn(label: MarcText('Product name')),
          DataColumn(label: MarcText('Brand')),
          DataColumn(label: MarcText('Store name')),
          DataColumn(label: MarcText('Purchased by')),
          DataColumn(label: MarcText('Purchased for')),
          DataColumn(label: MarcText('Payment method')),
          DataColumn(label: MarcText('Quantity and unit')),
          DataColumn(label: MarcText('Unit price')),
          DataColumn(label: MarcText('Price paid')),
          DataColumn(label: MarcText('Purchase total')),
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
                DataCell(MarcText(_formatLocal(row.purchaseOccurrenceTime))),
                DataCell(Text(row.productCode)),
                DataCell(Text(row.productName)),
                DataCell(
                  Text(
                    row.productBrand.isEmpty
                        ? context.tr('Unavailable')
                        : row.productBrand,
                  ),
                ),
                DataCell(Text(row.storeName)),
                DataCell(
                  Text(
                    row.purchasedBy?.displayLabel ?? context.tr('Not assigned'),
                  ),
                ),
                const DataCell(MarcText('Unavailable in recorded data')),
                DataCell(
                  Text(
                    row.paymentMethod?.displayLabel ??
                        context.tr('Not assigned'),
                  ),
                ),
                DataCell(
                  Text('${row.quantity.decimalText} ${row.quantity.unit.name}'),
                ),
                DataCell(MarcText(_unitPrice(row))),
                DataCell(MarcText(_money(row.lineTotal))),
                DataCell(MarcText(_money(row.purchaseTotal))),
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
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: constraints.maxWidth.clamp(0, 300),
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          underline: const SizedBox.shrink(),
          items: [
            for (final item in values)
              DropdownMenuItem(
                value: item,
                child: Text(
                  '${context.tr(label)}: ${context.tr(labelFor(item))}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
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
    analyticsDimensionLabel(determinant);

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

bool _isTimeDimension(AnalyticsDeterminantKind? kind) =>
    kind == AnalyticsDeterminantKind.timeDayUtc ||
    kind == AnalyticsDeterminantKind.timeMonthUtc;

class _AnalyticsTimeframeRange extends StatefulWidget {
  const _AnalyticsTimeframeRange({
    required this.timeframe,
    required this.onChanged,
  });

  final AnalyticsTimeframe timeframe;
  final ValueChanged<AnalyticsTimeframe> onChanged;

  @override
  State<_AnalyticsTimeframeRange> createState() =>
      _AnalyticsTimeframeRangeState();
}

class _AnalyticsTimeframeRangeState extends State<_AnalyticsTimeframeRange> {
  final _start = TextEditingController();
  final _end = TextEditingController();

  @override
  void initState() {
    super.initState();
    _syncFields();
  }

  @override
  void didUpdateWidget(covariant _AnalyticsTimeframeRange oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncFields();
  }

  void _syncFields() {
    final timeframe = widget.timeframe;
    _syncText(
      _start,
      timeframe.initialLocalDate ?? _localDate(timeframe.startUtc),
    );
    _syncText(
      _end,
      timeframe.finalLocalDate ??
          _localDate(
            timeframe.endUtc?.subtract(const Duration(microseconds: 1)),
          ),
    );
  }

  static String _localDate(DateTime? value) {
    if (value == null) return '';
    final local = value.toLocal();
    return '${local.day.toString().padLeft(2, '0')}-'
        '${local.month.toString().padLeft(2, '0')}-'
        '${local.year.toString().padLeft(4, '0')}';
  }

  static void _syncText(TextEditingController controller, String text) {
    if (controller.text == text) return;
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void _changed(String _) =>
      widget.onChanged(_parseTimeframeDraft(_start.text, _end.text));

  @override
  void dispose() {
    _start.dispose();
    _end.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      MarcText('Timeframe', style: MarkeiText.metadata),
      const SizedBox(height: MarkeiSpacing.xs),
      LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth < 180
              ? constraints.maxWidth
              : 180.0;
          return Wrap(
            spacing: MarkeiSpacing.sm,
            runSpacing: MarkeiSpacing.sm,
            children: [
              SizedBox(
                width: width,
                child: TextField(
                  key: const Key('analytics.timeframe.initialDate'),
                  controller: _start,
                  inputFormatters: [_AnalyticsDateFormatter()],
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Start date',
                    hintText: 'dd-mm-yyyy',
                    prefixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                  ).localized(context),
                  onChanged: _changed,
                ),
              ),
              SizedBox(
                width: width,
                child: TextField(
                  key: const Key('analytics.timeframe.finalDate'),
                  controller: _end,
                  inputFormatters: [_AnalyticsDateFormatter()],
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'End date',
                    hintText: 'dd-mm-yyyy',
                    prefixIcon: Icon(Icons.calendar_today_outlined, size: 18),
                  ).localized(context),
                  onChanged: _changed,
                ),
              ),
            ],
          );
        },
      ),
      const SizedBox(height: MarkeiSpacing.xs),
      const MarcText(
        'Both dates are included. Leave both blank to use all recorded time.',
        style: MarkeiText.metadata,
      ),
    ],
  );
}

AnalyticsTimeframe _parseTimeframeDraft(String initial, String finalDate) {
  final startText = initial.trim();
  final endText = finalDate.trim();
  if (startText.isEmpty && endText.isEmpty) {
    return const AnalyticsTimeframe.all();
  }
  if (startText.isEmpty || endText.isEmpty) {
    return AnalyticsTimeframe.invalid(
      'Enter both Start date and End date as dd-mm-yyyy.',
      initialLocalDate: initial,
      finalLocalDate: finalDate,
    );
  }
  final start = _parseLocalDate(startText);
  if (start == null) {
    return AnalyticsTimeframe.invalid(
      'Start date must be a valid date in dd-mm-yyyy format.',
      initialLocalDate: initial,
      finalLocalDate: finalDate,
    );
  }
  final end = _parseLocalDate(endText);
  if (end == null) {
    return AnalyticsTimeframe.invalid(
      'End date must be a valid date in dd-mm-yyyy format.',
      initialLocalDate: initial,
      finalLocalDate: finalDate,
    );
  }
  if (end.isBefore(start)) {
    return AnalyticsTimeframe.invalid(
      'End date must be the same as or later than Start date.',
      initialLocalDate: initial,
      finalLocalDate: finalDate,
    );
  }
  final endExclusive = DateTime(end.year, end.month, end.day + 1);
  return AnalyticsTimeframe.custom(
    startUtc: start.toUtc(),
    endUtc: endExclusive.toUtc(),
    initialLocalDate: initial,
    finalLocalDate: finalDate,
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

class _AnalyticsAxisView extends StatelessWidget {
  const _AnalyticsAxisView({
    required this.index,
    required this.axis,
    required this.options,
    required this.excluded,
    required this.onChanged,
  });
  final int index;
  final AnalyticsAxis axis;
  final Map<AnalyticsDeterminantKind, List<AnalyticsOption>> options;
  final Set<AnalyticsDeterminantKind> excluded;
  final ValueChanged<AnalyticsAxis> onChanged;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DropdownButtonFormField<AnalyticsDeterminantKind>(
        key: ValueKey('analytics.axis.$index.${axis.kind?.name}'),
        initialValue: axis.kind,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: index == 0 ? 'Analytics' : 'Analytics constraint',
          filled: true,
          fillColor: MarkeiColors.lavender.withValues(alpha: 0.035),
        ).localized(context),
        hint: const MarcText('No second dimension'),
        items: [
          const DropdownMenuItem(value: null, child: MarcText('None')),
          for (final kind in AnalyticsDeterminantKind.values)
            DropdownMenuItem(
              value: kind,
              enabled:
                  !excluded.contains(kind) &&
                  kind != AnalyticsDeterminantKind.purchasedFor,
              child: MarcText(_determinantLabel(kind)),
            ),
        ],
        onChanged: (kind) => onChanged(AnalyticsAxis(kind: kind)),
      ),
      if (_isTimeDimension(axis.kind))
        const Padding(
          padding: EdgeInsets.only(top: 12),
          child: MarcText(
            'Comparison dates follow the timeframe below.',
            style: MarkeiText.metadata,
          ),
        )
      else if (axis.kind != null) ...[
        _AnalyticsSearchChoice(
          key: ValueKey('axis.$index.${axis.kind!.name}'),
          options: options[axis.kind] ?? const [],
          selected: axis.selectedKeys,
          keyPrefix: 'analytics.axis.$index.choose',
          label: 'Search comparison values',
          onSelectAll: () => onChanged(AnalyticsAxis(kind: axis.kind)),
          onToggle: (key) {
            final next = {...axis.selectedKeys};
            if (!next.remove(key)) next.add(key);
            onChanged(AnalyticsAxis(kind: axis.kind, selectedKeys: next));
          },
        ),
        MarcText(
          axis.selectedKeys.isEmpty
              ? 'All recorded values form comparison series.'
              : '${axis.selectedKeys.length} selected comparison value(s).',
          style: MarkeiText.metadata,
        ),
      ],
    ],
  );
}

class _AnalyticsSearchChoice extends StatefulWidget {
  const _AnalyticsSearchChoice({
    required this.options,
    required this.selected,
    required this.onToggle,
    required this.keyPrefix,
    required this.label,
    this.onSelectAll,
    super.key,
  });
  final List<AnalyticsOption> options;
  final Set<String> selected;
  final ValueChanged<String> onToggle;
  final String keyPrefix;
  final String label;
  final VoidCallback? onSelectAll;
  @override
  State<_AnalyticsSearchChoice> createState() => _AnalyticsSearchChoiceState();
}

class _AnalyticsSearchChoiceState extends State<_AnalyticsSearchChoice> {
  String _search = '';
  final _scroll = ScrollController();
  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matches = widget.options
        .where(
          (o) => o.label.toLowerCase().contains(_search.trim().toLowerCase()),
        )
        .toList();
    final selected = widget.options.where(
      (o) => widget.selected.contains(o.key),
    );
    return ExpansionTile(
      key: Key('${widget.keyPrefix}.dropdown'),
      tilePadding: EdgeInsets.zero,
      title: const MarcText('Choose recorded values'),
      subtitle: Text(
        context.message('{p0} selected value(s)', [widget.selected.length]),
      ),
      childrenPadding: const EdgeInsets.only(bottom: 8),
      children: [
        const SizedBox(height: 12),
        TextField(
          key: Key('${widget.keyPrefix}.search'),
          decoration: InputDecoration(
            labelText: widget.label,
            prefixIcon: const Icon(Icons.search),
          ).localized(context),
          onChanged: (value) => setState(() => _search = value),
        ),
        if (selected.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final option in selected)
                  InputChip(
                    label: Text(option.label),
                    onDeleted: () => widget.onToggle(option.key),
                  ),
              ],
            ),
          ),
        if (matches.isNotEmpty)
          SizedBox(
            height:
                (matches.length < 5 ? matches.length : 5) *
                56 *
                MediaQuery.textScalerOf(context).scale(1),
            child: Scrollbar(
              controller: _scroll,
              thumbVisibility: true,
              child: ListView.builder(
                controller: _scroll,
                primary: false,
                itemExtent: 56 * MediaQuery.textScalerOf(context).scale(1),
                itemCount: matches.length,
                itemBuilder: (context, index) {
                  final option = matches[index];
                  return CheckboxListTile(
                    key: Key('${widget.keyPrefix}.${option.key}'),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      option.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: MarkeiText.body,
                    ),
                    value: widget.selected.contains(option.key),
                    onChanged: (_) => widget.onToggle(option.key),
                  );
                },
              ),
            ),
          ),
        TextButton(
          onPressed: widget.onSelectAll,
          child: const MarcText('Use all records'),
        ),
        if (matches.isEmpty)
          const MarcText(
            'No recorded values match this search.',
            style: MarkeiText.metadata,
          ),
      ],
    );
  }
}

class _HorizontalAnalyticsTable extends StatefulWidget {
  const _HorizontalAnalyticsTable({required this.child, super.key});
  final Widget child;
  @override
  State<_HorizontalAnalyticsTable> createState() =>
      _HorizontalAnalyticsTableState();
}

class _HorizontalAnalyticsTableState extends State<_HorizontalAnalyticsTable> {
  final _scroll = ScrollController();
  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scrollbar(
    controller: _scroll,
    thumbVisibility: true,
    trackVisibility: true,
    scrollbarOrientation: ScrollbarOrientation.bottom,
    child: SingleChildScrollView(
      controller: _scroll,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 16),
      child: widget.child,
    ),
  );
}

/// Inserts separators without accepting invalid calendar dates; validation is
/// still performed by the existing strict local-date parser.
class _AnalyticsDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.composing.isValid && !newValue.composing.isCollapsed) {
      return newValue;
    }
    // Keep explicitly separated drafts intact so existing strict validation
    // reports malformed pasted dates instead of silently coercing them.
    if (newValue.text.contains(RegExp(r'[^0-9-]'))) return newValue;
    final digits = newValue.text.replaceAll('-', '');
    if (digits.length > 8) return newValue;
    var formatted = digits;
    if (digits.length > 4) {
      formatted =
          '${digits.substring(0, 2)}-${digits.substring(2, 4)}-${digits.substring(4)}';
    } else if (digits.length > 2) {
      formatted = '${digits.substring(0, 2)}-${digits.substring(2)}';
    }
    if (newValue.text == formatted) return newValue;
    final cursor = newValue.selection.extentOffset.clamp(
      0,
      newValue.text.length,
    );
    final before = newValue.text
        .substring(0, cursor)
        .replaceAll('-', '')
        .length;
    final offset = (before + (before > 2 ? 1 : 0) + (before > 4 ? 1 : 0)).clamp(
      0,
      formatted.length,
    );
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}
