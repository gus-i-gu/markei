import '../../application/content_sharing.dart';
import '../widgets/content_share_dialog.dart';
import '../../l10n/marc_localizations.dart';
import 'package:flutter/material.dart';

import '../../application/product_lists.dart';
import '../../application/list_notes.dart';
import '../../domain/shared/ids.dart';
import '../../domain/catalogue/product.dart';
import '../design/markei_theme.dart';
import '../widgets/markei_components.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({
    required this.accountId,
    required this.projections,
    required this.refreshSignal,
    this.deviceId,
    this.notes,
    this.contentSharing,
    super.key,
  });

  final AccountId accountId;
  final ProductListProjectionRepository projections;
  final int refreshSignal;
  final DeviceId? deviceId;
  final ListNotesRepository? notes;

  final ContentSharingPort? contentSharing;

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  ProductListView _view = ProductListView.shortage;
  ProductListSort _sort = ProductListSort.remaining;
  _ListTimeDisplay _timeDisplay = _ListTimeDisplay.expected;
  late final TextEditingController _searchController;
  late Future<ProductListProjection> _projectionFuture;
  int _seenRefreshSignal = 0;
  Map<String, List<ListNoteRevision>> _notes = {};
  String? _noteMessage;
  int _loadGeneration = 0;
  bool _sharing = false;

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
        widget.accountId != oldWidget.accountId ||
        widget.notes != oldWidget.notes) {
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
                  trailing: MarcText(
                    'Updated from purchase history',
                    style: MarkeiText.metadata,
                  ),
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
                      label: const MarcText('Retry Lists read'),
                    ),
                  )
                else ...[
                  if (_noteMessage != null)
                    MarcText(_noteMessage!, key: const Key("lists.noteStatus")),
                  _ProjectionView(
                    projection: snapshot.data!,
                    onShare: widget.contentSharing == null || _sharing
                        ? null
                        : _shareList,
                    notes: _notes,
                    onEditNote: widget.notes == null || widget.deviceId == null
                        ? null
                        : _editNote,
                    layoutClass: layoutClass,
                    searchController: _searchController,
                    searchText: _searchController.text,
                    sort: _sort,
                    timeDisplay: _timeDisplay,
                    onTimeDisplayChanged: (value) =>
                        setState(() => _timeDisplay = value),
                    onSearchChanged: (value) => setState(() {}),
                    onSortChanged: (value) => setState(() => _sort = value),
                  ),
                ],
              ],
            );
          },
        );
      },
    );
  }

  Future<ProductListProjection> _loadProjection() async {
    final generation = ++_loadGeneration;
    final accountId = widget.accountId;
    final view = _view;
    final projections = widget.projections;
    try {
      final notes = await widget.notes?.read(accountId) ?? {};
      if (generation == _loadGeneration) _notes = notes;
    } on Object {
      if (generation == _loadGeneration) {
        _notes = {};
        _noteMessage = 'Notes could not be read. Your purchases are unchanged.';
      }
    }
    return projections.productListProjection(
      accountId: accountId,
      view: view,
      today: DateTime.now(),
    );
  }

  Future<void> _editNote(ProductListProjectionItem item) async {
    final current = _notes[item.productId.value] ?? const <ListNoteRevision>[];
    final note = TextEditingController(
      text: current.map((r) => r.note).where((s) => s.isNotEmpty).join('\n\n'),
    );
    final tags = TextEditingController(
      text: current.expand((r) => r.tags).toSet().join(', '),
    );
    String? error;
    var saving = false;
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, update) => AlertDialog(
          title: Text(
            context.message('{p0} · Tags and note', [item.productName]),
          ),
          content: SizedBox(
            width: 440,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (current.length > 1)
                    const MarcText(
                      'Two devices edited this product independently. Both notes are shown. Save to combine them.',
                    ),
                  TextField(
                    key: const Key('lists.note.tags'),
                    controller: tags,
                    decoration: InputDecoration(
                      labelText: 'Tags',
                      helperText:
                          '@person, #payment, custom tags · separate with commas',
                      helperMaxLines: 2,
                    ).localized(context),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    key: const Key('lists.note.text'),
                    controller: note,
                    maxLines: 5,
                    maxLength: 2000,
                    decoration: InputDecoration(
                      labelText: 'Note',
                    ).localized(context),
                  ),
                  if (error != null) MarcText(error!),
                  const MarcText(
                    'Saved locally first. Use Sync now to share across this Account.',
                    style: MarkeiText.metadata,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: saving
                  ? null
                  : () => Navigator.pop(dialogContext, false),
              child: const MarcText('Cancel'),
            ),
            FilledButton(
              key: const Key('lists.note.save'),
              onPressed: saving
                  ? null
                  : () async {
                      update(() => saving = true);
                      try {
                        await widget.notes!.save(
                          accountId: widget.accountId,
                          deviceId: widget.deviceId!,
                          productId: item.productId,
                          note: note.text,
                          tags: normalizeListTags(tags.text.split(',')),
                          observedRevisionIds: current.map((r) => r.id).toSet(),
                        );
                        if (dialogContext.mounted) {
                          Navigator.pop(dialogContext, true);
                        }
                      } on Object catch (failure) {
                        if (dialogContext.mounted) {
                          update(() {
                            saving = false;
                            error = failure is FormatException
                                ? failure.message
                                : 'The note was not saved. Keep your text and try again.';
                          });
                        }
                      }
                    },
              child: MarcText(saving ? 'Saving…' : 'Save'),
            ),
          ],
        ),
      ),
    );
    // Wait for the dialog route to release its text fields before disposal.
    await Future<void>.delayed(const Duration(milliseconds: 250));
    note.dispose();
    tags.dispose();
    if (saved == true && mounted) {
      setState(() {
        _noteMessage = 'Note saved on this device. Use Sync now to share it.';
        _projectionFuture = _loadProjection();
      });
    }
  }

  Future<void> _shareList(List<ProductListProjectionItem> items) async {
    if (_sharing || items.isEmpty || widget.contentSharing == null) return;
    final messages = MarcLocalizations.of(context);
    final text = StringBuffer(
      'Marc · ${messages.display(_view.name == 'all' ? 'All Products' : _view.name[0].toUpperCase() + _view.name.substring(1))}\n',
    );
    for (final item in items) {
      text.writeln('\n${item.productName} · ${item.productBrand}');
      text.writeln(messages.display(_modeText(item)));
      text.writeln(
        '${messages.display(_timeDisplay.label)}: ${messages.display(_timeText(item, _timeDisplay))}',
      );
      if (item.latestCurrencyCode != null &&
          item.latestLineTotalMinorUnits != null) {
        text.writeln(
          '${messages.display('Last price')}: ${messages.numericCopy(
                '${item.latestCurrencyCode} ${(item.latestLineTotalMinorUnits! / 100).toStringAsFixed(2)}',
              )}',
        );
      }
    }
    text.writeln(
      '\n${messages.display('Estimates from purchase history; not a confirmed stock count.')}',
    );
    setState(() => _sharing = true);
    try {
      final approved = await confirmContentShare(
        context,
        description: messages.display(
          'Only shown products, prices and estimates are included. Private notes and tags are excluded.',
        ),
        preview: text.toString(),
      );
      if (!approved || !mounted) return;
      final result = await widget.contentSharing!.share(
        ContentShareRequest(
          title: messages.display('Marc List'),
          text: text.toString(),
        ),
      );
      if (mounted) setState(() => _noteMessage = contentShareMessage(result));
    } on Object {
      if (mounted) {
        setState(
          () => _noteMessage = contentShareMessage(ContentShareResult.failed),
        );
      }
    } finally {
      if (mounted) setState(() => _sharing = false);
    }
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
    this.onShare,
    required this.notes,
    required this.onEditNote,
    required this.layoutClass,
    required this.searchController,
    required this.searchText,
    required this.sort,
    required this.timeDisplay,
    required this.onTimeDisplayChanged,
    required this.onSearchChanged,
    required this.onSortChanged,
  });

  final ProductListProjection projection;
  final ValueChanged<List<ProductListProjectionItem>>? onShare;
  final Map<String, List<ListNoteRevision>> notes;
  final ValueChanged<ProductListProjectionItem>? onEditNote;
  final MarkeiLayoutClass layoutClass;
  final TextEditingController searchController;
  final String searchText;
  final ProductListSort sort;
  final _ListTimeDisplay timeDisplay;
  final ValueChanged<_ListTimeDisplay> onTimeDisplayChanged;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ProductListSort> onSortChanged;

  @override
  Widget build(BuildContext context) {
    final visibleItems = _visibleItems();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SummaryBand(projection: projection, layoutClass: layoutClass),
        const SizedBox(height: MarkeiSpacing.md),
        _Controls(
          controller: searchController,
          sort: sort,
          timeDisplay: timeDisplay,
          onTimeDisplayChanged: onTimeDisplayChanged,
          showTimePicker: layoutClass != MarkeiLayoutClass.wide,
          onSearchChanged: onSearchChanged,
          onSortChanged: onSortChanged,
        ),
        const SizedBox(height: MarkeiSpacing.md),
        OutlinedButton.icon(
          key: const Key('lists.share'),
          onPressed: visibleItems.isEmpty || onShare == null
              ? null
              : () => onShare!(List.unmodifiable(visibleItems)),
          icon: const Icon(Icons.share_outlined),
          label: const MarcText('Share shown List'),
        ),
        const SizedBox(height: MarkeiSpacing.md),
        MarcText(
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
              label: const MarcText('Clear search'),
            ),
          )
        else if (layoutClass == MarkeiLayoutClass.wide)
          _ListsTable(
            onTimeDisplayChanged: onTimeDisplayChanged,
            items: visibleItems,
            notes: notes,
            onEditNote: onEditNote,
            timeDisplay: timeDisplay,
            shortageThreshold: projection.shortageThresholdDays,
          )
        else
          _ListsCards(
            items: visibleItems,
            notes: notes,
            onEditNote: onEditNote,
            timeDisplay: timeDisplay,
            shortageThreshold: projection.shortageThresholdDays,
          ),
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
          item.productBrand.toLowerCase().contains(query) ||
          (notes[item.productId.value] ?? const []).any(
            (r) =>
                r.note.toLowerCase().contains(query) ||
                r.tags.any((t) => t.toLowerCase().contains(query)),
          );
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
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? _viewTone(selected).background
                : MarkeiColors.surface,
          ),
          foregroundColor: WidgetStateProperty.all(
            _viewTone(selected).foreground,
          ),
        ),
        segments: const [
          ButtonSegment(
            value: ProductListView.storage,
            label: MarcText(
              'Storage',
              key: Key('lists.view.storage'),
              style: TextStyle(color: MarkeiColors.green),
            ),
          ),
          ButtonSegment(
            value: ProductListView.shortage,
            label: MarcText(
              'Shortage',
              key: Key('lists.view.shortage'),
              style: TextStyle(color: MarkeiColors.warning),
            ),
          ),
          ButtonSegment(
            value: ProductListView.market,
            label: MarcText(
              'Market',
              key: Key('lists.view.market'),
              style: TextStyle(color: MarkeiColors.information),
            ),
          ),
          ButtonSegment(
            value: ProductListView.all,
            label: MarcText(
              'All',
              key: Key('lists.view.all'),
              style: TextStyle(color: MarkeiColors.lavender),
            ),
          ),
        ],
        selected: {selected},
        onSelectionChanged: (value) => onChanged(value.single),
      ),
    );
  }
}

class _SummaryBand extends StatelessWidget {
  const _SummaryBand({required this.projection, required this.layoutClass});

  final ProductListProjection projection;
  final MarkeiLayoutClass layoutClass;

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
    final tiles = [
      MarkeiSummaryTile(
        key: const Key('lists.summary.count'),
        icon: Icons.inventory_2_outlined,
        label: _viewLabel(projection.view),
        value: projection.items.length.toString(),
        detail: 'Returned Products',
        tone: _viewTone(projection.view),
      ),
      MarkeiSummaryTile(
        key: const Key('lists.summary.estimated'),
        icon: Icons.event_available_outlined,
        label: 'With estimates',
        value: available.toString(),
        detail: 'Derived cycle available',
        tone: MarkeiSummaryTone.secondary,
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
        tone: MarkeiSummaryTone.info,
      ),
    ];
    if (layoutClass == MarkeiLayoutClass.wide) {
      return MarkeiSummaryStrip(children: tiles);
    }
    return MarkeiResponsiveGrid(
      layoutClass: layoutClass,
      minTileWidth: 240,
      children: tiles,
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({
    required this.controller,
    required this.sort,
    required this.timeDisplay,
    required this.onTimeDisplayChanged,
    required this.showTimePicker,
    required this.onSearchChanged,
    required this.onSortChanged,
  });

  final TextEditingController controller;
  final ProductListSort sort;
  final _ListTimeDisplay timeDisplay;
  final ValueChanged<_ListTimeDisplay> onTimeDisplayChanged;
  final bool showTimePicker;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ProductListSort> onSortChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Wrap(
        spacing: MarkeiSpacing.sm,
        runSpacing: MarkeiSpacing.sm,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (showTimePicker)
            _ListTimePicker(
              value: timeDisplay,
              onChanged: onTimeDisplayChanged,
            ),
          SizedBox(
            width: constraints.maxWidth.clamp(0, 360),
            child: TextField(
              key: const Key('lists.search'),
              controller: controller,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search Products',
              ).localized(context),
            ),
          ),
          SizedBox(
            width: constraints.maxWidth.clamp(0, 260),
            child: DropdownButtonFormField<ProductListSort>(
              key: const Key('lists.sort'),
              initialValue: sort,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Sort by',
              ).localized(context),
              items: const [
                DropdownMenuItem(
                  value: ProductListSort.remaining,
                  child: MarcText('Remaining estimate'),
                ),
                DropdownMenuItem(
                  value: ProductListSort.name,
                  child: MarcText('Product name'),
                ),
                DropdownMenuItem(
                  value: ProductListSort.code,
                  child: MarcText('Product code'),
                ),
                DropdownMenuItem(
                  value: ProductListSort.latestPrice,
                  child: MarcText('Latest price'),
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
      ),
    );
  }
}

class _ListsTable extends StatelessWidget {
  final ValueChanged<_ListTimeDisplay> onTimeDisplayChanged;
  const _ListsTable({
    required this.items,
    required this.notes,
    required this.onEditNote,
    required this.shortageThreshold,
    required this.timeDisplay,
    required this.onTimeDisplayChanged,
  });

  final List<ProductListProjectionItem> items;
  final Map<String, List<ListNoteRevision>> notes;
  final ValueChanged<ProductListProjectionItem>? onEditNote;
  final int shortageThreshold;
  final _ListTimeDisplay timeDisplay;

  @override
  Widget build(BuildContext context) {
    return MarkeiCard(
      key: const Key('lists.table'),
      padding: const EdgeInsets.all(MarkeiSpacing.xs),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          dataRowMinHeight: 68,
          dataRowMaxHeight: 100,
          columns: [
            DataColumn(label: MarcText('Product code')),
            DataColumn(label: MarcText('Product / Brand')),
            DataColumn(label: MarcText('Latest price')),
            DataColumn(label: MarcText('Cycle')),
            DataColumn(
              label: _ListTimePicker(
                value: timeDisplay,
                onChanged: onTimeDisplayChanged,
              ),
            ),
            DataColumn(label: MarcText('Remaining')),
            DataColumn(label: MarcText('Status')),
            DataColumn(label: MarcText('Tags / note')),
          ],
          rows: [
            for (final item in items)
              DataRow(
                key: ValueKey('lists.row.${item.productId.value}'),
                cells: [
                  DataCell(Text(item.productCode)),
                  DataCell(
                    Text(
                      '${item.productName}\n${item.productBrand} · ${context.tr(_modeText(item))}',
                    ),
                  ),
                  DataCell(
                    MarcText(
                      _money(
                        item.latestCurrencyCode,
                        item.latestLineTotalMinorUnits,
                      ),
                    ),
                  ),
                  DataCell(MarcText(_cycleText(item))),
                  DataCell(MarcText(_timeText(item, timeDisplay))),
                  DataCell(MarcText(_remainingText(item))),
                  DataCell(
                    _StatusChip(
                      item: item,
                      shortageThreshold: shortageThreshold,
                    ),
                  ),
                  DataCell(
                    _ListNoteSummary(
                      item: item,
                      revisions: notes[item.productId.value] ?? const [],
                      onEdit: onEditNote,
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

class _ListsCards extends StatelessWidget {
  const _ListsCards({
    required this.items,
    required this.notes,
    required this.onEditNote,
    required this.shortageThreshold,
    required this.timeDisplay,
  });

  final List<ProductListProjectionItem> items;
  final Map<String, List<ListNoteRevision>> notes;
  final ValueChanged<ProductListProjectionItem>? onEditNote;
  final int shortageThreshold;
  final _ListTimeDisplay timeDisplay;

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
                          MarcText(_modeText(item), style: MarkeiText.metadata),
                        ],
                      ),
                    ),
                    const SizedBox(width: MarkeiSpacing.sm),
                    Flexible(
                      child: _StatusChip(
                        item: item,
                        shortageThreshold: shortageThreshold,
                      ),
                    ),
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
                      label: timeDisplay.label,
                      value: _timeText(item, timeDisplay),
                    ),
                    _Fact(label: 'Remaining', value: _remainingText(item)),
                  ],
                ),
                _ListNoteSummary(
                  item: item,
                  revisions: notes[item.productId.value] ?? const [],
                  onEdit: onEditNote,
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
          MarcText(label, style: MarkeiText.metadata),
          const SizedBox(height: MarkeiSpacing.xxs),
          MarcText(value, style: MarkeiText.label),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.item, required this.shortageThreshold});

  final ProductListProjectionItem item;
  final int shortageThreshold;

  @override
  Widget build(BuildContext context) {
    if (!item.cycle.isAvailable) {
      return const MarkeiStatusChip(label: 'Not enough history');
    }
    final remaining = item.cycle.remainingDays!;
    if (remaining < 0) {
      return const MarkeiStatusChip(
        label: 'Expected ended',
        tone: MarkeiSummaryTone.info,
      );
    }
    if (remaining == 0) {
      return const MarkeiStatusChip(
        label: 'Due today',
        tone: MarkeiSummaryTone.warning,
      );
    }
    return MarkeiStatusChip(
      label: 'Estimate: $remaining day(s)',
      tone: remaining <= shortageThreshold
          ? MarkeiSummaryTone.warning
          : MarkeiSummaryTone.primary,
    );
  }
}

enum ProductListSort { remaining, name, code, latestPrice }

MarkeiSummaryTone _viewTone(ProductListView view) => switch (view) {
  ProductListView.storage => MarkeiSummaryTone.primary,
  ProductListView.shortage => MarkeiSummaryTone.warning,
  ProductListView.market => MarkeiSummaryTone.info,
  ProductListView.all => MarkeiSummaryTone.secondary,
};

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

enum _ListTimeDisplay {
  expected('Expected next purchase'),
  elapsed('Days from last purchase');

  const _ListTimeDisplay(this.label);
  final String label;
}

class _ListTimePicker extends StatelessWidget {
  const _ListTimePicker({required this.value, required this.onChanged});
  final _ListTimeDisplay value;
  final ValueChanged<_ListTimeDisplay> onChanged;
  @override
  Widget build(BuildContext context) => DropdownButton<_ListTimeDisplay>(
    key: const Key('lists.timeDisplay'),
    value: value,
    style: MarkeiText.body.copyWith(color: MarkeiColors.ink),
    items: [
      for (final choice in _ListTimeDisplay.values)
        DropdownMenuItem(value: choice, child: MarcText(choice.label)),
    ],
    onChanged: (value) {
      if (value != null) onChanged(value);
    },
  );
}

String _modeText(ProductListProjectionItem item) => switch (item.productMode) {
  ProductMode.bulk => 'Bulk',
  ProductMode.packaged => 'Packaged / per unit',
  null => 'Mode unavailable',
};
String _timeText(ProductListProjectionItem item, _ListTimeDisplay display) {
  if (display == _ListTimeDisplay.expected) return _expectedText(item);
  final days = item.daysSinceLastPurchase;
  if (days == null) return 'No purchase history';
  if (days < 0) return 'Purchase dated ${-days} day(s) ahead';
  return days == 0 ? 'Today' : '$days day(s)';
}

class _ListNoteSummary extends StatelessWidget {
  const _ListNoteSummary({
    required this.item,
    required this.revisions,
    required this.onEdit,
  });
  final ProductListProjectionItem item;
  final List<ListNoteRevision> revisions;
  final ValueChanged<ProductListProjectionItem>? onEdit;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 250,
    child: Row(
      children: [
        Expanded(
          child: Text(
            [
              if (revisions.length > 1)
                context.tr('Concurrent edits · combine notes'),
              ...revisions.expand((r) => r.tags).toSet(),
              ...revisions.map((r) => r.note).where((n) => n.isNotEmpty),
            ].join(' · '),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: MarkeiText.metadata,
          ),
        ),
        if (onEdit != null)
          IconButton(
            key: Key('lists.note.edit.${item.productId.value}'),
            tooltip: context.tr('Edit tags and note'),
            icon: const Icon(Icons.edit_note),
            onPressed: () => onEdit!(item),
          ),
      ],
    ),
  );
}
