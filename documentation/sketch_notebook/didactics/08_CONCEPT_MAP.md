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

# Current Didactic Checkpoint — C11-PH05

> Status: current conceptual checkpoint
> Branch: `grm-guarded-provisioning-20260727`
> Implementation: `426235d8b67ac719e494b53cfb23a6c3b06fb489`
> Evidence: complete `DEV_STAGE/H_DDC_CODEX.md`
> Main reconciliation: `e6ced7fe3945925bf5f314ee11c4538029e18d44` section 14
> Sequence: SEQ-PRM-04 / PDR2-A
> Learner maturity: unchanged

## Current terminal

```text
C11_PH01_R01=PERMANENTLY_ABSORBED
C11_PH02=PERMANENTLY_ABSORBED
C11_PH03=PERMANENTLY_ABSORBED
C11_PH05=IMPLEMENTED_AUTOMATED_AND_BUILT
GUIDE_STRUCTURE=IMPLEMENTED_AND_AUTOMATED
GUIDE_ACCEPTED_LEARNER_SEQUENCE=PARTIALLY_CONTRADICTED
ANALYTICS_LEARNER_DEFECT=ACTIVE
ANALYTICS_WRONG_VARIABLE_ROOT_CAUSE=NOT_ESTABLISHED
ANALYTICS_CORRECTION_DIRECTION=ACCEPTED_NOT_IMPLEMENTED
KANBAN_TRANSITIONS=NONE
```

## Current learner-visible distinctions

- `Optional purchase details` contains independent optional Person and Payment
  Method metadata; required Store/date/time remain outside that optional group.
- Catalogue detail activation is not ordinary selection.
- History detail opening is independent from zero/one/many action selection.
- `Select all shown` means the current filtered loaded recent-History window.
- `Use in Analytics` transfers scope only; requested, matched and unavailable
  counts expose reconciliation without automatic calculation.
- Export creates a file after a final destination result; sharing is separate.
- Audit uses `Readiness summary`, not provider Health.
- Settings is Account-first.
- Person codes are `@NNN`; Payment Method codes are `#NNN`.

## Guide correction

The Guide has eight local anchored sections and focusable contents navigation.
Its committed order is Home, Purchase, Catalogue, History, Analytics, Exports,
Audit and Settings.

The accepted learner sequence is not fully implemented: Lists is not preserved
as its own teaching boundary, while Getting started and
local-data/export/Sync-limit concepts are redistributed. Structure is
implemented/automated; sequence fidelity is partially contradicted; Guide
comprehension is unestablished.

## Active Analytics learner defect

Human screenshots expose a result that may use or display a Quantity value/unit
unrelated to the requested Variables and Operation. Current Analytics tests did
not detect the mismatch. The wrong-variable cause is unknown; no calculation-integrity claim is
authorized.

Accepted but not implemented correction direction:

- compact `Create analysis`;
- unified typed `Variables`;
- two `dd-mm-yyyy` date fields;
- Date-Time of purchase and Store name in learner-facing evidence.

## Evidence ceiling

Implemented, automated and built are not learner-understood. Automated evidence
covers the named responsive boundaries, compact More, Home 200-percent text,
Guide anchors, History selection, focus semantics and non-color meaning.

Still unestablished:

- complete screenshot-fidelity review;
- keyboard-only human review;
- Narrator and TalkBack;
- locale and long-string review;
- real-device review;
- direct learner comprehension or transfer.

No KANBAN maturity transition follows from PH05.

## Recovery pointers

1. `02_KANBAN.md` — stable concept identity and unchanged maturity.
2. `07_GLOSSARY.md` — concise PH05 terminology and evidence distinctions.
3. `13_LECTURE_REGISTER.md` Observation 014 — PH05 chronology and defect.
4. `DEV_STAGE/H_DDC_CODEX.md` — automated/build evidence and limits.
5. J section 14 — Guide deviation, Analytics defect and next authority boundary.
6. Relevant UI/tests — implementation truth at `426235d8…`.

## Next authority boundary

Main must first verify the Operational, Didactic and Design PH05 permanent
reconciliations. The Analytics correction requires a separate read-only
end-to-end state-of-union before any new D/E/F authority. Human accessibility,
locale, real-device and comprehension evidence remains a later gate.
