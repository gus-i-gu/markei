import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Windows runtime packaging contract', () {
    late String runnerCMake;
    late String runtimeScript;

    setUpAll(() {
      runnerCMake = File('windows/runner/CMakeLists.txt').readAsStringSync();
      runtimeScript = File(
        'windows/runner/copy_runtime_dependencies.cmake',
      ).readAsStringSync();
    });

    test('deploys the executable runtime closure from target metadata', () {
      expect(runnerCMake, contains(r'$<TARGET_RUNTIME_DLLS:${BINARY_NAME}>'));
      expect(
        runnerCMake,
        contains(r'$<TARGET_RUNTIME_DLL_DIRS:${BINARY_NAME}>'),
      );
      expect(runnerCMake, contains(r'$<TARGET_FILE_DIR:${BINARY_NAME}>'));
      expect(runnerCMake, contains('copy_runtime_dependencies.cmake'));
      expect(runtimeScript, contains('file(GET_RUNTIME_DEPENDENCIES'));
      expect(runtimeScript, contains('RESOLVED_DEPENDENCIES_VAR'));
      expect(runtimeScript, contains('UNRESOLVED_DEPENDENCIES_VAR'));
    });

    test('fails during configuration when runtime metadata is unavailable', () {
      expect(runnerCMake, contains('CMAKE_VERSION VERSION_LESS 3.27'));
      expect(runnerCMake, contains('message(FATAL_ERROR'));
      expect(
        runnerCMake,
        contains('target-level runtime dependency closure deployment'),
      );
      expect(
        runtimeScript,
        contains('Unresolved Markei Windows runtime dependencies'),
      );
    });

    test('keeps Debug and Release deployment configuration-derived', () {
      expect(runnerCMake, isNot(contains('cpprest_2_10.dll')));
      expect(runnerCMake, isNot(contains('debug/bin')));
      expect(runnerCMake, isNot(contains(r'debug\bin')));
      expect(runnerCMake, isNot(contains('Release/bin')));
      expect(runnerCMake, isNot(contains(r'Release\bin')));
    });

    test('does not introduce local machine paths', () {
      expect(runnerCMake, isNot(contains('vcpkg')));
      expect(runtimeScript, isNot(contains('vcpkg')));
      expect(runnerCMake, isNot(contains('VCPKG_ROOT')));
      expect(runtimeScript, isNot(contains('VCPKG_ROOT')));
      expect(runnerCMake, isNot(contains('C:/')));
      expect(runtimeScript, isNot(contains('C:/')));
      expect(runnerCMake, isNot(contains(r'C:\')));
      expect(runtimeScript, isNot(contains(r'C:\')));
      expect(runnerCMake, isNot(matches(RegExp(r'[A-Za-z]:[\\/]'))));
      expect(runtimeScript, isNot(matches(RegExp(r'[A-Za-z]:[\\/]'))));
      expect(runnerCMake, isNot(contains('gusrm')));
      expect(runtimeScript, isNot(contains('gusrm')));
      expect(runnerCMake, isNot(contains('Gus')));
      expect(runtimeScript, isNot(contains('Gus')));
    });

    test('does not track generated Windows build artifacts', () {
      final result = Process.runSync('git', [
        'ls-files',
        'build',
        'windows/flutter/ephemeral',
        '*.dll',
        '*.exe',
      ], workingDirectory: Directory.current.path);
      expect(result.exitCode, 0, reason: result.stderr.toString());
      expect(result.stdout.toString().trim(), isEmpty);
    });
  });
}
