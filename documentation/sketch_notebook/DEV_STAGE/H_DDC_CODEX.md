# H_DDC_CODEX - Gate 12.6 Recovery Classification Vocabulary

Sequence: FLX-INV-02 diagnostic report
Role: Codex
Evidence boundary: observational report only; no semantic promotion or didactic memory edit

## Core Distinctions

- repository-proven: readiness health is not protected-operation success. `/health/live` means the API process answered; `/health/ready` means the readiness contract returned ready. Neither endpoint uploads a Sync submission or proves the preserved events were applied.
- repository-proven: protected Sync success requires the guarded `/v1/sync/submissions` route, transaction authorization, server-side event acceptance, and local persistence of an accepted/duplicate-equivalent result.
- repository-proven: `unknownOutcome` means the client transport did not obtain a trusted upload response. In the current transport, timeout and client exception map here, and the local submission/event rows remain `unknown`.
- repository-proven: `notApplied` is a protocol outcome returned from a decoded failure body. When persisted by the local outbox, non-unknown/non-accepted result codes become failed local work.
- repository-proven: `service-unavailable` is one notApplied protocol code. It can be returned by the API for missing Account cursor state, and the HTTP mapper sends it as 503.
- repository-proven: `sync-unavailable` is a Closure/coordinator terminal state, not a direct submission outcome. It records the runner's projection after the coordinator stops on an unavailable condition.
- repository-proven: `provider-evidence-unavailable` is recovery guidance for unavailable coordinator states. It does not prove the provider did or did not apply the original submission.

## Preflight, Dialog, Transmission

- repository-proven: preflight is local eligibility checking before UI confirmation.
- repository-proven: confirmation dialog appears only after eligible unknown retry preflight.
- repository-proven: blocked preflight opens no dialog and starts no Sync attempt.
- test-validated: widget tests prove blocked retry preflight is non-mutating and does not show the confirm button.
- test-validated: cancellation after an eligible dialog does not start Sync.
- inferred: pressing ordinary Sync is more powerful than opening the unknown retry dialog because ordinary Sync invokes failed/notApplied recovery before upload.

## Proven, Inferred, Provisional, Unavailable

- proven: failed event count > 0 blocks unknown retry preflight as `unknown-retry-queue-not-isolated`.
- proven: notApplied upload results are persisted as failed local state; unknown upload results are persisted as unknown local state.
- proven: hosted connection ready does not prove protected Sync completion.
- inferred: the observed UI state is consistent with a failed/notApplied queue rather than an unknown queue.
- provisional: if the copied database confirms one failed/notApplied submission owning events 1-2, Gate 12.6's unknown-retry procedure is stale for the current state.
- unavailable: the screenshot alone does not expose `sync_submissions.outcome`, `response_code`, `error_code`, membership cardinality, request hash equality, or exact owning submission identity.
- unavailable: provider logs/database evidence were not inspected and must not be inferred from local tests.

## Decision Tree

1. repository-proven: if local copied evidence shows exactly one failed/notApplied submission owning events 1-2, with valid membership and next local sequence 3, classify the queue as failed/notApplied and route Main to a failed-recovery authorization decision, not unknown retry.
2. repository-proven/inferred: if local copied evidence shows `unknown` submission/event state and `unknownOutcome`, unknown retry remains the correct mechanism and the current screenshot/counts require drift reconciliation.
3. provisional: if local copied evidence shows failed state without notApplied response evidence, malformed membership, multiple candidates, request/hash inconsistency, or sequence gaps, keep Gate 12.6 blocked and require further diagnosis.
4. unavailable: if local state cannot explain whether a trusted protected Sync response was observed, request a bounded sanitized provider log correlation window.

## Terminology for Main

Main should preserve:
- "human-observed screenshot evidence" for UI fields;
- "repository-proven source behavior" for inspected code paths;
- "test-validated local behavior" for named test results;
- "coordinator-level projection" for `sync-unavailable`;
- "protocol failure response" for decoded failure bodies such as `service-unavailable`;
- "unknown transport outcome" for no trusted response before client classification;
- "failed/notApplied recovery" for `recoverOneFailedNotApplied`;
- "unknown exact-submission retry" for `unknownSubmissionRetryPreflight` and unknown submission reuse.

## Conceptual Ambiguity

- provisional: the current UI exposes a button named `Retry unresolved submission`, but the observed state reports failed work, not unknown work. The label and Gate 12.6 wording can steer the operator toward an unknown-retry procedure that is not eligible for a failed/notApplied queue.
- provisional: `sync-unavailable/provider-evidence-unavailable` can be misunderstood as the original submission result. It is safer to describe it as a later diagnostic/coordinator record unless local submission rows prove otherwise.
- unavailable: no permanent didactic maturity is claimed; no KANBAN, glossary or concept-map update is authorized.
