import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../application/content_sharing.dart';
import '../../application/export_destination.dart';
import '../../application/hosted_auth_ports.dart';
import '../../application/sync_privacy.dart';
import '../../application/user_data_access.dart';
import '../../domain/shared/ids.dart';
import '../../l10n/marc_localizations.dart';
import '../design/markei_theme.dart';
import 'markei_components.dart';

/// Device-local controls. No rights request or export happens merely on opening.
class UserDataSettings extends StatefulWidget {
  const UserDataSettings({
    required this.accountId,
    required this.dataAccess,
    required this.syncPrivacy,
    required this.exportDestination,
    required this.contentSharing,
    required this.profileSource,
    required this.onDocumentation,
    required this.onBusyChanged,
    required this.onDiagnosticsCleared,
    this.busy = false,
    super.key,
  });

  final AccountId accountId;
  final UserDataAccessRepository dataAccess;
  final SyncPrivacyPolicy syncPrivacy;
  final ExportDestinationPort exportDestination;
  final ContentSharingPort contentSharing;
  final AuthenticatedUserProfileSource profileSource;
  final VoidCallback onDocumentation;
  final ValueChanged<bool> onBusyChanged;
  final VoidCallback onDiagnosticsCleared;
  final bool busy;

  @override
  State<UserDataSettings> createState() => _UserDataSettingsState();
}

class _UserDataSettingsState extends State<UserDataSettings> {
  UserDataInventory? _inventory;
  bool? _paused;
  bool _choiceLoaded = false;
  bool _busy = false;
  String? _message;
  int _generation = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant UserDataSettings oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.accountId != widget.accountId ||
        oldWidget.dataAccess != widget.dataAccess ||
        oldWidget.syncPrivacy != widget.syncPrivacy) {
      _choiceLoaded = false;
      _inventory = null;
      _load();
    }
  }

  Future<void> _load() async {
    final generation = ++_generation;
    UserDataInventory? inventory;
    bool? paused;
    try {
      inventory = await widget.dataAccess.inventory(widget.accountId);
    } on Object {
      inventory = null;
    }
    try {
      paused = await widget.syncPrivacy.readPaused();
    } on Object {
      // A failed preference read must never look like permission to transfer.
      paused = null;
    }
    if (!mounted || generation != _generation) return;
    setState(() {
      _inventory = inventory;
      _paused = paused;
      _choiceLoaded = true;
      if (inventory == null) {
        _message = 'Local data controls could not be loaded.';
      }
    });
  }

  Future<void> _run(Future<String> Function() action) async {
    if (_busy || widget.busy) return;
    setState(() => _busy = true);
    widget.onBusyChanged(true);
    try {
      final message = await action();
      if (!mounted) return;
      await _load();
      if (!mounted) return;
      setState(() => _message = message);
    } on Object {
      if (!mounted) return;
      setState(
        () => _message =
            'This data action could not be completed. No completion is confirmed.',
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
        widget.onBusyChanged(false);
      }
    }
  }

  Future<void> _export({required bool share}) async {
    final confirmed = await _confirm(
      'Export data on this Device',
      'This JSON file contains personal purchase records, notes, local references and technical identifiers for the current Account. Protect the file and choose its destination carefully. It excludes hosted-only data, authentication secrets and unsaved session work. It is an access copy, not a restore file.',
      share ? 'Choose an app' : 'Save JSON',
    );
    if (!confirmed || !mounted) return;
    final shareTitle = context.tr('Marc local data export');
    await _run(() async {
      final export = await widget.dataAccess.exportAccountData(
        widget.accountId,
      );
      final request = ExportDestinationRequest(
        baseNameCue: 'marc-my-local-data',
        extension: 'json',
        mediaType: 'application/json',
        bytes: export.jsonBytes,
      );
      if (share) {
        final result = await widget.contentSharing.share(
          ContentShareRequest(title: shareTitle, file: request),
        );
        return contentShareMessage(result);
      }
      return exportDestinationMessage(
        'JSON',
        await widget.exportDestination.write(request),
      );
    });
  }

  Future<void> _changePause(bool value) async {
    if (!value) {
      final confirmed = await _confirm(
        'Resume Sync on this Device?',
        'Resuming permits future connection and Sync actions to transfer queued purchases and notes. Previously uploaded records remain online. Resume does not itself start Sync.',
        'Resume Sync',
      );
      if (!confirmed || !mounted) return;
    }
    await _run(() async {
      await widget.syncPrivacy.setPaused(value);
      return value
          ? 'Sync paused on this Device. Local purchases remain available. An operation already in progress finishes before the pause takes effect.'
          : 'Sync resumed on this Device. Use Sync now when you want to transfer data.';
    });
  }

  Future<void> _clearDiagnostics() async {
    final confirmed = await _confirm(
      'Clear local diagnostic history?',
      'Remove recorded Sync attempts and diagnostic events for this Account on this Device. Purchase records, notes, queued Sync work and device enrollment stay intact. Hosted logs, backups and shared exports are unaffected. This is not Account deletion or secure wiping.',
      'Clear history',
    );
    if (!confirmed || !mounted) return;
    await _run(() async {
      await widget.dataAccess.clearLocalDiagnostics(widget.accountId);
      if (mounted) widget.onDiagnosticsCleared();
      return 'Local diagnostic history cleared for this Account. Your purchases and queued work were preserved.';
    });
  }

  Future<bool> _confirm(String title, String body, String action) async =>
      await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: MarcText(title),
          content: SingleChildScrollView(child: MarcText(body)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const MarcText('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: MarcText(action),
            ),
          ],
        ),
      ) ??
      false;

  Future<void> _privacyRequest() async {
    if (_busy || widget.busy) return;
    // This source reads only the existing in-memory sign-in profile.
    AuthenticatedUserProfile? profile;
    try {
      profile = await widget.profileSource.currentProfile();
    } on Object {
      profile = null;
    }
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) => _PrivacyRequestDialog(
        accountId: widget.accountId,
        email: profile?.email,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final disabled = _busy || widget.busy;
    return MarkeiSection(
      key: const Key('settings.privacy'),
      title: 'Your data & privacy',
      subtitle:
          'Controls for this Device. Hosted Account rights are handled separately.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MarkeiCard(
            color: MarkeiColors.lavenderTint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MarcText(
                  'Your local data',
                  style: MarkeiText.sectionTitle,
                ),
                const SizedBox(height: 8),
                const MarcText(
                  'Purchase records, Catalogue, People, Payment Methods and List notes stored for the current Account can be exported without signing in.',
                ),
                if (_inventory != null) ...[
                  const SizedBox(height: 8),
                  MarcText(
                    context.message('Stored local records: {p0}', [
                      _inventory!.totalRecords.toString(),
                    ]),
                  ),
                ],
                const SizedBox(height: 12),
                Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    if (defaultTargetPlatform == TargetPlatform.windows)
                      FilledButton.tonalIcon(
                        key: const Key('privacy.export'),
                        onPressed: disabled
                            ? null
                            : () => _export(share: false),
                        icon: const Icon(Icons.download_outlined),
                        label: const MarcText('Save JSON'),
                      ),
                    OutlinedButton.icon(
                      key: const Key('privacy.shareExport'),
                      onPressed: disabled ? null : () => _export(share: true),
                      icon: const Icon(Icons.ios_share_outlined),
                      label: const MarcText('Export through another app'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const MarcText(
                  'Android: choose a file-saving app from the share sheet. Sharing may create a temporary copy and does not confirm delivery.',
                ),
              ],
            ),
          ),
          MarkeiCard(
            color: MarkeiColors.greenTint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SwitchListTile.adaptive(
                  key: const Key('privacy.pauseSync'),
                  contentPadding: EdgeInsets.zero,
                  title: const MarcText('Pause Sync on this Device'),
                  subtitle: MarcText(
                    !_choiceLoaded
                        ? 'Reading Sync choice...'
                        : _paused == null
                        ? 'Sync choice unavailable. Transfers are blocked until the preference can be read.'
                        : _paused!
                        ? 'Paused. Your queued records stay on this Device.'
                        : 'Allowed when you explicitly connect or Sync.',
                  ),
                  value: _paused ?? true,
                  onChanged: disabled || !_choiceLoaded ? null : _changePause,
                ),
                const MarcText(
                  'Saved across restarts. Pausing blocks new connection, upload, download and recovery actions. It does not remove data already online. Explicit sign-in and sign-out can still contact the login provider.',
                ),
              ],
            ),
          ),
          MarkeiCard(
            color: MarkeiColors.informationTint,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MarcText(
                  'Access, correction and deletion',
                  style: MarkeiText.sectionTitle,
                ),
                const SizedBox(height: 8),
                const MarcText(
                  'Your email identifies your login. Deleting that login alone does not delete Marc membership, purchases or provider-held records. This beta has no completed hosted Account deletion procedure or configured request channel yet.',
                ),
                const SizedBox(height: 8),
                const MarcText(
                  'People and Payment Methods can be archived in Preferences; Payment Methods can also be assigned to a Person. Registered purchases cannot currently be edited or deleted. Prepare a request for access, correction, deletion or restriction; copying it does not submit it.',
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  key: const Key('privacy.request'),
                  onPressed: disabled ? null : _privacyRequest,
                  icon: const Icon(Icons.edit_note_outlined),
                  label: const MarcText('Prepare privacy request'),
                ),
              ],
            ),
          ),
          MarkeiCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MarcText(
                  'Local diagnostic history',
                  style: MarkeiText.sectionTitle,
                ),
                const SizedBox(height: 8),
                const MarcText(
                  'Audit contains local technical evidence about Sync attempts. Clear that history without removing purchases or the Sync queue. New actions can create new diagnostic records.',
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  key: const Key('privacy.clearDiagnostics'),
                  onPressed: disabled ? null : _clearDiagnostics,
                  child: const MarcText('Clear local diagnostic history'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const MarcText(
            'Sign-out is not deletion. Marc does not include advertising or behavioural analytics SDKs in this build. Authentication and Sync providers can keep operational records under their policies.',
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            key: const Key('privacy.documentation'),
            onPressed: disabled ? null : widget.onDocumentation,
            icon: const Icon(Icons.policy_outlined),
            label: const MarcText('Read data and permissions documentation'),
          ),
          if (_busy) const LinearProgressIndicator(),
          if (_message != null) ...[
            const SizedBox(height: 8),
            MarcText(_message!, key: const Key('privacy.message')),
          ],
        ],
      ),
    );
  }
}

class _PrivacyRequestDialog extends StatefulWidget {
  const _PrivacyRequestDialog({required this.accountId, this.email});
  final AccountId accountId;
  final String? email;
  @override
  State<_PrivacyRequestDialog> createState() => _PrivacyRequestDialogState();
}

class _PrivacyRequestDialogState extends State<_PrivacyRequestDialog> {
  String _kind = 'Access';
  final _description = TextEditingController();
  late final _email = TextEditingController(text: widget.email ?? '');
  String? _message;
  @override
  void dispose() {
    _description.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _copy() async {
    try {
      final text = context.message(
        'Marc privacy request — draft, not submitted\nRequest: {p0}\nContact email supplied by requester: {p1}\nLocal Account reference: {p2}\nDetails: {p3}\nPlease confirm the request scope and a proportionate verification method. This draft is not proof of identity or Account ownership.',
        [
          context.tr(_kind),
          _email.text.trim(),
          widget.accountId.value,
          _description.text.trim(),
        ],
      );
      await Clipboard.setData(ClipboardData(text: text));
      if (!mounted) return;
      setState(
        () => _message =
            'Request draft copied. No request has been sent. Clear the clipboard after use.',
      );
    } on Object {
      if (!mounted) return;
      setState(
        () => _message =
            'The request could not be copied. No request has been sent.',
      );
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const MarcText('Prepare privacy request'),
    content: SizedBox(
      width: 480,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MarcText(
              'No request channel is configured in this beta. This draft stays local until you copy and send it yourself. Never include a password, access token, recovery code or identity document.',
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              key: const Key('privacy.requestKind'),
              initialValue: _kind,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: context.tr('Request type'),
              ),
              items: [
                for (final kind in [
                  'Access',
                  'Correction',
                  'Deletion',
                  'Restriction',
                  'Objection',
                  'Portability',
                ])
                  DropdownMenuItem(value: kind, child: MarcText(kind)),
              ],
              onChanged: (value) => setState(() => _kind = value ?? 'Access'),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('privacy.requestEmail'),
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: context.tr('Your contact email (optional)'),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('privacy.requestDetails'),
              controller: _description,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: context.tr('Describe the request (no secrets)'),
              ),
            ),
            if (_message != null) ...[
              const SizedBox(height: 12),
              MarcText(_message!, key: const Key('privacy.requestMessage')),
            ],
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const MarcText('Close'),
      ),
      FilledButton(
        key: const Key('privacy.copyRequest'),
        onPressed: _copy,
        child: const MarcText('Copy privacy request'),
      ),
    ],
  );
}
