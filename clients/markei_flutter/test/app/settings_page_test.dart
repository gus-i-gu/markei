import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/pages/settings_page.dart';
import 'package:markei/application/closure_diagnostics.dart';
import 'package:markei/application/local_references.dart';
import 'package:markei/domain/references/local_reference.dart';
import 'package:markei/domain/shared/ids.dart';

void main() {
  const account = AccountId('11111111-1111-4111-8111-111111111111');

  testWidgets(
    'Settings loads persisted threshold and preserves invalid draft',
    (tester) async {
      final references = _MemoryReferences();
      final preferences = _MemoryPreferences(42);
      var changed = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsPage(
              accountId: account,
              references: references,
              preferences: preferences,
              accountSupport: _FakeAccountSupport(),
              syncDeviceSupport: _FakeSyncDeviceSupport(),
              onChanged: () => changed++,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('settings.shortageThreshold')),
        findsOneWidget,
      );
      expect(
        tester
            .widget<TextField>(
              find.byKey(const Key('settings.shortageThreshold')),
            )
            .controller!
            .text,
        '42',
      );

      await tester.enterText(
        find.byKey(const Key('settings.shortageThreshold')),
        '366',
      );
      await _tapVisible(
        tester,
        find.byKey(const Key('settings.saveThreshold')),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('Enter a whole number of days from 0 through 365.'),
        findsWidgets,
      );
      expect(preferences.days, 42);
      expect(changed, 0);

      await tester.enterText(
        find.byKey(const Key('settings.shortageThreshold')),
        '365',
      );
      await _tapVisible(
        tester,
        find.byKey(const Key('settings.saveThreshold')),
      );
      await tester.pumpAndSettle();

      expect(preferences.days, 365);
      expect(changed, 1);
    },
  );

  testWidgets('Settings archive refreshes list and support actions use fakes', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final references = _MemoryReferences()
      ..people.add(
        LocalReference(
          id: 'p1',
          accountId: account,
          kind: LocalReferenceKind.person,
          visibleCode: '@001',
          nickname: 'Ana',
          normalizedNickname: 'ana',
          active: true,
          createdAt: DateTime.utc(2026, 7, 31),
          updatedAt: DateTime.utc(2026, 7, 31),
        ),
      );
    final accountSupport = _FakeAccountSupport();
    final syncSupport = _FakeSyncDeviceSupport();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SettingsPage(
            accountId: account,
            references: references,
            preferences: _MemoryPreferences(5),
            accountSupport: accountSupport,
            syncDeviceSupport: syncSupport,
            onChanged: () {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('Ana'), findsOneWidget);

    await _tapVisible(tester, find.byKey(const Key('settings.archive.p1')));
    await tester.pumpAndSettle();
    expect(find.text('Archived'), findsOneWidget);

    await _tapVisible(tester, find.byKey(const Key('settings.signInToSync')));
    await tester.pumpAndSettle();
    expect(accountSupport.signInCount, 1);
    expect(
      find.textContaining('Local Purchase data is not uploaded'),
      findsOneWidget,
    );

    expect(find.byKey(const Key('settings.advancedSupport')), findsOneWidget);
    await _tapVisible(tester, find.byKey(const Key('settings.connectDevice')));
    await tester.pumpAndSettle();
    expect(syncSupport.connectCount, 1);
    expect(
      find.textContaining('does not prove Sync succeeded'),
      findsOneWidget,
    );
    expect(find.text('Clear diagnostic history'), findsNothing);
    expect(find.textContaining('Retry'), findsNothing);
  });
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
}

final class _MemoryReferences implements LocalReferenceRepository {
  final people = <LocalReference>[];
  final payments = <LocalReference>[];

  @override
  Future<void> archiveReference({
    required AccountId accountId,
    required LocalReferenceKind kind,
    required String id,
  }) async {
    final list = kind == LocalReferenceKind.person ? people : payments;
    final index = list.indexWhere((item) => item.id == id);
    list[index] = LocalReference(
      id: list[index].id,
      accountId: list[index].accountId,
      kind: list[index].kind,
      visibleCode: list[index].visibleCode,
      nickname: list[index].nickname,
      normalizedNickname: list[index].normalizedNickname,
      active: false,
      createdAt: list[index].createdAt,
      updatedAt: DateTime.utc(2026, 7, 31),
      archivedAt: DateTime.utc(2026, 7, 31),
    );
  }

  @override
  Future<List<LocalReference>> listReferences(
    AccountId accountId,
    LocalReferenceKind kind, {
    bool includeArchived = false,
  }) async {
    final list = kind == LocalReferenceKind.person ? people : payments;
    return includeArchived
        ? List.of(list)
        : list.where((item) => item.active).toList();
  }

  @override
  Future<LocalReference> saveReference({
    required AccountId accountId,
    required LocalReferenceKind kind,
    String? id,
    required String nickname,
    bool active = true,
  }) async {
    final list = kind == LocalReferenceKind.person ? people : payments;
    final reference = LocalReference(
      id: id ?? 'ref-${list.length + 1}',
      accountId: accountId,
      kind: kind,
      visibleCode: kind == LocalReferenceKind.person ? '@002' : '#001',
      nickname: nickname.trim(),
      normalizedNickname: nickname.trim().toLowerCase(),
      active: active,
      createdAt: DateTime.utc(2026, 7, 31),
      updatedAt: DateTime.utc(2026, 7, 31),
    );
    list.add(reference);
    return reference;
  }
}

final class _MemoryPreferences implements AccountPreferenceRepository {
  _MemoryPreferences(this.days);

  int days;

  @override
  Future<int> shortageThresholdDays(AccountId accountId) async => days;

  @override
  Future<void> setShortageThresholdDays(AccountId accountId, int days) async {
    this.days = days;
  }
}

final class _FakeAccountSupport implements SettingsAccountSupportPort {
  int signInCount = 0;

  @override
  bool get signInMayContactNetwork => true;

  @override
  bool get signOutMayWriteLocalState => true;

  @override
  Future<SettingsAccountStatus> accountStatus() async => SettingsAccountStatus(
    authenticationState: 'signed-out',
    updatedAtUtc: DateTime.utc(2026, 7, 31),
  );

  @override
  Future<SettingsActionResult> signInToSync() async {
    signInCount++;
    return const SettingsActionResult(
      state: 'signed-out',
      message:
          'Sign in to Sync finished with signed-out. Local Purchase data is not uploaded merely by opening sign-in.',
      contactedNetwork: true,
      mayHaveWritten: false,
    );
  }

  @override
  Future<SettingsActionResult> signOutOnThisDevice() async =>
      const SettingsActionResult(
        state: 'signed-out-cleared',
        message: 'Sign out on this Device finished with signed-out-cleared.',
        contactedNetwork: false,
        mayHaveWritten: true,
      );
}

final class _FakeSyncDeviceSupport implements SettingsSyncDeviceSupportPort {
  int connectCount = 0;

  @override
  bool get connectMayContactNetwork => true;

  @override
  bool get refreshMayContactNetwork => false;

  @override
  bool get syncMayContactNetwork => true;

  @override
  Future<SettingsActionResult> connectThisDevice() async {
    connectCount++;
    return const SettingsActionResult(
      state: 'device-enrolled',
      message:
          'Connect this Device finished with device-enrolled. This does not prove Sync succeeded.',
      contactedNetwork: true,
      mayHaveWritten: true,
    );
  }

  @override
  Future<SettingsSyncDeviceStatus> localStatus() async =>
      SettingsSyncDeviceStatus(
        enrollmentState: 'device-unavailable',
        syncReadiness: 'signed-out',
        lastResult: 'no-recorded-attempts',
        lastSuccessfulSyncAtUtc: null,
        deviceReference: null,
        pending: 0,
        uploading: 0,
        failed: 0,
        unknown: 0,
        updatedAtUtc: DateTime.utc(2026, 7, 31),
      );

  @override
  Future<SettingsActionResult> syncNow() async => const SettingsActionResult(
    state: 'sync-unavailable',
    message:
        'Sync now finished with sync-unavailable. No automatic retry or recovery was started.',
    contactedNetwork: true,
    mayHaveWritten: true,
  );
}
