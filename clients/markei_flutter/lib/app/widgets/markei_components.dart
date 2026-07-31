import 'package:flutter/material.dart';

import '../design/markei_theme.dart';

class MarkeiCard extends StatelessWidget {
  const MarkeiCard({
    required this.child,
    super.key,
    this.padding,
    this.color,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MarkeiRadius.md),
        side: BorderSide(color: borderColor ?? MarkeiColors.outline),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(MarkeiSpacing.md),
        child: child,
      ),
    );
  }
}

class MarkeiSection extends StatelessWidget {
  const MarkeiSection({
    required this.title,
    required this.child,
    super.key,
    this.subtitle,
    this.trailing,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return MarkeiCard(
      padding: padding ?? const EdgeInsets.all(MarkeiSpacing.md),
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
                    Text(title, style: MarkeiText.sectionTitle),
                    if (subtitle != null) ...[
                      const SizedBox(height: MarkeiSpacing.xxs),
                      Text(subtitle!, style: MarkeiText.metadata),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: MarkeiSpacing.sm),
                trailing!,
              ],
            ],
          ),
          const SizedBox(height: MarkeiSpacing.md),
          child,
        ],
      ),
    );
  }
}

class MarkeiControlBand extends StatelessWidget {
  const MarkeiControlBand({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: MarkeiSpacing.sm,
      runSpacing: MarkeiSpacing.sm,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: children,
    );
  }
}

class MarkeiActionBand extends StatelessWidget {
  const MarkeiActionBand({required this.children, super.key, this.leading});

  final Widget? leading;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return MarkeiCard(
      color: MarkeiColors.secondarySurface,
      child: Wrap(
        spacing: MarkeiSpacing.sm,
        runSpacing: MarkeiSpacing.sm,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [?leading, ...children],
      ),
    );
  }
}

class MarkeiFact extends StatelessWidget {
  const MarkeiFact({required this.label, required this.value, super.key});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 112),
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

class MarkeiSummaryStrip extends StatelessWidget {
  const MarkeiSummaryStrip({required this.children, super.key});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return MarkeiCard(
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var index = 0; index < children.length; index++) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(MarkeiSpacing.md),
                  child: children[index],
                ),
              ),
              if (index != children.length - 1) const VerticalDivider(width: 1),
            ],
          ],
        ),
      ),
    );
  }
}

class MarkeiContentCanvas extends StatelessWidget {
  const MarkeiContentCanvas({
    required this.layoutClass,
    required this.child,
    super.key,
  });

  final MarkeiLayoutClass layoutClass;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final gutter = switch (layoutClass) {
      MarkeiLayoutClass.compact => MarkeiSpacing.compactGutter,
      MarkeiLayoutClass.medium => MarkeiSpacing.mediumGutter,
      MarkeiLayoutClass.wide => MarkeiSpacing.wideGutter,
    };
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: MarkeiSpacing.maxContentWidth,
        ),
        child: Padding(padding: EdgeInsets.all(gutter), child: child),
      ),
    );
  }
}

class MarkeiPageHeader extends StatelessWidget {
  const MarkeiPageHeader({
    required this.title,
    required this.purpose,
    super.key,
    this.icon,
    this.trailing,
  });

  final String title;
  final String purpose;
  final IconData? icon;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final inlineTrailing = trailing != null && constraints.maxWidth >= 520;
        final titleBlock = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: MarkeiText.pageTitle),
            const SizedBox(height: MarkeiSpacing.xs),
            Text(purpose, style: theme.textTheme.bodyMedium),
            if (trailing != null && !inlineTrailing) ...[
              const SizedBox(height: MarkeiSpacing.xs),
              trailing!,
            ],
          ],
        );
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) ...[
              Icon(icon, color: theme.colorScheme.primary, size: 30),
              const SizedBox(width: MarkeiSpacing.sm),
            ],
            Expanded(child: titleBlock),
            if (inlineTrailing) ...[
              const SizedBox(width: MarkeiSpacing.sm),
              trailing!,
            ],
          ],
        );
      },
    );
  }
}

class MarkeiSummaryTile extends StatelessWidget {
  const MarkeiSummaryTile({
    required this.label,
    required this.value,
    super.key,
    this.icon,
    this.detail,
    this.tone = MarkeiSummaryTone.primary,
  });

  final String label;
  final String value;
  final IconData? icon;
  final String? detail;
  final MarkeiSummaryTone tone;

  @override
  Widget build(BuildContext context) {
    final color = switch (tone) {
      MarkeiSummaryTone.primary => MarkeiColors.green,
      MarkeiSummaryTone.secondary => MarkeiColors.lavender,
      MarkeiSummaryTone.warning => MarkeiColors.warning,
      MarkeiSummaryTone.info => MarkeiColors.information,
    };
    return MarkeiCard(
      borderColor: color.withValues(alpha: 0.35),
      child: Row(
        children: [
          if (icon != null) ...[
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.12),
              foregroundColor: color,
              child: Icon(icon),
            ),
            const SizedBox(width: MarkeiSpacing.sm),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: MarkeiText.label),
                const SizedBox(height: MarkeiSpacing.xxs),
                Text(value, style: MarkeiText.numeric),
                if (detail != null) ...[
                  const SizedBox(height: MarkeiSpacing.xxs),
                  Text(detail!, style: MarkeiText.metadata),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum MarkeiSummaryTone { primary, secondary, warning, info }

class MarkeiStatePanel extends StatelessWidget {
  const MarkeiStatePanel({
    required this.message,
    super.key,
    this.icon = Icons.info_outline,
    this.title,
    this.action,
  });

  final String message;
  final IconData icon;
  final String? title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MarkeiCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: theme.colorScheme.secondary),
              const SizedBox(width: MarkeiSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) ...[
                      Text(title!, style: MarkeiText.sectionTitle),
                      const SizedBox(height: MarkeiSpacing.xs),
                    ],
                    Text(message),
                  ],
                ),
              ),
            ],
          ),
          if (action != null) ...[
            const SizedBox(height: MarkeiSpacing.md),
            action!,
          ],
        ],
      ),
    );
  }
}

class MarkeiStatusChip extends StatelessWidget {
  const MarkeiStatusChip({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      side: BorderSide(color: Theme.of(context).colorScheme.secondary),
      visualDensity: VisualDensity.compact,
    );
  }
}

class MarkeiResponsiveGrid extends StatelessWidget {
  const MarkeiResponsiveGrid({
    required this.layoutClass,
    required this.children,
    super.key,
    this.minTileWidth = 260,
  });

  final MarkeiLayoutClass layoutClass;
  final List<Widget> children;
  final double minTileWidth;

  @override
  Widget build(BuildContext context) {
    if (layoutClass == MarkeiLayoutClass.compact) {
      return Column(
        children: [
          for (final child in children) ...[
            child,
            if (child != children.last)
              const SizedBox(height: MarkeiSpacing.sm),
          ],
        ],
      );
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / minTileWidth).floor().clamp(
          1,
          layoutClass == MarkeiLayoutClass.wide ? 3 : 2,
        );
        final tileWidth =
            (constraints.maxWidth - (MarkeiSpacing.sm * (columns - 1))) /
            columns;
        return Wrap(
          spacing: MarkeiSpacing.sm,
          runSpacing: MarkeiSpacing.sm,
          children: [
            for (final child in children)
              SizedBox(width: tileWidth, child: child),
          ],
        );
      },
    );
  }
}
