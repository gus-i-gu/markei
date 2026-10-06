import 'dart:convert';
import '../l10n/marc_messages.dart';
import '../l10n/analytics_copy.dart';

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

String analyticsRecordCsv(
  AnalyticsRecord record,
  AnalyticsDataset dataset, {
  MarcMessages messages = MarcMessages.english,
}) {
  final rows = <List<String>>[
    ['record_fingerprint', record.fingerprint],
    ['record_created_utc', record.executedAtUtc.toUtc().toIso8601String()],
    ['registry', '${record.registryIdentifier}@${record.registryVersion}'],
    ['group_by', record.draft.determinant.name],
    ['analytics_01', record.draft.analytics01.kind?.name ?? 'none'],
    ['analytics_02', record.draft.analytics02.kind?.name ?? 'none'],
    ['operation', record.draft.operation.name],
    ['timeframe', record.draft.timeframe.label],
    ['eligible_count', record.eligibleCount.toString()],
    ['total_count', record.totalCount.toString()],
    ['excluded_count', record.excludedCount.toString()],
    [
      'raw_evidence_snapshot',
      messages.display(
        record.evidenceRows.isEmpty
            ? 'Raw evidence snapshot unavailable for this older record; saved results are preserved.'
            : 'Frozen evidence snapshot',
      ),
    ],
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
      entry.groupKey.contextLabel,
      entry.measure.name,
      entry.operation.name,
      analyticsDisplayValue(entry.measure, entry.value).value,
      analyticsDisplayValue(entry.measure, entry.value).unit,
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
      'date_time_of_purchase',
      'product_code',
      'product_name',
      'product_brand',
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
  final evidence = record.evidenceRows;
  for (final row in evidence.where(
    (row) => contributing.contains(row.id.value),
  )) {
    rows.add([
      _formatLocal(row.purchaseOccurrenceTime),
      row.productCode,
      row.productName,
      row.productBrand.isEmpty
          ? messages.display('Unavailable')
          : row.productBrand,
      row.storeName,
      row.purchasedByLabel ?? messages.display('Not assigned'),
      messages.display('Unavailable in recorded data'),
      row.paymentMethodLabel ?? messages.display('Not assigned'),
      row.quantity.decimalText,
      row.quantity.unit.name,
      row.unitPrice == null
          ? messages.display('Unavailable')
          : '${_minorUnits(row.unitPrice!.minorUnitsPerCanonicalUnit)} ${row.unitPrice!.currencyCode} per ${row.unitPrice!.unit.name}',
      '${_minorUnits(row.lineTotal.minorUnits)} ${row.lineTotal.currencyCode}',
      messages.display('Unavailable in recorded data'),
    ]);
  }
  return rows.map((row) => row.map(_csvCell).join(',')).join('\r\n');
}

List<int> analyticsRecordPdfBytes(
  AnalyticsRecord record, {
  MarcMessages messages = MarcMessages.english,
}) {
  final text = StringBuffer()
    ..writeln(messages.display('Marc Analytics record'))
    ..writeln()
    ..writeln(messages.message('Record #{p0}', [record.fingerprint]))
    ..writeln(
      messages.message('Created UTC: {p0}', [
        record.executedAtUtc.toUtc().toIso8601String(),
      ]),
    )
    ..writeln(
      messages.message('Registry: {p0}@{p1}', [
        record.registryIdentifier,
        record.registryVersion,
      ]),
    )
    ..writeln(
      messages.message('Group by: {p0}', [
        messages.language == 'en'
            ? record.draft.determinant.name
            : messages.enumLabel(record.draft.determinant.name),
      ]),
    )
    ..writeln(
      messages.message('Operation: {p0}', [
        messages.language == 'en'
            ? record.draft.operation.name
            : messages.enumLabel(record.draft.operation.name),
      ]),
    )
    ..writeln(
      messages.message('Timeframe: {p0}', [
        messages.display(record.draft.timeframe.label),
      ]),
    )
    ..writeln(
      messages.message('Evidence: {p0}/{p1}; excluded {p2}', [
        record.eligibleCount,
        record.totalCount,
        record.excludedCount,
      ]),
    )
    ..writeln()
    ..writeln(localizedAnalyticsInterpretation(record, messages));
  return _simplePdf(text.toString(), record, messages);
}

String _csvCell(String value) {
  final mustQuote =
      value.contains(',') || value.contains('"') || value.contains('\n');
  final escaped = value.replaceAll('"', '""');
  return mustQuote ? '"$escaped"' : escaped;
}

String _minorUnits(int value) {
  final sign = value < 0 ? '-' : '';
  final abs = value.abs();
  final whole = abs ~/ 100;
  final cents = (abs % 100).toString().padLeft(2, '0');
  return '$sign$whole.$cents';
}

String _formatLocal(DateTime value) {
  final local = value.toLocal();
  return '${local.day.toString().padLeft(2, '0')}-${local.month.toString().padLeft(2, '0')}-${local.year.toString().padLeft(4, '0')} ${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
}

// The report and chart use the same immutable record as the screen and CSV.
// WinAnsi covers the Latin text used by the EN/PT interface and product labels.
String _pdfLiteral(String value) {
  final out = StringBuffer();
  for (final rune in value.runes) {
    if (rune == 40 || rune == 41 || rune == 92) {
      out.write('\\${String.fromCharCode(rune)}');
    } else if (rune >= 32 && rune <= 126) {
      out.writeCharCode(rune);
    } else if (rune >= 160 && rune <= 255) {
      out.write('\\${rune.toRadixString(8).padLeft(3, '0')}');
    } else {
      out.write('?');
    }
  }
  return out.toString();
}

List<String> _pdfWrap(String value, int width) {
  if (value.isEmpty) return [''];
  final result = <String>[];
  var rest = value;
  while (rest.length > width) {
    var end = rest.lastIndexOf(' ', width);
    if (end < width ~/ 2) end = width;
    result.add(rest.substring(0, end));
    rest = rest.substring(end).trimLeft();
  }
  if (rest.isNotEmpty) result.add(rest);
  return result;
}

String _pdfText(String value, num x, num y, {num size = 10}) =>
    'BT /F1 $size Tf $x $y Td (${_pdfLiteral(value)}) Tj ET\n';

List<int> _simplePdf(
  String text,
  AnalyticsRecord record,
  MarcMessages messages,
) {
  final lines = text
      .replaceAll('\r', '')
      .split('\n')
      .expand((line) => _pdfWrap(line, 90))
      .toList();
  final streams = <String>[];
  var stream = StringBuffer();
  var y = 750.0;
  void finishPage() {
    stream.write(
      _pdfText(
        messages.message('Marc · Record {p0} · Page {p1}', [
          record.fingerprint,
          streams.length + 1,
        ]),
        40,
        25,
        size: 8,
      ),
    );
    streams.add(stream.toString());
    stream = StringBuffer();
    y = 750;
  }

  for (final line in lines) {
    if (y < 60) finishPage();
    stream.write(_pdfText(line, 40, y));
    y -= 14;
  }
  void tableHeading() {
    if (y < 140) finishPage();
    y -= 16;
    stream.write(_pdfText(messages.display('Results table'), 40, y, size: 12));
    y -= 30;
    stream.write('0.94 0.96 0.95 rg 40 ${y - 7} 532 23 re f\n0 0 0 rg\n');
    for (final cell in [
      ('Row', 40),
      ('Comparison / statistic', 113),
      ('Value', 355),
      ('Unit', 435),
      ('n / excluded', 522),
    ]) {
      stream.write(_pdfText(messages.display(cell.$1), cell.$2, y, size: 8));
    }
    y -= 22;
  }

  tableHeading();
  for (final entry in record.entries) {
    final display = analyticsDisplayValue(entry.measure, entry.value);
    final cells = [
      _pdfWrap(entry.groupKey.determinantLabel, 12),
      [
        ..._pdfWrap(entry.groupKey.contextLabel, 43),
        ..._pdfWrap(
          '${messages.language == 'en' ? entry.measure.name : messages.enumLabel(entry.measure.name)} / ${messages.language == 'en' ? entry.operation.name : messages.enumLabel(entry.operation.name)}',
          43,
        ),
      ],
      _pdfWrap(messages.numericCopy(display.value), 14),
      _pdfWrap(messages.display(display.unit), 16),
      _pdfWrap('${entry.eligibleCount} / ${entry.excludedCount}', 10),
    ];
    final maxLines = cells.fold<int>(
      1,
      (n, cell) => cell.length > n ? cell.length : n,
    );
    for (var start = 0; start < maxLines; start += 36) {
      final count = (maxLines - start).clamp(1, 36);
      final height = count * 12 + 16;
      if (y - height < 50) {
        finishPage();
        tableHeading();
      }
      final positions = [40, 113, 355, 435, 522];
      for (var column = 0; column < cells.length; column++) {
        final content = cells[column].skip(start).take(count).toList();
        for (var line = 0; line < content.length; line++) {
          stream.write(
            _pdfText(content[line], positions[column], y - line * 12, size: 8),
          );
        }
      }
      y -= height;
      stream.write('0.85 0.88 0.86 RG 40 ${y + 7} m 572 ${y + 7} l S\n');
    }
  }
  finishPage();
  final plotted = record.entries
      .where((entry) => entry.value is AnalyticsIntegerResultValue)
      .toList();
  final compatible =
      plotted.map((entry) => entry.compatibilityKey.value).toSet().length == 1;
  if (compatible) {
    final maxAbs = plotted.fold<int>(1, (max, entry) {
      final value = (entry.value as AnalyticsIntegerResultValue).value.abs();
      return value > max ? value : max;
    });
    final series = plotted
        .map((entry) => entry.groupKey.contextLabel)
        .toSet()
        .toList();
    const colors = [
      '0.40 0.33 0.70',
      '0.25 0.44 0.56',
      '0.06 0.31 0.16',
      '0.61 0.33 0.09',
    ];
    for (var start = 0; start < plotted.length; start += 9) {
      final stream = StringBuffer(
        _pdfText(
          messages.message('Marc · Comparison chart · {p0}', [
            record.fingerprint,
          ]),
          40,
          750,
          size: 14,
        ),
      );
      final signed = plotted.any(
        (entry) => (entry.value as AnalyticsIntegerResultValue).value < 0,
      );
      final zero = signed ? 310 : 55;
      final scale = signed ? 220 : 480;
      var y = 690;
      for (final entry in plotted.skip(start).take(9)) {
        final amount = (entry.value as AnalyticsIntegerResultValue).value;
        final width = amount.abs() / maxAbs * scale;
        final x = amount < 0 ? zero - width : zero;
        final display = analyticsDisplayValue(entry.measure, entry.value);
        final label =
            '${entry.groupKey.determinantLabel} · ${entry.groupKey.contextLabel}';
        for (final (index, line) in _pdfWrap(label, 100).indexed) {
          stream.write(_pdfText(line, 40, y + 17 + index * 10, size: 8));
        }
        stream.write('0.7 0.7 0.7 RG $zero ${y - 3} m $zero ${y + 12} l S\n');
        stream.write(
          '${colors[series.indexOf(entry.groupKey.contextLabel) % colors.length]} rg $x $y $width 10 re f\n0 0 0 rg\n',
        );
        stream.write(
          _pdfText(
            '${messages.numericCopy(display.value)} ${display.unit}',
            40,
            y - 15,
            size: 9,
          ),
        );
        y -= 70;
      }
      stream.write(
        _pdfText(
          messages.message(
            'Same scale on all chart pages. Evidence {p0}/{p1}.',
            [record.eligibleCount, record.totalCount],
          ),
          40,
          25,
          size: 8,
        ),
      );
      streams.add(stream.toString());
    }
  }
  final objects = <String>[
    '<< /Type /Catalog /Pages 2 0 R >>',
    '<< /Type /Pages /Kids [${[for (var i = 0; i < streams.length; i++) '${4 + i * 2} 0 R'].join(' ')}] /Count ${streams.length} >>',
    '<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica /Encoding /WinAnsiEncoding >>',
  ];
  for (var i = 0; i < streams.length; i++) {
    objects.add(
      '<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Resources << /Font << /F1 3 0 R >> >> /Contents ${5 + i * 2} 0 R >>',
    );
    objects.add(
      '<< /Length ${ascii.encode(streams[i]).length} >> stream\n${streams[i]}\nendstream',
    );
  }
  final buffer = StringBuffer('%PDF-1.4\n');
  final offsets = <int>[0];
  for (var i = 0; i < objects.length; i++) {
    offsets.add(ascii.encode(buffer.toString()).length);
    buffer.write('${i + 1} 0 obj ${objects[i]} endobj\n');
  }
  final xref = ascii.encode(buffer.toString()).length;
  buffer.write('xref\n0 ${objects.length + 1}\n0000000000 65535 f \n');
  for (final offset in offsets.skip(1)) {
    buffer.write('${offset.toString().padLeft(10, '0')} 00000 n \n');
  }
  buffer.write(
    'trailer << /Size ${objects.length + 1} /Root 1 0 R >>\nstartxref\n$xref\n%%EOF\n',
  );
  return ascii.encode(buffer.toString());
}
