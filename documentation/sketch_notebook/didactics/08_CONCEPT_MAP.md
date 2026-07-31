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

# Current Didactic Checkpoint — C11-PH03

> Status: current conceptual checkpoint
> Branch: `grm-guarded-provisioning-20260727`
> Implementation: `0924e743931ea7aba2c9cc5d2e28063e737b2ff5`
> Evidence: `DEV_STAGE/H_DDC_CODEX.md`
> Main reconciliation: `33dc1002b4a7b00fa67e863dfe98a43c97d66cee` section 11
> Sequence: SEQ-PRM-04 / PDR2-A
> Learner maturity: unchanged

## Current terminal

```text
C11_PH01_R01=PERMANENTLY_ABSORBED
C11_PH02=PERMANENTLY_ABSORBED
C11_PH03=IMPLEMENTED_VALIDATED_AUTOMATED_BUILD_CEILING
SETTINGS_PURPOSE=LOCAL_CONFIGURATION_AND_BOUNDED_READINESS
AUDIT_PURPOSE=RECENT_SANITIZED_LOCAL_ACTIVITY_HISTORY
PURCHASE_HISTORY_PURPOSE=RECORDED_PURCHASE_FACTS
CLOSURE_ORDINARY_NAVIGATION=ABSENT
HUMAN_UI_VERIFICATION=ACCEPTED_WITH_MINOR_C12_PH01_CARRYOVER
KANBAN_TRANSITIONS=NONE
```

## Concept dependency

```text
Settings
  -> local preferences and reference management
  -> bounded Account, Device and Sync-readiness information/actions

Audit
  -> active Account and environment
  -> recent sanitized local attempts and events
  -> bounded read-only historical evidence

Purchase History
  -> recorded Purchase facts

Current status
  -> latest locally observed readiness

Closure
  -> retired ordinary product vocabulary
```

Settings does not own Recovery, provider maintenance or destructive diagnostic
controls. Audit does not own Purchase facts, current status, hosted truth,
telemetry or causal explanation.

## Learner-visible evidence states

- local: read from on-device persistence for the active Account/environment;
- bounded window: only the displayed recent evidence is claimed;
- loading: the local read is in progress;
- empty: no records exist in the loaded window;
- stale: prior evidence remains visible after a later read failed;
- unavailable: the requested local evidence could not be provided.

A diagnostic code supplies a technical classification and safe guidance. It
does not prove why an event occurred. Audit Retry repeats only the same local
read and changes neither Purchase facts nor Sync/provider state.

## Product vocabulary and reachability

- Settings remains ordinary configuration and bounded readiness.
- Audit means recent local activity history and is reachable from wide/medium
  navigation and compact More.
- Purchase History remains the chronology of recorded Purchase facts.
- Closure is absent from ordinary navigation and semantics under both feature
  flag values.
- Retained native Closure runners and diagnostic infrastructure remain
  unreachable development/support implementation, not product vocabulary.

## Evidence ceiling

Implemented and validated within the named automated/build boundary:

- Settings persistence, validation, correction and duplicate-action behavior;
- Audit loading, empty, stale, unavailable, pagination, sanitization and
  read-only Retry behavior;
- Audit versus Purchase History and current-status wording;
- wide/compact reachability and shared meaning;
- focus semantics, non-color meaning and 200-percent text behavior;
- Closure absence from ordinary navigation;
- Windows release and Android debug build completion.

Human direction accepted the visible PH03 result for documentation closure.
Minor non-blocking UI polish is deferred to C12-PH01.

Still unestablished:

- a formal PH03 screenshot set;
- Narrator and TalkBack;
- locale and long-string review;
- keyboard-only human acceptance;
- real-device review;
- direct learner comprehension or transfer.

Passing tests, builds and bounded UI acceptance do not establish KANBAN
maturity.

## Stable exclusions

No causal/backend R07 engine, hosted Audit, provider telemetry, automatic
Recovery, destructive product maintenance, raw diagnostic overload, chart,
prediction or recommendation entered PH03.

## Remaining Main and human questions

1. Main must verify all three permanent-domain reconciliations before refreshing
   00/05/06 and opening C12-PH01.
2. Human review must establish the still-absent accessibility, locale,
   keyboard-only and real-device evidence if required.
3. Direct learner assays must distinguish Settings from status, Audit from
   Purchase History, local from hosted evidence, and technical classification
   from causal explanation before any maturity promotion.

## Recovery pointers

1. `02_KANBAN.md` — stable concept identities and unchanged maturity.
2. `07_GLOSSARY.md` — current Settings/Audit/Closure vocabulary.
3. `13_LECTURE_REGISTER.md` Observation 013 — PH03 implementation/evidence event.
4. `DEV_STAGE/H_DDC_CODEX.md` — learner-visible automated evidence and limits.
5. J section 11 — Main reconciliation and documentation-closure boundary.

