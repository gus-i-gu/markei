# I_DSN_CODEX - Gate 12.6 Recovery Classification Design Findings

Sequence: FLX-INV-02 diagnostic report
Role: Codex
Evidence boundary: architecture diagnosis only; no implementation authority

## Responsibility Boundaries

- repository-proven: UI responsibility lives in `NativeClosurePage`: render diagnostics, request preflight, show confirmation only for eligible unknown retry, and avoid mutation on block/cancel.
- repository-proven: diagnostics responsibility lives in `DriftClosureDiagnosticsRepository`: compute queue counts, readiness strings, recent attempts, device summaries, actionable events and unknown retry eligibility.
- repository-proven: local Sync repository responsibility lives in `DriftSyncOutboxRepository`: lease pending/unknown work, persist upload results, validate submission-event membership, and recover failed/notApplied candidates.
- repository-proven: coordinator responsibility lives in `HostedSyncCoordinator`: authenticate, guard enrollment, recover failed/notApplied, upload, download, apply and acknowledge.
- repository-proven: transport responsibility lives in `HttpSyncTransport`: produce `unknownOutcome` when no trusted response exists, or preserve decoded protocol failures as notApplied result codes.
- repository-proven: hosted API responsibility lives in `acceptSubmission` and route mapping: authorize protected operations, run transaction-scoped Sync, return protocol failures such as `service-unavailable`, and map them to HTTP status.
- repository-proven: readiness responsibility is separate in `/health/live` and `/health/ready`; readiness does not exercise protected Sync routes.

## State Machine Findings

- repository-proven: unknown retry and failed/notApplied recovery are intentionally distinct mechanisms.
- repository-proven: unknown retry preserves immutable submission identity and retries the same unknown submission.
- repository-proven: failed/notApplied recovery supersedes the failed submission and requeues validated member events as pending; the subsequent upload creates/uses a new pending submission path.
- repository-proven: `recoverOneFailedNotApplied` blocks ambiguous candidates and malformed candidates.
- repository-proven: ordinary Sync currently combines recovery and transmission in one coordinator operation.
- inferred: because ordinary Sync recovers and then uploads, it crosses the Gate 12.6 freeze boundary even if the user never sees a retry confirmation dialog.

## Retry/Recovery Invariants

- repository-proven: unknown preflight requires no pending/uploading/failed work, exactly one unknown submission, contiguous positions, event rows matching current Account/Device, pending row state `unknown`, valid content hashes, request-hash equality, and next local sequence equal to last event sequence + 1.
- repository-proven: failed recovery requires current Account/Device scope, failed state, `notApplied` outcome, one recoverable candidate, non-empty membership, valid event content hashes, canonical sequence order, no accepted member events, and no other active uploading/unknown submission for those events.
- repository-proven: failed recovery does not expose a user-facing confirmation path in the Closure page. It is invoked by ordinary Sync through the coordinator.
- repository-proven: failed recovery does not explicitly validate the stored request hash for historical failed rows, does not require exact old submission identity reuse, and does not alone assert sequences 1-2/next sequence 3.

## UI Fit for Observed State

- repository-proven: for failed=2 and unknown=0, unknown retry is not eligible and the blocked UI state is expected.
- provisional: the UI does not expose a separate "recover failed not-applied work" action, so the only visible retry-named action is misleading for a failed/notApplied queue.
- inferred: the Gate 12.6 procedure is likely stale if the real local database contains exactly one valid failed/notApplied candidate.
- unavailable: without the copied local database probe, the actual candidate shape cannot be proven from screenshot evidence.

## Drift and Missing Observability

- provisional: Gate wording drift exists between an expected unknown unresolved submission and observed failed events/zero unknown.
- unavailable: UI counts do not reveal whether there is one failed submission owning two events, multiple failed submissions, superseded history, malformed membership, or response-code details.
- unavailable: Closure diagnostics expose latest coordinator result but not the owning submission's response/outcome fields.
- inferred: adding a read-only diagnostic view for sanitized submission outcome/membership would reduce future ambiguity, but implementation is not authorized now.

## Candidate Corrective Designs

Ranked by safety and minimality:

1. procedure-only correction: after copied local evidence confirms exactly one failed/notApplied candidate, Main authorizes a failed/notApplied recovery gate instead of unknown retry. No source change.
2. UI wording correction: change the Closure action surface to distinguish unknown exact-submission retry from failed/notApplied recovery, with separate preflight/result states. Requires tests and explicit implementation authorization.
3. diagnostics observability correction: add sanitized submission summary fields to Closure diagnostics: active failed/notApplied candidate count, member count, first/last sequence, next local sequence and response-code class. Requires privacy review and tests.
4. recovery authorization correction: add an explicit confirmation path for failed/notApplied recovery so ordinary Sync is not the only UI path that can recover and transmit. Requires careful operation-boundary tests.

## Tests Required Before Any Correction

- unknown retry still blocks when failed > 0.
- failed/notApplied preflight confirms exactly one candidate and blocks multiple/malformed candidates.
- failed recovery confirmation cancellation is non-mutating.
- failed recovery confirmation does not transmit unless explicitly confirmed.
- ordinary Sync boundary remains explicit or is disabled during Gate freeze if that is the chosen design.
- diagnostics expose only sanitized counts, short fingerprints and sequence ranges.
- request-hash/membership/sequence-gap cases remain blocked.
- readiness checks remain separate from protected Sync.
- transport absent-response remains unknown, while observed protocol failure remains notApplied.

## Boundaries Preserved

- repository-proven: no source code, tests, migrations, GRIMOIRE, J, A/B/C, D/E/F, permanent domain memory, methodology or provider configuration was modified by this diagnosis.
- unavailable: no user database was accessed, copied, queried, uploaded, edited or repaired.
- unavailable: no Auth0, Render or Neon operation was performed.
- conclusion: corrective implementation is currently unauthorized; Gate 12.7, Retry, ordinary Sync and provider action remain held.
