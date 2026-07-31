import 'package:flutter/material.dart';

import '../../application/analytics.dart';
import '../../application/analytics_workspace.dart';
import '../../domain/analytics/analytics_models.dart';
import '../design/markei_theme.dart';
import '../widgets/analytics_components.dart';
import '../widgets/markei_components.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({
    required this.controller,
    required this.launchContext,
    required this.visible,
    super.key,
  });

  final AnalyticsWorkspaceController controller;
  final AnalyticsLaunchContext? launchContext;
  final bool visible;

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late Future<AnalyticsWorkspaceSnapshot> _loadFuture;

  @override
  void initState() {
    super.initState();
    widget.controller.setLaunchContext(widget.launchContext);
    _loadFuture = widget.visible
        ? widget.controller.load()
        : Future.value(widget.controller.snapshot);
  }

  @override
  void didUpdateWidget(covariant AnalyticsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.launchContext != widget.launchContext) {
      widget.controller.setLaunchContext(widget.launchContext);
    }
    if (!oldWidget.visible && widget.visible) {
      _loadFuture = widget.controller.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) {
      return const SizedBox.shrink();
    }
    return FutureBuilder<AnalyticsWorkspaceSnapshot>(
      future: _loadFuture,
      builder: (context, snapshot) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final layoutClass = MarkeiLayoutClass.fromWidth(
              constraints.maxWidth,
            );
            final state = snapshot.connectionState == ConnectionState.waiting
                ? (snapshot.data ?? widget.controller.snapshot)
                : widget.controller.snapshot;
            return _body(state, layoutClass);
          },
        );
      },
    );
  }

  Widget _body(
    AnalyticsWorkspaceSnapshot state,
    MarkeiLayoutClass layoutClass,
  ) {
    final wide = layoutClass == MarkeiLayoutClass.wide;
    return ListView(
      key: const Key('analytics.page'),
      children: [
        MarkeiPageHeader(
          title: 'Analytics',
          purpose:
              'Deterministic local calculations over this Account\'s recorded Purchase evidence.',
          icon: Icons.analytics_outlined,
          trailing: Text(
            '${state.rows.length} evidence row(s)',
            style: MarkeiText.metadata,
          ),
        ),
        const SizedBox(height: MarkeiSpacing.md),
        MarkeiSection(
          title: 'Local evidence scope',
          subtitle:
              'Loaded once from local Account evidence. Visible evidence is paged at 100 rows.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.historyContextMessage ??
                    'All local Account evidence is available.',
              ),
              if (state.message != null) ...[
                const SizedBox(height: MarkeiSpacing.xs),
                Text(state.message!, key: const Key('analytics.message')),
              ],
              const SizedBox(height: MarkeiSpacing.sm),
              Wrap(
                spacing: MarkeiSpacing.sm,
                children: [
                  FilledButton.icon(
                    key: const Key('analytics.card.create'),
                    onPressed: state.rows.isEmpty ? null : _createDefaultCard,
                    icon: const Icon(Icons.add),
                    label: const Text('New analysis card'),
                  ),
                  OutlinedButton.icon(
                    key: const Key('analytics.showAllEvidence'),
                    onPressed: () =>
                        setState(widget.controller.showAllEvidence),
                    icon: const Icon(Icons.visibility),
                    label: const Text('Show all evidence'),
                  ),
                  OutlinedButton.icon(
                    key: const Key('analytics.resetEvidence'),
                    onPressed: () => setState(widget.controller.resetEvidence),
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reset evidence'),
                  ),
                  OutlinedButton.icon(
                    key: const Key('analytics.retry'),
                    onPressed: _retry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry local evidence read'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: MarkeiSpacing.md),
        AnalyticsCardsView(
          cards: state.cards,
          results: state.results,
          onMoveEarlier: (id) =>
              setState(() => widget.controller.moveCardEarlier(id)),
          onMoveLater: (id) =>
              setState(() => widget.controller.moveCardLater(id)),
          onFocus: (id) =>
              setState(() => widget.controller.focusSupportingEvidence(id)),
          onDelete: (id) => setState(() => widget.controller.deleteCard(id)),
        ),
        const SizedBox(height: MarkeiSpacing.md),
        MarkeiSection(
          title: 'Supporting evidence matrix',
          subtitle:
              'Twelve recorded fields. Purchased for and Promotion are unavailable in recorded data.',
          child: AnalyticsEvidenceMatrix(
            rows: state.visibleRows,
            selectedRowIds: state.selectedRowIds,
            wide: wide,
            onSelectionChanged: (ids) =>
                setState(() => widget.controller.selectRows(ids)),
          ),
        ),
      ],
    );
  }

  void _createDefaultCard() {
    setState(() {
      widget.controller.addCard(
        determinant: AnalyticsDeterminantKind.product,
        variables: {AnalyticsVariable.lineTotal},
        operation: AnalyticsOperation.sum,
      );
    });
  }

  void _retry() {
    setState(() {
      _loadFuture = widget.controller.retry();
    });
  }
}
