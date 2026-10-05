import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/shared/quantity.dart';

void main() {
  test(
    'mg, g and kg normalize to the same canonical mass without truncation',
    () {
      for (final entry in {'mg': '500000', 'g': '500', 'kg': '0.5'}.entries) {
        final quantity = normalizeDisplayQuantity(
          kind: MeasurementKind.mass,
          amount: entry.value,
          unit: entry.key,
        );
        expect(quantity.unit, CanonicalUnit.kg);
        expect(quantity.microunits, 500000);
      }
      expect(
        normalizeDisplayQuantity(
          kind: MeasurementKind.mass,
          amount: '1',
          unit: 'mg',
        ).microunits,
        1,
      );
      expect(
        normalizeDisplayQuantity(
          kind: MeasurementKind.volume,
          amount: '1500',
          unit: 'mL',
        ).microunits,
        1500000,
      );
      for (final unit in ['mg', 'g', 'mL']) {
        expect(
          () => normalizeDisplayQuantity(
            kind: measurementKindForDisplayUnit(unit),
            amount: '0.000001',
            unit: unit,
          ),
          throwsArgumentError,
        );
      }
      expect(
        () => parseDisplayDecimalMicrounits('999999999999999999999'),
        throwsArgumentError,
      );
    },
  );
  test(
    'display quantity accepts comma or point and rejects mixed separators',
    () {
      final comma = normalizeDisplayQuantity(
        kind: MeasurementKind.volume,
        amount: '1,5',
        unit: 'L',
      );
      final point = normalizeDisplayQuantity(
        kind: MeasurementKind.volume,
        amount: '1.5',
        unit: 'L',
      );

      expect(comma.microunits, point.microunits);
      expect(comma.unit, CanonicalUnit.l);
      expect(
        () => normalizeDisplayQuantity(
          kind: MeasurementKind.mass,
          amount: '1,000.5',
          unit: 'kg',
        ),
        throwsArgumentError,
      );
    },
  );

  test('count unit accepts un but not fractional COUNT', () {
    final units = normalizeDisplayQuantity(
      kind: MeasurementKind.count,
      amount: '2',
      unit: 'un',
    );

    expect(units.unit, CanonicalUnit.unit);
    expect(
      () => normalizeDisplayQuantity(
        kind: MeasurementKind.count,
        amount: '2,5',
        unit: 'un',
      ),
      throwsArgumentError,
    );
  });
}
