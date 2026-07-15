// ignore_for_file: prefer_initializing_formals

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:markei/application/hosted_auth_ports.dart';

final class HttpDeviceEnrollmentTransport implements DeviceEnrollmentTransport {
  HttpDeviceEnrollmentTransport({
    required Uri origin,
    required String Function() accessToken,
    http.Client? client,
  }) : _origin = origin,
       _accessToken = accessToken,
       _client = client ?? http.Client();

  final Uri _origin;
  final String Function() _accessToken;
  final http.Client _client;

  @override
  Future<DeviceEnrollmentResult> enroll(DeviceEnrollmentCommand command) async {
    final response = await _client.post(
      _origin.resolve('/v1/devices/enroll'),
      headers: _headers(),
      body: jsonEncode({
        'contractVersion': command.contractVersion,
        'installationId': command.installationId,
        'enrollmentRequestId': command.enrollmentRequestId,
        'platform': command.platform,
        'applicationId': command.applicationId,
        'applicationVersion': command.applicationVersion,
      }),
    );
    return _decode(response);
  }

  @override
  Future<DeviceEnrollmentResult?> query(String enrollmentRequestId) async {
    final response = await _client.get(
      _origin.resolve('/v1/devices/enrollments/$enrollmentRequestId'),
      headers: _headers(),
    );
    if (response.statusCode == 404) return null;
    return _decode(response);
  }

  Map<String, String> _headers() => {
    'authorization': 'Bearer ${_accessToken()}',
    'content-type': 'application/json',
  };

  DeviceEnrollmentResult _decode(http.Response response) {
    if (response.statusCode == 409) throw const DeviceEnrollmentConflict();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw const DeviceEnrollmentUnavailable();
    }
    final body = jsonDecode(response.body) as Map<String, Object?>;
    return DeviceEnrollmentResult(
      installationId: body['installationId'] as String,
      deviceId: body['deviceId'] as String,
      accountId: body['accountId'] as String,
      generation: body['generation'] as int,
    );
  }
}
