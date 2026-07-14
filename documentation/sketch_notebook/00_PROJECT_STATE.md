# 00_PROJECT_STATE.md

> Version: Cycle 09 Main closure 2.0
> Status: Active Global State Canon-Checkpoint
> Persistence Class: Canon-Checkpoint
> Knowledge Class: Main / Global
> Authority: Main Chat [M]
> Branch: `intermid-cycle-recovery`
> Reconciled implementation: `1d817972aea0229c9f109f236f4d224671927aab`
> Post-Codex J: `4bf2e52d9d3e23437c4da1d8bb05e2402e189dd5`
> Permanent-domain head inspected: `d21507ad8cd1ce69bbb6768d2583bb1a84a5af44`
> Scope: Current global state after Cycle 09 closure

---

<!-- TEMPORAL_MARKER:C09-MAIN-CLOSURE-2026-07-14 -->

# Cycle 09 — Main Closure State

## 1. Current milestone

Cycle 09 is reconciled and closed on `intermid-cycle-recovery`.

```text
Cycle 08 / Intermid recovery foundation: closed
Cycle 09 Sprint 01 local expansion: reconciled
Cycle 09 Sprint 02 functional correction: reconciled
Cycle 09 implementation: complete at 1d81797
post-Codex Main reconciliation: complete at 4bf2e52
Design permanent promotion: complete through 8203ef6
Didactic permanent promotion: complete at df1df60
Operational permanent promotion: complete through d21507a
Cycle 10 forward checkpoint: prepared; implementation inactive
Cycle 11 UI/UX convergence: explicitly deferred
```

The protected Python/PySide6 beta and its database remain isolated and recoverable.

## 2. Accepted application state

The active Flutter/Drift local beta includes:

- Home, Lists, Purchase, History, Catalogue and Settings under adaptive navigation;
- schema v4 with Account-scoped immutable Person `@001...` and Payment Method `#001...`
  visible references while opaque UUIDs remain relational identity;
- optional Person and Payment Method Purchase references;
- mandatory normalized Account-scoped immutable Product codes;
- manual Purchase occurrence date/time distinct from insertion time;
- exact Product-code lookup and autofill without implicit Item addition;
- PACKAGED/BULK distinction, supported units and comma/point numeric input;
- same-unit BULK price-rate calculation with read-only half-up line total;
- transient Storage/Shortage/Market/All projections derived from registered history;
- Catalogue selection/detail and History multi-selection/detail increments;
- deterministic selected-Purchase CSV and PDF generation;
- typed application failure infrastructure;
- a small SDK-first theme/component foundation and compact navigation.

No authentication, cloud/API/Neon path, remote analytics, external data retention or real
synchronization was introduced.

## 3. Evidence boundary

Reported Cycle 09 Sprint 02 evidence at `1d81797`:

```text
Flutter tests                              43 passed
Flutter analysis                           no issues
schema-v4 migration tests                  passed
Windows release build                      passed
Windows bounded hidden launch              passed
protected Python tests                     5 passed
Android build/runtime                      host-unvalidated: Java unavailable
```

The Windows evidence is build/smoke evidence, not complete manual workflow or visual
acceptance. Android is host-unvalidated, not failed. Manual keyboard, focus, text-scale,
screen-reader, compact-device lifecycle and production-release evidence remain absent.

## 4. Domain reconciliation

Operational memory accepts the functional increment and named evidence while retaining
platform, recovery, visual and maintainability actions. Didactic memory stabilizes the
identity, occurrence, lookup, BULK, Lists and evidence vocabulary without changing learner
maturity. Design memory accepts schema-v4 and application-boundary decisions while recording
the visual architecture as partial.

Main continuity summarizes those owners; it does not replace them.

## 5. Closed, partial and deferred state

Closed within the stated boundary:

- visible local-reference sequences and optional Purchase references;
- non-null immutable Product codes and exact-code autofill;
- manual occurrence date/time;
- same-unit BULK derived total;
- narrow Lists availability-language correction;
- Catalogue/History functional interaction increments;
- automated Flutter/migration evidence and Windows build/smoke.

Partial and carried forward:

- migration failure/no-silent-reset and complete recovery evidence;
- deterministic export artifact lifecycle and portability policy;
- measured Lists, lookup, History and export performance;
- manual Windows workflow and Android build/install/runtime/lifecycle evidence;
- Purchase (~1,020 lines), Catalogue (~377) and History (~330) modularity debt.

Deferred to Cycle 11 by human direction:

- target-image UI polishing and page-level visual convergence;
- full responsive Lists table/card/filter composition;
- page adoption of the shared Markei component system;
- History double-click UX correction and Product-detail UX refinement;
- native-share presentation and broader accessibility/interaction improvement;
- the separately proposed minimum Analytics page.

Still outside immediate authority: authentication, API/Neon, synchronization, Household
behavior, registered Purchase mutation, Product merge/correction, public release, signing,
distribution and PySide6 retirement.

## 6. Cycle 10 direction and authority

Cycle 10 is **Cross-Platform Local Beta Consolidation**. Its forward mission is to improve
reliability and evidence without redesigning the visible product:

1. freeze a Cycle 10 baseline and acceptance matrix;
2. strengthen migration, reopen, rollback and no-silent-reset evidence;
3. establish deterministic local export/recovery integrity and privacy boundaries;
4. measure projection, lookup, History and export paths before optimization;
5. extract oversized pages without intentional UI or behavior changes;
6. record complete Windows functional and bounded Android platform evidence;
7. reconcile domain and Main memory.

Cycle 10 source authority is inactive until fresh A/B/C investigation, Main reconciliation
and controlling D/E/F are prepared. Cycle 09 D/E/F are consumed.

## 7. Active risks

- platform confidence exceeds neither the named Windows build/smoke nor the blocked Android host;
- incomplete migration/recovery evidence can hide destructive failure behavior;
- export exists, but portability, destination and cleanup policy are not fully evidenced;
- monolithic page files increase regression risk for later Cycle 11 recomposition;
- the existing visual scaffold may be mistaken for accepted target aesthetics;
- release, cloud and synchronization language must remain inactive.

## 8. Recovery route

Read next:

1. `06_SESSION_SCHEME.md` for Cycle 10 preparation and entry gates;
2. `operational/10_OPERATIONAL_STATE.md` for execution evidence and remaining actions;
3. `design/09_DESIGN_STATE.md` for accepted architecture and visual/modularity debt;
4. `didactics/08_CONCEPT_MAP.md` for stable vocabulary and unchanged maturity;
5. `[M]_STAGE/J_MAIN_STAGE.md` for post-Codex classifications;
6. G/H/I or source only when the checkpoints cannot resolve a claim.

```text
Cycle 09: closed
Cycle 09 materialization authority: consumed
Cycle 10: prepared, not yet activated for implementation
Cycle 11 UI/UX convergence: deferred and preserved
```
