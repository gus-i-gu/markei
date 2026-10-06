// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:crypto/crypto.dart';

import 'analytics.dart';
import '../domain/analytics/analytics_models.dart';
import '../domain/analytics/analytics_registry.dart';
import '../domain/shared/ids.dart';
import '../l10n/analytics_copy.dart';

enum AnalyticsWorkspaceStatus {
  loading,
  complete,
  noData,
  filteredEmpty,
  selectedEmpty,
  readFailure,
  invalidDraft,
}

typedef AnalyticsClock = DateTime Function();

final class AnalyticsWorkspaceSnapshot {
  const AnalyticsWorkspaceSnapshot({
    required this.status,
    required this.rows,
    required this.visibleRows,
    required this.selectedRowIds,
    required this.cards,
    required this.results,
    required this.repositoryRequestCount,
    required this.draft,
    required this.validation,
    required this.records,
    required this.selectedRecord,
    required this.presentation,
    required this.variables,
    required this.options,
    this.message,
    this.historyContextMessage,
    this.scrollToComposer = false,
  });

  final AnalyticsWorkspaceStatus status;
  final List<AnalyticsEvidenceRow> rows;
  final List<AnalyticsEvidenceRow> visibleRows;
  final Set<AnalyticsEvidenceRowId> selectedRowIds;
  final List<AnalyticsCardConfiguration> cards;
  final Map<AnalyticsCardId, AnalyticsResultEnvelope> results;
  final int repositoryRequestCount;
  final AnalyticsComposerDraft draft;
  final AnalyticsDraftValidation validation;
  final List<AnalyticsRecord> records;
  final AnalyticsRecord? selectedRecord;
  final AnalyticsResultPresentation presentation;
  final AnalyticsVariablesState variables;
  final Map<AnalyticsDeterminantKind, List<AnalyticsOption>> options;
  final String? message;
  final String? historyContextMessage;
  final bool scrollToComposer;
}

final class AnalyticsWorkspaceController {
  AnalyticsWorkspaceController({
    required AccountId accountId,
    required AnalyticsEvidenceRepository repository,
    required AnalyticsRegistry registry,
    AnalyticsLaunchContext? launchContext,
    AnalyticsClock? clock,
  }) : _accountId = accountId,
       _repository = repository,
       _registry = registry,
       _launchContext = launchContext,
       _clock = clock ?? (() => DateTime.now().toUtc());

  static const int renderedPageSize = 20;
  static const int selectedScopeCap = 500;

  final AccountId _accountId;
  final AnalyticsEvidenceRepository _repository;
  final AnalyticsRegistry _registry;
  final AnalyticsClock _clock;
  AnalyticsLaunchContext? _launchContext;
  AnalyticsDataset? _dataset;
  String _evidenceSignature = '';
  Map<AnalyticsDeterminantKind, List<AnalyticsOption>>? _optionCache;
  AnalyticsComposerDraft _draft = const AnalyticsComposerDraft();
  Set<AnalyticsEvidenceRowId> _selectedRowIds = {};
  Set<AnalyticsEvidenceRowId>? _focusedRowIds;
  AnalyticsVariablesProjection _variablesProjection =
      AnalyticsVariablesProjection.containedItems;
  String _variablesSearch = '';
  AnalyticsVariablesSort _variablesSort = AnalyticsVariablesSort.timeDescending;
  int _variablesPageIndex = 0;
  final List<AnalyticsRecord> _records = [];
  final Map<String, AnalyticsRecord> _recordsByExecution = {};
  AnalyticsRecordId? _selectedRecordId;
  AnalyticsResultPresentation _presentation = AnalyticsResultPresentation.table;
  int _nextRecordId = 1;
  int _generation = 0;
  int _repositoryRequestCount = 0;
  AnalyticsWorkspaceSnapshot _snapshot = _emptySnapshot(
    AnalyticsWorkspaceStatus.loading,
    const AnalyticsComposerDraft(),
  );

  AnalyticsWorkspaceSnapshot get snapshot => _snapshot;

  Future<AnalyticsWorkspaceSnapshot> load() => _load();

  Future<AnalyticsWorkspaceSnapshot> retry() => _load();

  Future<AnalyticsWorkspaceSnapshot> _load() async {
    final generation = ++_generation;
    _snapshot = _snapshotWith(status: AnalyticsWorkspaceStatus.loading);
    try {
      _repositoryRequestCount++;
      final dataset = await _repository.loadEvidence(_accountId);
      if (generation != _generation) return _snapshot;
      _dataset = dataset;
      _evidenceSignature = _datasetSignature(dataset);
      _optionCache = null;
      _applyLaunchContext();
      _snapshot = _buildSnapshot();
      return _snapshot;
    } on Object {
      if (generation != _generation) return _snapshot;
      _snapshot = _snapshotWith(
        status: AnalyticsWorkspaceStatus.readFailure,
        message:
            'Local Purchase evidence could not be loaded. No Purchase data was changed.',
      );
      return _snapshot;
    }
  }

  AnalyticsWorkspaceSnapshot updateDraft(AnalyticsComposerDraft draft) {
    _draft = draft;
    _snapshot = _buildSnapshot();
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot setDeterminant(AnalyticsDeterminantKind value) {
    return updateDraft(
      _draft.copyWith(
        determinant: value,
        selectedDeterminantKeys: {},
        analytics01: _draft.analytics01.kind == value
            ? const AnalyticsAxis()
            : _draft.analytics01,
        analytics02: _draft.analytics02.kind == value
            ? const AnalyticsAxis()
            : _draft.analytics02,
      ),
    );
  }

  AnalyticsWorkspaceSnapshot setAxis(int index, AnalyticsAxis value) =>
      updateDraft(
        _draft.copyWith(
          analytics01: index == 0 ? value.frozen() : null,
          analytics02: index == 1 ? value.frozen() : null,
        ),
      );

  AnalyticsWorkspaceSnapshot selectAllDeterminants() => updateDraft(
    _draft.copyWith(
      selectedDeterminantKeys: _options()[_draft.determinant]!
          .map((o) => o.key)
          .toSet(),
    ),
  );

  AnalyticsWorkspaceSnapshot toggleDeterminantKey(String key) {
    final next = {..._draft.selectedDeterminantKeys};
    if (!next.remove(key)) next.add(key);
    return updateDraft(_draft.copyWith(selectedDeterminantKeys: next));
  }

  AnalyticsWorkspaceSnapshot toggleBreakdown(
    AnalyticsRelationalBreakdown breakdown,
  ) {
    return toggleVariable(_variableForBreakdown(breakdown));
  }

  AnalyticsWorkspaceSnapshot toggleMeasure(AnalyticsMeasure measure) {
    return toggleVariable(_variableForMeasure(measure));
  }

  AnalyticsWorkspaceSnapshot toggleVariable(AnalyticsVariable variable) {
    final next = {..._draft.variables};
    if (!next.remove(variable)) next.add(variable);
    return updateDraft(_draft.copyWith(variables: next));
  }

  AnalyticsWorkspaceSnapshot setOperation(AnalyticsOperation operation) {
    return updateDraft(_draft.copyWith(operation: operation));
  }

  AnalyticsWorkspaceSnapshot setTimeframe(AnalyticsTimeframe timeframe) {
    return updateDraft(_draft.copyWith(timeframe: timeframe));
  }

  AnalyticsWorkspaceSnapshot clearDraft() {
    _draft = const AnalyticsComposerDraft();
    _snapshot = _buildSnapshot(
      message: 'Draft cleared. Saved analyses remain.',
    );
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot runAndSave() {
    final duplicate = _matchingRecord;
    if (duplicate != null) {
      return selectRecord(duplicate.id);
    }
    final validation = _validateDraft();
    if (!validation.canRun) {
      _snapshot = _buildSnapshot(
        status: AnalyticsWorkspaceStatus.invalidDraft,
        message: validation.explanation,
      );
      return _snapshot;
    }
    final dataset = _dataset;
    if (dataset == null) return _snapshot;
    final executedAt = _clock().toUtc();
    final id = AnalyticsRecordId(_nextRecordId++);
    final selectedValues = _selectedOptionsForDraft();
    final recordSeed = _recordSeed(
      id,
      executedAt,
      _draft,
      selectedValues,
      dataset.rows.map((row) => row.id.value).toList(),
    );
    final entries = _groupedEntries(id, _draft, dataset);
    final contributing = {
      for (final entry in entries)
        for (final id in entry.contributingRowIds) id,
    };
    final evidenceRows = _rowsForDraft(dataset)
        .where(
          (row) => _draft.selectedDeterminantKeys.contains(
            _determinantOption(row, _draft.determinant).key,
          ),
        )
        .toList();
    final eligibleIds = {
      for (final entry in entries.where(
        (entry) => entry.value is! AnalyticsUnavailableResultValue,
      ))
        for (final rowId in entry.contributingRowIds) rowId.value,
    };
    final eligible = eligibleIds.length;
    final excluded = evidenceRows.length - eligible;
    final selectedAxisValues = [
      for (final axis in _draft.axes)
        axis.kind == null
            ? <AnalyticsOption>[]
            : [
                for (final option in _options()[axis.kind]!)
                  if (axis.selectedKeys.isEmpty ||
                      axis.selectedKeys.contains(option.key))
                    option,
              ],
    ];
    final fingerprint = _fingerprint(recordSeed, _records);
    final record = AnalyticsRecord(
      id: id,
      fingerprint: fingerprint,
      executedAtUtc: executedAt,
      registryIdentifier: _registry.definitionFor(_draft.operation).identifier,
      registryVersion: _registry.definitionFor(_draft.operation).version,
      draft: _draft.copyWith(
        selectedDeterminantKeys: Set.unmodifiable(
          _draft.selectedDeterminantKeys,
        ),
        variables: Set.unmodifiable(_draft.variables),
        measures: Set.unmodifiable(_draft.measures),
        breakdowns: Set.unmodifiable(_draft.breakdowns),
        analytics01: _draft.analytics01.frozen(),
        analytics02: _draft.analytics02.frozen(),
        scope: _freezeScope(_draft.scope),
      ),
      selectedValues: selectedValues,
      entries: entries,
      contributingRowIds: contributing,
      eligibleCount: eligible,
      totalCount: evidenceRows.length,
      excludedCount: excluded,
      interpretation: analyticsContextualInterpretation(
        draft: _draft,
        selectedValues: selectedValues,
        selectedAxisValues: selectedAxisValues,
        entries: entries,
        evidenceRows: evidenceRows,
        eligibleCount: eligible,
        excludedCount: excluded,
      ),
      evidenceRows: evidenceRows,
      selectedAxisValues: selectedAxisValues,
    );
    _records.insert(0, record);
    _recordsByExecution[_executionSignature()] = record;
    _selectedRecordId = record.id;
    _focusedRowIds = record.contributingRowIds;
    _presentation = _defaultPresentation(record);
    _snapshot = _buildSnapshot(
      message: 'Record #${record.fingerprint} saved for this session.',
    );
    return _snapshot;
  }

  /// Restores the frozen result; selection never executes another analysis.
  AnalyticsWorkspaceSnapshot selectRecord(AnalyticsRecordId id) {
    final record = _records
        .where((record) => record.id.value == id.value)
        .firstOrNull;
    if (record == null) return _snapshot;
    _selectedRecordId = record.id;
    _draft = record.draft;
    _focusedRowIds = record.contributingRowIds;
    _presentation = _defaultPresentation(record);
    _variablesPageIndex = 0;
    _snapshot = _buildSnapshot();
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot selectOlderRecord() {
    final selected = _selectedRecord;
    if (selected == null) return _snapshot;
    final index = _records.indexWhere((r) => r.id.value == selected.id.value);
    if (index >= 0 && index < _records.length - 1) {
      return selectRecord(_records[index + 1].id);
    }
    _snapshot = _buildSnapshot();
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot selectNewerRecord() {
    final selected = _selectedRecord;
    if (selected == null) return _snapshot;
    final index = _records.indexWhere((r) => r.id.value == selected.id.value);
    if (index > 0) {
      return selectRecord(_records[index - 1].id);
    }
    _snapshot = _buildSnapshot();
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot setPresentation(
    AnalyticsResultPresentation presentation,
  ) {
    _presentation = presentation;
    _snapshot = _buildSnapshot();
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot showAllEvidence() => showAllVariables();

  AnalyticsWorkspaceSnapshot showAllVariables() {
    _focusedRowIds = null;
    _snapshot = _buildSnapshot(message: 'Showing all variables.');
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot resetEvidence() {
    _selectedRowIds = {};
    _focusedRowIds = null;
    _variablesSearch = '';
    _variablesPageIndex = 0;
    _snapshot = _buildSnapshot(
      message: 'All variables are shown. Saved analyses were not changed.',
    );
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot setVariablesProjection(
    AnalyticsVariablesProjection projection,
  ) {
    _variablesProjection = projection;
    _variablesPageIndex = 0;
    _snapshot = _buildSnapshot();
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot setVariablesSearch(String value) {
    _variablesSearch = value;
    _variablesPageIndex = 0;
    _snapshot = _buildSnapshot();
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot setVariablesSort(AnalyticsVariablesSort value) {
    _variablesSort = value;
    _variablesPageIndex = 0;
    _snapshot = _buildSnapshot();
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot variablesNextPage() {
    final variables = _variablesState();
    if (variables.hasNext) _variablesPageIndex++;
    _snapshot = _buildSnapshot();
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot variablesPreviousPage() {
    if (_variablesPageIndex > 0) _variablesPageIndex--;
    _snapshot = _buildSnapshot();
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot selectRows(Set<AnalyticsEvidenceRowId> rowIds) {
    if (rowIds.length > selectedScopeCap) {
      _snapshot = _buildSnapshot(
        message: 'Select up to 500 evidence rows, or use filtered evidence.',
      );
      return _snapshot;
    }
    _selectedRowIds = Set.unmodifiable(rowIds);
    _snapshot = _buildSnapshot(
      message: rowIds.isEmpty
          ? 'No variable rows are selected.'
          : '${rowIds.length} variable row(s) selected.',
    );
    return _snapshot;
  }

  AnalyticsWorkspaceSnapshot toggleItemSelection(AnalyticsEvidenceRowId id) {
    final next = {..._selectedRowIds};
    final existing = next.where((rowId) => rowId.value == id.value).firstOrNull;
    if (existing == null) {
      next.add(id);
    } else {
      next.remove(existing);
    }
    return selectRows(next);
  }

  AnalyticsWorkspaceSnapshot togglePurchaseSelection(PurchaseId id) {
    final dataset = _dataset;
    if (dataset == null) return _snapshot;
    final purchaseRows = dataset.rows
        .where((row) => row.purchaseId.value == id.value)
        .map((row) => row.id)
        .toSet();
    final allSelected = purchaseRows.every(
      (itemId) => _selectedRowIds.any((id) => id.value == itemId.value),
    );
    final next = {..._selectedRowIds};
    if (allSelected) {
      next.removeWhere(
        (id) => purchaseRows.any((rowId) => rowId.value == id.value),
      );
    } else {
      next.addAll(purchaseRows);
    }
    return selectRows(next);
  }

  AnalyticsWorkspaceSnapshot useSelectedRows() {
    final scope = _selectedRowIds.isEmpty
        ? const FilteredAnalyticsEvidenceScope()
        : SelectedAnalyticsEvidenceScope(_selectedRowIds);
    _draft = _draft.copyWith(scope: scope);
    _snapshot = _buildSnapshot(
      message: _selectedRowIds.isEmpty
          ? 'No variable rows are selected.'
          : 'Selected rows prepared a new analysis draft.',
      scrollToComposer: true,
    );
    return _snapshot;
  }

  void setLaunchContext(AnalyticsLaunchContext? context) {
    _launchContext = context;
    _applyLaunchContext();
    _snapshot = _buildSnapshot();
  }

  AnalyticsWorkspaceSnapshot _buildSnapshot({
    AnalyticsWorkspaceStatus? status,
    String? message,
    bool scrollToComposer = false,
  }) {
    final dataset = _dataset;
    if (dataset == null) {
      return _snapshotWith(
        status: status,
        message: message,
        scrollToComposer: scrollToComposer,
      );
    }
    _normalizeTimeDimensions(dataset);
    final rows = dataset.rows;
    final variables = _variablesState();
    final visibleRows = variables.itemRows.take(renderedPageSize).toList();
    final validation = _validateDraft();
    final derivedStatus =
        status ??
        (rows.isEmpty
            ? AnalyticsWorkspaceStatus.noData
            : variables.itemRows.isEmpty && variables.purchaseRows.isEmpty
            ? AnalyticsWorkspaceStatus.filteredEmpty
            : AnalyticsWorkspaceStatus.complete);
    return AnalyticsWorkspaceSnapshot(
      status: derivedStatus,
      rows: rows,
      visibleRows: List.unmodifiable(visibleRows),
      selectedRowIds: Set.unmodifiable(_selectedRowIds),
      cards: const [],
      results: const {},
      repositoryRequestCount: _repositoryRequestCount,
      draft: _draft,
      validation: validation,
      records: List.unmodifiable(_records),
      selectedRecord: _selectedRecord,
      presentation: _presentation,
      variables: variables,
      options: _options(),
      message: message,
      historyContextMessage: _historyContextMessage(dataset),
      scrollToComposer: scrollToComposer,
    );
  }

  void _normalizeTimeDimensions(AnalyticsDataset dataset) {
    bool isTime(AnalyticsDeterminantKind? kind) =>
        kind == AnalyticsDeterminantKind.timeDayUtc ||
        kind == AnalyticsDeterminantKind.timeMonthUtc;

    // The shared range controls dates; date checklists are no longer needed.
    _draft = _draft.copyWith(
      measures: _draft.measures,
      breakdowns: _draft.breakdowns,
      analytics01: isTime(_draft.analytics01.kind)
          ? AnalyticsAxis(kind: _draft.analytics01.kind)
          : null,
      analytics02: isTime(_draft.analytics02.kind)
          ? AnalyticsAxis(kind: _draft.analytics02.kind)
          : null,
    );
    if (isTime(_draft.determinant)) {
      _draft = _draft.copyWith(
        measures: _draft.measures,
        breakdowns: _draft.breakdowns,
        selectedDeterminantKeys: {
          for (final row in _rowsForDraft(dataset))
            _determinantOption(row, _draft.determinant).key,
        },
      );
    }
  }

  AnalyticsWorkspaceSnapshot _snapshotWith({
    AnalyticsWorkspaceStatus? status,
    String? message,
    bool scrollToComposer = false,
  }) {
    return AnalyticsWorkspaceSnapshot(
      status: status ?? _snapshot.status,
      rows: _snapshot.rows,
      visibleRows: _snapshot.visibleRows,
      selectedRowIds: _snapshot.selectedRowIds,
      cards: _snapshot.cards,
      results: _snapshot.results,
      repositoryRequestCount: _repositoryRequestCount,
      draft: _snapshot.draft,
      validation: _snapshot.validation,
      records: _snapshot.records,
      selectedRecord: _snapshot.selectedRecord,
      presentation: _snapshot.presentation,
      variables: _snapshot.variables,
      options: _snapshot.options,
      message: message ?? _snapshot.message,
      historyContextMessage: _snapshot.historyContextMessage,
      scrollToComposer: scrollToComposer,
    );
  }

  static AnalyticsWorkspaceSnapshot _emptySnapshot(
    AnalyticsWorkspaceStatus status,
    AnalyticsComposerDraft draft,
  ) {
    return AnalyticsWorkspaceSnapshot(
      status: status,
      rows: const [],
      visibleRows: const [],
      selectedRowIds: const {},
      cards: const [],
      results: const {},
      repositoryRequestCount: 0,
      draft: draft,
      validation: const AnalyticsDraftValidation(
        canRun: false,
        explanation:
            'Run & save analysis becomes available when the draft is complete.',
      ),
      records: const [],
      selectedRecord: null,
      presentation: AnalyticsResultPresentation.table,
      variables: AnalyticsVariablesState(
        projection: AnalyticsVariablesProjection.containedItems,
        search: '',
        sort: AnalyticsVariablesSort.timeDescending,
        pageIndex: 0,
        pageSize: renderedPageSize,
        purchaseRows: [],
        itemRows: [],
        selectedRowIds: {},
      ),
      options: const {},
    );
  }

  AnalyticsDraftValidation _validateDraft() {
    final dataset = _dataset;
    if (dataset == null || dataset.rows.isEmpty) {
      return const AnalyticsDraftValidation(
        canRun: false,
        explanation:
            'No Purchase evidence yet. Register a Purchase to begin local Analytics.',
      );
    }
    if (!_draft.timeframe.isValid) {
      return AnalyticsDraftValidation(
        canRun: false,
        explanation:
            _draft.timeframe.invalidDraft ??
            'Enter both Start date and End date as dd-mm-yyyy.',
      );
    }
    if (_draft.breakdowns.contains(AnalyticsRelationalBreakdown.purchasedFor) ||
        _draft.determinant == AnalyticsDeterminantKind.purchasedFor ||
        _draft.axes.any(
          (axis) => axis.kind == AnalyticsDeterminantKind.purchasedFor,
        )) {
      return const AnalyticsDraftValidation(
        canRun: false,
        explanation:
            'Purchased for will use tags in a future update; recorded data has no recipient tags yet.',
      );
    }
    if (_draft.selectedDeterminantKeys.isEmpty) {
      final temporal =
          _draft.determinant == AnalyticsDeterminantKind.timeDayUtc ||
          _draft.determinant == AnalyticsDeterminantKind.timeMonthUtc;
      return AnalyticsDraftValidation(
        canRun: false,
        explanation: temporal
            ? 'No recorded purchases match this timeframe and comparisons. Change the dates or comparisons.'
            : 'Choose at least one recorded value for the Determinant.',
      );
    }
    if (_draft.measures.isEmpty) {
      return const AnalyticsDraftValidation(
        canRun: false,
        explanation:
            'Choose at least one numeric variable. Categorical variables break down a result but are not calculated.',
      );
    }
    final variables = _draft.measures.map(_variableFor).toSet();
    for (final variable in variables) {
      if (!_registry.supports(_draft.operation, variable)) {
        return AnalyticsDraftValidation(
          canRun: false,
          explanation:
              '${_operationLabel(_draft.operation)} is unavailable for ${_variableLabel(variable)}.',
        );
      }
    }
    final axisKinds = _draft.axes
        .map((axis) => axis.kind)
        .whereType<AnalyticsDeterminantKind>()
        .toList();
    if (axisKinds.toSet().length != axisKinds.length ||
        axisKinds.contains(_draft.determinant)) {
      return const AnalyticsDraftValidation(
        canRun: false,
        explanation:
            'Choose different types for Determinant, Analytics and Analytics constraint.',
      );
    }
    for (final axis in _draft.axes) {
      if (axis.kind != null &&
          !axis.selectedKeys.every(
            _options()[axis.kind]!.map((o) => o.key).toSet().contains,
          )) {
        return const AnalyticsDraftValidation(
          canRun: false,
          explanation:
              'A comparison selection is no longer available. Choose it again.',
        );
      }
    }
    final filtered = _rowsForDraft(dataset);
    if (filtered.isEmpty) {
      return const AnalyticsDraftValidation(
        canRun: false,
        explanation:
            'No recorded purchases match this timeframe and comparisons. Change the dates or comparisons.',
      );
    }
    if (_draft.operation == AnalyticsOperation.difference &&
        _draft.selectedDeterminantKeys.length != 2) {
      return const AnalyticsDraftValidation(
        canRun: false,
        explanation:
            'Difference needs exactly two comparable groups: baseline A and comparison B.',
      );
    }
    if (_draft.operation == AnalyticsOperation.percentage &&
        _draft.selectedDeterminantKeys.length != 2) {
      return const AnalyticsDraftValidation(
        canRun: false,
        explanation:
            'Percentage needs a named part contained in a named whole.',
      );
    }
    final validKeys = _options()[_draft.determinant]!.map((o) => o.key).toSet();
    if (!_draft.selectedDeterminantKeys.every(validKeys.contains)) {
      return const AnalyticsDraftValidation(
        canRun: false,
        explanation:
            'The selected rows are stale or unavailable for this Account.',
      );
    }
    if (_matchingRecord != null) {
      return const AnalyticsDraftValidation(
        canRun: false,
        explanation:
            'This configuration and evidence are already saved. Change a selection or refresh changed evidence to run again.',
      );
    }
    return const AnalyticsDraftValidation(
      canRun: true,
      explanation: 'Run & save analysis is available.',
    );
  }

  List<AnalyticsGroupedResultEntry> _groupedEntries(
    AnalyticsRecordId recordId,
    AnalyticsComposerDraft draft,
    AnalyticsDataset dataset,
  ) {
    final definition = _registry.definitionFor(draft.operation);
    final rows = _rowsForDraft(dataset);
    final groups = _groups(rows, draft);
    if (draft.operation == AnalyticsOperation.difference ||
        draft.operation == AnalyticsOperation.percentage) {
      return _comparisonEntries(definition, draft, groups);
    }
    final entries = <AnalyticsGroupedResultEntry>[];
    for (final group in groups.values) {
      for (final measure in draft.measures) {
        entries.addAll(
          _aggregateGroup(definition, draft.operation, group, measure),
        );
      }
    }
    return List.unmodifiable(entries);
  }

  List<AnalyticsGroupedResultEntry> _comparisonEntries(
    AnalyticDefinition definition,
    AnalyticsComposerDraft draft,
    Map<String, _GroupBucket> groups,
  ) {
    if (!groups.values.any((group) => group.key.value.contains('|'))) {
      return _comparisonEntriesCore(definition, draft, groups);
    }
    final contexts = <String, Map<String, _GroupBucket>>{};
    for (final group in groups.values) {
      final parts = group.key.value.split('|');
      contexts.putIfAbsent(parts.skip(1).join('|'), () => {})[parts.first] =
          group;
    }
    final result = <AnalyticsGroupedResultEntry>[];
    for (final pair in contexts.values) {
      if (draft.selectedDeterminantKeys.every(pair.containsKey)) {
        result.addAll(_comparisonEntriesCore(definition, draft, pair));
      } else {
        final group = pair.values.first;
        for (final measure in draft.measures) {
          result.add(
            AnalyticsGroupedResultEntry(
              groupKey: group.key,
              measure: measure,
              operation: draft.operation,
              compatibilityKey: const AnalyticsCompatibilityKey('none'),
              value: const AnalyticsUnavailableResultValue(
                label: 'Comparison',
                reason: AnalyticsUnavailableReason.insufficientEvidence,
                message:
                    'Both selected rows need evidence in this comparison context.',
              ),
              eligibleCount: 0,
              totalCount: group.rows.length,
              excludedCount: group.rows.length,
              contributingRowIds: group.rows.map((row) => row.id).toSet(),
            ),
          );
        }
      }
    }
    return List.unmodifiable(result);
  }

  List<AnalyticsGroupedResultEntry> _comparisonEntriesCore(
    AnalyticDefinition definition,
    AnalyticsComposerDraft draft,
    Map<String, _GroupBucket> groups,
  ) {
    final keys = draft.selectedDeterminantKeys.toList()..sort();
    if (keys.length != 2) return const [];
    final baseline = groups[keys[0]];
    final comparison = groups[keys[1]];
    if (baseline == null || comparison == null) return const [];
    final entries = <AnalyticsGroupedResultEntry>[];
    for (final measure in draft.measures) {
      final a = _aggregateValues(
        baseline.rows,
        measure,
        mean: measure == AnalyticsMeasure.unitPrice,
      );
      final b = _aggregateValues(
        comparison.rows,
        measure,
        mean: measure == AnalyticsMeasure.unitPrice,
      );
      if (draft.operation == AnalyticsOperation.difference) {
        for (final bValue in b.values) {
          final aValue = a[bValue.compatibilityKey.value];
          if (aValue == null) {
            entries.add(
              _unavailableEntry(comparison, measure, draft.operation),
            );
            continue;
          }
          final eligibleA = _eligibleRows(
            baseline.rows,
            measure,
            bValue.compatibilityKey,
          );
          final eligibleB = _eligibleRows(
            comparison.rows,
            measure,
            bValue.compatibilityKey,
          );
          final eligibleSamples =
              _sampleCount(eligibleA, measure) +
              _sampleCount(eligibleB, measure);
          final totalSamples =
              _sampleCount(baseline.rows, measure) +
              _sampleCount(comparison.rows, measure);
          entries.add(
            AnalyticsGroupedResultEntry(
              groupKey: AnalyticsGroupKey(
                value: '${baseline.key.value}->${comparison.key.value}',
                seriesLabels: baseline.key.seriesLabels,
                breakdownLabels: baseline.key.breakdownLabels,
                determinantLabel:
                    '${comparison.key.determinantLabel} minus ${baseline.key.determinantLabel}',
              ),
              measure: measure,
              operation: draft.operation,
              compatibilityKey: bValue.compatibilityKey,
              value: AnalyticsIntegerResultValue(
                label:
                    '${comparison.key.determinantLabel} minus ${baseline.key.determinantLabel} ${_measureLabel(measure)}',
                value: _checkedSubtract(bValue.value, aValue.value),
                compatibilityKey: bValue.compatibilityKey,
              ),
              eligibleCount: eligibleSamples,
              totalCount: totalSamples,
              excludedCount: totalSamples - eligibleSamples,
              contributingRowIds: {
                for (final row in [...eligibleA, ...eligibleB]) row.id,
              },
            ),
          );
        }
      } else {
        for (final whole in b.values) {
          final part = a[whole.compatibilityKey.value];
          if (whole.value == 0) {
            final totalSamples =
                _sampleCount(baseline.rows, measure) +
                _sampleCount(comparison.rows, measure);
            entries.add(
              AnalyticsGroupedResultEntry(
                groupKey: AnalyticsGroupKey(
                  value: '${baseline.key.value}/${comparison.key.value}',
                  seriesLabels: baseline.key.seriesLabels,
                  breakdownLabels: baseline.key.breakdownLabels,
                  determinantLabel:
                      '${baseline.key.determinantLabel} as a percentage of ${comparison.key.determinantLabel}',
                ),
                measure: measure,
                operation: draft.operation,
                compatibilityKey: whole.compatibilityKey,
                value: const AnalyticsUnavailableResultValue(
                  label: 'Percentage',
                  reason: AnalyticsUnavailableReason.zeroDenominator,
                  message: 'Percentage unavailable - the total is zero.',
                ),
                eligibleCount: 0,
                totalCount: totalSamples,
                excludedCount: totalSamples,
                contributingRowIds: {
                  for (final row in [...baseline.rows, ...comparison.rows])
                    row.id,
                },
              ),
            );
            continue;
          }
          if (part == null) {
            entries.add(
              _unavailableEntry(comparison, measure, draft.operation),
            );
            continue;
          }
          final eligibleA = _eligibleRows(
            baseline.rows,
            measure,
            whole.compatibilityKey,
          );
          final eligibleB = _eligibleRows(
            comparison.rows,
            measure,
            whole.compatibilityKey,
          );
          final eligibleSamples =
              _sampleCount(eligibleA, measure) +
              _sampleCount(eligibleB, measure);
          final totalSamples =
              _sampleCount(baseline.rows, measure) +
              _sampleCount(comparison.rows, measure);
          entries.add(
            AnalyticsGroupedResultEntry(
              groupKey: AnalyticsGroupKey(
                value: '${baseline.key.value}/${comparison.key.value}',
                seriesLabels: baseline.key.seriesLabels,
                breakdownLabels: baseline.key.breakdownLabels,
                determinantLabel:
                    '${baseline.key.determinantLabel} as a percentage of ${comparison.key.determinantLabel}',
              ),
              measure: measure,
              operation: draft.operation,
              compatibilityKey: whole.compatibilityKey,
              value: AnalyticsBasisPointResultValue(
                label:
                    '${baseline.key.determinantLabel} as a percentage of ${comparison.key.determinantLabel} ${_measureLabel(measure)}',
                basisPoints: (part.value * 10000) ~/ whole.value,
                part: part.value,
                whole: whole.value,
                compatibilityKey: whole.compatibilityKey,
              ),
              eligibleCount: eligibleSamples,
              totalCount: totalSamples,
              excludedCount: totalSamples - eligibleSamples,
              contributingRowIds: {
                for (final row in [...eligibleA, ...eligibleB]) row.id,
              },
            ),
          );
        }
      }
    }
    return List.unmodifiable(entries);
  }

  Map<String, _GroupBucket> _groups(
    List<AnalyticsEvidenceRow> rows,
    AnalyticsComposerDraft draft,
  ) {
    final buckets = <String, _GroupBucket>{};
    for (final row in rows) {
      final determinantKey = _determinantOption(row, draft.determinant).key;
      if (!draft.selectedDeterminantKeys.contains(determinantKey)) continue;
      final key = _groupKey(row, draft);
      buckets.putIfAbsent(key.value, () => _GroupBucket(key, [])).rows.add(row);
    }
    return buckets;
  }

  AnalyticsGroupKey _groupKey(
    AnalyticsEvidenceRow row,
    AnalyticsComposerDraft draft,
  ) {
    final determinant = _determinantOption(row, draft.determinant);
    final breakdownLabels = <AnalyticsRelationalBreakdown, String>{};
    final parts = <String>[determinant.key];
    final seriesLabels = <String>[];
    for (final axis in draft.axes) {
      if (axis.kind == null) continue;
      final option = _determinantOption(row, axis.kind!);
      parts.add('${axis.kind!.name}:${option.key}');
      seriesLabels.add(option.label);
    }
    for (final breakdown in draft.breakdowns) {
      final option = _breakdownOption(row, breakdown);
      breakdownLabels[breakdown] = option.label;
      parts.add('${breakdown.name}:${option.key}');
    }
    return AnalyticsGroupKey(
      value: parts.join('|'),
      determinantLabel: determinant.label,
      breakdownLabels: breakdownLabels,
      seriesLabels: seriesLabels,
    );
  }

  List<AnalyticsGroupedResultEntry> _aggregateGroup(
    AnalyticDefinition definition,
    AnalyticsOperation operation,
    _GroupBucket group,
    AnalyticsMeasure measure,
  ) {
    final Map<String, AnalyticsIntegerResultValue> values;
    try {
      final mean = operation == AnalyticsOperation.mean;
      values = _aggregateValues(group.rows, measure, mean: mean);
    } on AnalyticsOverflow {
      return [
        AnalyticsGroupedResultEntry(
          groupKey: group.key,
          measure: measure,
          operation: operation,
          compatibilityKey: const AnalyticsCompatibilityKey('none'),
          value: AnalyticsUnavailableResultValue(
            label: _measureLabel(measure),
            reason: AnalyticsUnavailableReason.overflow,
            message:
                'This result could not be calculated. The evidence and record were preserved.',
          ),
          eligibleCount: 0,
          totalCount: group.rows.length,
          excludedCount: group.rows.length,
          contributingRowIds: {for (final row in group.rows) row.id},
        ),
      ];
    }
    if (values.isEmpty) return [_unavailableEntry(group, measure, operation)];
    return [
      for (final value in values.values)
        AnalyticsGroupedResultEntry(
          groupKey: group.key,
          measure: measure,
          operation: operation,
          compatibilityKey: value.compatibilityKey,
          value: value,
          eligibleCount: _sampleCount(
            _eligibleRows(group.rows, measure, value.compatibilityKey),
            measure,
          ),
          totalCount: _sampleCount(group.rows, measure),
          excludedCount:
              _sampleCount(group.rows, measure) -
              _sampleCount(
                _eligibleRows(group.rows, measure, value.compatibilityKey),
                measure,
              ),
          contributingRowIds: {
            for (final row in _eligibleRows(
              group.rows,
              measure,
              value.compatibilityKey,
            ))
              row.id,
          },
        ),
    ];
  }

  int _sampleCount(List<AnalyticsEvidenceRow> rows, AnalyticsMeasure measure) =>
      measure == AnalyticsMeasure.purchaseTotal
      ? rows.map((row) => row.purchaseId.value).toSet().length
      : rows.length;

  List<AnalyticsEvidenceRow> _eligibleRows(
    List<AnalyticsEvidenceRow> rows,
    AnalyticsMeasure measure,
    AnalyticsCompatibilityKey compatibility,
  ) => rows
      .where(
        (row) => _valueFor(
          measure,
          row,
          <String>{},
        ).keys.any((key) => key.value == compatibility.value),
      )
      .toList();

  Map<String, AnalyticsIntegerResultValue> _aggregateValues(
    List<AnalyticsEvidenceRow> rows,
    AnalyticsMeasure measure, {
    required bool mean,
  }) {
    final buckets =
        <String, ({AnalyticsCompatibilityKey key, int total, int count})>{};
    final purchaseSeen = <String>{};
    for (final row in rows) {
      for (final entry in _valueFor(measure, row, purchaseSeen).entries) {
        final existing = buckets[entry.key.value];
        buckets[entry.key.value] = (
          key: entry.key,
          total: _checkedAdd(existing?.total ?? 0, entry.value),
          count: (existing?.count ?? 0) + 1,
        );
      }
    }
    return {
      for (final bucket in buckets.values)
        bucket.key.value: AnalyticsIntegerResultValue(
          label: _measureLabel(measure),
          value: mean ? bucket.total ~/ bucket.count : bucket.total,
          compatibilityKey: bucket.key,
          unitLabel: _unitLabel(measure, bucket.key),
        ),
    };
  }

  Map<AnalyticsCompatibilityKey, int> _valueFor(
    AnalyticsMeasure measure,
    AnalyticsEvidenceRow row,
    Set<String> purchaseSeen,
  ) {
    return switch (measure) {
      AnalyticsMeasure.quantity => {
        AnalyticsCompatibilityKey(
          'quantity:${row.quantity.kind.name}:${row.quantity.unit.name}',
        ): row.quantity.microunits,
      },
      AnalyticsMeasure.unitPrice when row.unitPrice != null => {
        AnalyticsCompatibilityKey(
          'unitPrice:${row.unitPrice!.currencyCode}:${row.unitPrice!.kind.name}:${row.unitPrice!.unit.name}',
        ): row.unitPrice!.minorUnitsPerCanonicalUnit,
      },
      AnalyticsMeasure.unitPrice => const {},
      AnalyticsMeasure.lineTotal => {
        AnalyticsCompatibilityKey('money:${row.lineTotal.currencyCode}'):
            row.lineTotal.minorUnits,
      },
      AnalyticsMeasure.purchaseTotal
          when purchaseSeen.add(row.purchaseId.value) =>
        {
          AnalyticsCompatibilityKey(
            'purchaseTotal:${row.purchaseTotal.currencyCode}',
          ): row.purchaseTotal.minorUnits,
        },
      AnalyticsMeasure.purchaseTotal => const {},
      AnalyticsMeasure.evidenceCount => {
        const AnalyticsCompatibilityKey('evidenceCount:itemRow'): 1,
      },
    };
  }

  AnalyticsGroupedResultEntry _unavailableEntry(
    _GroupBucket group,
    AnalyticsMeasure measure,
    AnalyticsOperation operation,
  ) {
    return AnalyticsGroupedResultEntry(
      groupKey: group.key,
      measure: measure,
      operation: operation,
      compatibilityKey: const AnalyticsCompatibilityKey('none'),
      value: AnalyticsUnavailableResultValue(
        label: _measureLabel(measure),
        reason: AnalyticsUnavailableReason.unavailableField,
        message: '${_measureLabel(measure)} is unavailable for this group.',
      ),
      eligibleCount: 0,
      totalCount: group.rows.length,
      excludedCount: group.rows.length,
      contributingRowIds: {for (final row in group.rows) row.id},
    );
  }

  List<AnalyticsEvidenceRow> _rowsForDraft(AnalyticsDataset dataset) {
    var rows = dataset.rows
        .where((row) {
          for (final condition in _draft.timeframe.toConditions()) {
            if (condition is AnalyticsUtcPeriodCondition &&
                !condition.contains(row.purchaseOccurrenceTime)) {
              return false;
            }
          }
          for (final axis in _draft.axes) {
            if (axis.kind != null &&
                axis.selectedKeys.isNotEmpty &&
                !axis.selectedKeys.contains(
                  _determinantOption(row, axis.kind!).key,
                )) {
              return false;
            }
          }
          return true;
        })
        .toList(growable: false);
    final scope = _draft.scope;
    if (scope is SelectedAnalyticsEvidenceScope) {
      final selected = {for (final id in scope.rowIds) id.value};
      rows = rows.where((row) => selected.contains(row.id.value)).toList();
    }
    return rows;
  }

  Map<AnalyticsDeterminantKind, List<AnalyticsOption>> _options() {
    final cached = _optionCache;
    if (cached != null) return cached;
    final rows = _dataset?.rows ?? const <AnalyticsEvidenceRow>[];
    final result = <AnalyticsDeterminantKind, Map<String, AnalyticsOption>>{
      for (final kind in AnalyticsDeterminantKind.values)
        kind: <String, AnalyticsOption>{},
    };
    for (final row in rows) {
      for (final kind in AnalyticsDeterminantKind.values) {
        final option = _determinantOption(row, kind);
        result[kind]![option.key] = option;
      }
    }
    return _optionCache = {
      for (final entry in result.entries)
        entry.key:
            (entry.value.values.toList()
                  ..sort((a, b) => a.label.compareTo(b.label)))
                .toList(growable: false),
    };
  }

  AnalyticsOption _determinantOption(
    AnalyticsEvidenceRow row,
    AnalyticsDeterminantKind kind,
  ) {
    return analyticsDimensionOption(row, kind);
  }

  AnalyticsOption _breakdownOption(
    AnalyticsEvidenceRow row,
    AnalyticsRelationalBreakdown breakdown,
  ) {
    return switch (breakdown) {
      AnalyticsRelationalBreakdown.purchasedBy =>
        row.purchasedBy == null
            ? const AnalyticsOption(key: 'person:none', label: 'Not assigned')
            : AnalyticsOption(
                key: 'person:${row.purchasedBy!.id}',
                label: row.purchasedBy!.displayLabel,
              ),
      AnalyticsRelationalBreakdown.paymentMethod =>
        row.paymentMethod == null
            ? const AnalyticsOption(key: 'payment:none', label: 'Not assigned')
            : AnalyticsOption(
                key: 'payment:${row.paymentMethod!.id}',
                label: row.paymentMethod!.displayLabel,
              ),
      AnalyticsRelationalBreakdown.purchasedFor => const AnalyticsOption(
        key: 'purchasedFor:unavailable',
        label: 'Unavailable in recorded data',
      ),
    };
  }

  List<AnalyticsOption> _selectedOptionsForDraft() {
    final byKey = {
      for (final option
          in _options()[_draft.determinant] ?? const <AnalyticsOption>[])
        option.key: option,
    };
    return [
      for (final key in (_draft.selectedDeterminantKeys.toList()..sort()))
        byKey[key] ?? AnalyticsOption(key: key, label: key),
    ];
  }

  AnalyticsVariablesState _variablesState() {
    final dataset = _dataset;
    final record = _selectedRecord;
    final rows =
        _focusedRowIds != null &&
            record != null &&
            record.evidenceRows.isNotEmpty
        ? record.evidenceRows
        : dataset?.rows ?? const <AnalyticsEvidenceRow>[];
    final focused = _focusedRowIds;
    final focusedValues = focused == null
        ? null
        : {for (final id in focused) id.value};
    final baseRows = focusedValues == null
        ? rows
        : rows.where((row) => focusedValues.contains(row.id.value)).toList();
    final query = _variablesSearch.trim().toLowerCase();
    final itemRows = baseRows.where((row) {
      if (query.isEmpty) return true;
      return row.purchaseId.value.toLowerCase().contains(query) ||
          row.productCode.toLowerCase().contains(query) ||
          row.productName.toLowerCase().contains(query) ||
          row.storeName.toLowerCase().contains(query) ||
          (row.purchasedByLabel ?? '').toLowerCase().contains(query) ||
          (row.paymentMethodLabel ?? '').toLowerCase().contains(query);
    }).toList();
    itemRows.sort(_compareItems);
    final purchases = _purchaseProjection(itemRows)..sort(_comparePurchases);
    final filteredCount =
        _variablesProjection == AnalyticsVariablesProjection.purchases
        ? purchases.length
        : itemRows.length;
    final finalPage = filteredCount == 0
        ? 0
        : (filteredCount - 1) ~/ renderedPageSize;
    _variablesPageIndex = _variablesPageIndex.clamp(0, finalPage);
    final pageStart = _variablesPageIndex * renderedPageSize;
    final pagedItems = itemRows.skip(pageStart).take(renderedPageSize).toList();
    final pagedPurchases = purchases
        .skip(pageStart)
        .take(renderedPageSize)
        .toList();
    return AnalyticsVariablesState(
      projection: _variablesProjection,
      search: _variablesSearch,
      sort: _variablesSort,
      pageIndex: _variablesPageIndex,
      pageSize: renderedPageSize,
      filteredCount: filteredCount,
      purchaseRows: pagedPurchases,
      itemRows: pagedItems,
      selectedRowIds: _selectedRowIds,
      focusedRecord: _selectedRecord,
      message: focused == null || _selectedRecord == null
          ? null
          : 'Showing variables that contributed to Record #${_selectedRecord!.fingerprint}.',
    );
  }

  List<AnalyticsPurchaseProjectionRow> _purchaseProjection(
    List<AnalyticsEvidenceRow> rows,
  ) {
    final grouped = <String, List<AnalyticsEvidenceRow>>{};
    for (final row in rows) {
      grouped.putIfAbsent(row.purchaseId.value, () => []).add(row);
    }
    return [
      for (final rows in grouped.values)
        AnalyticsPurchaseProjectionRow(
          purchaseId: rows.first.purchaseId,
          occurrenceTime: rows.first.purchaseOccurrenceTime,
          storeId: rows.first.storeId,
          storeName: rows.first.storeName,
          purchasedBy: rows.first.purchasedBy,
          paymentMethod: rows.first.paymentMethod,
          itemCount: rows.length,
          purchaseTotal: rows.first.purchaseTotal,
          itemIds: {for (final row in rows) row.id},
          unavailableReason: _purchaseContradiction(rows),
        ),
    ];
  }

  AnalyticsUnavailableResultValue? _purchaseContradiction(
    List<AnalyticsEvidenceRow> rows,
  ) {
    final first = rows.first;
    final differs = rows.any(
      (row) =>
          row.storeId.value != first.storeId.value ||
          row.purchaseTotal.currencyCode != first.purchaseTotal.currencyCode ||
          row.purchaseTotal.minorUnits != first.purchaseTotal.minorUnits ||
          row.purchaseOccurrenceTime.toUtc() !=
              first.purchaseOccurrenceTime.toUtc(),
    );
    if (!differs) return null;
    return const AnalyticsUnavailableResultValue(
      label: 'Purchase projection',
      reason: AnalyticsUnavailableReason.contradiction,
      message:
          'Purchase-level facts disagree across contained items. This Purchase is visible but unavailable for summary calculation.',
    );
  }

  int _compareItems(AnalyticsEvidenceRow left, AnalyticsEvidenceRow right) {
    final primary = switch (_variablesSort) {
      AnalyticsVariablesSort.timeAscending =>
        left.purchaseOccurrenceTime.compareTo(right.purchaseOccurrenceTime),
      AnalyticsVariablesSort.timeDescending =>
        right.purchaseOccurrenceTime.compareTo(left.purchaseOccurrenceTime),
      AnalyticsVariablesSort.labelAscending =>
        left.productName.toLowerCase().compareTo(
          right.productName.toLowerCase(),
        ),
      AnalyticsVariablesSort.totalDescending =>
        right.lineTotal.minorUnits.compareTo(left.lineTotal.minorUnits),
    };
    if (primary != 0) return primary;
    return left.id.value.compareTo(right.id.value);
  }

  int _comparePurchases(
    AnalyticsPurchaseProjectionRow left,
    AnalyticsPurchaseProjectionRow right,
  ) {
    final primary = switch (_variablesSort) {
      AnalyticsVariablesSort.timeAscending => left.occurrenceTime.compareTo(
        right.occurrenceTime,
      ),
      AnalyticsVariablesSort.timeDescending => right.occurrenceTime.compareTo(
        left.occurrenceTime,
      ),
      AnalyticsVariablesSort.labelAscending =>
        left.storeName.toLowerCase().compareTo(right.storeName.toLowerCase()),
      AnalyticsVariablesSort.totalDescending =>
        right.purchaseTotal.minorUnits.compareTo(left.purchaseTotal.minorUnits),
    };
    if (primary != 0) return primary;
    return left.purchaseId.value.compareTo(right.purchaseId.value);
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
    _draft = _draft.copyWith(
      scope: _selectedRowIds.isEmpty
          ? const FilteredAnalyticsEvidenceScope()
          : SelectedAnalyticsEvidenceScope(_selectedRowIds),
    );
  }

  AnalyticsRecord? get _selectedRecord {
    final selected = _selectedRecordId;
    if (selected == null) return null;
    return _records
        .where((record) => record.id.value == selected.value)
        .firstOrNull;
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
        'History scope received: requested ${requested.length}, matched ${matched.length}, unavailable $stale Purchase(s). Use in Analytics prepared the scope only; no analysis was calculated or saved.';
    if (stale <= 0) return base;
    return '$base Unavailable Purchases were not used because they are stale or outside this Account.';
  }

  AnalyticsResultPresentation _defaultPresentation(AnalyticsRecord record) {
    final plottable = record.entries
        .where((entry) => entry.isPlottable)
        .toList();
    if (plottable.isEmpty) return AnalyticsResultPresentation.table;
    final compatibilityKeys = {
      for (final entry in plottable) entry.compatibilityKey.value,
    };
    if (compatibilityKeys.length > 1) return AnalyticsResultPresentation.table;
    return AnalyticsResultPresentation.chart;
  }

  String _fingerprint(String canonical, List<AnalyticsRecord> existing) {
    final digest = sha256
        .convert(utf8.encode(canonical))
        .toString()
        .toUpperCase();
    for (var length = 8; length <= 16; length += 2) {
      final prefix = digest.substring(0, length);
      if (!existing.any((record) => record.fingerprint == prefix)) {
        return prefix;
      }
    }
    return '${digest.substring(0, 16)}-${existing.length + 1}';
  }

  AnalyticsRecord? get _matchingRecord =>
      _dataset == null ? null : _recordsByExecution[_executionSignature()];

  /// Separate from the display fingerprint, which intentionally contains time
  /// and record identity. Include values and labels, not only stable row IDs.
  String _executionSignature() {
    List<String> sorted(Iterable<String> values) => values.toList()..sort();
    final scope = _draft.scope;
    final definition = _registry.definitionFor(_draft.operation);
    return sha256
        .convert(
          utf8.encode(
            jsonEncode([
              _accountId.value,
              definition.identifier,
              definition.version,
              _draft.determinant.name,
              sorted(_draft.selectedDeterminantKeys),
              [
                for (final axis in _draft.axes)
                  [axis.kind?.name, sorted(axis.selectedKeys)],
              ],
              sorted(_draft.variables.map((value) => value.name)),
              sorted(_draft.measures.map((value) => value.name)),
              sorted(_draft.breakdowns.map((value) => value.name)),
              _draft.operation.name,
              [
                _draft.timeframe.kind.name,
                _draft.timeframe.startUtc?.toUtc().toIso8601String(),
                _draft.timeframe.endUtc?.toUtc().toIso8601String(),
              ],
              switch (scope) {
                SelectedAnalyticsEvidenceScope() => [
                  'selected',
                  sorted(scope.rowIds.map((id) => id.value)),
                ],
                ComparisonAnalyticsEvidenceScope() => [
                  'comparison',
                  scope.baselineLabel,
                  sorted(scope.baselineRowIds.map((id) => id.value)),
                  scope.comparisonLabel,
                  sorted(scope.comparisonRowIds.map((id) => id.value)),
                ],
                PercentageAnalyticsEvidenceScope() => [
                  'percentage',
                  scope.partLabel,
                  sorted(scope.partRowIds.map((id) => id.value)),
                  scope.wholeLabel,
                  sorted(scope.wholeRowIds.map((id) => id.value)),
                ],
                FilteredAnalyticsEvidenceScope() => 'filtered',
              },
              _evidenceSignature,
            ]),
          ),
        )
        .toString();
  }

  String _datasetSignature(AnalyticsDataset dataset) {
    Object? reference(AnalyticsReference? value) => value == null
        ? null
        : [value.id, value.code, value.label, value.archived];
    final rows = [...dataset.rows]
      ..sort((a, b) => a.id.value.compareTo(b.id.value));
    return sha256
        .convert(
          utf8.encode(
            jsonEncode([
              for (final row in rows)
                [
                  row.id.value,
                  row.accountId.value,
                  row.purchaseId.value,
                  row.purchaseOccurrenceTime.toUtc().toIso8601String(),
                  row.purchaseTotal.currencyCode,
                  row.purchaseTotal.minorUnits,
                  row.productId.value,
                  row.productCode,
                  row.productName,
                  row.productBrand,
                  row.storeId.value,
                  row.storeName,
                  reference(row.purchasedBy),
                  reference(row.paymentMethod),
                  row.quantity.kind.name,
                  row.quantity.unit.name,
                  row.quantity.microunits,
                  row.lineTotal.currencyCode,
                  row.lineTotal.minorUnits,
                  if (row.unitPrice == null)
                    null
                  else
                    [
                      row.unitPrice!.currencyCode,
                      row.unitPrice!.kind.name,
                      row.unitPrice!.unit.name,
                      row.unitPrice!.minorUnitsPerCanonicalUnit,
                    ],
                ],
            ]),
          ),
        )
        .toString();
  }

  String _recordSeed(
    AnalyticsRecordId id,
    DateTime executedAt,
    AnalyticsComposerDraft draft,
    List<AnalyticsOption> selectedValues,
    List<String> rowIds,
  ) {
    final sortedRowIds = rowIds..sort();
    return [
      'id=${id.value}',
      'time=${executedAt.toIso8601String()}',
      'determinant=${draft.determinant.name}',
      'keys=${selectedValues.map((o) => o.key).join('|')}',
      'breakdowns=${draft.breakdowns.map((b) => b.name).toList()..sort()}',
      'measures=${draft.measures.map((m) => m.name).toList()..sort()}',
      'variables=${draft.variables.map((v) => v.name).toList()..sort()}',
      'axes=${draft.axes.map((a) => '${a.kind?.name}:${a.selectedKeys.toList()..sort()}').join('|')}',
      'operation=${draft.operation.name}',
      'timeframe=${draft.timeframe.label}',
      'rows=${sortedRowIds.join('|')}',
    ].join('\n');
  }
}

final class _GroupBucket {
  _GroupBucket(this.key, this.rows);

  final AnalyticsGroupKey key;
  final List<AnalyticsEvidenceRow> rows;
}

AnalyticsEvidenceScope _freezeScope(AnalyticsEvidenceScope scope) =>
    switch (scope) {
      FilteredAnalyticsEvidenceScope() => scope,
      SelectedAnalyticsEvidenceScope() => SelectedAnalyticsEvidenceScope(
        Set.unmodifiable(scope.rowIds),
      ),
      ComparisonAnalyticsEvidenceScope() => ComparisonAnalyticsEvidenceScope(
        baselineLabel: scope.baselineLabel,
        baselineRowIds: Set.unmodifiable(scope.baselineRowIds),
        comparisonLabel: scope.comparisonLabel,
        comparisonRowIds: Set.unmodifiable(scope.comparisonRowIds),
      ),
      PercentageAnalyticsEvidenceScope() => PercentageAnalyticsEvidenceScope(
        partLabel: scope.partLabel,
        partRowIds: Set.unmodifiable(scope.partRowIds),
        wholeLabel: scope.wholeLabel,
        wholeRowIds: Set.unmodifiable(scope.wholeRowIds),
      ),
    };

AnalyticsVariable _variableFor(AnalyticsMeasure measure) => switch (measure) {
  AnalyticsMeasure.quantity => AnalyticsVariable.quantity,
  AnalyticsMeasure.unitPrice => AnalyticsVariable.unitPrice,
  AnalyticsMeasure.lineTotal => AnalyticsVariable.lineTotal,
  AnalyticsMeasure.purchaseTotal => AnalyticsVariable.purchaseTotal,
  AnalyticsMeasure.evidenceCount => AnalyticsVariable.evidenceCount,
};

int _checkedAdd(int left, int right) {
  final value = left + right;
  if ((right > 0 && value < left) || (right < 0 && value > left)) {
    throw const AnalyticsOverflow();
  }
  return value;
}

int _checkedSubtract(int left, int right) => _checkedAdd(left, -right);

String _measureLabel(AnalyticsMeasure measure) => switch (measure) {
  AnalyticsMeasure.quantity => 'Quantity',
  AnalyticsMeasure.unitPrice => 'Unit price',
  AnalyticsMeasure.lineTotal => 'Price paid',
  AnalyticsMeasure.purchaseTotal => 'Purchase total',
  AnalyticsMeasure.evidenceCount => 'Evidence count',
};

String _variableLabel(AnalyticsVariable variable) => switch (variable) {
  AnalyticsVariable.purchasedBy => 'Purchased by',
  AnalyticsVariable.purchasedFor => 'Purchased for',
  AnalyticsVariable.paymentMethod => 'Payment method',
  AnalyticsVariable.quantity => 'Quantity',
  AnalyticsVariable.unitPrice => 'Unit price',
  AnalyticsVariable.lineTotal => 'Price paid',
  AnalyticsVariable.purchaseTotal => 'Purchase total',
  AnalyticsVariable.evidenceCount => 'Evidence count',
};

String _unitLabel(AnalyticsMeasure measure, AnalyticsCompatibilityKey key) {
  return analyticsDisplayValue(
    measure,
    AnalyticsIntegerResultValue(
      label: _measureLabel(measure),
      value: 0,
      compatibilityKey: key,
    ),
  ).unit;
}

AnalyticsVariable _variableForBreakdown(
  AnalyticsRelationalBreakdown value,
) => switch (value) {
  AnalyticsRelationalBreakdown.purchasedBy => AnalyticsVariable.purchasedBy,
  AnalyticsRelationalBreakdown.paymentMethod => AnalyticsVariable.paymentMethod,
  AnalyticsRelationalBreakdown.purchasedFor => AnalyticsVariable.purchasedFor,
};

AnalyticsVariable _variableForMeasure(AnalyticsMeasure measure) =>
    switch (measure) {
      AnalyticsMeasure.quantity => AnalyticsVariable.quantity,
      AnalyticsMeasure.unitPrice => AnalyticsVariable.unitPrice,
      AnalyticsMeasure.lineTotal => AnalyticsVariable.lineTotal,
      AnalyticsMeasure.purchaseTotal => AnalyticsVariable.purchaseTotal,
      AnalyticsMeasure.evidenceCount => AnalyticsVariable.evidenceCount,
    };

String _operationLabel(AnalyticsOperation operation) => switch (operation) {
  AnalyticsOperation.sum => 'Sum',
  AnalyticsOperation.mean => 'Mean',
  AnalyticsOperation.difference => 'Difference',
  AnalyticsOperation.percentage => 'Percentage',
};
