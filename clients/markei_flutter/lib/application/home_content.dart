final class HomeCardDescriptor {
  const HomeCardDescriptor({
    required this.title,
    required this.body,
    required this.destinationId,
  });

  final String title;
  final String body;
  final String destinationId;
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
