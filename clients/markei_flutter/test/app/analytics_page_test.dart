import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/analytics.dart';
import 'package:markei/application/analytics_workspace.dart';
import 'package:markei/domain/analytics/analytics_models.dart';
import 'package:markei/domain/analytics/analytics_registry.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/app/pages/analytics_page.dart';

void main() {
  testWidgets('Analytics page renders cards above evidence matrix', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final controller = AnalyticsWorkspaceController(
      accountId: const AccountId('account-1'),
      repository: const _Repository(),
      registry: localAnalyticsRegistry(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: AnalyticsPage(
          controller: controller,
          launchContext: null,
          visible: true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('analytics.page')), findsOneWidget);
    expect(find.text('Supporting evidence matrix'), findsOneWidget);
    await tester.tap(find.byKey(const Key('analytics.card.create')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('analytics.card.1')), findsOneWidget);
  });
}

final class _Repository implements AnalyticsEvidenceRepository {
  const _Repository();

  @override
  Future<AnalyticsDataset> loadEvidence(AccountId accountId) async {
    return AnalyticsDataset(
      accountId: accountId,
      rows: [
        AnalyticsEvidenceRow(
          id: const PurchaseItemId('item-1'),
          accountId: accountId,
          purchaseId: const PurchaseId('purchase-1'),
          purchaseOccurrenceTime: DateTime.utc(2026, 7, 31),
          purchaseTotal: const AnalyticsMoneyAmount(
            currencyCode: 'BRL',
            minorUnits: 100,
          ),
          productId: const ProductId('product-1'),
          productCode: 'P-1',
          productName: 'Product',
          productBrand: '',
          storeId: const StoreId('store-1'),
          storeName: 'Store',
          purchasedBy: null,
          paymentMethod: null,
          quantity: const NormalizedQuantity(
            kind: MeasurementKind.mass,
            unit: CanonicalUnit.kg,
            microunits: NormalizedQuantity.factor,
          ),
          lineTotal: const AnalyticsMoneyAmount(
            currencyCode: 'BRL',
            minorUnits: 100,
          ),
          unitPrice: const AnalyticsUnitPrice(
            currencyCode: 'BRL',
            minorUnitsPerCanonicalUnit: 100,
            kind: MeasurementKind.mass,
            unit: CanonicalUnit.kg,
          ),
        ),
      ],
    );
  }
}
