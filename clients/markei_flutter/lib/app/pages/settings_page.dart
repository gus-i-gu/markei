import 'package:flutter/material.dart';

import '../../application/closure_diagnostics.dart';
import '../../application/local_references.dart';
import '../../domain/references/local_reference.dart';
import '../../domain/shared/ids.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    required this.accountId,
    required this.references,
    required this.preferences,
    required this.accountSupport,
    required this.syncDeviceSupport,
    required this.onChanged,
    super.key,
  });

  final AccountId accountId;
  final LocalReferenceRepository references;
  final AccountPreferenceRepository preferences;
  final SettingsAccountSupportPort accountSupport;
  final SettingsSyncDeviceSupportPort syncDeviceSupport;
  final VoidCallback onChanged;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _personController = TextEditingController();
  final _paymentController = TextEditingController();
  final _thresholdController = TextEditingController();
  var _loading = true;
  var _busy = false;
  var _generation = 0;
  String? _message;
  String? _thresholdError;
  List<LocalReference> _people = const [];
  List<LocalReference> _payments = const [];
  SettingsAccountStatus? _accountStatus;
  SettingsSyncDeviceStatus? _syncStatus;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _generation++;
    _personController.dispose();
    _paymentController.dispose();
    _thresholdController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final generation = ++_generation;
    setState(() {
      _loading = true;
      _message = 'Loading local settings...';
    });
    try {
      final people = await widget.references.listReferences(
        widget.accountId,
        LocalReferenceKind.person,
        includeArchived: true,
      );
      final payments = await widget.references.listReferences(
        widget.accountId,
        LocalReferenceKind.paymentMethod,
        includeArchived: true,
      );
      final threshold = await widget.preferences.shortageThresholdDays(
        widget.accountId,
      );
      final account = await widget.accountSupport.accountStatus();
      final sync = await widget.syncDeviceSupport.localStatus();
      if (!mounted || generation != _generation) return;
      setState(() {
        _people = people;
        _payments = payments;
        _thresholdController.text = threshold.toString();
        _thresholdError = null;
        _accountStatus = account;
        _syncStatus = sync;
        _loading = false;
        _message = people.isEmpty && payments.isEmpty
            ? 'No People/Payment Methods saved for this Account.'
            : null;
      });
    } on Object {
      if (!mounted || generation != _generation) return;
      setState(() {
        _loading = false;
        _message = 'Local settings could not be loaded.';
      });
    }
  }

  Future<void> _saveReference(
    LocalReferenceKind kind,
    TextEditingController controller,
  ) async {
    if (_busy) return;
    final text = controller.text;
    setState(() => _busy = true);
    try {
      await widget.references.saveReference(
        accountId: widget.accountId,
        kind: kind,
        nickname: text,
      );
      controller.clear();
      await _refreshReferences();
      if (!mounted) return;
      setState(() {
        _message = kind == LocalReferenceKind.person
            ? 'Person saved locally.'
            : 'Payment Method saved locally.';
      });
      widget.onChanged();
    } on Object {
      if (!mounted) return;
      setState(() {
        _message =
            'This setting could not be saved locally. Your entered value is still available.';
      });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _archiveReference(
    LocalReferenceKind kind,
    LocalReference reference,
  ) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await widget.references.archiveReference(
        accountId: widget.accountId,
        kind: kind,
        id: reference.id,
      );
      await _refreshReferences();
      if (!mounted) return;
      setState(() {
        _message =
            '${reference.historyLabel} archived. Existing Purchase history keeps its recorded label.';
      });
      widget.onChanged();
    } on Object {
      if (!mounted) return;
      setState(() => _message = 'This setting could not be saved locally.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _refreshReferences() async {
    final people = await widget.references.listReferences(
      widget.accountId,
      LocalReferenceKind.person,
      includeArchived: true,
    );
    final payments = await widget.references.listReferences(
      widget.accountId,
      LocalReferenceKind.paymentMethod,
      includeArchived: true,
    );
    if (!mounted) return;
    setState(() {
      _people = people;
      _payments = payments;
    });
  }

  Future<void> _saveThreshold() async {
    if (_busy) return;
    final draft = _thresholdController.text.trim();
    final parsed = int.tryParse(draft);
    if (parsed == null ||
        parsed.toString() != draft ||
        parsed < 0 ||
        parsed > 365) {
      setState(() {
        _thresholdError = 'Enter a whole number of days from 0 through 365.';
        _message = _thresholdError;
      });
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.preferences.setShortageThresholdDays(
        widget.accountId,
        parsed,
      );
      if (!mounted) return;
      setState(() {
        _thresholdError = null;
        _message = 'Shortage threshold saved locally.';
      });
      widget.onChanged();
    } on Object {
      if (!mounted) return;
      setState(() {
        _message =
            'This setting could not be saved locally. Your entered value is still available.';
      });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<bool> _refreshLocalStatus({bool fromBusyAction = false}) async {
    if (_busy && !fromBusyAction) return false;
    if (!fromBusyAction) {
      setState(() => _busy = true);
    }
    try {
      final account = await widget.accountSupport.accountStatus();
      final sync = await widget.syncDeviceSupport.localStatus();
      if (!mounted) return false;
      setState(() {
        _accountStatus = account;
        _syncStatus = sync;
        if (!fromBusyAction) {
          _message = 'Local status refreshed.';
        }
      });
      return true;
    } on Object {
      if (!mounted) return false;
      setState(() => _message = 'Current Sync status is unavailable.');
      return false;
    } finally {
      if (mounted && !fromBusyAction) setState(() => _busy = false);
    }
  }

  Future<void> _runSupportAction(
    Future<SettingsActionResult> Function() run,
  ) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final result = await run();
      if (!mounted) return;
      final refreshed = await _refreshLocalStatus(fromBusyAction: true);
      if (!mounted) return;
      setState(
        () => _message = refreshed
            ? '${result.message} Local status refreshed.'
            : result.message,
      );
    } on Object {
      if (!mounted) return;
      setState(
        () => _message =
            'This action did not start: local support action unavailable.',
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const Key('settings.page'),
      padding: const EdgeInsets.all(16),
      children: [
        Text('Settings', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        const Text(
          'Choices for this Account and this Device. Local labels remain on this device unless existing Sync actions are explicitly used.',
        ),
        const Divider(height: 32),
        if (_loading)
          const Text('Loading local settings...', key: Key('settings.loading'))
        else ...[
          _AccountSection(
            status: _accountStatus,
            busy: _busy,
            onSignIn: () =>
                _runSupportAction(widget.accountSupport.signInToSync),
            onSignOut: () =>
                _runSupportAction(widget.accountSupport.signOutOnThisDevice),
          ),
          const Divider(height: 32),
          _PreferencesSection(
            people: _people,
            payments: _payments,
            personController: _personController,
            paymentController: _paymentController,
            thresholdController: _thresholdController,
            thresholdError: _thresholdError,
            busy: _busy,
            onSavePerson: () =>
                _saveReference(LocalReferenceKind.person, _personController),
            onSavePayment: () => _saveReference(
              LocalReferenceKind.paymentMethod,
              _paymentController,
            ),
            onArchivePerson: (reference) =>
                _archiveReference(LocalReferenceKind.person, reference),
            onArchivePayment: (reference) =>
                _archiveReference(LocalReferenceKind.paymentMethod, reference),
            onSaveThreshold: _saveThreshold,
          ),
          const Divider(height: 32),
          _SyncDeviceSection(
            status: _syncStatus,
            busy: _busy,
            onRefresh: _refreshLocalStatus,
          ),
          const Divider(height: 32),
          _AdvancedSupportSection(
            key: const Key('settings.advancedSupport'),
            busy: _busy,
            onConnectDevice: () =>
                _runSupportAction(widget.syncDeviceSupport.connectThisDevice),
            onSyncNow: () =>
                _runSupportAction(widget.syncDeviceSupport.syncNow),
          ),
        ],
        if (_message != null) ...[
          const SizedBox(height: 12),
          Text(_message!, key: const Key('settings.message')),
        ],
      ],
    );
  }
}

class _PreferencesSection extends StatelessWidget {
  const _PreferencesSection({
    required this.people,
    required this.payments,
    required this.personController,
    required this.paymentController,
    required this.thresholdController,
    required this.thresholdError,
    required this.busy,
    required this.onSavePerson,
    required this.onSavePayment,
    required this.onArchivePerson,
    required this.onArchivePayment,
    required this.onSaveThreshold,
  });

  final List<LocalReference> people;
  final List<LocalReference> payments;
  final TextEditingController personController;
  final TextEditingController paymentController;
  final TextEditingController thresholdController;
  final String? thresholdError;
  final bool busy;
  final VoidCallback onSavePerson;
  final VoidCallback onSavePayment;
  final ValueChanged<LocalReference> onArchivePerson;
  final ValueChanged<LocalReference> onArchivePayment;
  final VoidCallback onSaveThreshold;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preferences', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        _ReferenceList(
          title: 'People',
          references: people,
          controller: personController,
          saveLabel: 'Save Person',
          onSave: onSavePerson,
          onArchive: onArchivePerson,
          busy: busy,
        ),
        const SizedBox(height: 16),
        _ReferenceList(
          title: 'Payment Methods',
          references: payments,
          controller: paymentController,
          saveLabel: 'Save Payment Method',
          onSave: onSavePayment,
          onArchive: onArchivePayment,
          busy: busy,
        ),
        const SizedBox(height: 16),
        TextField(
          key: const Key('settings.shortageThreshold'),
          controller: thresholdController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Shortage threshold days',
            errorText: thresholdError,
          ),
        ),
        const SizedBox(height: 8),
        FilledButton(
          key: const Key('settings.saveThreshold'),
          onPressed: busy ? null : onSaveThreshold,
          child: const Text('Save threshold'),
        ),
      ],
    );
  }
}

class _ReferenceList extends StatelessWidget {
  const _ReferenceList({
    required this.title,
    required this.references,
    required this.controller,
    required this.saveLabel,
    required this.onSave,
    required this.onArchive,
    required this.busy,
  });

  final String title;
  final List<LocalReference> references;
  final TextEditingController controller;
  final String saveLabel;
  final VoidCallback onSave;
  final ValueChanged<LocalReference> onArchive;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        if (references.isEmpty)
          Text('No $title saved for this Account.')
        else
          for (final reference in references)
            ListTile(
              title: Text(reference.historyLabel),
              subtitle: Text(reference.active ? 'Active' : 'Archived'),
              trailing: reference.active
                  ? TextButton(
                      key: Key('settings.archive.${reference.id}'),
                      onPressed: busy ? null : () => onArchive(reference),
                      child: const Text('Archive'),
                    )
                  : null,
            ),
        TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nickname'),
        ),
        const SizedBox(height: 8),
        FilledButton.tonal(
          onPressed: busy ? null : onSave,
          child: Text(saveLabel),
        ),
      ],
    );
  }
}

class _AccountSection extends StatelessWidget {
  const _AccountSection({
    required this.status,
    required this.busy,
    required this.onSignIn,
    required this.onSignOut,
  });

  final SettingsAccountStatus? status;
  final bool busy;
  final VoidCallback onSignIn;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Account', style: Theme.of(context).textTheme.titleLarge),
        Text(
          'Current sign-in state: ${status?.authenticationState ?? 'Current Sync status is unavailable.'}',
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.tonal(
              key: const Key('settings.signInToSync'),
              onPressed: busy ? null : onSignIn,
              child: const Text('Sign in to Sync'),
            ),
            OutlinedButton(
              key: const Key('settings.signOutOnThisDevice'),
              onPressed: busy ? null : onSignOut,
              child: const Text('Sign out on this Device'),
            ),
          ],
        ),
      ],
    );
  }
}

class _SyncDeviceSection extends StatelessWidget {
  const _SyncDeviceSection({
    required this.status,
    required this.busy,
    required this.onRefresh,
  });

  final SettingsSyncDeviceStatus? status;
  final bool busy;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Sync and Device', style: Theme.of(context).textTheme.titleLarge),
        Text(
          'Enrollment: ${status?.enrollmentState ?? 'Current Sync status is unavailable.'}',
        ),
        Text('Readiness: ${status?.syncReadiness ?? 'unavailable'}'),
        Text('Last local result: ${status?.lastResult ?? 'unavailable'}'),
        Text(
          'Device: ${status?.deviceReference ?? 'No connected Device is recorded locally for this Account.'}',
        ),
        Text(
          'Pending ${status?.pending ?? 0}, uploading ${status?.uploading ?? 0}, failed ${status?.failed ?? 0}, unknown ${status?.unknown ?? 0}',
        ),
        Text(
          'Last successful Sync: ${status?.lastSuccessfulSyncAtUtc?.toIso8601String() ?? 'not recorded'}',
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          key: const Key('settings.refreshLocalStatus'),
          onPressed: busy ? null : onRefresh,
          child: const Text('Refresh local status'),
        ),
      ],
    );
  }
}

class _AdvancedSupportSection extends StatelessWidget {
  const _AdvancedSupportSection({
    required this.busy,
    required this.onConnectDevice,
    required this.onSyncNow,
    super.key,
  });

  final bool busy;
  final VoidCallback onConnectDevice;
  final VoidCallback onSyncNow;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('settings.advancedSupport.content'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Advanced', style: Theme.of(context).textTheme.titleLarge),
        const Text(
          'Explicit existing Device and Sync actions with visible results.',
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.tonal(
              key: const Key('settings.connectDevice'),
              onPressed: busy ? null : onConnectDevice,
              child: const Text('Connect this Device'),
            ),
            FilledButton.tonal(
              key: const Key('settings.syncNow'),
              onPressed: busy ? null : onSyncNow,
              child: const Text('Sync now'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Hosted connection checks, query enrollment, retry, recovery and clear diagnostic history are development-only or absent from product UI.',
        ),
      ],
    );
  }
}
