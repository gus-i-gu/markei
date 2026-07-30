# 06_SESSION_SCHEME.md

> Version: Cycle 11 forward checkpoint 3.0
> Status: Active Forward Checkpoint — preparation only
> Persistence Class: Forward Checkpoint
> Knowledge Class: Main / Prospective
> Authority: Main Chat [M]
> Branch: `grm-guarded-provisioning-20260727`
> Cycle 10 source baseline: `97cec7f733926f669d2a844feb2b5e6e0b7e6bce`
> Cycle 10 GCM03 closure: `05e630cfe04aa03846bc635c524278d4fa9b7c39`
> Current-state source: `00_PROJECT_STATE.md`

---

<!-- TEMPORAL_MARKER:C11-PREPARATION-2026-07-30 -->

# Cycle 11 — Product Surface, UX and Functional Analytics

## 1. Status and activation route

Cycle 10 is closed at the GCM03 two-Device development scope. Cycle 11 is
prepared for fresh A/B/C investigation; source authority is inactive.

```text
INDEX and methodology boot
→ Cycle 10 Main closure and current domain checkpoints
→ inspect five reference PNGs and current Flutter pages
→ fresh A/B/C C11 investigation
→ Main J reconciliation
→ synchronized D/E/F
→ bounded Codex materialization
→ G/H/I plus Windows/Android human validation
```

Old Cycle 10 D/E/F must not be reused.

## 2. Mission

> Make Markei’s Flutter product surface coherent, intuitive and functional on
> desktop and mobile by applying the archived visual language, improving UX,
> introducing mandatory Settings and Audit pages, and implementing local
> Analytics without reopening postponed backend lifecycle scope.

## 3. Controlling reference set

Read and compare all five files:

```text
DEV_STAGE/references/c09_s02/01_lists_target.png
DEV_STAGE/references/c09_s02/02_catalogue_target.png
DEV_STAGE/references/c09_s02/03_home_target.png
DEV_STAGE/references/c09_s02/04_purchase_target.png
DEV_STAGE/references/c09_s02/05_history_target.png
```

They establish:

- responsive desktop rail and compact mobile navigation;
- green/purple semantic hierarchy and warm surfaces;
- reusable cards, filters, summaries, status chips and action groups;
- table-to-card adaptation rather than simple widget shrinking;
- explicit loading, empty, error and selection states;
- readable information density and progressive disclosure.

They are design targets, not authority to invent unsupported data, remote
telemetry, Household behavior or destructive edit/delete operations.

## 4. Mandatory product pages

### Settings

Settings must be always available in ordinary navigation and reorganize current
People, Payment Methods and shortage-threshold controls into intuitive
sections. A/B/C must decide the bounded placement of:

- local preferences and list thresholds;
- People and Payment Method lifecycle;
- account/authentication and enrolled Device summary;
- Sync controls and safe connection state;
- data/export/privacy/support;
- Advanced diagnostics only where appropriate.

Settings must distinguish configuration from last-observed health and must not
reconstruct provider truth in widgets.

### Audit

Audit is always available and replaces the ordinary Closure navigation page.
It should present understandable operation history, Sync outcomes, queue
state, grouped causal/lifecycle detail and safe filtering/export from existing
truth.

Fresh Design/Operational investigation must classify each current Closure
action:

```text
retain in Audit
move to Settings/Advanced
keep development-only
remove from ordinary product navigation
```

The replacement must not delete required diagnostics, authentication,
enrollment, Sync or recovery capabilities before their new owner and tests are
defined.

### Analytics

Analytics becomes functional and local/account-scoped. At minimum investigate:

- total spending over selectable periods;
- spending by Store, Product/category, Person and Payment Method where data
  exists;
- price and purchase-frequency trends;
- reusable filters and empty/insufficient-history states;
- History “Move to Analytics” selection/context handoff;
- deterministic calculations with explicit currency and time boundaries.

Analytics is user-owned product analysis. It is not remote usage telemetry and
must not introduce developer-side behavioral collection.

## 5. Existing page recomposition and UX

C11 includes Home, Lists, Purchase, Catalogue and History convergence toward
their archived targets, plus shared shell/component adoption.

Investigation must preserve implemented facts and explicitly decide:

- adaptive navigation and information architecture;
- desktop tables versus mobile cards;
- filtering, sorting, selection and detail disclosure;
- Purchase staging/review/error presentation;
- Catalogue similarity/identity interactions;
- History filtering, double-click, export/share and Analytics handoff;
- loading, empty, validation, partial and retry states;
- keyboard, focus, text-scale and screen-reader behavior.

## 6. Suggested bounded phases

```text
C11-PH01  Baseline, information architecture and shared responsive shell
C11-PH02  Settings and Audit ownership/design, including Closure disposition
C11-PH03  Functional local Analytics and History handoff
C11-PH04  Home/Lists/Purchase/Catalogue/History target convergence
C11-PH05  UX, accessibility and cross-platform human acceptance
C11-PH06  Reconciliation, domain promotion and C12 handoff
```

Main may reorder these after A/B/C if dependency evidence supports a safer
sequence. Settings/Audit ownership should be settled before deleting or
renaming the Closure page.

## 7. Explicit non-goals

- GCM04 live or implementation work;
- a second Account or multi-user assay;
- membership/Device revocation;
- provider outage or exact-once recovery assay;
- retention, snapshot or rebootstrap;
- production release or hosted operational acceptance;
- R07 causal-engine activation;
- Household implementation;
- automatic Retry/Recovery;
- external analytics/telemetry;
- unrelated schema/provider mutation.

## 8. C11 exit direction

Cycle 11 may close only when:

- Settings, Audit, Analytics and the existing core pages are reachable through
  one coherent responsive shell;
- Settings and Audit have tested truth/ownership boundaries;
- functional Analytics derives deterministically from local accepted data;
- the five target pages materially converge at desktop and compact widths;
- existing Purchase, Sync and local-data invariants retain regression evidence;
- Windows and Android human workflows are recorded;
- accessibility and unresolved visual gaps are explicit;
- C12-PH01 receives measured polishing work rather than vague redesign;
- C12-PH02 retains GCM04/backend multi-user work without accidental activation.

## 9. Entry terminal

```text
CYCLE10=CLOSED_GCM03_DEVELOPMENT_SCOPE
CYCLE11=PREPARED_FOR_A_B_C
C11_SOURCE_AUTHORITY=INACTIVE
C11_SETTINGS=MANDATORY
C11_AUDIT=MANDATORY_REPLACES_CLOSURE_NAVIGATION
C11_ANALYTICS=FUNCTIONAL_LOCAL
C11_REFERENCE_SET=FIVE_C09_S02_PNGS
GCM04=DEFERRED_TO_C12_PHASE02
R07_IMPLEMENTATION_AUTHORIZED=NO
LIVE_SYNC_AUTHORITY=NONE
```

---

<!-- TEMPORAL_MARKER:C10-PREPARATION-2026-07-14 -->

# Cycle 10 — Cross-Platform Local Beta Consolidation

## 1. Status

Cycle 09 is closed. Cycle 10 is prepared as the next investigation cycle but has no active
source, schema, dependency or host-mutation authority.

Activation requires:

```text
clean shared branch
→ complete methodology boot
→ fresh A/B/C investigation
→ Main J reconciliation
→ controlling D/E/F
→ bounded Codex materialization
```

Cycle 09 D/E/F are consumed and must not be reused.

## 2. Governing schedule decision

Human direction moves UI polishing and UX improvement to Cycle 11. Cycle 10 must not silently
reintroduce the deferred visual scope as “consolidation.”

Deferred to Cycle 11:

- target-image page recomposition and visual polish;
- full responsive Lists tables/cards/filters and summary presentation;
- page-level adoption/expansion of Markei design components;
- History double-click and Product-detail UX refinement;
- native-share presentation and broader accessibility interaction improvement;
- the proposed minimum Analytics page.

Cycle 10 may record baseline visual/accessibility observations but should not claim their repair.

## 3. Mission

> Consolidate the local Flutter/Drift beta through data-recovery proof, deterministic artifact
> integrity, measured local behavior, behavior-preserving modularity and bounded Windows/Android
> functional evidence, without redesigning the visible product or activating cloud scope.

Cycle 10 is a reliability and evidence cycle, not public-release preparation.

## 4. Starting state

Available from Cycle 09:

- handwritten Drift schema v4 and tested sequential migrations;
- immutable Account-scoped Person `@...`, Payment Method `#...` and Product visible codes;
- optional Purchase references and archive-resolvable labels;
- manual local Purchase occurrence converted to persisted UTC;
- exact Product-code lookup/autofill without implicit Item addition;
- supported dimensional units and same-unit BULK fixed-point calculation;
- transient rebuildable Lists projections;
- selected-Purchase deterministic CSV/PDF generation;
- typed application failures;
- Windows build/bounded launch evidence;
- protected Python/PySide6 isolation.

Carried technical boundaries:

- migration failure/rollback/no-silent-reset evidence is incomplete;
- export destination, cancellation, cleanup and recovery policy are not fully evidenced;
- Lists, lookup, History and export paths lack measurement-driven performance decisions;
- Windows lacks a complete recorded manual functional workflow;
- Android build/install/runtime/lifecycle is host-unvalidated because Java was unavailable;
- Purchase, Catalogue and History exceed the ordinary modularity guideline;
- visual and accessibility convergence is deferred to Cycle 11.

## 5. Proposed workstreams

### A. Baseline and recovery integrity

- freeze the exact schema-v4/database fixture and Cycle 10 acceptance matrix;
- test representative v1/v2/v3→v4 migration, close/reopen and retained data;
- exercise migration failure and verify rollback/no-silent-reset behavior;
- document database location, backup boundary and recovery failure outcomes;
- preserve registered Purchase facts and protected Python storage isolation.

### B. Artifact and local portability integrity

- validate deterministic CSV/PDF content for explicit selected Purchases;
- define destination, cancellation, overwrite, cleanup and privacy behavior as contracts;
- decide whether Cycle 10 proves export only or also local backup/restore/import;
- do not add native sharing UI or any implicit upload path;
- keep exports read-only and user-initiated.

### C. Measurement before optimization

- establish representative local fixtures and timing method;
- measure Lists projection, exact lookup, Catalogue search, History and export;
- add indexes, paging or query changes only when evidence identifies a problem;
- preserve Product-first Lists semantics and rebuildability;
- report fixture size, host and command with every performance claim.

### D. Behavior-preserving modular extraction

- split Purchase, Catalogue and History into bounded page sections/controllers;
- keep current visible behavior, data ownership and navigation unchanged;
- avoid design-system expansion or page recomposition;
- add/retain regression tests before extraction;
- stop if extraction requires an unsettled UX decision.

### E. Cross-platform functional evidence

- rerun Flutter analysis and the full automated suite;
- record a complete Windows Home→Catalogue→Purchase→Lists→History functional workflow;
- restore Java/Gradle only under explicit host authority;
- validate Android build/install/launch and bounded lifecycle behavior when the host permits;
- classify build, emulator, physical-device, lifecycle and manual evidence separately;
- retain visual/accessibility findings as Cycle 11 inputs rather than Cycle 10 closure claims.

### F. Documentation continuity

- keep evidence states narrow and environment-specific;
- update Guide/privacy wording only from accepted local behavior;
- reconcile permanent domain checkpoints before Main closure;
- preserve unchanged learner maturity unless direct learner evidence appears.

## 6. Suggested bounded units

```text
C10-U01  Baseline, fixtures and acceptance matrix
C10-U02  Migration failure, rollback, reopen and local recovery evidence
C10-U03  CSV/PDF artifact integrity and portability-policy decision
C10-U04  Measurement-led local query/performance correction, if evidence requires it
C10-U05  Behavior-preserving Purchase/Catalogue/History extraction
C10-U06  Windows and Android functional validation
C10-U07  Domain promotion and Main-root closure
```

Each unit needs one invariant, rollback boundary and named evidence story. A unit may conclude
with no source change when investigation does not justify mutation.

## 7. Entry decisions for Main/human

1. Does Cycle 10 cover deterministic export only, or local backup/restore/import as well?
2. Which database versions and representative fixtures are mandatory for recovery evidence?
3. What Windows manual workflow is required for functional acceptance?
4. Which Android host/emulator/physical-device checks are realistically available?
5. What fixture sizes and timing thresholds justify query/index work?
6. Should modular extraction precede or follow platform functional validation?

These decisions require investigation; none authorizes implementation by itself.

## 8. Explicit non-goals

- UI aesthetic convergence or target-image reconstruction;
- new UX interaction policy, native-sharing UI or accessibility redesign;
- Analytics or Household behavior;
- authentication, authorization, API/Neon or remote storage;
- upload/download, convergence or multi-device synchronization;
- Product merge/correction, Store redesign or registered Purchase mutation;
- production signing, store publication or public release;
- PySide6 retirement.

Local SyncEvent/PendingEvent preparation is not real synchronization.

## 9. Evidence gates

| Claim | Minimum evidence |
| --- | --- |
| migration preserves data | representative file-backed migration and reopen |
| failure cannot silently reset | induced failure plus rollback/original-file evidence |
| export is deterministic | repeated artifact comparison on named fixtures |
| backup/restore works | explicit round trip and identity/data comparison |
| query is improved | repeatable before/after measurement on the same fixture/host |
| extraction preserves behavior | focused regressions plus unchanged workflow observation |
| Windows workflow works | build and recorded complete manual functional path |
| Android boundary works | build/install/launch and named lifecycle evidence |
| learner maturity changed | explicit learner explanation, prediction or transfer |

No green test suite proves visual parity, accessibility acceptance, production readiness or
cloud synchronization.

## 10. Exit direction

Proposed Cycle 10 exit:

- schema-v4 recovery behavior is evidenced at the agreed fixture/version boundary;
- export/portability scope is truthful and documented;
- optimization decisions are measurement-led;
- selected oversized pages are extracted without intentional visual/UX change;
- Windows functional workflow is recorded;
- Android is evidenced or remains explicitly host-unvalidated with a recovery route;
- permanent domains and Main continuity are reconciled;
- Cycle 11 receives preserved visual/UX observations without premature closure claims.

## 11. Recovery route

At Cycle 10 entry read:

1. `00_PROJECT_STATE.md`;
2. this forward checkpoint;
3. `operational/10_OPERATIONAL_STATE.md` and `04_TODO.md`;
4. `design/09_DESIGN_STATE.md` for schema and modularity boundaries;
5. `didactics/08_CONCEPT_MAP.md` for stable vocabulary and maturity;
6. post-Codex J/G/H/I only for unresolved Cycle 09 evidence;
7. repository source only for the selected first unit.

```text
Cycle 09: closed
Cycle 10 perspective: prepared
A/B/C: not yet staged
D/E/F: not prepared
source/schema/dependency/host authority: inactive
Cycle 11 visual/UX scope: preserved and deferred
```
