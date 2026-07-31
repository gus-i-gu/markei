import 'dart:convert';

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

String analyticsRecordCsv(AnalyticsRecord record, AnalyticsDataset dataset) {
  final rows = <List<String>>[
    ['record_fingerprint', record.fingerprint],
    ['record_created_utc', record.executedAtUtc.toUtc().toIso8601String()],
    ['registry', '${record.registryIdentifier}@${record.registryVersion}'],
    ['group_by', record.draft.determinant.name],
    ['operation', record.draft.operation.name],
    ['timeframe', record.draft.timeframe.label],
    ['eligible_count', record.eligibleCount.toString()],
    ['total_count', record.totalCount.toString()],
    ['excluded_count', record.excludedCount.toString()],
    [],
    [
      'group_label',
      'breakdowns',
      'measure',
      'operation',
      'value',
      'unit_or_currency',
      'eligible_count',
      'excluded_count',
      'unavailable_reason',
    ],
  ];
  for (final entry in record.entries) {
    rows.add([
      entry.groupKey.determinantLabel,
      entry.groupKey.breakdownLabels.values.join(' | '),
      entry.measure.name,
      entry.operation.name,
      _csvValue(entry.value),
      _csvUnit(entry.value),
      entry.eligibleCount.toString(),
      entry.excludedCount.toString(),
      entry.value is AnalyticsUnavailableResultValue
          ? (entry.value as AnalyticsUnavailableResultValue).reason.name
          : '',
    ]);
  }
  rows.addAll([
    [],
    [
      'purchase_item_id',
      'purchase_id',
      'occurrence_time_utc',
      'product_id',
      'product_code',
      'product_name',
      'product_brand',
      'store_id',
      'store_name',
      'purchased_by',
      'purchased_for',
      'payment_method',
      'quantity',
      'unit',
      'unit_price',
      'line_total',
      'promotion',
    ],
  ]);
  final contributing = {for (final id in record.contributingRowIds) id.value};
  for (final row in dataset.rows.where(
    (row) => contributing.contains(row.id.value),
  )) {
    rows.add([
      row.id.value,
      row.purchaseId.value,
      row.purchaseOccurrenceTime.toUtc().toIso8601String(),
      row.productId.value,
      row.productCode,
      row.productName,
      row.productBrand.isEmpty ? 'Unavailable' : row.productBrand,
      row.storeId.value,
      row.storeName,
      row.purchasedByLabel ?? 'Not assigned',
      'Unavailable in recorded data',
      row.paymentMethodLabel ?? 'Not assigned',
      row.quantity.decimalText,
      row.quantity.unit.name,
      row.unitPrice == null
          ? 'Unavailable'
          : '${row.unitPrice!.currencyCode} ${row.unitPrice!.minorUnitsPerCanonicalUnit}',
      '${row.lineTotal.currencyCode} ${row.lineTotal.minorUnits}',
      'Unavailable in recorded data',
    ]);
  }
  return rows.map((row) => row.map(_csvCell).join(',')).join('\r\n');
}

List<int> analyticsRecordPdfBytes(AnalyticsRecord record) {
  final text = StringBuffer()
    ..writeln('Markei Analytics record')
    ..writeln()
    ..writeln('Record #${record.fingerprint}')
    ..writeln('Created UTC: ${record.executedAtUtc.toUtc().toIso8601String()}')
    ..writeln(
      'Registry: ${record.registryIdentifier}@${record.registryVersion}',
    )
    ..writeln('Group by: ${record.draft.determinant.name}')
    ..writeln('Operation: ${record.draft.operation.name}')
    ..writeln('Timeframe: ${record.draft.timeframe.label}')
    ..writeln(
      'Evidence: ${record.eligibleCount}/${record.totalCount}; excluded ${record.excludedCount}',
    )
    ..writeln()
    ..writeln(record.interpretation)
    ..writeln()
    ..writeln('Results');
  for (final entry in record.entries) {
    text.writeln(
      '${entry.groupKey.determinantLabel} ${entry.groupKey.breakdownLabels.values.join(' ')} '
      '${entry.measure.name} ${entry.operation.name}: ${_csvValue(entry.value)} ${_csvUnit(entry.value)} '
      'eligible=${entry.eligibleCount} excluded=${entry.excludedCount}',
    );
  }
  return _simplePdf(text.toString());
}

String _csvCell(String value) {
  final mustQuote =
      value.contains(',') || value.contains('"') || value.contains('\n');
  final escaped = value.replaceAll('"', '""');
  return mustQuote ? '"$escaped"' : escaped;
}

String _csvValue(AnalyticsResultValue value) => switch (value) {
  AnalyticsIntegerResultValue() => value.value.toString(),
  AnalyticsBasisPointResultValue() =>
    '${(value.basisPoints / 100).toStringAsFixed(2)}%',
  AnalyticsUnavailableResultValue() => value.message,
};

String _csvUnit(AnalyticsResultValue value) => switch (value) {
  AnalyticsIntegerResultValue() => value.compatibilityKey.value,
  AnalyticsBasisPointResultValue() => value.compatibilityKey.value,
  AnalyticsUnavailableResultValue() => '',
};

List<int> _simplePdf(String text) {
  final escaped = text
      .replaceAll('\\', r'\\')
      .replaceAll('(', r'\(')
      .replaceAll(')', r'\)')
      .replaceAll('\r', '')
      .split('\n')
      .map((line) => '($line) Tj T*')
      .join('\n');
  final stream = 'BT /F1 10 Tf 40 780 Td 14 TL\n$escaped\nET';
  final objects = <String>[
    '1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj\n',
    '2 0 obj << /Type /Pages /Kids [3 0 R] /Count 1 >> endobj\n',
    '3 0 obj << /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Resources << /Font << /F1 4 0 R >> >> /Contents 5 0 R >> endobj\n',
    '4 0 obj << /Type /Font /Subtype /Type1 /BaseFont /Helvetica >> endobj\n',
    '5 0 obj << /Length ${ascii.encode(stream).length} >> stream\n$stream\nendstream endobj\n',
  ];
  final buffer = StringBuffer('%PDF-1.4\n');
  final offsets = <int>[0];
  var length = ascii.encode(buffer.toString()).length;
  for (final object in objects) {
    offsets.add(length);
    buffer.write(object);
    length += ascii.encode(object).length;
  }
  final xrefOffset = length;
  buffer.write('xref\n0 ${objects.length + 1}\n');
  buffer.write('0000000000 65535 f \n');
  for (final offset in offsets.skip(1)) {
    buffer.write('${offset.toString().padLeft(10, '0')} 00000 n \n');
  }
  buffer.write(
    'trailer << /Size ${objects.length + 1} /Root 1 0 R >>\nstartxref\n$xrefOffset\n%%EOF\n',
  );
  return ascii.encode(buffer.toString());
}
