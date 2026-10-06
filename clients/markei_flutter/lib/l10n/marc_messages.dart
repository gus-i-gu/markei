import 'messages.g.dart';

/// Presentation-only copy. Unknown values and placeholder values are preserved.
/// Neither model values nor user-entered text is translated here.
final class MarcMessages {
  const MarcMessages(this.language);
  final String language;
  static const english = MarcMessages('en');
  String enumLabel(String code) => display(
    const {
          'sum': 'Sum',
          'mean': 'Mean',
          'difference': 'Difference',
          'percentage': 'Percentage',
          'quantity': 'Quantity',
          'unitPrice': 'Unit price',
          'lineTotal': 'Price paid',
          'pricePaid': 'Price paid',
          'purchaseTotal': 'Purchase total',
          'purchasedBy': 'Purchased by',
          'purchasedFor': 'Purchased for',
          'paymentMethod': 'Payment Method',
          'evidenceCount': 'Evidence count',
          'product': 'Product',
          'purchase': 'Purchase',
          'store': 'Store',
          'timeDayUtc': 'UTC day',
          'timeMonthUtc': 'UTC month',
        }[code] ??
        code,
  );

  /// Display decimals only in numeric presentation fields; never parse or store
  /// this result as a model value. Both comma and dot inputs remain supported.
  String numericCopy(String text) {
    if (language == 'en') return text;
    if (RegExp(
      r'^-?\d+\.\d+(%| (mg|g|kg|mL|ml|L|l|un|unit))?$',
    ).hasMatch(text)) {
      return text.replaceAll('.', ',');
    }
    return text.replaceAllMapped(
      RegExp(r'\b(BRL|USD|EUR) (-?\d+)\.(\d+)'),
      (m) => '${m[1]} ${m[2]},${m[3]}',
    );
  }

  Map<String, String> get _messages => switch (language) {
    'pt' || 'pt_BR' => messagesPt,
    'es' => messagesEs,
    _ => messagesEn,
  };

  /// Use an explicit English template for messages containing user data.
  String message(String source, [List<Object?> arguments = const []]) {
    final translated = _messages[source] ?? source;
    return translated.replaceAllMapped(RegExp(r'\{p(\d+)\}'), (match) {
      final index = int.parse(match[1]!);
      return index < arguments.length ? '${arguments[index] ?? ''}' : match[0]!;
    });
  }

  /// Compatibility boundary for existing application status messages.
  /// Only anchored, catalogued templates with literal text may match.
  /// New messages should use [message] with explicit arguments.
  String display(String source) {
    if (language == 'en') return source;
    final exact = _messages[source];
    if (exact != null) return exact;
    for (final template in _templates) {
      final match = template.pattern.firstMatch(source);
      if (match == null) continue;
      final values = <Object?>[];
      for (var i = 1; i <= match.groupCount; i++) {
        final value = match[i] ?? '';
        final knownCopy =
            (const {
              '{p0} is unavailable for {p1}.',
              'Operation: {p0}',
            }.contains(template.source)) ||
            (const {
                  '{p0} Local status refreshed.',
                  'Group by: {p0}',
                  'No {p0} saved for this Account.',
                }.contains(template.source) &&
                i == 1) ||
            (template.source == '{p0}: {p1} The draft is still available.' &&
                i == 2);
        values.add(knownCopy ? display(value) : value);
      }
      return message(template.source, values);
    }
    return source;
  }

  static final _templates = _buildTemplates();
  static List<_MessageTemplate> _buildTemplates() {
    final candidates =
        messagesEn.keys
            .where((text) => text.contains('{p0}'))
            .where(
              (text) => RegExp(
                r'[A-Za-z]',
              ).hasMatch(text.replaceAll(RegExp(r'\{p\d+\}'), '')),
            )
            .toList()
          ..sort((a, b) {
            // Specific prefixes must beat generic suffixes such as unavailable.
            final prefix = (a.startsWith('{p') ? 1 : 0).compareTo(
              b.startsWith('{p') ? 1 : 0,
            );
            return prefix != 0
                ? prefix
                : _literalLength(b).compareTo(_literalLength(a));
          });
    return [for (final source in candidates) _MessageTemplate(source)];
  }

  static int _literalLength(String source) =>
      source.replaceAll(RegExp(r'\{p\d+\}'), '').length;
}

final class _MessageTemplate {
  _MessageTemplate(this.source) : pattern = _pattern(source);
  final String source;
  final RegExp pattern;
  static RegExp _pattern(String source) {
    final buffer = StringBuffer('^');
    var end = 0;
    for (final placeholder in RegExp(r'\{p\d+\}').allMatches(source)) {
      buffer.write(RegExp.escape(source.substring(end, placeholder.start)));
      buffer.write('(.*?)');
      end = placeholder.end;
    }
    buffer.write(RegExp.escape(source.substring(end)));
    buffer.write(r'$');
    return RegExp(buffer.toString(), dotAll: true);
  }
}
