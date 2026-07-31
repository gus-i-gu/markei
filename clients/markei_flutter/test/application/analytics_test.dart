import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/analytics.dart';
import 'package:markei/domain/shared/ids.dart';

void main() {
  test('History launch context carries Account and Purchase IDs only', () {
    const accountId = AccountId('account-1');
    final purchaseIds = {const PurchaseId('purchase-1')};
    const context = AnalyticsLaunchContext.purchaseSelection(accountId, {
      PurchaseId('purchase-1'),
    });

    final selection = context as AnalyticsPurchaseSelectionLaunchContext;
    expect(selection.accountId.value, accountId.value);
    expect(selection.purchaseIds.map((id) => id.value), ['purchase-1']);
    expect(selection.purchaseIds, purchaseIds);
  });
}
