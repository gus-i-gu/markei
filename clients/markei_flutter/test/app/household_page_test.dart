import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/design/markei_theme.dart';
import 'package:markei/app/pages/household_page.dart';
import 'package:markei/application/hosted_auth_ports.dart';

void main() {
  testWidgets(
    'Household shows explicit email and removes it when the session changes',
    (tester) async {
      final source = _Profiles(
        const AuthenticatedUserProfile(
          name: 'Alex',
          email: 'alex@example.invalid',
        ),
      );
      Widget page(int refresh) => MaterialApp(
        theme: markeiTheme(),
        home: Scaffold(
          body: HouseholdPage(
            profileSource: source,
            refreshSignal: refresh,
            onOpenSettings: () {},
          ),
        ),
      );
      await tester.pumpWidget(page(0));
      await tester.pumpAndSettle();
      expect(find.text('Welcome, Alex'), findsOneWidget);
      expect(find.text('alex@example.invalid'), findsOneWidget);
      source.profile = null;
      await tester.pumpWidget(page(1));
      await tester.pumpAndSettle();
      expect(find.text('alex@example.invalid'), findsNothing);
      expect(find.byKey(const Key('household.signedOut')), findsOneWidget);
    },
  );

  testWidgets(
    'Household profile wraps long names and email at compact 200 percent scale',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await tester.pumpWidget(
        MaterialApp(
          theme: markeiTheme(),
          home: Scaffold(
            body: HouseholdPage(
              profileSource: _Profiles(
                const AuthenticatedUserProfile(
                  name: 'A household member with a long name',
                  email: 'a.very.long.household.member@example.invalid',
                ),
              ),
              refreshSignal: 0,
              onOpenSettings: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.byKey(const Key('household.email')),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(
        find.text('a.very.long.household.member@example.invalid'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );
}

class _Profiles implements AuthenticatedUserProfileSource {
  _Profiles(this.profile);
  AuthenticatedUserProfile? profile;
  @override
  Future<AuthenticatedUserProfile?> currentProfile() async => profile;
}
