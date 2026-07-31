final class HomeCardDescriptor {
  const HomeCardDescriptor({
    required this.title,
    required this.body,
    this.destinationId,
    this.badge,
  });

  final String title;
  final String body;
  final String? destinationId;
  final String? badge;
}

const homeCards = <HomeCardDescriptor>[
  HomeCardDescriptor(
    title: 'Register purchases',
    body: 'Record household purchases locally first, then reuse Products.',
    destinationId: 'purchase',
  ),
  HomeCardDescriptor(
    title: 'View lists',
    body: 'Inspect Storage, Shortage, Market and All estimates from history.',
    destinationId: 'lists',
  ),
  HomeCardDescriptor(
    title: 'Browse catalogue',
    body: 'Maintain reusable Products for faster future purchase entries.',
    destinationId: 'catalogue',
  ),
  HomeCardDescriptor(
    title: 'Open purchase history',
    body: 'Review registered Purchases and the Products recorded in them.',
    destinationId: 'history',
  ),
];

const homeFollowUpCards = <HomeCardDescriptor>[
  HomeCardDescriptor(
    title: 'News',
    body:
        'Local beta work is focused on reliable purchase registration, evidence review and explicit export from this device.',
    badge: 'Local information',
  ),
  HomeCardDescriptor(
    title: 'Updates follow-up',
    body:
        'Next review gates cover human UI checks, accessibility review and platform export behavior that cannot be proven by automated tests alone.',
    badge: 'Follow-up',
  ),
];
