import '../domain/shared/quantity.dart';

/// The field last edited by the user remains authoritative when quantity changes.
enum PurchasePriceSource { unitPrice, totalPrice }

int purchaseLineTotalMinorUnits({
  required String amount,
  required String unitPrice,
}) {
  final quantity = _positiveAmount(amount);
  final rate = BigInt.from(parseDisplayDecimalMicrounits(unitPrice));
  final divisor = BigInt.from(NormalizedQuantity.factor).pow(2);
  return _checkedMoney(
    _roundHalfUp(quantity * rate * BigInt.from(100), divisor),
  );
}

String purchaseUnitPriceText({
  required String amount,
  required int totalMinorUnits,
}) {
  if (totalMinorUnits < 0) {
    throw const FormatException('Price cannot be negative.');
  }
  final quantity = _positiveAmount(amount);
  final rate = _roundHalfUp(
    BigInt.from(totalMinorUnits) *
        BigInt.from(NormalizedQuantity.factor).pow(2),
    quantity * BigInt.from(100),
  );
  final factor = BigInt.from(NormalizedQuantity.factor);
  final fraction = (rate % factor).toString().padLeft(6, '0');
  final trimmed = fraction.replaceFirst(RegExp(r'0+$'), '');
  return '${rate ~/ factor}.${trimmed.padRight(2, '0')}';
}

int parsePurchaseTotalMinorUnits(String value) {
  final normalized = value.trim().replaceAll(',', '.');
  final match = RegExp(r'^(\d+)(?:\.(\d{1,2}))?$').firstMatch(normalized);
  if (match == null) {
    throw const FormatException('Enter a total price with up to two decimals.');
  }
  return _checkedMoney(
    BigInt.parse(match.group(1)!) * BigInt.from(100) +
        BigInt.parse((match.group(2) ?? '').padRight(2, '0')),
  );
}

String formatPurchaseTotal(int minorUnits) =>
    '${minorUnits ~/ 100}.${(minorUnits % 100).toString().padLeft(2, '0')}';

BigInt _positiveAmount(String amount) {
  final quantity = parseDisplayDecimalMicrounits(amount);
  if (quantity <= 0) {
    throw const FormatException('Enter a quantity greater than zero.');
  }
  return BigInt.from(quantity);
}

BigInt _roundHalfUp(BigInt numerator, BigInt denominator) =>
    (numerator + denominator ~/ BigInt.two) ~/ denominator;

int _checkedMoney(BigInt value) {
  if (value < BigInt.zero || value > BigInt.from(0x7fffffffffffffff)) {
    throw const FormatException('Price is outside the supported range.');
  }
  return value.toInt();
}
