# G_OPS_CODEX - Gate 12.6 Copied-Database Reconciliation

Sequence: FLX-PRM-04 - Promotion/Reconciliation
Role: Codex operational report
Round or unit: C10-GCM02-GATE-12.6-COPIED-DATABASE-RECONCILIATION
Branch: cycle10-intermid-grimoire
Required baseline: 7a59bc8b2db4016bd42ca89df0cf2286cd64b755
Inspected HEAD: 8ee181954a99faddaff8f8517646dc2c6cbc1130
Evidence boundary: G/H/I report observed evidence only; no semantic promotion,
Retry, ordinary Sync, provider action, source correction, database access, or
GCM-02 closure was authorized.

## Repository Safety

- repository-proven: `git fetch origin cycle10-intermid-grimoire` completed.
- repository-proven: branch is `cycle10-intermid-grimoire`.
- repository-proven: inspected HEAD is
  `8ee181954a99faddaff8f8517646dc2c6cbc1130`, a descendant of required
  baseline `7a59bc8b2db4016bd42ca89df0cf2286cd64b755`.
- repository-proven: `git rev-list --left-right --count
HEAD...origin/cycle10-intermid-grimoire` returned `0 0`.
- repository-proven: the worktree was clean before materialization.

## Inputs Read

- repository-proven: read `AGENTS.md`,
  `documentation/sketch_notebook/INDEX.md`,
  `documentation/sketch_notebook/AGENTS.md`,
  `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, and
  `CHAT_PROTOCOL.md`.
- repository-proven: read active `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, and
  `F_DSN_STAGE.md`.
- repository-proven: read the newest Gate 12.6 reconciliation entry in
  `J_MAIN_STAGE.md` as append-only Main synthesis authority.
- repository-proven: inspected prior G/H/I, `documentation/G_SCRIPTS.md`,
  `documentation/GRIMOIRE.md`, current Sync source, relevant tests, and Git
  history.

## Copied-Database Evidence Reconciled

- human-observed: GS-SQLITE-02 found exactly one local database candidate,
  verified a copied database by size/hash without printing hashes, observed no
  sidecars, did not query the live database, and returned to repository root.
- human-observed: GS-SQLITE-03 observed six expected Sync tables,
  `PRAGMA quick_check=ok`, one active failed submission with outcome
  `notApplied`, response/error representation
  `conflict / service-unavailable`, two members at positions `0-1` and
  sequences `1-2`, member event state `failed`, two superseded submissions with
  the same two-member range, device `next_sequence` distribution `2`, `3`, `6`,
  two failed events at sequences `1-2`, six pending events at sequences `1-5`,
  and latest ordinary Sync diagnostics
  `sync-unavailable / provider-evidence-unavailable` with absent HTTP
  status/headers.
- human-observed: Retry, ordinary Sync, and provider action were not selected
  during the copied-database observation.
- repository-proven: no Codex command queried, copied, repaired, uploaded, or
  cleaned any user database.

## Source And History Findings

- repository-proven: current `HttpSyncTransport._failure` maps protocol
  `service-unavailable` to `SyncStatusCode.serviceUnavailable`.
- repository-proven: current `DriftSyncOutboxRepository.persistUploadResult`
  stores `result.code.name` in `sync_submissions.response_code` and
  `result.protocolCode` in `sync_submissions.error_code`.
- repository-proven: before commit
  `75dc7bed0789d693af93abb3ed15e107fd77433a`, protocol
  `service-unavailable` had no explicit switch arm and therefore reached
  `_ => SyncStatusCode.conflict`; the same path preserved `body['code']` as
  `protocolCode`.
- repository-proven: commit
  `75dc7bed0789d693af93abb3ed15e107fd77433a` was authored
  `2026-07-22 11:54:56 -0300` and added the explicit mapping.
- human-observed: the copied database last-modified time was reported as
  `2026-07-22 10:08:29` in the human's Windows locale, before that commit.
- inferred: `conflict / service-unavailable` is historically coherent with the
  legacy mapper and does not prove current-source behavior drift.
- unavailable: timestamp ordering does not prove row-level executable
  provenance for every copied row.

## Queue And Recovery Classification

- human-observed/repository-proven: copied-database procedure PASS and SQLite
  integrity/schema PASS are accepted as copied-database evidence, not provider
  evidence.
- human-observed: exactly one active failed/notApplied two-event lineage is
  confirmed for queue classification.
- repository-proven: unknown Retry is inapplicable because the copied state has
  no unknown candidate and the Closure preflight blocks when failed work is
  present.
- superseded: the earlier insufficient-evidence classification is replaced for
  queue class by copied-database evidence.
- repository-proven/inferred: Gate 12.6 remains open only for exact
  device-scoped transition correlation.
- repository-proven/inferred: ordinary Sync remains unauthorized because
  `HostedSyncCoordinator.run` performs failed recovery, then upload, then
  download, then acknowledgement in one compound operation.

## Remaining Evidence Gap

- unavailable from GS-SQLITE-03: the anonymized device scope owning the failed
  submission.
- unavailable from GS-SQLITE-03: that scope's `next_sequence`.
- unavailable from GS-SQLITE-03: how the six other pending events divide
  across anonymized device scopes.
- unavailable from GS-SQLITE-03: which events the next upload would include
  after failed recovery.
- unavailable from GS-SQLITE-03: whether request-hash equality/reuse can be
  verified safely without exposing complete hashes or IDs.
- inferred: because these facts cannot be derived from aggregate counts or
  current source alone, `GS-SQLITE-04` and `GRM-SQLITE-04` were necessary and
  were materialized.

## State Machine Summary

| Step                                                          | Evidence class    | Boundary                      | Effect                                                                            |
| ------------------------------------------------------------- | ----------------- | ----------------------------- | --------------------------------------------------------------------------------- |
| `HostedSyncCoordinator.run` calls `recoverFailedNotApplied()` | repository-proven | local read/mutation           | starts failed recovery before upload                                              |
| `recoverOneFailedNotApplied` finds one scoped candidate       | repository-proven | local read                    | requires current Account/Device and exactly one recoverable failed/notApplied row |
| `_recoverCandidate` supersedes failed submission              | repository-proven | local mutation                | old failed submission state becomes `superseded`                                  |
| candidate events become/remain pending                        | repository-proven | local mutation/no-op          | failed member events are requeued unless already pending                          |
| `uploadPendingEvents` leases pending rows                     | repository-proven | local mutation plus transport | creates a new upload submission for pending events in scope                       |
| download and acknowledgement follow                           | repository-proven | provider/local                | only reached if recovery and upload do not block                                  |

## Commands And Results

- `git fetch origin cycle10-intermid-grimoire`: succeeded.
- `git branch --show-current`: `cycle10-intermid-grimoire`.
- `git rev-parse HEAD`: `8ee181954a99faddaff8f8517646dc2c6cbc1130`.
- `git merge-base --is-ancestor
7a59bc8b2db4016bd42ca89df0cf2286cd64b755 HEAD`: succeeded.
- `git rev-list --left-right --count
HEAD...origin/cycle10-intermid-grimoire`: `0 0`.
- `flutter test test/infrastructure/closure_diagnostics_repository_test.dart
test/app/native_closure_diagnostics_test.dart
test/sync/local_sync_application_test.dart
test/infrastructure/http_sync_transport_device_header_test.dart`: passed
  before report materialization, with existing Drift multiple-database debug
  warnings.
- `flutter test test/infrastructure/native_closure_sync_path_test.dart
test/infrastructure/native_auth_composition_test.dart
test/sync/real_convergence_harness_test.dart
test/sync/two_device_system_harness_test.dart`: passed before report
  materialization; three lab-gated tests skipped unless `MARKEI_RUN_SYNC_LAB=1`.
- `npm exec prettier -- --check` for the edited Markdown paths: first attempt
  used an incorrect relative path and found no files; corrected path then
  reported formatting changes were needed.
- `npm exec prettier -- --write` for the five edited Markdown paths: completed
  on authorized documentation files only.
- corrected `npm exec prettier -- --check` for the five edited Markdown paths:
  passed.
- `dart format --set-exit-if-changed lib test`: passed, 93 files, 0 changed.
- `flutter analyze`: passed, no issues found.
- `flutter test`: passed 178 tests, with 4 lab-gated skips and existing Drift
  multiple-database debug warnings.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm test`: passed 53 tests.
- `npm run build`: passed.
- `npm audit --omit=dev`: passed, 0 vulnerabilities.
- PowerShell parser check for `GS-SQLITE-01` through `GS-SQLITE-04`: passed.
- PowerShell parser check for `GRM-SQLITE-04`: passed.
- GS/GRM SQLite index check for `01` through `04`: passed.
- consistent G/H/I gate-terminal verification: passed.
- disposable SQLite fixture validation for `GS-SQLITE-04`: zero-candidate
  fail-closed count OK; one-device fixture OK; multi-device fixture OK; no
  synthetic identifiers leaked in successful fixture output.
- `git diff --check`: passed after documentation formatting.

## Gate State

```text
COPIED_DATABASE_PROBE_PASS
GATE_12_6_COPIED_DATABASE_PROBE_PASS
FAILED_NOT_APPLIED_CLASS_CONFIRMED
UNKNOWN_RETRY_INAPPLICABLE
LEGACY_RESPONSE_REPRESENTATION_EXPLAINED_WITH_BOUNDARY
LEGACY_CONFLICT_SERVICE_UNAVAILABLE_EXPLAINED_WITH_BOUNDARY
EXACT_DEVICE_SCOPED_TRANSITION_CORRELATION_PENDING
GATE_12_6_OPEN
GATE_12_7_PENDING
RETRY_UNAUTHORIZED
ORDINARY_SYNC_UNAUTHORIZED
PROVIDER_ACTION_UNAUTHORIZED
GCM02_OPEN
```
