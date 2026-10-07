import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/widgets/user_data_settings.dart';
import 'package:markei/application/content_sharing.dart';
import 'package:markei/application/export_destination.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/application/sync_privacy.dart';
import 'package:markei/application/user_data_access.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_user_data_access.dart';

const _account = AccountId('privacy-account-a');
const _foreignAccount = AccountId('privacy-account-b');

void main() {
  testWidgets(
    'opening controls reads inventory and preference without disclosure actions',
    (tester) async {
      final harness = await _Harness.create();
      addTearDown(harness.close);
      await _open(tester, harness);
      expect(harness.data.inventoryCalls, 1);
      expect(harness.privacy.readCalls, 1);
      expect(harness.data.exportCalls, 0);
      expect(harness.destination.requests, isEmpty);
      expect(harness.sharing.requests, isEmpty);
      expect(harness.profile.calls, 0);
      expect(harness.privacy.preferenceWrites, isEmpty);
      expect(harness.privacy.providerActions, 0);
      expect(harness.busyChanges, isEmpty);
      expect(find.textContaining('Stored local records:'), findsOneWidget);
    },
    variant: const TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets(
    'cancelling export confirmation reads no export and writes no file',
    (tester) async {
      final harness = await _Harness.create();
      addTearDown(harness.close);
      await _open(tester, harness);
      await _tap(tester, find.byKey(const Key('privacy.export')));
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.textContaining('not a restore file'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(harness.data.exportCalls, 0);
      expect(harness.destination.requests, isEmpty);
      expect(harness.sharing.requests, isEmpty);
      expect(await harness.db.select(harness.db.purchases).get(), hasLength(2));
    },
    variant: const TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets(
    'explicit save produces scoped JSON through the destination port',
    (tester) async {
      final harness = await _Harness.create();
      addTearDown(harness.close);
      await _open(tester, harness);
      await _tap(tester, find.byKey(const Key('privacy.export')));
      final confirm = find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('Save JSON'),
      );
      await tester.tap(confirm);
      await tester.pumpAndSettle();
      expect(harness.data.exportCalls, 1);
      expect(harness.destination.requests, hasLength(1));
      expect(harness.sharing.requests, isEmpty);
      final request = harness.destination.requests.single;
      expect(request.extension, 'json');
      expect(request.mediaType, 'application/json');
      final document =
          jsonDecode(utf8.decode(request.bytes)) as Map<String, dynamic>;
      expect(document['account_id'], _account.value);
      expect(document['format'], 'marc-local-account-access');
      expect(document['datasets']['purchases'], hasLength(1));
      expect(
        utf8.decode(request.bytes),
        isNot(contains(_foreignAccount.value)),
      );
      expect(
        find.textContaining('Exported JSON to Downloads:'),
        findsOneWidget,
      );
      expect(harness.busyChanges, [true, false]);
      expect(
        await harness.db.select(harness.db.pendingEvents).get(),
        hasLength(2),
      );
    },
    variant: const TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets(
    'Android sharing uses JSON file handoff without claiming delivery',
    (tester) async {
      final harness = await _Harness.create();
      addTearDown(harness.close);
      await _open(tester, harness);
      expect(find.byKey(const Key('privacy.export')), findsNothing);
      await _tap(tester, find.byKey(const Key('privacy.shareExport')));
      await tester.tap(find.text('Choose an app'));
      await tester.pumpAndSettle();
      expect(harness.destination.requests, isEmpty);
      expect(harness.sharing.requests, hasLength(1));
      final request = harness.sharing.requests.single;
      expect(request.text, isNull);
      expect(request.file!.extension, 'json');
      expect(request.file!.mediaType, 'application/json');
      expect(
        jsonDecode(utf8.decode(request.file!.bytes))['account_id'],
        _account.value,
      );
      expect(
        find.text(
          'Content handed to the selected app. Delivery is not confirmed by Marc.',
        ),
        findsOneWidget,
      );
      expect(find.textContaining('temporary copy'), findsOneWidget);
    },
    variant: const TargetPlatformVariant({TargetPlatform.android}),
  );

  testWidgets(
    'pause persists across remount, blocks provider callbacks, resume only changes preference',
    (tester) async {
      final harness = await _Harness.create();
      addTearDown(harness.close);
      await _open(tester, harness);
      await _tap(tester, find.byKey(const Key('privacy.pauseSync')));
      expect(harness.privacy.paused, true);
      expect(harness.privacy.preferenceWrites, [true]);
      expect(harness.privacy.providerActions, 0);
      final gated = await harness.privacy.runWhenAllowed(
        () async => 'called',
        () => 'blocked',
      );
      expect(gated, 'blocked');
      expect(harness.privacy.providerActions, 0);
      await tester.pumpWidget(const SizedBox());
      await _open(tester, harness);
      expect(
        tester
            .widget<SwitchListTile>(find.byKey(const Key('privacy.pauseSync')))
            .value,
        true,
      );
      expect(harness.privacy.preferenceWrites, [true]);
      await _tap(tester, find.byKey(const Key('privacy.pauseSync')));
      expect(find.text('Resume Sync on this Device?'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(harness.privacy.paused, true);
      await _tap(tester, find.byKey(const Key('privacy.pauseSync')));
      await tester.tap(find.text('Resume Sync'));
      await tester.pumpAndSettle();
      expect(harness.privacy.paused, false);
      expect(harness.privacy.preferenceWrites, [true, false]);
      expect(harness.privacy.providerActions, 0);
      expect(harness.data.exportCalls, 0);
      expect(
        find.textContaining('Use Sync now when you want to transfer data.'),
        findsOneWidget,
      );
    },
    variant: const TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets(
    'diagnostic cancellation preserves all data; confirmation clears only this Account',
    (tester) async {
      final harness = await _Harness.create();
      addTearDown(harness.close);
      await _open(tester, harness);
      await _tap(tester, find.byKey(const Key('privacy.clearDiagnostics')));
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(harness.data.clearCalls, 0);
      expect(
        await harness.db.select(harness.db.syncDiagnosticEvents).get(),
        hasLength(2),
      );
      await _tap(tester, find.byKey(const Key('privacy.clearDiagnostics')));
      await tester.tap(find.text('Clear history'));
      await tester.pumpAndSettle();
      expect(harness.data.clearCalls, 1);
      expect(harness.clearedNotifications, 1);
      final attempts = await harness.db.select(harness.db.syncAttempts).get();
      expect(attempts.single.accountId, _foreignAccount.value);
      expect(
        await harness.db.select(harness.db.syncDiagnosticEvents).get(),
        hasLength(1),
      );
      expect(await harness.db.select(harness.db.purchases).get(), hasLength(2));
      expect(
        await harness.db.select(harness.db.pendingEvents).get(),
        hasLength(2),
      );
      expect(await harness.db.select(harness.db.devices).get(), hasLength(2));
      expect(harness.destination.requests, isEmpty);
      expect(harness.privacy.providerActions, 0);
      expect(
        find.textContaining('Your purchases and queued work were preserved.'),
        findsOneWidget,
      );
    },
    variant: const TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets(
    'privacy request uses optional user email and copies a local unsubmitted draft',
    (tester) async {
      final harness = await _Harness.create();
      addTearDown(harness.close);
      String? clipboard;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (call) async {
            if (call.method == 'Clipboard.setData') {
              clipboard = (call.arguments as Map)['text'] as String;
            }
            return null;
          });
      addTearDown(
        () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(SystemChannels.platform, null),
      );
      await _open(tester, harness);
      expect(harness.profile.calls, 0);
      await _tap(tester, find.byKey(const Key('privacy.request')));
      expect(harness.profile.calls, 1);
      expect(find.textContaining('Never include a password'), findsOneWidget);
      expect(
        tester
            .widget<TextField>(find.byKey(const Key('privacy.requestEmail')))
            .controller!
            .text,
        'owner@example.invalid',
      );
      await tester.enterText(find.byKey(const Key('privacy.requestEmail')), '');
      await tester.enterText(
        find.byKey(const Key('privacy.requestDetails')),
        'Please explain which hosted purchase records belong to me.',
      );
      await tester.tap(find.byKey(const Key('privacy.copyRequest')));
      await tester.pumpAndSettle();
      expect(clipboard, contains('draft, not submitted'));
      expect(clipboard, contains('Contact email supplied by requester: \n'));
      expect(clipboard, contains('Local Account reference: ${_account.value}'));
      expect(clipboard, contains('Please confirm the request scope'));
      expect(clipboard, contains('not proof of identity or Account ownership'));
      expect(clipboard, isNot(contains('owner@example.invalid')));
      expect(clipboard, isNot(contains('access-token-secret')));
      expect(find.textContaining('No request has been sent.'), findsOneWidget);
      expect(harness.data.exportCalls, 0);
      expect(harness.data.clearCalls, 0);
      expect(harness.destination.requests, isEmpty);
      expect(harness.sharing.requests, isEmpty);
      expect(harness.privacy.providerActions, 0);
    },
    variant: const TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets(
    'pending export locks competing actions and failure confirms no completion',
    (tester) async {
      final harness = await _Harness.create();
      addTearDown(harness.close);
      final pending = Completer<UserDataExport>();
      harness.data.pendingExport = pending;
      await _open(tester, harness);
      await _tap(tester, find.byKey(const Key('privacy.export')));
      await tester.tap(
        find.descendant(
          of: find.byType(AlertDialog),
          matching: find.text('Save JSON'),
        ),
      );
      await tester.pump();
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(
        tester
            .widget<OutlinedButton>(
              find.byKey(const Key('privacy.shareExport')),
            )
            .onPressed,
        isNull,
      );
      expect(
        tester
            .widget<SwitchListTile>(find.byKey(const Key('privacy.pauseSync')))
            .onChanged,
        isNull,
      );
      pending.completeError(StateError('access-token-secret'));
      await tester.pumpAndSettle();
      expect(find.byType(LinearProgressIndicator), findsNothing);
      expect(
        find.text(
          'This data action could not be completed. No completion is confirmed.',
        ),
        findsOneWidget,
      );
      expect(find.textContaining('access-token-secret'), findsNothing);
      expect(harness.destination.requests, isEmpty);
      expect(harness.busyChanges, [true, false]);
    },
    variant: const TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets(
    'unavailable inventory and pause reads produce truthful feedback',
    (tester) async {
      final harness = await _Harness.create();
      addTearDown(harness.close);
      harness.data.failInventory = true;
      await _open(tester, harness);
      expect(
        find.text('Local data controls could not be loaded.'),
        findsOneWidget,
      );
      expect(
        tester
            .widget<SwitchListTile>(find.byKey(const Key('privacy.pauseSync')))
            .value,
        false,
      );
      expect(
        find.textContaining('Allowed when you explicitly connect or Sync.'),
        findsOneWidget,
      );
      expect(harness.data.exportCalls, 0);
      expect(harness.profile.calls, 0);
      expect(harness.privacy.providerActions, 0);
      await tester.pumpWidget(const SizedBox());
      harness.data.failInventory = false;
      harness.privacy.failRead = true;
      await _open(tester, harness);
      expect(
        tester
            .widget<SwitchListTile>(find.byKey(const Key('privacy.pauseSync')))
            .value,
        true,
      );
      expect(find.textContaining('Transfers are blocked'), findsOneWidget);
      expect(find.textContaining('private policy exception'), findsNothing);
    },
    variant: const TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets(
    '320px layout scrolls all controls without a render overflow',
    (tester) async {
      final harness = await _Harness.create();
      addTearDown(harness.close);
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await _open(tester, harness);
      expect(tester.takeException(), isNull);
      await _tap(tester, find.byKey(const Key('privacy.documentation')));
      expect(harness.documentationCalls, 1);
      expect(tester.takeException(), isNull);
      await _tap(tester, find.byKey(const Key('privacy.request')));
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Close'));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(harness.data.exportCalls, 0);
      expect(harness.sharing.requests, isEmpty);
    },
    variant: const TargetPlatformVariant({TargetPlatform.android}),
  );
}

Future<void> _open(WidgetTester tester, _Harness harness) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: UserDataSettings(
              accountId: _account,
              dataAccess: harness.data,
              syncPrivacy: harness.privacy,
              exportDestination: harness.destination,
              contentSharing: harness.sharing,
              profileSource: harness.profile,
              onDocumentation: () => harness.documentationCalls++,
              onBusyChanged: harness.busyChanges.add,
              onDiagnosticsCleared: () => harness.clearedNotifications++,
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

class _Harness {
  _Harness(this.db) : data = _CountingData(LocalUserDataAccessRepository(db));
  final LocalDatabase db;
  final _CountingData data;
  final privacy = _PrivacyPolicy();
  final destination = _Destination();
  final sharing = _Sharing();
  final profile = _Profile();
  final busyChanges = <bool>[];
  int documentationCalls = 0;
  int clearedNotifications = 0;

  static Future<_Harness> create() async {
    final db = LocalDatabase.memory();
    for (var suffix = 0; suffix < 2; suffix++) {
      final account = suffix == 0 ? _account.value : _foreignAccount.value;
      const stamp = 1790866800;
      Future<void> insert(
        String table,
        Map<String, Object?> values,
      ) => db.customStatement(
        'INSERT INTO $table (${values.keys.join(',')}) VALUES (${List.filled(values.length, '?').join(',')})',
        values.values.toList(),
      );
      await insert('local_accounts', {
        'id': account,
        'default_currency_code': 'BRL',
        'created_at': stamp,
      });
      await insert('devices', {
        'id': 'device-$suffix',
        'account_id': account,
        'next_sequence': 2,
        'created_at': stamp,
      });
      await insert('stores', {
        'id': 'store-$suffix',
        'account_id': account,
        'display_name': 'Market',
        'created_at': stamp,
      });
      await insert('purchases', {
        'id': 'purchase-$suffix',
        'account_id': account,
        'store_id': 'store-$suffix',
        'occurrence_time': stamp,
        'currency_code': 'BRL',
        'total_minor_units': 1200,
        'created_at': stamp,
      });
      await insert('sync_events', {
        'id': 'event-$suffix',
        'account_id': account,
        'device_id': 'device-$suffix',
        'device_sequence': 1,
        'event_type': 'purchase.recorded',
        'payload_version': 3,
        'occurrence_time': stamp,
        'payload_json': '{}',
        'content_hash': 'hash-$suffix',
        'created_at': stamp,
      });
      await insert('pending_events', {
        'event_id': 'event-$suffix',
        'state': 'pending',
        'enqueued_at': stamp,
      });
      await insert('sync_attempts', {
        'id': suffix + 1,
        'account_id': account,
        'environment_alias': 'test',
        'started_at': stamp,
        'phase': 'finished',
        'result_code': 'sync-completed',
        'outcome_class': 'applied',
      });
      await insert('sync_diagnostic_events', {
        'attempt_id': suffix + 1,
        'ordinal': 1,
        'code': 'MKS-SYNC-001',
        'severity': 'info',
        'outcome': 'success',
        'operation_kind': 'sync',
        'phase': 'finished',
        'local_mutation_state': 'applied',
        'provider_contact_state': 'contacted',
        'provider_transaction_state': 'committed',
        'trusted_response_state': 'trusted',
        'safe_action': 'None',
        'recorded_at': stamp,
      });
    }
    return _Harness(db);
  }

  Future<void> close() => db.close();
}

class _CountingData implements UserDataAccessRepository {
  _CountingData(this.delegate);
  final UserDataAccessRepository delegate;
  int inventoryCalls = 0;
  int exportCalls = 0;
  int clearCalls = 0;
  bool failInventory = false;
  Completer<UserDataExport>? pendingExport;

  @override
  Future<UserDataInventory> inventory(AccountId accountId) {
    inventoryCalls++;
    if (failInventory) throw StateError('private inventory exception');
    return delegate.inventory(accountId);
  }

  @override
  Future<UserDataExport> exportAccountData(AccountId accountId) {
    exportCalls++;
    return pendingExport?.future ?? delegate.exportAccountData(accountId);
  }

  @override
  Future<LocalDiagnosticsClearResult> clearLocalDiagnostics(
    AccountId accountId,
  ) {
    clearCalls++;
    return delegate.clearLocalDiagnostics(accountId);
  }
}

class _PrivacyPolicy implements SyncPrivacyPolicy {
  bool paused = false;
  bool failRead = false;
  int readCalls = 0;
  int providerActions = 0;
  final preferenceWrites = <bool>[];
  @override
  Future<bool> readPaused() async {
    readCalls++;
    if (failRead) throw StateError('private policy exception');
    return paused;
  }

  @override
  Future<void> setPaused(bool value) async {
    preferenceWrites.add(value);
    paused = value;
  }

  @override
  Future<T> runWhenAllowed<T>(
    Future<T> Function() action,
    T Function() blocked,
  ) async {
    if (paused) return blocked();
    providerActions++;
    return action();
  }
}

class _Destination implements ExportDestinationPort {
  final requests = <ExportDestinationRequest>[];
  @override
  Future<ExportDestinationResult> write(
    ExportDestinationRequest request,
  ) async {
    requests.add(request);
    return ExportDestinationSuccess(
      destinationLabel: 'Downloads',
      path: 'Downloads/local-data.json',
      bytesWritten: request.bytes.length,
    );
  }
}

class _Sharing implements ContentSharingPort {
  final requests = <ContentShareRequest>[];
  @override
  Future<ContentShareResult> share(ContentShareRequest request) async {
    requests.add(request);
    return ContentShareResult.handedOff;
  }
}

class _Profile implements AuthenticatedUserProfileSource {
  int calls = 0;
  @override
  Future<AuthenticatedUserProfile?> currentProfile() async {
    calls++;
    return const AuthenticatedUserProfile(
      name: 'Owner',
      email: 'owner@example.invalid',
    );
  }
}
