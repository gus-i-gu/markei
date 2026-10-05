import 'package:flutter/material.dart';
import '../../l10n/marc_localizations.dart';

import '../../domain/shared/quantity.dart';

/// Shows familiar symbols while storing the existing canonical unit spelling.
class QuantityUnitPicker extends StatelessWidget {
  const QuantityUnitPicker({
    required this.value,
    required this.onChanged,
    this.kind,
    this.decoration = const InputDecoration(labelText: 'Unit'),
    super.key,
  });

  final String value;
  final ValueChanged<String>? onChanged;
  final MeasurementKind? kind;
  final InputDecoration decoration;

  static const units = <String, String>{
    'mL': 'millilitres',
    'mg': 'milligrams',
    'g': 'grams',
    'L': 'litres',
    'kg': 'kilograms',
    'un': 'individual units',
  };

  @override
  Widget build(BuildContext context) {
    final choices = units.entries
        .where(
          (unit) =>
              kind == null || measurementKindForDisplayUnit(unit.key) == kind,
        )
        .toList();
    return InputDecorator(
      decoration: decoration
          .copyWith(enabled: onChanged != null)
          .localized(context),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: displayQuantityUnit(value),
          isExpanded: true,
          isDense: true,
          items: [
            for (final unit in choices)
              DropdownMenuItem(
                value: unit.key,
                child: Text('${unit.key} — ${context.tr(unit.value)}'),
              ),
          ],
          selectedItemBuilder: (context) => [
            for (final unit in choices) Text(unit.key),
          ],
          onChanged: onChanged == null
              ? null
              : (unit) {
                  if (unit != null) onChanged!(unit);
                },
        ),
      ),
    );
  }
}

String displayQuantityUnit(String unit) => switch (unit.toLowerCase()) {
  'ml' => 'mL',
  'l' => 'L',
  'unit' => 'un',
  _ => unit,
};
