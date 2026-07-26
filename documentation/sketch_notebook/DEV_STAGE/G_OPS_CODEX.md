# G_OPS_CODEX - C10-GCM02-S12-REC-01

Evidence class: repository-proven and test-validated unless marked otherwise.

## Scope

Unit materialized: C10-GCM02-S12-REC-01 - Gate 12.7 Controlled Recovery Surface.

Branch and ancestry:

- Branch: cycle10-intermid-grimoire.
- Required ancestry: 76540c45702b027d56b52fea05a8025f14496cdf was confirmed as an ancestor before editing.
- Local and origin were aligned before editing.
- Pre-existing unrelated work was preserved: documentation/NEON_CHECK.ps1 deleted and documentation/I_SCRIPTS.ps1 untracked.

No hosted provider, user database, Sync, Retry, Repair, Enroll, deployment, Render, Auth0, or Neon action was performed.

## Operational Changes

- Added a separately named UI action: Recover failed/notApplied candidate.
- Preserved Inspect failed/notApplied recovery as read-only and network-free.
- Added a bounded failed/notApplied recovery coordinator that does not call HostedSyncCoordinator.run.
- Added exact-candidate local repository methods for atomic recovery and exact recovered-batch leasing.
- The bounded action revalidates authentication, binding, current-device preflight, candidate fingerprint, member count, sequence range, next Device sequence, queue counts, event states, request-hash equality, and active-overlap absence immediately before mutation.
- The bounded action performs at most one upload request and stops after upload-result persistence.
- Download, acknowledgement, ordinary Sync, enrollment, repair, cleanup, and automatic retry are absent from the bounded coordinator dependencies.
- Added a session-local UI lock that disables the execution action after the first confirmed execution attempt.
- Corrected eligible failed/notApplied inspection from MKS-UI-004 to MKS-REC-001. MKS-UI-004 remains reserved for the historical missing-action meaning.

## Files Changed

- clients/markei_flutter/lib/application/failed_not_applied_recovery_coordinator.dart
- clients/markei_flutter/lib/application/sync/sync_ports.dart
- clients/markei_flutter/lib/infrastructure/local/sync/local_sync_repositories.dart
- clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart
- clients/markei_flutter/lib/app/native_auth_closure_runner.dart
- clients/markei_flutter/lib/app/pages/native_closure_page.dart
- clients/markei_flutter/lib/app/markei_composition.dart
- clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
- clients/markei_flutter/test/sync/local_sync_application_test.dart
- clients/markei_flutter/test/infrastructure/closure_diagnostics_repository_test.dart
- clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart
- contracts/shared_beta/diagnostics_v1/diagnostics.registry.json
- clients/markei_flutter/lib/domain/sync/sync_diagnostic_registry.g.dart
- services/markei_sync_api/src/domain/sync_diagnostic_registry.generated.ts
- documentation/SYNC_DIAGNOSTICS.md
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

No Drift migration was added.

## Validation

Commands run:

- node scripts/generate_sync_diagnostics.mjs: passed.
- node scripts/generate_sync_diagnostics.mjs --check: passed.
- dart format on changed Dart files: passed.
- flutter test test/app/native_closure_diagnostics_test.dart: 17 passed.
- flutter test test/sync/local_sync_application_test.dart: 29 passed.
- flutter test test/infrastructure/closure_diagnostics_repository_test.dart test/infrastructure/native_auth_composition_test.dart: 26 passed before the final unrelated-failed-work tightening.
- flutter test test/infrastructure/closure_diagnostics_repository_test.dart: 10 passed after the final unrelated-failed-work tightening.
- flutter analyze: passed with no issues after the local lint adjustment.
- flutter test: 189 passed, 4 skipped lab tests.
- npm run diagnostics:check in services/markei_sync_api: passed.
- npm run format:check in services/markei_sync_api: passed.
- npm run lint in services/markei_sync_api: passed.
- npm run typecheck in services/markei_sync_api: passed.
- npm run build in services/markei_sync_api: passed.
- npm test in services/markei_sync_api: 58 passed.

Initial npm run diagnostics:check from repository root failed because there is no root package.json. The command was rerun from services/markei_sync_api and passed.

## Operational Evidence

- Cancellation path test-validated: no local recovery and no provider upload.
- Blocked and stale confirmation paths test-validated: no mutation and no provider contact.
- Exact recovered batch test-validated: only the confirmed member sequence range is leased.
- One-upload-only test-validated: upload count is one, download count is zero, acknowledgement count is zero.
- Unknown-outcome automatic recovery remains absent.
- MKS-REC-001 eligible preflight test-validated; MKS-UI-004 is not emitted for eligible preflight.

## Unavailable Validation

Unavailable by prohibition:

- Windows release validation.
- Android validation.
- Render validation.
- Auth0 validation.
- Neon validation.
- Live provider validation.
- Live end-to-end convergence.
- Execution against the user's database.

## Gate State

FAILED_NOT_APPLIED_EXECUTION_SURFACE=IMPLEMENTED
ELIGIBLE_PREFLIGHT_DIAGNOSTIC_CODE=CORRECTED
EXACT_RECOVERED_BATCH=VALIDATED
ONE_UPLOAD_ONLY=VALIDATED
DOWNLOAD_ACK_ABSENT=VALIDATED
NO_PROVIDER_ACTION_DURING_MATERIALIZATION=PASS
GATE_12_7=HELD
GCM02=OPEN
