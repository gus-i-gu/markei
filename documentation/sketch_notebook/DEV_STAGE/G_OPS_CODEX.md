# G_OPS_CODEX - Native Closure R1 Operational Evidence

- Authority marker: C10-MCG02-NATIVE-CLOSURE-R1_20260718T145121Z
- Required implementation ancestor: 214df17
- Required staging authority: e59d919ecb776597b13615137cd23413dae42c36
- Baseline local/remote SHA after fast-forward: e59d919ecb776597b13615137cd23413dae42c36
- Actual implementation evidence window: 2026-07-18 local Codex session
- Evidence timestamp: 2026-07-18T12:22:41.1552140-03:00 / 2026-07-18T15:22:41.1573995Z
- Final commit SHA: not self-embedded in this report; Codex final terminal response records the actual commit after publication.
- Evidence environment: Windows 10.0.26200.8875, Flutter 3.44.6, Dart 3.12.2, Docker Desktop 29.6.1 Linux engine, PostgreSQL 18.4 disposable preflight.
- Result classification: executable native closure correction complete locally; provider proof pending.

## Changed Paths

Implementation:

- `clients/markei_flutter/lib/app/markei_app.dart`
- `clients/markei_flutter/lib/app/markei_composition.dart`
- `clients/markei_flutter/lib/app/native_auth_closure_runner.dart`
- `clients/markei_flutter/lib/app/pages/native_closure_page.dart`
- `clients/markei_flutter/lib/application/hosted_sync_coordinator.dart`
- `clients/markei_flutter/lib/application/stable_device_enrollment_command_factory.dart`

Tests:

- `clients/markei_flutter/test/app/native_closure_surface_test.dart`
- `clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart`
- `clients/markei_flutter/test/infrastructure/native_closure_sync_path_test.dart`

Reports:

- `documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md`
- `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

Preserved without reading: `.vscode/`, `documentation/NEON_*`, `.env*`, and the pre-existing untracked provider-looking file `Enter only the POOLED Neon hostname`.

## Evidence

- Docker preflight: `docker version --format '{{json .}}'` passed with client/server present and server OS `linux`; disposable `postgres:18-alpine` container `markei-native-r1-pg-20260718-1` accepted `pg_isready`; `SELECT version();` returned PostgreSQL 18.4; container was removed; filtered inventory was empty. Process note: this gate was executed after initial source edits in the resumed session, not before mutation.
- Flutter devices: Windows desktop and Edge web detected; Android build target available through Gradle build, no Android device attached.
- Real sync path: `HostedSyncCoordinator` invokes existing `UploadPendingEvents`, `DownloadAndApplyEvents`, `AcknowledgeAppliedCursor`, `HttpSyncTransport`, `DriftSyncOutboxRepository`, and `DriftRemoteEventApplier`. `hostedSyncProbe()` no longer calls enrollment replay.
- Stable identity: `StableDeviceEnrollmentCommandFactory` reuses stored installation and enrollment request ids until resolution and across Drift file reopen.
- Closure surface: absent by default; shown only when `MARKEI_NATIVE_CLOSURE_SURFACE` is true and native configuration is ready; displays semantic state names only.

## Validation

- `flutter pub get --enforce-lockfile`: passed; 19 newer incompatible package versions reported, lock unchanged.
- `dart format --set-exit-if-changed lib test`: passed; 80 files checked, 0 changed.
- `flutter analyze`: passed; no issues.
- `flutter test test/infrastructure/native_auth_composition_test.dart`: passed; 14 tests.
- `flutter test test/app/native_closure_surface_test.dart`: passed; 2 tests.
- `flutter test test/infrastructure/native_closure_sync_path_test.dart`: passed; 1 test; Drift emitted existing multi-database debug warnings while separate file-backed databases were open.
- `flutter test`: passed; 79 tests, 2 existing lab skips.
- `flutter build apk --debug`: passed; built `build\app\outputs\flutter-apk\app-debug.apk`; Flutter emitted the existing future KGP migration warning for `auth0_flutter`.
- `flutter build windows --release`: host-excluded; Flutter reported plugin builds require symlink support and Developer Mode is disabled. Host configuration was not changed.
- Server checks: excluded because no server, migration or shared API contract changed.
- Protected Python regressions: excluded because no Python path changed.
- `git diff --check`: passed.
- Secret scan: no tracked/staged hits for private-key, API-key, bearer literal, client-secret, password, database URL or token material.
- Final Docker inventory: `docker ps -a --filter name=markei-native-r1 --format '{{.Names}}'` returned empty output.

No Auth0, Neon, Render, provider credential or public provider operation was performed.
