import 'package:flutter/material.dart';

enum MarkeiDestinationId {
  home,
  lists,
  purchase,
  catalogue,
  history,
  analytics,
  household,
  guide,
  documentation,
  settings,
  audit,
}

enum MarkeiDestinationGroup { primary, secondary }

final class MarkeiDestination {
  const MarkeiDestination({
    required this.id,
    required this.label,
    required this.icon,
    required this.group,
    this.enabled = true,
    this.description,
  });

  final MarkeiDestinationId id;
  final String label;
  final IconData icon;
  final MarkeiDestinationGroup group;
  final bool enabled;
  final String? description;

  bool get isPrimary => group == MarkeiDestinationGroup.primary;
}
