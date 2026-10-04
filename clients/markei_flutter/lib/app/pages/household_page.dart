import 'package:flutter/material.dart';

import '../../application/hosted_auth_ports.dart';
import '../design/markei_theme.dart';
import '../widgets/markei_components.dart';

class HouseholdPage extends StatefulWidget {
  const HouseholdPage({
    required this.profileSource,
    required this.refreshSignal,
    required this.onOpenSettings,
    super.key,
  });
  final AuthenticatedUserProfileSource profileSource;
  final int refreshSignal;
  final VoidCallback onOpenSettings;

  @override
  State<HouseholdPage> createState() => _HouseholdPageState();
}

class _HouseholdPageState extends State<HouseholdPage> {
  late Future<AuthenticatedUserProfile?> _profile;

  @override
  void initState() {
    super.initState();
    _profile = widget.profileSource.currentProfile();
  }

  @override
  void didUpdateWidget(covariant HouseholdPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profileSource != widget.profileSource ||
        oldWidget.refreshSignal != widget.refreshSignal) {
      _profile = widget.profileSource.currentProfile();
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
                child: const Text('Open Settings'),
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
                child: const Text('Sign in through Settings'),
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
                Text(
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
                      child: Text(
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
                const Text('Signed-in email', style: MarkeiText.metadata),
                const SizedBox(height: 8),
                SelectableText(
                  email == null || email.isEmpty
                      ? 'Email was not provided by your sign-in.'
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
      const MarkeiStatePanel(
        key: Key('household.reserved'),
        title: 'Room to grow',
        message:
            'Household sharing tools are planned. Your signed-in profile is available here today; invitations and member management are still being prepared.',
        icon: Icons.auto_awesome_outlined,
      ),
      const SizedBox(height: 24),
      Align(
        alignment: Alignment.centerLeft,
        child: OutlinedButton.icon(
          onPressed: widget.onOpenSettings,
          icon: const Icon(Icons.settings_outlined),
          label: const Text('Open Settings'),
        ),
      ),
    ],
  );
}
