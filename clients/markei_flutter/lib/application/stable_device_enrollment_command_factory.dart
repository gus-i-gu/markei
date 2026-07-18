import 'hosted_auth_ports.dart';

typedef EnrollmentIdFactory = String Function();

final class StableDeviceEnrollmentCommandFactory {
  const StableDeviceEnrollmentCommandFactory({
    required this._repository,
    required this._environmentAlias,
    required this._idFactory,
    required this._platform,
    required this._applicationId,
    required this._applicationVersion,
  });

  final HostedIdentityRepository _repository;
  final String _environmentAlias;
  final EnrollmentIdFactory _idFactory;
  final String _platform;
  final String _applicationId;
  final String _applicationVersion;

  Future<DeviceEnrollmentCommand> call() async {
    final state = await _repository.load(_environmentAlias);
    return DeviceEnrollmentCommand(
      contractVersion: 1,
      installationId: state?.installationId ?? _idFactory(),
      enrollmentRequestId: state?.enrollmentRequestId ?? _idFactory(),
      platform: _platform,
      applicationId: _applicationId,
      applicationVersion: _applicationVersion,
    );
  }
}
