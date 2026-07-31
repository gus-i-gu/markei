import 'dart:convert';

import 'package:flutter/material.dart';

import '../../application/analytics.dart';
import '../../application/analytics_workspace.dart';
import '../../application/export_destination.dart';
import '../../domain/analytics/analytics_models.dart';
import '../../domain/shared/ids.dart';
import '../design/markei_theme.dart';
import '../widgets/analytics_components.dart';
import '../widgets/markei_components.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({
    required this.controller,
    required this.launchContext,
    required this.exportDestination,
    required this.visible,
    super.key,
  });

  final AnalyticsWorkspaceController controller;
  final AnalyticsLaunchContext? launchContext;
  final ExportDestinationPort exportDestination;
  final bool visible;

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  late Future<AnalyticsWorkspaceSnapshot> _loadFuture;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _composerKey = GlobalKey();

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) return const SizedBox.shrink();
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
            if (state.scrollToComposer) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final current = _composerKey.currentContext;
                if (current != null) {
                  Scrollable.ensureVisible(
                    current,
                    duration: const Duration(milliseconds: 120),
                  );
                }
              });
            }
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
      controller: _scrollController,
      children: [
        MarkeiPageHeader(
          title: 'Analytics',
          purpose:
              'Deterministic local calculations over this Account\'s recorded Purchase evidence.',
          icon: Icons.analytics_outlined,
          trailing: Text(
            '${state.rows.length} contained item(s)',
            style: MarkeiText.metadata,
          ),
        ),
        const SizedBox(height: MarkeiSpacing.md),
        MarkeiSection(
          title: 'Local evidence scope',
          subtitle:
              'Loaded once from local Account evidence. Analyses are session-only and not synchronized.',
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
              OutlinedButton.icon(
                key: const Key('analytics.retry'),
                onPressed: _retry,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry local evidence read'),
              ),
            ],
          ),
        ),
        const SizedBox(height: MarkeiSpacing.md),
        KeyedSubtree(
          key: _composerKey,
          child: AnalyticsComposerView(
            draft: state.draft,
            validation: state.validation,
            options: state.options,
            onDeterminantChanged: (value) =>
                setState(() => widget.controller.setDeterminant(value)),
            onToggleDeterminantKey: (value) =>
                setState(() => widget.controller.toggleDeterminantKey(value)),
            onToggleBreakdown: (value) =>
                setState(() => widget.controller.toggleBreakdown(value)),
            onToggleMeasure: (value) =>
                setState(() => widget.controller.toggleMeasure(value)),
            onOperationChanged: (value) =>
                setState(() => widget.controller.setOperation(value)),
            onTimeframeChanged: (value) =>
                setState(() => widget.controller.setTimeframe(value)),
            onRun: () => setState(widget.controller.runAndSave),
            onClear: () => setState(widget.controller.clearDraft),
          ),
        ),
        const SizedBox(height: MarkeiSpacing.md),
        SavedAnalysisBrowser(
          records: state.records,
          selected: state.selectedRecord,
          onOlder: () => setState(widget.controller.selectOlderRecord),
          onNewer: () => setState(widget.controller.selectNewerRecord),
        ),
        const SizedBox(height: MarkeiSpacing.md),
        AnalyticsResultView(
          record: state.selectedRecord,
          presentation: state.presentation,
          onPresentationChanged: (value) =>
              setState(() => widget.controller.setPresentation(value)),
          onExportCsv: _exportCsv,
          onExportPdf: _exportPdf,
        ),
        const SizedBox(height: MarkeiSpacing.md),
        if (state.selectedRecord != null)
          MarkeiSection(
            title: 'Result interpretation',
            subtitle: 'Timeframe and evidence counts',
            child: Text(state.selectedRecord!.interpretation),
          ),
        const SizedBox(height: MarkeiSpacing.xl),
        AnalyticsVariablesView(
          state: state.variables,
          wide: wide,
          onProjectionChanged: (value) =>
              setState(() => widget.controller.setVariablesProjection(value)),
          onSearchChanged: (value) =>
              setState(() => widget.controller.setVariablesSearch(value)),
          onSortChanged: (value) =>
              setState(() => widget.controller.setVariablesSort(value)),
          onPreviousPage: () =>
              setState(widget.controller.variablesPreviousPage),
          onNextPage: () => setState(widget.controller.variablesNextPage),
          onTogglePurchase: (value) => setState(
            () => widget.controller.togglePurchaseSelection(PurchaseId(value)),
          ),
          onToggleItem: (value) =>
              setState(() => widget.controller.toggleItemSelection(value)),
          onUseSelectedRows: () => setState(widget.controller.useSelectedRows),
          onShowAll: () => setState(widget.controller.showAllVariables),
        ),
      ],
    );
  }

  void _retry() {
    setState(() {
      _loadFuture = widget.controller.retry();
    });
  }

  Future<void> _exportCsv() async {
    final record = widget.controller.snapshot.selectedRecord;
    if (record == null) return;
    try {
      final csv = analyticsRecordCsv(
        record,
        AnalyticsDataset(
          accountId: const AccountId('export-snapshot'),
          rows: widget.controller.snapshot.rows,
        ),
      );
      final result = await widget.exportDestination.write(
        ExportDestinationRequest(
          baseNameCue: 'markei-analytics-${record.fingerprint.toLowerCase()}',
          extension: 'csv',
          mediaType: 'text/csv',
          bytes: utf8.encode(csv),
        ),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(exportDestinationMessage('CSV', result))),
        );
      }
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('CSV export failed. Record was preserved.'),
          ),
        );
      }
    }
  }

  Future<void> _exportPdf() async {
    final record = widget.controller.snapshot.selectedRecord;
    if (record == null) return;
    try {
      final result = await widget.exportDestination.write(
        ExportDestinationRequest(
          baseNameCue: 'markei-analytics-${record.fingerprint.toLowerCase()}',
          extension: 'pdf',
          mediaType: 'application/pdf',
          bytes: analyticsRecordPdfBytes(record),
        ),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(exportDestinationMessage('PDF', result))),
        );
      }
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PDF export failed. Record was preserved.'),
          ),
        );
      }
    }
  }
}
