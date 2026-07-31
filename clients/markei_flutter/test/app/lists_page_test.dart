import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/product_lists.dart';
import 'package:markei/app/design/markei_theme.dart';
import 'package:markei/app/pages/lists_page.dart';
import 'package:markei/domain/shared/ids.dart';

void main() {
  testWidgets('Lists search and sort operate on one returned projection', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repository = _CountingListsRepository(
      _projection([
        _item(
          id: 'p-b',
          code: 'B-002',
          name: 'Coffee',
          brand: 'Pilar',
          remaining: 2,
        ),
        _item(
          id: 'p-a',
          code: 'A-001',
          name: 'Rice',
          brand: 'Tio Joao',
          remaining: 8,
        ),
      ]),
    );

    await tester.pumpWidget(_app(repository));
    await _pumpReady(tester);

    expect(repository.calls, 1);
    expect(find.byKey(const Key('lists.table')), findsOneWidget);

    await tester.enterText(find.byKey(const Key('lists.search')), 'rice');
    await _pumpReady(tester);

    expect(repository.calls, 1);
    expect(find.textContaining('Rice'), findsOneWidget);
    expect(find.text('Coffee'), findsNothing);

    await tester.tap(find.byKey(const Key('lists.sort')));
    await _pumpReady(tester);
    await tester.tap(find.text('Product code').last);
    await _pumpReady(tester);

    expect(repository.calls, 1);

    tester.view.physicalSize = const Size(390, 844);
    await _pumpReady(tester);

    expect(find.byKey(const Key('lists.cards')), findsOneWidget);
    expect(find.text('Rice'), findsOneWidget);
    expect(repository.calls, 1);
  });

  testWidgets(
    'Lists distinguishes empty filtered and insufficient-history states',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final repository = _CountingListsRepository(
        _projection([
          _item(
            id: 'p-learning',
            code: 'L-001',
            name: 'Learning Product',
            brand: 'Brand',
            remaining: null,
          ),
        ]),
      );

      await tester.pumpWidget(_app(repository));
      await _pumpReady(tester);

      expect(
        find.byKey(const Key('lists.insufficientHistory.p-learning')),
        findsOneWidget,
      );

      await tester.enterText(find.byKey(const Key('lists.search')), 'missing');
      await _pumpReady(tester);

      expect(find.byKey(const Key('lists.filteredEmpty')), findsOneWidget);
      expect(repository.calls, 1);

      final emptyRepository = _CountingListsRepository(_projection([]));
      await tester.pumpWidget(_app(emptyRepository));
      await _pumpReady(tester);

      expect(find.byKey(const Key('lists.empty.firstUse')), findsOneWidget);
    },
  );

  testWidgets('Lists retry repeats only the Lists read after an error', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final repository = _FailingThenPassingListsRepository(
      _projection([
        _item(
          id: 'p-retry',
          code: 'R-001',
          name: 'Retry Product',
          brand: 'Brand',
          remaining: 1,
        ),
      ]),
    );

    await tester.pumpWidget(_app(repository));
    await _pumpReady(tester);

    expect(find.byKey(const Key('lists.error')), findsOneWidget);
    expect(find.textContaining('StateError'), findsNothing);

    await tester.tap(find.byKey(const Key('lists.retry')));
    await _pumpReady(tester);

    expect(find.byKey(const Key('lists.product.p-retry')), findsOneWidget);
    expect(repository.calls, 2);
  });
}

Widget _app(ProductListProjectionRepository repository) {
  return MaterialApp(
    theme: markeiTheme(),
    home: Scaffold(
      body: ListsPage(
        accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
        projections: repository,
        refreshSignal: 0,
      ),
    ),
  );
}

ProductListProjection _projection(List<ProductListProjectionItem> items) {
  return ProductListProjection(
    view: ProductListView.shortage,
    items: items,
    shortageThresholdDays: 5,
    approximateTotalCurrencyCode: 'BRL',
    approximateTotalMinorUnits: 1234,
  );
}

ProductListProjectionItem _item({
  required String id,
  required String code,
  required String name,
  required String brand,
  required int? remaining,
}) {
  final cycle = remaining == null
      ? const PersonalCycleResult.unavailable('Not enough history')
      : PersonalCycleResult.available(
          version: 'personal-cycle-v1',
          averageIntervalDays: 7,
          expectedNextPurchaseDate: DateTime(2026, 8, 6),
          remainingDays: remaining,
        );
  return ProductListProjectionItem(
    productId: ProductId(id),
    productCode: code,
    productName: name,
    productBrand: brand,
    cycle: cycle,
    latestCurrencyCode: 'BRL',
    latestLineTotalMinorUnits: 1000,
  );
}

final class _CountingListsRepository
    implements ProductListProjectionRepository {
  _CountingListsRepository(this.projection);

  final ProductListProjection projection;
  int calls = 0;

  @override
  Future<ProductListProjection> productListProjection({
    required AccountId accountId,
    required ProductListView view,
    required DateTime today,
  }) async {
    calls++;
    return projection;
  }
}

final class _FailingThenPassingListsRepository
    implements ProductListProjectionRepository {
  _FailingThenPassingListsRepository(this.projection);

  final ProductListProjection projection;
  int calls = 0;

  @override
  Future<ProductListProjection> productListProjection({
    required AccountId accountId,
    required ProductListView view,
    required DateTime today,
  }) async {
    calls++;
    if (calls == 1) {
      throw StateError('database unavailable');
    }
    return projection;
  }
}

Future<void> _pumpReady(WidgetTester tester) async {
  for (var i = 0; i < 20; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}
