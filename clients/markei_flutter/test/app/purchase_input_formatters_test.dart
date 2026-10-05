import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/widgets/purchase_input_formatters.dart';
import 'package:markei/application/purchase_occurrence.dart';

TextEditingValue value(String text, [int? cursor]) => TextEditingValue(
  text: text,
  selection: TextSelection.collapsed(offset: cursor ?? text.length),
);

void main() {
  const date = PurchaseDigitsFormatter.date();
  const time = PurchaseDigitsFormatter.time();
  test(
    'digits, paste and already separated input produce date/time separators',
    () {
      expect(date.formatEditUpdate(value(''), value('05')).text, '05/');
      expect(
        date.formatEditUpdate(value(''), value('05102026')).text,
        '05/10/2026',
      );
      expect(
        date.formatEditUpdate(value(''), value('05/10/2026')).text,
        '05/10/2026',
      );
      expect(
        date.formatEditUpdate(value(''), value('051020269')).text,
        '05/10/2026',
      );
      expect(time.formatEditUpdate(value(''), value('09')).text, '09:');
      expect(time.formatEditUpdate(value(''), value('0930')).text, '09:30');
    },
  );
  test('backspace past a generated separator does not trap the cursor', () {
    final output = date.formatEditUpdate(value('05/'), value('05'));
    expect(output.text, '0');
    expect(output.selection.extentOffset, 1);
    final middle = date.formatEditUpdate(
      value('05/10/2026', 1),
      value('15/10/2026', 1),
    );
    expect(middle.text, '15/10/2026');
    expect(middle.selection.extentOffset, 1);
  });
  test(
    'composition is preserved and formatting does not accept invalid dates',
    () {
      final composing = value(
        '123',
      ).copyWith(composing: const TextRange(start: 0, end: 3));
      expect(date.formatEditUpdate(value(''), composing), composing);
      final invalid = date.formatEditUpdate(value(''), value('31022026'));
      expect(invalid.text, '31/02/2026');
      expect(
        () => parsePurchaseOccurrenceUtc(
          PurchaseOccurrenceInput(dateText: invalid.text, timeText: '09:30'),
        ),
        throwsFormatException,
      );
    },
  );
}
