# H_DDC_CODEX — C10-GCM02-S12-ERR-02

Unit: C10-GCM02-S12-ERR-02 — Step 12 Diagnostic Runtime Completion
Evidence class: repository-proven and test-validated locally unless marked otherwise.

## Meaning Changes

- repository-proven: ordinary Sync no longer depends only on `sync-unavailable` as the visible explanation. The generic terminal result can remain, but recorded child evidence preserves the causal MKS event beneath it.
- repository-proven: UI-visible diagnostics now include MKS code, title, meaning, outcome, last proved phase, local mutation, provider contact, trusted response, safe action and operation fingerprint.
- repository-proven: expandable details remain sanitized and bounded to closed values, counts, phases, ordinals and fingerprints.
- repository-proven: recent diagnostic timeline rows expose phase progression without raw IDs, payloads, tokens, URLs, SQL, stack traces or full hashes.

## Causal Language

- repository-proven: request-start without trusted provider outcome is recorded as unknown, with provider transaction state `unknown`.
- repository-proven: local preflight and no-request paths remain blocked/local rather than provider-attributed.
- repository-proven: provider result and local result persistence have separate state axes.
- repository-proven: API 500 responses say `service-unavailable` and `outcome=unknown` without claiming Auth0, Render, Neon or PostgreSQL caused the failure.
- inferred: precise pathogenic cause remains `unknown` or boundary-only unless the boundary can prove it.

## Public and Internal Projection

- repository-proven: public unexpected API responses expose `code`, `diagnosticCode`, `operation`, `phase`, `outcome`, `retryable`, `safeAction`, `correlationFingerprint` and `lastProvedPhase`.
- test-validated: public API response fixtures omit full correlation IDs, exception classes, SQLSTATE, messages, stack traces, SQL, payloads and raw IDs.
- test-validated: internal lifecycle evidence may retain permitted sanitized exception class and provider transaction outcome while public output omits them.
- repository-proven: public correlation fingerprints are 12 lowercase hex characters.

## Generated Documentation Alignment

- repository-proven: the 159-code registry remains under `contracts/shared_beta/diagnostics_v1/`.
- test-validated: `node scripts/generate_sync_diagnostics.mjs`, `node scripts/generate_sync_diagnostics.mjs --check`, and package `npm run diagnostics:check` passed.
- repository-proven: no second diagnostic catalogue was created.
- inferred: not all 159 meanings are runtime-emitted; the registry is broader than current reachable detectors by design.

## UI Meaning Boundary

- repository-proven: Native Closure still distinguishes current action, Sync overview, local queue, recent sync attempts, recent diagnostic timeline, devices and actionable events.
- repository-proven: `Retry unknown-outcome submission` remains distinct from `Inspect failed/notApplied recovery`.
- repository-proven: failed/notApplied inspection remains labeled read-only and non-provider in behavior.
- test-validated: current result remains visible through Closure runner/UI tests, and exceptional paths release the action lock.

## Terminal Markers

```text
CAUSAL_DIAGNOSTIC_MEANING=IMPLEMENTED
GENERIC_SUMMARY_PRESERVES_CAUSE=VALIDATED
PUBLIC_DIAGNOSTIC_REDACTION=VALIDATED
GENERATED_DOCUMENTATION=ALIGNED
GATE_12_7=HELD
GCM02=OPEN
```
