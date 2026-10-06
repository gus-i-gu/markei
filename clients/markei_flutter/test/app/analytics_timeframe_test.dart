import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/widgets/analytics_components.dart';
import 'package:markei/application/analytics.dart';
import 'package:markei/application/analytics_workspace.dart';
import 'package:markei/domain/analytics/analytics_models.dart';
import 'package:markei/domain/analytics/analytics_registry.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/quantity.dart';

void main() {
  testWidgets(
    'date input inserts separators and preserves strict calendar validation',
    (tester) async {
      final controller = await _controller();
      await _pumpComposer(tester, controller);
      await _enterDate(tester, 'initialDate', '31072026');
      await _enterDate(tester, 'finalDate', '31072026');
      expect(_dateText(tester, 'initialDate'), '31-07-2026');
      expect(_dateText(tester, 'finalDate'), '31-07-2026');
      expect(controller.snapshot.validation.canRun, isTrue);
      await _enterDate(tester, 'initialDate', '31022026');
      expect(_dateText(tester, 'initialDate'), '31-02-2026');
      expect(controller.snapshot.validation.canRun, isFalse);
    },
  );
  for (final width in [360.0, 1200.0]) {
    testWidgets(
      'date range retains sequential drafts and clears at width $width',
      (tester) async {
        final controller = await _controller();
        await _pumpComposer(tester, controller, width: width);

        expect(find.text('Start date'), findsOneWidget);
        expect(find.text('End date'), findsOneWidget);
        expect(find.byKey(const Key('analytics.timeframe.all')), findsNothing);
        expect(
          find.byKey(const Key('analytics.timeframe.customDates')),
          findsNothing,
        );
        expect(controller.snapshot.validation.canRun, isTrue);

        await _enterDate(tester, 'initialDate', '31-07-2026');
        expect(controller.snapshot.validation.canRun, isFalse);
        expect(
          controller.snapshot.draft.timeframe.initialLocalDate,
          '31-07-2026',
        );
        expect(_dateText(tester, 'initialDate'), '31-07-2026');

        await _enterDate(tester, 'finalDate', '01-08');
        expect(controller.snapshot.validation.canRun, isFalse);
        expect(controller.snapshot.draft.timeframe.finalLocalDate, '01-08');
        expect(_dateText(tester, 'initialDate'), '31-07-2026');
        expect(_dateText(tester, 'finalDate'), '01-08');

        await tester.pumpWidget(const SizedBox.shrink());
        await _pumpComposer(tester, controller, width: width);
        expect(_dateText(tester, 'initialDate'), '31-07-2026');
        expect(_dateText(tester, 'finalDate'), '01-08');

        await _enterDate(tester, 'finalDate', '01-08-2026');
        expect(controller.snapshot.validation.canRun, isTrue);
        expect(
          controller.snapshot.draft.timeframe.label,
          '31-07-2026 to 01-08-2026',
        );

        final clear = find.byKey(const Key('analytics.clearDraft'));
        await tester.ensureVisible(clear);
        await tester.tap(clear);
        await tester.pump();
        expect(_dateText(tester, 'initialDate'), isEmpty);
        expect(_dateText(tester, 'finalDate'), isEmpty);
        expect(
          controller.snapshot.draft.timeframe.kind,
          AnalyticsTimeframeKind.allRecordedTime,
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('invalid calendar dates and reversed ranges block analysis', (
    tester,
  ) async {
    final controller = await _controller();
    await _pumpComposer(tester, controller);

    await _enterDate(tester, 'initialDate', '31-02-2026');
    await _enterDate(tester, 'finalDate', '31-07-2026');
    expect(controller.snapshot.validation.canRun, isFalse);
    expect(controller.snapshot.draft.timeframe.isValid, isFalse);
    expect(_dateText(tester, 'initialDate'), '31-02-2026');
    expect(_dateText(tester, 'finalDate'), '31-07-2026');

    await _enterDate(tester, 'initialDate', '31-07-2026');
    await _enterDate(tester, 'finalDate', '30-07-2026');
    expect(controller.snapshot.validation.canRun, isFalse);
    expect(controller.snapshot.draft.timeframe.isValid, isFalse);
    expect(_dateText(tester, 'initialDate'), '31-07-2026');
    expect(_dateText(tester, 'finalDate'), '30-07-2026');

    await _enterDate(tester, 'finalDate', '31-07-2026');
    expect(controller.snapshot.validation.canRun, isTrue);
    expect(tester.takeException(), isNull);
  });

  for (final determinant in [
    AnalyticsDeterminantKind.timeDayUtc,
    AnalyticsDeterminantKind.timeMonthUtc,
  ]) {
    testWidgets(
      '${determinant.name} rows and temporal axes use dates without checkboxes',
      (tester) async {
        final controller = await _controller();
        controller.setDeterminant(determinant);
        controller.setAxis(
          0,
          AnalyticsAxis(
            kind: determinant == AnalyticsDeterminantKind.timeDayUtc
                ? AnalyticsDeterminantKind.timeMonthUtc
                : AnalyticsDeterminantKind.timeDayUtc,
          ),
        );
        await _pumpComposer(tester, controller);

        expect(find.byType(CheckboxListTile), findsNothing);
        expect(find.byKey(const Key('analytics.choose.search')), findsNothing);
        expect(
          find.byKey(const Key('analytics.axis.0.choose.search')),
          findsNothing,
        );
        expect(find.text('Use all recorded rows'), findsNothing);
        expect(controller.snapshot.validation.canRun, isTrue);

        await _enterDate(tester, 'initialDate', '31-07-2026');
        await _enterDate(tester, 'finalDate', '31-07-2026');
        expect(controller.snapshot.validation.canRun, isTrue);
        controller.runAndSave();
        expect(
          controller.snapshot.selectedRecord!.contributingRowIds
              .map((id) => id.value)
              .toSet(),
          {'first', 'last'},
        );
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('inclusive local date range excludes adjacent days', (
    tester,
  ) async {
    final controller = await _controller();
    await _pumpComposer(tester, controller);
    await _enterDate(tester, 'initialDate', '31-07-2026');
    await _enterDate(tester, 'finalDate', '31-07-2026');

    final condition =
        controller.snapshot.draft.timeframe.toConditions().single
            as AnalyticsUtcPeriodCondition;
    final start = DateTime(2026, 7, 31);
    final nextDay = DateTime(2026, 8, 1);
    expect(condition.contains(start), isTrue);
    expect(
      condition.contains(nextDay.subtract(const Duration(microseconds: 1))),
      isTrue,
    );
    expect(
      condition.contains(start.subtract(const Duration(microseconds: 1))),
      isFalse,
    );
    expect(condition.contains(nextDay), isFalse);
    controller.runAndSave();
    expect(
      controller.snapshot.selectedRecord!.contributingRowIds
          .map((id) => id.value)
          .toSet(),
      {'first', 'last'},
    );

    await _enterDate(tester, 'initialDate', '');
    expect(controller.snapshot.validation.canRun, isFalse);
    await _enterDate(tester, 'finalDate', '');
    expect(controller.snapshot.validation.canRun, isTrue);
    expect(controller.snapshot.draft.timeframe.toConditions(), isEmpty);
    controller.runAndSave();
    expect(
      controller.snapshot.selectedRecord!.contributingRowIds
          .map((id) => id.value)
          .toSet(),
      {'before', 'first', 'last', 'after'},
    );
    expect(tester.takeException(), isNull);
  });
}

Future<AnalyticsWorkspaceController> _controller() async {
  final start = DateTime(2026, 7, 31);
  final nextDay = DateTime(2026, 8, 1);
  final controller = AnalyticsWorkspaceController(
    accountId: const AccountId('account'),
    repository: _Repository([
      _row('before', start.subtract(const Duration(microseconds: 1))),
      _row('first', start),
      _row('last', nextDay.subtract(const Duration(microseconds: 1))),
      _row('after', nextDay),
    ]),
    registry: localAnalyticsRegistry(),
  );
  await controller.load();
  controller.toggleDeterminantKey('product');
  controller.toggleVariable(AnalyticsVariable.lineTotal);
  return controller;
}

Future<void> _pumpComposer(
  WidgetTester tester,
  AnalyticsWorkspaceController controller, {
  double width = 1200,
}) async {
  tester.view.physicalSize = Size(width, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: StatefulBuilder(
          builder: (context, setState) {
            void update(VoidCallback change) {
              setState(change);
            }

            final snapshot = controller.snapshot;
            return SingleChildScrollView(
              child: AnalyticsComposerView(
                draft: snapshot.draft,
                validation: snapshot.validation,
                options: snapshot.options,
                onDeterminantChanged: (value) =>
                    update(() => controller.setDeterminant(value)),
                onToggleDeterminantKey: (value) =>
                    update(() => controller.toggleDeterminantKey(value)),
                onToggleVariable: (value) =>
                    update(() => controller.toggleVariable(value)),
                onOperationChanged: (value) =>
                    update(() => controller.setOperation(value)),
                onTimeframeChanged: (value) =>
                    update(() => controller.setTimeframe(value)),
                onAxisChanged: (index, value) =>
                    update(() => controller.setAxis(index, value)),
                onSelectAllDeterminants: () =>
                    update(controller.selectAllDeterminants),
                onRun: () => update(controller.runAndSave),
                onClear: () => update(controller.clearDraft),
              ),
            );
          },
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _enterDate(WidgetTester tester, String field, String value) async {
  final finder = find.byKey(Key('analytics.timeframe.$field'));
  await tester.ensureVisible(finder);
  await tester.enterText(finder, value);
  await tester.pump();
}

String _dateText(WidgetTester tester, String field) => tester
    .widget<EditableText>(
      find.descendant(
        of: find.byKey(Key('analytics.timeframe.$field')),
        matching: find.byType(EditableText),
      ),
    )
    .controller
    .text;

final class _Repository implements AnalyticsEvidenceRepository {
  const _Repository(this.rows);

  final List<AnalyticsEvidenceRow> rows;

  @override
  Future<AnalyticsDataset> loadEvidence(AccountId accountId) async =>
      AnalyticsDataset(accountId: accountId, rows: rows);
}

AnalyticsEvidenceRow _row(String id, DateTime occurrence) =>
    AnalyticsEvidenceRow(
      id: PurchaseItemId(id),
      accountId: const AccountId('account'),
      purchaseId: PurchaseId('purchase-$id'),
      purchaseOccurrenceTime: occurrence.toUtc(),
      purchaseTotal: const AnalyticsMoneyAmount(
        currencyCode: 'BRL',
        minorUnits: 100,
      ),
      productId: const ProductId('product'),
      productCode: 'P-1',
      productName: 'Product',
      productBrand: '',
      storeId: const StoreId('store'),
      storeName: 'Store',
      purchasedBy: null,
      paymentMethod: null,
      quantity: const NormalizedQuantity(
        kind: MeasurementKind.mass,
        unit: CanonicalUnit.kg,
        microunits: 1000000,
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
    );
