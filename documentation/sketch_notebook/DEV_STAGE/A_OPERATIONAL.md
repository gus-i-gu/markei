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

<!-- ROUND_MARKER:C11-PH03-R01-O-2026-07-31 -->
# Cycle C11 PH03 Round 01 — Operational Investigation

## 1. Identity and authority

Operational Chat [O] ran `SEQ-INV-02`, `ERI-01`, and `FCA-02` as a read-only
repository investigation followed by one cumulative A-stage append. Operational
authority covers execution, local persistence, runtime and lifecycle behavior,
validation evidence, failure states, operational cost, and safe-stop gates.

This round does not authorize source, test, schema, dependency, generated-source,
provider, permanent-memory, Main-root, methodology, D/E/F, G/H/I, J, or KANBAN
change. The former R07 causal/backend engine is deferred and inactive.

Claim-state use in this round:

- **retained**: still supported by earlier authority and current repository truth;
- **new**: established by PH03 inspection;
- **corrected**: replaces an earlier incomplete interpretation;
- **superseded**: historical guidance no longer current;
- **contradicted**: current repository truth disproves the claim;
- **unresolved**: Main/human selection or missing evidence remains necessary;
- **prospective**: a bounded later implementation or validation proposal;
- **deferred**: excluded from PH03.

## 2. Inputs and repository HEAD

Repository `gus-i-gu/markei`, branch
`grm-guarded-provisioning-20260727`, starting remote HEAD
`e8723bec10836e37bc1a7cf22fcb6de21dd03cf4`.

The required baseline is the exact remote HEAD. There was no intervening
advancement. Complete methodology boot was performed sequentially through
`AGENTS.md`, `INDEX.md`, `PROMPT_COLLECTION.md`, `METHOD_FOUNDATIONS.md`,
`FLUX.md`, `PROMOTION_RULES.md`, `CHAT_PROTOCOL.md`, `CHAT_BEHAVIOUR.md`, and
`METHOD_GLOSSARY.md`. PRI-O and PMC-01 resolved the role; PMC-02 was not needed.

Authority was recovered, in order, from:

1. `[M]_STAGE/J_MAIN_STAGE.md` section 10;
2. `00_PROJECT_STATE.md`, current PH03 segment;
3. `05_SESSION_LOG.md`, latest PH03 entry;
4. `06_SESSION_SCHEME.md`, active PH03 checkpoint;
5. `operational/10_OPERATIONAL_STATE.md`;
6. the preceding `A_OPERATIONAL.md` round;
7. the `D_OPS_STAGE.md` tail as provisional historical cache only;
8. `G_OPS_CODEX.md` only for existing validation and lifecycle evidence.

The complete tracked topology was scanned before narrowing: 610 paths covering
legacy Python, Flutter client, API service, contracts, scripts, platform hosts,
schema/migrations, generated output, tests, documentation, and staging.

## 3. New repository evidence

### 3.1 Current product surfaces

`MarkeiDestinationId` in
`clients/markei_flutter/lib/app/navigation/markei_destination.dart` reserves
both `audit` and `closure`. `_MarkeiAppState._destinations` and `_pages` in
`app/markei_app.dart` always expose Audit as a reserved page and expose Closure
only when `MarkeiComposition.nativeClosureSurfaceEnabled` is true.

`MarkeiComposition.appPrivate()` enables Closure only when the compile-time
`MARKEI_NATIVE_CLOSURE_SURFACE` flag is true and
`NativeAuthConfiguration.fromEnvironment()` is ready. The configuration reads
Auth0 domain/client/audience and hosted HTTPS origin compile-time values. The
environment alias used by local hosted identity and diagnostics is the fixed
`provider-native` string.

`MarkeiShell` in `app/widgets/markei_shell.dart` uses:

- compact `<600`: Home, Lists, Purchase, History, plus a More sheet containing
  all other destinations;
- medium `600–1023`: scrollable icon-only navigation rail;
- wide `>=1024`: scrollable extended navigation rail.

Audit therefore appears in every layout today but is non-functional. Closure
appears in every layout only under the environment flag. `_visibleSelectedId`
falls back to Home if a selected destination disappears. Existing tests cover
Closure reachability, the compact More list, and selection survival when the
Closure flag changes.

### 3.2 Settings inventory and execution truth

`SettingsPage` owns three `TextEditingController`s, `_refresh`, and `_message`.
It exposes:

| Capability | Input/output | Scope and persistence | Current failure/risk |
| --- | --- | --- | --- |
| list People | Account ID + kind -> ordered `LocalReference` list | local SQLite; Account-scoped; includes archived | `FutureBuilder` treats loading/error as empty; no explicit unavailable state |
| save Person | nickname -> immutable UUID plus `@NNN`, active row | transaction; local Account; calls `onChanged` | trims and rejects empty in repository, but page catches nothing; repeated taps remain enabled |
| archive Person | Account/kind/reference ID -> inactive row | local Account write; history label retained | callback is neither awaited nor followed by refresh/message/`onChanged`; UI may remain stale |
| list Payment Methods | Account ID + kind -> ordered list | local SQLite; Account-scoped; no payment credential stored | same loading/error ambiguity |
| save Payment Method | nickname -> UUID plus `#NNN`, active row | transaction; local Account; calls `onChanged` | same uncaught error and concurrency risks |
| archive Payment Method | Account/kind/reference ID -> inactive row | local Account write | same stale UI and unobserved Future risk |
| shortage threshold | text -> integer days | `account_preferences`, Account primary key; valid 0–365 | controller always starts at `5`; persisted value is never loaded; `int.parse` and repository errors are uncaught |

`LocalQueryRepository.listReferences`, `saveReference`, `archiveReference`,
`shortageThresholdDays`, and `setShortageThresholdDays` are the handwritten
authority. People and Payment Method allocation is transactional and Account
scoped. The threshold persists locally. Settings performs no network, Auth,
Sync, provider, Device, environment, or diagnostic operation.

**New correction:** Settings persistence is implemented, but Settings cannot be
classified fully functional until it loads the stored threshold, distinguishes
loading/empty/error, validates safely, observes archive completion, refreshes
after archive, and has focused behavior tests. The earlier broad statement that
Settings behavior was merely “unchanged” remains true for PH01/PH02 but is
insufficient as PH03 acceptance.

### 3.3 Closure capability inventory

`NativeClosurePage` owns `_state`, `_running`, `_failedRecoveryAttempted`,
`_snapshot`, and `_currentAction`. It calls `_refreshDiagnostics()` in
`initState`; because `MarkeiApp` uses an `IndexedStack`, a flag-enabled Closure
page can perform its local diagnostic load while hidden. The page has no
visibility gate. It owns no disposable resource, but the composition-created
database and two `http.Client` instances have no application-level disposal
route.

The complete visible and runner capability disposition is:

| Capability / symbol | Input and output | Scope; reads/writes/effects | Retry/idempotency; failure | Operational recommendation |
| --- | --- | --- | --- | --- |
| build provenance / `_BuildProvenanceView` | validated revision and tree digest -> labels | build-local, no DB/network | rejects unsafe/incomplete metadata; test-validated | **Advanced/Support-only**, retained |
| automatic `diagnostics()` / `_refreshDiagnostics` | in-memory auth state -> `ClosureDiagnosticsSnapshot` | Account + environment history; Account queue/devices; local reads only | repeats full snapshot; exceptions during init are not caught | source for **Audit + System Health**, but replace hidden eager load |
| `status()` | none -> auth state | in-memory credential state; no local DB/network | repeatable; configuration-missing | **Settings/Account status** or System Health; not a separate ordinary action |
| `signIn()` | user interaction -> auth state | Auth0 browser/provider; in-memory credentials | user-cancel/reject/unavailable states; not idempotent interaction | **Settings/Account**, explicit network action |
| `enrollOrQueryDevice()` despite UI label “Enroll” | generated command -> enrollment outcome | local hosted identity writes, Auth0 sign-in/token, hosted enrollment/query API | request identity is stable through stored state; may require restart; mutating | **Advanced/Support-only**; label is misleading and ordinary navigation unsafe |
| `queryEnrollment()` | stored request -> enrollment outcome | local hosted state + access token + hosted query API; local state writes | replay-oriented; currently has no UI caller | **development/support-only** or retire after Main decides |
| `checkHostedConnection()` | generated correlation -> readiness result | two hosted health requests through `HttpHostedConnectionCheck`; writes one local attempt | explicit repeat creates another attempt; provider/readiness unavailable outcomes | **Advanced/Support-only**; not Audit and not ordinary status refresh |
| `hostedSyncProbe()` | current auth/binding/queue -> Sync outcome | Auth, local queue/submission/inbox/cursor writes, upload/download/ack network, attempt/phase writes | 35 s client deadline; identity-aware but side-effectful; typed blocked/rejected/timeout/failure | remove from ordinary Closure navigation; retain only in separately authorized Sync/Support surface |
| `logout()` | none -> `signed-out-cleared` | clears in-memory credentials and invokes Auth0 logout | provider logout failures are swallowed by SDK adapter, while returned state remains cleared | **Settings/Account**, with truthful local/provider outcome and confirmation decision |
| `unknownRetryPreflight()` | auth + local candidate -> eligibility | current Account + Device + environment; local transaction reads only | validates one isolated unknown submission, lineage, hash and next sequence | **Advanced/Support-only** preflight |
| `retryUnresolvedSubmission()` | confirmed preflight -> Sync status | calls full `hostedSyncProbe`, therefore may upload, download, acknowledge, mutate local facts and record history | not a read-only “same submission only” UI action; confirmation exists | ordinary product navigation **unsafe**; retain only after Main defines exact support semantics |
| `inspectFailedNotAppliedRecovery()` | auth + generated fingerprint -> inspection | Account/Device local transaction reads, then writes diagnostic attempt/event/result | no provider request, but not read-only because it records history | **Advanced/Support-only**; cannot be ordinary Audit |
| `recoverFailedNotAppliedCandidate()` | confirmed inspection -> recovery result | revalidates auth/binding, mutates failed batch/lease, sends at most one upload, persists result, writes diagnostics | one page-session lock only; confirmation exists; no download/ack/ordinary Sync | **development/support-only**, unsafe for ordinary product navigation |
| `clearDiagnosticHistory()` | confirmation -> void | deletes all `sync_attempts` for current Account + environment; diagnostic events cascade; queue/facts remain | destructive and repeatable; no retention/export policy | candidate for **retirement from ordinary UI**; unresolved Support placement |

### 3.4 Closure views and local data meaning

The current page renders:

- current action result: session-local action result plus newest diagnostic;
- Sync overview: authentication, enrollment, readiness, last result, last
  successful Sync, guidance, phase/deadline/fingerprints;
- local queue: Account-wide pending/uploading/failed/unknown plus current Device
  next sequence;
- recent attempts: latest 20 for Account + environment;
- grouped diagnostic lifecycle: latest 30 phase events for Account +
  environment, regrouped by operation fingerprint;
- Devices: every Device for the Account, current first;
- actionable events: latest 20 Account events in pending/failed/unknown states;
- build provenance;
- the mutating/network action group.

**New classification:** recent attempts and grouped lifecycle are the only
direct safe Audit-history candidates. Current action is session status. Sync
overview, queue, Devices and actionable events are current System Health. Build
provenance is Support. The action group is not Audit.

## 4. Component, function, and object additions to the cumulative index

Relevant handwritten ownership:

- `MarkeiApp._destinations`, `_pages`, `_visibleSelectedId`,
  `_selectedPageIndex`: navigation and page lifetime;
- `MarkeiShell.build`, `_selectCompactDestination`: compact/medium/wide
  navigation projection;
- `MarkeiComposition.appPrivate`, `_nativeClosureRunner`: active Account/Device,
  environment flag, service assembly, and long-lived resources;
- `SettingsPage._saveReference`, `_saveThreshold`, `_ReferenceSection.build`:
  current Settings execution;
- `NativeClosurePage._run`, `_runDiagnostics`,
  `_confirmRetryUnknownOutcome`, `_inspectFailedNotApplied`,
  `_confirmRecoverFailedNotApplied`, `_confirmClearHistory`: UI action and
  confirmation boundaries;
- `NativeAuthClosureRunner`: Auth/enrollment/health/Sync/recovery orchestration,
  diagnostic recording and sanitized lifecycle emission;
- `ClosureDiagnosticsQuery`, `SyncAttemptRecorder`,
  `ClosureDiagnosticsSnapshot` and summary models: application contracts;
- `DriftClosureDiagnosticsRepository`: local projection, preflight validation,
  history mutation, ordering and sanitization;
- `LocalQueryRepository`: Settings persistence and Account guards;
- `diagnostics.registry.json`: only handwritten diagnostic registry;
- `scripts/generate_sync_diagnostics.mjs`: validates 159 entries and generates
  Dart, TypeScript and `documentation/ERR_DIAGNOSTICS.md`; generated output must
  not be inspected or edited line-by-line absent drift.

The diagnostic schema forbids token, password, payload, connection string,
complete hash, private URL, stack trace, and SQL fields. Repository helpers
sanitize codes, fingerprints, identifiers, MKS codes, summaries and exception
classes. UI tests establish that raw tokens, SQL, paths and full exception text
are not displayed. This is strong automated evidence, not a complete secret
exposure audit.

## 5. Retained conclusions

- **Retained:** PH03 requires mandatory functional Settings, mandatory
  functional Audit, Audit replacing Closure in ordinary navigation, and a
  complete Closure capability disposition.
- **Retained:** ordinary Audit must be deterministic, local, Account-scoped,
  sanitized, truthful when empty/unavailable/stale, and usable without network.
- **Retained:** no schema, migration, dependency, generator, provider, Sync
  redesign, hosted Audit, causal engine, automatic retry/recovery, or R07 work
  is authorized.
- **Retained:** PH01/PH02 automated/build evidence does not establish current
  PH03 screenshots, assistive-technology, keyboard, real-device, locale, or
  human acceptance.
- **Retained:** Cycle 10 production and broader Account/Device acceptance remain
  closed/deferred and are not reopened.

## 6. Corrections and contradictions

1. **Corrected:** `diagnostics()` is local-only, but “Closure diagnostics” is
   not one semantic surface. It combines Audit history, current System Health,
   Support provenance, and action controls.
2. **Corrected:** failed/notApplied inspection performs no provider call, but it
   writes attempt/event history; it is not read-only Audit.
3. **Corrected:** unknown Retry is not narrowly limited to resending the unknown
   submission at the runner boundary; after preflight it executes the ordinary
   Sync coordinator, including later phases when reached.
4. **Contradicted:** current Audit is not functional. It is a reserved page.
5. **Contradicted:** current Settings UI safely reflects persisted threshold.
   The controller always initializes to `5` without reading the repository.
6. **Contradicted:** current Closure history is “complete.” It is bounded to 20
   attempts and 30 diagnostic events with no paging; a lifecycle can be cut.
7. **Superseded:** Closure as an ordinary destination is the product terminal.
   J section 10 selects Audit replacement after bounded materialization.

## 7. Confrontation with latest J

J section 10 is consistent with repository truth: Audit is reserved; Settings
exists but requires functional hardening; Closure is feature-gated but mixes
capabilities with different side effects. The smallest honest PH03 result must
move only safe projections into ordinary Audit, preserve local Settings facts,
remove Closure from ordinary navigation, and leave risky operations outside
ordinary product access.

J does not decide whether Account sign-in/logout belong visibly in Settings,
whether System Health is embedded in Audit or Settings, whether bounded recent
history satisfies the first Audit release, or whether clear-history remains in
Support. Those decisions cannot be inferred by Operational.

## 8. Confrontation with paired D/E/F

The current `D_OPS_STAGE.md` tail is a provisional historical cache for the
consumed PH01/PH02 materialization. It explicitly excluded PH03 and grants no
current source authority. Its stable lifecycle lesson—visibility-gate hidden
work and separate local reads from network actions—is retained. Its authorized
paths and Codex terminal are superseded for execution and must not be reused.

D/E/F remain inactive. No Codex instruction exists for PH03.

## 9. Cross-domain consequences

- Didactic must distinguish Audit history, current status/System Health,
  Settings configuration, Account session actions, and Support recovery.
- Design must split the current `ClosureDiagnosticsSnapshot` responsibility or
  provide separate projections without creating a new persistence model.
- Main must choose placement and labels for Account sign-in/logout, System
  Health, bounded-history disclosure, and Support access.
- Navigation removal must preserve selected destination fallback and identical
  page state across breakpoints.
- Sanitized fingerprints are still identifiers; user-facing meaning and copy
  require Didactic review even when secrets are excluded.

## 10. Prospective additions and smallest implementation boundary

### 10.1 Schema-free, dependency-free, provider-free boundary

**Prospective boundary:**

1. make Audit an implemented page backed only by a read-only local projection;
2. present recent attempts and grouped diagnostic phases as Audit history, with
   explicit `recent 20 / recent 30-event window` disclosure and freshness time;
3. present queue/readiness/Devices/actionable events separately as current
   System Health, not historical Audit;
4. retain Settings local behavior while fixing stored-threshold load,
   validation, async/error states, archive refresh and tests;
5. remove Closure from ordinary wide/medium/compact navigation regardless of
   `MARKEI_NATIVE_CLOSURE_SURFACE`;
6. retain runner/repositories only as non-navigation support infrastructure
   until Main selects retirement or an explicit Advanced/Support entry;
7. add no schema, migration, package, generator, API, provider or Sync change.

Likely affected surfaces are `markei_destination.dart`, `markei_app.dart`,
`markei_composition.dart`, a functional `audit_page.dart` or an approved rename
of the current page, `settings_page.dart`, the closure diagnostic application
projection/repository, and focused tests. Exact paths remain **prospective**;
Main/Design owns the final path envelope.

Reversibility is high because current tables and runner remain intact. An Audit
projection can be removed without data migration. Retiring the underlying
runner or clear-history path is a separate, less reversible decision and should
not be bundled into the first materialization.

### 10.2 Audit data behavior and cost

Current `snapshot()` performs seven sequential local SQL reads after auth state
is obtained: hosted state, Devices, queue counts, attempts, diagnostic events,
actionable events, and last successful Sync. There is no N+1 loop. However:

- Devices and queue counting load all matching rows into memory;
- attempts are ordered by `startedAt DESC, id DESC`, limit 20;
- diagnostics are ordered by `recordedAt DESC, id DESC`, limit 30;
- actionable events are ordered by `enqueuedAt DESC`, Device sequence and ID,
  limit 20;
- last success is one ordered row;
- there is no cursor/page API;
- there is no automatic retention or age cutoff;
- deletion removes every attempt for the Account/environment and cascades
  diagnostic events;
- `refreshedAt` exists but is not shown;
- load errors have no explicit Audit unavailable state;
- page init failures are not safely surfaced;
- diagnostic limit can split an operation lifecycle.

For the first PH03 boundary, no full-history claim is valid. The honest choice
is either a disclosed recent window or a blocked decision requiring paging.
Performance must be measured with large attempt/event/device/queue fixtures
before publication. No index or schema change follows automatically from a
failed measurement.

## 11. Risks and non-goals

Highest operational risks:

1. accidentally making Audit refresh invoke Auth, health, Sync, Retry, Recovery
   or provider access;
2. presenting current queue/readiness as historical evidence;
3. leaking cross-Account hosted state because `snapshot()` selects
   `hosted_auth_states` by environment alias only and assumes composition
   alignment;
4. claiming complete history from bounded, non-paged reads;
5. hidden `IndexedStack` loads and repeated breakpoint loads;
6. deleting history from an ordinary read-only Audit surface;
7. leaving database/HTTP clients undisposed;
8. preserving misleading labels such as “Enroll” and “Retry unknown-outcome
   submission” for broader side-effectful operations;
9. Settings silently overwriting a non-default stored threshold with `5`;
10. unbounded queue/device materialization on long-lived clients.

Non-goals remain R07, causal inference, new ledger, full provider observability,
telemetry, hosted cross-device Audit, Sync redesign, automatic repair,
schema/migration/index work, dependencies, production acceptance, GCM04,
multiple-Account/provider assay, credential inspection, and live operations.

## 12. Human/Main decisions and exact later validation ladder

Main/human decisions required:

1. Does first-release Audit disclose a bounded recent window, or is paging a
   release requirement?
2. Does System Health live within Audit as a distinct section, within Settings,
   or behind Advanced/Support?
3. Do sign-in/logout become an Account section in Settings, and what confirmation
   and partial-logout wording is required?
4. Is any Advanced/Support entry user-visible, build-flag-only, or absent while
   the runner remains test/operator infrastructure?
5. Is clear diagnostic history retired, Support-only, or deferred until a
   retention/export policy exists?
6. Are query-enrollment and failed/notApplied recovery retained or retired from
   the client surface?
7. What fixture sizes and host targets define acceptable Audit performance?

Exact later validation gates:

```text
cd clients/markei_flutter
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test test/app/settings_page_test.dart
flutter test test/app/audit_page_test.dart
flutter test test/infrastructure/closure_diagnostics_repository_test.dart
flutter test test/app/native_closure_surface_test.dart
flutter test test/app/native_closure_diagnostics_test.dart
flutter test test/app/markei_visual_foundation_test.dart
flutter test test/app/markei_app_test.dart
flutter test test/infrastructure/native_auth_composition_test.dart
flutter test test/sync/sync_diagnostic_registry_test.dart
flutter test
flutter build windows --release
flutter build apk --debug
cd ../..
node scripts/generate_sync_diagnostics.mjs --check
git diff --check
```

Required assertions, not merely command success:

- ordinary Audit initial load, explicit refresh, filtering, expansion and
  breakpoint changes produce zero Auth sign-in/logout, enrollment, health,
  Sync, Retry, Recovery, HTTP or provider calls;
- before/after hashes or row counts for Account, hosted-auth, queue, submission,
  event, attempt and diagnostic tables remain identical during ordinary Audit;
- two-Account adversarial fixtures return only the requested Account, including
  hosted-state mismatch, attempts, diagnostics, queue, Devices and events;
- no token, credential, payload, SQL, path, stack trace, complete hash, raw
  Account/Device/submission ID, private URL or provider secret reaches UI/logs;
- Audit loads only when visible, refreshes once per explicit request, suppresses
  stale async completion, shows freshness/window/empty/unavailable states, and
  preserves one state across widths 599, 600, 1023 and 1024 plus 200% text;
- Closure is absent from wide/medium rail and compact More with flag both false
  and true; Audit is reachable in both; hidden support infrastructure cannot be
  navigated ordinarily;
- Settings loads the persisted threshold, preserves Account isolation across
  reopen, validates 0–365 without uncaught exceptions, refreshes after archive,
  distinguishes loading/empty/error, prevents duplicate async submissions, and
  never performs network/diagnostic calls;
- lifecycle tests prove Audit controller/query and any injected clients are
  disposed, hidden pages do not read, responsive transitions do not reload, and
  database/HTTP ownership has an explicit close path;
- performance fixtures record local query count, row count, elapsed time and
  peak rendered rows; any N+1, unbounded widget construction, split-lifecycle
  misrepresentation or visible hang blocks publication;
- screenshots, Windows keyboard/Narrator, Android TalkBack/Back/rotation/insets,
  real-device and human comprehension remain separately recorded human gates.

## 13. Recommendation to Main and proposed Operational D gates

### Capability-disposition recommendation

- **Audit:** recent attempts and grouped diagnostic history, local/read-only,
  Account/environment scoped, sanitized, bounded and freshness-labelled.
- **Settings:** existing People, Payment Methods and shortage threshold after
  functional hardening; prospective Account sign-in/logout only after Main
  chooses semantics.
- **System Health:** authentication/enrollment/readiness, queue, last success,
  Devices and actionable events as a separately labelled current projection.
- **Advanced/Support-only:** build provenance, hosted connection check,
  enrollment/query, unknown preflight/retry, failed/notApplied inspection.
- **Development-only:** bounded failed/notApplied recovery and raw lifecycle
  details until a future explicit product decision.
- **Unsafe for ordinary navigation:** ordinary Sync, Retry, Recovery, Enroll,
  provider health, history clearing, and raw diagnostics controls.
- **Retirement candidates:** Closure destination/label, unused
  `queryEnrollment()` UI path, ordinary clear-history control, and recovery
  controls if no Support surface is approved.
- **Unresolved:** Account sign-in/logout placement, System Health placement,
  paging versus disclosed window, Support discoverability, and clear-history
  policy.

Proposed Operational D gates:

1. exact activation ancestry and narrow changed-path allowlist;
2. functional Settings preservation and focused tests before visual changes;
3. separate read-only Audit query from mutating/support runner methods;
4. zero-network and zero-write ordinary Audit instrumentation;
5. Account/environment isolation including mismatched hosted state;
6. sanitized projection and generated-registry drift check;
7. explicit freshness, ordering, limits, empty/unavailable and partial-window
   copy;
8. Closure removal from ordinary navigation for all flags/layouts;
9. visibility-gated loading, stale-generation suppression and disposal;
10. fixed query-count and bounded rendering/performance fixtures;
11. full regression, analysis, Windows release and Android debug builds;
12. separate automated, rendered, assistive-technology, real-device and human
    evidence; no promotion from build success alone;
13. stop on schema, dependency, generated output, provider, Sync behavior, R07,
    production boundary or unauthorized Support expansion.

## 14. Next route

### Evidence still required

- focused Settings behavior tests and persisted-threshold evidence;
- instrumented Audit no-network/no-write/query-count tests;
- adversarial Account/environment isolation for hosted state;
- large local history/queue/device performance and lifecycle-splitting fixtures;
- resource-disposal evidence for database and both HTTP clients;
- human placement decisions and later platform/accessibility evidence.

### Decisions Main cannot infer

Main cannot infer bounded-window acceptance, System Health placement,
Account sign-in/logout semantics, Support discoverability, clear-history
retention policy, retirement of enrollment/recovery controls, or performance
fixture targets from repository truth alone.

### Performance improvement achieved by the investigation

No runtime performance changed. The investigation established the exact
seven-query snapshot baseline, identified unbounded queue/device loads and
bounded-but-unpaged history, and reduced the next implementation search space
from the entire Closure runner to three explicit projections plus Settings.
This removes ambiguous validation and N+1 speculation before staging.

### Exit gate for Main reconciliation

Main may reconcile when matching PH03 B/C reports are published and every
capability has one selected destination or explicit unresolved state. D/E/F may
be prepared only after the seven Main decisions above are resolved or bounded
as explicit stop gates.

### Sequence Handoff Envelope

```text
SEQUENCE=FLX-INV-02
CYCLE=C11
PHASE=C11-PH03
ROUND=C11-PH03-R01
ROLE=O
REMOTE_HEAD=e8723bec10836e37bc1a7cf22fcb6de21dd03cf4
OUTPUT=documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
SETTINGS_STATE=IMPLEMENTED_WITH_FUNCTIONAL_GAPS
AUDIT_STATE=RESERVED
CLOSURE_STATE=FEATURE_GATED_MIXED_CAPABILITY_SURFACE
ORDINARY_AUDIT_BOUNDARY=LOCAL_ACCOUNT_SCOPED_READ_ONLY_RECENT_HISTORY
SYSTEM_HEALTH_BOUNDARY=SEPARATE_CURRENT_LOCAL_PROJECTION
R07_IMPLEMENTATION_AUTHORIZED=NO
LIVE_OPERATION_PERFORMED=NO
SOURCE_CHANGED=NO
PERMANENT_MEMORY_CHANGED=NO
METHODOLOGY_CHANGED=NO
D_E_F_STATUS=INACTIVE
CODEX_STATUS=INACTIVE
NEXT_MAIN_ACTION=RECONCILE_PH03_A_B_C_AND_RESOLVE_PLACEMENT_RETENTION_PAGING_SUPPORT_AND_ACCOUNT_SESSION_DECISIONS
```

D/E/F and Codex remain explicitly inactive.
