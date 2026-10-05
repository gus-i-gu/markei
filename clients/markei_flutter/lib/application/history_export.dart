import 'dart:convert';
import '../l10n/marc_messages.dart';

import '../domain/shared/ids.dart';
import 'purchase_history.dart';

final class PurchaseExportBundle {
  const PurchaseExportBundle({required this.purchases});

  final List<PurchaseDetail> purchases;
}

abstract interface class PurchaseExportRepository {
  Future<PurchaseExportBundle> exportBundle(
    AccountId accountId,
    Set<PurchaseId> purchaseIds,
  );
}

String purchaseBundleCsv(
  PurchaseExportBundle bundle, {
  MarcMessages messages = MarcMessages.english,
}) {
  final rows = <List<String>>[
    [
      'purchase_id',
      'occurrence_time',
      'store',
      'person',
      'payment_method',
      'currency',
      'purchase_total_minor_units',
      'product_code',
      'product_name',
      'product_brand',
      'package_count',
      'amount',
      'unit',
      'line_total_minor_units',
    ],
  ];
  for (final detail in bundle.purchases) {
    for (final item in detail.items) {
      rows.add([
        detail.entry.purchaseId.value,
        detail.entry.occurrenceTime.toUtc().toIso8601String(),
        detail.entry.storeName,
        detail.entry.personLabel ?? messages.display('Not assigned'),
        detail.entry.paymentMethodLabel ?? messages.display('Not assigned'),
        detail.entry.currencyCode,
        detail.entry.totalMinorUnits.toString(),
        item.productCode,
        item.productName,
        item.productBrand,
        item.packageCount?.toString() ?? messages.display('Not assigned'),
        item.purchasedAmount,
        item.purchasedUnit,
        item.lineTotalMinorUnits.toString(),
      ]);
    }
  }
  return rows.map((row) => row.map(_csvCell).join(',')).join('\r\n');
}

List<int> purchaseBundlePdfBytes(
  PurchaseExportBundle bundle, {
  MarcMessages messages = MarcMessages.english,
}) {
  final text = StringBuffer(
    messages.display('Markei selected purchase list\n\n'),
  );
  for (final detail in bundle.purchases) {
    text.writeln(
      '${detail.entry.storeName} - ${detail.entry.occurrenceTime.toLocal()} - ${detail.entry.currencyCode} ${messages.numericCopy((detail.entry.totalMinorUnits / 100).toStringAsFixed(2))}',
    );
    text.writeln(
      messages.message('Person: {p0}', [
        detail.entry.personLabel ?? messages.display('Not assigned'),
      ]),
    );
    text.writeln(
      messages.message('Payment Method: {p0}', [
        detail.entry.paymentMethodLabel ?? messages.display('Not assigned'),
      ]),
    );
    for (final item in detail.items) {
      text.writeln(
        '- ${item.productCode} ${item.productName}: ${item.purchasedAmount} ${item.purchasedUnit} ${item.currencyCode} ${messages.numericCopy((item.lineTotalMinorUnits / 100).toStringAsFixed(2))}',
      );
    }
    text.writeln();
  }
  return _simplePdf(text.toString());
}

String _csvCell(String value) {
  final mustQuote =
      value.contains(',') || value.contains('"') || value.contains('\n');
  final escaped = value.replaceAll('"', '""');
  return mustQuote ? '"$escaped"' : escaped;
}

List<int> _simplePdf(String text) {
  final escaped = text
      .replaceAll('\r', '')
      .split('\n')
      .map((line) => '(${_pdfLiteral(line)}) Tj T*')
      .join('\n');
  final stream = 'BT /F1 10 Tf 40 780 Td 14 TL\n$escaped\nET';
  final objects = <String>[
    '1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj\n',
    '2 0 obj << /Type /Pages /Kids [3 0 R] /Count 1 >> endobj\n',
    '3 0 obj << /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Resources << /Font << /F1 4 0 R >> >> /Contents 5 0 R >> endobj\n',
    '4 0 obj << /Type /Font /Subtype /Type1 /BaseFont /Helvetica /Encoding /WinAnsiEncoding >> endobj\n',
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

String _pdfLiteral(String value) {
  final buffer = StringBuffer();
  for (final rune in value.runes) {
    if (rune == 40 || rune == 41 || rune == 92) {
      buffer.write('\\${String.fromCharCode(rune)}');
    } else if (rune >= 32 && rune <= 126) {
      buffer.writeCharCode(rune);
    } else if (rune >= 160 && rune <= 255) {
      buffer.write('\\${rune.toRadixString(8).padLeft(3, '0')}');
    } else {
      buffer.write('?');
    }
  }
  return buffer.toString();
}
