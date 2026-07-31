import 'package:flutter/material.dart';

import 'build_provenance.dart';
import 'design/markei_theme.dart';
import 'markei_composition.dart';
import 'navigation/markei_destination.dart';
import 'pages/home_page.dart';
import 'pages/history_page.dart';
import 'pages/lists_page.dart';
import 'pages/native_closure_page.dart';
import 'pages/products_page.dart';
import 'pages/purchase_page.dart';
import 'pages/settings_page.dart';
import 'widgets/markei_components.dart';
import 'widgets/markei_shell.dart';

class MarkeiApp extends StatefulWidget {
  const MarkeiApp({
    required this.composition,
    this.buildProvenance = BuildProvenance.unavailable,
    super.key,
  });

  final MarkeiComposition composition;
  final BuildProvenance buildProvenance;

  @override
  State<MarkeiApp> createState() => _MarkeiAppState();
}

class _MarkeiAppState extends State<MarkeiApp> {
  MarkeiDestinationId _selectedId = MarkeiDestinationId.home;
  int _refreshSignal = 0;

  List<MarkeiDestination> get _destinations => [
    const MarkeiDestination(
      id: MarkeiDestinationId.home,
      label: 'Home',
      icon: Icons.home_outlined,
      group: MarkeiDestinationGroup.primary,
    ),
    const MarkeiDestination(
      id: MarkeiDestinationId.lists,
      label: 'Lists',
      icon: Icons.checklist_outlined,
      group: MarkeiDestinationGroup.primary,
    ),
    const MarkeiDestination(
      id: MarkeiDestinationId.purchase,
      label: 'Purchase',
      icon: Icons.add_shopping_cart_outlined,
      group: MarkeiDestinationGroup.primary,
    ),
    const MarkeiDestination(
      id: MarkeiDestinationId.catalogue,
      icon: Icons.inventory_2_outlined,
      label: 'Catalogue',
      group: MarkeiDestinationGroup.secondary,
    ),
    const MarkeiDestination(
      id: MarkeiDestinationId.history,
      icon: Icons.history_outlined,
      label: 'History',
      group: MarkeiDestinationGroup.primary,
    ),
    const MarkeiDestination(
      id: MarkeiDestinationId.analytics,
      icon: Icons.analytics_outlined,
      label: 'Analytics',
      group: MarkeiDestinationGroup.secondary,
      description: 'Planned for C11-PH02.',
    ),
    const MarkeiDestination(
      id: MarkeiDestinationId.household,
      icon: Icons.groups_outlined,
      label: 'Household',
      group: MarkeiDestinationGroup.secondary,
      description: 'Planned household tools.',
    ),
    const MarkeiDestination(
      id: MarkeiDestinationId.guide,
      icon: Icons.help_outline,
      label: 'Guide',
      group: MarkeiDestinationGroup.secondary,
    ),
    const MarkeiDestination(
      id: MarkeiDestinationId.documentation,
      icon: Icons.description_outlined,
      label: 'Documentation',
      group: MarkeiDestinationGroup.secondary,
    ),
    const MarkeiDestination(
      id: MarkeiDestinationId.settings,
      icon: Icons.settings_outlined,
      label: 'Settings',
      group: MarkeiDestinationGroup.secondary,
    ),
    const MarkeiDestination(
      id: MarkeiDestinationId.audit,
      icon: Icons.fact_check_outlined,
      label: 'Audit',
      group: MarkeiDestinationGroup.secondary,
      description: 'Planned for C11-PH03.',
    ),
    if (widget.composition.nativeClosureSurfaceEnabled)
      const MarkeiDestination(
        id: MarkeiDestinationId.closure,
        icon: Icons.vpn_key_outlined,
        label: 'Closure',
        group: MarkeiDestinationGroup.secondary,
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markei',
      theme: markeiTheme(),
      home: MarkeiShell(
        destinations: _destinations,
        selectedId: _visibleSelectedId,
        onDestinationSelected: _selectDestination,
        content: IndexedStack(
          index: _selectedPageIndex,
          children: [
            for (final entry in _pages.entries)
              KeyedSubtree(
                key: ValueKey('markei.page.${entry.key.name}'),
                child: entry.value,
              ),
          ],
        ),
      ),
    );
  }

  Map<MarkeiDestinationId, Widget> get _pages => {
    MarkeiDestinationId.home: HomePage(onNavigate: _selectDestination),
    MarkeiDestinationId.lists: ListsPage(
      accountId: widget.composition.accountId,
      projections: widget.composition.productLists,
      refreshSignal: _refreshSignal,
    ),
    MarkeiDestinationId.purchase: PurchasePage(
      accountId: widget.composition.accountId,
      deviceId: widget.composition.deviceId,
      registration: widget.composition.purchaseRegistration,
      catalogueQueries: widget.composition.catalogueQueries,
      references: widget.composition.references,
      refreshSignal: _refreshSignal,
      onRegistered: () => setState(() => _refreshSignal++),
    ),
    MarkeiDestinationId.catalogue: ProductsPage(
      accountId: widget.composition.accountId,
      catalogueQueries: widget.composition.catalogueQueries,
      refreshSignal: _refreshSignal,
      onChanged: () => setState(() => _refreshSignal++),
    ),
    MarkeiDestinationId.history: HistoryPage(
      accountId: widget.composition.accountId,
      history: widget.composition.purchaseHistory,
      exports: widget.composition.purchaseExports,
      refreshSignal: _refreshSignal,
    ),
    MarkeiDestinationId.analytics: const _ReservedPage(
      key: Key('analytics.reserved'),
      title: 'Analytics',
      body:
          'Analytics is planned for C11-PH02. No calculations or telemetry are active here yet.',
      icon: Icons.analytics_outlined,
    ),
    MarkeiDestinationId.household: const _ReservedPage(
      key: Key('household.reserved'),
      title: 'Household',
      body: 'Household tools are planned and secondary during this phase.',
      icon: Icons.groups_outlined,
    ),
    MarkeiDestinationId.guide: const _StaticPage(
      title: 'Guide',
      body:
          'Register purchases locally, then use Catalogue, History and Lists to inspect Products and estimates.',
    ),
    MarkeiDestinationId.documentation: const _StaticPage(
      title: 'Documentation',
      body:
          'This beta uses local offline-first storage for purchase registration and review.',
    ),
    MarkeiDestinationId.settings: SettingsPage(
      accountId: widget.composition.accountId,
      references: widget.composition.references,
      preferences: widget.composition.preferences,
      onChanged: () => setState(() => _refreshSignal++),
    ),
    MarkeiDestinationId.audit: const _ReservedPage(
      key: Key('audit.reserved'),
      title: 'Audit',
      body:
          'Audit is planned for C11-PH03. It is not a diagnostic or Sync surface in this unit.',
      icon: Icons.fact_check_outlined,
    ),
    if (widget.composition.nativeClosureSurfaceEnabled)
      MarkeiDestinationId.closure: NativeClosurePage(
        runner: widget.composition.nativeClosureRunner,
        buildProvenance: widget.buildProvenance,
      ),
  };

  MarkeiDestinationId get _visibleSelectedId {
    if (_destinations.any((destination) => destination.id == _selectedId)) {
      return _selectedId;
    }
    return MarkeiDestinationId.home;
  }

  int get _selectedPageIndex {
    final ids = _pages.keys.toList(growable: false);
    final index = ids.indexOf(_visibleSelectedId);
    return index < 0 ? 0 : index;
  }

  void _selectDestination(MarkeiDestinationId id) {
    final destination = _destinations
        .where((item) => item.id == id)
        .firstOrNull;
    if (destination == null || !destination.enabled) {
      return;
    }
    setState(() => _selectedId = id);
  }
}

class _ReservedPage extends StatelessWidget {
  const _ReservedPage({
    required this.title,
    required this.body,
    required this.icon,
    super.key,
  });

  final String title;
  final String body;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        MarkeiPageHeader(title: title, purpose: body, icon: icon),
        const SizedBox(height: MarkeiSpacing.lg),
        MarkeiStatePanel(title: '$title reserved', message: body, icon: icon),
      ],
    );
  }
}

class _StaticPage extends StatelessWidget {
  const _StaticPage({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [MarkeiPageHeader(title: title, purpose: body)],
    );
  }
}
