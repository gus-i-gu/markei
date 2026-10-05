import '../domain/shared/quantity.dart';
import 'purchase_pricing.dart';

int bulkLineTotalMinorUnits({
  required MeasurementKind kind,
  required String amount,
  required String amountUnit,
  required String pricePerSelectedUnit,
}) {
  final unit = amountUnit.trim().toLowerCase();
  _amountMicrosForSelectedUnit(kind: kind, amount: amount, unit: unit);
  return purchaseLineTotalMinorUnits(
    amount: amount,
    unitPrice: pricePerSelectedUnit,
  );
}

int _amountMicrosForSelectedUnit({
  required MeasurementKind kind,
  required String amount,
  required String unit,
}) {
  if (kind == MeasurementKind.mass &&
      (unit == 'kg' || unit == 'g' || unit == 'mg')) {
    return parseDisplayDecimalMicrounits(amount);
  }
  if (kind == MeasurementKind.volume && (unit == 'l' || unit == 'ml')) {
    return parseDisplayDecimalMicrounits(amount);
  }
  if (kind == MeasurementKind.count && (unit == 'un' || unit == 'unit')) {
    return parseDisplayDecimalMicrounits(amount);
  }
  throw ArgumentError('Price unit must match the selected amount unit.');
}
