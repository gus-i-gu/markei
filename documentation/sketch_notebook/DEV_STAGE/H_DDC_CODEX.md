# H_DDC_CODEX — C10-GCM02-S12-ERR-03

Unit: C10-GCM02-S12-ERR-03 within sequence C10-GCM02-S12-SYNC-01
Evidence class: Codex observational report

## Meaning Projection

- repository-proven: Readiness and ordinary Sync now remain didactically separate in UI text and storage interpretation. A live/ready hosted health result is not treated as aggregate Sync success.
- repository-proven: `Last successful sync` now means a completed ordinary-Sync operation with result `sync-completed` or `sync-no-new-events`; hosted connection checks and other Closure attempts are excluded.
- repository-proven: `Recent sync attempts` was renamed to `Recent Closure attempts`, preserving the difference between Sync, health/readiness checks, Retry inspection, and failed/notApplied surfaces.
- repository-proven: The UI exposes client-operation declaration scope, ordinary-Sync operation kind, client result code, last proved phase, client-owned configured deadline, operation fingerprint, and correlation fingerprint.
- repository-proven: API logs expose server-request declaration scope. Server-request completion is a request-level fact and not client ordinary-Sync completion.

## Terminal Vocabulary

- repository-proven: The ordinary-Sync client terminal vocabulary is bounded to `sync-completed`, `sync-no-new-events`, `sync-rejected`, `sync-server-timeout`, and `sync-failed`.
- repository-proven: A client observation deadline before a trusted response is `sync-failed`, with provider outcome unknown.
- repository-proven: `sync-server-timeout` remains a reserved meaning for a proved server-owned deadline with authoritative cancellation or rollback.

## Redaction And Causal Language

- repository-proven: Public API failure bodies continue to omit full correlation IDs, exception classes, SQLSTATE, messages, stack traces, SQL, payloads, and raw IDs.
- repository-proven: Internal lifecycle evidence may retain sanitized exception class, SQLSTATE class, route class, phase, provider transaction outcome, and sanitized lineage fingerprints.
- inferred: The implementation preserves the detector/cause distinction by logging server-request declarations without attributing unknown outcomes to Auth0, Render, Neon, or PostgreSQL unless the specific code path proves that boundary.

READINESS_SYNC_MEANING=SEPARATE
CLIENT_SERVER_SCOPE_MEANING=SEPARATE
FIVE_SYNC_RESULTS=VISIBLE
TIMEOUT_OWNERSHIP=VISIBLE
LAST_SUCCESSFUL_SYNC_LABEL=TRUTHFUL
RECENT_CLOSURE_ATTEMPTS_LABEL=ALIGNED
GATE_12_7=HELD
GCM02=OPEN
