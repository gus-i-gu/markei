import 'package:flutter/material.dart';
import '../design/markei_theme.dart';

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
            applicationVersion: '1.1.0 · development',
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
            child: compact
                ? _emblem()
                : SizedBox(
                    width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _emblem(),
                            const SizedBox(width: 12),
                            const Text(
                              'MARC',
                              style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 2.8,
                                fontWeight: FontWeight.w500,
                                color: MarkeiColors.brandDeepGreen,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'HOUSEHOLD GOVERNANCE',
                          style: TextStyle(
                            fontSize: 9,
                            letterSpacing: 1.2,
                            color: MarkeiColors.mutedInk,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Divider(),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _emblem() => Image.asset(
    'assets/branding/marc-emblem.png',
    width: 36,
    height: 44,
    fit: BoxFit.contain,
    excludeFromSemantics: true,
    filterQuality: FilterQuality.high,
  );
}
