import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:markei/application/hosted_auth_ports.dart';
import 'package:markei/application/hosted_enrollment_coordinator.dart';
import 'package:markei/application/hosted_sync_coordinator.dart';
import 'package:markei/application/register_purchase.dart';
import 'package:markei/application/sync/sync_use_cases.dart';
import 'package:markei/domain/catalogue/product.dart';
import 'package:markei/domain/purchase/purchase.dart';
import 'package:markei/domain/shared/ids.dart';
import 'package:markei/domain/shared/money.dart';
import 'package:markei/domain/shared/quantity.dart';
import 'package:markei/infrastructure/local/hosted_identity_repository.dart';
import 'package:markei/infrastructure/local/local_database.dart';
import 'package:markei/infrastructure/local/local_purchase_repository.dart';
import 'package:markei/infrastructure/local/sync/local_sync_repositories.dart';
import 'package:markei/infrastructure/local/sync/remote_purchase_event_applier.dart';
import 'package:markei/infrastructure/remote/http_sync_transport.dart';

void main() {
  test(
    'loopback HTTP and file-backed Drift execute hosted sync path',
    () async {
      final temp = await Directory.systemTemp.createTemp(
        'markei-native-closure-sync-',
      );
      addTearDown(() => temp.delete(recursive: true));
      final source = LocalDatabase.file(File('${temp.path}/source.sqlite'));
      final local = LocalDatabase.file(File('${temp.path}/local.sqlite'));
      addTearDown(source.close);
      addTearDown(local.close);

      const account = AccountId('11111111-1111-4111-8111-111111111111');
      const sourceDevice = DeviceId('22222222-2222-4222-8222-222222222222');
      const localDevice = DeviceId('33333333-3333-4333-8333-333333333333');
      await LocalPurchaseRepository(
        source,
      ).registerPurchase(_command(account, sourceDevice, 'REMOTE-001'));
      await LocalPurchaseRepository(
        local,
      ).registerPurchase(_command(account, localDevice, 'LOCAL-001'));
      final remoteEvent =
          jsonDecode(
                (await source.select(source.syncEvents).getSingle())
                    .payloadJson,
              )
              as Map<String, Object?>;
      final server = await _SyncFixtureServer.start([remoteEvent]);
      addTearDown(server.close);

      await DriftHostedIdentityRepository(local).save(
        HostedIdentityState(
          environmentAlias: 'native',
          installationId: 'install-stable',
          enrollmentRequestId: 'request-stable',
          enrollmentState: 'device-enrolled',
          accountId: account.value,
          serverDeviceId: localDevice.value,
          generation: 1,
          updatedAt: DateTime.utc(2026, 7, 18),
        ),
      );
      final transport = HttpSyncTransport(
        client: http.Client(),
        baseUri: server.uri,
        tokenSource: () => 'synthetic-access-token',
        correlationSource: () => 'native-closure-test',
      );
      final outbox = DriftSyncOutboxRepository(local);
      final applier = DriftRemoteEventApplier(local);
      final coordinator = HostedSyncCoordinator(
        authenticationSession: LabAuthenticationSession(),
        syncGuard: DriftHostedSyncGuard(DriftHostedIdentityRepository(local)),
        applier: applier,
        uploadPendingEvents: UploadPendingEvents(outbox, transport),
        downloadAndApplyEvents: DownloadAndApplyEvents(transport, applier),
        acknowledgeAppliedCursor: AcknowledgeAppliedCursor(transport, applier),
      );

      expect((await coordinator.run('native')).state, 'sync-completed');
      expect(server.uploadCount, 1);
      expect(server.downloadCount, 1);
      expect(server.acknowledgeCount, 1);
      expect(await local.select(local.purchases).get(), hasLength(2));
      expect(
        (await local.select(local.pendingEvents).get()).single.state,
        'accepted',
      );
      expect(await local.select(local.syncInbox).get(), hasLength(1));

      await local.close();
      final reopened = LocalDatabase.file(File('${temp.path}/local.sqlite'));
      addTearDown(reopened.close);
      expect(await reopened.select(reopened.purchases).get(), hasLength(2));
      expect(await reopened.select(reopened.syncInbox).get(), hasLength(1));
    },
  );
}

RegisterPurchaseCommand _command(
  AccountId accountId,
  DeviceId deviceId,
  String productCode,
) {
  return RegisterPurchaseCommand(
    accountId: accountId,
    deviceId: deviceId,
    storeName: 'Mercado Central',
    occurrenceTime: DateTime.utc(2026, 7, 18, 10),
    currencyCode: 'BRL',
    items: [
      PurchaseItemDraft(
        productReference: NewProductReference(
          ProductDraft(
            userCode: productCode,
            name: 'Synthetic $productCode',
            brand: 'Fixture',
            mode: ProductMode.packaged,
            measurementKind: MeasurementKind.mass,
            packageAmount: '1',
            packageUnit: 'kg',
          ),
        ),
        packageCount: 1,
        purchasedQuantity: NormalizedQuantity.fromDecimalString(
          kind: MeasurementKind.mass,
          unit: CanonicalUnit.kg,
          decimal: '1',
        ),
        lineTotal: const Money(currencyCode: 'BRL', minorUnits: 1299),
      ),
    ],
  );
}

final class _SyncFixtureServer {
  _SyncFixtureServer._(this._server, this.uri, this._events);

  final HttpServer _server;
  final Uri uri;
  final List<Map<String, Object?>> _events;
  int uploadCount = 0;
  int downloadCount = 0;
  int acknowledgeCount = 0;

  static Future<_SyncFixtureServer> start(
    List<Map<String, Object?>> events,
  ) async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final fixture = _SyncFixtureServer._(
      server,
      Uri.parse('http://127.0.0.1:${server.port}'),
      events,
    );
    fixture._listen();
    return fixture;
  }

  Future<void> close() async {
    await _server.close(force: true);
  }

  void _listen() {
    _server.listen((request) async {
      request.response.headers.contentType = ContentType.json;
      if (request.method == 'POST' &&
          request.uri.path == '/v1/sync/submissions') {
        uploadCount++;
        await utf8.decoder.bind(request).join();
        request.response.write(jsonEncode({'status': 'server-accepted'}));
      } else if (request.method == 'GET' &&
          request.uri.path == '/v1/sync/events') {
        downloadCount++;
        request.response.write(
          jsonEncode({
            'nextCursor': 'c10b:${_events.length}',
            'events': [
              for (var i = 0; i < _events.length; i++)
                {'event': _events[i], 'serverCursor': 'c10b:${i + 1}'},
            ],
          }),
        );
      } else if (request.method == 'POST' &&
          request.uri.path == '/v1/sync/acknowledgements') {
        acknowledgeCount++;
        await utf8.decoder.bind(request).join();
        request.response.write(jsonEncode({'status': 'acknowledged'}));
      } else {
        request.response.statusCode = HttpStatus.notFound;
        request.response.write(jsonEncode({'code': 'not-found'}));
      }
      await request.response.close();
    });
  }
}
