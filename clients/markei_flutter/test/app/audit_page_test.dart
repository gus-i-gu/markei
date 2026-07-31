import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/pages/audit_page.dart';
import 'package:markei/application/audit.dart';
import 'package:markei/domain/shared/ids.dart';

void main() {
  const account = AccountId('11111111-1111-4111-8111-111111111111');

  testWidgets('Audit load is visibility gated and retry is local only', (
    tester,
  ) async {
    final repository = _RecordingAuditRepository();
    final controller = AuditController(
      accountId: account,
      environmentAlias: 'provider-native',
      repository: repository,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: AuditPage(controller: controller, visible: false)),
      ),
    );
    await tester.pumpAndSettle();
    expect(repository.requests, isEmpty);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: AuditPage(controller: controller, visible: true)),
      ),
    );
    await tester.pumpAndSettle();
    expect(repository.requests, hasLength(1));
    expect(find.byKey(const Key('audit.page')), findsOneWidget);
    expect(find.text('Audit'), findsOneWidget);
    expect(
      find.text(
        'Recent activity recorded locally for this Account and environment.',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('Older records may exist'), findsOneWidget);
    expect(find.textContaining('not a cause'), findsOneWidget);

    await tester.tap(find.byKey(const Key('audit.retry')));
    await tester.pumpAndSettle();
    expect(repository.requests, hasLength(2));
    expect(repository.networkCalls, 0);
    expect(repository.writeCalls, 0);
  });
}

final class _RecordingAuditRepository implements AuditReadPort {
  final requests = <AuditPageRequest>[];
  int networkCalls = 0;
  int writeCalls = 0;

  @override
  Future<AuditPageResult> loadPage(AuditPageRequest request) async {
    requests.add(request);
    return AuditPageResult(
      records: [
        AuditAttemptProjection(
          id: const AuditAttemptId(7),
          startedAtUtc: DateTime.utc(2026, 7, 31, 10),
          completedAtUtc: DateTime.utc(2026, 7, 31, 10, 1),
          operationKind: 'ordinary-sync',
          resultCode: 'sync-completed',
          outcomeClass: 'completed',
          latestStage: 'completed',
          correlationReference: '#abcdef12',
          deviceReference: null,
          events: [
            AuditEventProjection(
              id: AuditEventId(8),
              recordedAtUtc: DateTime.utc(2026, 7, 31, 10),
              code: 'MKS-OBS-001',
              title: 'Operation observation',
              meaning: 'Client operation evidence was recorded.',
              guidance: 'Review local evidence.',
              severity: 'INFO',
              outcome: 'completed',
              phase: 'terminal',
            ),
          ],
        ),
      ],
      nextCursor: AuditCursor(
        startedAtUtc: DateTime.utc(2026, 7, 31, 10),
        attemptId: AuditAttemptId(7),
      ),
      loadedAtUtc: DateTime.utc(2026, 7, 31, 11),
      isPartialWindow: true,
      queryCount: 2,
      networkCallCount: 0,
      writeCallCount: 0,
    );
  }
}
