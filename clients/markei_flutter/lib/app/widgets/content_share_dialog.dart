import 'package:flutter/material.dart';
import '../../l10n/marc_localizations.dart';

Future<bool> confirmContentShare(
  BuildContext context, {
  required String description,
  String? preview,
}) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.tr('Review before sharing')),
        content: SizedBox(
          width: 520,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(description),
                const SizedBox(height: 12),
                Text(
                  context.tr(
                    'The chosen app and recipient will receive a copy. Sharing does not invite them into your Household.',
                  ),
                ),
                if (preview != null) ...[
                  const SizedBox(height: 16),
                  SelectableText(preview),
                ],
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            key: const Key('share.cancel'),
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.tr('Cancel')),
          ),
          FilledButton.icon(
            key: const Key('share.confirm'),
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.share_outlined),
            label: Text(context.tr('Choose app')),
          ),
        ],
      ),
    ) ??
    false;
