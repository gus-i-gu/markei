enum MeasurementKind { mass, volume, count }

enum CanonicalUnit { kg, l, unit }

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
    final parsed = _parseDecimalMicrounits(decimal);
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
  final rawMicros = _parseDecimalMicrounits(amount);
  return switch (kind) {
    MeasurementKind.mass when rawUnit == 'g' => NormalizedQuantity(
      kind: kind,
      unit: CanonicalUnit.kg,
      microunits: rawMicros ~/ 1000,
    ),
    MeasurementKind.mass when rawUnit == 'kg' => NormalizedQuantity(
      kind: kind,
      unit: CanonicalUnit.kg,
      microunits: rawMicros,
    ),
    MeasurementKind.volume when rawUnit == 'ml' => NormalizedQuantity(
      kind: kind,
      unit: CanonicalUnit.l,
      microunits: rawMicros ~/ 1000,
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

int _parseDecimalMicrounits(String decimal) {
  final trimmed = decimal.trim();
  final match = RegExp(r'^(\d+)(?:\.(\d{1,6}))?$').firstMatch(trimmed);
  if (match == null) {
    throw ArgumentError('Invalid fixed decimal quantity: $decimal');
  }
  final whole = int.parse(match.group(1)!);
  final fraction = (match.group(2) ?? '').padRight(
    NormalizedQuantity.scale,
    '0',
  );
  return whole * NormalizedQuantity.factor + int.parse(fraction);
}
