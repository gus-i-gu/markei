# I_DSN_CODEX - Gate 12.6 Failed-Recovery Transition Boundary

Sequence: FLX-PRM-04 - Promotion/Reconciliation
Role: Codex design report
Evidence boundary: architecture diagnosis only; no implementation, provider,
database, Retry, ordinary Sync, or Gate 12.7 authorization is granted.

## Responsibility Boundaries

- repository-proven: UI responsibility is `NativeClosurePage`: render
  diagnostics, run unknown-retry preflight, show confirmation only when
  eligible, and avoid mutation on blocked preflight or cancel.
- repository-proven: diagnostics responsibility is
  `DriftClosureDiagnosticsRepository`: compute queue counts, readiness,
  recent attempts, device summaries, actionable events, and unknown retry
  eligibility.
- repository-proven: local Sync repository responsibility is
  `DriftSyncOutboxRepository`: lease pending/unknown work, persist upload
  results, validate submission-event membership, and recover failed/notApplied
  candidates.
- repository-proven: coordinator responsibility is `HostedSyncCoordinator`:
  authentication, guard, failed recovery, upload, download, acknowledgement,
  and terminal projection.
- repository-proven: transport responsibility is `HttpSyncTransport`: map
  absent trusted upload response to `unknownOutcome`, and decoded protocol
  failure bodies to notApplied result codes.
- repository-proven: hosted API responsibility is protected Sync execution,
  not public readiness. Readiness proves route availability, not submission
  application.

## State Machine

| Phase                     | Evidence class    | Boundary                      | Precondition                                                                          | Post-state                                       | Six pending events                                                |
| ------------------------- | ----------------- | ----------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------ | ----------------------------------------------------------------- |
| Guarded coordinator entry | repository-proven | local/provider read           | authenticated, enrolled device                                                        | continue or blocked terminal                     | not touched                                                       |
| Failed recovery call      | repository-proven | local transaction             | coordinator invokes `recoverFailedNotApplied()` before upload                         | no-op, available, or blocked                     | not uploaded yet                                                  |
| Candidate validation      | repository-proven | local read                    | current Account/Device, failed state, `notApplied`, exactly one recoverable candidate | candidate accepted or blocked                    | unrelated pending not checked globally                            |
| Submission supersession   | repository-proven | local mutation                | valid failed candidate still failed/notApplied                                        | failed submission becomes `superseded`           | not touched unless member rows                                    |
| Event requeue             | repository-proven | local mutation/no-op          | member rows valid and not accepted                                                    | member events become/remain `pending`            | can join same-scope pending queue later                           |
| Pending upload            | repository-proven | local mutation plus transport | recovery did not block; pending rows exist in scoped outbox                           | new uploading submission created and sent        | yes, if in same Account/Device scope and within lease order/limit |
| Download                  | repository-proven | provider/local                | upload did not block                                                                  | remote events applied or unavailable/interrupted | independent after upload                                          |
| Acknowledgement           | repository-proven | provider/local                | download did not block                                                                | cursor acknowledged or terminal blocker          | independent after download                                        |

Failure in recovery, upload, download, or acknowledgement stops later phases via
`HostedSyncCoordinator._blockedBy` or exception handling.

## Invariants And Findings

- repository-proven: unknown Retry and failed/notApplied recovery are
  intentionally distinct branches.
- repository-proven: unknown Retry requires no pending/uploading/failed work,
  exactly one unknown submission, matching Account/Device, contiguous
  membership, unknown member state, request-hash equality, and matching next
  local sequence.
- repository-proven: failed recovery requires current Account/Device, exactly
  one recoverable failed/notApplied candidate, non-empty valid membership,
  canonical event sequence, no accepted member events, and no other uploading or
  unknown active submission for those member events.
- repository-proven: failed recovery does not reuse the failed submission as
  the next upload identity; after requeue, the pending path creates a new upload
  submission and request hash.
- repository-proven: ordinary Sync currently combines recovery and transmission.
  The Closure UI exposes unknown Retry, not a separate failed-recovery-only
  operator surface.
- inferred: the UI does not expose the correct narrowly isolated recovery action
  for the observed failed/notApplied state.

## Implementation Drift And Observability

- inferred: Gate 12.6 wording drift exists because the observed queue is
  failed/notApplied while the visible retry control targets unknown submissions.
- unavailable: GS-SQLITE-03 does not identify the anonymized failed-candidate
  device scope, that scope's next sequence, or pending-work distribution.
- inferred: `GS-SQLITE-04` is the minimal no-mutation observability addition:
  it can report anonymized ranks, counts, booleans, statuses, sequence ranges,
  and safe equality counts from the preserved copied database.
- prohibited: adding a source-level failed recovery preflight or UI action is
  outside this round.

## Candidate Corrective Designs

1. Procedure-only: use GS-SQLITE-04 output to finish a Gate 12.7 authorization
   packet without source changes. Safest and authorized as documentation only.
2. UI wording: split "unknown exact retry" from "failed/notApplied recovery" in
   Closure. Requires explicit implementation authority and widget tests.
3. Diagnostics observability: add sanitized failed-candidate scope fields to
   Closure diagnostics. Requires privacy review and tests.
4. Operation split: add a failed-recovery-only confirmation path that cannot
   immediately upload. Larger behavior change; requires state-machine tests.

## Tests Required Before Any Correction

- failed/notApplied preflight accepts exactly one candidate and blocks zero,
  multiple, malformed, cross-scope, accepted-member, sequence-gap, and
  hash/membership mismatch cases.
- UI cancellation for failed recovery is non-mutating.
- failed recovery without explicit upload does not transmit.
- ordinary Sync boundary is either held during Gate freeze or explicitly
  authorized by tests and operator evidence.
- diagnostics emit only sanitized counts, ranks, booleans, short fingerprints,
  and sequence ranges.
- transport keeps absent-response outcomes unknown and decoded protocol failures
  notApplied.

## Gate 12.7 Authorization-Packet Skeleton

This skeleton is not authorization.

```text
Branch: cycle10-intermid-grimoire
Source baseline: 8ee181954a99faddaff8f8517646dc2c6cbc1130
Copied-database freshness: human-observed copy from GS-SQLITE-02/03; exact
  scope correlation PENDING
Candidate anonymized rank: PENDING
Candidate hosted/current scope match: PENDING
Candidate device next_sequence: PENDING
Candidate submission state/outcome: failed/notApplied
Candidate response/error representation: conflict/service-unavailable legacy
Candidate event count: 2
Candidate sequence range: 1-2
Candidate member positions: 0-1
Candidate member pre-state: failed
Other pending-work counts by anonymized scope: PENDING
First upload after recovery would include: PENDING
Request identity/hash reuse/equality: PENDING
Proposed phases: failed recovery -> upload -> download -> acknowledgement
Expected local deltas: failed submission superseded; member events pending or
  uploading after lease; exact deltas PENDING
Expected provider deltas: PENDING
Allowed terminal results: PENDING
Mandatory stop results: PENDING
Evidence-capture order: PENDING
No-second-action rule: PENDING
Retry authorization: NO
ordinary Sync authorization: NO
provider action authorization: NO
GCM-02 closure authorization: NO
```

## Terminals

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
