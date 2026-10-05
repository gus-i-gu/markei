import 'package:flutter/services.dart';

/// Inserts separators without changing the digits or validating a calendar date.
/// Calendar/time validity remains the purchase-occurrence parser's responsibility.
class PurchaseDigitsFormatter extends TextInputFormatter {
  const PurchaseDigitsFormatter.date()
    : groups = const [2, 2, 4],
      separator = '/';

  const PurchaseDigitsFormatter.time() : groups = const [2, 2], separator = ':';

  final List<int> groups;
  final String separator;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!newValue.composing.isCollapsed) return newValue;
    final maxDigits = groups.fold<int>(0, (sum, group) => sum + group);
    var digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length > maxDigits) digits = digits.substring(0, maxDigits);
    final cursor = newValue.selection.extentOffset.clamp(
      0,
      newValue.text.length,
    );
    var digitsBeforeCursor = newValue.text
        .substring(0, cursor)
        .replaceAll(RegExp(r'[^0-9]'), '')
        .length
        .clamp(0, digits.length);

    // Backspace over an automatically inserted separator also deletes its digit.
    if (oldValue.selection.isCollapsed &&
        newValue.selection.isCollapsed &&
        oldValue.text.length == newValue.text.length + 1 &&
        oldValue.selection.extentOffset > 0 &&
        oldValue.text[oldValue.selection.extentOffset - 1] == separator &&
        digits == oldValue.text.replaceAll(RegExp(r'[^0-9]'), '') &&
        digitsBeforeCursor > 0) {
      final index = digitsBeforeCursor - 1;
      digits = digits.substring(0, index) + digits.substring(index + 1);
      digitsBeforeCursor--;
    }

    final output = StringBuffer();
    var boundary = groups.first;
    var groupIndex = 0;
    var formattedCursor = 0;
    for (var i = 0; i < digits.length; i++) {
      output.write(digits[i]);
      if (i < digitsBeforeCursor) formattedCursor = output.length;
      if (i + 1 == boundary && groupIndex < groups.length - 1) {
        output.write(separator);
        if (i < digitsBeforeCursor) formattedCursor = output.length;
        boundary += groups[++groupIndex];
      }
    }
    return TextEditingValue(
      text: output.toString(),
      selection: TextSelection.collapsed(offset: formattedCursor),
    );
  }
}
