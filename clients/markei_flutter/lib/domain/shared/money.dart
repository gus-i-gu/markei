final class Money {
  const Money({required this.currencyCode, required this.minorUnits})
    : assert(currencyCode.length == 3);

  final String currencyCode;
  final int minorUnits;

  Map<String, Object?> toJson() => {
    'currencyCode': currencyCode,
    'minorUnits': minorUnits,
  };
}
