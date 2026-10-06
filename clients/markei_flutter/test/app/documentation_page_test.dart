import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/pages/documentation_page.dart';

const _topicIds = [
  'local-data',
  'online-actions',
  'providers',
  'permissions',
  'sharing',
  'storage',
  'responsibility',
  'rights',
];

void main() {
  testWidgets('privacy topics remain reachable on a narrow large-text screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(2)),
          child: const Scaffold(body: DocumentationPage()),
        ),
      ),
    );

    for (final topic in _topicIds) {
      final anchor = find.byKey(Key('documentation.anchor.$topic'));
      await tester.ensureVisible(anchor);
      await tester.pumpAndSettle();
      await tester.tap(anchor);
      await tester.pumpAndSettle();
      final section = find.byKey(Key('documentation.section.$topic'));
      expect(Focus.of(tester.element(section)).hasFocus, isTrue);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets(
    'provider policies are visible and copied only by explicit action',
    (tester) async {
      final copied = <String>[];
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        (call) async {
          if (call.method == 'Clipboard.setData') {
            copied.add((call.arguments as Map)['text'] as String);
          }
          return null;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          null,
        ),
      );
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: DocumentationPage())),
      );

      const policies = {
        'auth0': 'https://www.okta.com/legal/privacy-policy/',
        'auth0-processing':
            'https://auth0.com/docs/secure/data-privacy-and-compliance/data-processing',
        'render': 'https://render.com/privacy',
        'neon': 'https://neon.com/privacy-policy',
        'neon-processing': 'https://neon.com/platform-terms',
      };
      for (final policy in policies.entries) {
        final visibleUrl = tester.widget<SelectableText>(
          find.byKey(Key('documentation.policy.${policy.key}.url')),
        );
        expect(visibleUrl.data, policy.value);
      }
      expect(copied, isEmpty);

      for (final policy in policies.entries) {
        final button = find.byKey(
          Key('documentation.policy.${policy.key}.copy'),
        );
        await tester.ensureVisible(button);
        await tester.pumpAndSettle();
        await tester.tap(button);
        await tester.pumpAndSettle();
        expect(copied.last, policy.value);
      }
      expect(copied, policies.values.toList());
    },
  );

  testWidgets(
    'disclosure explains operational processing and deletion limits',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: DocumentationPage())),
      );

      expect(find.textContaining('IP addresses'), findsOneWidget);
      expect(find.textContaining('operational logs'), findsOneWidget);
      expect(find.textContaining('current Marc sign-in flow'), findsOneWidget);
      expect(
        find.textContaining('system backup or Device transfer'),
        findsOneWidget,
      );
      expect(
        find.textContaining('in-app Account deletion action'),
        findsOneWidget,
      );
      expect(
        find.textContaining('mandatory consumer protections'),
        findsOneWidget,
      );
      expect(find.textContaining('cannot lawfully exclude'), findsOneWidget);
      expect(find.textContaining('no metadata is collected'), findsNothing);
      expect(find.textContaining('not liable for any harm'), findsNothing);
    },
  );
}
