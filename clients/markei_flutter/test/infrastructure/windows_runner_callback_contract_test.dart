import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:markei/infrastructure/auth/native_auth_config.dart';

void main() {
  group('Windows Auth0 runner callback contract', () {
    late String source;

    setUpAll(() {
      source = File('windows/runner/main.cpp').readAsStringSync();
    });

    test('matches the configured callback prefix', () {
      expect(
        NativeAuthConfiguration.defaultWindowsCallbackUrl,
        'auth0flutter://callback',
      );
      expect(
        source,
        contains(
          'const wchar_t* kCallbackPrefix = L"auth0flutter://callback";',
        ),
      );
    });

    test('forwards callbacks through a current-user bounded pipe', () {
      expect(source, contains('ConvertSidToStringSidW'));
      expect(source, contains('D:(A;;GRGW;;;'));
      expect(source, contains('CreateNamedPipeW'));
      expect(source, contains('PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE'));
      expect(source, contains('WaitNamedPipeW(kRedirectPipeName, 2000)'));
      expect(source, contains('wchar_t buffer[2048];'));
      expect(
        source,
        contains('ReadFile(pipe, buffer, sizeof(buffer) - sizeof(wchar_t)'),
      );
      expect(source, contains('buffer[read / sizeof(wchar_t)] = L\'\\0\';'));
    });

    test('writes startup URLs through the SDK synchronization lock', () {
      expect(source, contains('plugin_startup_url_lock.h'));
      expect(source, contains('auth0_flutter::WriteLockGuard'));
      expect(source, contains('auth0_flutter::GetPluginUrlRwLock()'));
      expect(source, contains('SetPluginStartupUrl(callback.c_str())'));
      expect(source, contains('SetPluginStartupUrl((!startup_uri.empty()'));
      expect(source, isNot(contains('SetEnvironmentVariableW(\n')));
    });

    test('fails closed for wrong callbacks and does not log callback data', () {
      expect(source, contains('IsAuth0Callback(startup_uri)'));
      expect(source, contains('IsAuth0Callback(callback)'));
      expect(source, isNot(contains('std::cout')));
      expect(source, isNot(contains('OutputDebugString')));
      expect(source, isNot(contains('OutputDebugStringW')));
    });
  });
}
