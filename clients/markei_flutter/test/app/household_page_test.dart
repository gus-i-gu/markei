import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/design/markei_theme.dart';
import 'package:markei/app/pages/household_page.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/domain/references/local_reference.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';

void main() {
  testWidgets(
    'Household shows assigned payments and local purchase at compact 200 percent scale',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      const account = AccountId('11111111-1111-4111-8111-111111111111');
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final repository = LocalQueryRepository(db);
      final person = await repository.saveReference(
        accountId: account,
        kind: LocalReferenceKind.person,
        nickname: 'A person with a long registered name',
      );
      final payment = await repository.saveReference(
        accountId: account,
        kind: LocalReferenceKind.paymentMethod,
        nickname: 'A payment method with a long registered name',
      );
      await repository.assignPaymentMethod(
        accountId: account,
        paymentMethodId: payment.id,
        personId: person.id,
      );
      await db
          .into(db.stores)
          .insert(
            StoresCompanion.insert(
              id: 'store',
              accountId: account.value,
              displayName: 'Corner Market',
              createdAt: DateTime.utc(2026, 10, 1),
            ),
          );
      await db
          .into(db.purchases)
          .insert(
            PurchasesCompanion.insert(
              id: 'purchase',
              accountId: account.value,
              storeId: 'store',
              personId: Value(person.id),
              occurrenceTime: DateTime.utc(2026, 10, 1),
              currencyCode: 'BRL',
              totalMinorUnits: 1234,
              createdAt: DateTime.utc(2026, 10, 2),
            ),
          );
      await tester.pumpWidget(
        MaterialApp(
          theme: markeiTheme(),
          home: Scaffold(
            body: HouseholdPage(
              profileSource: _Profiles(null),
              accountId: account,
              references: repository,
              household: repository,
              refreshSignal: 0,
              onOpenSettings: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      final dropdown = find.byKey(
        PageStorageKey('household.payments.${person.id}'),
      );
      final dropdownTitle = find.descendant(
        of: dropdown,
        matching: find.text('Payment Methods'),
      );
      await tester.scrollUntilVisible(
        dropdownTitle,
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(dropdownTitle);
      await tester.pumpAndSettle();
      final archive = find.byKey(Key('household.archive.${payment.id}'));
      await tester.ensureVisible(archive);
      await tester.pumpAndSettle();
      await tester.tap(archive);
      await tester.pumpAndSettle();
      expect(
        (await repository.listReferences(
          account,
          LocalReferenceKind.paymentMethod,
          includeArchived: true,
        )).single.assignedPersonId,
        person.id,
      );
      final restore = find.byKey(Key('household.unarchive.${payment.id}'));
      await tester.ensureVisible(restore);
      await tester.pumpAndSettle();
      await tester.tap(restore);
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Corner Market'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.textContaining('BRL 12.34'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'Household lists local people and freely archives and restores them',
    (tester) async {
      const account = AccountId('11111111-1111-4111-8111-111111111111');
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final repository = LocalQueryRepository(db);
      final person = await repository.saveReference(
        accountId: account,
        kind: LocalReferenceKind.person,
        nickname: 'Ana',
      );
      var changes = 0;
      await tester.pumpWidget(
        MaterialApp(
          theme: markeiTheme(),
          home: Scaffold(
            body: HouseholdPage(
              profileSource: _Profiles(null),
              accountId: account,
              references: repository,
              household: repository,
              refreshSignal: 0,
              onOpenSettings: () {},
              onChanged: () => changes++,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Ana · @001'), findsOneWidget);
      expect(
        find.text('No purchase recorded for this person on this device.'),
        findsOneWidget,
      );
      final archive = find.byKey(Key('household.archive.${person.id}'));
      await tester.ensureVisible(archive);
      await tester.tap(archive);
      await tester.pumpAndSettle();
      expect(find.text('Archived'), findsOneWidget);
      expect(
        await repository.listReferences(account, LocalReferenceKind.person),
        isEmpty,
      );
      final restore = find.byKey(Key('household.unarchive.${person.id}'));
      await tester.ensureVisible(restore);
      await tester.tap(restore);
      await tester.pumpAndSettle();
      expect(find.text('Active'), findsOneWidget);
      expect(
        (await repository.listReferences(
          account,
          LocalReferenceKind.person,
        )).single.id,
        person.id,
      );
      expect(changes, 2);
      expect(tester.takeException(), isNull);
    },
  );

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
