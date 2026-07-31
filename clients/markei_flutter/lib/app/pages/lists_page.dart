import 'package:flutter/material.dart';

import '../../application/product_lists.dart';
import '../../domain/shared/ids.dart';
import '../design/markei_theme.dart';
import '../widgets/markei_components.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({
    required this.accountId,
    required this.projections,
    required this.refreshSignal,
    super.key,
  });

  final AccountId accountId;
  final ProductListProjectionRepository projections;
  final int refreshSignal;

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  ProductListView _view = ProductListView.shortage;
  ProductListSort _sort = ProductListSort.remaining;
  late final TextEditingController _searchController;
  late Future<ProductListProjection> _projectionFuture;
  int _seenRefreshSignal = 0;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _seenRefreshSignal = widget.refreshSignal;
    _projectionFuture = _loadProjection();
  }

  @override
  void didUpdateWidget(covariant ListsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refreshSignal != _seenRefreshSignal ||
        widget.projections != oldWidget.projections ||
        widget.accountId != oldWidget.accountId) {
      _seenRefreshSignal = widget.refreshSignal;
      _projectionFuture = _loadProjection();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductListProjection>(
      key: ValueKey('lists.future.${_view.name}.$_seenRefreshSignal'),
      future: _projectionFuture,
      builder: (context, snapshot) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final layoutClass = MarkeiLayoutClass.fromWidth(
              constraints.maxWidth,
            );
            return ListView(
              key: const Key('lists.page'),
              children: [
                const MarkeiPageHeader(
                  title: 'Lists',
                  purpose:
                      'Estimate Storage, Shortage, Market and All Products from registered Purchase history.',
                  icon: Icons.checklist_outlined,
                ),
                const SizedBox(height: MarkeiSpacing.md),
                _ViewSelector(
                  selected: _view,
                  onChanged: (view) {
                    setState(() {
                      _view = view;
                      _projectionFuture = _loadProjection();
                    });
                  },
                ),
                const SizedBox(height: MarkeiSpacing.md),
                if (snapshot.connectionState == ConnectionState.waiting)
                  const MarkeiStatePanel(
                    key: Key('lists.loading'),
                    title: 'Loading Lists',
                    message: 'Loading estimated Product lists.',
                    icon: Icons.hourglass_empty,
                  )
                else if (snapshot.hasError)
                  MarkeiStatePanel(
                    key: const Key('lists.error'),
                    title: 'Lists read failed',
                    message:
                        'Lists estimates could not be loaded. Local data was not changed.',
                    icon: Icons.error_outline,
                    action: OutlinedButton.icon(
                      key: const Key('lists.retry'),
                      onPressed: _retryListsRead,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry Lists read'),
                    ),
                  )
                else
                  _ProjectionView(
                    projection: snapshot.data!,
                    layoutClass: layoutClass,
                    searchController: _searchController,
                    searchText: _searchController.text,
                    sort: _sort,
                    onSearchChanged: (value) => setState(() {}),
                    onSortChanged: (value) => setState(() => _sort = value),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Future<ProductListProjection> _loadProjection() {
    return widget.projections.productListProjection(
      accountId: widget.accountId,
      view: _view,
      today: DateTime.now(),
    );
  }

  void _retryListsRead() {
    setState(() {
      _projectionFuture = _loadProjection();
    });
  }
}

class _ProjectionView extends StatelessWidget {
  const _ProjectionView({
    required this.projection,
    required this.layoutClass,
    required this.searchController,
    required this.searchText,
    required this.sort,
    required this.onSearchChanged,
    required this.onSortChanged,
  });

  final ProductListProjection projection;
  final MarkeiLayoutClass layoutClass;
  final TextEditingController searchController;
  final String searchText;
  final ProductListSort sort;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ProductListSort> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final visibleItems = _visibleItems();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SummaryBand(projection: projection),
        const SizedBox(height: MarkeiSpacing.md),
        _Controls(
          controller: searchController,
          sort: sort,
          onSearchChanged: onSearchChanged,
          onSortChanged: onSortChanged,
        ),
        const SizedBox(height: MarkeiSpacing.md),
        Text(
          'Estimates use registered Purchase history. Shortage threshold: '
          '${projection.shortageThresholdDays} day(s).',
          style: MarkeiText.metadata,
        ),
        const SizedBox(height: MarkeiSpacing.md),
        if (projection.items.isEmpty)
          const MarkeiStatePanel(
            key: Key('lists.empty.firstUse'),
            title: 'No Products in this List',
            message:
                'No returned Product currently belongs to this view. Register Purchases to build estimate history.',
            icon: Icons.inventory_2_outlined,
          )
        else if (visibleItems.isEmpty)
          MarkeiStatePanel(
            key: const Key('lists.filteredEmpty'),
            title: 'No search results',
            message: 'The current search produced no Product result.',
            icon: Icons.search_off,
            action: OutlinedButton.icon(
              key: const Key('lists.clearSearch'),
              onPressed: () {
                searchController.clear();
                onSearchChanged('');
              },
              icon: const Icon(Icons.close),
              label: const Text('Clear search'),
            ),
          )
        else if (layoutClass == MarkeiLayoutClass.wide)
          _ListsTable(items: visibleItems)
        else
          _ListsCards(items: visibleItems),
      ],
    );
  }

  List<ProductListProjectionItem> _visibleItems() {
    final query = searchText.trim().toLowerCase();
    final filtered = projection.items.where((item) {
      if (query.isEmpty) {
        return true;
      }
      return item.productCode.toLowerCase().contains(query) ||
          item.productName.toLowerCase().contains(query) ||
          item.productBrand.toLowerCase().contains(query);
    }).toList();
    filtered.sort(_compareItems);
    return filtered;
  }

  int _compareItems(
    ProductListProjectionItem left,
    ProductListProjectionItem right,
  ) {
    final primary = switch (sort) {
      ProductListSort.remaining => _compareNullableInt(
        left.cycle.remainingDays,
        right.cycle.remainingDays,
      ),
      ProductListSort.name => left.productName.toLowerCase().compareTo(
        right.productName.toLowerCase(),
      ),
      ProductListSort.code => left.productCode.toLowerCase().compareTo(
        right.productCode.toLowerCase(),
      ),
      ProductListSort.latestPrice => _compareNullableInt(
        left.latestLineTotalMinorUnits,
        right.latestLineTotalMinorUnits,
      ),
    };
    if (primary != 0) {
      return primary;
    }
    final code = left.productCode.toLowerCase().compareTo(
      right.productCode.toLowerCase(),
    );
    if (code != 0) {
      return code;
    }
    return left.productId.value.compareTo(right.productId.value);
  }

  int _compareNullableInt(int? left, int? right) {
    return switch ((left, right)) {
      (null, null) => 0,
      (null, _) => 1,
      (_, null) => -1,
      (final int leftValue, final int rightValue) => leftValue.compareTo(
        rightValue,
      ),
    };
  }
}

class _ViewSelector extends StatelessWidget {
  const _ViewSelector({required this.selected, required this.onChanged});

  final ProductListView selected;
  final ValueChanged<ProductListView> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SegmentedButton<ProductListView>(
        key: const Key('lists.viewSelector'),
        segments: const [
          ButtonSegment(
            value: ProductListView.storage,
            label: Text('Storage', key: Key('lists.view.storage')),
          ),
          ButtonSegment(
            value: ProductListView.shortage,
            label: Text('Shortage', key: Key('lists.view.shortage')),
          ),
          ButtonSegment(
            value: ProductListView.market,
            label: Text('Market', key: Key('lists.view.market')),
          ),
          ButtonSegment(
            value: ProductListView.all,
            label: Text('All', key: Key('lists.view.all')),
          ),
        ],
        selected: {selected},
        onSelectionChanged: (value) => onChanged(value.single),
      ),
    );
  }
}

class _SummaryBand extends StatelessWidget {
  const _SummaryBand({required this.projection});

  final ProductListProjection projection;

  @override
  Widget build(BuildContext context) {
    final available = projection.items.where((item) {
      return item.cycle.isAvailable;
    }).length;
    final unavailable = projection.items.length - available;
    final total = projection.approximateTotalMinorUnits == null
        ? 'Unavailable'
        : _money(
            projection.approximateTotalCurrencyCode,
            projection.approximateTotalMinorUnits,
          );
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutClass = MarkeiLayoutClass.fromWidth(constraints.maxWidth);
        return MarkeiResponsiveGrid(
          layoutClass: layoutClass,
          minTileWidth: 220,
          children: [
            MarkeiSummaryTile(
              key: const Key('lists.summary.count'),
              icon: Icons.inventory_2_outlined,
              label: 'Returned Products',
              value: projection.items.length.toString(),
              detail: _viewLabel(projection.view),
            ),
            MarkeiSummaryTile(
              key: const Key('lists.summary.estimated'),
              icon: Icons.event_available_outlined,
              label: 'With estimates',
              value: available.toString(),
              detail: 'Derived cycle available',
              tone: MarkeiSummaryTone.info,
            ),
            MarkeiSummaryTile(
              key: const Key('lists.summary.insufficient'),
              icon: Icons.info_outline,
              label: 'Not enough history',
              value: unavailable.toString(),
              detail: 'Product remains visible',
              tone: MarkeiSummaryTone.secondary,
            ),
            MarkeiSummaryTile(
              key: const Key('lists.approxTotal'),
              icon: Icons.payments_outlined,
              label: 'Approximate next purchase',
              value: total,
              detail: 'Estimate, not a recorded total',
              tone: MarkeiSummaryTone.warning,
            ),
          ],
        );
      },
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({
    required this.controller,
    required this.sort,
    required this.onSearchChanged,
    required this.onSortChanged,
  });

  final TextEditingController controller;
  final ProductListSort sort;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ProductListSort> onSortChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: MarkeiSpacing.sm,
      runSpacing: MarkeiSpacing.sm,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(
          width: 360,
          child: TextField(
            key: const Key('lists.search'),
            controller: controller,
            onChanged: onSearchChanged,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'Search Products',
            ),
          ),
        ),
        SizedBox(
          width: 260,
          child: DropdownButtonFormField<ProductListSort>(
            key: const Key('lists.sort'),
            initialValue: sort,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Sort by'),
            items: const [
              DropdownMenuItem(
                value: ProductListSort.remaining,
                child: Text('Remaining estimate'),
              ),
              DropdownMenuItem(
                value: ProductListSort.name,
                child: Text('Product name'),
              ),
              DropdownMenuItem(
                value: ProductListSort.code,
                child: Text('Product code'),
              ),
              DropdownMenuItem(
                value: ProductListSort.latestPrice,
                child: Text('Latest price'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                onSortChanged(value);
              }
            },
          ),
        ),
      ],
    );
  }
}

class _ListsTable extends StatelessWidget {
  const _ListsTable({required this.items});

  final List<ProductListProjectionItem> items;

  @override
  Widget build(BuildContext context) {
    return MarkeiCard(
      key: const Key('lists.table'),
      padding: const EdgeInsets.all(MarkeiSpacing.xs),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Product code')),
            DataColumn(label: Text('Product / Brand')),
            DataColumn(label: Text('Latest price')),
            DataColumn(label: Text('Cycle')),
            DataColumn(label: Text('Expected next purchase')),
            DataColumn(label: Text('Remaining')),
            DataColumn(label: Text('Status')),
          ],
          rows: [
            for (final item in items)
              DataRow(
                key: ValueKey('lists.row.${item.productId.value}'),
                cells: [
                  DataCell(Text(item.productCode)),
                  DataCell(Text('${item.productName}\n${item.productBrand}')),
                  DataCell(
                    Text(
                      _money(
                        item.latestCurrencyCode,
                        item.latestLineTotalMinorUnits,
                      ),
                    ),
                  ),
                  DataCell(Text(_cycleText(item))),
                  DataCell(Text(_expectedText(item))),
                  DataCell(Text(_remainingText(item))),
                  DataCell(_StatusChip(item: item)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ListsCards extends StatelessWidget {
  const _ListsCards({required this.items});

  final List<ProductListProjectionItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('lists.cards'),
      children: [
        for (final item in items) ...[
          MarkeiCard(
            key: Key('lists.product.${item.productId.value}'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName,
                            style: MarkeiText.sectionTitle,
                          ),
                          const SizedBox(height: MarkeiSpacing.xxs),
                          Text('${item.productCode} · ${item.productBrand}'),
                        ],
                      ),
                    ),
                    const SizedBox(width: MarkeiSpacing.sm),
                    _StatusChip(item: item),
                  ],
                ),
                const SizedBox(height: MarkeiSpacing.sm),
                Wrap(
                  spacing: MarkeiSpacing.lg,
                  runSpacing: MarkeiSpacing.xs,
                  children: [
                    _Fact(
                      label: 'Latest price',
                      value: _money(
                        item.latestCurrencyCode,
                        item.latestLineTotalMinorUnits,
                      ),
                    ),
                    _Fact(label: 'Cycle', value: _cycleText(item)),
                    _Fact(
                      label: 'Expected next purchase',
                      value: _expectedText(item),
                    ),
                    _Fact(label: 'Remaining', value: _remainingText(item)),
                  ],
                ),
                if (!item.cycle.isAvailable) ...[
                  const SizedBox(height: MarkeiSpacing.sm),
                  MarkeiStatePanel(
                    key: Key(
                      'lists.insufficientHistory.${item.productId.value}',
                    ),
                    message:
                        'Not enough history for this Product estimate yet.',
                    icon: Icons.info_outline,
                  ),
                ],
              ],
            ),
          ),
          if (item != items.last) const SizedBox(height: MarkeiSpacing.sm),
        ],
      ],
    );
  }
}

class _Fact extends StatelessWidget {
  const _Fact({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: MarkeiText.metadata),
          const SizedBox(height: MarkeiSpacing.xxs),
          Text(value, style: MarkeiText.label),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.item});

  final ProductListProjectionItem item;

  @override
  Widget build(BuildContext context) {
    if (!item.cycle.isAvailable) {
      return const MarkeiStatusChip(label: 'Not enough history');
    }
    final remaining = item.cycle.remainingDays!;
    if (remaining < 0) {
      return const MarkeiStatusChip(label: 'Expected ended');
    }
    if (remaining == 0) {
      return const MarkeiStatusChip(label: 'Due today');
    }
    return MarkeiStatusChip(label: 'Estimate: $remaining day(s)');
  }
}

enum ProductListSort { remaining, name, code, latestPrice }

String _viewLabel(ProductListView view) {
  return switch (view) {
    ProductListView.storage => 'Storage projection',
    ProductListView.shortage => 'Shortage projection',
    ProductListView.market => 'Market projection',
    ProductListView.all => 'All Products projection',
  };
}

String _cycleText(ProductListProjectionItem item) {
  final cycle = item.cycle;
  if (!cycle.isAvailable) {
    return 'Not enough history';
  }
  return 'Estimate: ${cycle.averageIntervalDays} day(s)';
}

String _expectedText(ProductListProjectionItem item) {
  final expected = item.cycle.expectedNextPurchaseDate;
  if (expected == null) {
    return 'Unavailable';
  }
  return '${_date(expected)} estimated';
}

String _remainingText(ProductListProjectionItem item) {
  final remaining = item.cycle.remainingDays;
  if (remaining == null) {
    return 'Unknown';
  }
  if (remaining < 0) {
    return '${remaining.abs()} day(s) overdue';
  }
  if (remaining == 0) {
    return 'Today';
  }
  return '$remaining day(s)';
}

String _money(String? currencyCode, int? minorUnits) {
  if (currencyCode == null || minorUnits == null) {
    return 'Unavailable';
  }
  return '$currencyCode ${(minorUnits / 100).toStringAsFixed(2)}';
}

String _date(DateTime date) {
  final local = date.toLocal();
  final day = local.day.toString().padLeft(2, '0');
  final month = local.month.toString().padLeft(2, '0');
  return '$day/$month/${local.year}';
}
