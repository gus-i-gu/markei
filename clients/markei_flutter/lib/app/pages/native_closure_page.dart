import 'package:flutter/material.dart';

import '../native_auth_closure_runner.dart';

class NativeClosurePage extends StatefulWidget {
  const NativeClosurePage({required this.runner, super.key});

  final NativeAuthClosureRunner runner;

  @override
  State<NativeClosurePage> createState() => _NativeClosurePageState();
}

class _NativeClosurePageState extends State<NativeClosurePage> {
  String _state = 'closure-disabled';
  bool _running = false;

  @override
  Widget build(BuildContext context) {
    final actions = [
      _Action('Status', widget.runner.status),
      _Action('Sign in', widget.runner.signIn),
      _Action('Enroll', widget.runner.enrollOrQueryDevice),
      _Action('Query', widget.runner.queryEnrollment),
      _Action('Sync', widget.runner.hostedSyncProbe),
      _Action('Logout', widget.runner.logout),
    ];
    return ListView(
      key: const Key('nativeClosure.page'),
      padding: const EdgeInsets.all(16),
      children: [
        Text('Native closure', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Text(
          _running ? 'sync-running' : _state,
          key: const Key('nativeClosure.state'),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final action in actions)
              FilledButton(
                key: Key('nativeClosure.${action.label}'),
                onPressed: _running ? null : () => _run(action),
                child: Text(action.label),
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _run(_Action action) async {
    setState(() => _running = true);
    final result = await action.run();
    if (!mounted) return;
    setState(() {
      _state = result.state;
      _running = false;
    });
  }
}

final class _Action {
  const _Action(this.label, this.run);

  final String label;
  final Future<NativeClosureStatus> Function() run;
}
