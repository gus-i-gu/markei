# 08_CONCEPT_MAP.md

> Status: Current Didactic checkpoint — Cycle 10 closure and C11-PH01-S01
> Branch: `grm-guarded-provisioning-20260727`
> Inspected repository head: `1422731e512ce073e7fda09451415803d12f3a4e`
> C11-PH01-S01 implementation head: `1c7df53c095f4e7c1d85f278ba16c21fd95b25e6`
> Sequence: FLX-PRM-04 / PDR2-A
> Canonical owner: `02_KANBAN.md`
> Derived retrieval: `07_GLOSSARY.md`
> Observational history: `13_LECTURE_REGISTER.md` Observations 010–011
> Learner maturity: unchanged

## Current terminal

```text
CYCLE10=CLOSED_AT_GCM03_TWO_DEVICE_DEVELOPMENT_SCOPE
GCM02=CLOSED_HOSTED_SAME_DEVICE_SCOPE
GCM03=CLOSED_TWO_DEVICE_DEVELOPMENT_SCOPE
MVP_SYNC_ACCEPTANCE=PASS_TWO_DEVICE_ONE_ACCOUNT_DEVELOPMENT_SCOPE
PRODUCTION_ACCEPTANCE=ABSENT

CYCLE11=ACTIVE
C11_PHASE=C11-PH01
C11_UNIT=C11-PH01-S01
C11_S01_PRESENTATION_SCOPE=IMPLEMENTED_TESTED_BUILD_VALIDATED
C11_PH01_COMPLETE=NO
HUMAN_WINDOWS_ACCEPTANCE=NOT_PERFORMED
HUMAN_ANDROID_ACCEPTANCE=NOT_PERFORMED
KANBAN_TRANSITIONS=NONE
```

## Cycle 10 concept spine

```text
local-first Product/Purchase truth
→ durable local queue and projections
→ hosted readiness prerequisite
→ ordinary Sync upload/download
→ durable local apply and cursor progress
→ acknowledgement
→ same-Device proof
→ reciprocal two-Device convergence
```

Stable distinctions:

- readiness is not ordinary Sync;
- local queue preparation is not synchronization;
- Product code, local Product UUID, natural Product identity and Event UUID are
  different identities;
- transaction outcome and diagnostic-persistence outcome are independent;
- current action result and preserved historical operation evidence coexist;
- blocked, not-applied, applied, duplicate-equivalent and unknown are distinct;
- acknowledgement follows committed local apply/cursor progress;
- same-Device proof is weaker than reciprocal two-Device convergence;
- tests/builds, practical human assays, production acceptance and learner
  mastery are different evidence classes;
- client, server and provider evidence cannot be inferred from one another.

## Cycle 10 accepted evidence boundary

The accepted terminal proves reciprocal Windows/Android convergence for two
enrolled Devices on one Account in development, including exact natural Product
identity reconciliation, drained queues and idempotent no-op repeats.

It does not prove:

- multiple-Account isolation;
- membership disable or Device revocation;
- outage/acknowledgement-uncertainty recovery;
- retention, snapshot or rebootstrap behavior;
- production deployment, lifecycle, availability or acceptance;
- a final provider-table recount after the golden no-op repeats;
- learner mastery.

Observation 010 owns the ordered learning progression and misconceptions. The
KANBAN owns the stable canonical distinctions above.

## C11-PH01-S01 meaning spine

```text
ordinary destination label
→ page purpose
→ one primary action
→ progressive secondary actions
→ explicit readable state
→ equivalent wide/compact information
→ evidence-qualified accessibility
```

Implemented presentation meaning:

- Home is local-first: register a Purchase, then inspect Lists, Catalogue and
  History.
- `Register purchase` is primary; Lists, Catalogue and History are secondary.
- Lists is an estimated Purchase-history projection, never measured inventory.
- Stable projection words are `Estimate`, `Approximate`, `Unavailable`,
  `Not enough history` and `Expected ended`.
- Lists distinguishes loading, local read error, first-use empty, filtered
  empty, insufficient history and populated data.
- Lists Retry repeats a read-only local request and states local data was not
  changed.
- Wide tables and compact cards consume the same projection/search/sort state.
- Analytics is reserved for PH02 without implying calculations or telemetry.
- Audit is reserved for PH03 without implying diagnostic migration.

## C11 evidence and accessibility boundary

Accepted automated evidence:

- exact compact/medium/wide boundaries at 599, 600, 1023 and 1024 logical pixels;
- selected-destination preservation;
- compact More reachability and medium tooltips;
- shared wide-table/compact-card state;
- 200-percent text-scale Home render without Flutter overflow/exception;
- focused and full Flutter tests;
- Flutter analyze;
- Windows release and Android debug builds.

Not accepted or not performed:

- Windows Narrator;
- Android TalkBack;
- keyboard-only manual traversal;
- real-device visual review;
- human Windows/Android page-comprehension acceptance;
- approved pixel/golden parity.

Automated evidence does not establish human accessibility acceptance or learner
comprehension.

## Maturity checkpoint

No status changed.

| Concept family | Canonical identifiers | Current evidence effect |
| --- | --- | --- |
| Evidence and acceptance boundaries | `&&&05` | wording/evidence boundary corrected; Red unchanged |
| Identity distinctions | `&&&03`, `&&&06`, `&%%08`, `&%%11` | stable Cycle 10 distinction; statuses unchanged |
| Outcome/history distinctions | `&&&05`, `&&&10`, `&%%05`, `&%%12`, `&%%14` | stable Cycle 10 distinction; statuses unchanged |
| Convergence/acknowledgement | `&&&09`, `&%%13`, `&%%14` | development evidence strengthened; Red unchanged |
| Lists projection | `&&&02`, `&%%17` | presentation vocabulary stabilized; statuses unchanged |
| Responsive composition | `%%%07` | automated S01 evidence strengthened; Red unchanged |

Direct learner explanation, prediction, debugging or transfer evidence remains
absent.

## Remaining PH01 work

- recompose Catalogue;
- recompose Purchase;
- recompose History;
- perform human Windows and Android visual acceptance;
- perform Narrator, TalkBack, keyboard-only and real-device accessibility
  evidence where required;
- decide a font/locale/DPR policy before any approved golden boundary.

## Deferred boundaries

- C11-PH02: functional deterministic local/account-scoped Analytics;
- C11-PH03: Settings and Audit, including Closure capability disposition;
- C12-PHASE02: multiple-Account/provider/lifecycle work and deferred GCM04.

No current destination label authorizes these deferred behaviors.

## Recovery pointers

1. `02_KANBAN.md` — canonical concepts, Cycle 10 correction and C11 S01 absorption.
2. `07_GLOSSARY.md` — current concise vocabulary.
3. `13_LECTURE_REGISTER.md` Observation 010 — Cycle 10 learning history.
4. `13_LECTURE_REGISTER.md` Observation 011 — C11 S01 meaning event.
5. `DEV_STAGE/H_DDC_CODEX.md` — C11 S01 implementation/test/build evidence.
6. `documentation/REC_LEGACY.md` — exact Cycle 10 assay chronology.
7. current J mutable prefix §§2–5.2 and 7–8 — Main terminal and evidence ceiling.

## Next valid route

Complete the remaining C11-PH01 page convergence and collect bounded human
visual/accessibility evidence. Do not infer a KANBAN maturity transition,
production acceptance, Analytics behavior or Audit/Closure migration.

---

<!-- TEMPORAL_MARKER:C11-PH02-DIDACTIC-2026-07-31 -->

# Current Didactic Checkpoint — C11-PH01-R01 and C11-PH02

> Status: current conceptual checkpoint
> Branch: `grm-guarded-provisioning-20260727`
> Implementation: `20e3d5f6c2f973d138e3b2680aa8adf96f17d0b6`
> Main reconciliation: `0bfc02e8363d8119469a5e8627d8350fa97790b4` section 9
> Sequence: SEQ-PRM-04 / PDR2-A
> Learner maturity: unchanged

## Current terminal

```text
CYCLE10=CLOSED_AT_GCM03_TWO_DEVICE_DEVELOPMENT_SCOPE
PRODUCTION_ACCEPTANCE=ABSENT
C11_PH01_FIVE_PAGE_REACHABILITY=IMPLEMENTED
C11_PH02_LOCAL_ANALYTICS=IMPLEMENTED
ANALYTICS_AUTHORITY=LOCAL_ACCOUNT_SCOPED_PURCHASE_EVIDENCE
HISTORY_CALCULATION_AUTHORITY=NONE
KANBAN_TRANSITIONS=NONE
```

## Concept dependency

Recorded Account-scoped Purchase facts support a complete evidence matrix.
Selected or filtered evidence supplies a session-local card. A card combines:

- one determinant: Product, Purchase, Store or UTC Time;
- one or more relational variables;
- one operation: Sum, Mean, Difference or Percentage;
- optional UTC Time conditions;
- a value or typed unavailable outcome;
- a factual interpretation, evidence count and applicable period.

History may transfer typed Purchase IDs into this dependency. It does not
calculate or interpret.

## Twelve-field evidence authority

| Field | Learner-visible meaning |
| --- | --- |
| Purchase | transaction context and identifier |
| Date/time | recorded UTC Purchase time |
| Product | Item subject |
| Brand | recorded Product brand when available |
| Store | recorded Purchase Store when available |
| Purchased by | recorded purchaser when available |
| Purchased for | explicit unavailable state when absent |
| Payment method | recorded Purchase payment method when available |
| Quantity | recorded Item quantity |
| Unit price | recorded or evidence-qualified derived unit value |
| Line total | recorded Item contribution |
| Promotion | explicit unavailable state when absent |

Unavailable fields remain unavailable; Analytics does not create or repair a
raw fact.

## Operation checkpoint

- Sum: total contribution of the named variable.
- Mean: average contribution of valid named evidence.
- Difference: comparison B minus baseline A.
- Percentage: named part of a named containing whole, never percentage change.
- zero denominator and numeric overflow: typed unavailable outcomes.

## Presentation and traceability checkpoint

- evidence pages contain 100 rows;
- selected scope is bounded to 500 Purchase IDs;
- matrix selection initializes a card;
- card evidence focuses the matrix;
- reset restores all current evidence;
- cards are session-local;
- wide tables and compact cards preserve meaning, scope and actions;
- PH01 navigation makes History selection/detail meaning reachable and
  unambiguous.

## Evidence ceiling

Automated tests establish named state, calculation, traceability, breakpoint,
keyboard/focus and 200-percent text behavior. Windows/Android build artifacts
establish compilation for their named targets.

The following remain `NOT_PERFORMED`:

- screenshots and rendered visual acceptance;
- Narrator and TalkBack;
- locale variation;
- keyboard-only human acceptance;
- real-device acceptance;
- direct learner explanation, comparison, prediction, debugging or transfer.

Passing tests and builds do not establish learner understanding or KANBAN
maturity.

## Exclusions

Charts, forecasting, prediction, rankings, recommendations, causal explanation,
telemetry, remote/Sync-derived Analytics, external facts and raw-fact repair
remain absent. Audit/Settings remains PH03; no Analytics evidence selects that
architecture or claims production acceptance.

## Remaining Main and human questions

1. Main must choose the bounded PH03 Settings/Audit route without moving
   Analytics calculation into History.
2. Human evidence must test screenshots, assistive technology, locale,
   keyboard-only use and real devices.
3. Direct learner assays must test determinant/condition, Purchase/Item,
   Difference baseline and Percentage containing-whole distinctions before any
   maturity promotion.

## Recovery pointers

1. `02_KANBAN.md` — stable identities and unchanged maturity.
2. `07_GLOSSARY.md` — concise current vocabulary.
3. `13_LECTURE_REGISTER.md` Observation 012 — implementation/evidence event.
4. `DEV_STAGE/H_DDC_CODEX.md` — focused implementation/test/build evidence.
5. J section 9 — Main reconciliation and evidence ceiling.
