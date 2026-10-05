import '../../l10n/marc_localizations.dart';
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
            MarkeiCard(
              key: const Key('home.brandHero'),
              color: MarkeiColors.brandDeepGreen,
              borderColor: MarkeiColors.brandDeepGreen,
              padding: EdgeInsets.all(
                layoutClass == MarkeiLayoutClass.compact ? 24 : 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MarcText(
                    'MARC / HOUSEHOLD GOVERNANCE',
                    style: TextStyle(
                      fontSize: 11,
                      letterSpacing: 1.6,
                      color: MarkeiColors.brandLime,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 24),
                  MarcText(
                    'Your household,\na little clearer.',
                    style: TextStyle(
                      fontSize: layoutClass == MarkeiLayoutClass.compact
                          ? 32
                          : 42,
                      height: 1.12,
                      letterSpacing: -1.2,
                      color: MarkeiColors.cream,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const MarcText(
                    'Register purchases. Find your rhythm.\nKeep everyday essentials in view.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: MarkeiColors.brandLime,
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    key: const Key('home.action.registerPurchase'),
                    style: FilledButton.styleFrom(
                      backgroundColor: MarkeiColors.brandLime,
                      foregroundColor: MarkeiColors.brandDeepGreen,
                    ),
                    onPressed: () => onNavigate(MarkeiDestinationId.purchase),
                    icon: const Icon(Icons.add_shopping_cart_outlined),
                    label: const MarcText('Register purchase'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: MarkeiSpacing.lg),
            const MarkeiStatePanel(
              key: Key('home.translationReview'),
              title: 'Translations under review',
              message:
                  'Portuguese and Spanish translations will receive human review for the first official app update.',
              icon: Icons.translate_outlined,
            ),
            const SizedBox(height: MarkeiSpacing.lg),
            MarkeiResponsiveGrid(
              layoutClass: layoutClass,
              minTileWidth: layoutClass == MarkeiLayoutClass.wide ? 520 : 300,
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
            MarkeiResponsiveGrid(
              layoutClass: layoutClass,
              minTileWidth: layoutClass == MarkeiLayoutClass.wide ? 520 : 300,
              children: [
                for (final card in homeFollowUpCards)
                  _HomeInformationCard(descriptor: card),
              ],
            ),
            const SizedBox(height: MarkeiSpacing.lg),
            const MarkeiStatePanel(
              key: Key('home.scanRoadmap'),
              title: 'NF / NF-e Scan · under study',
              message:
                  'Scanning Brazilian fiscal receipts and NF-e is under study. If technically viable, it may arrive in the first app updates. It is not available in this MVP.',
              icon: Icons.qr_code_scanner_outlined,
            ),
            const SizedBox(height: MarkeiSpacing.lg),
            const MarkeiStatePanel(
              key: Key('home.restoRoadmap'),
              title: 'Marc pour Resto · preview',
              message:
                  'A restaurant edition is planned for exploration over the coming months: advanced statistics and analytics, possible secure institutional messaging, and potential Receita Federal / CNPJ integration to simplify supply-chain declarations. Scope and availability remain subject to research and validation.',
              icon: Icons.restaurant_outlined,
            ),
            const SizedBox(height: MarkeiSpacing.lg),
            const MarkeiStatePanel(
              key: Key('home.localFirst'),
              title: 'Local-first workspace',
              message:
                  'Markei keeps purchase registration available on this device. Lists are estimates derived from registered Purchase history, and Catalogue keeps reusable Products and Stores.',
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

class _HomeInformationCard extends StatelessWidget {
  const _HomeInformationCard({required this.descriptor});

  final HomeCardDescriptor descriptor;

  @override
  Widget build(BuildContext context) {
    return MarkeiCard(
      color: MarkeiColors.lavenderTint,
      borderColor: MarkeiColors.lavender.withValues(alpha: 0.18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: MarkeiColors.lavender),
          const SizedBox(height: MarkeiSpacing.sm),
          MarcText(descriptor.title, style: MarkeiText.sectionTitle),
          const SizedBox(height: MarkeiSpacing.xs),
          MarcText(descriptor.body),
          if (descriptor.badge != null) ...[
            const SizedBox(height: MarkeiSpacing.sm),
            MarcText(descriptor.badge!, style: MarkeiText.metadata),
          ],
        ],
      ),
    );
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
    final tone = descriptor.destinationId == 'lists'
        ? MarkeiSummaryTone.primary
        : descriptor.destinationId == 'catalogue'
        ? MarkeiSummaryTone.info
        : MarkeiSummaryTone.secondary;
    return MarkeiCard(
      borderColor: tone.foreground.withValues(alpha: 0.22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: tone.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(destination.$1, color: tone.foreground),
          ),
          const SizedBox(height: MarkeiSpacing.sm),
          MarcText(descriptor.title, style: MarkeiText.sectionTitle),
          const SizedBox(height: MarkeiSpacing.xs),
          MarcText(descriptor.body),
          const SizedBox(height: MarkeiSpacing.sm),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(
              key: Key(destination.$2),
              onPressed: onTap,
              child: MarcText(destination.$3),
            ),
          ),
        ],
      ),
    );
  }
}
