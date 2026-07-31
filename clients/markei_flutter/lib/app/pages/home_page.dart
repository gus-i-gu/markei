import 'package:flutter/material.dart';

import '../../application/home_content.dart';
import '../design/markei_theme.dart';
import '../navigation/markei_destination.dart';
import '../widgets/markei_components.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.onNavigate, super.key});

  final ValueChanged<MarkeiDestinationId> onNavigate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutClass = MarkeiLayoutClass.fromWidth(constraints.maxWidth);
        return ListView(
          key: const Key('home.page'),
          children: [
            const MarkeiPageHeader(
              title: 'Home',
              purpose:
                  'Register purchases locally first and inspect reusable Products, estimates and history.',
              icon: Icons.home_outlined,
            ),
            const SizedBox(height: MarkeiSpacing.lg),
            FilledButton.icon(
              key: const Key('home.action.registerPurchase'),
              onPressed: () => onNavigate(MarkeiDestinationId.purchase),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Register purchase'),
            ),
            const SizedBox(height: MarkeiSpacing.lg),
            MarkeiResponsiveGrid(
              layoutClass: layoutClass,
              minTileWidth: 300,
              children: [
                for (final card in homeCards.where((card) {
                  return card.destinationId != 'purchase';
                }))
                  _HomeTaskCard(
                    descriptor: card,
                    onTap: () => onNavigate(_destinationFor(card)),
                  ),
              ],
            ),
            const SizedBox(height: MarkeiSpacing.lg),
            const MarkeiStatePanel(
              key: Key('home.localFirst'),
              title: 'Local-first workspace',
              message:
                  'Markei keeps normal purchase registration available on this device. Lists are estimates derived from registered Purchase history.',
              icon: Icons.verified_outlined,
            ),
          ],
        );
      },
    );
  }

  MarkeiDestinationId _destinationFor(HomeCardDescriptor card) {
    return switch (card.destinationId) {
      'lists' => MarkeiDestinationId.lists,
      'catalogue' => MarkeiDestinationId.catalogue,
      'history' => MarkeiDestinationId.history,
      _ => MarkeiDestinationId.purchase,
    };
  }
}

class _HomeTaskCard extends StatelessWidget {
  const _HomeTaskCard({required this.descriptor, required this.onTap});

  final HomeCardDescriptor descriptor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final destination = switch (descriptor.destinationId) {
      'lists' => (Icons.checklist, 'home.action.viewLists', 'View lists'),
      'catalogue' => (
        Icons.inventory_2_outlined,
        'home.action.browseCatalogue',
        'Browse catalogue',
      ),
      'history' => (
        Icons.history_outlined,
        'home.action.openHistory',
        'Open purchase history',
      ),
      _ => (
        Icons.add_shopping_cart_outlined,
        'home.action.registerPurchase.secondary',
        'Register purchase',
      ),
    };
    return MarkeiCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(destination.$1, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: MarkeiSpacing.sm),
          Text(descriptor.title, style: MarkeiText.sectionTitle),
          const SizedBox(height: MarkeiSpacing.xs),
          Text(descriptor.body),
          const SizedBox(height: MarkeiSpacing.sm),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(
              key: Key(destination.$2),
              onPressed: onTap,
              child: Text(destination.$3),
            ),
          ),
        ],
      ),
    );
  }
}
