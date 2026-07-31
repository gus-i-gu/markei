// ignore_for_file: prefer_initializing_formals

import 'analytics.dart';
import '../domain/analytics/analytics_models.dart';
import '../domain/analytics/analytics_registry.dart';
import '../domain/shared/ids.dart';

enum AnalyticsWorkspaceStatus {
  loading,
  complete,
  noData,
  filteredEmpty,
  selectedEmpty,
  readFailure,
}

final class AnalyticsWorkspaceSnapshot {
  const AnalyticsWorkspaceSnapshot({
    required this.status,
    required this.rows,
    required this.visibleRows,
    required this.selectedRowIds,
    required this.cards,
    required this.results,
    required this.repositoryRequestCount,
    this.message,
    this.historyContextMessage,
  });

  final AnalyticsWorkspaceStatus status;
  final List<AnalyticsEvidenceRow> rows;
  final List<AnalyticsEvidenceRow> visibleRows;
  final Set<AnalyticsEvidenceRowId> selectedRowIds;
  final List<AnalyticsCardConfiguration> cards;
  final Map<AnalyticsCardId, AnalyticsResultEnvelope> results;
  final int repositoryRequestCount;
  final String? message;
  final String? historyContextMessage;
}

final class AnalyticsWorkspaceController {
  AnalyticsWorkspaceController({
    required AccountId accountId,
    required AnalyticsEvidenceRepository repository,
    required AnalyticsRegistry registry,
    AnalyticsLaunchContext? launchContext,
  }) : _accountId = accountId,
       _repository = repository,
       _registry = registry,
       _launchContext = launchContext;

  static const int renderedPageSize = 100;
  static const int selectedScopeCap = 500;

  final AccountId _accountId;
  final AnalyticsEvidenceRepository _repository;
  final AnalyticsRegistry _registry;
  AnalyticsLaunchContext? _launchContext;
  AnalyticsDataset? _dataset;
  List<AnalyticsCondition> _conditions = const [];
  Set<AnalyticsEvidenceRowId> _selectedRowIds = {};
  Set<AnalyticsEvidenceRowId>? _focusedRowIds;
  final List<AnalyticsCardConfiguration> _cards = [];
  final Map<AnalyticsCardId, AnalyticsResultEnvelope> _results = {};
  int _nextCardId = 1;
  int _generation = 0;
  int _repositoryRequestCount = 0;
  AnalyticsWorkspaceSnapshot _snapshot = const AnalyticsWorkspaceSnapshot(
    status: AnalyticsWorkspaceStatus.loading,
    rows: [],
    visibleRows: [],
    selectedRowIds: {},
    cards: [],
    results: {},
    repositoryRequestCount: 0,
  );

  AnalyticsWorkspaceSnapshot get snapshot => _snapshot;

  Future<AnalyticsWorkspaceSnapshot> load() => _load(preserveCards: true);

  Future<AnalyticsWorkspaceSnapshot> retry() => _load(preserveCards: true);

  Future<AnalyticsWorkspaceSnapshot> _load({
    required bool preserveCards,
  }) async {
    final generation = ++_generation;
    _snapshot = _snapshotWith(status: AnalyticsWorkspaceStatus.loading);
    try {
      _repositoryRequestCount++;
      final dataset = await _repository.loadEvidence(_accountId);
      if (generation != _generation) {
        return _snapshot;
      }
      _dataset = dataset;
      _applyLaunchContext();
      _recalculateCards();
      _snapshot = _buildSnapshot();
      return _snapshot;
    } on Object {
      if (generation != _generation) {
        return _snapshot;
      }
      _snapshot = _snapshotWith(
        status: AnalyticsWorkspaceStatus.readFailure,
        message:
            'Local Purchase evidence could not be loaded. No Purchase data was changed.',
      );
      return _snapshot;
    }
  }

  AnalyticsWorkspaceSnapshot applyConditions(List<AnalyticsCondition> value) {
    _conditions = List.unmodifiable(value);
    _focusedRowIds = null;
    _snapshot = _buildSnapshot();
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot selectRows(Set<AnalyticsEvidenceRowId> rowIds) {
    if (rowIds.length > selectedScopeCap) {
      _snapshot = _snapshotWith(
        message: 'Select up to 500 evidence rows, or use filtered evidence.',
      );
      return _snapshot;
    }
    _selectedRowIds = Set.unmodifiable(rowIds);
    _snapshot = _buildSnapshot(
      message: rowIds.isEmpty
          ? 'No evidence rows are selected.'
          : 'Card started from ${rowIds.length} selected evidence rows. Choose its determinant, variables and operation.',
    );
    return _snapshot;
  }

  AnalyticsCardConfiguration addCard({
    required AnalyticsDeterminantKind determinant,
    required Set<AnalyticsVariable> variables,
    required AnalyticsOperation operation,
    AnalyticsEvidenceScope? scope,
  }) {
    final card = AnalyticsCardConfiguration(
      id: AnalyticsCardId(_nextCardId++),
      revision: const AnalyticsCardRevision(1),
      determinant: determinant,
      variables: Set.unmodifiable(variables),
      operation: operation,
      conditions: _conditions,
      scope:
          scope ??
          (_selectedRowIds.isEmpty
              ? const FilteredAnalyticsEvidenceScope()
              : SelectedAnalyticsEvidenceScope(_selectedRowIds)),
    );
    _cards.add(card);
    _executeCard(card);
    _snapshot = _buildSnapshot();
    return card;
  }

  void editCard(AnalyticsCardConfiguration configuration) {
    final index = _cards.indexWhere(
      (card) => card.id.value == configuration.id.value,
    );
    if (index == -1) return;
    final edited = configuration.copyWith(
      revision: AnalyticsCardRevision(_cards[index].revision.value + 1),
    );
    _cards[index] = edited;
    _executeCard(edited);
    _snapshot = _buildSnapshot();
  }

  void deleteCard(AnalyticsCardId id) {
    _cards.removeWhere((card) => card.id.value == id.value);
    _results.removeWhere((key, _) => key.value == id.value);
    _snapshot = _buildSnapshot();
  }

  void moveCardEarlier(AnalyticsCardId id) {
    final index = _cards.indexWhere((card) => card.id.value == id.value);
    if (index > 0) {
      final card = _cards.removeAt(index);
      _cards.insert(index - 1, card);
    }
    _snapshot = _buildSnapshot();
  }

  void moveCardLater(AnalyticsCardId id) {
    final index = _cards.indexWhere((card) => card.id.value == id.value);
    if (index != -1 && index < _cards.length - 1) {
      final card = _cards.removeAt(index);
      _cards.insert(index + 1, card);
    }
    _snapshot = _buildSnapshot();
  }

  void focusSupportingEvidence(AnalyticsCardId id) {
    final result = _results.entries
        .where((entry) => entry.key.value == id.value)
        .firstOrNull
        ?.value;
    _focusedRowIds = result?.contributingRowIds;
    _snapshot = _buildSnapshot();
  }

  void showAllEvidence() {
    _focusedRowIds = null;
    _snapshot = _buildSnapshot();
  }

  void resetEvidence() {
    _conditions = const [];
    _selectedRowIds = {};
    _focusedRowIds = null;
    _snapshot = _buildSnapshot(
      message:
          'All evidence is shown. Cards and Purchase data were not changed.',
    );
  }

  void setLaunchContext(AnalyticsLaunchContext? context) {
    _launchContext = context;
    _applyLaunchContext();
    _snapshot = _buildSnapshot();
  }

  void _applyLaunchContext() {
    final context = _launchContext;
    final dataset = _dataset;
    if (context is! AnalyticsPurchaseSelectionLaunchContext ||
        dataset == null ||
        context.accountId.value != _accountId.value) {
      return;
    }
    final requested = {for (final id in context.purchaseIds) id.value};
    final matchedRows = dataset.rows
        .where((row) => requested.contains(row.purchaseId.value))
        .map((row) => row.id)
        .toSet();
    _selectedRowIds = matchedRows.length > selectedScopeCap
        ? Set.unmodifiable(matchedRows.take(selectedScopeCap))
        : Set.unmodifiable(matchedRows);
  }

  void _recalculateCards() {
    _results.clear();
    for (final card in _cards) {
      _executeCard(card);
    }
  }

  void _executeCard(AnalyticsCardConfiguration card) {
    final dataset = _dataset;
    if (dataset == null) return;
    _results[card.id] = executeAnalyticsCard(
      registry: _registry,
      configuration: card,
      dataset: dataset,
    );
  }

  AnalyticsWorkspaceSnapshot _buildSnapshot({String? message}) {
    final dataset = _dataset;
    if (dataset == null) {
      return _snapshotWith(message: message);
    }
    final rows = dataset.rows;
    final filtered = _filter(rows);
    final focused = _focusedRowIds;
    final visible = focused == null
        ? filtered
        : filtered
              .where((row) => focused.any((id) => id.value == row.id.value))
              .toList(growable: false);
    final paged = visible.take(renderedPageSize).toList(growable: false);
    final status = rows.isEmpty
        ? AnalyticsWorkspaceStatus.noData
        : filtered.isEmpty
        ? AnalyticsWorkspaceStatus.filteredEmpty
        : AnalyticsWorkspaceStatus.complete;
    return AnalyticsWorkspaceSnapshot(
      status: status,
      rows: rows,
      visibleRows: paged,
      selectedRowIds: _selectedRowIds,
      cards: List.unmodifiable(_cards),
      results: Map.unmodifiable(_results),
      repositoryRequestCount: _repositoryRequestCount,
      message: message,
      historyContextMessage: _historyContextMessage(dataset),
    );
  }

  AnalyticsWorkspaceSnapshot _snapshotWith({
    AnalyticsWorkspaceStatus? status,
    String? message,
  }) {
    return AnalyticsWorkspaceSnapshot(
      status: status ?? _snapshot.status,
      rows: _snapshot.rows,
      visibleRows: _snapshot.visibleRows,
      selectedRowIds: _snapshot.selectedRowIds,
      cards: _snapshot.cards,
      results: _snapshot.results,
      repositoryRequestCount: _repositoryRequestCount,
      message: message ?? _snapshot.message,
      historyContextMessage: _snapshot.historyContextMessage,
    );
  }

  List<AnalyticsEvidenceRow> _filter(List<AnalyticsEvidenceRow> rows) {
    return rows
        .where((row) {
          for (final condition in _conditions) {
            switch (condition) {
              case AnalyticsUtcPeriodCondition():
                if (!condition.contains(row.purchaseOccurrenceTime)) {
                  return false;
                }
              case AnalyticsFieldCondition():
                final value = switch (condition.field) {
                  AnalyticsDeterminantKind.product => row.productId.value,
                  AnalyticsDeterminantKind.purchase => row.purchaseId.value,
                  AnalyticsDeterminantKind.store => row.storeId.value,
                  AnalyticsDeterminantKind.timeDayUtc =>
                    row.purchaseOccurrenceTime.toUtc().day.toString(),
                  AnalyticsDeterminantKind.timeMonthUtc =>
                    row.purchaseOccurrenceTime.toUtc().month.toString(),
                };
                if (value != condition.value) return false;
            }
          }
          return true;
        })
        .toList(growable: false);
  }

  String? _historyContextMessage(AnalyticsDataset dataset) {
    final context = _launchContext;
    if (context is! AnalyticsPurchaseSelectionLaunchContext) return null;
    final requested = {for (final id in context.purchaseIds) id.value};
    final matched = dataset.rows
        .where((row) => requested.contains(row.purchaseId.value))
        .map((row) => row.purchaseId.value)
        .toSet();
    final stale = requested.length - matched.length;
    final base =
        'Using ${matched.length} purchases from History. Analytics will calculate from their local evidence.';
    if (stale <= 0) return base;
    return '$base $stale transferred purchases were unavailable for this Account and were not used.';
  }
}
