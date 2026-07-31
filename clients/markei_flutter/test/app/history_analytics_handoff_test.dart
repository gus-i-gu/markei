import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/history_export.dart';
import 'package:markei/application/purchase_history.dart';
import 'package:markei/app/pages/history_page.dart';
import 'package:markei/domain/shared/ids.dart';

void main() {
  testWidgets('History hands off selected Purchase IDs without calculation', (
    tester,
  ) async {
    Set<PurchaseId>? handedOff;
    await tester.pumpWidget(
      MaterialApp(
        home: HistoryPage(
          accountId: const AccountId('account-1'),
          history: const _History(),
          exports: const _Exports(),
          refreshSignal: 0,
          onAnalyzeSelected: (ids) => handedOff = ids,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('history.analyzeSelected')), findsOneWidget);
    await tester.tap(find.byType(Checkbox).first);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('history.analyzeSelected')));

    expect(handedOff!.map((id) => id.value), ['purchase-1']);
  });
}

final class _History implements PurchaseHistoryRepository {
  const _History();

  @override
  Future<PurchaseDetail?> getPurchaseDetail(
    AccountId accountId,
    PurchaseId purchaseId,
  ) async => null;

  @override
  Future<List<PurchaseHistoryEntry>> listRecentPurchases(
    AccountId accountId,
  ) async => [
    PurchaseHistoryEntry(
      purchaseId: const PurchaseId('purchase-1'),
      storeName: 'Store',
      occurrenceTime: DateTime.utc(2026, 7, 31),
      currencyCode: 'BRL',
      totalMinorUnits: 100,
      itemCount: 1,
    ),
  ];

  @override
  Future<PriceChangeResult> priceChangeForProduct(
    AccountId accountId,
    ProductId productId,
  ) async => const PriceChangeUnavailable('Not enough comparable purchases.');
}

final class _Exports implements PurchaseExportRepository {
  const _Exports();

  @override
  Future<PurchaseExportBundle> exportBundle(
    AccountId accountId,
    Set<PurchaseId> purchaseIds,
  ) async => const PurchaseExportBundle(purchases: []);
}
