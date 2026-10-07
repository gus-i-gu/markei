import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:markei/app/native_auth_closure_runner.dart';
import 'package:markei/application/closure_diagnostics.dart';
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/application/hosted_connection_check.dart';
import 'package:markei/application/hosted_enrollment_coordinator.dart';
import 'package:markei/application/hosted_sync_coordinator.dart';
import 'package:markei/application/failed_not_applied_recovery_coordinator.dart';
import 'package:markei/application/stable_device_enrollment_command_factory.dart';
import 'package:markei/application/sync/sync_ports.dart';
import 'package:markei/application/sync/sync_use_cases.dart';
import 'package:markei/application/sync_privacy.dart';
import 'package:markei/domain/sync/sync_event.dart';
import 'package:markei/infrastructure/auth/auth0_native_authentication.dart';
import 'package:markei/infrastructure/auth/native_auth_config.dart';
import 'package:markei/infrastructure/local/hosted_identity_repository.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/platform/file_sync_privacy.dart';

void main() {
  group('native runner Sync privacy boundary', () {
    late Directory directory;
    late File preference;

    setUp(() async {
      directory = await Directory.systemTemp.createTemp('marc-runner-privacy-');
      preference = File('${directory.path}/marc-privacy.json');
    });
    tearDown(() => directory.delete(recursive: true));

    test(
      'pause blocks every provider action before callbacks or queue writes',
      () async {
        final policy = FileSyncPrivacyPolicy.atFile(preference);
        await policy.setPaused(true);
        final fixture = _PrivacyRunnerFixture(policy);
        expect((await fixture.runner.signIn()).state, 'authenticated');
        for (final action in [
          fixture.runner.enrollOrQueryDevice,
          fixture.runner.queryEnrollment,
          fixture.runner.hostedSyncProbe,
          fixture.runner.checkHostedConnection,
          fixture.runner.retryUnresolvedSubmission,
        ]) {
          expect((await action()).state, 'sync-paused');
        }
        final recovery = await fixture.runner.recoverFailedNotAppliedCandidate(
          _privacyRecoveryInspection,
        );
        expect(recovery.state, 'sync-paused');
        expect(recovery.diagnosticCode, 'MKS-PRV-001');
        expect(recovery.operationFingerprint, 'not-started');
        fixture.expectNoProviderOrQueueActivity();

        // These surfaces inspect only local state and remain available paused.
        await fixture.runner.status();
        await fixture.runner.unknownRetryPreflight();
        await fixture.runner.inspectFailedNotAppliedRecovery();
        await fixture.runner.diagnostics();
        await fixture.runner.clearDiagnosticHistory();
        expect(fixture.diagnostics.preflightCalls, 1);
        expect(fixture.diagnostics.inspectionCalls, 1);
        expect(fixture.diagnostics.snapshotCalls, 1);
        expect((await fixture.runner.logout()).state, 'signed-out-cleared');
        expect(fixture.authClient.loginAudiences, hasLength(1));
        expect(fixture.authClient.logoutCount, 1);
        expect(await policy.readPaused(), isTrue);
      },
    );

    test(
      'malformed preference returns safe unavailable statuses and leaves queues alone',
      () async {
        await preference.writeAsString('{"syncPaused":"not-a-boolean"}');
        final fixture = _PrivacyRunnerFixture(
          FileSyncPrivacyPolicy.atFile(preference),
        );
        for (final action in [
          fixture.runner.enrollOrQueryDevice,
          fixture.runner.queryEnrollment,
          fixture.runner.hostedSyncProbe,
          fixture.runner.checkHostedConnection,
          fixture.runner.retryUnresolvedSubmission,
        ]) {
          expect((await action()).state, 'sync-choice-unavailable');
        }
        final recovery = await fixture.runner.recoverFailedNotAppliedCandidate(
          _privacyRecoveryInspection,
        );
        expect(recovery.state, 'sync-choice-unavailable');
        expect(recovery.diagnosticCode, 'MKS-PRV-002');
        fixture.expectNoProviderOrQueueActivity();
        expect((await fixture.runner.signIn()).state, 'authenticated');
        expect((await fixture.runner.logout()).state, 'signed-out-cleared');
      },
    );

    test(
      'pause waits for a live provider check and rejects an already queued Sync',
      () async {
        final policy = FileSyncPrivacyPolicy.atFile(preference);
        final check = _BlockingPrivacyConnectionCheck();
        final fixture = _PrivacyRunnerFixture(policy, hostedCheck: check);
        final active = fixture.runner.checkHostedConnection();
        await check.started.future;
        final queuedSync = fixture.runner.hostedSyncProbe();
        var pauseCompleted = false;
        final pause = policy.setPaused(true).then((_) {
          pauseCompleted = true;
        });
        expect(
          (await fixture.runner.enrollOrQueryDevice()).state,
          'sync-paused',
        );
        expect(pauseCompleted, isFalse);
        expect(fixture.commandCalls, 0);
        expect(fixture.outbox.leaseCount, 0);
        check.release.complete();
        expect((await active).state, 'hosted-connection-ready');
        expect((await queuedSync).state, 'sync-paused');
        await pause;
        expect(check.calls, 1);
        expect(fixture.outbox.leaseCount, 0);
        expect(fixture.transport.downloadCount, 0);
        expect(fixture.transport.acknowledgeCount, 0);
        expect(await policy.readPaused(), isTrue);
      },
    );

    test(
      'explicit resume restores manual Sync and retry without re-entering its gate',
      () async {
        final policy = FileSyncPrivacyPolicy.atFile(preference);
        await policy.setPaused(true);
        final fixture = _PrivacyRunnerFixture(policy);
        await fixture.runner.signIn();
        await policy.setPaused(false);
        expect(
          (await fixture.runner.enrollOrQueryDevice()).state,
          'hosted-restart-required',
        );
        expect(fixture.commandCalls, 1);
        expect(fixture.enrollment.enrollCount, 1);
        fixture.diagnostics.retryEligible = true;
        expect(
          (await fixture.runner.retryUnresolvedSubmission().timeout(
            const Duration(seconds: 5),
          )).state,
          'sync-completed',
        );
        expect(fixture.outbox.leaseCount, 1);
        expect(fixture.transport.downloadCount, 1);
        expect(fixture.transport.acknowledgeCount, 1);
        expect(fixture.diagnostics.attemptCalls, greaterThan(0));
      },
    );
  });
  test(
    'signed-in profile is memory-only and cleared by logout or expiry',
    () async {
      var now = DateTime.utc(2026, 7, 18, 12);
      final auth = _auth(
        _FakeNativeAuth0Client(
          credentials: NativeAuthCredentials(
            accessToken: 'synthetic-api-token',
            idToken: 'synthetic-id-token',
            expiresAt: DateTime.utc(2026, 7, 18, 13),
            name: 'Alex',
            email: 'alex@example.invalid',
          ),
        ),
        now: () => now,
      );
      expect(await auth.currentProfile(), isNull);
      await auth.signIn();
      expect((await auth.currentProfile())?.email, 'alex@example.invalid');
      await auth.logout();
      expect(await auth.currentProfile(), isNull);
      await auth.signIn();
      now = DateTime.utc(2026, 7, 18, 14);
      expect(await auth.currentProfile(), isNull);
    },
  );
  group('native auth configuration', () {
    test('accepts valid Android and Windows configuration', () {
      final android = NativeAuthConfiguration.validate(
        domain: 'tenant.example.auth0.com',
        clientId: 'android-public-client',
        audience: 'https://api.example.invalid',
        hostedOrigin: 'https://hosted.example.invalid',
        platform: NativeAuthPlatform.android,
      );
      final windows = NativeAuthConfiguration.validate(
        domain: 'tenant.example.auth0.com',
        clientId: 'windows-public-client',
        audience: 'https://api.example.invalid',
        hostedOrigin: 'https://hosted.example.invalid',
        platform: NativeAuthPlatform.windows,
      );

      expect(android, isA<NativeAuthConfigurationReady>());
      expect(windows, isA<NativeAuthConfigurationReady>());
      expect(
        (android as NativeAuthConfigurationReady)
            .configuration
            .androidCallbackUrl,
        'https://tenant.example.auth0.com/android/com.gusigu.markei/callback',
      );
      expect(
        (windows as NativeAuthConfigurationReady).configuration.windowsCallback,
        'auth0flutter://callback',
      );
    });

    test('fails closed when configuration is missing or malformed', () {
      final cases = [
        NativeAuthConfiguration.validate(
          domain: '',
          clientId: 'client',
          audience: 'https://api.example.invalid',
          hostedOrigin: 'https://hosted.example.invalid',
          platform: NativeAuthPlatform.android,
        ),
        NativeAuthConfiguration.validate(
          domain: 'https://tenant.example.auth0.com',
          clientId: 'client',
          audience: 'https://api.example.invalid',
          hostedOrigin: 'https://hosted.example.invalid',
          platform: NativeAuthPlatform.android,
        ),
        NativeAuthConfiguration.validate(
          domain: 'tenant.example.auth0.com',
          clientId: '',
          audience: 'https://api.example.invalid',
          hostedOrigin: 'https://hosted.example.invalid',
          platform: NativeAuthPlatform.android,
        ),
        NativeAuthConfiguration.validate(
          domain: 'tenant.example.auth0.com',
          clientId: 'client',
          audience: 'not-https',
          hostedOrigin: 'https://hosted.example.invalid',
          platform: NativeAuthPlatform.android,
        ),
        NativeAuthConfiguration.validate(
          domain: 'tenant.example.auth0.com',
          clientId: 'client',
          audience: 'https://api.example.invalid',
          hostedOrigin: 'http://hosted.example.invalid',
          platform: NativeAuthPlatform.android,
        ),
      ];

      expect(cases, everyElement(isA<NativeAuthConfigurationUnavailable>()));
    });

    test('compile-time loader selects platform-specific client IDs', () {
      final android =
          NativeAuthConfiguration.fromEnvironment(
                targetPlatform: TargetPlatform.android,
                domain: 'tenant.example.auth0.com',
                androidClientId: 'android-client',
                windowsClientId: 'windows-client',
                audience: 'https://api.example.invalid',
                hostedOrigin: 'https://hosted.example.invalid',
              )
              as NativeAuthConfigurationReady;
      final windows =
          NativeAuthConfiguration.fromEnvironment(
                targetPlatform: TargetPlatform.windows,
                domain: 'tenant.example.auth0.com',
                androidClientId: 'android-client',
                windowsClientId: 'windows-client',
                audience: 'https://api.example.invalid',
                hostedOrigin: 'https://hosted.example.invalid',
              )
              as NativeAuthConfigurationReady;

      expect(android.configuration.clientId, 'android-client');
      expect(windows.configuration.clientId, 'windows-client');
    });
  });

  group('native Auth0 adapter', () {
    test(
      'requests the exact API audience and returns only access token',
      () async {
        final client = _FakeNativeAuth0Client(
          credentials: _credentials(
            accessToken: 'api-token',
            idToken: 'id-token',
          ),
        );
        final auth = _auth(client);

        expect(await auth.signIn(), isA<SignedIn>());
        expect(client.loginAudiences, ['https://api.example.invalid']);
        expect((await auth.accessToken()).accessToken, 'api-token');
      },
    );

    test('rejects ID token substitution as an API credential', () async {
      final auth = _auth(
        _FakeNativeAuth0Client(
          credentials: _credentials(
            accessToken: 'same-token',
            idToken: 'same-token',
          ),
        ),
      );

      expect(await auth.signIn(), isA<AuthenticationRejected>());
      expect((await auth.accessToken()).errorCode, 'signed-out');
    });

    test('accepts only non-empty distinct unexpired SDK credentials', () async {
      final valid = _auth(
        _FakeNativeAuth0Client(
          credentials: _credentials(
            accessToken: 'api-token',
            idToken: 'id-token',
          ),
        ),
      );
      expect(await valid.signIn(), isA<SignedIn>());
      expect((await valid.accessToken()).accessToken, 'api-token');

      final missingAccess = await _auth(
        _FakeNativeAuth0Client(
          credentials: _credentials(accessToken: '', idToken: 'id-token'),
        ),
      ).signIn();
      expect(
        (missingAccess as AuthenticationRejected).code,
        'access-token-missing',
      );

      final missingId = await _auth(
        _FakeNativeAuth0Client(
          credentials: _credentials(accessToken: 'api-token', idToken: ''),
        ),
      ).signIn();
      expect((missingId as AuthenticationRejected).code, 'id-token-missing');

      final confused = await _auth(
        _FakeNativeAuth0Client(
          credentials: _credentials(
            accessToken: 'same-token',
            idToken: 'same-token',
          ),
        ),
      ).signIn();
      expect(
        (confused as AuthenticationRejected).code,
        'token-confusion-rejected',
      );

      final expired = await _auth(
        _FakeNativeAuth0Client(
          credentials: _credentials(
            accessToken: 'api-token',
            idToken: 'id-token',
            expiresAt: DateTime.utc(2026, 7, 18, 12),
          ),
        ),
        now: () => DateTime.utc(2026, 7, 18, 12, 1),
      ).signIn();
      expect(expired, isA<TokenExpired>());
    });

    test('maps cancellation, rejection, outage, expiry and logout', () async {
      expect(
        await _auth(_FakeNativeAuth0Client(cancel: true)).signIn(),
        isA<SignInCancelled>(),
      );
      expect(
        await _auth(
          _FakeNativeAuth0Client(rejectCode: 'access-denied'),
        ).signIn(),
        isA<AuthenticationRejected>(),
      );
      expect(
        await _auth(_FakeNativeAuth0Client(unavailable: true)).signIn(),
        isA<ProviderUnavailable>(),
      );

      final expired = _auth(
        _FakeNativeAuth0Client(
          credentials: _credentials(
            accessToken: 'api-token',
            idToken: 'id-token',
            expiresAt: DateTime.utc(2026, 7, 18, 12),
          ),
        ),
        now: () => DateTime.utc(2026, 7, 18, 12, 1),
      );
      expect(await expired.signIn(), isA<TokenExpired>());

      final client = _FakeNativeAuth0Client(
        credentials: _credentials(
          accessToken: 'api-token',
          idToken: 'id-token',
        ),
      );
      final auth = _auth(client);
      await auth.signIn();
      await auth.logout();
      expect(client.logoutCount, 1);
      expect(await auth.currentState(), isA<SignedOut>());
    });

    test(
      'maps provider exceptions through a closed diagnostic allowlist',
      () async {
        final cases = {
          'timeout': 'callback-not-received',
          'state_mismatch': 'callback-state-rejected',
          'invalid_callback': 'callback-state-rejected',
          'invalid_grant': 'authorization-code-exchange-rejected',
          'access_denied': 'authorization-code-exchange-rejected',
          'server_error': 'provider-unavailable',
          'authorization-code-with-secret': 'authentication-rejected-unknown',
          'https://tenant.example.auth0.com/callback?code=secret&state=secret':
              'authentication-rejected-unknown',
        };

        for (final entry in cases.entries) {
          final state = await _auth(
            _FakeNativeAuth0Client(rejectCode: entry.key),
          ).signIn();
          expect(
            (state as AuthenticationRejected).code,
            entry.value,
            reason: entry.key,
          );
        }
      },
    );

    test('cold restart cannot recover in-memory credentials', () async {
      final first = _auth(
        _FakeNativeAuth0Client(
          credentials: _credentials(
            accessToken: 'api-token',
            idToken: 'id-token',
          ),
        ),
      );
      await first.signIn();
      expect((await first.accessToken()).accessToken, 'api-token');

      final restarted = _auth(_FakeNativeAuth0Client());
      expect(await restarted.currentState(), isA<SignedOut>());
      expect((await restarted.accessToken()).errorCode, 'signed-out');
    });
  });

  test('token is absent from Drift bytes and retained diagnostics', () async {
    final directory = await Directory.systemTemp.createTemp(
      'markei-native-auth-',
    );
    addTearDown(() => directory.delete(recursive: true));
    final dbFile = File('${directory.path}/markei.sqlite');
    final db = LocalDatabase.file(dbFile);
    addTearDown(db.close);
    final token = 'native-proof-token-secret';
    final auth = _auth(
      _FakeNativeAuth0Client(
        credentials: _credentials(accessToken: token, idToken: 'id-token'),
      ),
    );

    await auth.signIn();
    final repository = DriftHostedIdentityRepository(db);
    await repository.save(
      HostedIdentityState(
        environmentAlias: 'native',
        installationId: '33333333-3333-4333-8333-333333333333',
        enrollmentState: 'signed-out',
        updatedAt: DateTime.utc(2026, 7, 18),
      ),
    );

    await db.close();
    expect(
      _containsBytes(await dbFile.readAsBytes(), token.codeUnits),
      isFalse,
    );
    expect((await auth.accessToken()).toString().contains(token), isFalse);
  });

  test('closure runner exposes semantic state only', () async {
    final runner = NativeAuthClosureRunner(
      authenticationSession: LabAuthenticationSession(),
      enrollmentCoordinator: HostedEnrollmentCoordinator(
        authenticationSession: LabAuthenticationSession(),
        tokenSource: LabAccessTokenSource.accepted('synthetic-token'),
        transport: _FakeEnrollmentTransport(
          result: const DeviceEnrollmentResult(
            status: 'device-enrolled',
            installationId: '33333333-3333-4333-8333-333333333333',
            deviceId: '22222222-2222-4222-8222-222222222222',
            accountId: '11111111-1111-4111-8111-111111111111',
            generation: 1,
          ),
        ),
        repository: _MemoryHostedIdentityRepository(),
        now: () => DateTime.utc(2026, 7, 18),
      ),
      environmentAlias: 'native',
      commandFactory: () async => _command(),
      diagnosticsQuery: _FakeClosureDiagnostics(),
      syncAttemptRecorder: _FakeClosureDiagnostics(),
      hostedSyncCoordinator: HostedSyncCoordinator(
        authenticationSession: LabAuthenticationSession(),
        syncGuard: _MemorySyncGuard.allowing(),
        applier: _MemoryApplier(cursor: 'c10b:1'),
        recoverFailedNotApplied: RecoverFailedNotApplied(_EmptyOutbox()),
        uploadPendingEvents: UploadPendingEvents(
          _EmptyOutbox(),
          _RecordingSyncTransport(downloadEvents: const []),
        ),
        downloadAndApplyEvents: DownloadAndApplyEvents(
          _RecordingSyncTransport(downloadEvents: const []),
          _MemoryApplier(cursor: 'c10b:1'),
        ),
        acknowledgeAppliedCursor: AcknowledgeAppliedCursor(
          _RecordingSyncTransport(downloadEvents: const []),
          _MemoryApplier(cursor: 'c10b:1'),
        ),
      ),
      failedNotAppliedRecoveryCoordinator: FailedNotAppliedRecoveryCoordinator(
        authenticationSession: LabAuthenticationSession(),
        syncGuard: _MemorySyncGuard.allowing(),
        diagnosticsQuery: _FakeClosureDiagnostics(),
        outbox: _EmptyOutbox(),
        transport: _RecordingSyncTransport(downloadEvents: const []),
      ),
      hostedConnectionCheck: const _FakeHostedConnectionCheck(),
    );

    expect((await runner.status()).state, 'authenticated');
    expect(
      (await runner.enrollOrQueryDevice()).state,
      'hosted-restart-required',
    );
    expect((await runner.hostedSyncProbe()).state, 'sync-completed');
    expect((await runner.logout()).state, 'signed-out-cleared');
  });

  test('closure runner reports exact authentication diagnostics', () async {
    final runner = NativeAuthClosureRunner(
      authenticationSession: _RejectingAuthenticationSession(
        const AuthenticationRejected('callback-not-received'),
      ),
      enrollmentCoordinator: HostedEnrollmentCoordinator(
        authenticationSession: LabAuthenticationSession(),
        tokenSource: LabAccessTokenSource.accepted('synthetic-token'),
        transport: _FakeEnrollmentTransport(
          result: const DeviceEnrollmentResult(
            status: 'device-enrolled',
            installationId: '33333333-3333-4333-8333-333333333333',
            deviceId: '22222222-2222-4222-8222-222222222222',
            accountId: '11111111-1111-4111-8111-111111111111',
            generation: 1,
          ),
        ),
        repository: _MemoryHostedIdentityRepository(),
        now: () => DateTime.utc(2026, 7, 18),
      ),
      environmentAlias: 'native',
      commandFactory: () async => _command(),
      diagnosticsQuery: _FakeClosureDiagnostics(),
      syncAttemptRecorder: _FakeClosureDiagnostics(),
      hostedSyncCoordinator: HostedSyncCoordinator(
        authenticationSession: LabAuthenticationSession(),
        syncGuard: _MemorySyncGuard.allowing(),
        applier: _MemoryApplier(),
        recoverFailedNotApplied: RecoverFailedNotApplied(_EmptyOutbox()),
        uploadPendingEvents: UploadPendingEvents(
          _EmptyOutbox(),
          _RecordingSyncTransport(downloadEvents: const []),
        ),
        downloadAndApplyEvents: DownloadAndApplyEvents(
          _RecordingSyncTransport(downloadEvents: const []),
          _MemoryApplier(),
        ),
        acknowledgeAppliedCursor: AcknowledgeAppliedCursor(
          _RecordingSyncTransport(downloadEvents: const []),
          _MemoryApplier(),
        ),
      ),
      failedNotAppliedRecoveryCoordinator: FailedNotAppliedRecoveryCoordinator(
        authenticationSession: LabAuthenticationSession(),
        syncGuard: _MemorySyncGuard.allowing(),
        diagnosticsQuery: _FakeClosureDiagnostics(),
        outbox: _EmptyOutbox(),
        transport: _RecordingSyncTransport(downloadEvents: const []),
      ),
      hostedConnectionCheck: const _FakeHostedConnectionCheck(),
    );

    expect((await runner.status()).state, 'signed-out');
    expect((await runner.signIn()).state, 'callback-not-received');
  });

  test('enrollment success alone cannot produce sync success', () async {
    final runner = NativeAuthClosureRunner(
      authenticationSession: LabAuthenticationSession(),
      enrollmentCoordinator: HostedEnrollmentCoordinator(
        authenticationSession: LabAuthenticationSession(),
        tokenSource: LabAccessTokenSource.accepted('synthetic-token'),
        transport: _FakeEnrollmentTransport(
          result: const DeviceEnrollmentResult(
            status: 'device-enrolled',
            installationId: '33333333-3333-4333-8333-333333333333',
            deviceId: '22222222-2222-4222-8222-222222222222',
            accountId: '11111111-1111-4111-8111-111111111111',
            generation: 1,
          ),
        ),
        repository: _MemoryHostedIdentityRepository(),
        now: () => DateTime.utc(2026, 7, 18),
      ),
      environmentAlias: 'native',
      commandFactory: () async => _command(),
      diagnosticsQuery: _FakeClosureDiagnostics(),
      syncAttemptRecorder: _FakeClosureDiagnostics(),
      hostedSyncCoordinator: HostedSyncCoordinator(
        authenticationSession: LabAuthenticationSession(),
        syncGuard: _MemorySyncGuard.blocked('enrollment-required'),
        applier: _MemoryApplier(),
        recoverFailedNotApplied: RecoverFailedNotApplied(_EmptyOutbox()),
        uploadPendingEvents: UploadPendingEvents(
          _EmptyOutbox(),
          _RecordingSyncTransport(downloadEvents: const []),
        ),
        downloadAndApplyEvents: DownloadAndApplyEvents(
          _RecordingSyncTransport(downloadEvents: const []),
          _MemoryApplier(),
        ),
        acknowledgeAppliedCursor: AcknowledgeAppliedCursor(
          _RecordingSyncTransport(downloadEvents: const []),
          _MemoryApplier(),
        ),
      ),
      failedNotAppliedRecoveryCoordinator: FailedNotAppliedRecoveryCoordinator(
        authenticationSession: LabAuthenticationSession(),
        syncGuard: _MemorySyncGuard.blocked('enrollment-required'),
        diagnosticsQuery: _FakeClosureDiagnostics(),
        outbox: _EmptyOutbox(),
        transport: _RecordingSyncTransport(downloadEvents: const []),
      ),
      hostedConnectionCheck: const _FakeHostedConnectionCheck(),
    );

    expect(
      (await runner.enrollOrQueryDevice()).state,
      'hosted-restart-required',
    );
    expect(
      (await runner.hostedSyncProbe()).state,
      'device-enrollment-required',
    );
  });

  test(
    'hosted sync coordinator invokes upload, download, apply and ack',
    () async {
      final transport = _RecordingSyncTransport(
        downloadEvents: [
          DownloadedEvent(event: _syncEvent(), serverCursor: 'c10b:1'),
        ],
      );
      final applier = _MemoryApplier();
      final coordinator = HostedSyncCoordinator(
        authenticationSession: LabAuthenticationSession(),
        syncGuard: _MemorySyncGuard.allowing(),
        applier: applier,
        recoverFailedNotApplied: RecoverFailedNotApplied(_OneOutbox()),
        uploadPendingEvents: UploadPendingEvents(_OneOutbox(), transport),
        downloadAndApplyEvents: DownloadAndApplyEvents(transport, applier),
        acknowledgeAppliedCursor: AcknowledgeAppliedCursor(transport, applier),
      );

      expect((await coordinator.run('native')).state, 'sync-completed');
      expect(transport.uploadCount, 1);
      expect(transport.downloadCount, 1);
      expect(transport.acknowledgeCount, 1);
      expect(applier.applyCount, 1);
    },
  );

  test('hosted sync distinguishes no new events from interruption', () async {
    final noNewApplier = _MemoryApplier();
    final noNew = HostedSyncCoordinator(
      authenticationSession: LabAuthenticationSession(),
      syncGuard: _MemorySyncGuard.allowing(),
      applier: noNewApplier,
      recoverFailedNotApplied: RecoverFailedNotApplied(_EmptyOutbox()),
      uploadPendingEvents: UploadPendingEvents(
        _EmptyOutbox(),
        _RecordingSyncTransport(downloadEvents: const []),
      ),
      downloadAndApplyEvents: DownloadAndApplyEvents(
        _RecordingSyncTransport(downloadEvents: const []),
        noNewApplier,
      ),
      acknowledgeAppliedCursor: AcknowledgeAppliedCursor(
        _RecordingSyncTransport(downloadEvents: const []),
        noNewApplier,
      ),
    );
    final interrupted = HostedSyncCoordinator(
      authenticationSession: LabAuthenticationSession(),
      syncGuard: _MemorySyncGuard.allowing(),
      applier: _MemoryApplier(),
      recoverFailedNotApplied: RecoverFailedNotApplied(_OneOutbox()),
      uploadPendingEvents: UploadPendingEvents(
        _OneOutbox(),
        _RecordingSyncTransport(
          uploadResult: const SyncResult(
            code: SyncStatusCode.unknownOutcome,
            outcome: SyncOutcome.unknown,
            retryable: true,
          ),
          downloadEvents: const [],
        ),
      ),
      downloadAndApplyEvents: DownloadAndApplyEvents(
        _RecordingSyncTransport(downloadEvents: const []),
        _MemoryApplier(),
      ),
      acknowledgeAppliedCursor: AcknowledgeAppliedCursor(
        _RecordingSyncTransport(downloadEvents: const []),
        _MemoryApplier(),
      ),
    );

    expect((await noNew.run('native')).state, 'sync-no-new-events');
    expect((await interrupted.run('native')).state, 'sync-failed');
  });

  test('stable enrollment identity survives retry and restart', () async {
    final dbFile = File(
      '${(await Directory.systemTemp.createTemp('markei-stable-id-')).path}/local.sqlite',
    );
    final db = LocalDatabase.file(dbFile);
    addTearDown(db.close);
    addTearDown(() => dbFile.parent.delete(recursive: true));
    final repository = DriftHostedIdentityRepository(db);
    final ids = ['install-a', 'request-a', 'install-b', 'request-b'].iterator;
    final factory = StableDeviceEnrollmentCommandFactory(
      repository: repository,
      environmentAlias: 'native',
      idFactory: () {
        ids.moveNext();
        return ids.current;
      },
      platform: 'windows',
      applicationId: 'markei.windows',
      applicationVersion: '1.0.0',
    );

    final first = await factory();
    await repository.save(
      HostedIdentityState(
        environmentAlias: 'native',
        installationId: first.installationId,
        enrollmentRequestId: first.enrollmentRequestId,
        enrollmentState: 'unknown-outcome',
        updatedAt: DateTime.utc(2026, 7, 18),
      ),
    );
    final retry = await factory();
    await db.close();
    final reopened = LocalDatabase.file(dbFile);
    addTearDown(reopened.close);
    final restarted = StableDeviceEnrollmentCommandFactory(
      repository: DriftHostedIdentityRepository(reopened),
      environmentAlias: 'native',
      idFactory: () => 'unexpected-new-id',
      platform: 'windows',
      applicationId: 'markei.windows',
      applicationVersion: '1.0.0',
    );
    final afterRestart = await restarted();

    expect(retry.installationId, first.installationId);
    expect(retry.enrollmentRequestId, first.enrollmentRequestId);
    expect(afterRestart.installationId, first.installationId);
    expect(afterRestart.enrollmentRequestId, first.enrollmentRequestId);
  });

  test(
    'production composition is unavailable instead of lab-auth when unconfigured',
    () async {
      final runner = NativeAuthClosureRunner.unavailable();

      expect(
        NativeAuthConfiguration.fromEnvironment(),
        isA<NativeAuthConfigurationUnavailable>(),
      );
      expect((await runner.status()).state, 'configuration-missing');
    },
  );
}

bool _containsBytes(List<int> haystack, List<int> needle) {
  for (var index = 0; index <= haystack.length - needle.length; index++) {
    var matched = true;
    for (var offset = 0; offset < needle.length; offset++) {
      if (haystack[index + offset] != needle[offset]) {
        matched = false;
        break;
      }
    }
    if (matched) return true;
  }
  return false;
}

NativeAuth0Authentication _auth(
  _FakeNativeAuth0Client client, {
  DateTime Function()? now,
}) {
  final config =
      NativeAuthConfiguration.validate(
            domain: 'tenant.example.auth0.com',
            clientId: 'public-client',
            audience: 'https://api.example.invalid',
            hostedOrigin: 'https://hosted.example.invalid',
            platform: NativeAuthPlatform.windows,
          )
          as NativeAuthConfigurationReady;
  return NativeAuth0Authentication(
    configuration: config.configuration,
    clientFactory: (_) => client,
    now: now ?? () => DateTime.utc(2026, 7, 18),
  );
}

NativeAuthCredentials _credentials({
  required String accessToken,
  required String idToken,
  DateTime? expiresAt,
}) {
  return NativeAuthCredentials(
    accessToken: accessToken,
    idToken: idToken,
    expiresAt: expiresAt ?? DateTime.utc(2026, 7, 18, 13),
  );
}

DeviceEnrollmentCommand _command() => const DeviceEnrollmentCommand(
  contractVersion: 1,
  installationId: '33333333-3333-4333-8333-333333333333',
  enrollmentRequestId: '55555555-5555-4555-8555-555555555555',
  platform: 'windows',
  applicationId: 'markei.windows',
  applicationVersion: '1.0.0',
);

final class _FakeNativeAuth0Client implements NativeAuth0Client {
  _FakeNativeAuth0Client({
    this.credentials,
    this.cancel = false,
    this.unavailable = false,
    this.rejectCode,
  });

  final NativeAuthCredentials? credentials;
  final bool cancel;
  final bool unavailable;
  final String? rejectCode;
  final loginAudiences = <String>[];
  int logoutCount = 0;

  @override
  Future<NativeAuthCredentials> login({
    required String audience,
    required NativeAuthPlatform platform,
    required String windowsCallbackUrl,
  }) async {
    loginAudiences.add(audience);
    if (cancel) throw const NativeAuthCancelled();
    if (unavailable) throw const NativeAuthUnavailable();
    final code = rejectCode;
    if (code != null) throw NativeAuthRejected(code);
    return credentials ??
        _credentials(accessToken: 'api-token', idToken: 'id-token');
  }

  @override
  Future<void> logout({
    required NativeAuthPlatform platform,
    required String windowsCallbackUrl,
  }) async {
    logoutCount++;
  }
}

final class _RejectingAuthenticationSession
    implements ExternalAuthenticationSession {
  const _RejectingAuthenticationSession(this.rejection);

  final ExternalAuthenticationState rejection;

  @override
  Future<ExternalAuthenticationState> currentState() async => const SignedOut();

  @override
  Future<ExternalAuthenticationState> signIn() async => rejection;

  @override
  Future<void> logout() async {}
}

final class _FakeEnrollmentTransport implements DeviceEnrollmentTransport {
  _FakeEnrollmentTransport({required this.result});

  final DeviceEnrollmentResult result;
  int enrollCount = 0;
  int queryCount = 0;

  @override
  Future<DeviceEnrollmentTransportResult> enroll(
    DeviceEnrollmentCommand command,
    String bearerCredential,
  ) async {
    enrollCount++;
    return DeviceEnrollmentTransportSuccess(result);
  }

  @override
  Future<DeviceEnrollmentTransportResult> query(
    String enrollmentRequestId,
    String bearerCredential,
  ) async {
    queryCount++;
    return DeviceEnrollmentTransportSuccess(result);
  }
}

final class _MemoryHostedIdentityRepository
    implements HostedIdentityRepository {
  HostedIdentityState? _state;
  int saveCount = 0;

  @override
  Future<HostedIdentityState?> load(String environmentAlias) async => _state;

  @override
  Future<void> save(HostedIdentityState state) async {
    saveCount++;
    _state = state;
  }
}

final class _MemorySyncGuard implements HostedSyncGuard {
  const _MemorySyncGuard._(this._decision);

  const _MemorySyncGuard.allowing()
    : this._(
        const HostedSyncDecision.allowed(
          '22222222-2222-4222-8222-222222222222',
        ),
      );

  _MemorySyncGuard.blocked(String reason)
    : this._(HostedSyncDecision.blocked(reason));

  final HostedSyncDecision _decision;

  @override
  Future<HostedSyncDecision> evaluate(String environmentAlias) async =>
      _decision;
}

final class _EmptyOutbox implements SyncOutboxRepository {
  int leaseCount = 0;
  int recoveryCount = 0;

  @override
  Future<SyncUploadSubmission?> leasePending({required int limit}) async {
    leaseCount++;
    return null;
  }

  @override
  Future<FailedNotAppliedRecoveredBatch> recoverExactFailedNotAppliedCandidate(
    FailedNotAppliedRecoveryConfirmation confirmation,
  ) {
    recoveryCount++;
    throw UnimplementedError();
  }

  @override
  Future<SyncUploadSubmission> leaseExactRecoveredBatch(
    FailedNotAppliedRecoveredBatch batch,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<void> persistUploadResult(String submissionId, SyncResult result) {
    throw UnimplementedError();
  }

  @override
  Future<SyncResult> recoverFailedNotApplied(String submissionId) {
    throw UnimplementedError();
  }

  @override
  Future<SyncResult> recoverOneFailedNotApplied() async {
    recoveryCount++;
    return const SyncResult(
      code: SyncStatusCode.noRecoverableFailure,
      outcome: SyncOutcome.notApplied,
      retryable: false,
      protocolCode: 'no-recoverable-failure',
    );
  }
}

final class _OneOutbox implements SyncOutboxRepository {
  String? persistedCode;

  @override
  Future<SyncUploadSubmission?> leasePending({required int limit}) async =>
      const SyncUploadSubmission(
        id: 'submission-1',
        deviceId: '22222222-2222-4222-8222-222222222222',
        requestHash: 'hash-1',
        events: [],
      );

  @override
  Future<FailedNotAppliedRecoveredBatch> recoverExactFailedNotAppliedCandidate(
    FailedNotAppliedRecoveryConfirmation confirmation,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<SyncUploadSubmission> leaseExactRecoveredBatch(
    FailedNotAppliedRecoveredBatch batch,
  ) {
    throw UnimplementedError();
  }

  @override
  Future<void> persistUploadResult(
    String submissionId,
    SyncResult result,
  ) async {
    persistedCode = result.code.name;
  }

  @override
  Future<SyncResult> recoverFailedNotApplied(String submissionId) {
    throw UnimplementedError();
  }

  @override
  Future<SyncResult> recoverOneFailedNotApplied() async => const SyncResult(
    code: SyncStatusCode.noRecoverableFailure,
    outcome: SyncOutcome.notApplied,
    retryable: false,
    protocolCode: 'no-recoverable-failure',
  );
}

final class _MemoryApplier implements RemoteEventApplier {
  _MemoryApplier({this.cursor});

  String? cursor;
  int applyCount = 0;

  @override
  Future<SyncResult> applyPage(DownloadPage page) async {
    applyCount++;
    if (page.events.isEmpty) {
      return const SyncResult(
        code: SyncStatusCode.downloadReceived,
        outcome: SyncOutcome.duplicateEquivalent,
        retryable: false,
      );
    }
    cursor = page.nextCursor ?? page.events.last.serverCursor;
    return const SyncResult(
      code: SyncStatusCode.downloadedApplied,
      outcome: SyncOutcome.applied,
      retryable: false,
    );
  }

  @override
  Future<String?> greatestContiguousAppliedCursor() async => cursor;
}

final class _RecordingSyncTransport implements SyncTransport {
  _RecordingSyncTransport({
    required this.downloadEvents,
    this.uploadResult = const SyncResult(
      code: SyncStatusCode.serverAccepted,
      outcome: SyncOutcome.applied,
      retryable: false,
    ),
  });

  final List<DownloadedEvent> downloadEvents;
  final SyncResult uploadResult;
  int uploadCount = 0;
  int downloadCount = 0;
  int acknowledgeCount = 0;

  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) async {
    uploadCount++;
    return uploadResult;
  }

  @override
  Future<DownloadPage> downloadAfter(
    String? cursor, {
    required int limit,
  }) async {
    downloadCount++;
    return DownloadPage(
      nextCursor: 'c10b:${downloadEvents.length}',
      events: downloadEvents,
    );
  }

  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) async {
    acknowledgeCount++;
    return const SyncResult(
      code: SyncStatusCode.acknowledged,
      outcome: SyncOutcome.applied,
      retryable: false,
    );
  }
}

Map<String, Object?> _syncEvent() {
  final content = <String, Object?>{
    'eventId': 'event-1',
    'accountId': '11111111-1111-4111-8111-111111111111',
    'deviceId': '22222222-2222-4222-8222-222222222222',
    'deviceSequence': 1,
    'eventType': 'purchase.registered',
    'payloadVersion': 3,
    'occurrenceTime': DateTime.utc(2026, 7, 18).toIso8601String(),
    'payload': <String, Object?>{},
  };
  return {...content, 'contentHash': base64Encode(utf8.encode('safe-hash'))};
}

final class _FakeClosureDiagnostics
    implements ClosureDiagnosticsQuery, SyncAttemptRecorder {
  int attemptCalls = 0;
  int preflightCalls = 0;
  int inspectionCalls = 0;
  int snapshotCalls = 0;
  bool retryEligible = false;

  @override
  Future<int> beginSyncAttempt() async => 1;

  @override
  Future<int> beginDiagnosticAttempt({
    required String operationKind,
    required String latestStage,
    required String resultCode,
    required String outcomeClass,
    required String correlationFingerprint,
  }) async {
    attemptCalls++;
    return 1;
  }

  @override
  Future<void> completeSyncAttempt(
    int attemptId, {
    required String resultCode,
    required String outcomeClass,
    required String phase,
    String? recoveryCode,
  }) async {}

  @override
  Future<void> completeDiagnosticAttempt(
    int attemptId, {
    required String operationKind,
    required String latestStage,
    required String resultCode,
    required String outcomeClass,
    required String recoveryCode,
    required String correlationFingerprint,
    required String elapsedBand,
    int? httpStatus,
    required bool responseHeadersReceived,
  }) async {}

  @override
  Future<void> clearAttemptHistory() async {}

  @override
  Future<int> recordDiagnosticEvent(SyncDiagnosticEnvelope diagnostic) async {
    return diagnostic.ordinal;
  }

  @override
  Future<FailedNotAppliedRecoveryInspection> inspectFailedNotAppliedRecovery({
    required String authenticationState,
    required String operationFingerprint,
  }) async {
    inspectionCalls++;
    return const FailedNotAppliedRecoveryInspection.blocked(
      diagnosticCode: 'MKS-REC-012',
      state: 'failed-not-applied-no-candidate',
      queueCounts: ClosureQueueCounts(
        pending: 0,
        uploading: 0,
        failed: 0,
        unknown: 0,
      ),
    );
  }

  @override
  Future<UnknownSubmissionRetryPreflight> unknownSubmissionRetryPreflight({
    required String authenticationState,
  }) async {
    preflightCalls++;
    if (retryEligible) {
      return const UnknownSubmissionRetryPreflight.eligible(
        submissionFingerprint: 'fixture-submission',
        eventCount: 1,
        firstDeviceSequence: 1,
        lastDeviceSequence: 1,
        nextLocalDeviceSequence: 2,
      );
    }
    return const UnknownSubmissionRetryPreflight.blocked(
      state: 'unknown-retry-no-unresolved-submission',
      guidance: 'no-local-sync-action-needed',
    );
  }

  @override
  Future<ClosureDiagnosticsSnapshot> snapshot({
    required String authenticationState,
  }) async {
    snapshotCalls++;
    return ClosureDiagnosticsSnapshot(
      authenticationState: authenticationState,
      enrollmentState: 'device-enrolled',
      syncReadiness: 'ready-no-local-work',
      lastResult: 'no-recorded-attempts',
      queueCounts: const ClosureQueueCounts(
        pending: 0,
        uploading: 0,
        failed: 0,
        unknown: 0,
      ),
      nextDeviceSequence: 1,
      lastSuccessfulSyncAt: null,
      recoveryGuidance: 'no-local-sync-action-needed',
      recentAttempts: const [],
      devices: const [],
      actionableEvents: const [],
      refreshedAt: DateTime.utc(2026, 7, 21),
    );
  }
}

final class _FakeHostedConnectionCheck implements HostedConnectionCheckPort {
  const _FakeHostedConnectionCheck();

  @override
  HostedConnectionCorrelation createCorrelation() {
    return const HostedConnectionCorrelation(
      value: 'correlation-fixture',
      fingerprint: 'corr1234',
    );
  }

  @override
  Future<HostedConnectionCheckResult> check(
    HostedConnectionCorrelation correlation,
  ) async {
    return HostedConnectionCheckResult(
      correlationFingerprint: correlation.fingerprint,
      latestStage: 'response-parsed',
      resultCode: 'hosted-connection-ready',
      outcomeClass: 'completed',
      recoveryCode: 'ready-does-not-prove-sync',
      liveReachable: true,
      ready: true,
      elapsedBand: 'lt-1s',
      responseHeadersReceived: true,
      httpStatus: 200,
    );
  }
}

const _privacyRecoveryInspection = FailedNotAppliedRecoveryInspection.blocked(
  diagnosticCode: 'MKS-REC-012',
  state: 'failed-not-applied-no-candidate',
  queueCounts: ClosureQueueCounts(
    pending: 0,
    uploading: 0,
    failed: 0,
    unknown: 0,
  ),
);

final class _PrivacyRunnerFixture {
  _PrivacyRunnerFixture(
    SyncPrivacyPolicy policy, {
    HostedConnectionCheckPort? hostedCheck,
  }) {
    final authentication = _auth(authClient);
    runner = NativeAuthClosureRunner(
      authenticationSession: authentication,
      enrollmentCoordinator: HostedEnrollmentCoordinator(
        authenticationSession: authentication,
        tokenSource: authentication,
        transport: enrollment,
        repository: identities,
        now: () => DateTime.utc(2026, 7, 18),
      ),
      environmentAlias: 'native',
      commandFactory: () async {
        commandCalls++;
        return _command();
      },
      diagnosticsQuery: diagnostics,
      syncAttemptRecorder: diagnostics,
      hostedSyncCoordinator: HostedSyncCoordinator(
        authenticationSession: authentication,
        syncGuard: const _MemorySyncGuard.allowing(),
        applier: applier,
        recoverFailedNotApplied: RecoverFailedNotApplied(outbox),
        uploadPendingEvents: UploadPendingEvents(outbox, transport),
        downloadAndApplyEvents: DownloadAndApplyEvents(transport, applier),
        acknowledgeAppliedCursor: AcknowledgeAppliedCursor(transport, applier),
      ),
      failedNotAppliedRecoveryCoordinator: FailedNotAppliedRecoveryCoordinator(
        authenticationSession: authentication,
        syncGuard: const _MemorySyncGuard.allowing(),
        diagnosticsQuery: diagnostics,
        outbox: outbox,
        transport: transport,
      ),
      hostedConnectionCheck: hostedCheck ?? connectionCheck,
      syncPrivacyPolicy: policy,
      lifecycleSink: (_) {
        lifecycleCalls++;
      },
    );
  }

  late final NativeAuthClosureRunner runner;
  final authClient = _FakeNativeAuth0Client();
  final enrollment = _FakeEnrollmentTransport(
    result: const DeviceEnrollmentResult(
      status: 'device-enrolled',
      installationId: '33333333-3333-4333-8333-333333333333',
      deviceId: '22222222-2222-4222-8222-222222222222',
      accountId: '11111111-1111-4111-8111-111111111111',
      generation: 1,
    ),
  );
  final identities = _MemoryHostedIdentityRepository();
  final outbox = _EmptyOutbox();
  final applier = _MemoryApplier(cursor: 'c10b:1');
  final transport = _RecordingSyncTransport(downloadEvents: const []);
  final diagnostics = _FakeClosureDiagnostics();
  final connectionCheck = _RecordingPrivacyConnectionCheck();
  int commandCalls = 0;
  int lifecycleCalls = 0;

  void expectNoProviderOrQueueActivity() {
    expect(commandCalls, 0);
    expect(enrollment.enrollCount, 0);
    expect(enrollment.queryCount, 0);
    expect(identities.saveCount, 0);
    expect(outbox.leaseCount, 0);
    expect(outbox.recoveryCount, 0);
    expect(applier.applyCount, 0);
    expect(transport.uploadCount, 0);
    expect(transport.downloadCount, 0);
    expect(transport.acknowledgeCount, 0);
    expect(connectionCheck.calls, 0);
    expect(diagnostics.attemptCalls, 0);
    expect(diagnostics.preflightCalls, 0);
    expect(lifecycleCalls, 0);
  }
}

final class _RecordingPrivacyConnectionCheck
    implements HostedConnectionCheckPort {
  int calls = 0;

  @override
  HostedConnectionCorrelation createCorrelation() =>
      const _FakeHostedConnectionCheck().createCorrelation();

  @override
  Future<HostedConnectionCheckResult> check(
    HostedConnectionCorrelation correlation,
  ) {
    calls++;
    return const _FakeHostedConnectionCheck().check(correlation);
  }
}

final class _BlockingPrivacyConnectionCheck
    implements HostedConnectionCheckPort {
  final started = Completer<void>();
  final release = Completer<void>();
  int calls = 0;

  @override
  HostedConnectionCorrelation createCorrelation() =>
      const _FakeHostedConnectionCheck().createCorrelation();

  @override
  Future<HostedConnectionCheckResult> check(
    HostedConnectionCorrelation correlation,
  ) async {
    calls++;
    started.complete();
    await release.future;
    return const _FakeHostedConnectionCheck().check(correlation);
  }
}
