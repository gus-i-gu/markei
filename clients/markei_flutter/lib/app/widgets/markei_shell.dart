import '../../l10n/marc_localizations.dart';
import 'package:flutter/material.dart';

import '../design/markei_theme.dart';
import '../navigation/markei_destination.dart';
import 'markei_components.dart';
import 'marc_brand.dart';

class MarkeiShell extends StatelessWidget {
  const MarkeiShell({
    required this.destinations,
    required this.selectedId,
    required this.onDestinationSelected,
    required this.content,
    super.key,
  });

  final List<MarkeiDestination> destinations;
  final MarkeiDestinationId selectedId;
  final ValueChanged<MarkeiDestinationId> onDestinationSelected;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutClass = MarkeiLayoutClass.fromWidth(constraints.maxWidth);
        final contentCanvas = SafeArea(
          child: MarkeiContentCanvas(layoutClass: layoutClass, child: content),
        );

        if (layoutClass == MarkeiLayoutClass.compact) {
          return Scaffold(
            appBar: AppBar(
              leading: const MarcBrand(compact: true),
              title: MarcText(_selectedDestination.label),
              centerTitle: true,
              scrolledUnderElevation: 0,
            ),
            body: contentCanvas,
            bottomNavigationBar: Builder(
              builder: (barContext) => NavigationBar(
                key: const Key('markei.navigationBar'),
                selectedIndex: _compactSelectedIndex,
                onDestinationSelected: (index) =>
                    _selectCompactDestination(index, barContext),
                destinations: [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: context.tr('Home'),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.checklist_outlined),
                    selectedIcon: Icon(Icons.checklist),
                    label: context.tr('Lists'),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.add_shopping_cart_outlined),
                    selectedIcon: Icon(Icons.add_shopping_cart),
                    label: context.tr('Purchase'),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.history_outlined),
                    selectedIcon: Icon(Icons.history),
                    label: context.tr('History'),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.more_horiz),
                    label: context.tr('More'),
                  ),
                ],
              ),
            ),
          );
        }

        final rail = NavigationRail(
          key: const Key('markei.navigationRail'),
          leading: MarcBrand(compact: layoutClass != MarkeiLayoutClass.wide),
          selectedIndex: _selectedRailIndex,
          onDestinationSelected: (index) =>
              _selectDestination(destinations[index]),
          extended: layoutClass == MarkeiLayoutClass.wide,
          labelType: layoutClass == MarkeiLayoutClass.medium
              ? NavigationRailLabelType.none
              : null,
          minExtendedWidth: MarkeiSpacing.navRailExtendedWidth,
          scrollable: true,
          destinations: [
            for (final destination in destinations)
              NavigationRailDestination(
                icon: Tooltip(
                  message: context.tr(destination.label),
                  child: Icon(destination.icon),
                ),
                selectedIcon: Tooltip(
                  message: context.tr(destination.label),
                  child: Icon(destination.icon),
                ),
                label: MarcText(destination.label),
              ),
          ],
        );

        return Scaffold(
          body: Row(
            children: [
              rail,
              const VerticalDivider(width: 1),
              Expanded(child: contentCanvas),
            ],
          ),
        );
      },
    );
  }

  static const _compactIds = [
    MarkeiDestinationId.home,
    MarkeiDestinationId.lists,
    MarkeiDestinationId.purchase,
    MarkeiDestinationId.history,
  ];

  int get _compactSelectedIndex {
    final compactIndex = _compactIds.indexOf(selectedId);
    return compactIndex == -1 ? 4 : compactIndex;
  }

  int get _selectedRailIndex {
    final index = destinations.indexWhere((destination) {
      return destination.id == selectedId;
    });
    return index < 0 ? 0 : index;
  }

  MarkeiDestination get _selectedDestination {
    return destinations.firstWhere(
      (destination) => destination.id == selectedId,
      orElse: () => destinations.first,
    );
  }

  void _selectDestination(MarkeiDestination destination) {
    if (!destination.enabled) {
      return;
    }
    onDestinationSelected(destination.id);
  }

  void _selectCompactDestination(int index, BuildContext sheetContext) {
    if (index < _compactIds.length) {
      onDestinationSelected(_compactIds[index]);
      return;
    }
    final moreDestinations = destinations.where((destination) {
      return !_compactIds.contains(destination.id);
    });
    showModalBottomSheet<void>(
      context: sheetContext,
      builder: (context) => SafeArea(
        child: ListView(
          key: const Key('markei.moreDestinations'),
          shrinkWrap: true,
          children: [
            for (final destination in moreDestinations)
              ListTile(
                key: Key('markei.more.${destination.id.name}'),
                enabled: destination.enabled,
                leading: Icon(destination.icon),
                title: MarcText(destination.label),
                subtitle: destination.description == null
                    ? null
                    : MarcText(destination.description!),
                onTap: destination.enabled
                    ? () {
                        Navigator.of(context).pop();
                        onDestinationSelected(destination.id);
                      }
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
