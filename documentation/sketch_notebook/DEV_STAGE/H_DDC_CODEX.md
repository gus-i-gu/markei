# H_DDC_CODEX — ERR-04 Diagnostic Meaning Evidence

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex didactic evidence
Round or unit: C10-GCM02-S12-ERR-04 within C10-GCM02-S12-SYNC-01
Branch: `cycle10-intermid-grimoire`
Authority: D/E/F synchronized ERR-04 staging
Evidence boundary: repository inspection and local tests only

## Implemented Meanings

- repository-proven: ordinary Sync now means authentication, Device binding, ordinary pending upload, download/apply, acknowledgement, and aggregate terminal persistence. It no longer means failed/notApplied recovery.
- repository-proven: failed/notApplied recovery remains a separate explicit confirmed action; inspection remains read-only, and recovery execution remains outside ordinary Sync.
- repository-proven: `Retry unknown-outcome submission`, `Inspect failed/notApplied recovery`, `Recover failed/notApplied candidate`, hosted readiness, and ordinary Sync remain separate UI/action vocabulary.
- repository-proven: the UI still labels recent mixed history as `Recent Closure attempts`.
- repository-proven: Last successful Sync retains the ERR-03 predicate and is not advanced by hosted readiness.

## Scope-Aware Presentation

- repository-proven: aggregate attempt rows no longer say `status not-observed` or `headers not-received` when the parent attempt row simply does not own per-request HTTP evidence.
- repository-proven: aggregate wording now uses `aggregate HTTP status not applicable - see child requests` and `aggregate response headers not applicable - see child requests` when no parent-owned status/header fact exists.
- repository-proven: the overview labels the child identity as `Client child correlation` and avoids treating a missing local child event as a failed transport observation.
- repository-proven: lifecycle lines distinguish `client-operation`, `client-phase`, and existing API `server-request` scopes.
- repository-proven: server lifecycle lines explicitly distinguish `clientChildCorrelationFingerprint` from `serverRequestFingerprint`.

## Redaction And Comprehension Tests

- test-validated: `native_closure_diagnostics_test.dart` proves ordinary Sync lifecycle lines are JSON, scoped, fingerprinted, deadline-bearing, and redacted from fixture token, authorization text, URL text, event ID, and request hash.
- test-validated: `native_closure_diagnostics_test.dart` proves lifecycle sink failure does not alter the Sync terminal.
- test-validated: `native_closure_diagnostics_test.dart` proves aggregate UI wording no longer exposes the old misleading `status not-observed` phrase.
- test-validated: `protocol.test.ts` proves server lifecycle logs expose separate client-child and server-request fingerprints and do not include injected header text.
- test-validated: full Flutter and API tests preserve the existing five-result Sync vocabulary and redacted public API response shape.

## Evidence Limits

- unavailable: no live provider or Windows terminal assay was performed in this source-only round.
- unavailable: second-device convergence, provider row contents, and future Gate 12.7 authorization remain outside this evidence.
- inferred: a future manual assay should read the new Flutter terminal lines as client-side evidence only; server HTTP 200 lines remain request-scoped evidence only.

## Terminal Markers

```text
ORDINARY_SYNC_RECOVERY_MEANING=SEPARATE
TECHNICAL_SUCCESS_AUTHORIZATION_MEANING=SEPARATE
CLIENT_PHASE_SERVER_REQUEST_SCOPES=VISIBLE
AGGREGATE_HTTP_WORDING=TRUTHFUL
NEXT_SEQUENCE_REPLAY_MEANING=ALIGNED
TERMINAL_LOG_REDACTION=VALIDATED
GATE_12_7=HELD
GCM02=OPEN
```
