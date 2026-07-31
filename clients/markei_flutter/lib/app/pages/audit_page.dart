import 'package:flutter/material.dart';

import '../../application/audit.dart';
import '../widgets/audit_components.dart';
import '../widgets/markei_components.dart';

class AuditPage extends StatefulWidget {
  const AuditPage({required this.controller, required this.visible, super.key});

  final AuditController controller;
  final bool visible;

  @override
  State<AuditPage> createState() => _AuditPageState();
}

class _AuditPageState extends State<AuditPage> {
  late AuditWorkspaceState _state = widget.controller.state;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    if (widget.visible) _loadFirstPage();
  }

  @override
  void didUpdateWidget(covariant AuditPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible && !_started) _loadFirstPage();
  }

  Future<void> _loadFirstPage() async {
    _started = true;
    final state = await widget.controller.loadFirstPage();
    if (mounted) setState(() => _state = state);
  }

  Future<void> _retry() async {
    final state = await widget.controller.retry();
    if (mounted) setState(() => _state = state);
  }

  Future<void> _nextPage() async {
    final state = await widget.controller.loadNextPage();
    if (mounted) setState(() => _state = state);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.visible) return const SizedBox.shrink();
    return ListView(
      key: const Key('audit.page'),
      padding: const EdgeInsets.all(16),
      children: [
        const MarkeiPageHeader(
          title: 'Audit',
          purpose:
              'Recent activity recorded locally for this Account and environment.',
          icon: Icons.fact_check_outlined,
        ),
        const SizedBox(height: 16),
        AuditStateView(state: _state, onRetry: _retry, onNextPage: _nextPage),
      ],
    );
  }
}
