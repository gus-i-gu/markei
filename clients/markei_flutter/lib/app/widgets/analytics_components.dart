import 'package:flutter/material.dart';

import '../../domain/analytics/analytics_models.dart';
import '../design/markei_theme.dart';
import 'markei_components.dart';

class AnalyticsCardsView extends StatelessWidget {
  const AnalyticsCardsView({
    required this.cards,
    required this.results,
    required this.onMoveEarlier,
    required this.onMoveLater,
    required this.onFocus,
    required this.onDelete,
    super.key,
  });

  final List<AnalyticsCardConfiguration> cards;
  final Map<AnalyticsCardId, AnalyticsResultEnvelope> results;
  final ValueChanged<AnalyticsCardId> onMoveEarlier;
  final ValueChanged<AnalyticsCardId> onMoveLater;
  final ValueChanged<AnalyticsCardId> onFocus;
  final ValueChanged<AnalyticsCardId> onDelete;

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return const MarkeiStatePanel(
        key: Key('analytics.cards.empty'),
        title: 'No analysis cards yet',
        message:
            'New cards stay in this session and never change Purchase evidence.',
        icon: Icons.analytics_outlined,
      );
    }
    return Column(
      children: [
        for (final card in cards) ...[
          MarkeiCard(
            key: Key('analytics.card.${card.id.value}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_operationLabel(card.operation)} by ${_determinantLabel(card.determinant)}',
                  style: MarkeiText.sectionTitle,
                ),
                const SizedBox(height: MarkeiSpacing.xs),
                Text(
                  card.variables.map(_variableLabel).join(', '),
                  style: MarkeiText.metadata,
                ),
                const SizedBox(height: MarkeiSpacing.sm),
                _ResultView(result: results[card.id]),
                const SizedBox(height: MarkeiSpacing.sm),
                Wrap(
                  spacing: MarkeiSpacing.xs,
                  children: [
                    IconButton(
                      tooltip: 'Move card earlier',
                      onPressed: () => onMoveEarlier(card.id),
                      icon: const Icon(Icons.arrow_upward),
                    ),
                    IconButton(
                      tooltip: 'Move card later',
                      onPressed: () => onMoveLater(card.id),
                      icon: const Icon(Icons.arrow_downward),
                    ),
                    IconButton(
                      tooltip: 'Focus supporting evidence',
                      onPressed: () => onFocus(card.id),
                      icon: const Icon(Icons.center_focus_strong),
                    ),
                    IconButton(
                      tooltip: 'Delete card',
                      onPressed: () => onDelete(card.id),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: MarkeiSpacing.sm),
        ],
      ],
    );
  }
}

class AnalyticsEvidenceMatrix extends StatelessWidget {
  const AnalyticsEvidenceMatrix({
    required this.rows,
    required this.selectedRowIds,
    required this.onSelectionChanged,
    required this.wide,
    super.key,
  });

  final List<AnalyticsEvidenceRow> rows;
  final Set<AnalyticsEvidenceRowId> selectedRowIds;
  final ValueChanged<Set<AnalyticsEvidenceRowId>> onSelectionChanged;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return const MarkeiStatePanel(
        key: Key('analytics.evidence.empty'),
        message: 'No evidence matches these conditions.',
        icon: Icons.filter_alt_off,
      );
    }
    if (!wide) {
      return Column(
        children: [
          for (final row in rows) ...[
            MarkeiCard(
              key: Key('analytics.evidence.card.${row.id.value}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: _contains(row.id),
                    onChanged: (_) => _toggle(row.id),
                    title: Text(row.productName),
                    subtitle: Text(
                      '${row.storeName} - ${_formatUtc(row.purchaseOccurrenceTime)}',
                    ),
                  ),
                  Wrap(
                    spacing: MarkeiSpacing.lg,
                    runSpacing: MarkeiSpacing.xs,
                    children: _facts(row),
                  ),
                ],
              ),
            ),
            const SizedBox(height: MarkeiSpacing.sm),
          ],
        ],
      );
    }
    return MarkeiCard(
      padding: const EdgeInsets.all(MarkeiSpacing.xs),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Select')),
            DataColumn(label: Text('Purchase')),
            DataColumn(label: Text('Purchase date and time')),
            DataColumn(label: Text('Product')),
            DataColumn(label: Text('Brand')),
            DataColumn(label: Text('Store')),
            DataColumn(label: Text('Purchased by')),
            DataColumn(label: Text('Purchased for')),
            DataColumn(label: Text('Payment method')),
            DataColumn(label: Text('Quantity')),
            DataColumn(label: Text('Unit price')),
            DataColumn(label: Text('Line total')),
            DataColumn(label: Text('Promotion')),
          ],
          rows: [
            for (final row in rows)
              DataRow(
                key: ValueKey('analytics.evidence.row.${row.id.value}'),
                selected: _contains(row.id),
                cells: [
                  DataCell(
                    Checkbox(
                      value: _contains(row.id),
                      onChanged: (_) => _toggle(row.id),
                    ),
                  ),
                  DataCell(Text(row.purchaseId.value)),
                  DataCell(Text(_formatUtc(row.purchaseOccurrenceTime))),
                  DataCell(Text('${row.productCode} - ${row.productName}')),
                  DataCell(
                    Text(
                      row.productBrand.isEmpty
                          ? 'Unavailable'
                          : row.productBrand,
                    ),
                  ),
                  DataCell(Text(row.storeName)),
                  DataCell(Text(row.purchasedBy ?? 'Unavailable')),
                  const DataCell(Text('Unavailable in recorded data')),
                  DataCell(Text(row.paymentMethod ?? 'Unavailable')),
                  DataCell(
                    Text(
                      '${row.quantity.decimalText} ${row.quantity.unit.name}',
                    ),
                  ),
                  DataCell(Text(_unitPrice(row))),
                  DataCell(Text(_money(row.lineTotal))),
                  const DataCell(Text('Unavailable in recorded data')),
                ],
              ),
          ],
        ),
      ),
    );
  }

  bool _contains(AnalyticsEvidenceRowId id) {
    return selectedRowIds.any((selected) => selected.value == id.value);
  }

  void _toggle(AnalyticsEvidenceRowId id) {
    final next = {...selectedRowIds};
    final existing = next
        .where((selected) => selected.value == id.value)
        .firstOrNull;
    if (existing == null) {
      next.add(id);
    } else {
      next.remove(existing);
    }
    onSelectionChanged(next);
  }

  List<Widget> _facts(AnalyticsEvidenceRow row) {
    return [
      MarkeiFact(label: 'Purchase', value: row.purchaseId.value),
      MarkeiFact(
        label: 'Purchase date and time',
        value: _formatUtc(row.purchaseOccurrenceTime),
      ),
      MarkeiFact(
        label: 'Product',
        value: '${row.productCode} - ${row.productName}',
      ),
      MarkeiFact(
        label: 'Brand',
        value: row.productBrand.isEmpty ? 'Unavailable' : row.productBrand,
      ),
      MarkeiFact(label: 'Store', value: row.storeName),
      MarkeiFact(
        label: 'Purchased by',
        value: row.purchasedBy ?? 'Unavailable',
      ),
      const MarkeiFact(
        label: 'Purchased for',
        value: 'Unavailable in recorded data',
      ),
      MarkeiFact(
        label: 'Payment method',
        value: row.paymentMethod ?? 'Unavailable',
      ),
      MarkeiFact(
        label: 'Quantity',
        value: '${row.quantity.decimalText} ${row.quantity.unit.name}',
      ),
      MarkeiFact(label: 'Unit price', value: _unitPrice(row)),
      MarkeiFact(label: 'Line total', value: _money(row.lineTotal)),
      const MarkeiFact(
        label: 'Promotion',
        value: 'Unavailable in recorded data',
      ),
    ];
  }
}

class _ResultView extends StatelessWidget {
  const _ResultView({required this.result});

  final AnalyticsResultEnvelope? result;

  @override
  Widget build(BuildContext context) {
    final value = result;
    if (value == null) {
      return const Text(
        'Choose a determinant, variable and operation to calculate this card.',
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value.interpretation,
          key: const Key('analytics.result.interpretation'),
        ),
        const SizedBox(height: MarkeiSpacing.xs),
        for (final resultValue in value.values)
          Text(_resultValueLabel(resultValue)),
      ],
    );
  }
}

String _resultValueLabel(AnalyticsResultValue value) {
  return switch (value) {
    AnalyticsIntegerResultValue() =>
      '${value.label}: ${value.value}${value.unitLabel == null ? '' : ' ${value.unitLabel}'}',
    AnalyticsBasisPointResultValue() =>
      '${value.label}: ${(value.basisPoints / 100).toStringAsFixed(2)}%',
    AnalyticsUnavailableResultValue() => value.message,
  };
}

String _operationLabel(AnalyticsOperation operation) => switch (operation) {
  AnalyticsOperation.sum => 'Sum',
  AnalyticsOperation.mean => 'Mean',
  AnalyticsOperation.difference => 'Difference',
  AnalyticsOperation.percentage => 'Percentage',
};

String _variableLabel(AnalyticsVariable variable) => switch (variable) {
  AnalyticsVariable.quantity => 'Quantity',
  AnalyticsVariable.unitPrice => 'Unit price',
  AnalyticsVariable.lineTotal => 'Line total',
  AnalyticsVariable.purchaseTotal => 'Purchase total',
  AnalyticsVariable.evidenceCount => 'Evidence count',
};

String _determinantLabel(AnalyticsDeterminantKind determinant) =>
    switch (determinant) {
      AnalyticsDeterminantKind.product => 'Product',
      AnalyticsDeterminantKind.purchase => 'Purchase',
      AnalyticsDeterminantKind.store => 'Store',
      AnalyticsDeterminantKind.timeDayUtc => 'UTC day',
      AnalyticsDeterminantKind.timeMonthUtc => 'UTC month',
    };

String _money(AnalyticsMoneyAmount money) {
  return '${money.currencyCode} ${(money.minorUnits / 100).toStringAsFixed(2)}';
}

String _unitPrice(AnalyticsEvidenceRow row) {
  final price = row.unitPrice;
  if (price == null) return 'Unavailable';
  return '${price.currencyCode} ${(price.minorUnitsPerCanonicalUnit / 100).toStringAsFixed(2)} per ${price.unit.name}';
}

String _formatUtc(DateTime value) {
  final utc = value.toUtc();
  return '${utc.year.toString().padLeft(4, '0')}-${utc.month.toString().padLeft(2, '0')}-${utc.day.toString().padLeft(2, '0')} ${utc.hour.toString().padLeft(2, '0')}:${utc.minute.toString().padLeft(2, '0')} UTC';
}
