import 'package:flutter/material.dart';

import '../design/markei_theme.dart';
import '../widgets/markei_components.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final _scrollController = ScrollController();
  final _sectionKeys = [
    for (var index = 0; index < _guideSections.length; index++) GlobalKey(),
  ];
  final _focusNodes = [
    for (var index = 0; index < _guideSections.length; index++) FocusNode(),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const Key('guide.page'),
      controller: _scrollController,
      padding: const EdgeInsets.all(MarkeiSpacing.md),
      children: [
        const MarkeiPageHeader(
          title: 'Guide',
          purpose:
              'Local help for registering purchases, reviewing evidence and exporting files from this device.',
          icon: Icons.help_outline,
        ),
        const SizedBox(height: MarkeiSpacing.md),
        MarkeiSection(
          title: 'Contents',
          subtitle: 'Jump to a local Guide section.',
          child: Wrap(
            spacing: MarkeiSpacing.sm,
            runSpacing: MarkeiSpacing.xs,
            children: [
              for (var index = 0; index < _guideSections.length; index++)
                OutlinedButton(
                  key: Key('guide.anchor.${index + 1}'),
                  onPressed: () => _focusSection(index),
                  child: Text(_guideSections[index].title),
                ),
            ],
          ),
        ),
        const SizedBox(height: MarkeiSpacing.md),
        for (var index = 0; index < _guideSections.length; index++) ...[
          _GuideSectionView(
            key: _sectionKeys[index],
            section: _guideSections[index],
            focusNode: _focusNodes[index],
            index: index + 1,
          ),
          if (index != _guideSections.length - 1)
            const SizedBox(height: MarkeiSpacing.md),
        ],
      ],
    );
  }

  void _focusSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 160),
      );
    }
    _focusNodes[index].requestFocus();
  }
}

class _GuideSectionView extends StatelessWidget {
  const _GuideSectionView({
    required this.section,
    required this.focusNode,
    required this.index,
    super.key,
  });

  final _GuideSection section;
  final FocusNode focusNode;
  final int index;

  @override
  Widget build(BuildContext context) {
    return MarkeiSection(
      title: section.title,
      subtitle: section.subtitle,
      child: Focus(
        focusNode: focusNode,
        child: Semantics(
          header: true,
          label: 'Guide section $index, ${section.title}',
          child: Text(section.body, key: Key('guide.section.$index')),
        ),
      ),
    );
  }
}

final class _GuideSection {
  const _GuideSection({
    required this.title,
    required this.subtitle,
    required this.body,
  });

  final String title;
  final String subtitle;
  final String body;
}

const _guideSections = [
  _GuideSection(
    title: 'Home',
    subtitle: 'Local status and follow-up cards.',
    body:
        'Home summarizes local-first purchase work and shows static News and Updates follow-up cards. Opening Home does not read or write data.',
  ),
  _GuideSection(
    title: 'Purchase',
    subtitle: 'Register a local Purchase draft.',
    body:
        'Choose Store and time first, add optional Person and Payment Method details when useful, then stage Items and register the Purchase locally.',
  ),
  _GuideSection(
    title: 'Catalogue',
    subtitle: 'Reusable Product and Store facts.',
    body:
        'Catalogue keeps reusable Product facts and Stores. Product details can be opened without selecting rows for bulk action.',
  ),
  _GuideSection(
    title: 'History',
    subtitle: 'Review, select and export registered Purchases.',
    body:
        'History selection is for actions only. Opening detail is separate. Select all shown means the currently filtered loaded recent-History window.',
  ),
  _GuideSection(
    title: 'Analytics',
    subtitle: 'Use selected History Purchases as scope.',
    body:
        'Use in Analytics prepares a local scope from selected Purchases. It does not calculate, save an analysis record or mutate a Purchase.',
  ),
  _GuideSection(
    title: 'Exports',
    subtitle: 'Write explicit local files.',
    body:
        'Export creates a file only after an explicit action. Windows writes to Downloads. Android public Downloads export is unavailable in this build.',
  ),
  _GuideSection(
    title: 'Audit',
    subtitle: 'Read-only local activity projection.',
    body:
        'Audit shows bounded local activity for this Account and environment. It does not contact the network or repair data.',
  ),
  _GuideSection(
    title: 'Settings',
    subtitle: 'Account, references, Sync and Device.',
    body:
        'Settings starts with Account state, then Purchase references and shortage timeframe, then Sync and Device status, followed by visible Advanced actions.',
  ),
];
