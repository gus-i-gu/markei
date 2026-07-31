import 'package:flutter_test/flutter_test.dart';
import 'package:markei/application/audit.dart';
import 'package:markei/domain/shared/ids.dart';

void main() {
  const account = AccountId('11111111-1111-4111-8111-111111111111');

  test(
    'controller gates stale completions and retry repeats one local read',
    () async {
      final repository = _RecordingAuditRepository();
      final controller = AuditController(
        accountId: account,
        environmentAlias: 'provider-native',
        repository: repository,
      );

      final first = await controller.loadFirstPage();
      expect(first.kind, AuditWorkspaceKind.ready);
      expect(repository.requests, hasLength(1));
      expect(first.page!.queryCount, 2);
      expect(first.page!.networkCallCount, 0);
      expect(first.page!.writeCallCount, 0);

      final retry = await controller.retry();
      expect(retry.kind, AuditWorkspaceKind.ready);
      expect(repository.requests, hasLength(2));

      controller.dispose();
      final afterDispose = await controller.retry();
      expect(afterDispose.generation, retry.generation);
      expect(repository.requests, hasLength(2));
    },
  );

  test('request clamps page limits to hard maximum', () {
    final request = AuditPageRequest(
      accountId: account,
      environmentAlias: 'provider-native',
      limit: 500,
    );

    expect(request.limit, AuditPageRequest.maxLimit);
  });
}

final class _RecordingAuditRepository implements AuditReadPort {
  final requests = <AuditPageRequest>[];

  @override
  Future<AuditPageResult> loadPage(AuditPageRequest request) async {
    requests.add(request);
    return AuditPageResult(
      records: [
        AuditAttemptProjection(
          id: AuditAttemptId(requests.length),
          startedAtUtc: DateTime.utc(2026, 7, 31, 12, requests.length),
          completedAtUtc: null,
          operationKind: 'ordinary-sync',
          resultCode: 'sync-completed',
          outcomeClass: 'completed',
          latestStage: 'completed',
          correlationReference: '#abcdef12',
          deviceReference: null,
          events: const [],
        ),
      ],
      nextCursor: null,
      loadedAtUtc: DateTime.utc(2026, 7, 31, 13, requests.length),
      isPartialWindow: false,
      queryCount: 2,
      networkCallCount: 0,
      writeCallCount: 0,
    );
  }
}
