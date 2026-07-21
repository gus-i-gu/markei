# G_OPS_CODEX - Recovery Orchestration Evidence

> Unit: C10-MCG02-RECOVERY-ORCHESTRATION_20260721T003303Z
> Baseline SHA: 7a0e6d7128913232a4644ded4bbc4d931c095a9f
> Final SHA: recorded in Codex terminal response after commit creation
> Result: C10_MCG02_RECOVERY_ORCHESTRATION_PROVED

## Changed Paths

- clients/markei_flutter/lib/app/markei_composition.dart
- clients/markei_flutter/lib/application/hosted_sync_coordinator.dart
- clients/markei_flutter/lib/application/sync/sync_ports.dart
- clients/markei_flutter/lib/application/sync/sync_use_cases.dart
- clients/markei_flutter/lib/domain/sync/sync_event.dart
- clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart
- clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart
- clients/markei_flutter/test/infrastructure/native_closure_sync_path_test.dart
- clients/markei_flutter/test/sync/local_sync_application_test.dart
- clients/markei_flutter/test/sync/real_convergence_harness_support.dart
- clients/markei_flutter/test/sync/real_convergence_harness_test.dart
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

## Production Call Path

Production composition now wires:

```text
HostedSyncCoordinator
  -> RecoverFailedNotApplied
  -> SyncOutboxRepository.recoverOneFailedNotApplied
  -> UploadPendingEvents
  -> HttpSyncTransport
```

The coordinator invokes recovery only after hosted authentication, Account/Device binding, and Device-allowed checks. It then continues through the existing upload, download, and acknowledgement ordering. No UI submission-ID control, Drift query in UI/coordinator, schema migration, provider mutation, or human database edit was added.

## Candidate Counts And Decisions

- zero scoped failed/notApplied candidates: `SyncStatusCode.noRecoverableFailure`, protocol `no-recoverable-failure`, ordinary no-op.
- one structurally valid scoped candidate: old failed submission retained as `superseded`; same immutable events returned to `pending`; result `SyncStatusCode.failedRecoveryAvailable`, protocol `failed-recovery-available`.
- multiple structurally valid candidates: `SyncStatusCode.failedRecoveryBlocked`; no submission or event state changed.
- malformed candidate, missing membership, hash mismatch, duplicate/gapped sequence, accepted member, active equivalent retry, wrong Account, or wrong Device: fail closed with bounded result and no unsafe mutation.
- failed outcome other than `notApplied`, unknown outcome, uploading, or accepted submission: not eligible for automatic recovery.

## Local Evidence

Focused command:

```text
flutter test test\sync\local_sync_application_test.dart
```

Result: pass, 18 tests.

Named recovery-orchestration tests included:

- `scoped recovery discovery reports no candidate as no-op`
- `scoped recovery discovery blocks ambiguous candidates`
- `scoped recovery discovery blocks malformed failed candidate`
- `scoped recovery ignores non-failed-notApplied states`
- `scoped recovery blocks missing membership and hash mismatch`
- `scoped recovery leaves cross-device failed attempts untouched`
- `coordinator discovers failed recovery and uploads canonically`
- `concurrent scoped recovery creates one pending recovery`
- `unknown upload after recovery preserves same retry submission`

Local counts and decisions:

- reversed physical/member order `[2,1]` leased canonically as `[1,2]`;
- coordinator recovery run uploaded exactly once and recorded transmitted sequences `[1,2]`;
- old failed attempt count with `state=superseded`: `1`;
- repeated coordinator sync after recovery produced no second upload;
- concurrent recovery calls produced one `failedRecoveryAvailable` result and one durable superseded failed attempt;
- unknown upload after recovery preserved one retry submission identity in `state=unknown`.

## HTTP/PostgreSQL Proof

Command:

```text
$env:MARKEI_RUN_SYNC_LAB='1'; flutter test test\sync\real_convergence_harness_test.dart
```

Result:

```text
CONVERGED=true
ORDERED_OUTBOX_HTTP_PROOF=true sequences=1,2
RECOVERY_ORCHESTRATION_HTTP_PROOF=true sequences=1,2
3 tests passed
```

Human-equivalent disposable fixture:

- Drift schema v8 file-backed database;
- hosted Account/Device binding with Device sequences `1` and `2`;
- local next sequence `3`;
- one failed/notApplied legacy submission with reversed membership `[2,1]`;
- server `devices.next_expected_sequence` before upload: `1`;
- unrelated local-only Device event outside hosted scope preserved.

After one production `HostedSyncCoordinator` run:

- failed attempt discovered without supplied submission ID;
- old failed submission retained as `superseded`;
- same immutable hosted events requeued and leased canonically as `1,2`;
- upload used real HTTP transport;
- server `sync_events`: `2`;
- server `submissions`: `1`;
- server `devices.next_expected_sequence`: `3`;
- local hosted pending rows accepted: `2`;
- unrelated local-only pending row preserved: `1`;
- repeated coordinator run left server counts unchanged at `sync_events=2`, `submissions=1`.

## Regression And Platform Validation

- `dart format --output=none --set-exit-if-changed ...` -> pass, 11 files checked, 0 changed.
- `flutter analyze` -> pass, no issues.
- `flutter test test\sync\local_sync_application_test.dart` -> pass, 18 tests.
- `flutter test test\sync\local_sync_application_test.dart test\sync\real_convergence_harness_test.dart` without lab env -> pass, lab-only cases skipped by explicit guard.
- `flutter test test\infrastructure\native_auth_composition_test.dart test\infrastructure\native_closure_sync_path_test.dart test\sync\real_recovery_harness_test.dart test\sync\two_device_system_harness_test.dart` -> pass; lab-only recovery harness skipped without env.
- `flutter test` -> pass, 133 passed, 4 skipped.
- `npm run format:check` in `services/markei_sync_api` -> pass.
- `npm run lint` in `services/markei_sync_api` -> pass.
- `npm run typecheck` in `services/markei_sync_api` -> pass.
- `npm test` in `services/markei_sync_api` -> pass, 46 tests.
- `npm run build` in `services/markei_sync_api` -> pass.
- `flutter build apk --debug` -> pass, built `build\app\outputs\flutter-apk\app-debug.apk`; existing Auth0 Kotlin Gradle Plugin warning emitted.
- `flutter build windows --release` -> pass, built `build\windows\x64\runner\Release\markei.exe`; existing Boost CMake policy warning emitted.
- `git diff --check` -> pass.

Drift generation was not run because no Drift schema declaration or generated database file changed. No TypeScript source changed; TypeScript checks were run as regression evidence.

## Teardown, Secrets, And Scope

- `docker compose ps --format json` in `infra/sync_lab` returned no services after lab teardown.
- Tracked/staged secret and artifact scans were run before commit.
- Pre-existing untracked private note files were preserved, not read, and not staged:
  - `clients/markei_flutter/Exact Auth0 API audience`
  - `clients/markei_flutter/Windows Native Application Client ID`

No Neon, Auth0, Render, provider configuration, private provider files, or human Drift database was accessed or modified. No PostgreSQL or Drift migration, event version change, Device reenrollment, sequence renumbering, deployment, broad UI work, permanent documentation promotion, MCG-03, or MCG-04 was performed.
