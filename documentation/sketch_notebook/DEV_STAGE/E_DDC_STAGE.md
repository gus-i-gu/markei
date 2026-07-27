# E_DDC_STAGE — DIAG-01 diagnostic meaning

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Didactic materialization stage
> Unit: `C10-GCM02-S12-DIAG-01`
> Branch: `cycle10-intermid-grimoire`
> Required ancestry: `cf405347b6fdc58bf0da698a1f07028e05ccd471`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Evidence boundary: corrected Gate 12.7 client controls and sanitized
> diagnostic record; no provider-state claim

## 1. Meaning correction

The UI must teach the correct distinction:

```text
diagnostic declaration ≠ error
operation group ≠ individual phase row
pre-result unknown ≠ failed terminal
duplicate-equivalent ≠ failure
historical operation ≠ newest operation
Next Device sequence ≠ Sync press counter
```

The newest successful ordinary Sync produced one operation with ordered causal
phase declarations. The apparent “13 ERRs” are a presentation/comprehension
defect, not evidence of 13 protocol failures.

## 2. User-facing vocabulary

Use one top-level action:

```text
Diagnostics
```

Within its result surface, retain separately named subchecks:

- Authentication;
- Enrollment / Device binding;
- Local queue and Next Device sequence;
- Last Sync result and Last successful Sync;
- Recovery guidance;
- Recent operation summaries;
- Devices and actionable events.

Keep these meanings separate:

- `Diagnostics`: read-only client-state projection;
- `Check hosted connection`: hosted readiness request;
- `Sync`: stateful ordinary synchronization;
- `Retry unknown-outcome submission`: explicit same-submission retry;
- failed/notApplied inspection: read-only recovery preflight;
- failed/notApplied recovery: explicit confirmed bounded mutation.

## 3. Default and technical views

Default view:

- group by parent operation;
- label newest/current and historical operations;
- present a concise terminal and ordered phase summary;
- show an explicit status such as `successful`, `failed`, `in progress`,
  `unknown terminal`, or equivalent evidence-backed wording;
- avoid using warning/error styling solely because an MKS code or pre-result
  `unknown` exists.

Expandable technical view:

- retain every sanitized lifecycle row;
- retain MKS/native codes and all causal axes;
- retain parent and child fingerprints;
- explain that raw declarations are ordered evidence, not an error count.

Do not hide a real failed severity or failed terminal. Presentation must reduce
false alarm without converting failure evidence into success.

## 4. Historical distinction

An older operation containing `MKS-REC-001` must remain recoverable as history,
but its group must be clearly marked historical and separated from the newest
ordinary Sync. Never blend events from different parent fingerprints into one
apparent timeline.

## 5. Sequence explanation

Preserve or add concise guidance near Next Device sequence:

> The next sequence is allocated to a new local Device event. Diagnostics,
> readiness, and Sync do not increment it by themselves.

Equivalent compact wording is acceptable.

## 6. Tests and H report

Tests must prove:

- the single Diagnostics label and separate readiness/Sync labels;
- subcheck meaning remains visible;
- a 13-row successful operation is summarized as one successful operation;
- paired pre/result declarations do not create a false failure;
- a genuine failed terminal remains visibly failed;
- historical recovery rows cannot be mistaken for the newest Sync;
- raw technical evidence is accessible;
- no secrets/raw identifiers appear.

Replace `H_DDC_CODEX.md` with materialized vocabulary, comprehension tests,
evidence limits, and terminal markers:

```text
DIAGNOSTIC_DECLARATIONS_NOT_ERROR_COUNT=VISIBLE_OR_BLOCKED
OPERATION_PHASE_HIERARCHY=VISIBLE_OR_BLOCKED
PRE_RESULT_UNKNOWN_NOT_FAILURE=VISIBLE_OR_BLOCKED
HISTORICAL_OPERATION_DISTINCTION=VISIBLE_OR_BLOCKED
NEXT_SEQUENCE_MEANING=VISIBLE_OR_BLOCKED
READINESS_SYNC_DIAGNOSTICS_MEANINGS=SEPARATE_OR_BLOCKED
RAW_EVIDENCE_RETAINED=PASS_OR_BLOCKED
GATE_12_7=PASSED_PRIOR_SCOPE
GATE_12_8=NEXT_READ_ONLY
```

Do not edit permanent didactic memory.
