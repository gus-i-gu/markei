enum MeasurementKind { mass, volume, count }

enum CanonicalUnit { kg, l, unit }

enum DisplayUnit {
  kg('kg'),
  g('g'),
  mg('mg'),
  l('L'),
  ml('mL'),
  unit('un');

  const DisplayUnit(this.label);

  final String label;
}

final class NormalizedQuantity {
  const NormalizedQuantity({
    required this.kind,
    required this.unit,
    required this.microunits,
  });

  static const int scale = 6;
  static const int factor = 1000000;

  final MeasurementKind kind;
  final CanonicalUnit unit;
  final int microunits;

  factory NormalizedQuantity.fromDecimalString({
    required MeasurementKind kind,
    required CanonicalUnit unit,
    required String decimal,
  }) {
    final parsed = parseDisplayDecimalMicrounits(decimal);
    if (kind == MeasurementKind.count && parsed % factor != 0) {
      throw ArgumentError('Fractional COUNT is not accepted in this unit.');
    }
    return NormalizedQuantity(kind: kind, unit: unit, microunits: parsed);
  }

  String get decimalText {
    final whole = microunits ~/ factor;
    final fraction = (microunits % factor).abs().toString().padLeft(scale, '0');
    return '$whole.$fraction';
  }

  Map<String, Object?> toJson() => {
    'kind': kind.name.toUpperCase(),
    'unit': unit.name.toUpperCase(),
    'amount': decimalText,
    'scale': scale,
  };
}

NormalizedQuantity normalizeDisplayQuantity({
  required MeasurementKind kind,
  required String amount,
  required String unit,
}) {
  final rawUnit = unit.trim().toLowerCase();
  final rawMicros = parseDisplayDecimalMicrounits(amount);
  return switch (kind) {
    MeasurementKind.mass when rawUnit == 'g' => NormalizedQuantity(
      kind: kind,
      unit: CanonicalUnit.kg,
      microunits: _exactSubunitQuantity(rawMicros, 1000),
    ),
    MeasurementKind.mass when rawUnit == 'mg' => NormalizedQuantity(
      kind: kind,
      unit: CanonicalUnit.kg,
      microunits: _exactSubunitQuantity(rawMicros, 1000000),
    ),
    MeasurementKind.mass when rawUnit == 'kg' => NormalizedQuantity(
      kind: kind,
      unit: CanonicalUnit.kg,
      microunits: rawMicros,
    ),
    MeasurementKind.volume when rawUnit == 'ml' => NormalizedQuantity(
      kind: kind,
      unit: CanonicalUnit.l,
      microunits: _exactSubunitQuantity(rawMicros, 1000),
    ),
    MeasurementKind.volume when rawUnit == 'l' => NormalizedQuantity(
      kind: kind,
      unit: CanonicalUnit.l,
      microunits: rawMicros,
    ),
    MeasurementKind.count when rawUnit == 'unit' || rawUnit == 'un' =>
      NormalizedQuantity.fromDecimalString(
        kind: kind,
        unit: CanonicalUnit.unit,
        decimal: amount,
      ),
    _ => throw ArgumentError('Unsupported unit $unit for ${kind.name}.'),
  };
}

int _exactSubunitQuantity(int value, int divisor) {
  if (value % divisor != 0) {
    throw ArgumentError(
      'Quantity is too precise. Use whole mg, or at most three decimals for g/mL.',
    );
  }
  return value ~/ divisor;
}

MeasurementKind measurementKindForDisplayUnit(String unit) {
  return switch (unit.trim().toLowerCase()) {
    'mg' || 'g' || 'kg' => MeasurementKind.mass,
    'ml' || 'l' => MeasurementKind.volume,
    'un' || 'unit' => MeasurementKind.count,
    _ => throw ArgumentError('Use mL, mg, g, L, kg or un for the unit.'),
  };
}

int parseDisplayDecimalMicrounits(String decimal) {
  final trimmed = decimal.trim();
  if (trimmed.contains(',') && trimmed.contains('.')) {
    throw ArgumentError('Ambiguous decimal separator: $decimal');
  }
  final normalized = trimmed.replaceAll(',', '.');
  final match = RegExp(r'^(\d+)(?:\.(\d{1,6}))?$').firstMatch(normalized);
  if (match == null) {
    throw ArgumentError('Invalid fixed decimal quantity: $decimal');
  }
  final whole = BigInt.parse(match.group(1)!);
  final fraction = (match.group(2) ?? '').padRight(
    NormalizedQuantity.scale,
    '0',
  );
  final value =
      whole * BigInt.from(NormalizedQuantity.factor) + BigInt.parse(fraction);
  if (value > BigInt.from(0x7fffffffffffffff)) {
    throw ArgumentError('Quantity is outside the supported range.');
  }
  return value.toInt();
}
