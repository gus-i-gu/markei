import '../../l10n/marc_localizations.dart';
import 'package:flutter/material.dart';

import '../../application/closure_diagnostics.dart';
import '../../application/local_references.dart';
import '../../domain/references/local_reference.dart';
import '../../domain/shared/ids.dart';
import '../../l10n/language_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    required this.accountId,
    required this.references,
    required this.preferences,
    required this.accountSupport,
    required this.syncDeviceSupport,
    required this.onChanged,
    this.languageController,
    super.key,
  });

  final AccountId accountId;
  final LocalReferenceRepository references;
  final AccountPreferenceRepository preferences;
  final SettingsAccountSupportPort accountSupport;
  final SettingsSyncDeviceSupportPort syncDeviceSupport;
  final VoidCallback onChanged;
  final LanguageController? languageController;

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
  void didUpdateWidget(covariant SettingsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.accountId != widget.accountId ||
        oldWidget.references != widget.references) {
      _load();
    }
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
      if (reference.active) {
        await widget.references.archiveReference(
          accountId: widget.accountId,
          kind: kind,
          id: reference.id,
        );
      } else {
        await widget.references.saveReference(
          accountId: widget.accountId,
          kind: kind,
          id: reference.id,
          nickname: reference.nickname,
        );
      }
      await _refreshReferences();
      if (!mounted) return;
      setState(() {
        _message = reference.active
            ? context.message(
                '{p0} archived. Existing Purchase history keeps its recorded label.',
                [reference.displayLabel],
              )
            : context.message('{p0} unarchived.', [reference.displayLabel]);
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

  Future<void> _assignPayment(LocalReference payment, String? personId) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await widget.references.assignPaymentMethod(
        accountId: widget.accountId,
        paymentMethodId: payment.id,
        personId: personId,
      );
      await _refreshReferences();
      if (!mounted) return;
      setState(
        () => _message = 'Payment Method assignment saved on this device.',
      );
      widget.onChanged();
    } on Object {
      if (!mounted) return;
      setState(() => _message = 'This setting could not be saved locally.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
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
      if (result.state == 'sync-completed' ||
          result.state == 'sync-no-new-events') {
        await _refreshReferences();
        if (!mounted) return;
      }
      if (const {
        'sync-completed',
        'sync-no-new-events',
        'signed-in',
        'signed-out-cleared',
      }.contains(result.state)) {
        widget.onChanged();
      }
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
        MarcText('Settings', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        const MarcText(
          'People and Payment Methods are saved on this device for this Account.',
        ),
        if (widget.languageController != null) ...[
          const Divider(height: 32),
          _LanguageSection(controller: widget.languageController!),
        ],
        const Divider(height: 32),
        if (_loading)
          const MarcText(
            'Loading local settings...',
            key: Key('settings.loading'),
          )
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
            onAssignPayment: _assignPayment,
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
          MarcText(_message!, key: const Key('settings.message')),
        ],
      ],
    );
  }
}

class _LanguageSection extends StatelessWidget {
  const _LanguageSection({required this.controller});
  final LanguageController controller;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, child) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MarcText('Language'),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          key: ValueKey(
            'settings.language.${controller.selection ?? 'device'}.${controller.busy}',
          ),
          initialValue: controller.selection ?? 'device',
          isExpanded: true,
          decoration: InputDecoration(labelText: context.tr('Language')),
          items: [
            DropdownMenuItem(
              value: 'device',
              child: MarcText('Device language'),
            ),
            const DropdownMenuItem(value: 'en', child: Text('English')),
            const DropdownMenuItem(
              value: 'pt_BR',
              child: Text('Português (Brasil)'),
            ),
            const DropdownMenuItem(value: 'es', child: Text('Español')),
          ],
          onChanged: controller.busy
              ? null
              : (value) => controller.select(value == 'device' ? null : value),
        ),
        const SizedBox(height: 8),
        const MarcText(
          'Saved on this device. Changing language does not change your purchases.',
        ),
        if (controller.error != null) MarcText(controller.error!),
      ],
    ),
  );
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
    required this.onAssignPayment,
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
  final void Function(LocalReference, String?) onAssignPayment;
  final VoidCallback onSaveThreshold;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarcText('Preferences', style: Theme.of(context).textTheme.titleLarge),
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
          people: people,
          onAssign: onAssignPayment,
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
          ).localized(context),
        ),
        const SizedBox(height: 8),
        FilledButton(
          key: const Key('settings.saveThreshold'),
          onPressed: busy ? null : onSaveThreshold,
          child: const MarcText('Save threshold'),
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
    this.people = const [],
    this.onAssign,
  });

  final String title;
  final List<LocalReference> references;
  final TextEditingController controller;
  final String saveLabel;
  final VoidCallback onSave;
  final ValueChanged<LocalReference> onArchive;
  final bool busy;
  final List<LocalReference> people;
  final void Function(LocalReference, String?)? onAssign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarcText(title, style: Theme.of(context).textTheme.titleMedium),
        if (references.isEmpty)
          MarcText('No $title saved for this Account.')
        else
          for (final reference in references)
            onAssign == null
                ? ListTile(
                    title: Text(_referenceDisplay(context, reference)),
                    subtitle: MarcText(
                      reference.active ? 'Active' : 'Archived',
                    ),
                    trailing: TextButton(
                      key: Key(
                        'settings.${reference.active ? 'archive' : 'unarchive'}.${reference.id}',
                      ),
                      onPressed: busy ? null : () => onArchive(reference),
                      child: MarcText(
                        reference.active ? 'Archive' : 'Unarchive',
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_referenceDisplay(context, reference)),
                        MarcText(reference.active ? 'Active' : 'Archived'),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            SizedBox(
                              width: 280,
                              child: DropdownButtonFormField<String>(
                                key: Key(
                                  'settings.assign.${reference.id}.${reference.assignedPersonId ?? 'none'}',
                                ),
                                initialValue: reference.assignedPersonId ?? '',
                                isExpanded: true,
                                decoration: InputDecoration(
                                  labelText: context.tr('Assign Person'),
                                ),
                                items: [
                                  const DropdownMenuItem(
                                    value: '',
                                    child: MarcText('Not assigned'),
                                  ),
                                  for (final person in people)
                                    if (person.active ||
                                        person.id == reference.assignedPersonId)
                                      DropdownMenuItem(
                                        value: person.id,
                                        enabled: person.active,
                                        child: Text(
                                          _referenceDisplay(context, person),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                ],
                                onChanged: busy || !reference.active
                                    ? null
                                    : (value) => onAssign!(
                                        reference,
                                        value == '' ? null : value,
                                      ),
                              ),
                            ),
                            TextButton(
                              key: Key(
                                'settings.${reference.active ? 'archive' : 'unarchive'}.${reference.id}',
                              ),
                              onPressed: busy
                                  ? null
                                  : () => onArchive(reference),
                              child: MarcText(
                                reference.active ? 'Archive' : 'Unarchive',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
        TextField(
          controller: controller,
          decoration: InputDecoration(labelText: 'Nickname').localized(context),
        ),
        const SizedBox(height: 8),
        FilledButton.tonal(
          onPressed: busy ? null : onSave,
          child: MarcText(saveLabel),
        ),
      ],
    );
  }
}

String _referenceDisplay(BuildContext context, LocalReference reference) =>
    reference.active
    ? reference.displayLabel
    : context.message('{p0} (archived)', [reference.displayLabel]);

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
        MarcText('Account', style: Theme.of(context).textTheme.titleLarge),
        MarcText(
          'Current sign-in state: ${context.tr(status?.authenticationState ?? 'Current Sync status is unavailable.')}',
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            FilledButton.tonal(
              key: const Key('settings.signInToSync'),
              onPressed: busy ? null : onSignIn,
              child: const MarcText('Sign in to Sync'),
            ),
            OutlinedButton(
              key: const Key('settings.signOutOnThisDevice'),
              onPressed: busy ? null : onSignOut,
              child: const MarcText('Sign out on this Device'),
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
        MarcText(
          'Sync and Device',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        MarcText(
          'Enrollment: ${context.tr(status?.enrollmentState ?? 'Current Sync status is unavailable.')}',
        ),
        MarcText(
          'Readiness: ${context.tr(status?.syncReadiness ?? 'unavailable')}',
        ),
        MarcText('Last local result: ${status?.lastResult ?? 'unavailable'}'),
        MarcText(
          'Device: ${status?.deviceReference ?? context.tr('No connected Device is recorded locally for this Account.')}',
        ),
        MarcText(
          'Pending ${status?.pending ?? 0}, uploading ${status?.uploading ?? 0}, failed ${status?.failed ?? 0}, unknown ${status?.unknown ?? 0}',
        ),
        MarcText(
          'Last successful Sync: ${status?.lastSuccessfulSyncAtUtc?.toIso8601String() ?? context.tr('not recorded')}',
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          key: const Key('settings.refreshLocalStatus'),
          onPressed: busy ? null : onRefresh,
          child: const MarcText('Refresh local status'),
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
        MarcText('Advanced', style: Theme.of(context).textTheme.titleLarge),
        const MarcText(
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
              child: const MarcText('Connect this Device'),
            ),
            FilledButton.tonal(
              key: const Key('settings.syncNow'),
              onPressed: busy ? null : onSyncNow,
              child: const MarcText('Sync now'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const MarcText(
          'Hosted connection checks, query enrollment, retry, recovery and clear diagnostic history are development-only or absent from product UI.',
        ),
      ],
    );
  }
}
