import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/purchase_pricing.dart';

void main() {
  test(
    'package and bulk totals use exact decimals and round half up to cents',
    () {
      expect(purchaseLineTotalMinorUnits(amount: '2', unitPrice: '11'), 2200);
      expect(purchaseLineTotalMinorUnits(amount: '2,5', unitPrice: '10'), 2500);
      expect(purchaseLineTotalMinorUnits(amount: '1', unitPrice: '0.005'), 1);
      expect(purchaseLineTotalMinorUnits(amount: '0.25', unitPrice: '0.03'), 1);
      expect(purchaseLineTotalMinorUnits(amount: '2', unitPrice: '0'), 0);
    },
  );

  test(
    'total price derives rates without rounding repeating rates to cents',
    () {
      expect(
        purchaseUnitPriceText(amount: '2', totalMinorUnits: 2000),
        '10.00',
      );
      expect(
        purchaseUnitPriceText(amount: '3', totalMinorUnits: 1000),
        '3.333333',
      );
      expect(
        purchaseUnitPriceText(amount: '0.000001', totalMinorUnits: 100),
        '1000000.00',
      );
      expect(parsePurchaseTotalMinorUnits('22,50'), 2250);
      expect(formatPurchaseTotal(2250), '22.50');
    },
  );

  test(
    'rejects invalid quantities and ambiguous or excessive money precision',
    () {
      for (final value in ['0', '-2', '1,000.5', '99999999999999999999999']) {
        expect(
          () => purchaseLineTotalMinorUnits(amount: value, unitPrice: '10'),
          throwsA(anything),
        );
      }
      for (final value in [
        '-1',
        '2.999',
        '1,000.00',
        '99999999999999999999999',
      ]) {
        expect(
          () => parsePurchaseTotalMinorUnits(value),
          throwsFormatException,
        );
      }
      expect(
        () => purchaseLineTotalMinorUnits(
          amount: '9000000000000',
          unitPrice: '9000000000000',
        ),
        throwsFormatException,
      );
    },
  );
}
