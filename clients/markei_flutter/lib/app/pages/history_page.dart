import 'dart:convert';

import 'package:flutter/material.dart';

import '../../application/export_destination.dart';
import '../../application/history_export.dart';
import '../../application/purchase_history.dart';
import '../../domain/shared/ids.dart';
import '../design/markei_theme.dart';
import '../widgets/markei_components.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    required this.accountId,
    required this.history,
    required this.exports,
    required this.exportDestination,
    required this.refreshSignal,
    this.onAnalyzeSelected,
    super.key,
  });

  final AccountId accountId;
  final PurchaseHistoryRepository history;
  final PurchaseExportRepository exports;
  final ExportDestinationPort exportDestination;
  final int refreshSignal;
  final ValueChanged<Set<PurchaseId>>? onAnalyzeSelected;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _retrySignal = 0;
  PurchaseId? _selectedPurchaseId;
  final Set<PurchaseId> _selectedIds = {};
  String? _message;
  late Future<List<PurchaseHistoryEntry>> _historyFuture;
  int _seenRefreshSignal = 0;
  String _storeFilter = _allFilter;
  String _personFilter = _allFilter;
  String _paymentFilter = _allFilter;
  bool _exportInProgress = false;

  static const _allFilter = 'All';

  @override
  void initState() {
    super.initState();
    _seenRefreshSignal = widget.refreshSignal;
    _historyFuture = _loadHistory();
  }

  @override
  void didUpdateWidget(covariant HistoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshSignal != _seenRefreshSignal ||
        oldWidget.history != widget.history ||
        oldWidget.accountId != widget.accountId) {
      _seenRefreshSignal = widget.refreshSignal;
      _historyFuture = _loadHistory();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PurchaseHistoryEntry>>(
      key: ValueKey('${widget.refreshSignal}-$_retrySignal'),
      future: _historyFuture,
      builder: (context, snapshot) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final layoutClass = MarkeiLayoutClass.fromWidth(
              constraints.maxWidth,
            );
            return _buildForSnapshot(context, snapshot, layoutClass);
          },
        );
      },
    );
  }

  Widget _buildForSnapshot(
    BuildContext context,
    AsyncSnapshot<List<PurchaseHistoryEntry>> snapshot,
    MarkeiLayoutClass layoutClass,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const MarkeiStatePanel(
        key: Key('history.loading'),
        title: 'Loading History',
        message: 'Loading registered Purchases.',
        icon: Icons.hourglass_empty,
      );
    }
    if (snapshot.hasError) {
      return MarkeiStatePanel(
        key: const Key('history.error'),
        title: 'History read failed',
        message: 'Purchase history could not be loaded.',
        icon: Icons.error_outline,
        action: OutlinedButton.icon(
          key: const Key('history.retry'),
          onPressed: _retryHistoryRead,
          icon: const Icon(Icons.refresh),
          label: const Text('Retry History read'),
        ),
      );
    }
    final entries = snapshot.data ?? const <PurchaseHistoryEntry>[];
    if (entries.isEmpty) {
      return const MarkeiStatePanel(
        key: Key('history.empty'),
        title: 'No Purchases yet',
        message: 'Register a Purchase to build local History.',
        icon: Icons.history_outlined,
      );
    }
    final visibleEntries = _filteredEntries(entries);
    final selected = _selectedPurchaseId;
    return ListView(
      key: const Key('history.page'),
      children: [
        MarkeiPageHeader(
          title: 'Purchase history',
          purpose:
              'Review registered Purchases, select records and export the current selection.',
          icon: Icons.history_outlined,
          trailing: Text(
            '${entries.length} Purchase(s)',
            style: MarkeiText.metadata,
          ),
        ),
        const SizedBox(height: MarkeiSpacing.md),
        _filterBand(entries),
        const SizedBox(height: MarkeiSpacing.md),
        _actionBand(visibleEntries),
        if (_message != null) ...[
          const SizedBox(height: MarkeiSpacing.sm),
          Text(_message!, key: const Key('history.export.message')),
        ],
        const SizedBox(height: MarkeiSpacing.md),
        if (visibleEntries.isEmpty)
          const MarkeiStatePanel(
            key: Key('history.filteredEmpty'),
            title: 'No matching Purchases',
            message: 'The current History filters produced no result.',
            icon: Icons.filter_alt_off,
          )
        else if (layoutClass == MarkeiLayoutClass.wide)
          _HistoryRows(
            entries: visibleEntries,
            selectedIds: _selectedIds,
            activeDetailId: _selectedPurchaseId,
            onToggle: _toggleSelection,
            onOpen: _openDetail,
          )
        else
          _HistoryCards(
            entries: visibleEntries,
            selectedIds: _selectedIds,
            activeDetailId: _selectedPurchaseId,
            onToggle: _toggleSelection,
            onOpen: _openDetail,
          ),
        if (selected != null) ...[
          const SizedBox(height: MarkeiSpacing.md),
          _PurchaseDetailView(
            accountId: widget.accountId,
            purchaseId: selected,
            history: widget.history,
          ),
        ],
      ],
    );
  }

  Future<List<PurchaseHistoryEntry>> _loadHistory() async {
    final entries = await widget.history.listRecentPurchases(widget.accountId);
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => _reconcileSelection(entries));
        }
      });
    }
    return entries;
  }

  void _retryHistoryRead() {
    setState(() {
      _retrySignal++;
      _historyFuture = _loadHistory();
    });
  }

  Widget _filterBand(List<PurchaseHistoryEntry> entries) {
    return MarkeiSection(
      title: 'Filters',
      subtitle: 'Presentation filters use the loaded History only.',
      child: MarkeiControlBand(
        children: [
          _filterDropdown(
            key: const Key('history.filter.store'),
            label: 'Store',
            value: _storeFilter,
            values: _filterValues(entries.map((entry) => entry.storeName)),
            onChanged: (value) => _updateFilters(entries, store: value),
          ),
          _filterDropdown(
            key: const Key('history.filter.person'),
            label: 'Person',
            value: _personFilter,
            values: _filterValues(entries.map((entry) => entry.personLabel)),
            onChanged: (value) => _updateFilters(entries, person: value),
          ),
          _filterDropdown(
            key: const Key('history.filter.payment'),
            label: 'Payment method',
            value: _paymentFilter,
            values: _filterValues(
              entries.map((entry) => entry.paymentMethodLabel),
            ),
            onChanged: (value) => _updateFilters(entries, payment: value),
          ),
          OutlinedButton(
            key: const Key('history.filters.clear'),
            onPressed: () => _updateFilters(
              entries,
              store: _allFilter,
              person: _allFilter,
              payment: _allFilter,
            ),
            child: const Text('Clear filters'),
          ),
        ],
      ),
    );
  }

  Widget _filterDropdown({
    required Key key,
    required String label,
    required String value,
    required List<String> values,
    required ValueChanged<String> onChanged,
  }) {
    return SizedBox(
      width: 240,
      child: DropdownButtonFormField<String>(
        key: key,
        initialValue: values.contains(value) ? value : _allFilter,
        isExpanded: true,
        decoration: InputDecoration(labelText: label),
        items: [
          for (final item in values)
            DropdownMenuItem(value: item, child: Text(item)),
        ],
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }

  List<String> _filterValues(Iterable<String?> rawValues) {
    final values = {
      _allFilter,
      for (final value in rawValues)
        if (value != null && value.trim().isNotEmpty) value,
    }.toList();
    values.sort();
    values
      ..remove(_allFilter)
      ..insert(0, _allFilter);
    return values;
  }

  List<PurchaseHistoryEntry> _filteredEntries(
    List<PurchaseHistoryEntry> entries,
  ) {
    return entries
        .where((entry) {
          return (_storeFilter == _allFilter ||
                  entry.storeName == _storeFilter) &&
              (_personFilter == _allFilter ||
                  entry.personLabel == _personFilter) &&
              (_paymentFilter == _allFilter ||
                  entry.paymentMethodLabel == _paymentFilter);
        })
        .toList(growable: false);
  }

  Widget _actionBand(List<PurchaseHistoryEntry> visibleEntries) {
    final allVisibleSelected =
        visibleEntries.isNotEmpty &&
        visibleEntries.every(
          (entry) =>
              _selectedIds.any((id) => id.value == entry.purchaseId.value),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarkeiActionBand(
          leading: Text(
            '${_selectedIds.length} selected for action',
            style: MarkeiText.label,
          ),
          children: [
            FilledButton.tonal(
              key: const Key('history.analyzeSelected'),
              onPressed:
                  _selectedIds.isEmpty || widget.onAnalyzeSelected == null
                  ? null
                  : () => widget.onAnalyzeSelected!(
                      Set.unmodifiable(_selectedIds),
                    ),
              child: const Text('Use in Analytics'),
            ),
            FilledButton.tonal(
              key: const Key('history.exportCsv'),
              onPressed: _selectedIds.isEmpty || _exportInProgress
                  ? null
                  : () => _exportSelected(format: 'CSV'),
              child: const Text('Export CSV'),
            ),
            FilledButton.tonal(
              key: const Key('history.exportPdf'),
              onPressed: _selectedIds.isEmpty || _exportInProgress
                  ? null
                  : () => _exportSelected(format: 'PDF'),
              child: const Text('Export PDF'),
            ),
            TextButton(
              key: const Key('history.selectAll'),
              onPressed: allVisibleSelected
                  ? null
                  : () => setState(() {
                      _selectedIds
                        ..clear()
                        ..addAll(
                          visibleEntries.map((entry) => entry.purchaseId),
                        );
                    }),
              child: const Text('Select all shown'),
            ),
            TextButton(
              key: const Key('history.clearSelection'),
              onPressed: _selectedIds.isEmpty
                  ? null
                  : () => setState(_selectedIds.clear),
              child: const Text('Clear selection'),
            ),
          ],
        ),
        if (_selectedIds.isEmpty) ...[
          const SizedBox(height: MarkeiSpacing.xs),
          const Text(
            'Select at least one shown Purchase to export or use in Analytics.',
            key: Key('history.action.reason'),
          ),
        ],
      ],
    );
  }

  void _updateFilters(
    List<PurchaseHistoryEntry> entries, {
    String? store,
    String? person,
    String? payment,
  }) {
    setState(() {
      if (store != null) _storeFilter = store;
      if (person != null) _personFilter = person;
      if (payment != null) _paymentFilter = payment;
      _reconcileSelection(_filteredEntries(entries));
    });
  }

  void _reconcileSelection(List<PurchaseHistoryEntry> entries) {
    final loadedIds = {for (final entry in entries) entry.purchaseId.value};
    _selectedIds.removeWhere((id) => !loadedIds.contains(id.value));
    if (_selectedPurchaseId case final selected?) {
      if (!loadedIds.contains(selected.value)) {
        _selectedPurchaseId = null;
      }
    }
  }

  void _toggleSelection(PurchaseId purchaseId) {
    setState(() {
      final existing = _selectedIds
          .where((id) => id.value == purchaseId.value)
          .toList(growable: false);
      if (existing.isEmpty) {
        _selectedIds.add(purchaseId);
      } else {
        _selectedIds.remove(existing.first);
      }
    });
  }

  void _openDetail(PurchaseId purchaseId) {
    setState(() => _selectedPurchaseId = purchaseId);
  }

  Future<void> _exportSelected({required String format}) async {
    if (_exportInProgress) {
      setState(() => _message = 'Another export is already in progress.');
      return;
    }
    final ids = Set<PurchaseId>.unmodifiable(_selectedIds);
    if (ids.isEmpty) {
      setState(() => _message = 'Select at least one Purchase before export.');
      return;
    }
    setState(() {
      _exportInProgress = true;
      _message = 'Preparing $format export from selected Purchases...';
    });
    try {
      final bundle = await widget.exports.exportBundle(widget.accountId, ids);
      final result = await widget.exportDestination.write(
        ExportDestinationRequest(
          baseNameCue: 'markei-selected-purchases',
          extension: format.toLowerCase(),
          mediaType: format == 'CSV' ? 'text/csv' : 'application/pdf',
          bytes: format == 'CSV'
              ? utf8.encode(purchaseBundleCsv(bundle))
              : purchaseBundlePdfBytes(bundle),
        ),
      );
      if (!mounted) return;
      setState(() => _message = exportDestinationMessage(format, result));
    } on Object {
      if (!mounted) return;
      setState(
        () => _message =
            'The export could not be completed. No completed file is available.',
      );
    } finally {
      if (mounted) setState(() => _exportInProgress = false);
    }
  }
}

class _HistoryRows extends StatelessWidget {
  const _HistoryRows({
    required this.entries,
    required this.selectedIds,
    required this.activeDetailId,
    required this.onToggle,
    required this.onOpen,
  });

  final List<PurchaseHistoryEntry> entries;
  final Set<PurchaseId> selectedIds;
  final PurchaseId? activeDetailId;
  final ValueChanged<PurchaseId> onToggle;
  final ValueChanged<PurchaseId> onOpen;

  @override
  Widget build(BuildContext context) {
    return MarkeiCard(
      padding: const EdgeInsets.all(MarkeiSpacing.xs),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Select')),
            DataColumn(label: Text('Store')),
            DataColumn(label: Text('Date / Time')),
            DataColumn(label: Text('Items')),
            DataColumn(label: Text('Recorded total')),
            DataColumn(label: Text('Detail')),
          ],
          rows: [
            for (final entry in entries)
              DataRow(
                key: ValueKey('history.row.${entry.purchaseId.value}'),
                cells: [
                  DataCell(
                    Semantics(
                      label:
                          '${_containsPurchase(selectedIds, entry.purchaseId) ? 'Deselect' : 'Select'} Purchase ${entry.purchaseId.value} for action',
                      child: Checkbox(
                        key: Key('history.select.${entry.purchaseId.value}'),
                        value: _containsPurchase(selectedIds, entry.purchaseId),
                        onChanged: (_) => onToggle(entry.purchaseId),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(entry.storeName),
                    onTap: () => onOpen(entry.purchaseId),
                  ),
                  DataCell(
                    Text(_formatOccurrence(entry.occurrenceTime)),
                    onTap: () => onOpen(entry.purchaseId),
                  ),
                  DataCell(Text('${entry.itemCount} Purchase Item(s)')),
                  DataCell(Text(_formatMoney(entry))),
                  DataCell(
                    TextButton(
                      key: Key('history.detail.${entry.purchaseId.value}'),
                      onPressed: () => onOpen(entry.purchaseId),
                      child: Text(
                        activeDetailId?.value == entry.purchaseId.value
                            ? 'Open'
                            : 'View',
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCards extends StatelessWidget {
  const _HistoryCards({
    required this.entries,
    required this.selectedIds,
    required this.activeDetailId,
    required this.onToggle,
    required this.onOpen,
  });

  final List<PurchaseHistoryEntry> entries;
  final Set<PurchaseId> selectedIds;
  final PurchaseId? activeDetailId;
  final ValueChanged<PurchaseId> onToggle;
  final ValueChanged<PurchaseId> onOpen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final entry in entries) ...[
          MarkeiCard(
            key: Key('history.purchase.${entry.purchaseId.value}'),
            borderColor: activeDetailId?.value == entry.purchaseId.value
                ? MarkeiColors.green
                : null,
            child: InkWell(
              onTap: () => onOpen(entry.purchaseId),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          entry.storeName,
                          style: MarkeiText.sectionTitle,
                        ),
                      ),
                      Checkbox(
                        value: _containsPurchase(selectedIds, entry.purchaseId),
                        onChanged: (_) => onToggle(entry.purchaseId),
                      ),
                    ],
                  ),
                  const SizedBox(height: MarkeiSpacing.sm),
                  Wrap(
                    spacing: MarkeiSpacing.lg,
                    runSpacing: MarkeiSpacing.xs,
                    children: [
                      MarkeiFact(
                        label: 'Date / time',
                        value: _formatOccurrence(entry.occurrenceTime),
                      ),
                      MarkeiFact(
                        label: 'Items',
                        value: '${entry.itemCount} Purchase Item(s)',
                      ),
                      MarkeiFact(
                        label: 'Recorded total',
                        value: _formatMoney(entry),
                      ),
                    ],
                  ),
                  const SizedBox(height: MarkeiSpacing.sm),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                      key: Key('history.detail.${entry.purchaseId.value}'),
                      onPressed: () => onOpen(entry.purchaseId),
                      child: Text(
                        activeDetailId?.value == entry.purchaseId.value
                            ? 'Detail open'
                            : 'View detail',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (entry != entries.last) const SizedBox(height: MarkeiSpacing.sm),
        ],
      ],
    );
  }
}

class _PurchaseDetailView extends StatelessWidget {
  const _PurchaseDetailView({
    required this.accountId,
    required this.purchaseId,
    required this.history,
  });

  final AccountId accountId;
  final PurchaseId purchaseId;
  final PurchaseHistoryRepository history;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PurchaseDetail?>(
      future: history.getPurchaseDetail(accountId, purchaseId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Loading Purchase details...',
            key: Key('history.detail.loading'),
          );
        }
        if (snapshot.hasError) {
          return const Text(
            'Purchase details could not be loaded.',
            key: Key('history.detail.error'),
          );
        }
        final detail = snapshot.data;
        if (detail == null) {
          return const Text(
            'Purchase detail is not available.',
            key: Key('history.detail.empty'),
          );
        }
        return MarkeiSection(
          key: const Key('history.detail'),
          title: 'Purchase detail',
          subtitle: 'Purchase at ${detail.entry.storeName}',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MarkeiFact(
                label: 'Recorded total',
                value: _formatMoney(detail.entry),
              ),
              const SizedBox(height: MarkeiSpacing.sm),
              for (final item in detail.items) ...[
                MarkeiCard(
                  padding: const EdgeInsets.all(MarkeiSpacing.sm),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(item.productName),
                    subtitle: Text(
                      '${item.productCode} · ${item.packageCount == null ? 'BULK' : '${item.packageCount} package(s)'} · ${item.purchasedAmount} ${item.purchasedUnit}',
                    ),
                    trailing: Text(
                      '${item.currencyCode} ${(item.lineTotalMinorUnits / 100).toStringAsFixed(2)}',
                    ),
                  ),
                ),
                const SizedBox(height: MarkeiSpacing.sm),
              ],
              if (detail.items.isNotEmpty)
                _PriceChangeView(
                  accountId: accountId,
                  productId: detail.items.first.productId,
                  history: history,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _PriceChangeView extends StatelessWidget {
  const _PriceChangeView({
    required this.accountId,
    required this.productId,
    required this.history,
  });

  final AccountId accountId;
  final ProductId productId;
  final PurchaseHistoryRepository history;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PriceChangeResult>(
      future: history.priceChangeForProduct(accountId, productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Loading price comparison...',
            key: Key('history.price.loading'),
          );
        }
        if (snapshot.hasError) {
          return const Text(
            'Price change in your purchases could not be loaded.',
            key: Key('history.price.error'),
          );
        }
        final result = snapshot.data;
        return switch (result) {
          ComparablePriceChange() => Text(
            'Price change in your purchases: ${_formatBasisPoints(result.changeBasisPoints)} from ${result.previous.storeName} to ${result.latest.storeName}.',
            key: const Key('history.price.change'),
          ),
          PriceChangeUnavailable(:final reason) => Text(
            reason,
            key: const Key('history.price.unavailable'),
          ),
          null => const Text(
            'Not enough comparable purchases.',
            key: Key('history.price.unavailable'),
          ),
        };
      },
    );
  }
}

String _formatBasisPoints(int basisPoints) {
  final sign = basisPoints > 0 ? '+' : '';
  return '$sign${(basisPoints / 100).toStringAsFixed(2)}%';
}

bool _containsPurchase(Set<PurchaseId> ids, PurchaseId purchaseId) {
  return ids.any((id) => id.value == purchaseId.value);
}

String _formatMoney(PurchaseHistoryEntry entry) {
  return '${entry.currencyCode} ${(entry.totalMinorUnits / 100).toStringAsFixed(2)}';
}

String _formatOccurrence(DateTime value) {
  final local = value.toLocal();
  final date =
      '${local.day.toString().padLeft(2, '0')}/${local.month.toString().padLeft(2, '0')}/${local.year}';
  final time =
      '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
  return '$date $time';
}
