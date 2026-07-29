import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/build_provenance.dart';
import 'package:markei/app/native_auth_closure_runner.dart';
import 'package:markei/app/pages/native_closure_page.dart';
import 'package:markei/application/closure_diagnostics.dart';
import 'package:markei/application/failed_not_applied_recovery_coordinator.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/application/hosted_connection_check.dart';
import 'package:markei/application/hosted_enrollment_coordinator.dart';
import 'package:markei/application/hosted_sync_coordinator.dart';
import 'package:markei/application/sync/sync_ports.dart';
import 'package:markei/application/sync/sync_use_cases.dart';
import 'package:markei/domain/sync/sync_event.dart';

void main() {
  testWidgets('Closure renders signed-out empty diagnostics', (tester) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query, signedIn: false);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();

    expect(find.text('signed-out'), findsOneWidget);
    expect(find.text('Build provenance unavailable'), findsOneWidget);
    expect(find.text('device-enrolled'), findsOneWidget);
    expect(find.text('No locally recorded attempt history'), findsOneWidget);
    expect(find.text('No pending, failed or unknown events'), findsOneWidget);
  });

  testWidgets('Closure renders enrolled pending failed unknown and history', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery(populated: true);
    final runner = _runner(query: query);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();

    expect(find.text('authenticated'), findsOneWidget);
    expect(find.text('failed-work-needs-review'), findsOneWidget);
    expect(find.text('ordinary-sync: sync-failed #attempt1'), findsOneWidget);
    expect(
      find.textContaining(
        'aggregate HTTP status not applicable - see child requests',
      ),
      findsOneWidget,
    );
    expect(find.textContaining('status not-observed'), findsNothing);
    expect(find.text('purchase.registered.v3 #event1'), findsOneWidget);
    expect(find.text('Current #device1'), findsOneWidget);
  });

  testWidgets('Diagnostics replaces Status Query Refresh controls', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('nativeClosure.Diagnostics')), findsOneWidget);
    expect(find.text('Diagnostics'), findsOneWidget);
    expect(find.byKey(const Key('nativeClosure.Status')), findsNothing);
    expect(find.byKey(const Key('nativeClosure.Query')), findsNothing);
    expect(
      find.byKey(const Key('nativeClosure.Refresh diagnostics')),
      findsNothing,
    );
    expect(find.text('Check hosted connection'), findsOneWidget);
    expect(find.text('Sync'), findsOneWidget);
  });

  testWidgets(
    'compact Closure exposes consolidated diagnostics and provenance',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final query = _FakeDiagnosticsQuery(populated: true);
      final runner = _runner(query: query);

      await tester.pumpWidget(
        MaterialApp(
          home: NativeClosurePage(
            runner: runner,
            buildProvenance: BuildProvenance.fromRaw('db17f47'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('nativeClosure.page')), findsOneWidget);
      expect(
        find.byKey(const Key('nativeClosure.buildProvenance')),
        findsOneWidget,
      );
      expect(find.text('Build provenance #db17f47'), findsOneWidget);

      for (final text in [
        'Sync overview',
        'Local queue',
        'Next Device sequence',
        'Recent Closure attempts',
        'Grouped diagnostic lifecycle',
        'Devices',
        'Actionable events',
      ]) {
        await tester.scrollUntilVisible(
          find.text(text),
          500,
          scrollable: find.byType(Scrollable).first,
        );
        expect(find.text(text), findsOneWidget);
      }

      await tester.scrollUntilVisible(
        find.text('Closure actions'),
        500,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Closure actions'), findsOneWidget);
      expect(
        find.byKey(const Key('nativeClosure.Diagnostics')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('nativeClosure.Check hosted connection')),
        findsOneWidget,
      );
      expect(find.byKey(const Key('nativeClosure.Sync')), findsOneWidget);
      expect(find.byKey(const Key('nativeClosure.Status')), findsNothing);
      expect(find.byKey(const Key('nativeClosure.Query')), findsNothing);
      expect(
        find.byKey(const Key('nativeClosure.Refresh diagnostics')),
        findsNothing,
      );
    },
  );

  testWidgets('build provenance rejects unsafe visible metadata', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query);

    await tester.pumpWidget(
      MaterialApp(
        home: NativeClosurePage(
          runner: runner,
          buildProvenance: BuildProvenance.fromRaw(
            'DB17F47-with-path-H:/repo-and-token',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Build provenance unavailable'), findsOneWidget);
    expect(find.textContaining('DB17F47'), findsNothing);
    expect(find.textContaining('token'), findsNothing);
    expect(find.textContaining('H:/repo'), findsNothing);
    expect(query.beginAttempts, 0);
    expect(query.beginDiagnosticAttempts, 0);
    expect(query.completedResults, isEmpty);
  });

  testWidgets('Diagnostics is local only and does not invoke Sync', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const Key('nativeClosure.Diagnostics')),
    );
    await tester.tap(find.byKey(const Key('nativeClosure.Diagnostics')));
    await tester.pumpAndSettle();

    expect(find.text('diagnostics-ready'), findsOneWidget);
    expect(find.text('Authentication'), findsOneWidget);
    expect(find.text('Enrollment'), findsOneWidget);
    expect(find.text('Local queue and Next Device sequence'), findsNothing);
    expect(find.text('Recovery guidance'), findsOneWidget);
    expect(
      find.text('Allocated only to new local Device events'),
      findsOneWidget,
    );
    expect(query.snapshots, 2);
    expect(query.beginAttempts, 0);
    expect(query.beginDiagnosticAttempts, 0);
    expect(query.completedResults, isEmpty);
  });

  testWidgets('Current Sync action shows sanitized exception class only', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery(
      diagnostics: [
        _event(
          operation: 'apply12345678',
          ordinal: 1,
          phase: 'download-local-apply',
          code: 'MKS-DNL-006',
          nativeCode: 'remote-payload-shape-invalid',
          severity: 'ERROR',
          outcome: 'notApplied',
          sanitizedExceptionClass: 'payload-shape-failure',
        ),
      ],
    );
    final runner = _runner(query: query);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('nativeClosure.Sync')));
    await tester.tap(find.byKey(const Key('nativeClosure.Sync')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sanitized technical details'));
    await tester.pumpAndSettle();

    expect(find.text('Exception class'), findsOneWidget);
    expect(find.text('payload-shape-failure'), findsOneWidget);
    expect(find.textContaining('Exception:'), findsNothing);
    expect(find.textContaining('SQL'), findsNothing);
  });

  testWidgets('Lifecycle declarations are grouped by operation', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 3200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery(
      diagnostics: [
        _event(
          operation: 'older12345678',
          ordinal: 1,
          operationKind: 'failed-not-applied-recovery',
          phase: 'failed-recovery-preflight',
          code: 'MKS-REC-001',
          nativeCode: 'failed-not-applied-inspection-eligible',
          outcome: 'not-applied',
        ),
        _event(
          operation: 'newest123456',
          ordinal: 4,
          phase: 'terminal',
          nativeCode:
              'client-operation-declaration:sync-completed:scope-client-operation',
          outcome: 'applied',
        ),
        _event(
          operation: 'newest123456',
          ordinal: 3,
          phase: 'upload-provider',
          nativeCode: 'serverAccepted',
          outcome: 'applied',
        ),
        _event(
          operation: 'newest123456',
          ordinal: 2,
          phase: 'upload-provider',
          nativeCode: 'upload-request-started',
          outcome: 'unknown',
          trustedResponseState: 'not-received',
        ),
        _event(
          operation: 'newest123456',
          ordinal: 1,
          phase: 'authentication',
          nativeCode: 'authenticated',
          outcome: 'applied',
        ),
      ],
    );
    final runner = _runner(query: query);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();

    expect(
      find.textContaining('ordered evidence, not an error count'),
      findsOneWidget,
    );
    final newestGroup = find.byKey(
      const Key('nativeClosure.operationGroup.newest123456'),
    );
    await tester.ensureVisible(newestGroup);
    expect(newestGroup, findsOneWidget);
    await tester.tap(newestGroup);
    await tester.pumpAndSettle();
    await tester.tap(newestGroup);
    await tester.pumpAndSettle();
    expect(
      find.byKey(const Key('nativeClosure.operationGroup.newest123456.title')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('nativeClosure.operationGroup.older12345678.title')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('nativeClosure.operationGroup.newest123456.status')),
      findsOneWidget,
    );
    final terminalPhase = find.byKey(
      const Key('nativeClosure.operationGroup.newest123456.phase.terminal.4'),
    );
    await tester.ensureVisible(terminalPhase);
    expect(terminalPhase, findsOneWidget);
    expect(
      find.byKey(
        const Key(
          'nativeClosure.operationGroup.newest123456.phase.upload-provider.3',
        ),
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(
        const Key(
          'nativeClosure.operationGroup.newest123456.phase.upload-provider.2',
        ),
      ),
      findsNothing,
    );

    final rawGroup = find.byKey(
      const Key('nativeClosure.operationGroup.newest123456.raw'),
    );
    await tester.ensureVisible(rawGroup);
    await tester.tap(rawGroup);
    await tester.pumpAndSettle();

    expect(
      find.textContaining('2. MKS-TRN-001 / upload-provider'),
      findsOneWidget,
    );
    expect(find.textContaining('correlation #corr0002'), findsOneWidget);
  });

  testWidgets('Genuine failed terminal remains visible in operation group', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery(
      diagnostics: [
        _event(
          operation: 'failed123456',
          ordinal: 1,
          phase: 'download-transport',
          nativeCode: 'timeout',
          severity: 'ERROR',
          outcome: 'unknown',
          trustedResponseState: 'not-received',
        ),
        _event(
          operation: 'failed123456',
          ordinal: 2,
          phase: 'terminal',
          nativeCode:
              'client-operation-declaration:sync-failed:scope-client-operation',
          severity: 'ERROR',
          outcome: 'unknown',
        ),
      ],
    );
    final runner = _runner(query: query);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Newest operation: ordinary-sync #failed123456'),
      findsOneWidget,
    );
    expect(find.textContaining('failed /'), findsOneWidget);
    expect(find.textContaining('sync-failed'), findsWidgets);
  });

  testWidgets('Check hosted connection records one non-Sync attempt', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery();
    final hostedConnection = _FakeHostedConnectionCheck();
    final runner = _runner(
      query: query,
      hostedConnectionCheck: hostedConnection,
      outbox: _UploadingOutbox(),
    );

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const Key('nativeClosure.Check hosted connection')),
    );
    await tester.tap(
      find.byKey(const Key('nativeClosure.Check hosted connection')),
    );
    await tester.pumpAndSettle();

    expect(find.text('hosted-connection-ready'), findsOneWidget);
    expect(hostedConnection.checks, 1);
    expect(query.beginAttempts, 0);
    expect(query.beginDiagnosticAttempts, 1);
    expect(query.completedResults, ['hosted-connection-ready']);
    expect(
      query.completedDiagnosticAttempts.single.latestStage,
      'response-parsed',
    );
    expect(query.snapshots, greaterThanOrEqualTo(2));
  });

  testWidgets('Clear diagnostic history is confirmed and scoped to attempts', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1400, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final query = _FakeDiagnosticsQuery(populated: true);
    final runner = _runner(query: query);

    await tester.pumpWidget(
      MaterialApp(home: NativeClosurePage(runner: runner)),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(
      find.byKey(const Key('nativeClosure.Clear diagnostic history')),
    );
    await tester.tap(
      find.byKey(const Key('nativeClosure.Clear diagnostic history')),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('nativeClosure.clear.confirm')));
    await tester.pumpAndSettle();

    expect(query.cleared, isTrue);
    expect(find.text('diagnostic-history-cleared'), findsOneWidget);
  });

  testWidgets(
    'Retry unknown-outcome submission cancellation does not start Sync',
    (tester) async {
      tester.view.physicalSize = const Size(1400, 2200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final query = _FakeDiagnosticsQuery(
        populated: true,
        unknownPreflight: const UnknownSubmissionRetryPreflight.eligible(
          submissionFingerprint: 'subm1234',
          eventCount: 2,
          firstDeviceSequence: 1,
          lastDeviceSequence: 2,
          nextLocalDeviceSequence: 3,
        ),
      );
      final runner = _runner(query: query, outbox: _UploadingOutbox());

      await tester.pumpWidget(
        MaterialApp(home: NativeClosurePage(runner: runner)),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(const Key('nativeClosure.Retry unknown-outcome submission')),
      );
      await tester.tap(
        find.byKey(const Key('nativeClosure.Retry unknown-outcome submission')),
      );
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('nativeClosure.retry.guidance')),
        findsOneWidget,
      );
      expect(find.textContaining('Events 1-2'), findsOneWidget);
      expect(find.textContaining('#subm1234'), findsOneWidget);
      expect(
        find.textContaining('Hosted outcome is unresolved'),
        findsOneWidget,
      );

      await tester.tap(find.text('Cancel').last);
      await tester.pumpAndSettle();

      expect(find.text('unknown-retry-cancelled'), findsOneWidget);
      expect(query.beginAttempts, 0);
    },
  );

  testWidgets(
    'Retry unknown-outcome submission confirms and refreshes diagnostics',
    (tester) async {
      tester.view.physicalSize = const Size(1400, 2200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final query = _FakeDiagnosticsQuery(
        populated: true,
        unknownPreflight: const UnknownSubmissionRetryPreflight.eligible(
          submissionFingerprint: 'subm1234',
          eventCount: 2,
          firstDeviceSequence: 1,
          lastDeviceSequence: 2,
          nextLocalDeviceSequence: 3,
        ),
      );
      final runner = _runner(query: query, outbox: _UploadingOutbox());

      await tester.pumpWidget(
        MaterialApp(home: NativeClosurePage(runner: runner)),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(const Key('nativeClosure.Retry unknown-outcome submission')),
      );
      await tester.tap(
        find.byKey(const Key('nativeClosure.Retry unknown-outcome submission')),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('nativeClosure.retry.confirm')));
      await tester.pumpAndSettle();

      expect(find.text('sync-completed'), findsOneWidget);
      expect(query.beginDiagnosticAttempts, 1);
      expect(query.completedResults, ['sync-completed']);
      expect(query.snapshots, greaterThanOrEqualTo(2));
    },
  );

  testWidgets(
    'Retry unknown-outcome submission blocked preflight is non-mutating',
    (tester) async {
      tester.view.physicalSize = const Size(1400, 2200);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final query = _FakeDiagnosticsQuery(
        populated: true,
        unknownPreflight: const UnknownSubmissionRetryPreflight.blocked(
          state: 'unknown-retry-state-invalid',
          guidance: 'preserve-local-evidence-and-stop',
        ),
      );
      final runner = _runner(query: query, outbox: _UploadingOutbox());

      await tester.pumpWidget(
        MaterialApp(home: NativeClosurePage(runner: runner)),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(const Key('nativeClosure.Retry unknown-outcome submission')),
      );
      await tester.tap(
        find.byKey(const Key('nativeClosure.Retry unknown-outcome submission')),
      );
      await tester.pumpAndSettle();

      expect(find.text('unknown-retry-state-invalid'), findsOneWidget);
      expect(query.beginAttempts, 0);
      expect(
        find.byKey(const Key('nativeClosure.retry.confirm')),
        findsNothing,
      );
    },
  );

  test('runner records auth-required Sync terminal outcome once', () async {
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query, signedIn: false);

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'authentication-required');
    expect(query.beginDiagnosticAttempts, 1);
    expect(query.completedResults, ['authentication-required']);
  });

  test('runner records no-new-events Sync terminal outcome once', () async {
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query);

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-no-new-events');
    expect(query.beginDiagnosticAttempts, 1);
    expect(query.completedResults, ['sync-no-new-events']);
  });

  test('runner records completed Sync terminal outcome once', () async {
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query, outbox: _UploadingOutbox());

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-completed');
    expect(query.beginDiagnosticAttempts, 1);
    expect(query.completedResults, ['sync-completed']);
  });

  test(
    'ordinary Sync records ordered phase diagnostics and correlations',
    () async {
      final query = _FakeDiagnosticsQuery();
      final runner = _runner(query: query, outbox: _UploadingOutbox());

      final result = await runner.hostedSyncProbe();

      expect(result.state, 'sync-completed');
      final diagnostics = query.diagnosticEvents;
      expect(
        diagnostics.map((event) => event.phase),
        containsAllInOrder([
          'authentication',
          'binding',
          'upload-lease',
          'upload-transport',
          'upload-provider',
          'upload-result-persistence',
          'download-transport',
          'download-provider',
          'download-local-apply',
          'acknowledgement',
          'terminal',
        ]),
      );
      expect(
        diagnostics.map((event) => event.ordinal),
        List<int>.generate(diagnostics.length, (index) => index + 1),
      );
      expect(
        diagnostics.map((event) => event.operationId).toSet(),
        hasLength(1),
      );
      expect(
        diagnostics.map((event) => event.operationFingerprint).toSet(),
        hasLength(1),
      );
      expect(
        diagnostics.map((event) => event.correlationId).toSet(),
        hasLength(diagnostics.length),
      );
      for (final diagnostic in diagnostics) {
        expect(diagnostic.diagnosticVersion, 1);
        expect(diagnostic.correlationFingerprint, matches(r'^[a-f0-9]{12}$'));
        expect(diagnostic.resultPersistenceState, isNotEmpty);
      }
    },
  );

  test('ordinary Sync does not invoke failed notApplied recovery', () async {
    final query = _FakeDiagnosticsQuery();
    final outbox = _BlockedRecoveryOutbox();
    final runner = _runner(query: query, outbox: outbox);

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-no-new-events');
    expect(outbox.recoveries, 0);
    expect(
      query.diagnosticEvents.map((event) => event.phase),
      isNot(contains('failed-recovery')),
    );
    expect(query.completedResults, ['sync-no-new-events']);
  });

  test('ordinary Sync uploads genuinely pending events', () async {
    final query = _FakeDiagnosticsQuery();
    final transport = _CountingTransport();
    final runner = _runner(
      query: query,
      outbox: _UploadingOutbox(),
      transport: transport,
    );

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-completed');
    expect(transport.uploads, 1);
    expect(transport.downloads, 1);
    expect(transport.acknowledgements, 0);
  });

  test('runner records rejected Sync terminal outcome once', () async {
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(
      query: query,
      outbox: _UploadingOutbox(),
      transport: _RejectingTransport(),
    );

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-rejected');
    expect(query.beginDiagnosticAttempts, 1);
    expect(query.completedResults, ['sync-rejected']);
  });

  test('ordinary Sync lifecycle lines are structured and redacted', () async {
    final query = _FakeDiagnosticsQuery();
    final lines = <String>[];
    final runner = _runner(
      query: query,
      outbox: _UploadingOutbox(),
      lifecycleSink: lines.add,
    );

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-completed');
    expect(lines, isNotEmpty);
    final events = lines
        .map((line) => jsonDecode(line) as Map<String, Object?>)
        .toList();
    expect(events.first['event'], 'operation-started');
    expect(events.last['event'], 'operation-completed');
    expect(
      events.map((event) => event['declarationScope']).toSet(),
      containsAll({'client-operation', 'client-phase'}),
    );
    for (final event in events) {
      expect(event['operationKind'], 'ordinary-sync');
      expect(event['operationFingerprint'], matches(r'^[a-f0-9]{12}$'));
      expect(event['correlationFingerprint'], matches(r'^[a-f0-9]{12}$'));
      expect(event['configuredDeadlineMs'], 35000);
      expect(event['elapsedBand'], isA<String>());
      expect(event.containsKey('providerContactState'), isTrue);
      expect(event.containsKey('trustedResponseState'), isTrue);
      final serialized = jsonEncode(event);
      expect(serialized.contains('fixture-token'), isFalse);
      expect(serialized.contains('authorization'), isFalse);
      expect(serialized.contains('http'), isFalse);
      expect(serialized.contains('event-fixture'), isFalse);
      expect(serialized.contains('request-hash'), isFalse);
    }
    expect(
      events
          .where((event) => event['declarationScope'] == 'client-phase')
          .map((event) => event['correlationFingerprint'])
          .toSet()
          .length,
      greaterThan(1),
    );
  });

  test(
    'acknowledgement request preserves trusted download and committed apply',
    () async {
      final query = _FakeDiagnosticsQuery();
      final lines = <String>[];
      final applier = _CursorApplier(cursor: 'c10b:1');
      final runner = _runner(
        query: query,
        applier: applier,
        lifecycleSink: lines.add,
      );

      final result = await runner.hostedSyncProbe();

      expect(result.state, 'sync-completed');
      final ackRequest = query.diagnosticEvents.firstWhere(
        (event) =>
            event.phase == 'acknowledgement' &&
            event.nativeCode == 'acknowledgement-request-started',
      );
      expect(ackRequest.trustedResponseState, 'not-received');
      final terminalLifecycle = lines
          .map((line) => jsonDecode(line) as Map<String, Object?>)
          .lastWhere(
            (event) => event['declarationScope'] == 'client-operation',
          );
      expect(terminalLifecycle['trustedResponseState'], 'received');
      expect(terminalLifecycle['localMutationState'], 'committed');
      expect(terminalLifecycle['lastProvedPhase'], 'download-local-apply');
    },
  );

  test(
    'acknowledgement exception keeps committed apply in runner fallback',
    () async {
      final query = _FakeDiagnosticsQuery();
      final lines = <String>[];
      final applier = _CursorApplier(cursor: 'c10b:1');
      final runner = _runner(
        query: query,
        applier: applier,
        transport: _ThrowingAcknowledgementTransport(),
        lifecycleSink: lines.add,
      );

      final result = await runner.hostedSyncProbe();

      expect(result.state, 'sync-failed');
      final terminalLifecycle = lines
          .map((line) => jsonDecode(line) as Map<String, Object?>)
          .lastWhere(
            (event) => event['declarationScope'] == 'client-operation',
          );
      expect(terminalLifecycle['trustedResponseState'], 'received');
      expect(terminalLifecycle['localMutationState'], 'committed');
      expect(terminalLifecycle['lastProvedPhase'], 'download-local-apply');
      expect(terminalLifecycle['resultPersistenceState'], 'committed');
      expect(
        query.diagnosticEvents.map((event) => event.sanitizedExceptionClass),
        contains('arbitraryacknowledgementfailure'),
      );
    },
  );

  test('diagnostic begin failure is degraded while Sync continues', () async {
    final query = _FakeDiagnosticsQuery(throwBeginDiagnostic: true);
    final lines = <String>[];
    final runner = _runner(query: query, lifecycleSink: lines.add);

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-no-new-events');
    expect(query.diagnosticEvents, isEmpty);
    final events = lines
        .map((line) => jsonDecode(line) as Map<String, Object?>)
        .toList();
    expect(
      events
          .where(
            (event) =>
                event['resultPersistenceState'] ==
                'diagnostics-persistence-degraded',
          )
          .length,
      greaterThan(1),
    );
    expect(events.last['event'], 'operation-completed');
  });

  test(
    'diagnostic row failure is degraded without changing commit truth',
    () async {
      final query = _FakeDiagnosticsQuery(throwDiagnosticEvents: true);
      final lines = <String>[];
      final applier = _CursorApplier(cursor: 'c10b:1');
      final transport = _CountingTransport();
      final runner = _runner(
        query: query,
        applier: applier,
        transport: transport,
        lifecycleSink: lines.add,
      );

      final result = await runner.hostedSyncProbe();

      expect(result.state, 'sync-completed');
      expect(transport.acknowledgements, 1);
      expect(query.diagnosticEvents, isEmpty);
      final terminalLifecycle = lines
          .map((line) => jsonDecode(line) as Map<String, Object?>)
          .lastWhere(
            (event) => event['declarationScope'] == 'client-operation',
          );
      expect(
        terminalLifecycle['resultPersistenceState'],
        'diagnostics-persistence-degraded',
      );
      expect(terminalLifecycle['localMutationState'], 'committed');
      expect(terminalLifecycle['trustedResponseState'], 'received');
    },
  );

  test(
    'diagnostic row failure while reporting rollback preserves rollback truth',
    () async {
      final query = _FakeDiagnosticsQuery(throwDiagnosticEvents: true);
      final lines = <String>[];
      final transport = _CountingTransport();
      final runner = _runner(
        query: query,
        applier: _FailingApplyApplier(),
        transport: transport,
        lifecycleSink: lines.add,
      );

      final result = await runner.hostedSyncProbe();

      expect(result.state, 'sync-failed');
      expect(transport.acknowledgements, 0);
      final terminalLifecycle = lines
          .map((line) => jsonDecode(line) as Map<String, Object?>)
          .lastWhere(
            (event) => event['declarationScope'] == 'client-operation',
          );
      expect(
        terminalLifecycle['resultPersistenceState'],
        'diagnostics-persistence-degraded',
      );
      expect(terminalLifecycle['trustedResponseState'], 'received');
      expect(terminalLifecycle['localMutationState'], 'rolled-back');
    },
  );

  test(
    'diagnostic completion failure is degraded after committed apply',
    () async {
      final query = _FakeDiagnosticsQuery(throwCompleteSyncAttempt: true);
      final lines = <String>[];
      final applier = _CursorApplier(cursor: 'c10b:1');
      final runner = _runner(
        query: query,
        applier: applier,
        lifecycleSink: lines.add,
      );

      final result = await runner.hostedSyncProbe();

      expect(result.state, 'sync-completed');
      final terminalLifecycle = lines
          .map((line) => jsonDecode(line) as Map<String, Object?>)
          .lastWhere(
            (event) => event['declarationScope'] == 'client-operation',
          );
      expect(
        terminalLifecycle['resultPersistenceState'],
        'diagnostics-persistence-degraded',
      );
      expect(terminalLifecycle['localMutationState'], 'committed');
      expect(terminalLifecycle['trustedResponseState'], 'received');
    },
  );

  test('lifecycle sink failure does not alter ordinary Sync result', () async {
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(
      query: query,
      lifecycleSink: (_) => throw StateError('redacted'),
    );

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-no-new-events');
    expect(query.completedResults, ['sync-no-new-events']);
  });

  test('runner records failed Sync terminal outcome once', () async {
    final query = _FakeDiagnosticsQuery();
    final runner = _runner(query: query, transport: _TimeoutTransport());

    final result = await runner.hostedSyncProbe();

    expect(result.state, 'sync-failed');
    expect(query.beginDiagnosticAttempts, 1);
    expect(query.completedResults, ['sync-failed']);
  });

  test(
    'runner retry blocks before ledger when preflight is ineligible',
    () async {
      final query = _FakeDiagnosticsQuery(
        unknownPreflight: const UnknownSubmissionRetryPreflight.blocked(
          state: 'unknown-retry-no-unresolved-submission',
          guidance: 'no-local-sync-action-needed',
        ),
      );
      final runner = _runner(query: query, outbox: _UploadingOutbox());

      final result = await runner.retryUnresolvedSubmission();

      expect(result.state, 'unknown-retry-no-unresolved-submission');
      expect(query.beginAttempts, 0);
      expect(query.completedResults, isEmpty);
    },
  );

  testWidgets(
    'failed notApplied recovery cancellation does not mutate or contact provider',
    (tester) async {
      tester.view.physicalSize = const Size(1400, 2400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final query = _FakeDiagnosticsQuery(
        populated: true,
        failedInspection: _eligibleFailedInspection(),
      );
      final transport = _CountingTransport();
      final outbox = _ExactRecoveryOutbox();
      final runner = _runner(
        query: query,
        outbox: outbox,
        transport: transport,
      );

      await tester.pumpWidget(
        MaterialApp(home: NativeClosurePage(runner: runner)),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.byKey(
          const Key('nativeClosure.Recover failed/notApplied candidate'),
        ),
      );
      await tester.tap(
        find.byKey(
          const Key('nativeClosure.Recover failed/notApplied candidate'),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        find.byKey(const Key('nativeClosure.failedRecovery.guidance')),
        findsOneWidget,
      );
      await tester.tap(find.text('Cancel').last);
      await tester.pumpAndSettle();

      expect(
        find.text('failed-not-applied-recovery-cancelled'),
        findsOneWidget,
      );
      expect(outbox.recoveries, 0);
      expect(transport.uploads, 0);
    },
  );

  testWidgets(
    'failed notApplied recovery confirms one upload and disables second run',
    (tester) async {
      tester.view.physicalSize = const Size(1400, 2600);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final query = _FakeDiagnosticsQuery(
        populated: true,
        failedInspection: _eligibleFailedInspection(),
      );
      final transport = _CountingTransport();
      final outbox = _ExactRecoveryOutbox();
      final runner = _runner(
        query: query,
        outbox: outbox,
        transport: transport,
      );

      await tester.pumpWidget(
        MaterialApp(home: NativeClosurePage(runner: runner)),
      );
      await tester.pumpAndSettle();
      final action = find.byKey(
        const Key('nativeClosure.Recover failed/notApplied candidate'),
      );
      await tester.ensureVisible(action);
      await tester.tap(action);
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(const Key('nativeClosure.failedRecovery.confirm')),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('failed-not-applied-recovery-upload-persisted'),
        findsOneWidget,
      );
      expect(outbox.recoveries, 1);
      expect(outbox.exactLeases, 1);
      expect(outbox.persisted, 1);
      expect(transport.uploads, 1);
      expect(transport.downloads, 0);
      expect(transport.acknowledgements, 0);
      expect(
        query.completedResults.last,
        'failed-not-applied-recovery-upload-persisted',
      );
      expect(
        query.diagnosticEvents.map((event) => event.phase),
        containsAllInOrder([
          'authorization-preflight',
          'binding',
          'failed-recovery-preflight',
          'failed-recovery-local-transition',
          'recovered-batch-validation',
          'upload-lease',
          'upload-transport',
          'upload-provider',
          'upload-result-persistence',
          'terminal',
        ]),
      );
      expect(
        query.diagnosticEvents.where((event) => event.code == 'MKS-UI-004'),
        isEmpty,
      );
    },
  );
}

FailedNotAppliedRecoveryInspection _eligibleFailedInspection() {
  return const FailedNotAppliedRecoveryInspection.eligible(
    diagnosticCode: 'MKS-REC-001',
    candidateFingerprint: 'candidate123',
    memberCount: 2,
    firstDeviceSequence: 1,
    lastDeviceSequence: 2,
    nextDeviceSequence: 3,
    queueCounts: ClosureQueueCounts(
      pending: 0,
      uploading: 0,
      failed: 2,
      unknown: 0,
    ),
    requestHashMatches: true,
    membershipContiguous: true,
    deviceScopeMatches: true,
    eventStatesCompatible: true,
    noAcceptedMembers: true,
    noActiveOverlap: true,
  );
}

NativeAuthClosureRunner _runner({
  required _FakeDiagnosticsQuery query,
  bool signedIn = true,
  SyncOutboxRepository? outbox,
  SyncTransport? transport,
  RemoteEventApplier? applier,
  HostedConnectionCheckPort? hostedConnectionCheck,
  NativeClosureLifecycleSink? lifecycleSink,
}) {
  final auth = LabAuthenticationSession(signedIn: signedIn);
  final enrollmentTransport = _FakeEnrollmentTransport();
  final syncOutbox = outbox ?? _NoopOutbox();
  final syncTransport = transport ?? _NoopTransport();
  final syncApplier = applier ?? _NoopApplier();
  return NativeAuthClosureRunner(
    authenticationSession: auth,
    enrollmentCoordinator: HostedEnrollmentCoordinator(
      authenticationSession: auth,
      tokenSource: LabAccessTokenSource.accepted('fixture-token'),
      transport: enrollmentTransport,
      repository: _MemoryHostedIdentityRepository(),
      now: DateTime.now,
    ),
    environmentAlias: 'provider-native',
    commandFactory: () async => const DeviceEnrollmentCommand(
      contractVersion: 1,
      installationId: 'install-fixture',
      enrollmentRequestId: 'request-fixture',
      platform: 'windows',
      applicationId: 'markei.windows',
      applicationVersion: '1.0.0',
    ),
    diagnosticsQuery: query,
    syncAttemptRecorder: query,
    hostedSyncCoordinator: HostedSyncCoordinator(
      authenticationSession: auth,
      syncGuard: const _AllowedGuard(),
      applier: syncApplier,
      recoverFailedNotApplied: RecoverFailedNotApplied(syncOutbox),
      uploadPendingEvents: UploadPendingEvents(syncOutbox, syncTransport),
      downloadAndApplyEvents: DownloadAndApplyEvents(
        syncTransport,
        syncApplier,
      ),
      acknowledgeAppliedCursor: AcknowledgeAppliedCursor(
        syncTransport,
        syncApplier,
      ),
    ),
    failedNotAppliedRecoveryCoordinator: FailedNotAppliedRecoveryCoordinator(
      authenticationSession: auth,
      syncGuard: const _AllowedGuard(),
      diagnosticsQuery: query,
      outbox: syncOutbox,
      transport: syncTransport,
    ),
    hostedConnectionCheck:
        hostedConnectionCheck ?? _FakeHostedConnectionCheck(),
    lifecycleSink: lifecycleSink,
  );
}

final class _FakeDiagnosticsQuery
    implements ClosureDiagnosticsQuery, SyncAttemptRecorder {
  _FakeDiagnosticsQuery({
    this.populated = false,
    this.unknownPreflight,
    this.failedInspection,
    this.diagnostics = const [],
    this.throwBeginDiagnostic = false,
    this.throwDiagnosticEvents = false,
    this.throwCompleteSyncAttempt = false,
  });

  final bool populated;
  final UnknownSubmissionRetryPreflight? unknownPreflight;
  final FailedNotAppliedRecoveryInspection? failedInspection;
  final List<ClosureDiagnosticEventSummary> diagnostics;
  final bool throwBeginDiagnostic;
  final bool throwDiagnosticEvents;
  final bool throwCompleteSyncAttempt;
  var snapshots = 0;
  var beginAttempts = 0;
  var beginDiagnosticAttempts = 0;
  var cleared = false;
  final completedResults = <String>[];
  final completedDiagnosticAttempts = <_CompletedDiagnosticAttempt>[];
  final diagnosticEvents = <SyncDiagnosticEnvelope>[];

  @override
  Future<int> beginSyncAttempt() async {
    beginAttempts++;
    return beginAttempts;
  }

  @override
  Future<int> beginDiagnosticAttempt({
    required String operationKind,
    required String latestStage,
    required String resultCode,
    required String outcomeClass,
    required String correlationFingerprint,
  }) async {
    beginDiagnosticAttempts++;
    if (throwBeginDiagnostic) throw StateError('redacted');
    return beginDiagnosticAttempts + 100;
  }

  @override
  Future<void> completeSyncAttempt(
    int attemptId, {
    required String resultCode,
    required String outcomeClass,
    required String phase,
    String? recoveryCode,
  }) async {
    if (throwCompleteSyncAttempt) throw StateError('redacted');
    completedResults.add(resultCode);
  }

  @override
  Future<void> completeDiagnosticAttempt(
    int attemptId, {
    required String operationKind,
    required String latestStage,
    required String resultCode,
    required String outcomeClass,
    required String recoveryCode,
    required String correlationFingerprint,
    required String elapsedBand,
    int? httpStatus,
    required bool responseHeadersReceived,
  }) async {
    completedResults.add(resultCode);
    completedDiagnosticAttempts.add(
      _CompletedDiagnosticAttempt(
        latestStage: latestStage,
        resultCode: resultCode,
        correlationFingerprint: correlationFingerprint,
        httpStatus: httpStatus,
        responseHeadersReceived: responseHeadersReceived,
      ),
    );
  }

  @override
  Future<void> clearAttemptHistory() async {
    cleared = true;
  }

  @override
  Future<int> recordDiagnosticEvent(SyncDiagnosticEnvelope diagnostic) async {
    if (throwDiagnosticEvents) throw StateError('redacted');
    diagnosticEvents.add(diagnostic);
    return diagnostic.ordinal;
  }

  @override
  Future<FailedNotAppliedRecoveryInspection> inspectFailedNotAppliedRecovery({
    required String authenticationState,
    required String operationFingerprint,
  }) async {
    final inspection = failedInspection;
    if (inspection != null) return inspection;
    return FailedNotAppliedRecoveryInspection.blocked(
      diagnosticCode: 'MKS-REC-012',
      state: 'failed-not-applied-no-candidate',
      queueCounts: ClosureQueueCounts(
        pending: populated ? 1 : 0,
        uploading: 0,
        failed: populated ? 1 : 0,
        unknown: populated ? 1 : 0,
      ),
    );
  }

  @override
  Future<UnknownSubmissionRetryPreflight> unknownSubmissionRetryPreflight({
    required String authenticationState,
  }) async {
    return unknownPreflight ??
        const UnknownSubmissionRetryPreflight.blocked(
          state: 'unknown-retry-no-unresolved-submission',
          guidance: 'no-local-sync-action-needed',
        );
  }

  @override
  Future<ClosureDiagnosticsSnapshot> snapshot({
    required String authenticationState,
  }) async {
    snapshots++;
    return ClosureDiagnosticsSnapshot(
      authenticationState: authenticationState,
      enrollmentState: 'device-enrolled',
      syncReadiness: populated
          ? 'failed-work-needs-review'
          : 'ready-no-local-work',
      lastResult: populated ? 'sync-failed' : 'no-recorded-attempts',
      queueCounts: ClosureQueueCounts(
        pending: populated ? 1 : 0,
        uploading: 0,
        failed: populated ? 1 : 0,
        unknown: populated ? 1 : 0,
      ),
      nextDeviceSequence: 3,
      lastSuccessfulSyncAt: null,
      recoveryGuidance: populated
          ? 'review-local-sync-state-before-retry'
          : 'no-local-sync-action-needed',
      recentAttempts: populated
          ? [
              ClosureSyncAttemptSummary(
                fingerprint: 'attempt1',
                startedAt: DateTime.utc(2026, 7, 21),
                completedAt: DateTime.utc(2026, 7, 21, 0, 0, 1),
                duration: const Duration(seconds: 1),
                phase: 'transport-or-closure',
                operationKind: 'ordinary-sync',
                latestStage: 'transport-or-closure',
                resultCode: 'sync-failed',
                outcomeClass: 'failed',
                recoveryCode: 'preserve-evidence-and-inspect-diagnostics',
                correlationFingerprint: null,
                elapsedBand: null,
                httpStatus: null,
                responseHeadersReceived: false,
              ),
            ]
          : const [],
      devices: const [
        ClosureDeviceSummary(
          fingerprint: 'device1',
          isCurrent: true,
          enrollmentState: 'device-enrolled',
          nextSequence: 3,
        ),
      ],
      recentDiagnostics: diagnostics,
      actionableEvents: populated
          ? [
              ClosureActionableEventSummary(
                fingerprint: 'event1',
                eventType: 'purchase.registered.v3',
                deviceSequence: 1,
                state: 'failed',
                enqueuedAt: DateTime.utc(2026, 7, 21),
                occurredAt: DateTime.utc(2026, 7, 21),
              ),
            ]
          : const [],
      refreshedAt: DateTime.utc(2026, 7, 21),
    );
  }
}

ClosureDiagnosticEventSummary _event({
  required String operation,
  required int ordinal,
  String operationKind = 'ordinary-sync',
  required String phase,
  String code = 'MKS-TRN-001',
  required String nativeCode,
  String severity = 'INFO',
  required String outcome,
  String trustedResponseState = 'received',
  String? sanitizedExceptionClass,
}) {
  return ClosureDiagnosticEventSummary(
    attemptFingerprint: 'attempt-$operation',
    diagnosticVersion: 1,
    ordinal: ordinal,
    code: code,
    nativeCode: nativeCode,
    severity: severity,
    outcome: outcome,
    operationKind: operationKind,
    phase: phase,
    lastProvedPhase: phase,
    operationFingerprint: operation,
    correlationFingerprint: 'corr${ordinal.toString().padLeft(4, '0')}',
    localMutationState: 'none',
    providerContactState: 'request-started',
    providerTransactionState: 'unknown',
    trustedResponseState: trustedResponseState,
    resultPersistenceState: outcome == 'applied' ? 'committed' : 'not-started',
    queueScope: 'current-device',
    pendingCount: null,
    uploadingCount: null,
    failedCount: null,
    unknownCount: null,
    memberCount: null,
    firstDeviceSequence: null,
    lastDeviceSequence: null,
    nextDeviceSequence: null,
    httpStatus: null,
    responseHeadersReceived: false,
    safeAction: 'inspect grouped diagnostics',
    retryable: false,
    sanitizedExceptionClass: sanitizedExceptionClass,
  );
}

final class _CompletedDiagnosticAttempt {
  const _CompletedDiagnosticAttempt({
    required this.latestStage,
    required this.resultCode,
    required this.correlationFingerprint,
    required this.httpStatus,
    required this.responseHeadersReceived,
  });

  final String latestStage;
  final String resultCode;
  final String correlationFingerprint;
  final int? httpStatus;
  final bool responseHeadersReceived;
}

final class _FakeHostedConnectionCheck implements HostedConnectionCheckPort {
  var checks = 0;

  @override
  HostedConnectionCorrelation createCorrelation() {
    return const HostedConnectionCorrelation(
      value: 'correlation-fixture',
      fingerprint: 'corr1234',
    );
  }

  @override
  Future<HostedConnectionCheckResult> check(
    HostedConnectionCorrelation correlation,
  ) async {
    checks++;
    return HostedConnectionCheckResult(
      correlationFingerprint: correlation.fingerprint,
      latestStage: 'response-parsed',
      resultCode: 'hosted-connection-ready',
      outcomeClass: 'completed',
      recoveryCode: 'ready-does-not-prove-sync',
      liveReachable: true,
      ready: true,
      elapsedBand: 'lt-1s',
      responseHeadersReceived: true,
      httpStatus: 200,
    );
  }
}

final class _AllowedGuard implements HostedSyncGuard {
  const _AllowedGuard();

  @override
  Future<HostedSyncDecision> evaluate(String environmentAlias) async =>
      const HostedSyncDecision.allowed('device-fixture');
}

class _NoopOutbox implements SyncOutboxRepository {
  @override
  Future<SyncUploadSubmission?> leasePending({required int limit}) async =>
      null;

  @override
  Future<FailedNotAppliedRecoveredBatch> recoverExactFailedNotAppliedCandidate(
    FailedNotAppliedRecoveryConfirmation confirmation,
  ) {
    throw SyncBatchPreflightException(
      const SyncResult(
        code: SyncStatusCode.failedRecoveryBlocked,
        outcome: SyncOutcome.notApplied,
        retryable: false,
        protocolCode: 'failed-recovery-blocked',
      ),
    );
  }

  @override
  Future<SyncUploadSubmission> leaseExactRecoveredBatch(
    FailedNotAppliedRecoveredBatch batch,
  ) {
    throw SyncBatchPreflightException(
      const SyncResult(
        code: SyncStatusCode.failedRecoveryBlocked,
        outcome: SyncOutcome.notApplied,
        retryable: false,
        protocolCode: 'failed-recovery-blocked',
      ),
    );
  }

  @override
  Future<void> persistUploadResult(
    String submissionId,
    SyncResult result,
  ) async {}

  @override
  Future<SyncResult> recoverFailedNotApplied(String submissionId) async =>
      const SyncResult(
        code: SyncStatusCode.noRecoverableFailure,
        outcome: SyncOutcome.notApplied,
        retryable: false,
      );

  @override
  Future<SyncResult> recoverOneFailedNotApplied() async => const SyncResult(
    code: SyncStatusCode.noRecoverableFailure,
    outcome: SyncOutcome.notApplied,
    retryable: false,
  );
}

final class _UploadingOutbox extends _NoopOutbox {
  @override
  Future<SyncUploadSubmission?> leasePending({required int limit}) async =>
      const SyncUploadSubmission(
        id: 'submission-fixture',
        deviceId: 'device-fixture',
        requestHash: 'request-hash',
        events: [
          {'eventId': 'event-fixture'},
        ],
      );
}

final class _ExactRecoveryOutbox extends _NoopOutbox {
  var recoveries = 0;
  var exactLeases = 0;
  var persisted = 0;

  @override
  Future<FailedNotAppliedRecoveredBatch> recoverExactFailedNotAppliedCandidate(
    FailedNotAppliedRecoveryConfirmation confirmation,
  ) async {
    recoveries++;
    expect(confirmation.candidateFingerprint, 'candidate123');
    expect(confirmation.memberCount, 2);
    return const FailedNotAppliedRecoveredBatch(
      submissionId: 'internal-submission-id',
      candidateFingerprint: 'candidate123',
      memberCount: 2,
      firstDeviceSequence: 1,
      lastDeviceSequence: 2,
      nextDeviceSequence: 3,
    );
  }

  @override
  Future<SyncUploadSubmission> leaseExactRecoveredBatch(
    FailedNotAppliedRecoveredBatch batch,
  ) async {
    exactLeases++;
    return const SyncUploadSubmission(
      id: 'upload-submission',
      deviceId: 'device-fixture',
      requestHash: 'request-hash',
      events: [
        {'eventId': 'one', 'deviceSequence': 1},
        {'eventId': 'two', 'deviceSequence': 2},
      ],
    );
  }

  @override
  Future<void> persistUploadResult(
    String submissionId,
    SyncResult result,
  ) async {
    persisted++;
    expect(submissionId, 'upload-submission');
    expect(result.code, SyncStatusCode.serverAccepted);
  }
}

final class _BlockedRecoveryOutbox extends _NoopOutbox {
  var recoveries = 0;

  @override
  Future<SyncResult> recoverOneFailedNotApplied() async {
    recoveries++;
    return const SyncResult(
      code: SyncStatusCode.failedRecoveryBlocked,
      outcome: SyncOutcome.notApplied,
      retryable: false,
    );
  }
}

final class _CountingTransport extends _NoopTransport {
  var uploads = 0;
  var downloads = 0;
  var acknowledgements = 0;

  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) async {
    uploads++;
    final sequences = submission.events
        .map((event) => event['deviceSequence'])
        .whereType<int>()
        .toList();
    if (sequences.isNotEmpty) {
      expect(sequences, [1, 2]);
    }
    return const SyncResult(
      code: SyncStatusCode.serverAccepted,
      outcome: SyncOutcome.applied,
      retryable: false,
    );
  }

  @override
  Future<DownloadPage> downloadAfter(String? cursor, {required int limit}) {
    downloads++;
    return super.downloadAfter(cursor, limit: limit);
  }

  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) {
    acknowledgements++;
    return super.acknowledge(greatestContiguousCursor);
  }
}

final class _ThrowingAcknowledgementTransport extends _NoopTransport {
  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) {
    throw ArbitraryAcknowledgementFailure();
  }
}

final class ArbitraryAcknowledgementFailure implements Exception {}

class _NoopTransport implements SyncTransport {
  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) async =>
      const SyncResult(
        code: SyncStatusCode.acknowledged,
        outcome: SyncOutcome.applied,
        retryable: false,
      );

  @override
  Future<DownloadPage> downloadAfter(
    String? cursor, {
    required int limit,
  }) async => const DownloadPage(nextCursor: null, events: []);

  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) async =>
      const SyncResult(
        code: SyncStatusCode.serverAccepted,
        outcome: SyncOutcome.applied,
        retryable: false,
      );
}

final class _TimeoutTransport extends _NoopTransport {
  @override
  Future<DownloadPage> downloadAfter(String? cursor, {required int limit}) {
    throw TimeoutException('redacted');
  }
}

final class _RejectingTransport extends _NoopTransport {
  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) async =>
      const SyncResult(
        code: SyncStatusCode.serviceUnavailable,
        outcome: SyncOutcome.notApplied,
        retryable: false,
        protocolCode: 'service-unavailable',
      );
}

final class _NoopApplier implements RemoteEventApplier {
  @override
  Future<SyncResult> applyPage(DownloadPage page) async => const SyncResult(
    code: SyncStatusCode.downloadReceived,
    outcome: SyncOutcome.applied,
    retryable: false,
  );

  @override
  Future<String?> greatestContiguousAppliedCursor() async => null;
}

final class _CursorApplier extends _NoopApplier {
  _CursorApplier({required this.cursor});

  final String? cursor;

  @override
  Future<String?> greatestContiguousAppliedCursor() async => cursor;
}

final class _FailingApplyApplier extends _NoopApplier {
  @override
  Future<SyncResult> applyPage(DownloadPage page) async => const SyncResult(
    code: SyncStatusCode.unknownOutcome,
    outcome: SyncOutcome.unknown,
    retryable: false,
    protocolCode: 'unexpected-local-apply-failed',
    sanitizedExceptionClass: 'unexpected-local-apply-failure',
  );
}

final class _FakeEnrollmentTransport implements DeviceEnrollmentTransport {
  @override
  Future<DeviceEnrollmentTransportResult> enroll(
    DeviceEnrollmentCommand command,
    String bearerCredential,
  ) async => const DeviceEnrollmentTransportUnavailable();

  @override
  Future<DeviceEnrollmentTransportResult> query(
    String enrollmentRequestId,
    String bearerCredential,
  ) async => const DeviceEnrollmentTransportUnavailable();
}

final class _MemoryHostedIdentityRepository
    implements HostedIdentityRepository {
  HostedIdentityState? state;

  @override
  Future<HostedIdentityState?> load(String environmentAlias) async => state;

  @override
  Future<void> save(HostedIdentityState state) async {
    this.state = state;
  }
}
