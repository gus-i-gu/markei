import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../application/catalogue_queries.dart';
import '../application/audit.dart';
import '../application/analytics_workspace.dart';
import '../application/closure_diagnostics.dart';
import '../application/history_export.dart';
import '../application/hosted_auth_ports.dart';
import '../application/hosted_enrollment_coordinator.dart';
import '../application/hosted_sync_coordinator.dart';
import '../application/failed_not_applied_recovery_coordinator.dart';
import '../application/local_references.dart';
import '../application/product_lists.dart';
import '../application/purchase_history.dart';
import '../application/register_purchase.dart';
import '../application/stable_device_enrollment_command_factory.dart';
import '../application/sync/sync_ports.dart';
import '../application/sync/sync_use_cases.dart';
import '../domain/shared/ids.dart';
import '../domain/analytics/analytics_registry.dart';
import '../infrastructure/local/local_analytics_repository.dart';
import '../infrastructure/auth/auth0_native_authentication.dart';
import '../infrastructure/auth/native_auth_config.dart';
import '../infrastructure/local/hosted_identity_repository.dart';
import '../infrastructure/local/closure_diagnostics_repository.dart';
import '../infrastructure/local/local_database.dart';
import '../infrastructure/local/local_device_identity_repository.dart';
import '../infrastructure/local/local_purchase_repository.dart';
import '../infrastructure/local/local_query_repository.dart';
import '../infrastructure/local/sync/local_sync_repositories.dart';
import '../infrastructure/local/sync/remote_purchase_event_applier.dart';
import '../infrastructure/remote/http_device_enrollment_transport.dart';
import '../infrastructure/remote/hosted_http_policy.dart';
import '../infrastructure/remote/http_hosted_connection_check.dart';
import '../infrastructure/remote/http_sync_transport.dart';
import 'native_auth_closure_runner.dart';

final class MarkeiComposition {
  MarkeiComposition({
    required this.database,
    required this.purchaseRegistration,
    required this.catalogueQueries,
    required this.purchaseHistory,
    required this.references,
    required this.preferences,
    required this.productLists,
    required this.purchaseExports,
    AnalyticsWorkspaceController? analyticsWorkspace,
    AuditController? auditController,
    SettingsAccountSupportPort? settingsAccountSupport,
    SettingsSyncDeviceSupportPort? settingsSyncDeviceSupport,
    required this.accountId,
    required this.deviceId,
    this.nativeAuthConfiguration = const NativeAuthConfigurationUnavailable(
      'configuration-missing',
    ),
    this.nativeClosureRunner = const NativeAuthClosureRunner.unavailable(),
    this.nativeClosureSurfaceEnabled = false,
  }) : analyticsWorkspace =
           analyticsWorkspace ??
           AnalyticsWorkspaceController(
             accountId: accountId,
             repository: LocalAnalyticsRepository(database),
             registry: localAnalyticsRegistry(),
           ),
       auditController =
           auditController ??
           AuditController(
             accountId: accountId,
             environmentAlias: 'provider-native',
             repository: DriftClosureDiagnosticsRepository(
               database,
               accountId: accountId,
               deviceId: deviceId,
               environmentAlias: 'provider-native',
             ),
           ),
       settingsAccountSupport =
           settingsAccountSupport ??
           _RunnerSettingsAccountSupport(nativeClosureRunner),
       settingsSyncDeviceSupport =
           settingsSyncDeviceSupport ??
           _RunnerSettingsSyncDeviceSupport(nativeClosureRunner);

  final LocalDatabase database;
  final PurchaseRegistrationRepository purchaseRegistration;
  final CatalogueQueryRepository catalogueQueries;
  final PurchaseHistoryRepository purchaseHistory;
  final LocalReferenceRepository references;
  final AccountPreferenceRepository preferences;
  final ProductListProjectionRepository productLists;
  final PurchaseExportRepository purchaseExports;
  final AnalyticsWorkspaceController analyticsWorkspace;
  final AuditController auditController;
  final SettingsAccountSupportPort settingsAccountSupport;
  final SettingsSyncDeviceSupportPort settingsSyncDeviceSupport;
  final AccountId accountId;
  final DeviceId deviceId;
  final NativeAuthConfigurationResult nativeAuthConfiguration;
  final NativeAuthClosureRunner nativeClosureRunner;
  final bool nativeClosureSurfaceEnabled;
  var _closed = false;

  static Future<MarkeiComposition> appPrivate() async {
    final database = LocalDatabase.appPrivate();
    final queries = LocalQueryRepository(database);
    final nativeConfig = NativeAuthConfiguration.fromEnvironment();
    const environmentAlias = 'provider-native';
    final hostedRepository = DriftHostedIdentityRepository(database);
    final hostedBinding = await hostedRepository.loadActiveBinding(
      environmentAlias,
    );
    final AccountId accountId;
    final DeviceId deviceId;
    if (hostedBinding == null) {
      accountId = const AccountId('local-account');
      deviceId = await LocalDeviceIdentityRepository(
        database,
      ).loadOrCreateDeviceId(accountId);
    } else {
      await hostedRepository.ensureLocalHostedIdentity(hostedBinding);
      accountId = AccountId(hostedBinding.accountId);
      deviceId = DeviceId(hostedBinding.serverDeviceId);
    }
    final nativeClosureRunner = _nativeClosureRunner(
      database,
      nativeConfig,
      activeBinding: hostedBinding,
    );
    final nativeClosureSurfaceEnabled =
        const bool.fromEnvironment('MARKEI_NATIVE_CLOSURE_SURFACE') &&
        nativeConfig is NativeAuthConfigurationReady;
    return MarkeiComposition(
      database: database,
      purchaseRegistration: LocalPurchaseRepository(database),
      catalogueQueries: queries,
      purchaseHistory: queries,
      references: queries,
      preferences: queries,
      productLists: queries,
      purchaseExports: queries,
      accountId: accountId,
      deviceId: deviceId,
      nativeAuthConfiguration: nativeConfig,
      nativeClosureRunner: nativeClosureRunner,
      nativeClosureSurfaceEnabled: nativeClosureSurfaceEnabled,
    );
  }

  static NativeAuthClosureRunner _nativeClosureRunner(
    LocalDatabase database,
    NativeAuthConfigurationResult config, {
    HostedIdentityBinding? activeBinding,
  }) {
    if (config is! NativeAuthConfigurationReady) {
      return NativeAuthClosureRunner.unavailable();
    }
    final authentication = NativeAuth0Authentication(
      configuration: config.configuration,
    );
    final repository = DriftHostedIdentityRepository(database);
    final binding = activeBinding;
    const uuid = Uuid();
    final syncTransport = binding == null
        ? const _BlockedSyncTransport()
        : HttpSyncTransport(
            client: http.Client(),
            baseUri: config.configuration.hostedOrigin,
            tokenSource: () async {
              final result = await authentication.accessToken();
              final token = result.accessToken;
              if (token == null) {
                throw StateError(result.errorCode ?? 'auth-required');
              }
              return token;
            },
            correlationSource: uuid.v4,
            hostedDeviceId: binding.serverDeviceId,
            timeout: HttpSyncTransport.hostedOrdinarySyncDefaultTimeout,
          );
    final syncOutbox = binding == null
        ? DriftSyncOutboxRepository(database)
        : DriftSyncOutboxRepository.scoped(
            database,
            accountId: AccountId(binding.accountId),
            deviceId: DeviceId(binding.serverDeviceId),
          );
    final remoteApplier = binding == null
        ? DriftRemoteEventApplier(database)
        : DriftRemoteEventApplier.scoped(
            database,
            accountId: AccountId(binding.accountId),
          );
    const environmentAlias = 'provider-native';
    final diagnostics = DriftClosureDiagnosticsRepository(
      database,
      accountId: binding == null
          ? const AccountId('local-account')
          : AccountId(binding.accountId),
      deviceId: binding == null
          ? const DeviceId('local-device')
          : DeviceId(binding.serverDeviceId),
      environmentAlias: environmentAlias,
    );
    final commandFactory = StableDeviceEnrollmentCommandFactory(
      repository: repository,
      environmentAlias: environmentAlias,
      idFactory: uuid.v4,
      platform: config.configuration.platform.name,
      applicationId: config.configuration.platform == NativeAuthPlatform.android
          ? NativeAuthConfiguration.defaultAndroidApplicationId
          : 'markei.windows',
      applicationVersion: '1.0.0',
    );
    return NativeAuthClosureRunner(
      authenticationSession: authentication,
      enrollmentCoordinator: HostedEnrollmentCoordinator(
        authenticationSession: authentication,
        tokenSource: authentication,
        transport: HttpDeviceEnrollmentTransport(
          origin: config.configuration.hostedOrigin,
        ),
        repository: repository,
        now: DateTime.now,
      ),
      environmentAlias: environmentAlias,
      commandFactory: commandFactory.call,
      diagnosticsQuery: diagnostics,
      syncAttemptRecorder: diagnostics,
      hostedSyncCoordinator: HostedSyncCoordinator(
        authenticationSession: authentication,
        syncGuard: binding == null
            ? const BlockedHostedSyncGuard('hosted-restart-required')
            : DriftHostedSyncGuard(repository),
        applier: remoteApplier,
        recoverFailedNotApplied: RecoverFailedNotApplied(syncOutbox),
        uploadPendingEvents: UploadPendingEvents(syncOutbox, syncTransport),
        downloadAndApplyEvents: DownloadAndApplyEvents(
          syncTransport,
          remoteApplier,
        ),
        acknowledgeAppliedCursor: AcknowledgeAppliedCursor(
          syncTransport,
          remoteApplier,
        ),
      ),
      failedNotAppliedRecoveryCoordinator: FailedNotAppliedRecoveryCoordinator(
        authenticationSession: authentication,
        syncGuard: binding == null
            ? const BlockedHostedSyncGuard('hosted-restart-required')
            : DriftHostedSyncGuard(repository),
        diagnosticsQuery: diagnostics,
        outbox: syncOutbox,
        transport: syncTransport,
      ),
      hostedConnectionCheck: HttpHostedConnectionCheck(
        client: http.Client(),
        policy: HostedHttpPolicy(
          origin: config.configuration.hostedOrigin,
          correlationSource: uuid.v4,
        ),
      ),
    );
  }

  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    auditController.dispose();
    await database.close();
  }
}

final class _RunnerSettingsAccountSupport
    implements SettingsAccountSupportPort {
  const _RunnerSettingsAccountSupport(this._runner);

  final NativeAuthClosureRunner _runner;

  @override
  bool get signInMayContactNetwork => true;

  @override
  bool get signOutMayWriteLocalState => true;

  @override
  Future<SettingsAccountStatus> accountStatus() async {
    final status = await _runner.status();
    return SettingsAccountStatus(
      authenticationState: status.state,
      updatedAtUtc: DateTime.now().toUtc(),
    );
  }

  @override
  Future<SettingsActionResult> signInToSync() async {
    final result = await _runner.signIn();
    return SettingsActionResult(
      state: result.state,
      message:
          'Sign in to Sync finished with ${result.state}. Local Purchase data is not uploaded merely by opening sign-in.',
      contactedNetwork: true,
      mayHaveWritten: false,
    );
  }

  @override
  Future<SettingsActionResult> signOutOnThisDevice() async {
    final result = await _runner.logout();
    return SettingsActionResult(
      state: result.state,
      message:
          'Sign out on this Device finished with ${result.state}. Local Purchase history and queued work remain according to existing local behavior.',
      contactedNetwork: false,
      mayHaveWritten: true,
    );
  }
}

final class _RunnerSettingsSyncDeviceSupport
    implements SettingsSyncDeviceSupportPort {
  const _RunnerSettingsSyncDeviceSupport(this._runner);

  final NativeAuthClosureRunner _runner;

  @override
  bool get refreshMayContactNetwork => false;

  @override
  bool get connectMayContactNetwork => true;

  @override
  bool get syncMayContactNetwork => true;

  @override
  Future<SettingsSyncDeviceStatus> localStatus() async {
    final snapshot = await _runner.diagnostics();
    final now = DateTime.now().toUtc();
    if (snapshot == null) {
      return SettingsSyncDeviceStatus(
        enrollmentState: 'unavailable',
        syncReadiness: 'unavailable',
        lastResult: 'unavailable',
        lastSuccessfulSyncAtUtc: null,
        deviceReference: null,
        pending: 0,
        uploading: 0,
        failed: 0,
        unknown: 0,
        updatedAtUtc: now,
      );
    }
    final currentDevice = snapshot.devices
        .where((device) => device.isCurrent)
        .firstOrNull;
    return SettingsSyncDeviceStatus(
      enrollmentState: snapshot.enrollmentState,
      syncReadiness: snapshot.syncReadiness,
      lastResult: snapshot.lastResult,
      lastSuccessfulSyncAtUtc: snapshot.lastSuccessfulSyncAt?.toUtc(),
      deviceReference: currentDevice == null
          ? null
          : '#${currentDevice.fingerprint}',
      pending: snapshot.queueCounts.pending,
      uploading: snapshot.queueCounts.uploading,
      failed: snapshot.queueCounts.failed,
      unknown: snapshot.queueCounts.unknown,
      updatedAtUtc: snapshot.refreshedAt.toUtc(),
    );
  }

  @override
  Future<SettingsActionResult> connectThisDevice() async {
    final result = await _runner.enrollOrQueryDevice();
    return SettingsActionResult(
      state: result.state,
      message:
          'Connect this Device finished with ${result.state}. This does not prove Sync succeeded.',
      contactedNetwork: true,
      mayHaveWritten: true,
    );
  }

  @override
  Future<SettingsActionResult> syncNow() async {
    final result = await _runner.hostedSyncProbe();
    return SettingsActionResult(
      state: result.state,
      message:
          'Sync now finished with ${result.state}. No automatic retry or recovery was started.',
      contactedNetwork: true,
      mayHaveWritten: true,
    );
  }
}

final class _BlockedSyncTransport implements SyncTransport {
  const _BlockedSyncTransport();

  @override
  Future<SyncResult> acknowledge(String greatestContiguousCursor) {
    throw StateError('hosted-restart-required');
  }

  @override
  Future<DownloadPage> downloadAfter(String? cursor, {required int limit}) {
    throw StateError('hosted-restart-required');
  }

  @override
  Future<SyncResult> uploadSubmission(SyncUploadSubmission submission) {
    throw StateError('hosted-restart-required');
  }
}
