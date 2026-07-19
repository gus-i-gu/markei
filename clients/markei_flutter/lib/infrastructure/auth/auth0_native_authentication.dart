// ignore_for_file: prefer_initializing_formals

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:markei/application/hosted_auth_ports.dart';

import 'native_auth_config.dart';

typedef Auth0ClientFactory =
    NativeAuth0Client Function(NativeAuthConfiguration configuration);

final class NativeAuth0Authentication
    implements ExternalAuthenticationSession, AccessTokenSource {
  NativeAuth0Authentication({
    required NativeAuthConfiguration configuration,
    Auth0ClientFactory clientFactory = SdkNativeAuth0Client.new,
    DateTime Function() now = DateTime.now,
  }) : _configuration = configuration,
       _client = clientFactory(configuration),
       _now = now;

  final NativeAuthConfiguration _configuration;
  final NativeAuth0Client _client;
  final DateTime Function() _now;
  NativeAuthCredentials? _credentials;
  bool _signingIn = false;

  @override
  Future<ExternalAuthenticationState> currentState() async {
    final credentials = _credentials;
    if (credentials == null) return const SignedOut();
    final rejection = _credentialRejection(credentials);
    if (rejection != null) {
      _credentials = null;
      return rejection == 'token-expired'
          ? const TokenExpired()
          : AuthenticationRejected(rejection);
    }
    return const SignedIn();
  }

  @override
  Future<ExternalAuthenticationState> signIn() async {
    if (_signingIn) return const SigningIn();
    _signingIn = true;
    try {
      final credentials = await _client.login(
        audience: _configuration.audience,
        platform: _configuration.platform,
        windowsCallbackUrl: _configuration.windowsCallback,
      );
      final rejection = _credentialRejection(credentials);
      if (rejection != null) {
        _credentials = null;
        return rejection == 'token-expired'
            ? const TokenExpired()
            : AuthenticationRejected(rejection);
      }
      _credentials = credentials;
      return const SignedIn();
    } on NativeAuthCancelled {
      _credentials = null;
      return const SignInCancelled();
    } on NativeAuthRejected catch (error) {
      _credentials = null;
      return AuthenticationRejected(_closedDiagnosticCode(error.code));
    } on NativeAuthUnavailable {
      _credentials = null;
      return const ProviderUnavailable();
    } finally {
      _signingIn = false;
    }
  }

  @override
  Future<void> logout() async {
    _credentials = null;
    await _client.logout(
      platform: _configuration.platform,
      windowsCallbackUrl: _configuration.windowsLogout,
    );
  }

  @override
  Future<AccessTokenResult> accessToken() async {
    final credentials = _credentials;
    if (credentials == null) {
      return const AccessTokenResult.rejected('signed-out');
    }
    final rejection = _credentialRejection(credentials);
    if (rejection != null) {
      _credentials = null;
      return AccessTokenResult.rejected(rejection);
    }
    return AccessTokenResult.accepted(credentials.accessToken);
  }

  String? _credentialRejection(NativeAuthCredentials credentials) {
    if (credentials.accessToken.isEmpty) return 'access-token-missing';
    if (credentials.idToken.isEmpty) return 'id-token-missing';
    if (credentials.accessToken == credentials.idToken) {
      return 'token-confusion-rejected';
    }
    if (!credentials.expiresAt.isAfter(
      _now().toUtc().add(const Duration(seconds: 5)),
    )) {
      return 'token-expired';
    }
    return null;
  }
}

abstract interface class NativeAuth0Client {
  Future<NativeAuthCredentials> login({
    required String audience,
    required NativeAuthPlatform platform,
    required String windowsCallbackUrl,
  });

  Future<void> logout({
    required NativeAuthPlatform platform,
    required String windowsCallbackUrl,
  });
}

final class SdkNativeAuth0Client implements NativeAuth0Client {
  SdkNativeAuth0Client(NativeAuthConfiguration configuration)
    : _configuration = configuration,
      _auth0 = Auth0(
        configuration.domain,
        configuration.clientId,
        credentialsManager: InMemoryAuth0CredentialsManager(),
      );

  final NativeAuthConfiguration _configuration;
  final Auth0 _auth0;

  @override
  Future<NativeAuthCredentials> login({
    required String audience,
    required NativeAuthPlatform platform,
    required String windowsCallbackUrl,
  }) async {
    try {
      final credentials = switch (platform) {
        NativeAuthPlatform.android =>
          await _auth0
              .webAuthentication(scheme: 'https', useCredentialsManager: false)
              .login(audience: audience),
        NativeAuthPlatform.windows =>
          await _auth0.windowsWebAuthentication().login(
            appCustomURL: windowsCallbackUrl,
            audience: audience,
          ),
        NativeAuthPlatform.unsupported => throw const NativeAuthUnavailable(),
      };
      return NativeAuthCredentials.fromSdk(credentials);
    } on WebAuthenticationException catch (error) {
      if (error.isUserCancelledException) throw const NativeAuthCancelled();
      if (error.isRetryable) throw const NativeAuthUnavailable();
      throw NativeAuthRejected(_closedDiagnosticCode(error.code));
    } on ApiException catch (error) {
      if (error.isCanceled) throw const NativeAuthCancelled();
      if (error.isRetryable || error.isBrowserAppNotAvailable) {
        throw const NativeAuthUnavailable();
      }
      throw NativeAuthRejected(_closedDiagnosticCode(error.code));
    } catch (error) {
      if (kDebugMode) {
        debugPrint('native-auth-provider-unavailable');
      }
      throw const NativeAuthUnavailable();
    }
  }

  @override
  Future<void> logout({
    required NativeAuthPlatform platform,
    required String windowsCallbackUrl,
  }) async {
    try {
      switch (platform) {
        case NativeAuthPlatform.android:
          await _auth0.webAuthentication(scheme: 'https').logout();
        case NativeAuthPlatform.windows:
          await _auth0.windowsWebAuthentication().logout(
            appCustomURL: windowsCallbackUrl,
          );
        case NativeAuthPlatform.unsupported:
          return;
      }
    } catch (_) {
      if (kDebugMode) {
        debugPrint('native-auth-logout-unavailable');
      }
    }
  }

  String get callbackEvidence => switch (_configuration.platform) {
    NativeAuthPlatform.android => _configuration.androidCallbackUrl,
    NativeAuthPlatform.windows => _configuration.windowsCallback,
    NativeAuthPlatform.unsupported => 'platform-unsupported',
  };
}

String _closedDiagnosticCode(String code) {
  final normalized = code.toLowerCase().replaceAll(RegExp(r'[^a-z0-9-]'), '-');
  return switch (normalized) {
    'timeout' || 'callback-not-received' => 'callback-not-received',
    'state-mismatch' ||
    'invalid-state' ||
    'invalid-callback' ||
    'callback-state-rejected' => 'callback-state-rejected',
    'invalid-request' ||
    'invalid-grant' ||
    'access-denied' ||
    'unauthorized' ||
    'authorization-code-exchange-rejected' =>
      'authorization-code-exchange-rejected',
    'access-token-missing' => 'access-token-missing',
    'id-token-missing' => 'id-token-missing',
    'token-expired' => 'token-expired',
    'id-token-rejected' ||
    'token-confusion' ||
    'token-confusion-rejected' => 'token-confusion-rejected',
    'provider-unavailable' ||
    'network-error' ||
    'server-error' ||
    'temporarily-unavailable' => 'provider-unavailable',
    _ => 'authentication-rejected-unknown',
  };
}

final class NativeAuthCredentials {
  const NativeAuthCredentials({
    required this.accessToken,
    required this.idToken,
    required this.expiresAt,
  });

  factory NativeAuthCredentials.fromSdk(Credentials credentials) {
    return NativeAuthCredentials(
      accessToken: credentials.accessToken,
      idToken: credentials.idToken,
      expiresAt: credentials.expiresAt.toUtc(),
    );
  }

  final String accessToken;
  final String idToken;
  final DateTime expiresAt;
}

final class InMemoryAuth0CredentialsManager extends CredentialsManager {
  Credentials? _credentials;

  @override
  Future<bool> clearCredentials() async {
    _credentials = null;
    return true;
  }

  @override
  Future<void> clearApiCredentials({
    required String audience,
    String? scope,
  }) async {}

  @override
  Future<Credentials> credentials({
    int minTtl = 0,
    Set<String> scopes = const {},
    Map<String, String> parameters = const {},
  }) async {
    final credentials = _credentials;
    if (credentials == null) {
      throw const NativeAuthUnavailable();
    }
    return credentials;
  }

  @override
  Future<ApiCredentials> getApiCredentials({
    required String audience,
    Set<String> scope = const {},
    int minTtl = 0,
    Map<String, String> parameters = const {},
    Map<String, String> headers = const {},
  }) {
    throw const NativeAuthUnavailable();
  }

  @override
  Future<bool> hasValidCredentials({int minTtl = 0}) async =>
      _credentials != null;

  @override
  Future<Credentials> renewCredentials({
    Map<String, String> parameters = const {},
  }) {
    throw const NativeAuthUnavailable();
  }

  @override
  Future<bool> storeCredentials(Credentials credentials) async {
    _credentials = credentials;
    return true;
  }

  @override
  Future<SSOCredentials> ssoCredentials({
    Map<String, String> parameters = const {},
    Map<String, String> headers = const {},
  }) {
    throw const NativeAuthUnavailable();
  }

  @override
  Future<UserProfile?> user() async => _credentials?.user;
}

final class NativeAuthCancelled implements Exception {
  const NativeAuthCancelled();
}

final class NativeAuthRejected implements Exception {
  const NativeAuthRejected(this.code);

  final String code;
}

final class NativeAuthUnavailable implements Exception {
  const NativeAuthUnavailable();
}
