import 'package:markei/application/content_sharing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/product_lists.dart';
import 'package:markei/application/list_notes.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/app/design/markei_theme.dart';
import 'package:markei/app/pages/lists_page.dart';
import 'package:markei/domain/shared/ids.dart';

void main() {
  testWidgets(
    'List sharing freezes filtered products and cancels without handoff',
    (tester) async {
      tester.view.physicalSize = const Size(390, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final repository = _CountingListsRepository(
        _projection([
          _item(
            id: 'coffee',
            code: 'C-1',
            name: 'Coffee',
            brand: 'Marc',
            remaining: 2,
          ),
          _item(
            id: 'tea',
            code: 'T-1',
            name: 'Tea',
            brand: 'Other',
            remaining: 3,
          ),
        ]),
      );
      final sharing = _Sharing();
      await tester.pumpWidget(
        MaterialApp(
          theme: markeiTheme(),
          home: Scaffold(
            body: ListsPage(
              accountId: const AccountId('account-1'),
              projections: repository,
              refreshSignal: 0,
              contentSharing: sharing,
            ),
          ),
        ),
      );
      await _pumpReady(tester);
      final search = find.byKey(const Key('lists.search'));
      await tester.ensureVisible(search);
      await tester.enterText(search, 'Coffee');
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const Key('lists.share')));
      await tester.tap(find.byKey(const Key('lists.share')));
      await tester.pumpAndSettle();
      expect(find.textContaining('Coffee · Marc'), findsOneWidget);
      await tester.tap(find.byKey(const Key('share.cancel')));
      await tester.pumpAndSettle();
      expect(sharing.requests, isEmpty);
      await tester.tap(find.byKey(const Key('lists.share')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('share.confirm')));
      await tester.pumpAndSettle();
      expect(sharing.requests.single.text, contains('Coffee'));
      expect(sharing.requests.single.text, isNot(contains('Tea')));
      expect(
        sharing.requests.single.text,
        contains('not a confirmed stock count'),
      );
      expect(repository.calls, 1);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'time display preserves projection and phone notes stay editable',
    (tester) async {
      tester.view.physicalSize = const Size(360, 900);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final repository = _CountingListsRepository(
        _projection([
          _item(
            id: 'coffee',
            code: 'C-1',
            name: 'Coffee',
            brand: 'Marc',
            remaining: 2,
          ),
        ]),
      );
      final notes = _Notes();
      await tester.pumpWidget(_app(repository, notes: notes));
      await _pumpReady(tester);
      await tester.tap(find.byKey(const Key('lists.timeDisplay')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Days from last purchase').last);
      await tester.pumpAndSettle();
      expect(find.text('17 day(s)'), findsOneWidget);
      expect(repository.calls, 1);
      expect(find.textContaining('Packaged / per unit'), findsWidgets);
      final editor = find.byKey(const Key('lists.note.edit.coffee'));
      await tester.ensureVisible(editor);
      await tester.pumpAndSettle();
      await tester.tap(editor);
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('lists.note.text')),
        'Bring coffee',
      );
      await tester.enterText(
        find.byKey(const Key('lists.note.tags')),
        '@Alex, #Debit',
      );
      await tester.tap(find.byKey(const Key('lists.note.save')));
      await _pumpReady(tester);
      expect(notes.saved.single.note, 'Bring coffee');
      expect(notes.saved.single.tags, ['@Alex', '#Debit']);
      await tester.ensureVisible(find.byKey(const Key('lists.noteStatus')));
      await tester.pumpAndSettle();
      expect(
        find.text('Note saved on this device. Use Sync now to share it.'),
        findsOneWidget,
      );
      await tester.ensureVisible(editor);
      await tester.pumpAndSettle();
      await tester.tap(editor);
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('lists.note.text')))
            .controller!
            .text,
        'Bring coffee',
      );
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Cancel'));
      await _pumpReady(tester);
    },
  );
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

Widget _app(
  ProductListProjectionRepository repository, {
  ListNotesRepository? notes,
}) {
  return MaterialApp(
    theme: markeiTheme(),
    home: Scaffold(
      body: ListsPage(
        accountId: const AccountId('11111111-1111-4111-8111-111111111111'),
        projections: repository,
        notes: notes,
        deviceId: const DeviceId('22222222-2222-4222-8222-222222222222'),
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
    productMode: ProductMode.packaged,
    daysSinceLastPurchase: 17,
    cycle: cycle,
    latestCurrencyCode: 'BRL',
    latestLineTotalMinorUnits: 1000,
  );
}

final class _Notes implements ListNotesRepository {
  final saved = <ListNoteRevision>[];
  @override
  Future<Map<String, List<ListNoteRevision>>> read(AccountId accountId) async =>
      {
        if (saved.isNotEmpty) 'coffee': [saved.last],
      };
  @override
  Future<void> save({
    required AccountId accountId,
    required DeviceId deviceId,
    required ProductId productId,
    required String note,
    required List<String> tags,
    required Set<String> observedRevisionIds,
  }) async {
    saved.add(
      ListNoteRevision(
        id: 'edit-${saved.length}',
        productId: productId.value,
        note: note,
        tags: tags,
        replaces: observedRevisionIds,
      ),
    );
  }
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

final class _Sharing implements ContentSharingPort {
  final requests = <ContentShareRequest>[];
  @override
  Future<ContentShareResult> share(ContentShareRequest request) async {
    requests.add(request);
    return ContentShareResult.handedOff;
  }
}
