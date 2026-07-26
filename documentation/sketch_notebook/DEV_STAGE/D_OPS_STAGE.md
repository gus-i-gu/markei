# D_OPS_STAGE — Step 12 Diagnostic Runtime Completion

Sequence: FLX-ORD-01 — Ordinary Sequence
Role: Codex Operational materialization authority
Unit: C10-GCM02-S12-ERR-02
Branch: `cycle10-intermid-grimoire`
Required ancestry: `0636c54e139fc92b16d1e11b2672d61f42f02f1b`
Authority: Main Chat under explicit human direction
Status: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
Evidence boundary: source, generated artifacts, local/disposable tests, and G/H/I
only; no hosted service, user database, deployment, Sync, Retry, Repair,
Enroll, or provider mutation

## 1. Accepted baseline

Treat C10-GCM02-S12-ERR-01 as partially accepted:

- the versioned 159-code registry is the single diagnostic owner;
- Dart, TypeScript, and Markdown are deterministic projections;
- Drift v11 diagnostic child-event storage exists;
- current-action diagnostics and the two correctly named controls exist;
- `Inspect failed/notApplied recovery` is read-only and network-free;
- the five named hazard fixes are locally test-validated;
- failed/notApplied execution remains absent;
- Gate 12.6 is PASS;
- Gate 12.7 remains held and GCM02 remains open.

Preserve these results and their tests. Do not recreate the catalogue, invent a
second registry, or reinterpret the current failed lineage as unknown-outcome.

## 2. Objective

Close only the residual D/E/F conformance gaps recorded in J:

1. ordinary Sync must emit persistent, typed phase diagnostics rather than
   terminalizing unexpected paths only as `sync-unavailable`;
2. each top-level action must own one unique operation identity and each child
   request/phase event must carry distinct correlation identity, sanitized
   fingerprint, and deterministic ordinal;
3. the persisted v1 envelope must retain the evidence required to distinguish
   local mutation, provider contact, trusted response, provider transaction,
   and local result persistence;
4. public API failures must expose only safe protocol data and a correlation
   fingerprint, while exception class, SQLSTATE class, and full correlation
   identity remain internal;
5. runtime emitters must select precise MKS codes at the boundary that can
   prove them; `MKS-UPL-012` must not remain a generic protocol-failure code.

This is diagnostic completion, not Gate 12.7 execution.

## 3. Ordinary Sync instrumentation

Instrument the real ordinary Sync path, including every entered phase:

```text
authentication
binding
failed-recovery
upload-lease
upload-transport
upload-provider
upload-result-persistence
download-transport
download-provider
download-local-apply
acknowledgement
terminal
```

For each phase:

- persist an ordered child event when entered and when a meaningful outcome is
  known;
- preserve the last proved phase;
- preserve the native code and typed MKS code;
- preserve local mutation, provider contact, trusted response, provider
  transaction, and result-persistence states;
- retain a causal event beneath any coarse UI summary;
- convert catch-all exceptions into a typed, sanitized boundary event;
- always release the action lock and keep the current result visible.

`sync-unavailable` may remain as a summary label only. It must link to, not
erase, the causal diagnostic.

## 4. Operation and correlation requirements

Generate a new random operation identity for every top-level UI action.

Every child phase/request event must have:

- the parent operation identity;
- a distinct full correlation identity used only within its permitted
  internal boundary;
- a public/local sanitized 12-hex correlation fingerprint;
- a deterministic ordinal within the operation;
- a stable operation fingerprint;
- a diagnostic version.

Do not reuse an operation ID as a child correlation ID. Do not reuse a
constant correlation. HTTP children must propagate the full correlation
identity internally and return only its fingerprint publicly.

## 5. Persisted v1 envelope

Extend the existing additive v11 design only as necessary. A forward-only
Drift v12 migration is authorized if required.

Persist bounded fields for:

- diagnostic version;
- protocol and native codes;
- operation kind, phase, and child ordinal;
- operation and correlation fingerprints;
- sanitized account/Device/submission fingerprints when relevant;
- queue counts and member/sequence boundaries when relevant;
- local mutation state;
- provider contact state;
- trusted response state;
- provider transaction state;
- result-persistence state;
- HTTP status and safe header evidence;
- outcome, retryability, and safe action;
- sanitized internal exception class where locally appropriate.

Do not persist tokens, raw identifiers, payloads, complete hashes, private
URLs, SQL, connection strings, exception messages, or stack traces.

Any migration must preserve v1–v11 data, submissions, pending events, cursors,
and purchases unchanged; include a migration-ledger entry; reopen
successfully; and be tested only with in-memory/disposable fixtures.

## 6. API public/internal split

For unexpected public failures, keep a safe response such as:

```text
HTTP 500
code=service-unavailable
outcome=unknown
retryable=false
diagnosticCode=<safe MKS code>
correlationFingerprint=<12 hex>
lastProvedPhase=<safe closed value>
```

Do not expose full correlation IDs, exception classes, SQLSTATE, messages,
stack traces, SQL, payloads, or provider details publicly.

Internal structured diagnostics may retain:

- full correlation identity;
- sanitized exception class;
- SQLSTATE class;
- route class;
- last proved phase;
- provider transaction outcome.

Public and internal projections must be derived from the same typed event.

## 7. Precise attribution

Map reachable failures to the registry at their actual detector boundary:

- AUT: authentication/JWT/JWKS;
- BND: membership, enrollment, account/Device binding;
- CFG: Flutter composition/configuration;
- LDB: Drift open, schema, transaction, diagnostic persistence;
- REC: failed/notApplied candidate and requeue rules;
- QUE: lease and upload-result persistence;
- TRN: DNS/TCP/TLS/timeout/HTTP decode;
- API: route, body, authorization, request contract;
- PDB: PostgreSQL pool/transaction/constraint/commit/rollback;
- UPL: upload protocol/application;
- DNL: download/cursor/application;
- ACK: acknowledgement;
- OBS/INV: cross-boundary unknown outcome and invariant failures.

Use `unknown` or `boundary-only` when evidence does not prove a pathogenic
cause. Never blame Auth0, Render, Neon, or PostgreSQL by proximity.

Audit reachable Sync branches. Replace broad `MKS-UPL-012` use with the exact
registry code. Keep `MKS-UPL-012` only for the partial-provider-batch-commit
hazard it names.

Full emission of all 159 codes is not required when their conditions are not
implemented or reachable. Every reachable detector must, however, use the
correct typed code, and tests must prove representative coverage for every
active layer.

## 8. Tests and validation

Add focused tests proving:

- all ordinary Sync phases create ordered typed evidence;
- a coarse terminal summary retains the causal child event;
- each action has a unique operation identity;
- child correlations are distinct, fingerprinted, and ordinal;
- request-start without trusted response is unknown and not auto-retried;
- provider outcome and local persistence outcome remain separate;
- public API failures omit full correlation ID, exception class, SQLSTATE,
  messages, stack traces, SQL, and payloads;
- internal diagnostics retain permitted sanitized details;
- generic HTTP 500 is not retryable;
- representative AUT/BND/LDB/REC/QUE/TRN/API/PDB/UPL/DNL/ACK/OBS/INV mapping is
  precise;
- `MKS-UPL-012` is not used as a generic protocol error;
- current result remains visible and action locks release on exceptions;
- existing read-only failed inspection remains network-free;
- the five previously accepted hazard regressions still pass;
- migration preservation/reopen passes if v12 is added;
- registry/projection determinism and 159-code equality remain intact.

Run generator update/check, Dart format, build_runner if needed, Flutter
analysis, focused tests, full Flutter tests, TypeScript format/lint/typecheck/
build/full tests, `git diff --check`, and a changed-file sensitive-content
scan. Report exact commands and counts.

## 9. Writable and prohibited scope

Authorized:

- necessary Flutter/API source and tests;
- existing diagnostic registry/generator/projections if schema fields require
  a compatible change;
- additive local migration source and generated Drift output if required;
- `documentation/SYNC_DIAGNOSTICS.md` only through generation;
- replacement G/H/I reports.

Prohibited:

- J, D/E/F after materialization begins, A/B/C, methodology, permanent domain
  memory, and Main-root continuity;
- hosted migrations and live database access;
- deployment or contact with Render/Auth0/Neon;
- Sync, Retry, Repair, Enroll, or failed/notApplied execution;
- Gate 12.7 authorization or GCM02 closure.

## 10. Reporting and completion

Replace G/H/I with unit `C10-GCM02-S12-ERR-02` evidence. Distinguish
repository-proven, test-validated, inferred, host-unavailable, and
provider-unvalidated claims.

Create one focused local commit after validation. Do not push unless explicitly
authorized in that Codex session.

Terminal markers must include evidence-supported variants of:

```text
ORDINARY_SYNC_PHASE_DIAGNOSTICS=IMPLEMENTED_OR_BLOCKED
PARENT_CHILD_CORRELATION=IMPLEMENTED_OR_BLOCKED
DIAGNOSTIC_ENVELOPE_V1=IMPLEMENTED_OR_BLOCKED
PUBLIC_INTERNAL_DIAGNOSTIC_SPLIT=IMPLEMENTED_OR_BLOCKED
REACHABLE_MKS_ATTRIBUTION=VALIDATED_OR_BLOCKED
FAILED_NOT_APPLIED_PREFLIGHT=READ_ONLY
FAILED_NOT_APPLIED_EXECUTION=ABSENT
PROVIDER_ACTION=NOT_PERFORMED
GATE_12_7=HELD_FOR_RECONCILIATION
GCM02=OPEN
```
