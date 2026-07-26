import 'package:flutter/material.dart';

import '../../application/closure_diagnostics.dart';
import '../../domain/sync/sync_diagnostic_registry.g.dart';
import '../native_auth_closure_runner.dart';

class NativeClosurePage extends StatefulWidget {
  const NativeClosurePage({required this.runner, super.key});

  final NativeAuthClosureRunner runner;

  @override
  State<NativeClosurePage> createState() => _NativeClosurePageState();
}

class _NativeClosurePageState extends State<NativeClosurePage> {
  String _state = 'closure-disabled';
  bool _running = false;
  ClosureDiagnosticsSnapshot? _snapshot;
  _CurrentActionDiagnostic? _currentAction;

  @override
  void initState() {
    super.initState();
    _refreshDiagnostics();
  }

  @override
  Widget build(BuildContext context) {
    final actions = [
      _Action('Status', widget.runner.status),
      _Action('Sign in', widget.runner.signIn),
      _Action('Enroll', widget.runner.enrollOrQueryDevice),
      _Action('Query', widget.runner.queryEnrollment),
      _Action('Check hosted connection', widget.runner.checkHostedConnection),
      _Action('Sync', widget.runner.hostedSyncProbe),
      _Action('Logout', widget.runner.logout),
    ];
    final snapshot = _snapshot;
    return ListView(
      key: const Key('nativeClosure.page'),
      padding: const EdgeInsets.all(16),
      children: [
        Text('Native closure', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Text(
          _running ? 'action-running' : _state,
          key: const Key('nativeClosure.state'),
        ),
        const SizedBox(height: 16),
        if (_currentAction != null) ...[
          _CurrentActionCard(diagnostic: _currentAction!),
          const SizedBox(height: 12),
        ],
        if (snapshot == null)
          const _DiagnosticsCard(
            title: 'Sync overview',
            child: Text(
              'No locally recorded attempt history',
              key: Key('nativeClosure.diagnostics.empty'),
            ),
          )
        else ...[
          _SyncOverview(snapshot: snapshot),
          const SizedBox(height: 12),
          _LocalQueue(snapshot: snapshot),
          const SizedBox(height: 12),
          _Attempts(snapshot: snapshot),
          const SizedBox(height: 12),
          _DiagnosticTimeline(snapshot: snapshot),
          const SizedBox(height: 12),
          _Devices(snapshot: snapshot),
          const SizedBox(height: 12),
          _ActionableEvents(snapshot: snapshot),
        ],
        const SizedBox(height: 16),
        _DiagnosticsCard(
          title: 'Closure actions',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final action in actions)
                FilledButton(
                  key: Key('nativeClosure.${action.label}'),
                  onPressed: _running ? null : () => _run(action),
                  child: Text(action.label),
                ),
              OutlinedButton(
                key: const Key('nativeClosure.Refresh diagnostics'),
                onPressed: _running ? null : _refreshDiagnostics,
                child: const Text('Refresh diagnostics'),
              ),
              OutlinedButton(
                key: const Key(
                  'nativeClosure.Retry unknown-outcome submission',
                ),
                onPressed: _running ? null : _confirmRetryUnknownOutcome,
                child: const Text('Retry unknown-outcome submission'),
              ),
              OutlinedButton(
                key: const Key(
                  'nativeClosure.Inspect failed/notApplied recovery',
                ),
                onPressed: _running ? null : _inspectFailedNotApplied,
                child: const Text('Inspect failed/notApplied recovery'),
              ),
              OutlinedButton(
                key: const Key('nativeClosure.Clear diagnostic history'),
                onPressed: _running ? null : _confirmClearHistory,
                child: const Text('Clear diagnostic history'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _run(_Action action) async {
    setState(() => _running = true);
    try {
      final result = await action.run();
      final snapshot = await widget.runner.diagnostics();
      if (!mounted) return;
      setState(() {
        _state = result.state;
        _snapshot = snapshot;
        _running = false;
        final event = snapshot?.recentDiagnostics.firstOrNull;
        _currentAction = event == null
            ? _CurrentActionDiagnostic.fromState(
                state: result.state,
                code: result.state == 'sync-unavailable'
                    ? 'MKS-OBS-003'
                    : 'MKS-UI-003',
                operationFingerprint: 'not-recorded',
              )
            : _CurrentActionDiagnostic.fromEvent(event);
      });
    } on Object catch (error) {
      if (!mounted) return;
      setState(() {
        _state = 'closure-runner-exception';
        _running = false;
        _currentAction = _CurrentActionDiagnostic.fromState(
          state: 'closure-runner-exception',
          code: 'MKS-UI-006',
          operationFingerprint: 'local-page',
          sanitizedExceptionClass: error.runtimeType.toString(),
        );
      });
    }
  }

  Future<void> _refreshDiagnostics() async {
    final snapshot = await widget.runner.diagnostics();
    if (!mounted) return;
    setState(() => _snapshot = snapshot);
  }

  Future<void> _confirmRetryUnknownOutcome() async {
    final preflight = await widget.runner.unknownRetryPreflight();
    if (!mounted) return;
    if (!preflight.eligible) {
      final snapshot = await widget.runner.diagnostics();
      if (!mounted) return;
      setState(() {
        _state = preflight.state;
        _snapshot = snapshot;
        _currentAction = _CurrentActionDiagnostic.fromState(
          state: preflight.state,
          code: 'MKS-UI-001',
          operationFingerprint: 'local-preflight',
          pending: snapshot?.queueCounts.pending,
          uploading: snapshot?.queueCounts.uploading,
          failed: snapshot?.queueCounts.failed,
          unknown: snapshot?.queueCounts.unknown,
          nextSequence: snapshot?.nextDeviceSequence,
        );
      });
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Retry unknown-outcome submission'),
        content: Text(
          'This will retry the same unresolved submission without changing '
          'local events. Events ${preflight.firstDeviceSequence}-'
          '${preflight.lastDeviceSequence}; next local sequence '
          '${preflight.nextLocalDeviceSequence}; submission '
          '#${preflight.submissionFingerprint}. Hosted outcome is unresolved.',
          key: const Key('nativeClosure.retry.guidance'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const Key('nativeClosure.retry.confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      setState(() => _state = 'unknown-retry-cancelled');
      return;
    }
    setState(() => _running = true);
    final result = await widget.runner.retryUnresolvedSubmission();
    final snapshot = await widget.runner.diagnostics();
    if (!mounted) return;
    setState(() {
      _state = result.state;
      _snapshot = snapshot;
      _running = false;
    });
  }

  Future<void> _inspectFailedNotApplied() async {
    setState(() => _running = true);
    final result = await widget.runner.inspectFailedNotAppliedRecovery();
    final snapshot = await widget.runner.diagnostics();
    if (!mounted) return;
    final inspection = result.inspection;
    setState(() {
      _state = result.state;
      _snapshot = snapshot;
      _running = false;
      _currentAction = _CurrentActionDiagnostic.fromState(
        state: result.state,
        code: result.diagnosticCode,
        operationFingerprint: result.operationFingerprint,
        pending: inspection?.queueCounts.pending,
        uploading: inspection?.queueCounts.uploading,
        failed: inspection?.queueCounts.failed,
        unknown: inspection?.queueCounts.unknown,
        memberCount: inspection?.memberCount,
        firstSequence: inspection?.firstDeviceSequence,
        lastSequence: inspection?.lastDeviceSequence,
        nextSequence: inspection?.nextDeviceSequence,
        requestHashMatches: inspection?.requestHashMatches,
        membershipContiguous: inspection?.membershipContiguous,
        deviceScopeMatches: inspection?.deviceScopeMatches,
        eventStatesCompatible: inspection?.eventStatesCompatible,
        noAcceptedMembers: inspection?.noAcceptedMembers,
        noActiveOverlap: inspection?.noActiveOverlap,
      );
    });
  }

  Future<void> _confirmClearHistory() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear diagnostic history'),
        content: const Text('Only local Sync attempt history will be cleared.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const Key('nativeClosure.clear.confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() => _running = true);
    await widget.runner.clearDiagnosticHistory();
    final snapshot = await widget.runner.diagnostics();
    if (!mounted) return;
    setState(() {
      _state = 'diagnostic-history-cleared';
      _snapshot = snapshot;
      _running = false;
    });
  }
}

final class _CurrentActionDiagnostic {
  const _CurrentActionDiagnostic({
    required this.code,
    required this.title,
    required this.meaning,
    required this.outcome,
    required this.phase,
    required this.localMutation,
    required this.providerContact,
    required this.trustedResponse,
    required this.resultPersistence,
    required this.safeAction,
    required this.operationFingerprint,
    required this.nativeState,
    this.pending,
    this.uploading,
    this.failed,
    this.unknown,
    this.memberCount,
    this.firstSequence,
    this.lastSequence,
    this.nextSequence,
    this.requestHashMatches,
    this.membershipContiguous,
    this.deviceScopeMatches,
    this.eventStatesCompatible,
    this.noAcceptedMembers,
    this.noActiveOverlap,
    this.sanitizedExceptionClass,
  });

  factory _CurrentActionDiagnostic.fromState({
    required String state,
    required String code,
    required String operationFingerprint,
    int? pending,
    int? uploading,
    int? failed,
    int? unknown,
    int? memberCount,
    int? firstSequence,
    int? lastSequence,
    int? nextSequence,
    bool? requestHashMatches,
    bool? membershipContiguous,
    bool? deviceScopeMatches,
    bool? eventStatesCompatible,
    bool? noAcceptedMembers,
    bool? noActiveOverlap,
    String? sanitizedExceptionClass,
  }) {
    final definition = syncDiagnosticByCode(code);
    return _CurrentActionDiagnostic(
      code: code,
      title: definition?.title ?? code,
      meaning: definition?.meaning ?? 'Diagnostic meaning unavailable.',
      outcome: definition?.defaultOutcome ?? 'unknown',
      phase: state.contains('preflight') || code.startsWith('MKS-REC')
          ? 'failed-recovery-preflight'
          : 'presentation',
      localMutation: 'none',
      providerContact: 'not-started',
      trustedResponse: 'not-received',
      resultPersistence: 'not-started',
      safeAction:
          definition?.safeAction ?? 'preserve evidence and inspect diagnostics',
      operationFingerprint: operationFingerprint,
      nativeState: state,
      pending: pending,
      uploading: uploading,
      failed: failed,
      unknown: unknown,
      memberCount: memberCount,
      firstSequence: firstSequence,
      lastSequence: lastSequence,
      nextSequence: nextSequence,
      requestHashMatches: requestHashMatches,
      membershipContiguous: membershipContiguous,
      deviceScopeMatches: deviceScopeMatches,
      eventStatesCompatible: eventStatesCompatible,
      noAcceptedMembers: noAcceptedMembers,
      noActiveOverlap: noActiveOverlap,
      sanitizedExceptionClass: sanitizedExceptionClass,
    );
  }

  factory _CurrentActionDiagnostic.fromEvent(
    ClosureDiagnosticEventSummary event,
  ) {
    final definition = syncDiagnosticByCode(event.code);
    return _CurrentActionDiagnostic(
      code: event.code,
      title: definition?.title ?? event.code,
      meaning: definition?.meaning ?? 'Diagnostic meaning unavailable.',
      outcome: event.outcome,
      phase: event.lastProvedPhase,
      localMutation: event.localMutationState,
      providerContact: event.providerContactState,
      trustedResponse: event.trustedResponseState,
      resultPersistence: event.resultPersistenceState,
      safeAction: event.safeAction,
      operationFingerprint: event.operationFingerprint ?? 'not-recorded',
      nativeState: event.nativeCode ?? event.code,
      pending: event.pendingCount,
      uploading: event.uploadingCount,
      failed: event.failedCount,
      unknown: event.unknownCount,
      memberCount: event.memberCount,
      firstSequence: event.firstDeviceSequence,
      lastSequence: event.lastDeviceSequence,
      nextSequence: event.nextDeviceSequence,
    );
  }

  final String code;
  final String title;
  final String meaning;
  final String outcome;
  final String phase;
  final String localMutation;
  final String providerContact;
  final String trustedResponse;
  final String resultPersistence;
  final String safeAction;
  final String operationFingerprint;
  final String nativeState;
  final int? pending;
  final int? uploading;
  final int? failed;
  final int? unknown;
  final int? memberCount;
  final int? firstSequence;
  final int? lastSequence;
  final int? nextSequence;
  final bool? requestHashMatches;
  final bool? membershipContiguous;
  final bool? deviceScopeMatches;
  final bool? eventStatesCompatible;
  final bool? noAcceptedMembers;
  final bool? noActiveOverlap;
  final String? sanitizedExceptionClass;
}

final class _CurrentActionCard extends StatelessWidget {
  const _CurrentActionCard({required this.diagnostic});

  final _CurrentActionDiagnostic diagnostic;

  @override
  Widget build(BuildContext context) {
    return _DiagnosticsCard(
      title: 'Current action result',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _KeyValueGrid(
            children: [
              _DiagnosticValue('MKS code', diagnostic.code),
              _DiagnosticValue('Title', diagnostic.title),
              _DiagnosticValue('Outcome', diagnostic.outcome),
              _DiagnosticValue('Last proved phase', diagnostic.phase),
              _DiagnosticValue('Local mutation', diagnostic.localMutation),
              _DiagnosticValue('Provider contact', diagnostic.providerContact),
              _DiagnosticValue('Trusted response', diagnostic.trustedResponse),
              _DiagnosticValue(
                'Operation',
                '#${diagnostic.operationFingerprint}',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(diagnostic.meaning, key: const Key('nativeClosure.mks.meaning')),
          const SizedBox(height: 8),
          Text(
            diagnostic.safeAction,
            key: const Key('nativeClosure.mks.safeAction'),
          ),
          const SizedBox(height: 8),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: const Text('Sanitized technical details'),
            children: [
              _KeyValueGrid(
                children: [
                  _DiagnosticValue('Native state', diagnostic.nativeState),
                  _DiagnosticValue(
                    'Result persistence',
                    diagnostic.resultPersistence,
                  ),
                  _DiagnosticValue('Pending', _number(diagnostic.pending)),
                  _DiagnosticValue('Uploading', _number(diagnostic.uploading)),
                  _DiagnosticValue('Failed', _number(diagnostic.failed)),
                  _DiagnosticValue('Unknown', _number(diagnostic.unknown)),
                  _DiagnosticValue('Members', _number(diagnostic.memberCount)),
                  _DiagnosticValue(
                    'Sequence range',
                    _range(diagnostic.firstSequence, diagnostic.lastSequence),
                  ),
                  _DiagnosticValue(
                    'Next sequence',
                    _number(diagnostic.nextSequence),
                  ),
                  _DiagnosticValue(
                    'Request hash equality',
                    _bool(diagnostic.requestHashMatches),
                  ),
                  _DiagnosticValue(
                    'Contiguous membership',
                    _bool(diagnostic.membershipContiguous),
                  ),
                  _DiagnosticValue(
                    'Device scope',
                    _bool(diagnostic.deviceScopeMatches),
                  ),
                  _DiagnosticValue(
                    'Event states',
                    _bool(diagnostic.eventStatesCompatible),
                  ),
                  _DiagnosticValue(
                    'No accepted members',
                    _bool(diagnostic.noAcceptedMembers),
                  ),
                  _DiagnosticValue(
                    'No active overlap',
                    _bool(diagnostic.noActiveOverlap),
                  ),
                  _DiagnosticValue(
                    'Exception class',
                    diagnostic.sanitizedExceptionClass ?? 'Unavailable',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _DiagnosticTimeline extends StatelessWidget {
  const _DiagnosticTimeline({required this.snapshot});

  final ClosureDiagnosticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final events = snapshot.recentDiagnostics;
    return _DiagnosticsCard(
      title: 'Recent diagnostic timeline',
      child: events.isEmpty
          ? const Text(
              'No locally recorded diagnostic events',
              key: Key('nativeClosure.diagnosticTimeline.empty'),
            )
          : Column(
              key: const Key('nativeClosure.diagnosticTimeline'),
              children: [
                for (final event in events)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '${event.ordinal}. ${event.code} / ${event.phase}',
                    ),
                    subtitle: Text(
                      '${event.outcome} / last ${event.lastProvedPhase} / '
                      'mutation ${event.localMutationState} / '
                      'contact ${event.providerContactState} / '
                      'trusted ${event.trustedResponseState} / '
                      'persist ${event.resultPersistenceState}\n'
                      'operation #${event.operationFingerprint ?? 'not-recorded'} / '
                      'correlation #${event.correlationFingerprint ?? 'not-recorded'} / '
                      '${event.safeAction}',
                    ),
                  ),
              ],
            ),
    );
  }
}

final class _SyncOverview extends StatelessWidget {
  const _SyncOverview({required this.snapshot});

  final ClosureDiagnosticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _DiagnosticsCard(
      title: 'Sync overview',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _KeyValueGrid(
            children: [
              _DiagnosticValue('Authentication', snapshot.authenticationState),
              _DiagnosticValue('Enrollment', snapshot.enrollmentState),
              _DiagnosticValue('Readiness', snapshot.syncReadiness),
              _DiagnosticValue('Last result', snapshot.lastResult),
              _DiagnosticValue(
                'Last successful sync',
                _timeOrNotRecorded(snapshot.lastSuccessfulSyncAt),
              ),
              _DiagnosticValue('Recovery guidance', snapshot.recoveryGuidance),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Live means the API process answered. Ready means the API database '
            'readiness contract passed. Neither proves Sync success.',
            key: Key('nativeClosure.health.guidance'),
          ),
        ],
      ),
    );
  }
}

final class _LocalQueue extends StatelessWidget {
  const _LocalQueue({required this.snapshot});

  final ClosureDiagnosticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _DiagnosticsCard(
      title: 'Local queue',
      child: _KeyValueGrid(
        children: [
          _DiagnosticValue('Pending', '${snapshot.queueCounts.pending}'),
          _DiagnosticValue('Uploading', '${snapshot.queueCounts.uploading}'),
          _DiagnosticValue('Failed', '${snapshot.queueCounts.failed}'),
          _DiagnosticValue('Unknown', '${snapshot.queueCounts.unknown}'),
          _DiagnosticValue(
            'Next Device sequence',
            snapshot.nextDeviceSequence?.toString() ?? 'Unavailable',
          ),
        ],
      ),
    );
  }
}

final class _Attempts extends StatelessWidget {
  const _Attempts({required this.snapshot});

  final ClosureDiagnosticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final attempts = snapshot.recentAttempts;
    return _DiagnosticsCard(
      title: 'Recent sync attempts',
      child: attempts.isEmpty
          ? const Text(
              'No locally recorded attempt history',
              key: Key('nativeClosure.attempts.empty'),
            )
          : Column(
              key: const Key('nativeClosure.attempts'),
              children: [
                for (final attempt in attempts)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '${attempt.operationKind}: ${attempt.resultCode} '
                      '#${attempt.fingerprint}',
                    ),
                    subtitle: Text(
                      '${attempt.outcomeClass} / ${attempt.latestStage} / '
                      '${attempt.recoveryCode ?? 'no-recovery-code'}\n'
                      'correlation ${attempt.correlationFingerprint ?? 'not-recorded'} / '
                      'status ${attempt.httpStatus?.toString() ?? 'not-observed'} / '
                      'headers ${attempt.responseHeadersReceived ? 'received' : 'not-received'} / '
                      '${attempt.elapsedBand ?? _duration(attempt.duration)}',
                    ),
                  ),
              ],
            ),
    );
  }
}

final class _Devices extends StatelessWidget {
  const _Devices({required this.snapshot});

  final ClosureDiagnosticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final devices = snapshot.devices;
    return _DiagnosticsCard(
      title: 'Devices',
      child: devices.isEmpty
          ? const Text('Unavailable', key: Key('nativeClosure.devices.empty'))
          : Column(
              key: const Key('nativeClosure.devices'),
              children: [
                for (final device in devices)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '${device.isCurrent ? 'Current' : 'Device'} '
                      '#${device.fingerprint}',
                    ),
                    subtitle: Text(
                      '${device.enrollmentState} / next ${device.nextSequence}',
                    ),
                  ),
              ],
            ),
    );
  }
}

final class _ActionableEvents extends StatelessWidget {
  const _ActionableEvents({required this.snapshot});

  final ClosureDiagnosticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final events = snapshot.actionableEvents;
    return _DiagnosticsCard(
      title: 'Actionable events',
      child: events.isEmpty
          ? const Text(
              'No pending, failed or unknown events',
              key: Key('nativeClosure.events.empty'),
            )
          : Column(
              key: const Key('nativeClosure.events'),
              children: [
                for (final event in events)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text('${event.eventType} #${event.fingerprint}'),
                    subtitle: Text(
                      '${event.state} / sequence ${event.deviceSequence}',
                    ),
                  ),
              ],
            ),
    );
  }
}

final class _DiagnosticsCard extends StatelessWidget {
  const _DiagnosticsCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

final class _KeyValueGrid extends StatelessWidget {
  const _KeyValueGrid({required this.children});

  final List<_DiagnosticValue> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 720 ? 3 : 1;
        return GridView.count(
          crossAxisCount: columns,
          childAspectRatio: columns == 1 ? 5 : 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: children,
        );
      },
    );
  }
}

final class _DiagnosticValue extends StatelessWidget {
  const _DiagnosticValue(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Text(value, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

String _timeOrNotRecorded(DateTime? value) {
  return value == null ? 'Not recorded' : value.toUtc().toIso8601String();
}

String _duration(Duration? value) {
  if (value == null) return 'duration-unavailable';
  return '${value.inMilliseconds}ms';
}

String _number(int? value) => value?.toString() ?? 'Unavailable';

String _bool(bool? value) {
  if (value == null) return 'Unavailable';
  return value ? 'Yes' : 'No';
}

String _range(int? first, int? last) {
  if (first == null || last == null) return 'Unavailable';
  return '$first-$last';
}

final class _Action {
  const _Action(this.label, this.run);

  final String label;
  final Future<NativeClosureStatus> Function() run;
}
