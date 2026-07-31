import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/export_destination.dart';
import 'package:markei/app/pages/analytics_page.dart';
import 'package:markei/application/analytics.dart';
import 'package:markei/application/analytics_workspace.dart';
import 'package:markei/domain/analytics/analytics_models.dart';
import 'package:markei/domain/analytics/analytics_registry.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';

void main() {
  testWidgets(
    'Analytics page renders PH04 composer records result and variables',
    (tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account-1'),
        repository: const _Repository(),
        registry: localAnalyticsRegistry(),
        clock: () => DateTime.utc(2026, 7, 31, 12),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AnalyticsPage(
              controller: controller,
              launchContext: null,
              exportDestination: exportDestination,
              visible: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('analytics.page')), findsOneWidget);
      expect(find.text('Create analysis'), findsOneWidget);
      expect(find.text('Saved analyses — this session'), findsOneWidget);
      expect(find.text('Variables'), findsOneWidget);
      expect(find.text('Supporting evidence matrix'), findsNothing);

      await tester.tap(find.byKey(const Key('analytics.choose.product-1')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('analytics.measure.lineTotal')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('analytics.runSave')));
      await tester.pumpAndSettle();

      expect(controller.snapshot.records, hasLength(1));
      expect(find.textContaining('Record #'), findsWidgets);
      await tester.drag(
        find.byKey(const Key('analytics.page')),
        const Offset(0, -700),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('analytics.result')), findsOneWidget);
      expect(find.byKey(const Key('analytics.export.csv')), findsOneWidget);
      expect(find.byKey(const Key('analytics.export.pdf')), findsOneWidget);
      await tester.tap(find.byKey(const Key('analytics.export.csv')));
      await tester.pump(const Duration(milliseconds: 100));
      expect(exportDestination.writeCount, 1);
      expect(exportDestination.requests.single.extension, 'csv');
      await tester.tap(find.byKey(const Key('analytics.export.pdf')));
      await tester.pump(const Duration(milliseconds: 100));
      expect(exportDestination.writeCount, 2);
      expect(exportDestination.requests.last.extension, 'pdf');
      await tester.drag(
        find.byKey(const Key('analytics.page')),
        const Offset(0, -900),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('analytics.items.table')), findsOneWidget);
      expect(find.byTooltip('Delete card'), findsNothing);
      expect(find.byTooltip('Move card earlier'), findsNothing);
    },
  );
}

final exportDestination = _FakeExportDestination();

final class _FakeExportDestination implements ExportDestinationPort {
  final requests = <ExportDestinationRequest>[];

  int get writeCount => requests.length;

  @override
  Future<ExportDestinationResult> write(
    ExportDestinationRequest request,
  ) async {
    requests.add(request);
    return ExportDestinationSuccess(
      destinationLabel: 'Downloads',
      path:
          'C:\\Users\\tester\\Downloads\\${request.baseNameCue}.${request.extension}',
      bytesWritten: request.bytes.length,
    );
  }
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
