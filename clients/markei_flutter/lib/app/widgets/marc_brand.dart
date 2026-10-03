import 'package:flutter/material.dart';

/// Approved Marc artwork; the emblem stays readable in compact navigation.
class MarcBrand extends StatelessWidget {
  const MarcBrand({this.compact = false, super.key});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'About Marc',
      child: Tooltip(
        message: 'About Marc',
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => showAboutDialog(
            context: context,
            applicationName: 'Marc',
            children: [
              Center(
                child: Image.asset(
                  'assets/branding/marc-logo.png',
                  width: 160,
                  height: 200,
                  fit: BoxFit.contain,
                  semanticLabel: 'Marc logo',
                ),
              ),
              const SizedBox(height: 16),
              const Text('Household governance'),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              compact
                  ? 'assets/branding/marc-emblem.png'
                  : 'assets/branding/marc-logo.png',
              width: compact ? 36 : 112,
              height: compact ? 40 : 140,
              fit: BoxFit.contain,
              excludeFromSemantics: true,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),
      ),
    );
  }
}
