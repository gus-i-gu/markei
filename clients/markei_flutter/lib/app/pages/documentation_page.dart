import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/marc_localizations.dart';
import '../design/markei_theme.dart';
import '../widgets/markei_components.dart';

/// A local disclosure surface. Reading it never contacts a provider.
class DocumentationPage extends StatefulWidget {
  const DocumentationPage({super.key});

  @override
  State<DocumentationPage> createState() => _DocumentationPageState();
}

class _DocumentationPageState extends State<DocumentationPage> {
  final _scrollController = ScrollController();
  final _sectionKeys = [
    for (var index = 0; index < _sections.length; index++) GlobalKey(),
  ];
  final _focusNodes = [
    for (var index = 0; index < _sections.length; index++) FocusNode(),
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const Key('documentation.page'),
      controller: _scrollController,
      padding: const EdgeInsets.all(MarkeiSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MarkeiPageHeader(
            title: 'Documentation',
            purpose:
                'How Marc uses your data, permissions and connected services.',
            icon: Icons.policy_outlined,
          ),
          const SizedBox(height: MarkeiSpacing.md),
          const MarkeiCard(
            child: MarcText(
              'Your purchase records and notes are your content. Marc stores them locally and lets you choose when to connect, Sync, export or share. Online features also process the technical data explained below.',
            ),
          ),
          const SizedBox(height: MarkeiSpacing.md),
          MarkeiSection(
            title: 'Contents',
            subtitle: 'Choose a documentation topic.',
            child: Wrap(
              spacing: MarkeiSpacing.sm,
              runSpacing: MarkeiSpacing.xs,
              children: [
                for (var index = 0; index < _sections.length; index++)
                  OutlinedButton(
                    key: Key('documentation.anchor.${_sections[index].id}'),
                    onPressed: () => _focusSection(index),
                    child: MarcText(_sections[index].title),
                  ),
              ],
            ),
          ),
          const SizedBox(height: MarkeiSpacing.md),
          for (var index = 0; index < _sections.length; index++) ...[
            Focus(
              key: _sectionKeys[index],
              focusNode: _focusNodes[index],
              child: MarkeiSection(
                key: Key('documentation.section.${_sections[index].id}'),
                title: _sections[index].title,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (
                      var paragraph = 0;
                      paragraph < _sections[index].paragraphs.length;
                      paragraph++
                    ) ...[
                      if (paragraph != 0)
                        const SizedBox(height: MarkeiSpacing.sm),
                      MarcText(_sections[index].paragraphs[paragraph]),
                    ],
                    if (_sections[index].id == 'providers') ...[
                      const SizedBox(height: MarkeiSpacing.md),
                      for (final policy in _policies)
                        _PolicyReference(policy: policy),
                    ],
                  ],
                ),
              ),
            ),
            if (index != _sections.length - 1)
              const SizedBox(height: MarkeiSpacing.md),
          ],
        ],
      ),
    );
  }

  void _focusSection(int index) {
    final sectionContext = _sectionKeys[index].currentContext;
    if (sectionContext != null) {
      Scrollable.ensureVisible(
        sectionContext,
        duration: const Duration(milliseconds: 160),
      );
    }
    _focusNodes[index].requestFocus();
  }
}

class _PolicyReference extends StatelessWidget {
  const _PolicyReference({required this.policy});

  final _ProviderPolicy policy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MarkeiSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MarcText(policy.label, style: MarkeiText.sectionTitle),
          const SizedBox(height: MarkeiSpacing.xxs),
          SelectableText(
            policy.url,
            key: Key('documentation.policy.${policy.id}.url'),
          ),
          const SizedBox(height: MarkeiSpacing.xs),
          OutlinedButton.icon(
            key: Key('documentation.policy.${policy.id}.copy'),
            icon: const Icon(Icons.copy_outlined),
            label: const MarcText('Copy policy link'),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: policy.url));
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: MarcText('Policy link copied.')),
              );
            },
          ),
        ],
      ),
    );
  }
}

final class _DocumentationSection {
  const _DocumentationSection({
    required this.id,
    required this.title,
    required this.paragraphs,
  });

  final String id;
  final String title;
  final List<String> paragraphs;
}

final class _ProviderPolicy {
  const _ProviderPolicy(this.id, this.label, this.url);

  final String id;
  final String label;
  final String url;
}

const _sections = [
  _DocumentationSection(
    id: 'local-data',
    title: 'Data on this Device',
    paragraphs: [
      'The local database contains the information you enter: Product codes, names, brands and package measurements; Store names; Purchase dates, quantities, prices, currency and totals; optional Person and Payment Method nicknames and references; and List notes, tags and revision history. Language and shortage preferences are also stored locally.',
      'Marc also creates Account, Device, installation and record identifiers, timestamps, event sequences, content hashes, pending Sync records and Sync status. Local diagnostics record operation phases, error codes, counts, duration bands and request references. These records support consistency, synchronization and troubleshooting; a shortened or hashed reference is not a guarantee of anonymity.',
      'Analytics calculates reports from Purchase records available on this Device. This version does not include an advertising or behavioral tracking SDK. Its fonts are bundled with the app and do not require a font-service request.',
    ],
  ),
  _DocumentationSection(
    id: 'online-actions',
    title: 'Sign-in, connection and Sync',
    paragraphs: [
      'Sign in opens the Auth0 sign-in page. Auth0 and any identity provider you choose there process the login information. Marc requests identity, profile and email access, receives authentication tokens and may display your name and email. This client keeps its authentication tokens in memory for the session.',
      'Connect this Device sends an installation identifier, enrollment request identifier, platform, application identifier and version to the hosted service. The service records identity-to-Account membership and Device enrollment. Follow the restart instructions shown after connection. Records created before connection remain in the offline workspace.',
      'Sync now is an explicit action. It sends queued Purchase, Product, Store and List-note records for the connected Account, and receives that Account\'s records from connected Devices. It also exchanges authentication, Device, event, submission, sequence, hash, cursor and request identifiers. It does not upload the entire local database; optional Person and Payment Method references currently remain local.',
    ],
  ),
  _DocumentationSection(
    id: 'providers',
    title: 'Connected providers and technical records',
    paragraphs: [
      'Auth0 provides sign-in, Render hosts the synchronization service, and Neon stores the hosted database. These services process the information needed for their role. Hosted records are associated with your Account and enrolled Devices; they are not made public by opening Marc.',
      'Online requests expose network information such as an IP address to the services contacted. Auth0 can record login times, outcomes, user identifiers, IP addresses and browser details. The Marc service emits operational logs with timestamps, routes, results, request fingerprints and duration bands. Providers may also keep security, infrastructure and backup records under their service terms.',
      'Provider policies and processing terms are available below. Copy a link and open it in your browser to read the current details. Visiting these websites is a separate external action, covered by their own policies. Their website policies do not replace the Marc publisher\'s responsibilities for data processed for Marc.',
    ],
  ),
  _DocumentationSection(
    id: 'permissions',
    title: 'Device permissions',
    paragraphs: [
      'The Android release declares Internet access for sign-in and synchronization. Its dependencies also declare biometric and fingerprint authentication support, but the current Marc sign-in flow does not invoke biometric authentication or collect biometric templates. An internal signature permission protects an app receiver.',
      'The current release does not request camera, microphone, location, contacts, notification or broad storage access. Native sharing gives the chosen recipient access to the selected text or temporary file. Windows export writes to your Downloads folder and uses your existing folder access.',
    ],
  ),
  _DocumentationSection(
    id: 'sharing',
    title: 'Exports and sharing',
    paragraphs: [
      'Marc exports or shares content when you choose the corresponding action. Sharing opens the system share interface; you choose the destination and recipient. The selected app or service then handles the content under its own rules. A share handoff does not prove delivery, receipt or deletion by that recipient.',
      'Windows exports remain in Downloads until you remove them. Android public Downloads export is unavailable in this build. File sharing uses temporary app files; files older than one day are eligible for cleanup when another file share is prepared. Shared or exported copies can persist outside Marc.',
    ],
  ),
  _DocumentationSection(
    id: 'storage',
    title: 'Storage, backup and deletion',
    paragraphs: [
      'The local database is stored in the app\'s support directory. This client does not add separate database encryption; protection also depends on your operating system, Device access controls and backups. Android may include local app data in system backup or Device transfer, depending on your settings and platform. The app currently has no custom Android backup exclusions.',
      'Signing out ends the Marc session; it does not erase Purchases, hosted Account data or provider logs. Removing local app data does not request deletion of hosted records, backups or recipient copies. This MVP does not provide an in-app Account deletion action.',
      'A hosted retention schedule, backup-deletion procedure and dedicated privacy contact for the Marc publisher have not yet been published here. Provider log and backup lifetimes depend on the services and their configuration. This page does not promise immediate or complete deletion.',
    ],
  ),
  _DocumentationSection(
    id: 'responsibility',
    title: 'Accurate and lawful use',
    paragraphs: [
      'Enter accurate records and only information you are entitled to use. Do not put passwords, authentication tokens, full card numbers or unnecessary sensitive personal information in names or notes. Review records and calculated results before using or sharing them.',
      'You are responsible for the content you enter and share, and for unlawful, fraudulent or improper use of Marc. Marc does not verify the real-world truth of manual entries or certify financial, tax or legal declarations. Responsibility for any harm depends on applicable law and the circumstances; this statement does not exclude obligations that the Marc publisher cannot lawfully exclude.',
    ],
  ),
  _DocumentationSection(
    id: 'rights',
    title: 'Your privacy rights',
    paragraphs: [
      'Applicable privacy law may give you rights to confirmation and access, correction, portability, information about sharing, and anonymization, blocking or deletion in the cases allowed by law. Where processing relies on consent, you may withdraw it. You may also contact the competent data-protection authority.',
      'These rights and mandatory consumer protections remain in force. The Marc publisher must still identify the responsible person and publish a contact and practical request procedure; provider policy links alone do not supply that missing information.',
    ],
  ),
];

const _policies = [
  _ProviderPolicy(
    'auth0',
    'Auth0 / Okta privacy policy',
    'https://www.okta.com/legal/privacy-policy/',
  ),
  _ProviderPolicy(
    'auth0-processing',
    'Auth0 data processing',
    'https://auth0.com/docs/secure/data-privacy-and-compliance/data-processing',
  ),
  _ProviderPolicy(
    'render',
    'Render privacy policy',
    'https://render.com/privacy',
  ),
  _ProviderPolicy(
    'neon',
    'Neon / Databricks privacy notice',
    'https://neon.com/privacy-policy',
  ),
  _ProviderPolicy(
    'neon-processing',
    'Neon processing and service terms',
    'https://neon.com/platform-terms',
  ),
];
