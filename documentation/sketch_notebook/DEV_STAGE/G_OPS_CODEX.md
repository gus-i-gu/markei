# G_OPS_CODEX — Ordered Hosted Outbox Recovery Evidence

> Unit: C10-MCG02-ORDERED-OUTBOX-RECOVERY_20260721T000323Z
> Baseline SHA: b214d8395cc2e70ba7860b53215ed7225b940ff0
> Final SHA: recorded in Codex terminal response after commit creation
> Result: C10_MCG02_ORDERED_OUTBOX_RECOVERY_PROVED

## Changed paths

- clients/markei_flutter/lib/application/hosted_sync_coordinator.dart
- clients/markei_flutter/lib/application/sync/sync_ports.dart
- clients/markei_flutter/lib/application/sync/sync_use_cases.dart
- clients/markei_flutter/lib/domain/sync/sync_event.dart
- clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart
- clients/markei_flutter/lib/infrastructure/remote/http_sync_transport.dart
- clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart
- clients/markei_flutter/test/sync/local_sync_application_test.dart
- clients/markei_flutter/test/sync/real_convergence_harness_support.dart
- clients/markei_flutter/test/sync/real_convergence_harness_test.dart
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

## Reproduction and correction evidence

- Focused file-backed fixture inserted same Account/Device events with sequence 2 then 1 and event IDs chosen so legacy unordered `IN` hydration returns `[2, 1]`.
- Production `DriftSyncOutboxRepository.leasePending` returned `[1, 2]`.
- Stored `sync_submission_events` membership positions were `[event sequence 1, event sequence 2]`.
- Preflight gap fixture with sequences `[1, 3]` returned `localBatchInvalid`, made zero transport calls, created zero submissions, and left both pending rows `pending`.
- Failed/notApplied recovery fixture retained old submission as `superseded`, requeued existing event rows, reopened the file-backed database, leased one new ordered retry `[1, 2]`, and repeated recovery returned `failedRecoveryBlocked`.
- Unknown-outcome recovery fixture returned `failedRecoveryBlocked` and left pending state `unknown`.
- HTTP decoder fixture preserved `sequence-gap`, `wrong-account`, and `hash-mismatch`; unknown protocol code remained `conflict`.

## Disposable HTTP/PostgreSQL proof

Command:

~~~text
$env:MARKEI_RUN_SYNC_LAB='1'; flutter test test\sync\real_convergence_harness_test.dart
~~~

Result:

~~~text
CONVERGED=true
ORDERED_OUTBOX_HTTP_PROOF=true sequences=1,2
2 tests passed
~~~

Ordered proof counts:

- server `devices.next_expected_sequence` before upload: `1`;
- reversed transport `[2,1]`: `sequenceGap`, `sync_events=0`, `submissions=0`;
- production transport `[1,2]`: `serverAccepted`;
- server after upload: `sync_events=2`, `submissions=1`, `next_expected_sequence=3`;
- replay same submission identity/hash: `serverAccepted`, counts unchanged `sync_events=2`, `submissions=1`.

Teardown:

- `docker compose ps --format json` in `infra/sync_lab` returned no services.
- `docker ps --filter name=sync_lab --format "{{.Names}} {{.Status}}"` returned no sync-lab containers.

## Validation commands

- `dart format --output=none --set-exit-if-changed ...` -> pass, 10 files checked, 0 changed.
- `flutter analyze` -> pass, no issues.
- `flutter test test\sync\local_sync_application_test.dart` -> pass, 9 tests.
- `flutter test test\sync\real_convergence_harness_test.dart` without lab env -> 2 skipped by explicit guard.
- `flutter test test\sync\real_convergence_harness_test.dart` with `MARKEI_RUN_SYNC_LAB=1` -> pass, 2 tests.
- `flutter test test\sync\real_convergence_harness_test.dart test\sync\real_recovery_harness_test.dart test\infrastructure\native_closure_sync_path_test.dart test\infrastructure\native_auth_composition_test.dart` -> pass, 19 passed, 2 skipped.
- `flutter test` -> pass, 124 passed, 3 skipped.
- `npm run format:check` in `services/markei_sync_api` -> pass.
- `npm run lint` in `services/markei_sync_api` -> pass.
- `npm run typecheck` in `services/markei_sync_api` -> pass.
- `npm test` in `services/markei_sync_api` -> pass, 46 tests.
- `npm run build` in `services/markei_sync_api` -> pass.
- `flutter build apk --debug` -> pass, built `build\app\outputs\flutter-apk\app-debug.apk`; emitted existing Auth0 Kotlin Gradle Plugin warning.
- `flutter build windows --release` -> pass, built `build\windows\x64\runner\Release\markei.exe`; emitted existing Boost CMake policy warning.
- `git diff --check` -> pass.

Drift generation was not run because no Drift schema declaration or generated database file changed.

## Privacy and scope

No Neon, Auth0, Render, provider configuration, or human Drift database was accessed or modified. No PostgreSQL or Drift migration was added. No Device reenrollment, sequence renumbering, payload version change, deployment, UI redesign, MCG-03, MCG-04, or permanent documentation promotion was performed.

Pre-existing untracked private note files were preserved and not read:

- clients/markei_flutter/Exact Auth0 API audience
- clients/markei_flutter/Windows Native Application Client ID
