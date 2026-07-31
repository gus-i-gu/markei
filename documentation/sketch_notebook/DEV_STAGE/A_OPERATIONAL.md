# A_OPERATIONAL.md

> Cycle: C11
> Phase: C11-PH02
> Role: Operational Chat [O]
> Status: PROVISIONAL OPERATIONAL INVESTIGATION — A/B/C INPUT ONLY
> Repository: gus-i-gu/markei
> Branch: grm-guarded-provisioning-20260727
> Inspected remote HEAD: ca380632f5714ce4007d694a954568c3a57828cd
> Date: 2026-07-31
> Writable scope: this file only

---

<!-- RECONCILIATION_MARKER:C11-PH02-O-2026-07-31 -->

# C11-PH02 — Deterministic Local Analytics

## 1. Identity, authority and recovered state

MSU-02 was run through AGENTS.md, INDEX.md, PROMPT_COLLECTION.md, PRI-O,
PMC-01 and the complete MSU-02 route. PMC-02 was not required because role,
routing, promotion state and A-only authority were explicit and consistent.

Operational [O] observes execution, reproducibility, persistence, query cost,
validation, failure states and evidence ceilings. This investigation replaces
only DEV_STAGE/A_OPERATIONAL.md. Source, tests, schemas, dependencies,
generated files, B/C, D-J, Main-root continuity, permanent memory, methodology
and operator files remain unchanged.

All named commits remain ancestors with zero divergence:
1422731e512ce073e7fda09451415803d12f3a4e,
1c7df53c095f4e7c1d85f278ba16c21fd95b25e6,
e587872d1b231205a83dbd30c46fae84a21831ee and
526e0de6e294c5fb969d8ee1f35e6eb53914902b.

The initial inspected head was f6566a407c2215c1ade61444a7f97994994d93f8.
Before publication the branch advanced compatibly to ca380632f5714ce4007d694a954568c3a57828cd
through three commits changing only PH02 B/C and the explained PH01-S02-R01
corrective D/E/F packet. Those siblings are preserved.

Recovered Main state:

- Cycle 10 is accepted only at the two-Device, one-Account development
  boundary; production and later backend resilience remain deferred.
- C11-PH01-S01 is implemented and validated at automated/build scope.
- C11-PH01-S02 source publication remains absent from the inspected ancestry;
  a corrective D/E/F packet now describes retained local worktree evidence.
- C11-PH02 owns deterministic local Account-scoped Analytics.
- C11-PH03 owns Settings, Audit and Closure disposition.
- live Sync and provider mutation authority are absent.

## 2. Hierarchical recovery and deeper reads

Required recovery used J_MAIN_STAGE.md, 00_PROJECT_STATE.md, the latest C11
segment of 05_SESSION_LOG.md, the active 06_SESSION_SCHEME.md checkpoint,
operational/10_OPERATIONAL_STATE.md and PH01 G/H/I.

Deeper reads were justified because those surfaces do not establish Analytics
field authority, operation compatibility, row identity, query shape, time
boundaries, pagination or History handoff:

- markei_app.dart: Analytics is a reserved page and stable destination only.
- markei_composition.dart: local application ports and Account identity.
- history_page.dart and purchase_history.dart: current selection, detail and
  price-comparison behavior.
- local_database.dart: authoritative local tables, fields and stable IDs.
- local_query_repository.dart: joins, Account predicates, History limit,
  detail queries and price comparison.
- history_export.dart: selected-Purchase export shape and N+1 detail loop.
- quantity.dart and money.dart: fixed-point quantity and minor-unit money.
- markei_app_test.dart and markei_visual_foundation_test.dart: navigation,
  registration, History and responsive coverage.
- pubspec.yaml: no Analytics dependency.

Generated local_database.g.dart was not read; Drift generator ownership is
preserved.

## 3. PH01 classification

PH01 is PARTIAL, and that qualifies rather than blocks PH02.

The available PH01 implementation commit is
1c7df53c095f4e7c1d85f278ba16c21fd95b25e6. G/H/I establish stable
destination identity, compact/medium/wide shell behavior, shared presentation,
Home and Lists recomposition, reserved Analytics identity, focused tests,
245-test full Flutter suite with four skips, analysis, Windows release build
and Android debug build.

Human Windows/Android, Narrator, TalkBack, keyboard-only and real-device
acceptance are absent. The descendants after 526e0de6 contain documentation,
staging and legacy consolidation but no final S02 Flutter source, tests or
replacement G/H/I. The later S02-R01 D/E/F packet explicitly identifies
preliminary S02 work as local worktree state, not remote implementation.

| PH01 evidence | Classification |
| --- | --- |
| S01 source | implemented |
| S01 automation, analysis and builds | validated |
| S01 rendered reference comparison | host-unvalidated |
| S01 human platform acceptance | absent |
| S02 remote source/test/G/H/I materialization | absent |
| PH01 closure | blocked |
| PH02 investigation and A publication | accepted |

PH02 inherits the S01 neutral white/forest-green system, compact controls,
bordered semantic surfaces, shell bounds and one page state across breakpoints.
It also carries the absent S02 publication and human acceptance as
qualifications. It does not reopen PH01 design.

## 4. Analytics current state and proposed authority

Analytics currently has a stable destination and reserved page only. No
calculation port, page, result model, repository method, state reducer, History
handoff or Analytics-specific test is implemented.

The proposed authority is one read-only local application port backed by the
local Drift adapter. Every request requires AccountId and reads only purchases,
purchase_items, products, stores, people and payment_methods. Sync tables,
diagnostics, hosted events, provider state, telemetry and external facts are
excluded.

A request carries exactly one determinant—Product, Purchase, Store or Time—one
or more relational variables, exactly one operation—Sum, Mean, Difference or
Percentage—a filtered-dataset or selected-row scope, optional half-open time
bounds, and stable cursor-page parameters.

A result carries exact value or comparable pair, factual interpretation,
evidence count, applicable period, compatibility/exclusion counts and a stable
local query fingerprint.

## 5. Twelve-field authority matrix

| Field | Repository authority | Classification | Qualification |
| --- | --- | --- | --- |
| Purchase | purchases.id / PurchaseId | accepted | Purchase identity; Item evidence retains purchase_id |
| date/time | purchases.occurrence_time | accepted | instant stored; named time zone absent |
| Product | purchase_items.product_id to products.id | accepted | local Account Product authority |
| Brand | products.display_brand with normalized fallback | accepted | Product fact, not an Item snapshot |
| Store | purchases.store_id to stores.id | accepted | scoped through Purchase |
| purchased by | purchases.person_id to people | provisional | optional Person exists; meaning requires confirmation |
| purchased for | absent | absent | no field or relation |
| payment method | purchases.payment_method_id | accepted | optional; archived label remains resolvable |
| quantity | measurement_kind, purchased_amount, purchased_unit | accepted | fixed six-decimal canonical quantity |
| unit price | line total divided by canonical quantity | provisional | derived; per-package price is not equivalent |
| line total | line_total_minor_units and currency_code | accepted | exact minor units; mixed currency blocked |
| promotion | absent | absent | no promotion fact |

Purchase total remains available for validation and Purchase summaries but must
not be counted once per joined Item.

Stable matrix identity is purchase_items.id represented as PurchaseItemId.
PurchaseDetailItem currently omits it, so History detail objects cannot be the
Analytics evidence authority without a bounded contract change.

## 6. Operations, combinations and minimum evidence

Definitions:

- Sum: exact addition of compatible values.
- Mean: exact Sum divided by included evidence count; display-only rounding.
- Difference: comparison minus baseline.
- Percentage: proposed signed Difference divided by absolute non-zero baseline,
  represented in basis points.
- Interpretation: increased, decreased, unchanged, total or mean only.

| Operation | Minimum evidence | Compatibility gate |
| --- | --- | --- |
| Sum | one row | one currency or one quantity class |
| Mean | one row | non-zero divisor |
| Difference | two ordered determinant values/buckets | comparable aggregate values |
| Percentage | two ordered determinant values/buckets | comparable values and non-zero baseline |

| Determinant | Executable findings |
| --- | --- |
| Product | Sum/Mean line total or compatible quantity; rate Mean only for positive canonical quantity; Difference/Percentage require two ordered rows, periods or explicit Product A/B totals |
| Purchase | Sum Item line totals or compatible quantity; Mean per included Item; Difference/Percentage require two explicit Purchases and same currency/unit class |
| Store | Sum/Mean by Store; rate requires the same Product and unit class; Difference/Percentage require explicit Store A/B order |
| Time | Sum/Mean by stable bucket; Difference/Percentage use two chronological buckets |

Invalid findings:

- mixed currency money arithmetic;
- mixed MeasurementKind or canonical unit quantity arithmetic;
- non-positive quantity for unit-rate derivation;
- unit-rate comparison across Products unless Main explicitly accepts it;
- Difference/Percentage without exactly two ordered groups;
- Percentage with zero baseline;
- purchased-for or promotion variables;
- Sum of unit prices;
- arithmetic on IDs, labels or instants;
- repeated Purchase totals after an Item join;
- current History's 50-row limit as complete evidence.

Main must decide whether Percentage is relative change only or also share of
total. Only relative change is proposed for PH02.

## 7. Time, identity and reproducibility

occurrence_time is the factual time authority. created_at, Sync event time and
diagnostic time are excluded.

The schema stores an instant but no named time-zone identity. UTC half-open
bounds [start, end) are proposed as the deterministic default. Applicable
periods must display UTC. End dates resolve to the exclusive start of the next
UTC day. Proposed buckets are UTC day and UTC month.

Device-local calendar-day claims are blocked across host time-zone changes.
Week, locale calendar and daylight-saving local buckets remain deferred. Main
must accept UTC or authorize a later time-zone policy/schema unit.

Stable evidence ordering is occurrence_time, purchase_id, purchase_item_id.
Time uses chronological baseline/comparison order; non-Time determinants
require explicit A/B order.

## 8. Matrix, cards, selection and breakpoint parity

One page state survives compact, medium and wide layouts. Breakpoint changes
must not requery, reset filters/card/selection/cursor or duplicate results.

Proposed state route:

1. Reset restores all Account evidence and clears filter, card, result,
   selection and cursor.
2. Filters define the complete logical dataset; the matrix exposes it through
   stable pages.
3. Matrix selection initializes the card's selected-row scope using
   PurchaseItemId values but does not infer an operation.
4. A complete card validates and calculates.
5. Card evidence focuses the matrix to the exact included rows.
6. Clearing the card restores the filtered matrix.
7. A request generation token discards stale async results.

Wide uses a dense bordered twelve-field table. Compact projects time,
Purchase, Product/Brand, Store, quantity, line total and selection, with detail
expansion for remaining fields. Both consume the same records, IDs and result.

## 9. Typed History handoff

History must not calculate Analytics. It may emit one immutable typed handoff
containing AccountId, selected PurchaseId values, optional History time filter
when implemented, and History origin.

MarkeiApp owns navigation and transfers the handoff. Analytics revalidates IDs
against the active Account and resolves Items through its own query port.
Stale or foreign IDs are excluded and counted.

Current History has selected Purchase IDs, but Move to Analytics is disabled
and no callback exists. The proposed handoff focuses the matrix to selected
Purchases and preselects no operation. With no selection, the action is
proposed disabled; Main may instead accept opening the complete dataset.

## 10. Query shape, N+1 risk and limits

Current evidence:

- listRecentPurchases uses one Purchase join, a grouped count query and limit 50.
- getPurchaseDetail uses one Purchase join and one Item/Product join.
- exportBundle loops over IDs and calls getPurchaseDetail, creating N+1 risk.
- priceChangeForProduct uses one Account-scoped join and fixed quantity
  normalization.
- no explicit Analytics-supporting indexes were observed for
  purchases(account_id, occurrence_time), purchase_items(purchase_id) or
  purchase_items(product_id).

Analytics needs one Account-scoped joined evidence query family. It must not
call getPurchaseDetail per row/Purchase. Aggregate and evidence selection must
share one normalized predicate so results and rows cannot drift.

Proposed limits:

- page size 100;
- stable keyset cursor, not offset-only pagination;
- UI memory limited to current page, result, filters and selected IDs;
- provisional selected-row cap 500 IDs;
- calculations cover the complete filtered/selected set;
- ordinary fixture: 1,000 Purchases / 5,000 Items;
- stress fixture: 10,000 Purchases / 50,000 Items;
- proposed warm targets: first page and simple card below 250 ms; stress result
  below one second on the validation host.

Failure to meet the fixture target blocks acceptance and triggers an explicit
index/migration decision. No hidden unbounded cache is accepted.

SQLite sums can overflow signed 64-bit range. Exact checked accumulation or
explicit preflight is required; floating-point aggregation is contradicted.
Unit rates remain rational internally, with deterministic display rounding.

## 11. States, failures and local Retry

Required states: initial, loading, complete, empty, incomplete card,
calculating, calculated, insufficient evidence, incompatible currency,
incompatible quantity, zero Percentage baseline, overflow, stale handoff,
query failure and superseded async result.

Retry repeats only the failed local Analytics read with the same Account,
filters, selection and card. It must not run Sync, Recovery, provider access,
migration, repair or mutation.

Failures preserve selection/card/filter unless Reset is explicit. Empty is not
failure. Excluded rows remain counted; silent dropping is contradicted.

## 12. Validation ladder

No command was run in this connector-only investigation.

Proposed commands from clients/markei_flutter:

1. flutter pub get
2. dart format --output=none --set-exit-if-changed lib test
3. flutter analyze
4. flutter test test/application/analytics_test.dart test/infrastructure/local_analytics_repository_test.dart
5. flutter test test/app/analytics_page_test.dart test/app/history_analytics_handoff_test.dart
6. flutter test test/app/markei_visual_foundation_test.dart test/app/markei_app_test.dart
7. flutter test
8. flutter build windows --release
9. flutter build apk --debug
10. repository-root git diff --check

build_runner is required only if authorized Drift inputs change:
dart run build_runner build --delete-conflicting-outputs. Generated output
must be audited and never hand-edited.

Automated gates cover every combination, Account isolation, selected versus
filtered scope, pagination completeness, UTC boundaries, currency/unit/zero/
overflow failures, stale/foreign handoff IDs, card focus/Reset, stale async
suppression, local Retry without Sync, 599/600/1023/1024 widths, 200 percent
text scale, query count, performance fixtures and the full regression suite.

Rendered and human acceptance remain separate: Windows resizing, keyboard and
dense evidence; Android compact projection, TalkBack, Back, rotation and
insets; factual interpretation; stable state across breakpoints; and absence
of chart, forecast, recommendation, telemetry or remote facts.

## 13. Bounded slices by execution risk

| Slice | Proposed outcome | Risk | Gate |
| --- | --- | --- | --- |
| 1 | pure request/result and operation compatibility | low | exhaustive fixed-point tests |
| 2 | Account query, stable Item ID, cursor page and shared predicate | high | isolation, query count, completeness, performance |
| 3 | page state, matrix, cards, focus and Reset | high | reducer and responsive widget tests |
| 4 | typed History handoff and navigation | medium | no History calculation; stale/foreign ID tests |
| 5 | regression, builds and human platform acceptance | high | automated/rendered/human gates separated |

No schema migration or dependency is proposed initially. A failed stress gate
requires a separate index-migration decision.

## 14. Main/human decisions

1. UTC half-open periods or a named time-zone policy.
2. Confirmation that purchased by maps to optional Person.
3. purchased for and promotion remain absent or move to a later schema unit.
4. canonical-unit rate only versus a separately defined package price.
5. Percentage as relative change only.
6. explicit A/B ordering for non-Time comparisons.
7. 100-row page and provisional 500-ID selection cap.
8. no-selection History handoff disabled or complete dataset.
9. UTC day/month buckets; week/local calendar deferred.
10. whether stress failure authorizes a later index migration.

## 15. Non-goals

Forecasting, recommendations, rankings, advanced statistics, charts,
telemetry, hosted/Sync/provider Analytics, external facts, raw-fact repair,
fact mutation, schema/dependency change in this stage, PH01 redesign, PH03,
live operations, installation, migration, repair and packaging are excluded.

## 16. Claim/evidence matrix

| Claim | Classification | Evidence |
| --- | --- | --- |
| Analytics calculations are absent | validated | reserved page and composition |
| Account-scoped facts exist locally | implemented | local schema/query adapter |
| all twelve fields are not authoritative | validated | purchased-for/promotion absent; unit price derived |
| stable Item ID is not projected | validated | PurchaseItems.id versus PurchaseDetailItem |
| History is incomplete Analytics authority | validated | limit 50 and detail contract |
| export has N+1 risk | validated | exportBundle detail loop |
| fixed money/quantity exist | implemented | minor units and microunits |
| S01 visual/navigation foundation exists | validated | G/H/I and tests |
| final S02 remote implementation is absent | validated | ancestry and path audit |
| UTC periods preserve current determinism | proposed | named time zone absent |
| one local query port avoids N+1 | proposed | current joined Drift patterns |
| 100-row keyset pages bound UI memory | proposed | Operational cost analysis |
| human Analytics acceptance | absent | no implementation or assay |

## 17. Proposed D gates and Main handoff

D must require exact ancestry; one Account-scoped local port; twelve-field
authority; PurchaseItemId evidence; exhaustive compatibility; one predicate
for result and matrix; no N+1; resolved time policy; paging, memory, query-count
and performance gates; local-only Retry; exact failure states; one page state;
IDs-only History handoff; full validation; separate automated/rendered/human
evidence; and stop on schema, dependency, Sync, provider, charts or prediction.

PH02 is executable without schema/dependency change if Main accepts UTC,
relative-change Percentage, canonical-unit rate and explicit comparison order.
The highest risks are predicate parity, Account isolation, stable Item
identity, N+1 avoidance and bounded matrix memory.

PH01 is PARTIAL: S01 is implemented and automated/build validated; final S02
remote materialization and human acceptance are absent. Main should reconcile
PH01 and PH02 together without suppressing PH02 staging.

## 18. Terminal

~~~text
INSPECTED_REMOTE_HEAD=ca380632f5714ce4007d694a954568c3a57828cd
PH01_IMPLEMENTATION_COMMIT=1c7df53c095f4e7c1d85f278ba16c21fd95b25e6
PH01_MATERIALIZATION_GATE=PARTIAL
PH01_HUMAN_ACCEPTANCE=ABSENT
ANALYTICS_CURRENT_STATE=ABSENT
LOCAL_ANALYTICS_AUTHORITY=PROPOSED
ACCOUNT_SCOPING=ACCEPTED
EVIDENCE_MATRIX_FIELD_AUTHORITY=PARTIAL
OPERATION_COMPATIBILITY=PROPOSED
TIME_SEMANTICS=BLOCKED
HISTORY_HANDOFF=PROPOSED
WIDE_COMPACT_STATE_PARITY=ACCEPTED
STAGE_STATUS=PROVISIONAL
MAIN_DECISIONS_REQUIRED=UTC_PERIODS;PERSON_MEANING;UNIT_RATE;PERCENTAGE;A_B_ORDER;PAGE_SELECTION_LIMIT;EMPTY_HISTORY_HANDOFF
NEXT_MAIN_ACTION=Reconcile the published C11-PH02 A/B/C reports while carrying PH01 PARTIAL qualifications, then resolve the named Analytics decisions before any D/E/F staging.
CHARTS_AUTHORIZED=NO
PREDICTIVE_ANALYTICS_AUTHORIZED=NO
REMOTE_ANALYTICS_AUTHORITY=NO
SOURCE_CHANGED=NO
PERMANENT_MEMORY_CHANGED=NO
METHODOLOGY_CHANGED=NO
~~~
