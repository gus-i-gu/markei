// ignore_for_file: prefer_initializing_formals

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:markei/application/hosted_auth_ports.dart';

final class HttpDeviceEnrollmentTransport implements DeviceEnrollmentTransport {
  HttpDeviceEnrollmentTransport({
    required Uri origin,
    http.Client? client,
    http.Client Function()? clientFactory,
    Duration timeout = const Duration(seconds: 3),
    int maxResponseBytes = 32768,
  }) : _origin = origin,
       _borrowedClient = client,
       _clientFactory = clientFactory ?? http.Client.new,
       _timeout = timeout,
       _maxResponseBytes = maxResponseBytes;

  final Uri _origin;
  final http.Client? _borrowedClient;
  final http.Client Function() _clientFactory;
  final Duration _timeout;
  final int _maxResponseBytes;

  @override
  Future<DeviceEnrollmentTransportResult> enroll(
    DeviceEnrollmentCommand command,
    String bearerCredential,
  ) async {
    return _closed(() async {
      return _attempt((client, deadline) async {
        final response = await _send(
          client,
          deadline,
          'POST',
          _origin.resolve('/v1/devices/enroll'),
          bearerCredential,
          jsonEncode({
            'contractVersion': command.contractVersion,
            'installationId': command.installationId,
            'enrollmentRequestId': command.enrollmentRequestId,
            'platform': command.platform,
            'applicationId': command.applicationId,
            'applicationVersion': command.applicationVersion,
          }),
        );
        return _decode(response);
      });
    });
  }

  @override
  Future<DeviceEnrollmentTransportResult> query(
    String enrollmentRequestId,
    String bearerCredential,
  ) async {
    return _closed(() async {
      return _attempt((client, deadline) async {
        final response = await _send(
          client,
          deadline,
          'GET',
          _origin.resolve('/v1/devices/enrollments/$enrollmentRequestId'),
          bearerCredential,
          null,
        );
        if (response.statusCode == 404) {
          return const DeviceEnrollmentTransportUnknown();
        }
        return _decode(response);
      });
    });
  }

  void close() {}

  Future<DeviceEnrollmentTransportResult> _attempt(
    Future<DeviceEnrollmentTransportResult> Function(
      http.Client client,
      DateTime deadline,
    )
    action,
  ) async {
    final borrowed = _borrowedClient;
    final client = borrowed ?? _clientFactory();
    final owned = borrowed == null;
    final deadline = DateTime.now().add(_timeout);
    try {
      return await action(client, deadline).timeout(_remaining(deadline));
    } on TimeoutException {
      return const DeviceEnrollmentTransportUnavailable();
    } finally {
      if (owned) client.close();
    }
  }

  Future<http.Response> _send(
    http.Client client,
    DateTime deadline,
    String method,
    Uri uri,
    String bearerCredential,
    String? body,
  ) async {
    final request = http.Request(method, uri)
      ..followRedirects = false
      ..headers.addAll(_headers(bearerCredential));
    if (body != null) request.body = body;
    final streamed = await client.send(request).timeout(_remaining(deadline));
    if (streamed.isRedirect) {
      return http.Response.bytes([], 302, request: streamed.request);
    }
    final chunks = <int>[];
    final iterator = StreamIterator(streamed.stream);
    while (await iterator.moveNext().timeout(_remaining(deadline))) {
      final chunk = iterator.current;
      chunks.addAll(chunk);
      if (chunks.length > _maxResponseBytes) {
        await iterator.cancel();
        return http.Response.bytes(
          [],
          413,
          request: streamed.request,
          reasonPhrase: 'response too large',
        );
      }
    }
    return http.Response.bytes(
      chunks,
      streamed.statusCode,
      headers: streamed.headers,
      request: streamed.request,
      reasonPhrase: streamed.reasonPhrase,
    );
  }

  Map<String, String> _headers(String bearerCredential) => {
    'authorization': 'Bearer $bearerCredential',
    'content-type': 'application/json',
  };

  DeviceEnrollmentTransportResult _decode(http.Response response) {
    if (response.statusCode == 409) {
      return const DeviceEnrollmentTransportConflict();
    }
    if (response.statusCode < 200 || response.statusCode >= 300) {
      return response.statusCode >= 500
          ? const DeviceEnrollmentTransportUnknown()
          : const DeviceEnrollmentTransportUnavailable();
    }
    final Object parsed;
    try {
      parsed = jsonDecode(response.body);
    } catch (_) {
      return const DeviceEnrollmentTransportUnavailable();
    }
    if (parsed is! Map<String, Object?> ||
        parsed.length != 6 ||
        parsed['contractVersion'] != 1 ||
        (parsed['status'] != 'device-enrolled' &&
            parsed['status'] != 'duplicate-equivalent') ||
        parsed['status'] is! String ||
        parsed['installationId'] is! String ||
        parsed['deviceId'] is! String ||
        parsed['accountId'] is! String ||
        parsed['generation'] is! int) {
      return const DeviceEnrollmentTransportUnavailable();
    }
    return DeviceEnrollmentTransportSuccess(
      DeviceEnrollmentResult(
        status: parsed['status'] as String,
        installationId: parsed['installationId'] as String,
        deviceId: parsed['deviceId'] as String,
        accountId: parsed['accountId'] as String,
        generation: parsed['generation'] as int,
      ),
    );
  }

  Future<DeviceEnrollmentTransportResult> _closed(
    Future<DeviceEnrollmentTransportResult> Function() action,
  ) async {
    try {
      return await action();
    } on TimeoutException {
      return const DeviceEnrollmentTransportUnknown();
    } on http.ClientException {
      return const DeviceEnrollmentTransportUnavailable();
    } on FormatException {
      return const DeviceEnrollmentTransportUnavailable();
    }
  }

  Duration _remaining(DateTime deadline) {
    final remaining = deadline.difference(DateTime.now());
    if (!remaining.isNegative && remaining > Duration.zero) return remaining;
    throw TimeoutException('device enrollment deadline expired');
  }
}
