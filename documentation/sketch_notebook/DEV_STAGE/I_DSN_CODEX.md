# I_DSN_CODEX - C10-GCM03-S10-R04

## Architecture Summary

R04 replaces replaceable diagnostic-event selection with recorder-owned cumulative causal state inside `NativeAuthClosureRunner`.

The cumulative state is in-memory, per operation, and updated synchronously before diagnostic event persistence is awaited. Diagnostic persistence is therefore observational and best-effort; it cannot erase already-proved operation truth.

## Cumulative State

The recorder accumulates:

- latest entered phase;
- latest proved phase;
- provider contact and provider transaction state;
- trusted-response state;
- local mutation committed, rolled-back, unknown, or none;
- result-persistence/degradation state;
- acknowledgement phase/result as an independent progression;
- bounded outcome/result, retryability, safe next action, and sanitized exception class;
- already-authorized counts, sequences, and fingerprints.

The existing external `SyncDiagnosticPhaseEvidence` shape remains the snapshot boundary, so no schema, API, payload, auth, enrollment, configuration, dependency, or migration change was introduced.

## Merge Laws

- Trusted `received` is monotonic and cannot regress to `not-received`, `unknown`, defaults, or `see-causal-event`.
- Committed local mutation cannot be erased by acknowledgement-request or terminal evidence.
- Proved rollback cannot be silently rewritten.
- Authoritative committed/rolled-back contradiction becomes a bounded `diagnostic-invariant-conflict`.
- Acknowledgement advances independently from download/apply truth.
- Terminal placeholder fields do not erase earlier causal facts.
- Runner exceptions add bounded terminal result and sanitized exception class without rewriting earlier provider, response, apply, cursor, or acknowledgement proof.
- Latest entered phase can advance while earlier proved facts remain retained.
- Evidence strength is not inferred from arbitrary strings or severity alone.

## Persistence Boundaries

- Begin failure creates a recorder with degradation already active when no durable attempt row exists.
- Row/event write failure marks degradation and does not throw through Sync coordination.
- Attempt-completion failure marks degradation after the core result is established.
- Final lifecycle projection uses the recorder's actual cumulative degradation state and emits `diagnostics-persistence-degraded`.
- Diagnostic degradation does not change committed versus rolled-back transaction truth.
- Diagnostic degradation cannot manufacture provider success or acknowledgement success.
- Diagnostic write failure is not recursively diagnosed.

## Acknowledgement Ordering

Acknowledgement remains ordered after committed contiguous cursor proof.

Failed, rejected, rolled-back, or unproved apply remains acknowledgement-ineligible. A committed apply remains acknowledgement-eligible when only diagnostics are degraded. If acknowledgement transport fails after committed apply, local transaction truth remains committed and the runner/lifecycle evidence retains the prior trusted response and local commit.

## Product And Apply Architecture

R03 Product reconciliation architecture is retained:

- exact semantic Product identity under another user code reuses the local Product and preserves local display/code;
- same-code/different-identity, split-key, ambiguity, and established-UUID mutation remain bounded conflicts;
- dependent Purchase Items use the remote-to-local Product map;
- facts, inbox, and cursor remain inside one Drift transaction.

Two minimal test-only seams were added:

- Product resolver seam to exercise ambiguity branches that production uniqueness prevents from normal row construction.
- Apply-failure seam to inject an arbitrary exception inside the existing Drift transaction before fact writes.

Both seams are annotated for testing, keep production constructors unchanged, and do not weaken production constraints.

## Compatibility And Non-Goals

No live Sync, Retry, Recovery, Query, enrollment, live acknowledgement, new Purchase registration, diagnostic clearing, provider mutation, schema/API/auth/dependency/configuration change, branch creation, rebase, force push, or PR was performed.

R04 does not promote MVP Sync acceptance, Android Sync, Windows Sync, Retry/Recovery, or GCM03 closure. Those remain subject to Main reconciliation and a separately authorized preserved-state human assay.

## Residual Design Risk

The remaining risk is evidence-class risk, not source architecture risk: this change is validated by deterministic local tests and builds, but not by live provider or preserved-state human-assay execution.
