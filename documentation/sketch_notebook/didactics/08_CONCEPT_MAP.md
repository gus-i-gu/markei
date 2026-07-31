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

# Current Didactic Checkpoint — C11 Analytics Correction R01

> Status: current conceptual checkpoint
> Branch: `grm-guarded-provisioning-20260727`
> Inspected implementation: `17fd65296e960112787b870363b40339f535f5b6`
> Implementation parent: `2cdb8a66bfa75918acbbcae324e8315e0b7b2658`
> Correction authority: `0e647e76aa8275bda48cea1e9d08427e3d949134`
> Evidence: complete `DEV_STAGE/H_DDC_CODEX.md`
> Main reconciliation: J section 16 at `34eb4b60fd4f9c6455c1774c055c1615581623af`
> Observational event: `13_LECTURE_REGISTER.md` Observation 015
> Sequence: SEQ-PRM-04 / PDR2-A
> Learner maturity: unchanged

## Current terminal

```text
C11_ANALYTICS_CORRECTION_R01=IMPLEMENTED_AUTOMATED_VALIDATED
TEN_CASE_REGRESSION_MATRIX=PASS
SELECTED_VARIABLE_PROJECTION_INTEGRITY=PASS
WIDE_COMPACT_COMPONENT_BEHAVIOR=PASS
TEXT_SCALE_200_CONTAINMENT=PASS
AUTOMATED_SEMANTICS=PASS
HUMAN_SCREENSHOT_ACCEPTANCE=NOT_PERFORMED
HUMAN_COMPREHENSION=NOT_ESTABLISHED
GUIDE_ACCEPTED_SEQUENCE=PARTIALLY_CONTRADICTED_OUT_OF_SCOPE
KANBAN_TRANSITIONS=NONE
```

## Learner-facing Analytics model

One visible `Variables` set contains:

- categorical breakdowns: Purchased by and Payment method;
- typed unavailable category: Purchased for, unsupported by recorded evidence;
- numeric measures: Quantity, Unit price, Price paid, Purchase total and
  Evidence count.

Categorical-only selection asks for a numeric variable and inserts no implicit
count or Quantity. Unsupported operations name the selected Operation and
numeric Variable.

`Initial date` and `Final date` use inclusive `dd-mm-yyyy` local-calendar
meaning. Missing, invalid and reversed ranges receive distinct correction
guidance.

## Record and evidence integrity

`Run & save` creates an immutable session record. Changing or clearing the live
draft does not change saved analyses.

Chart, Table, interpretation, CSV and PDF derive meaning from the same frozen
record. Results use readable quantity, currency, currency-per-unit, percentage,
signed Difference and integer Evidence-count scales.

Compatibility keys, raw storage integers and ordinary UUIDs are not
learner-facing evidence. `Date-Time of purchase` and `Store name` are exposed
as evidence labels.

## Evidence classification

The ten-case regression matrix passed. Automated evidence validates
selected-variable/projection integrity, compact and wide components,
200-percent text containment and semantics.

The earlier PH05 screenshot defect remains historical evidence but is
superseded as the current automated implementation classification. No human
screenshot acceptance was performed.

Still unestablished:

- keyboard-only human acceptance;
- Narrator and TalkBack acceptance;
- locale and long-string acceptance;
- real-device acceptance;
- direct learner comprehension or transfer.

Automated implementation evidence is not learner maturity.

## Retained Guide deviation

The PH05 Guide still has eight anchored sections and automated navigation, but
its accepted learner sequence remains partially contradicted: Lists is not its
own teaching boundary and other accepted concepts remain redistributed. This
Analytics correction did not repair the Guide.

## Maturity

No KANBAN status changed. Existing concept identities absorb the corrected
Variables, validation, immutable-record, readable-scale and evidence-label
distinctions at the implemented/automated ceiling only.
`KANBAN_TRANSITIONS=NONE`.

## Recovery pointers

1. `02_KANBAN.md` — canonical correction truth and unchanged maturity.
2. `07_GLOSSARY.md` — concise current Analytics correction terminology.
3. `13_LECTURE_REGISTER.md` Observation 015 — learning/evidence chronology.
4. Complete `DEV_STAGE/H_DDC_CODEX.md` — correction labels and automated evidence.
5. J section 16 — Main correction reconciliation and evidence ceiling.
6. `DEV_STAGE/E_DDC_STAGE.md` latest C11 Analytics correction authority.
7. Relevant Analytics UI/tests at implementation `17fd6529…`.

## Next authority boundary

Main may reconcile the three permanent-domain correction commits and prepare
final C11 continuity. Human work remains required for screenshot, keyboard-only,
assistive-technology, locale, real-device and comprehension acceptance. The
Guide sequence deviation remains a separate unresolved PH05 teaching question.
