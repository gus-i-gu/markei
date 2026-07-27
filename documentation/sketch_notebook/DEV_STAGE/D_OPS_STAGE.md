# D_OPS_STAGE — DIAG-01 diagnostics consolidation

> Sequence: FLX-ORD-01 — Ordinary Sequence
> Role: Main-approved Operational materialization stage
> Unit: `C10-GCM02-S12-DIAG-01`
> Branch: `cycle10-intermid-grimoire`
> Required ancestry: `cf405347b6fdc58bf0da698a1f07028e05ccd471`
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Evidence boundary: Gate 12.7 corrected Windows client controls and
> `REC_DIAGNOSTICS.md` Records 004–006 as reconciled into J; no new
> live/provider action

## 1. Objective

Correct the Closure control and diagnostic presentation without changing the
Sync protocol:

1. replace the top-level `Status`, `Query`, and `Refresh diagnostics` controls
   with one `Diagnostics` button;
2. make that button refresh and coherently project authentication,
   enrollment/binding, queue/sequence, persisted Sync result, recovery
   guidance, attempts, devices, and actionable events;
3. group lifecycle rows by parent operation identity and show a compact phase
   summary by default;
4. retain the complete sanitized raw lifecycle behind an expandable technical
   view;
5. keep `Check hosted connection` and `Sync` separate.

The observed 13 rows for operation `d723c1f392f3` are ordered lifecycle
declarations, not 13 failures. Do not rename, delete, or suppress valid MKS
codes to make the count disappear.

## 2. Required source inspection

Before editing, inspect at minimum:

```text
clients/markei_flutter/lib/app/pages/native_closure_page.dart
clients/markei_flutter/lib/app/native_auth_closure_runner.dart
clients/markei_flutter/lib/application/closure_diagnostics.dart
clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart
clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
clients/markei_flutter/test/app/native_closure_surface_test.dart
```

Inspect additional Flutter source/tests only when required by direct
dependencies. Do not scan or modify the protected Python/PySide distribution.
`REC_DIAGNOSTICS.md` may remain an untracked/manual report and is not a
required Codex input; J contains the controlling reconciled conclusions.

## 3. Diagnostics action contract

The new top-level button must be labelled exactly:

```text
Diagnostics
```

Use a stable widget key:

```text
nativeClosure.Diagnostics
```

Remove the three top-level buttons and their keys:

```text
nativeClosure.Status
nativeClosure.Query
nativeClosure.Refresh diagnostics
```

The runner methods may remain internally available for compatibility or
composition, but the page must expose one coherent diagnostics action.

The action must:

- obtain the current authentication projection;
- obtain the current enrollment/binding projection;
- obtain one local diagnostics snapshot;
- publish the refreshed snapshot in one UI state transition;
- remain read-only with respect to Sync events, submissions, cursors,
  acknowledgement state, Device sequence allocation, and provider data;
- make no Sync, Retry, recovery, enrollment, logout, history-clear, or
  readiness request;
- expose subcheck results separately so one failure cannot be mistaken for a
  successful aggregate refresh;
- return a truthful aggregate state such as `diagnostics-ready`,
  `diagnostics-partial`, `diagnostics-configuration-missing`, or an equally
  explicit existing-vocabulary-compatible result.

Avoid duplicate snapshot reads where one snapshot can serve the whole action.
Do not introduce a diagnostic-only provider request.

## 4. Lifecycle presentation contract

Replace the flat default presentation with operation-aware grouping.

Grouping identity priority:

```text
operationFingerprint
→ attemptFingerprint when operation fingerprint is absent
→ explicit unknown-operation bucket only as a last resort
```

For each group, show:

- newest/current versus historical status;
- operation kind;
- parent operation fingerprint;
- aggregate terminal/result when available;
- phase count;
- latest proved phase;
- whether any failure-severity or failed terminal actually exists;
- compact ordered phase summaries.

Pair pre-result/result declarations by operation plus phase. The compact
summary must prefer the most advanced/result-bearing declaration and must not
label a pre-result `unknown` as a failure when a later paired declaration
proves `applied`, `duplicate-equivalent`, or another accepted terminal.

The newest successful operation must be visually distinct from older preserved
operations. An older `MKS-REC-001` row must not appear to belong to the newest
ordinary Sync.

Keep all sanitized raw declarations accessible under an expansion control.
Raw evidence must preserve:

- ordinal;
- MKS/native code;
- phase and last proved phase;
- outcome/severity;
- local mutation, provider contact/transaction, trusted response and result
  persistence axes;
- parent operation and child correlation fingerprints;
- safe action.

Do not change persistence shape or order. This is a projection change.

## 5. Controls that remain separate

Preserve these as distinct actions with their current guards:

```text
Sign in
Enroll
Check hosted connection
Sync
Logout
Retry unknown-outcome submission
Inspect failed/notApplied recovery
Recover failed/notApplied candidate
Clear diagnostic history
```

`Check hosted connection` remains readiness-only. `Sync` remains the stateful
ordinary protocol action. Diagnostics must not invoke either.

## 6. State and sequence invariants

Preserve:

- ordinary Sync never invokes failed/notApplied recovery;
- explicit recovery remains confirmed, bounded, and session-locked;
- unknown Retry remains distinct;
- Next Device sequence advances only when a new local Device event is
  allocated, not when Diagnostics or Sync is pressed;
- Last successful Sync advances only for an accepted ordinary-Sync terminal;
- warm hosted readiness does not advance Last successful Sync;
- queue counts and stored history are not mutated by Diagnostics;
- client deadline remains 35000 ms;
- diagnostic redaction and fingerprinting remain intact.

## 7. Validation

Add or update focused tests proving:

1. exactly one `Diagnostics` top-level button is rendered;
2. `Status`, `Query`, and `Refresh diagnostics` top-level buttons are absent;
3. Diagnostics performs the three intended read-only subchecks/projections;
4. Diagnostics begins no Sync or diagnostic network attempt;
5. Diagnostics leaves queue, next sequence, Last successful Sync, and history
   unchanged;
6. one operation with paired phase declarations renders one compact operation
   group, not a flat apparent-error list;
7. pre-result `unknown` followed by applied/duplicate-equivalent is not
   projected as a failure;
8. raw declarations remain expandable and complete;
9. older operations and `MKS-REC-001` remain visible but clearly historical;
10. readiness and Sync buttons remain separate and retain their tests;
11. existing recovery/Retry confirmation and lock tests pass;
12. no schema/migration/API change occurs.

Run:

```text
dart format <changed Dart files>
flutter test test/app/native_closure_diagnostics_test.dart
flutter test test/app/native_closure_surface_test.dart
flutter test
flutter analyze
git diff --check
```

Run the repository’s existing changed-content sensitive-pattern scan when
available. Do not run a live hosted assay.

## 8. Writable and prohibited scope

Writable:

- directly relevant Flutter Closure source;
- directly relevant Flutter tests;
- G/H/I replacement reports.

Prohibited:

- API source/tests;
- database schema or migrations;
- Auth0, Render, Neon, provider consoles, or user database;
- permanent domain memory;
- methodology;
- J;
- GRM/GRIMOIRE execution documents;
- unrelated formatting or cleanup;
- protected Python/PySide artifacts.

If the requested projection cannot be implemented without a schema migration,
API change, provider request, or broad diagnostics refactor, stop and report
the exact blocker.

## 9. G report requirements

Replace `G_OPS_CODEX.md` with:

- exact inspected baseline and final commit;
- changed paths;
- Diagnostics subcheck implementation;
- grouping/expansion implementation;
- state/sequence invariant evidence;
- commands and exact results;
- skipped/unavailable checks;
- explicit no-live-action statement;
- residual risks, including cold-start readiness tolerance.

Terminal markers:

```text
DIAGNOSTICS_TOP_LEVEL_CONTROL=CONSOLIDATED_OR_BLOCKED
DIAGNOSTICS_PROVIDER_ACTION=ABSENT_OR_BLOCKED
LIFECYCLE_OPERATION_GROUPING=IMPLEMENTED_OR_BLOCKED
RAW_LIFECYCLE_EVIDENCE=PRESERVED_OR_BLOCKED
HISTORICAL_OPERATION_LABELING=IMPLEMENTED_OR_BLOCKED
NEXT_DEVICE_SEQUENCE_INVARIANT=PRESERVED_OR_BLOCKED
LAST_SUCCESSFUL_SYNC_INVARIANT=PRESERVED_OR_BLOCKED
NO_SCHEMA_MIGRATION=PASS_OR_BLOCKED
NO_API_CHANGE=PASS_OR_BLOCKED
GATE_12_7=PASSED_PRIOR_SCOPE
GATE_12_8=NEXT_READ_ONLY
GCM02=OPEN
```
