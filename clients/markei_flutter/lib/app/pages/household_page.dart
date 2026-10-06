import '../../l10n/marc_localizations.dart';
import 'package:flutter/material.dart';

import '../../application/hosted_auth_ports.dart';
import '../../application/household.dart';
import '../../application/local_references.dart';
import '../../domain/references/local_reference.dart';
import '../../domain/shared/ids.dart';
import '../design/markei_theme.dart';
import '../widgets/markei_components.dart';

class HouseholdPage extends StatefulWidget {
  const HouseholdPage({
    required this.profileSource,
    required this.refreshSignal,
    required this.onOpenSettings,
    this.accountId,
    this.references,
    this.household,
    this.onChanged,
    super.key,
  });
  final AuthenticatedUserProfileSource profileSource;
  final int refreshSignal;
  final VoidCallback onOpenSettings;
  final AccountId? accountId;
  final LocalReferenceRepository? references;
  final HouseholdQueryRepository? household;
  final VoidCallback? onChanged;

  @override
  State<HouseholdPage> createState() => _HouseholdPageState();
}

class _HouseholdPageState extends State<HouseholdPage> {
  late Future<AuthenticatedUserProfile?> _profile;
  late Future<List<HouseholdPersonSummary>> _people;
  var _busy = false;
  String? _message;

  @override
  void initState() {
    super.initState();
    _profile = widget.profileSource.currentProfile();
    _people = _loadPeople();
  }

  @override
  void didUpdateWidget(covariant HouseholdPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profileSource != widget.profileSource ||
        oldWidget.refreshSignal != widget.refreshSignal) {
      _profile = widget.profileSource.currentProfile();
    }
    if (oldWidget.accountId != widget.accountId ||
        oldWidget.household != widget.household ||
        oldWidget.refreshSignal != widget.refreshSignal) {
      _people = _loadPeople();
      _message = null;
    }
  }

  Future<List<HouseholdPersonSummary>> _loadPeople() async {
    final account = widget.accountId;
    final repository = widget.household;
    if (account == null || repository == null) return const [];
    return repository.householdPeople(account);
  }

  Future<void> _toggleArchived(LocalReference reference) async {
    final account = widget.accountId;
    final repository = widget.references;
    if (_busy || account == null || repository == null) return;
    setState(() => _busy = true);
    try {
      if (reference.active) {
        await repository.archiveReference(
          accountId: account,
          kind: reference.kind,
          id: reference.id,
        );
      } else {
        await repository.saveReference(
          accountId: account,
          kind: reference.kind,
          id: reference.id,
          nickname: reference.nickname,
        );
      }
      if (!mounted || account != widget.accountId) return;
      setState(() {
        _people = _loadPeople();
        _message = null;
      });
      widget.onChanged?.call();
    } on Object {
      if (!mounted || account != widget.accountId) return;
      setState(() => _message = 'This setting could not be saved locally.');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) => ListView(
    key: const Key('household.page'),
    children: [
      const MarkeiPageHeader(
        title: 'Household',
        purpose: 'A considered space for you and your everyday essentials.',
        icon: Icons.groups_outlined,
      ),
      const SizedBox(height: 24),
      FutureBuilder<AuthenticatedUserProfile?>(
        future: _profile,
        builder: (context, snapshot) {
          // Never show the previous user's profile while a new session loads.
          if (snapshot.connectionState != ConnectionState.done) {
            return const MarkeiStatePanel(
              title: 'Your profile',
              message: 'Loading your current sign-in profile.',
              icon: Icons.person_outline,
            );
          }
          if (snapshot.hasError) {
            return MarkeiStatePanel(
              title: 'Profile unavailable',
              message:
                  'Your sign-in profile could not be read. Open Settings to check your session.',
              action: OutlinedButton(
                onPressed: widget.onOpenSettings,
                child: const MarcText('Open Settings'),
              ),
            );
          }
          final profile = snapshot.data;
          if (profile == null) {
            return MarkeiStatePanel(
              key: const Key('household.signedOut'),
              title: 'Your household starts with you',
              message:
                  'Sign in through Settings to see your name and email here.',
              action: FilledButton(
                onPressed: widget.onOpenSettings,
                child: const MarcText('Sign in through Settings'),
              ),
            );
          }
          final name = profile.name?.trim();
          final email = profile.email?.trim();
          return MarkeiCard(
            key: const Key('household.profile'),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MarcText(
                  'MARC / YOUR SPACE',
                  style: MarkeiText.label.copyWith(
                    color: MarkeiColors.lavender,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: MarkeiColors.lavenderTint,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        color: MarkeiColors.lavender,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: MarcText(
                        name == null || name.isEmpty
                            ? 'Welcome to your household'
                            : 'Welcome, $name',
                        key: const Key('household.name'),
                        style: MarkeiText.pageTitle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                const MarcText('Signed-in email', style: MarkeiText.metadata),
                const SizedBox(height: 8),
                SelectableText(
                  email == null || email.isEmpty
                      ? context.tr('Email was not provided by your sign-in.')
                      : email,
                  key: const Key('household.email'),
                  style: MarkeiText.body.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const MarkeiStatusChip(label: 'Signed-in profile'),
              ],
            ),
          );
        },
      ),
      const SizedBox(height: 24),
      FutureBuilder<List<HouseholdPersonSummary>>(
        future: _people,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const MarkeiStatePanel(
              title: 'People',
              message: 'Loading people for this Account.',
              icon: Icons.groups_outlined,
            );
          }
          if (snapshot.hasError) {
            return const MarkeiStatePanel(
              title: 'People unavailable',
              message:
                  'People could not be loaded. Open Settings to try again.',
              icon: Icons.groups_outlined,
            );
          }
          final people = snapshot.data ?? const [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const MarcText('People', style: MarkeiText.sectionTitle),
              const SizedBox(height: 8),
              const MarcText(
                'People and Payment Methods are saved on this device for this Account.',
              ),
              const SizedBox(height: 16),
              if (people.isEmpty)
                const MarkeiStatePanel(
                  key: Key('household.empty'),
                  title: 'Your everyday people',
                  message:
                      'Register people in Settings to see their cards here.',
                  icon: Icons.groups_outlined,
                )
              else
                for (final summary in people) ...[
                  _PersonCard(
                    summary: summary,
                    busy: _busy || widget.references == null,
                    onToggleArchived: _toggleArchived,
                  ),
                  const SizedBox(height: 16),
                ],
            ],
          );
        },
      ),
      if (_message != null) MarcText(_message!),
      const SizedBox(height: 24),
      Align(
        alignment: Alignment.centerLeft,
        child: OutlinedButton.icon(
          onPressed: widget.onOpenSettings,
          icon: const Icon(Icons.settings_outlined),
          label: const MarcText('Open Settings'),
        ),
      ),
    ],
  );
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({
    required this.summary,
    required this.busy,
    required this.onToggleArchived,
  });

  final HouseholdPersonSummary summary;
  final bool busy;
  final ValueChanged<LocalReference> onToggleArchived;

  @override
  Widget build(BuildContext context) {
    final person = summary.person;
    final purchase = summary.latestPurchase;
    return MarkeiCard(
      key: Key('household.person.${person.id}'),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 8,
            children: [
              Text(
                '${person.nickname} · ${person.visibleCode}',
                style: MarkeiText.sectionTitle,
              ),
              MarkeiStatusChip(label: person.active ? 'Active' : 'Archived'),
              TextButton(
                key: Key(
                  'household.${person.active ? 'archive' : 'unarchive'}.${person.id}',
                ),
                onPressed: busy ? null : () => onToggleArchived(person),
                child: MarcText(person.active ? 'Archive' : 'Unarchive'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (summary.paymentMethods.isEmpty)
            const MarcText('No Payment Methods assigned.')
          else
            ExpansionTile(
              key: PageStorageKey('household.payments.${person.id}'),
              maintainState: true,
              tilePadding: EdgeInsets.zero,
              title: const MarcText('Payment Methods'),
              children: [
                for (final payment in summary.paymentMethods)
                  ListTile(
                    title: Text(
                      payment.active
                          ? payment.displayLabel
                          : context.message('{p0} (archived)', [
                              payment.displayLabel,
                            ]),
                    ),
                    trailing: TextButton(
                      key: Key(
                        'household.${payment.active ? 'archive' : 'unarchive'}.${payment.id}',
                      ),
                      onPressed: busy ? null : () => onToggleArchived(payment),
                      child: MarcText(payment.active ? 'Archive' : 'Unarchive'),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 16),
          const MarcText(
            'Last registered purchase',
            style: MarkeiText.metadata,
          ),
          const SizedBox(height: 8),
          if (purchase == null)
            const MarcText(
              'No purchase recorded for this person on this device.',
            )
          else ...[
            Text(purchase.storeName),
            MarcText(_purchaseDisplay(context, purchase)),
          ],
        ],
      ),
    );
  }

  String _purchaseDisplay(
    BuildContext context,
    HouseholdPurchaseSummary purchase,
  ) {
    final date = purchase.occurrenceTime.toLocal();
    final day = MaterialLocalizations.of(context).formatCompactDate(date);
    final total =
        '${purchase.totalMinorUnits ~/ 100}.${(purchase.totalMinorUnits % 100).toString().padLeft(2, '0')}';
    return '$day · ${purchase.currencyCode} $total';
  }
}
