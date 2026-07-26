# G_OPS_CODEX - Step 12 Error Protocol Tightening

Sequence: FLX-ORD-01 - Ordinary Sequence
Unit: C10-GCM02-S12-ERR-01
Role: Codex operational materialization report
Evidence boundary: G/H/I are observational reports only. No semantic promotion, provider action, Retry, ordinary Sync execution, user database access, deployment, Gate 12.7 authorization, or GCM-02 closure was performed.

## Repository Safety

- repository-proven: branch was `cycle10-intermid-grimoire` before editing.
- repository-proven: HEAD `02aa7a0a57219faba856a22c73f1cac0ff2d1988` is a descendant of required pre-stage ancestry `5f30b9d7a55e1312889873bdb3728233cce72ff2`.
- repository-proven: `git fetch origin cycle10-intermid-grimoire` completed and `git rev-list --left-right --count HEAD...origin/cycle10-intermid-grimoire` returned `0 0` before editing.
- repository-proven: `git status --short` was clean before materialization.
- repository-proven: D/E/F contained `C10-GCM02-S12-ERR-01` and `ACTIVE - CODEX IMPLEMENTATION AUTHORIZED`; D/E/F were controlling.

## Inputs Read

- repository-proven: read `AGENTS.md`, `documentation/sketch_notebook/INDEX.md`, `documentation/sketch_notebook/AGENTS.md`, and methodology boot files `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, `CHAT_PROTOCOL.md`.
- repository-proven: read active `D_OPS_STAGE.md`, `E_DDC_STAGE.md`, `F_DSN_STAGE.md`.
- repository-proven: recovered `## System Diagnosis` from `J_MAIN_STAGE.md` and extracted 159 unique `MKS-*` codes.
- repository-proven: inspected current Flutter/API Sync, Closure diagnostics, persistence, transport, migration and tests.

## Materialized Changes

- repository-proven: added `contracts/shared_beta/diagnostics_v1/diagnostics.registry.json`, `diagnostics.schema.json`, and `README.md` as the versioned Sync diagnostics source of truth.
- repository-proven: added deterministic generator `scripts/generate_sync_diagnostics.mjs` and generated Dart, TypeScript and Markdown projections.
- repository-proven: generated `documentation/SYNC_DIAGNOSTICS.md`, `sync_diagnostic_registry.g.dart`, and `sync_diagnostic_registry.generated.ts`; all expose registry version 1 and the same 159-code set.
- repository-proven: added Drift v11 `sync_diagnostic_events` child table with migration ledger entry `v10-to-v11-sync-diagnostic-events`; submissions, pending events, cursors and purchase tables were not migrated or rewritten by source.
- repository-proven: renamed the Closure action to `Retry unknown-outcome submission` and added separate read-only `Inspect failed/notApplied recovery` UI action.
- repository-proven: added current-action diagnostic presentation for MKS code, title, meaning, outcome, phase, local mutation, provider contact, safe action, operation fingerprint and expandable sanitized details.
- repository-proven: added failed/notApplied inspection that requires authenticated current Account/Device binding, current-device scope, exactly one candidate, contiguous membership, request-hash equality, compatible failed member states, no accepted members, no active overlap, and next-sequence match. It performs no recovery and no network request.

## Hazard Fixes

- test-validated: MKS-QUE-009 fixed by persisting `unknownOutcome` after a leased upload when transport throws a sanitized exception.
- test-validated: MKS-QUE-010 fixed by throwing `SyncPersistenceInvariantException` on scoped result-persistence miss.
- test-validated: MKS-REC-012 fixed by requiring all recovery members to be pending or all failed; mixed states block.
- test-validated: MKS-UPL-012 fixed by validating the complete provider submission before first provider write; later-member failure creates no event, submission, cursor, or device-sequence write.
- test-validated: MKS-DNL-013 fixed by advancing the local contiguous cursor for equivalent duplicate-only download pages transactionally.
- test-validated: unexpected API 500 remains sanitized with `service-unavailable`, internal diagnostic fields, and `retryable: false`.

## Commands And Validation

- test-validated: `node scripts/generate_sync_diagnostics.mjs` passed.
- test-validated: `node scripts/generate_sync_diagnostics.mjs --check` passed.
- test-validated: `npm run diagnostics:check` passed.
- test-validated: `flutter pub run build_runner build --delete-conflicting-outputs` passed and regenerated Drift output; build_runner warned the option is ignored by current tooling.
- test-validated: `dart format --set-exit-if-changed lib test` passed with 0 changed files.
- test-validated: `flutter analyze` passed.
- test-validated: focused Flutter diagnostic/sync/migration tests passed.
- test-validated: full `flutter test` passed: 183 passed, 4 skipped by existing lab guards.
- test-validated: `npm run format:check`, `npm run lint`, `npm run typecheck`, `npm run build`, and full `npm test` passed.
- unavailable: Windows release validation, Android validation, Render validation, Auth0 validation, Neon validation and live end-to-end convergence were not authorized and were not performed.

## Gate State

- repository-proven: Gate 12.6 accepted starting state was treated as PASS.
- inferred: Gate 12.7 remains held for Main reconciliation of the new diagnostic/action/interface alignment.
- repository-proven: failed/notApplied execution was not implemented.
- repository-proven: no provider action, deploy, Sync, Retry, Repair, Enroll, or user database access was performed.

ERROR_PROTOCOL_SOURCE_IMPLEMENTED
ERROR_PROTOCOL_GENERATION_VALIDATED
FAILED_NOT_APPLIED_PREFLIGHT_NON_MUTATING
FAILED_NOT_APPLIED_EXECUTION_NOT_IMPLEMENTED
PROVIDER_ACTION_NOT_PERFORMED
GATE_12_7_HELD_FOR_RECONCILIATION
GCM02_OPEN
