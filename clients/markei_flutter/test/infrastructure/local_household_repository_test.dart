import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/domain/references/local_reference.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_query_repository.dart';

void main() {
  const account = AccountId('11111111-1111-4111-8111-111111111111');
  const otherAccount = AccountId('22222222-2222-4222-8222-222222222222');

  test(
    'payment assignments are device-local, account-isolated and survive archive and reopen',
    () async {
      final temp = await Directory.systemTemp.createTemp(
        'marc_local_assignment_',
      );
      addTearDown(() => temp.delete(recursive: true));
      final file = File('${temp.path}/marc.sqlite');
      final db = LocalDatabase.file(file);
      final repository = LocalQueryRepository(db);
      final person = await repository.saveReference(
        accountId: account,
        kind: LocalReferenceKind.person,
        nickname: 'Ana',
      );
      final foreign = await repository.saveReference(
        accountId: otherAccount,
        kind: LocalReferenceKind.person,
        nickname: 'Other person',
      );
      final payment = await repository.saveReference(
        accountId: account,
        kind: LocalReferenceKind.paymentMethod,
        nickname: 'Card',
      );
      await expectLater(
        repository.assignPaymentMethod(
          accountId: account,
          paymentMethodId: payment.id,
          personId: foreign.id,
        ),
        throwsStateError,
      );
      await expectLater(
        repository.assignPaymentMethod(
          accountId: otherAccount,
          paymentMethodId: payment.id,
          personId: foreign.id,
        ),
        throwsStateError,
      );
      await repository.assignPaymentMethod(
        accountId: account,
        paymentMethodId: payment.id,
        personId: person.id,
      );
      await repository.archiveReference(
        accountId: account,
        kind: LocalReferenceKind.person,
        id: person.id,
      );
      await expectLater(
        repository.assignPaymentMethod(
          accountId: account,
          paymentMethodId: payment.id,
          personId: person.id,
        ),
        throwsStateError,
      );
      await repository.archiveReference(
        accountId: account,
        kind: LocalReferenceKind.paymentMethod,
        id: payment.id,
      );
      final summary = (await repository.householdPeople(account)).single;
      expect(summary.person.active, isFalse);
      expect(summary.paymentMethods.single.id, payment.id);
      expect(summary.paymentMethods.single.active, isFalse);
      expect(await db.select(db.syncEvents).get(), isEmpty);
      expect(await db.select(db.pendingEvents).get(), isEmpty);
      await db.close();
      final reopened = LocalDatabase.file(file);
      addTearDown(reopened.close);
      final reopenedRepository = LocalQueryRepository(reopened);
      final persisted = (await reopenedRepository.listReferences(
        account,
        LocalReferenceKind.paymentMethod,
        includeArchived: true,
      )).single;
      expect(persisted.assignedPersonId, person.id);
      expect(persisted.active, isFalse);
      await reopenedRepository.assignPaymentMethod(
        accountId: account,
        paymentMethodId: payment.id,
        personId: null,
      );
      expect(
        (await reopenedRepository.householdPeople(
          account,
        )).single.paymentMethods,
        isEmpty,
      );
      expect(await reopened.select(reopened.syncEvents).get(), isEmpty);
    },
  );

  test(
    'v13 to v14 adds nullable assignment without changing prior facts',
    () async {
      final temp = await Directory.systemTemp.createTemp(
        'marc_assignment_upgrade_',
      );
      addTearDown(() => temp.delete(recursive: true));
      final file = File('${temp.path}/marc.sqlite');
      final before = LocalDatabase.file(file);
      final repository = LocalQueryRepository(before);
      final person = await repository.saveReference(
        accountId: account,
        kind: LocalReferenceKind.person,
        nickname: 'Ana',
      );
      final payment = await repository.saveReference(
        accountId: account,
        kind: LocalReferenceKind.paymentMethod,
        nickname: 'Card',
      );
      await repository.archiveReference(
        accountId: account,
        kind: LocalReferenceKind.person,
        id: person.id,
      );
      await before
          .into(before.stores)
          .insert(
            StoresCompanion.insert(
              id: 'store',
              accountId: account.value,
              displayName: 'Market',
              createdAt: DateTime.utc(2026, 10, 1),
            ),
          );
      await before
          .into(before.purchases)
          .insert(
            PurchasesCompanion.insert(
              id: 'existing-purchase',
              accountId: account.value,
              storeId: 'store',
              personId: Value(person.id),
              paymentMethodId: Value(payment.id),
              occurrenceTime: DateTime.utc(2026, 10, 1),
              currencyCode: 'BRL',
              totalMinorUnits: 1234,
              createdAt: DateTime.utc(2026, 10, 1),
            ),
          );
      // The v13 schema differs from v14 only by this additive nullable column.
      await before.customStatement(
        'ALTER TABLE payment_methods DROP COLUMN assigned_person_id',
      );
      await before.customStatement('PRAGMA user_version = 13');
      await before.close();
      final upgraded = LocalDatabase.file(file);
      addTearDown(upgraded.close);
      final queries = LocalQueryRepository(upgraded);
      final existingPerson = (await queries.listReferences(
        account,
        LocalReferenceKind.person,
        includeArchived: true,
      )).single;
      final existingPayment = (await queries.listReferences(
        account,
        LocalReferenceKind.paymentMethod,
      )).single;
      expect(existingPerson.id, person.id);
      expect(existingPerson.visibleCode, person.visibleCode);
      expect(existingPerson.active, isFalse);
      expect(existingPerson.createdAt, person.createdAt);
      expect(existingPayment.id, payment.id);
      expect(existingPayment.assignedPersonId, isNull);
      final purchase = (await upgraded.select(upgraded.purchases).get()).single;
      expect(purchase.personId, person.id);
      expect(purchase.paymentMethodId, payment.id);
      expect(purchase.totalMinorUnits, 1234);
      expect(
        (await queries.householdPeople(
          account,
        )).single.latestPurchase?.purchaseId.value,
        'existing-purchase',
      );
      expect(
        (await upgraded.select(upgraded.migrationLedger).get())
            .last
            .migrationId,
        'v13-to-v14-local-payment-person-assignment',
      );
      expect(
        await upgraded.customSelect('PRAGMA foreign_key_check').get(),
        isEmpty,
      );
      expect(await upgraded.select(upgraded.syncEvents).get(), isEmpty);
      expect(await upgraded.select(upgraded.pendingEvents).get(), isEmpty);
    },
  );

  for (final kind in LocalReferenceKind.values) {
    test(
      '$kind can be restored without replacing its identity or history',
      () async {
        final db = LocalDatabase.memory();
        addTearDown(db.close);
        final repository = LocalQueryRepository(db);
        final original = await repository.saveReference(
          accountId: account,
          kind: kind,
          nickname: 'Ana',
        );
        await repository.archiveReference(
          accountId: account,
          kind: kind,
          id: original.id,
        );
        expect(await repository.listReferences(account, kind), isEmpty);
        final archived = (await repository.listReferences(
          account,
          kind,
          includeArchived: true,
        )).single;
        expect(archived.archivedAt, isNotNull);
        final restored = await repository.saveReference(
          accountId: account,
          kind: kind,
          id: original.id,
          nickname: original.nickname,
        );
        expect(restored.id, original.id);
        expect(restored.visibleCode, original.visibleCode);
        expect(restored.createdAt, original.createdAt);
        expect(restored.active, isTrue);
        expect(restored.archivedAt, isNull);
        expect(await repository.listReferences(account, kind), hasLength(1));
        await expectLater(
          repository.saveReference(
            accountId: otherAccount,
            kind: kind,
            id: original.id,
            nickname: 'Another name',
          ),
          throwsStateError,
        );
        final unchanged = (await repository.listReferences(
          account,
          kind,
        )).single;
        expect(unchanged.nickname, original.nickname);
        expect(await db.select(db.syncEvents).get(), isEmpty);
        expect(await db.select(db.pendingEvents).get(), isEmpty);
      },
    );
  }

  test(
    'Household resolves last registration by Person ID and Account',
    () async {
      final db = LocalDatabase.memory();
      addTearDown(db.close);
      final repository = LocalQueryRepository(db);
      final person = await repository.saveReference(
        accountId: account,
        kind: LocalReferenceKind.person,
        nickname: 'Ana',
      );
      final namesake = await repository.saveReference(
        accountId: account,
        kind: LocalReferenceKind.person,
        nickname: 'Ana',
      );
      final foreignPerson = await repository.saveReference(
        accountId: otherAccount,
        kind: LocalReferenceKind.person,
        nickname: 'Ana',
      );
      for (final entry in [('store-a', account), ('store-b', otherAccount)]) {
        await db
            .into(db.stores)
            .insert(
              StoresCompanion.insert(
                id: entry.$1,
                accountId: entry.$2.value,
                displayName: 'Market',
                createdAt: DateTime.utc(2026, 10, 1),
              ),
            );
      }
      Future<void> purchase(
        String id,
        AccountId owner,
        String? personId,
        DateTime occurred,
        DateTime registered,
      ) => db
          .into(db.purchases)
          .insert(
            PurchasesCompanion.insert(
              id: id,
              accountId: owner.value,
              storeId: owner == account ? 'store-a' : 'store-b',
              personId: Value(personId),
              occurrenceTime: occurred,
              currencyCode: 'BRL',
              totalMinorUnits: 1234,
              createdAt: registered,
            ),
          )
          .then((_) {});
      await purchase(
        'older-registration',
        account,
        person.id,
        DateTime.utc(2026, 10, 5),
        DateTime.utc(2026, 10, 1),
      );
      await purchase(
        'latest-registration',
        account,
        person.id,
        DateTime.utc(2026, 9, 1),
        DateTime.utc(2026, 10, 2),
      );
      await purchase(
        'unassigned',
        account,
        null,
        DateTime.utc(2026, 10, 5),
        DateTime.utc(2026, 10, 3),
      );
      await purchase(
        'another-account',
        otherAccount,
        foreignPerson.id,
        DateTime.utc(2026, 10, 5),
        DateTime.utc(2026, 10, 4),
      );
      await repository.archiveReference(
        accountId: account,
        kind: LocalReferenceKind.person,
        id: person.id,
      );
      final summaries = await repository.householdPeople(account);
      expect(summaries, hasLength(2));
      final summary = summaries.singleWhere(
        (item) => item.person.id == person.id,
      );
      expect(summary.person.active, isFalse);
      expect(summary.latestPurchase?.purchaseId.value, 'latest-registration');
      expect(summary.latestPurchase?.storeName, 'Market');
      expect(
        summaries
            .singleWhere((item) => item.person.id == namesake.id)
            .latestPurchase,
        isNull,
      );
      final foreign = await repository.householdPeople(otherAccount);
      expect(
        foreign.single.latestPurchase?.purchaseId.value,
        'another-account',
      );
    },
  );
}
