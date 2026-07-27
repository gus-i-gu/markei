# F_DSN_STAGE — DIAG-01 projection boundaries

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Design materialization stage
> Unit: `C10-GCM02-S12-DIAG-01`
> Branch: `cycle10-intermid-grimoire`
> Required ancestry: `cf405347b6fdc58bf0da698a1f07028e05ccd471`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Evidence boundary: Flutter UI/projection correction only

## 1. Boundary decision

Implement one composition-facing Diagnostics command while preserving distinct
internal responsibilities:

```text
Diagnostics command
├─ authentication state projection
├─ enrollment/binding state projection
└─ local diagnostics snapshot projection

Hosted readiness command
└─ separate network/readiness boundary

Ordinary Sync command
└─ separate stateful protocol boundary
```

The page owns orchestration and presentation. Existing runner/query ports own
state access. Do not move provider, transport, queue, or persistence
responsibility into widgets.

## 2. Operation-aware projection

Build the display model from existing snapshot data:

```text
OperationDiagnosticGroup
  parent fingerprint
  attempt fingerprint
  operation kind
  temporal classification: newest/current or historical
  aggregate terminal/status
  latest proved phase
  has genuine failure
  compact phase summaries
  raw events
```

A dedicated private view model/helper in the Closure page is acceptable. A
small application-level projector is acceptable only if it materially improves
testability and remains free of Flutter widgets. Avoid new layers or files
unless the existing paths cannot own the logic coherently.

Grouping and pairing must be deterministic:

- never merge different parent fingerprints;
- preserve ordinal order within one operation;
- pair declarations only inside the same operation and phase;
- prefer result-bearing evidence for compact presentation;
- retain unpaired declarations truthfully;
- determine failure from severity/terminal evidence, not from row count or MKS
  prefix;
- retain raw events unchanged.

## 3. No persistence or protocol expansion

The existing `ClosureDiagnosticEventSummary` carries sufficient grouping,
ordinal, code, severity, outcome, phase, fingerprint, axis, and safe-action
data. Do not add a Drift migration or server/API contract merely for UI
grouping.

Do not change:

- diagnostic registry ownership;
- lifecycle emission order;
- transport headers;
- server request identity;
- Sync coordinator steps;
- Retry/recovery coordinators;
- Device sequence allocation;
- Last successful Sync predicate.

## 4. Diagnostics aggregate semantics

The consolidated button is a read-only aggregate command, not an opaque
success label. Its result must retain per-subcheck outcomes.

Acceptable architecture:

```text
aggregate diagnostics result
├─ authentication subcheck
├─ enrollment/binding subcheck
└─ local snapshot subcheck
```

If one subcheck fails, project `partial` or the precise blocked state and show
which subcheck failed. Do not let a later successful snapshot erase an earlier
subcheck failure.

Do not add provider calls to strengthen this aggregate. Hosted readiness remains
the separate `Check hosted connection` action.

## 5. Compatibility and validation

Preserve:

- constructor/composition compatibility unless a narrow cleanup is directly
  required;
- existing deep diagnostic history and redaction;
- current MKS registry and generated projections;
- explicit action guards;
- compact/wide responsive behavior;
- all ERR-04 recovery-boundary corrections.

Design tests must cover deterministic grouping, paired-phase reduction,
historical separation, true-failure retention, raw-evidence expansion, and
read-only aggregate behavior.

No source outside Flutter Closure may change unless a directly required
dependency is named in G/H/I and remains within this no-schema/no-API boundary.

## 6. I report

Replace `I_DSN_CODEX.md` with:

- final command/responsibility map;
- grouping model and deterministic rules;
- files changed;
- proof that protocol, schema, API, and provider boundaries did not expand;
- validation evidence and unresolved UI/host risks.

Terminal markers:

```text
DIAGNOSTICS_COMMAND_BOUNDARY=READ_ONLY_OR_BLOCKED
DIAGNOSTICS_SUBCHECKS=SEPARATELY_PROJECTED_OR_BLOCKED
OPERATION_GROUP_MODEL=DETERMINISTIC_OR_BLOCKED
PHASE_PAIRING=TRUTHFUL_OR_BLOCKED
TRUE_FAILURE_RETENTION=PASS_OR_BLOCKED
RAW_EVENT_PRESERVATION=PASS_OR_BLOCKED
HOSTED_READINESS_BOUNDARY=SEPARATE_OR_BLOCKED
ORDINARY_SYNC_BOUNDARY=SEPARATE_OR_BLOCKED
NO_SCHEMA_API_PROVIDER_EXPANSION=PASS_OR_BLOCKED
GATE_12_7=PASSED_PRIOR_SCOPE
GATE_12_8=NEXT_READ_ONLY
GCM02=OPEN
```

Do not edit permanent design memory.
