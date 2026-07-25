# G_OPS_CODEX - Gate 12.6 Recovery Classification Diagnosis

Sequence: FLX-INV-02 diagnostic report
Role: Codex
Round or unit: C10-GCM02-GATE-12.6-RECOVERY-CLASSIFICATION
Branch: cycle10-intermid-grimoire
Baseline / inspected HEAD: b2221c065306fd3ac71381e325333d44dbe7ec92
Authority: human instruction authorizes diagnosis and G/H/I replacement only
Writable surfaces: G_OPS_CODEX.md, H_DDC_CODEX.md, I_DSN_CODEX.md
Evidence boundary: repository-proven, test-validated, human-observed, inferred, provisional and unavailable claims are kept separate

## Baseline

- repository-proven: branch is `cycle10-intermid-grimoire`.
- repository-proven: inspected HEAD is exactly `b2221c065306fd3ac71381e325333d44dbe7ec92`.
- repository-proven: required ancestors `1579711f21f7bc9cfac940dda7d7f436161122a4` and `1d2a342be17b8df237ec469110187aca117f55ac` are ancestors of HEAD.
- repository-proven: `git rev-list --left-right --count HEAD...origin/cycle10-intermid-grimoire` returned `0 0`.
- repository-proven: worktree was clean before diagnosis.

## Inputs Read

- repository-proven: read `AGENTS.md`, `documentation/sketch_notebook/INDEX.md`, `documentation/sketch_notebook/AGENTS.md`, `METHOD_FOUNDATIONS.md`, `FLUX.md`, `PROMOTION_RULES.md`, and `CHAT_PROTOCOL.md`.
- repository-proven: read D/E/F and prior G/H/I as historical Account Cursor Provisioning Repair context only.
- repository-proven: searched Dart, TypeScript, SQL, GRIMOIRE, A/B/C and J references for retry, failed, unknown, transport, readiness and recovery terms.
- human-observed: accepted sanitized screenshot evidence exactly as supplied by Main/human; no local database, provider, Auth0, Render or Neon evidence was fetched.

## Source Route

- repository-proven: `NativeClosurePage._confirmRetryUnresolved` calls `runner.unknownRetryPreflight()` before opening a dialog. If `eligible == false`, it refreshes diagnostics, sets `_state` to `preflight.state`, and returns without `showDialog`.
- repository-proven: `DriftClosureDiagnosticsRepository.unknownSubmissionRetryPreflight` blocks before unknown-submission lookup when current-device queue counts have any pending, uploading or failed rows. The returned state is `unknown-retry-queue-not-isolated`.
- repository-proven: `snapshot()` computes local queue counts from `pending_events` joined to `sync_events`; `failed-work-needs-review` is returned when failed count is greater than zero and unknown count is not greater than zero.
- repository-proven: `UploadPendingEvents.call()` leases an existing unknown submission or new pending batch, calls `transport.uploadSubmission`, then persists the result.
- repository-proven: `persistUploadResult` stores `accepted` for `serverAccepted` and `duplicateIgnored`, `unknown` for `unknownOutcome`, and `failed` for every other `SyncStatusCode`; it writes that same state to all member `pending_events`.
- repository-proven: `HttpSyncTransport._sendJson` maps `TimeoutException` and `http.ClientException` to null; upload then returns `unknownOutcome` / `unknown`.
- repository-proven: a parsed protocol failure body maps through `_failure` to `notApplied`; `service-unavailable` becomes `SyncStatusCode.serviceUnavailable`, outcome `notApplied`, protocol code `service-unavailable`.
- repository-proven: API `acceptSubmission` returns `service-unavailable` / `upload-submission` / `not-applied` when `account_cursor_state` update affects zero rows. `sendHostedResult` returns HTTP 503 for `service-unavailable`.
- repository-proven: `NativeAuthClosureRunner.hostedSyncProbe` records only coordinator-level terminal state. `sync-unavailable` maps to outcomeClass `unavailable`, phase `sync`, recoveryCode `provider-evidence-unavailable`.

## State-Transition Table

| Evidence class | Transport/API result | Local submission state | Local event state | Notes |
| --- | --- | --- | --- | --- |
| repository-proven | `serverAccepted` | `accepted` | `accepted` | Applied success. |
| repository-proven | `duplicateIgnored` | `accepted` | `accepted` | Duplicate-equivalent treated as accepted locally. |
| repository-proven | `unknownOutcome` | `unknown` | `unknown` | Timeout/client exception/no trusted upload response preserves exact submission. |
| repository-proven | `sequenceGap`, `wrongAccount`, `hashMismatch`, `serviceUnavailable`, other non-unknown codes | `failed` | `failed` | Outcome commonly `notApplied`; exact response fields are stored on `sync_submissions`. |

## Unknown Retry vs Failed Recovery

- repository-proven: unknown retry is exact-submission retry. It requires authentication, current hosted binding, matching Account/Device, no pending/uploading/failed work, exactly one unknown submission, contiguous membership, pending row state `unknown`, valid event payload hashes, matching request hash, and `device.nextSequence == lastDeviceSequence + 1`.
- repository-proven: failed/not-applied recovery is a separate mechanism. `recoverOneFailedNotApplied` scopes to exactly one failed/notApplied candidate for current Account/Device, validates membership and event hashes, supersedes the old failed submission, and requeues member events as pending.
- repository-proven: ordinary `HostedSyncCoordinator.run` automatically calls `recoverFailedNotApplied()` before `uploadPendingEvents()`, then download, then acknowledgement.
- inferred: ordinary Sync can transmit the preserved failed/notApplied workload without an explicit Retry-dialog confirmation, because the coordinator recovery step can requeue it and the same coordinator invocation then uploads pending events.

## Answers

1. repository-proven: failed > 0 prevents the unknown retry dialog because preflight checks queue counts before unknown-submission lookup and returns `unknown-retry-queue-not-isolated`.
2. repository-proven: `UploadPendingEvents.call` -> `SyncTransport.uploadSubmission` -> `DriftSyncOutboxRepository.persistUploadResult` changes a submission and its member events to failed for any non-accepted and non-unknown result code.
3. repository-proven: accepted is `serverAccepted` or `duplicateIgnored`; unknown is `unknownOutcome`; failed is every other code persisted by `persistUploadResult`.
4. repository-proven/provisional: a request with no observed HTTP status or headers in `HttpSyncTransport` cannot be conclusively stored as notApplied by that transport path; timeout/client exception maps to unknown. A notApplied store requires a decoded protocol failure or a different local state path. The screenshot alone does not show the owning submission response fields.
5. repository-proven: `sync-unavailable/provider-evidence-unavailable` in Closure diagnostics is a later runner/coordinator-level projection recorded in `sync_attempts`, not by itself the original submission response. It may summarize an underlying failed recovery, serviceUnavailable upload, local exception, or other unavailable coordinator stop.
6. human-observed plus inferred: screenshots alone prove the UI displayed failed event count 2, unknown count 0, last sync unavailable and no HTTP status/headers for the displayed attempt. They do not prove the owning submission is `notApplied`.
7. repository-proven/inferred: identical UI counts can exist under multiple DB states: one failed submission owning two events, two failed submissions owning one event each, superseded history plus one active failed candidate, or failed events with malformed/missing membership. The UI count does not expose ownership cardinality.
8. repository-proven: `recoverOneFailedNotApplied` enforces current Account/Device scope, exactly one recoverable candidate, non-empty and valid membership, canonical sequence ordering, valid event content hashes, no accepted member events, and no other active uploading/unknown member submission. It does not explicitly require the old submission ID to be reused; it supersedes it. It validates event content hash, not request-hash equality for failed legacy rows. It does not itself require sequences specifically 1-2 or next local sequence 3, and it does not check unrelated pending/uploading work outside the candidate.
9. repository-proven/inferred: ordinary Sync can recover and transmit failed/notApplied work because coordinator order is recovery then upload. Ordinary Sync must remain prohibited while Gate 12.6 freeze is active because it can perform a mutation without the unknown-retry confirmation dialog.
10. provisional: Gate 12.6 unknown-retry procedure is semantically wrong for a queue that is genuinely failed/notApplied. The queue classification itself remains unproven from screenshot evidence because the exact submission outcome/response fields were not read.
11. inferred: minimum additional evidence is a sanitized copied-database read-only probe of `sync_submissions`, `sync_submission_events`, `pending_events`, `sync_events`, `devices`, and latest `sync_attempts`; provider logs are needed only if local state cannot prove whether an observed protocol failure existed.
12. provisional: source correction is currently unauthorized and not proven required. A UI/procedure correction may be advisable if copied local evidence confirms failed/notApplied, but implementation remains outside this diagnostic authority.

## Diagnosis

Conclusion C: mixed or insufficient evidence requiring one additional read-only local observation before selecting recovery path. Confidence: high that source explains the blocked UI state; medium that the correct next route is failed/notApplied recovery; unavailable for the actual owning submission outcome in the human database.

If the copied local probe shows exactly one failed/notApplied submission owning events 1-2 with `response_code=serviceUnavailable` and `error_code=service-unavailable`, then conclusion A becomes supported: correct failed/not-applied classification with stale/inappropriate unknown-retry Gate 12.6 procedure. If it shows failed state without a protocol failure or with response fields inconsistent with observed transport evidence, conclusion B or D must be considered.

## Proposed Sanitized Copied-Database Probe

State: proposed, unexecuted, requires Main and human authorization.

Contract:
- copy the database first; never query the live database;
- open the copy read-only where supported;
- begin a read-only transaction where supported;
- return only counts, states, outcomes, response codes, error codes, sequence ranges, membership counts and short fingerprints;
- never return payload_json, tokens, complete UUIDs, complete hashes, receipt contents, purchase contents or private configuration.

Probe outline:

```sql
BEGIN;
SELECT state, outcome, response_code, error_code, COUNT(*) FROM sync_submissions GROUP BY state, outcome, response_code, error_code;
SELECT s.state, s.outcome, s.response_code, s.error_code,
       COUNT(se.event_id) AS member_count,
       MIN(e.device_sequence) AS first_sequence,
       MAX(e.device_sequence) AS last_sequence,
       COUNT(DISTINCT pe.state) AS pending_state_kinds,
       MIN(pe.state) AS min_event_state,
       MAX(pe.state) AS max_event_state,
       substr(hex(sha256(s.id)), 1, 8) AS submission_fp
FROM sync_submissions s
LEFT JOIN sync_submission_events se ON se.submission_id = s.id
LEFT JOIN sync_events e ON e.id = se.event_id
LEFT JOIN pending_events pe ON pe.event_id = e.id
GROUP BY s.id, s.state, s.outcome, s.response_code, s.error_code
ORDER BY s.created_at, s.id;
SELECT d.next_sequence, COUNT(*) FROM devices d GROUP BY d.next_sequence;
SELECT operation_kind, result_code, outcome_class, phase, recovery_code,
       http_status IS NOT NULL AS has_http_status,
       response_headers_received,
       elapsed_band
FROM sync_attempts
ORDER BY started_at DESC, id DESC
LIMIT 5;
ROLLBACK;
```

Expected interpretations:
- exactly one failed/notApplied submission, member_count 2, sequences 1-2, event state failed, Device next_sequence 3, serviceUnavailable/service-unavailable response fields: supports A.
- unknown submission/event rows exist or response_code `unknownOutcome`: supports unknown retry path, contradicts current UI screenshot or indicates target/database drift.
- failed rows without notApplied/protocol response, malformed membership, multiple candidates, sequence gaps, or missing membership: supports C/D and blocks recovery.
- sync attempts only show coordinator `sync-unavailable` without submission response fields: insufficient for A/B; bounded provider logs may be needed.

## Provider Evidence Boundary

- unavailable: no Render logs, Neon queries, Auth0 data, provider deployment state, or protected Sync response was obtained in this revision.
- inferred: a bounded future Render log correlation window may be useful only if local copied-database response fields cannot distinguish protocol response from absent-response transport. It should expose only timestamp band, route class, status, result code, correlation fingerprint and no identifiers/secrets.

## Commands and Validation

- `git status --short --branch`: clean branch tracking origin.
- `git rev-parse HEAD`: `b2221c065306fd3ac71381e325333d44dbe7ec92`.
- `git fetch origin cycle10-intermid-grimoire`: succeeded.
- `git merge-base --is-ancestor ... HEAD` for both required commits: succeeded.
- `git rev-list --left-right --count HEAD...origin/cycle10-intermid-grimoire`: `0 0`.
- `flutter test test/infrastructure/closure_diagnostics_repository_test.dart`: passed 7/7.
- `flutter test test/sync/local_sync_application_test.dart`: passed 25/25 with Drift multiple-database debug warnings.
- `flutter test test/app/native_closure_diagnostics_test.dart`: passed 14/14.
- `flutter test test/infrastructure/http_sync_transport_device_header_test.dart`: passed 2/2.
- `flutter test test/infrastructure/http_hosted_connection_check_test.dart`: passed 7/7.
- `flutter test test/infrastructure/native_auth_composition_test.dart`: passed 17/17.
- `flutter test test/infrastructure/native_closure_sync_path_test.dart`: passed 3/3 with Drift debug warnings.
- `npm test -- --runInBand test/protocol.test.ts`: project script ran API test glob; passed 53/53.
- `dart format --set-exit-if-changed lib test`: passed, 93 files, 0 changed.
- `flutter analyze`: passed, no issues.
- `flutter test`: passed 178/178, 4 lab-gated skips, with existing Drift debug warnings.
- `npm run format:check`: passed.
- `npm run lint`: passed.
- `npm run typecheck`: passed.
- `npm run build`: passed.
- `npm audit --omit=dev`: passed, 0 vulnerabilities.
- `git diff --check`: passed before report edits.

## Gate State

- Gate 12.6: BLOCKED/OPEN.
- Gate 12.7: PENDING.
- Retry authorization: NO.
- ordinary Sync authorization: NO.
- provider action authorization: NO.
- corrective implementation authorization: NO.
- terminal: C10_GCM02_GATE_12_6_RECOVERY_CLASSIFICATION_EVIDENCE_REQUIRED.
