import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/export_destination.dart';
import 'package:markei/application/history_export.dart';
import 'package:markei/application/purchase_history.dart';
import 'package:markei/app/pages/history_page.dart';
import 'package:markei/domain/shared/ids.dart';

void main() {
  testWidgets('History selection is action-only and export uses destination', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final history = _History();
    final exports = _Exports();
    final destination = _Destination();
    await tester.pumpWidget(
      MaterialApp(
        home: HistoryPage(
          accountId: const AccountId('account-1'),
          history: history,
          exports: exports,
          exportDestination: destination,
          refreshSignal: 0,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('history.select.purchase-1')));
    await tester.pumpAndSettle();
    expect(find.text('1 selected for action'), findsOneWidget);
    expect(find.byKey(const Key('history.detail')), findsNothing);

    await tester.tap(find.text('Store A').first);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('history.detail')), findsOneWidget);

    await tester.tap(find.byKey(const Key('history.select.purchase-1')));
    await tester.pumpAndSettle();
    expect(find.text('0 selected for action'), findsOneWidget);
    expect(find.byKey(const Key('history.detail')), findsOneWidget);

    await tester.tap(find.byKey(const Key('history.select.purchase-1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('history.exportCsv')));
    await tester.pumpAndSettle();
    expect(exports.calls, 1);
    expect(exports.lastIds, {'purchase-1'});
    expect(destination.writeCount, 1);
    expect(destination.lastRequest!.extension, 'csv');
  });

  testWidgets('History filters prune selection to shown loaded rows', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        home: HistoryPage(
          accountId: const AccountId('account-1'),
          history: _History(),
          exports: _Exports(),
          exportDestination: _Destination(),
          refreshSignal: 0,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('history.selectAll')));
    await tester.pumpAndSettle();
    expect(find.text('2 selected for action'), findsOneWidget);

    await tester.tap(find.byKey(const Key('history.filter.store')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Store B').last);
    await tester.pumpAndSettle();

    expect(find.text('1 selected for action'), findsOneWidget);
    expect(find.text('Store A'), findsNothing);
    expect(find.text('Store B'), findsWidgets);
  });
}

final class _History implements PurchaseHistoryRepository {
  final entries = [
    PurchaseHistoryEntry(
      purchaseId: const PurchaseId('purchase-1'),
      storeName: 'Store A',
      occurrenceTime: DateTime.utc(2026, 7, 31),
      currencyCode: 'BRL',
      totalMinorUnits: 100,
      itemCount: 1,
    ),
    PurchaseHistoryEntry(
      purchaseId: const PurchaseId('purchase-2'),
      storeName: 'Store B',
      occurrenceTime: DateTime.utc(2026, 7, 30),
      currencyCode: 'BRL',
      totalMinorUnits: 200,
      itemCount: 1,
    ),
  ];

  @override
  Future<PurchaseDetail?> getPurchaseDetail(
    AccountId accountId,
    PurchaseId purchaseId,
  ) async {
    final entry = entries.firstWhere(
      (entry) => entry.purchaseId.value == purchaseId.value,
    );
    return PurchaseDetail(
      entry: entry,
      items: [
        PurchaseDetailItem(
          productId: const ProductId('product-1'),
          productName: 'Product',
          productBrand: 'Brand',
          productCode: 'P-1',
          packageCount: 1,
          measurementKind: 'MASS',
          purchasedAmount: '1.000000',
          purchasedUnit: 'KG',
          currencyCode: 'BRL',
          lineTotalMinorUnits: entry.totalMinorUnits,
        ),
      ],
    );
  }

  @override
  Future<List<PurchaseHistoryEntry>> listRecentPurchases(
    AccountId accountId,
  ) async => entries;

  @override
  Future<PriceChangeResult> priceChangeForProduct(
    AccountId accountId,
    ProductId productId,
  ) async => const PriceChangeUnavailable('Not enough comparable purchases.');
}

final class _Exports implements PurchaseExportRepository {
  int calls = 0;
  Set<String> lastIds = const {};

  @override
  Future<PurchaseExportBundle> exportBundle(
    AccountId accountId,
    Set<PurchaseId> purchaseIds,
  ) async {
    calls++;
    lastIds = {for (final id in purchaseIds) id.value};
    return const PurchaseExportBundle(purchases: []);
  }
}

final class _Destination implements ExportDestinationPort {
  int writeCount = 0;
  ExportDestinationRequest? lastRequest;

  @override
  Future<ExportDestinationResult> write(
    ExportDestinationRequest request,
  ) async {
    writeCount++;
    lastRequest = request;
    return ExportDestinationSuccess(
      destinationLabel: 'Downloads',
      path:
          'C:\\Users\\tester\\Downloads\\${request.baseNameCue}.${request.extension}',
      bytesWritten: request.bytes.length,
    );
  }
}
