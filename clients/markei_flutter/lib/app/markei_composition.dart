import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../application/catalogue_queries.dart';
import '../application/history_export.dart';
import '../application/hosted_enrollment_coordinator.dart';
import '../application/hosted_sync_coordinator.dart';
import '../application/local_references.dart';
import '../application/product_lists.dart';
import '../application/purchase_history.dart';
import '../application/register_purchase.dart';
import '../application/stable_device_enrollment_command_factory.dart';
import '../application/sync/sync_use_cases.dart';
import '../domain/shared/ids.dart';
import '../infrastructure/auth/auth0_native_authentication.dart';
import '../infrastructure/auth/native_auth_config.dart';
import '../infrastructure/local/hosted_identity_repository.dart';
import '../infrastructure/local/local_database.dart';
import '../infrastructure/local/local_device_identity_repository.dart';
import '../infrastructure/local/local_purchase_repository.dart';
import '../infrastructure/local/local_query_repository.dart';
import '../infrastructure/local/sync/local_sync_repositories.dart';
import '../infrastructure/local/sync/remote_purchase_event_applier.dart';
import '../infrastructure/remote/http_device_enrollment_transport.dart';
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
    required this.accountId,
    required this.deviceId,
    this.nativeAuthConfiguration = const NativeAuthConfigurationUnavailable(
      'configuration-missing',
    ),
    this.nativeClosureRunner = const NativeAuthClosureRunner.unavailable(),
    this.nativeClosureSurfaceEnabled = false,
  });

  final LocalDatabase database;
  final PurchaseRegistrationRepository purchaseRegistration;
  final CatalogueQueryRepository catalogueQueries;
  final PurchaseHistoryRepository purchaseHistory;
  final LocalReferenceRepository references;
  final AccountPreferenceRepository preferences;
  final ProductListProjectionRepository productLists;
  final PurchaseExportRepository purchaseExports;
  final AccountId accountId;
  final DeviceId deviceId;
  final NativeAuthConfigurationResult nativeAuthConfiguration;
  final NativeAuthClosureRunner nativeClosureRunner;
  final bool nativeClosureSurfaceEnabled;

  static Future<MarkeiComposition> appPrivate() async {
    final database = LocalDatabase.appPrivate();
    final queries = LocalQueryRepository(database);
    final nativeConfig = NativeAuthConfiguration.fromEnvironment();
    final nativeClosureRunner = _nativeClosureRunner(database, nativeConfig);
    final nativeClosureSurfaceEnabled =
        const bool.fromEnvironment('MARKEI_NATIVE_CLOSURE_SURFACE') &&
        nativeConfig is NativeAuthConfigurationReady;
    const accountId = AccountId('local-account');
    final deviceId = await LocalDeviceIdentityRepository(
      database,
    ).loadOrCreateDeviceId(accountId);
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
    NativeAuthConfigurationResult config,
  ) {
    if (config is! NativeAuthConfigurationReady) {
      return NativeAuthClosureRunner.unavailable();
    }
    final authentication = NativeAuth0Authentication(
      configuration: config.configuration,
    );
    final repository = DriftHostedIdentityRepository(database);
    final syncTransport = HttpSyncTransport(
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
      correlationSource: () => 'native-closure',
    );
    final syncOutbox = DriftSyncOutboxRepository(database);
    final remoteApplier = DriftRemoteEventApplier(database);
    const uuid = Uuid();
    const environmentAlias = 'provider-native';
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
      hostedSyncCoordinator: HostedSyncCoordinator(
        authenticationSession: authentication,
        syncGuard: DriftHostedSyncGuard(repository),
        applier: remoteApplier,
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
    );
  }
}
