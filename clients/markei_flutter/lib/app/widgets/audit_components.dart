import 'package:flutter/material.dart';

import '../../application/audit.dart';

class AuditStateView extends StatelessWidget {
  const AuditStateView({
    required this.state,
    required this.onRetry,
    required this.onNextPage,
    super.key,
  });

  final AuditWorkspaceState state;
  final VoidCallback onRetry;
  final VoidCallback onNextPage;

  @override
  Widget build(BuildContext context) {
    final page = state.page;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (state.kind == AuditWorkspaceKind.loading)
          const LinearProgressIndicator(key: Key('audit.loading.indicator')),
        if (state.kind == AuditWorkspaceKind.loading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text(
              'Loading locally recorded activity...',
              key: Key('audit.loading.copy'),
            ),
          ),
        if (state.kind == AuditWorkspaceKind.unavailable)
          _StatusPanel(
            key: const Key('audit.unavailable'),
            title: 'Local activity could not be loaded.',
            message:
                'Try loading local activity again. No Purchase or Sync data will be changed.',
            action: onRetry,
          ),
        if (state.kind == AuditWorkspaceKind.stale)
          _StatusPanel(
            key: const Key('audit.stale'),
            title: state.message ?? 'Displayed evidence is stale.',
            message:
                'Try loading local activity again. No Purchase or Sync data will be changed.',
            action: onRetry,
          ),
        if (page != null) ...[
          _AuditWindowHeader(page: page, onRetry: onRetry),
          const SizedBox(height: 12),
          if (page.records.isEmpty)
            const _EmptyAudit()
          else
            for (final record in page.records)
              _AuditAttemptCard(record: record),
          const SizedBox(height: 12),
          Row(
            children: [
              OutlinedButton(
                key: const Key('audit.retry'),
                onPressed: onRetry,
                child: const Text('Load local activity again'),
              ),
              const SizedBox(width: 8),
              FilledButton.tonal(
                key: const Key('audit.nextPage'),
                onPressed: page.nextCursor == null ? null : onNextPage,
                child: const Text('Older local attempts'),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _AuditWindowHeader extends StatelessWidget {
  const _AuditWindowHeader({required this.page, required this.onRetry});

  final AuditPageResult page;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final count = page.records.length;
    return Semantics(
      container: true,
      label:
          'Audit local activity window loaded at ${page.loadedAtUtc.toUtc().toIso8601String()} showing $count attempts',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Loaded locally at ${page.loadedAtUtc.toUtc().toIso8601String()}',
            key: const Key('audit.loadedAt'),
          ),
          const SizedBox(height: 4),
          Text(
            page.isPartialWindow
                ? 'Showing $count recent local attempts. Older records may exist.'
                : 'Showing $count recent local attempts in this local window.',
            key: const Key('audit.window.copy'),
          ),
          const SizedBox(height: 4),
          const Text(
            'A diagnostic code is a technical classification, not a cause. This view is local to this Account and environment.',
          ),
        ],
      ),
    );
  }
}

class _EmptyAudit extends StatelessWidget {
  const _EmptyAudit();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'No application activity has been recorded here yet.',
      key: Key('audit.empty'),
    );
  }
}

class _AuditAttemptCard extends StatelessWidget {
  const _AuditAttemptCard({required this.record});

  final AuditAttemptProjection record;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        key: Key('audit.attempt.${record.id.value}'),
        title: Text('${record.operationKind}: ${record.resultCode}'),
        subtitle: Text(
          '${record.outcomeClass} / ${record.latestStage} / ${record.startedAtUtc.toUtc().toIso8601String()}',
        ),
        children: [
          ListTile(
            title: const Text('Reference'),
            subtitle: Text(
              record.correlationReference ??
                  'This technical detail was not recorded.',
            ),
          ),
          ListTile(
            title: const Text('Device'),
            subtitle: Text(
              record.deviceReference ??
                  'Device attribution is unavailable for this record.',
            ),
          ),
          if (record.events.isEmpty)
            const ListTile(
              title: Text('Diagnostic events'),
              subtitle: Text('This technical detail was not recorded.'),
            )
          else
            for (final event in record.events)
              ListTile(
                key: Key('audit.event.${event.id.value}'),
                title: Text('${event.code}: ${event.title}'),
                subtitle: Text(
                  '${event.meaning}\n${event.guidance}\n${event.phase} / ${event.severity} / ${event.outcome}',
                ),
              ),
        ],
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel({
    required this.title,
    required this.message,
    required this.action,
    super.key,
  });

  final String title;
  final String message;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 8),
        Text(message),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: action,
          child: const Text('Retry local read'),
        ),
      ],
    );
  }
}
