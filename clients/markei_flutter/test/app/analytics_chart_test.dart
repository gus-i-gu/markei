import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/analytics.dart';
import 'package:markei/application/analytics_workspace.dart';
import 'package:markei/app/widgets/analytics_components.dart';
import 'package:markei/domain/analytics/analytics_models.dart';
import 'package:markei/domain/analytics/analytics_registry.dart';
import 'package:markei/domain/shared/ids.dart';
import '../application/analytics_axes_test.dart' as fixtures;

void main() {
  testWidgets(
    'all chart entries remain reachable and a different record resets its page',
    (tester) async {
      final controller = AnalyticsWorkspaceController(
        accountId: const AccountId('account'),
        repository: _Evidence(),
        registry: localAnalyticsRegistry(),
      );
      await controller.load();
      controller.selectAllDeterminants();
      controller.toggleVariable(AnalyticsVariable.lineTotal);
      controller.runAndSave();
      Widget chart(AnalyticsRecord record) => MaterialApp(
        home: Scaffold(body: AnalyticsChartProjection(record: record)),
      );
      await tester.pumpWidget(chart(controller.snapshot.records.single));
      expect(find.text('Chart page 1 of 2'), findsOneWidget);
      await tester.tap(find.byKey(const Key('analytics.chart.next')));
      await tester.pump();
      expect(find.text('Chart page 2 of 2'), findsOneWidget);
      controller.setOperation(AnalyticsOperation.mean);
      controller.runAndSave();
      await tester.pumpWidget(chart(controller.snapshot.records.first));
      expect(find.text('Chart page 1 of 2'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}

class _Evidence implements AnalyticsEvidenceRepository {
  @override
  Future<AnalyticsDataset> loadEvidence(AccountId accountId) async =>
      AnalyticsDataset(
        accountId: accountId,
        rows: [
          for (var i = 0; i < 40; i++)
            fixtures.row('$i', 'Product $i', 'Condor', 1, 1000 + i),
        ],
      );
}
