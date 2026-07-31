# C_DESIGN — C11-PH02 Local Analytics Architecture

> Role: Design Chat [D]
> Cycle / phase: C11 / C11-PH02
> Date: 2026-07-31
> Repository / branch: `gus-i-gu/markei` / `grm-guarded-provisioning-20260727`
> Inspected remote HEAD: `f6c1ae653bc50449f1308de72516c4bda3e39ebc`
> Writable surface: `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
> Status: proposed

## 1. Recovered state and authority

Design [D] owns architectural investigation: responsibility, dependency
direction, identity, state lifetime, invariants, alternatives, reversibility and
validation design. This MSU-02 round may replace only this temporary Design
stage. It does not authorize source, tests, schemas, dependencies, G/H/I, J,
permanent memory, methodology, provider operations or reconciliation.

Recovered Main state:

- Cycle 10 is accepted only within its documented two-Device, one-Account,
  development scope.
- C11-PH01-S01 is implemented and validated at
  `1c7df53c095f4e7c1d85f278ba16c21fd95b25e6`.
- C11-PH01-S02 is staged but not implemented at the inspected HEAD.
- The branch advanced during this investigation from `f6566a4…` to
  `f6c1ae6…` through one compatible PH01-S02-R01 D/E/F-only recovery staging
  commit. It adds no remote source or materialization evidence and does not
  overlap A/B/C.
- C11-PH02 owns deterministic local, Account-scoped Analytics.
- C11-PH03 retains Settings, Audit and Closure disposition.
- hosted coordination, Sync, diagnostics and recovery are not Analytics
  authority.

Human direction in this round explicitly makes PH01 evidence a qualification,
not a PH02 stop gate. This report therefore carries unfinished PH01 page
convergence without redesigning the implemented shell, theme or responsive
foundation.

## 2. Hierarchical recovery and justified deeper reads

Primary recovery followed the required order:

1. latest `J_MAIN_STAGE.md`;
2. `00_PROJECT_STATE.md`;
3. latest relevant `05_SESSION_LOG.md` segment;
4. active `06_SESSION_SCHEME.md`;
5. `design/09_DESIGN_STATE.md`.

Deeper reads and reasons:

- G/H/I were required to separate PH01 implementation, automated validation,
  rendered artifacts and human acceptance.
- commit `1c7df53…` was required to verify PH01 changed paths.
- `analytics_registry.dart` was required because the checkpoint does not define
  a usable PH02 calculation contract.
- `history_page.dart` and `purchase_history.dart` were required to classify the
  present History selection and typed handoff seam.
- `local_database.dart`, `local_query_repository.dart`, Purchase, quantity,
  Catalogue and local-reference types were required to assign exact authority
  for the twelve matrix fields and to detect absent facts.
- shell, destination, theme and shared-component files were required only to
  inherit implemented responsive ownership without redesign.

PMC-02 was not invoked: routing, semantic ownership and promotion authority are
explicit in the invoking instruction and recovered surfaces.

## 3. PH01 classification

Overall PH01 classification: **PARTIAL**.

| Evidence layer | Classification | Evidence |
| --- | --- | --- |
| S01 implementation | implemented | `1c7df53…` changes shell, theme, destinations, shared components, Home and Lists |
| S01 automated validation | validated | focused tests, 245-test suite, analyze and diff checks recorded in G/H/I |
| S01 rendered artifacts | validated | Windows release build and Android debug APK were produced with recorded hashes |
| S01 human acceptance | ABSENT | no Windows/Android visual, real-device, screen-reader or keyboard-only acceptance |
| S02 implementation | ABSENT | no Catalogue, History or Purchase convergence descendant is present |
| complete five-page PH01 | PARTIAL | Home and Lists implemented; Catalogue, History and Purchase remain unavailable |

The implemented responsive constitution is retained:

- destination identity is enum/ID-based;
- page state is retained by `IndexedStack`;
- layout classes are compact `<600`, medium `600–1023`, wide `>=1024`;
- tokens and shared components are presentation semantics;
- shared widgets do not query repositories or calculate Analytics;
- responsive projections must consume the same state.

Unavailable S02 structures qualify PH02 as follows:

- Analytics must use the implemented shell and tokens.
- It must not depend on unfinished Catalogue, History or Purchase visual
  recomposition.
- The existing History page may gain only a typed navigation callback in a
  later authorized slice; its broader PH01 redesign remains separate.
- No claim of visual parity or human platform acceptance may be inherited.

## 4. Inspected application surfaces

| Surface | Current responsibility | PH02 consequence |
| --- | --- | --- |
| `domain/analytics/analytics_registry.dart` | version-keyed zero-input placeholder returning `0` | implemented registry shape is insufficient; retain versioned identity, replace placeholder execution contract |
| `app/markei_composition.dart` | constructs local repositories and Account/Device scope | compose Analytics local evidence adapter here; no provider/Sync input |
| `app/markei_app.dart` | stable destinations, retained pages and reserved Analytics page | replace reservation only in later authorized source work |
| `app/pages/history_page.dart` | Account-scoped History, selected Purchase IDs, export and detail | typed Purchase-ID handoff is the lowest-coupling seam |
| `application/purchase_history.dart` | History projections and price comparison | useful evidence precedent, not Analytics authority |
| `infrastructure/local/local_database.dart` | authoritative local tables | local evidence authority |
| `infrastructure/local/local_query_repository.dart` | Account-scoped joins/projections | precedent for one joined Analytics adapter; do not add per-row repository calls |
| `domain/purchase/purchase.dart` | Purchase and Purchase Item facts | authoritative money, quantity and identity invariants |
| `domain/shared/quantity.dart` | canonical quantity units and microunit scale | quantity/unit-price compatibility authority |
| `domain/references/local_reference.dart` | person/payment labels and archived-state meaning | matrix labels remain facts resolved by ID |
| theme/shell/shared components | responsive presentation foundation | inherited unchanged |

## 5. Authority boundary and dependency direction

Proposed dependency direction:

```text
Analytics page/widgets
  -> Analytics workspace/controller
  -> Analytics use cases and versioned registry
  -> AnalyticsEvidenceRepository port
  -> Drift local Analytics evidence adapter
  -> Account-scoped local Product/Purchase tables
```

Rules:

1. Local SQLite Product and Purchase facts are Analytics authority.
2. Every evidence load requires an `AccountId`; the adapter applies the Account
   predicate before returning rows.
3. Remote transports, Sync events, submissions, diagnostics, Audit and hosted
   identity are excluded from the graph.
4. Widgets receive typed state, formatted values and callbacks. They do not
   query repositories, normalize quantities, perform arithmetic or interpret
   failure causes.
5. The evidence adapter joins facts; the executor calculates results.
6. History transfers typed context but never calculates an Analytics result.
7. Results are reproducible from a configuration snapshot, registry
   identifier/version and the referenced evidence-row identities.
8. Missing facts remain unavailable; Analytics cannot repair raw data.

## 6. Twelve-field evidence matrix

The proposed supporting matrix is item-level because `purchase_items.id` is the
smallest stable fact identity that relates Purchase, Product, quantity and
money. Purchase-level values must be deduplicated by `purchaseId` where an
operation explicitly uses a Purchase measure.

| Field | Authoritative source | Evidence-row representation | State / qualification |
| --- | --- | --- | --- |
| Purchase | `purchases.id`, scoped by `purchases.account_id` | `PurchaseId purchaseId` | implemented fact |
| date/time | `purchases.occurrence_time` | `DateTime occurrenceInstant` | implemented fact |
| Product | `purchase_items.product_id` → `products.id` | `ProductId`, code, display name | implemented fact |
| Brand | `products.display_brand`, fallback `normalized_brand` | nullable/display label | implemented fact |
| Store | `purchases.store_id` → `stores.id` | `StoreId`, display name | implemented fact |
| purchased by | `purchases.person_id` → `people.id` | nullable reference ID and historical label | implemented fact |
| purchased for | no current field/table relation | unavailable state | blocked |
| payment method | `purchases.payment_method_id` → `payment_methods.id` | nullable reference ID and historical label | implemented fact |
| quantity | `purchase_items.purchased_amount`, `purchased_unit`, `measurement_kind` | fixed microunits + canonical unit/kind | implemented fact |
| unit price | derived from line total / positive normalized quantity | fixed minor-units-per-canonical-unit | proposed derived evidence |
| line total | `purchase_items.line_total_minor_units`, `currency_code` | fixed minor units + currency | implemented fact |
| promotion | no current field/table relation | unavailable state | blocked |

`purchased for` and `promotion` remain visible matrix columns with an explicit
unavailable value. Their absence cannot be inferred from nickname, Product,
price change, notes or Sync payloads.

## 7. Proposed types and stable identities

The exact filenames remain for Main/Codex staging. The architectural types are:

```text
AnalyticsEvidenceRowId
  = PurchaseItemId

AnalyticsEvidenceRow
  rowId
  accountId
  purchaseId
  product identity/facts
  store identity/facts
  occurrenceInstant
  purchasedBy reference?
  purchasedFor = unavailable
  paymentMethod reference?
  quantity
  unitPrice outcome
  lineTotal
  promotion = unavailable

AnalyticsDataset
  accountId
  rows
  loadedAt
  applicablePeriod

AnalyticsCardId
AnalyticsCardRevision
AnalyticsRegistryIdentifier
AnalyticsRegistryVersion

AnalyticsCardConfiguration
  cardId
  revision
  determinant
  variables
  operation
  timeCondition?
  evidenceScope

AnalyticsResultEnvelope
  registry identifier/version
  configuration snapshot
  values
  factual interpretation inputs
  evidence count
  applicable period
  evidence row IDs
  unavailable/blocked outcomes
```

Identity rules:

- row identity is the persisted Purchase Item ID, never a list index;
- Purchase identity remains available for deduplication and History handoff;
- card identity survives reordering and editing during the app session;
- editing increments card revision;
- removal discards the card/configuration/result;
- registry identity and version identify calculation semantics;
- result traceability stores the exact evidence-row IDs used, not only a count.

## 8. Determinants, variables and compatibility

Determinants are a closed type:

- `ProductDeterminant(ProductId? grouping/focus)`;
- `PurchaseDeterminant`;
- `StoreDeterminant(StoreId? grouping/focus)`;
- `TimeDeterminant(TimeGranularity)`.

Time granularity is day, ISO week or month under the time policy in section 10.

Relational variables are numeric measures related to the determinant:

- `QuantityVariable`;
- `UnitPriceVariable`;
- `LineTotalVariable`;
- `PurchaseTotalVariable`;
- `EvidenceCountVariable`.

Categorical matrix fields are determinants, labels or evidence conditions; they
are not silently coerced into numbers.

### Compatibility matrix

| Variable | Sum | Mean | Difference | Percentage | Compatibility key |
| --- | --- | --- | --- | --- | --- |
| quantity | proposed | proposed | proposed | proposed | measurement kind + canonical unit |
| unit price | proposed | proposed | proposed | proposed | currency + measurement kind + canonical unit |
| line total | proposed | proposed | proposed | proposed | currency |
| Purchase total | proposed | proposed | proposed | proposed | currency; distinct Purchase IDs |
| evidence count | proposed | proposed | proposed | proposed | counting unit must be row or distinct Purchase, explicit in configuration |

Rules:

- Mixed currencies never combine into one money value. They produce independent
  currency-keyed values or an explicit unavailable outcome.
- Mixed quantity kinds/units never combine. Quantity and unit-price results are
  keyed by compatible kind/unit, and unit price also by currency.
- Multi-variable cards produce independent typed values under one common
  determinant, evidence scope and period.
- No implicit composite score or cross-variable arithmetic is permitted.
- `PurchaseTotalVariable` deduplicates by `purchaseId`; item rows must not
  multiply the Purchase total.

## 9. Operation architecture

Use operation-specific sealed configuration/result types behind one common
registry definition envelope.

### Sum

For each variable, sum compatible values. Results remain separated by currency
or quantity compatibility key.

### Mean

Mean is the arithmetic mean per contributing aggregation unit:

- item row for quantity, unit price and line total;
- distinct Purchase for Purchase total;
- selected counting unit for evidence count.

The result exposes numerator, contributing count and label such as “per
Purchase Item” or “per Purchase”. Weighted mean is deferred.

### Difference

Difference has ordered operands:

```text
left  = one EvidenceScope
right = one EvidenceScope
```

For each selected variable the registry applies the same aggregate semantics to
both scopes, verifies identical compatibility keys, then returns
`left - right`. Arbitrary user-entered scalars and cross-dimension operands are
blocked.

### Percentage

Percentage has:

```text
numerator   = one EvidenceScope
denominator = one EvidenceScope
```

Both use the same variable, aggregation semantics and compatibility key. The
result is fixed basis points plus numerator and denominator inputs. A zero
denominator returns a typed `zeroDenominator` unavailable outcome; it never
returns zero, infinity or an exception-derived label.

### Registry

The current zero-input `calculate: () => 0` registry is implemented only as a
placeholder. PH02 should retain version lookup but use definitions that own:

- supported operation/configuration type;
- compatibility validation;
- executor;
- result type;
- factual interpretation-input builder;
- registry identifier and version.

Recommended registry identifiers are stable semantic strings such as
`local.sum`, `local.mean`, `local.difference`, `local.percentage`, each at
version `1`. Unknown identifier/version remains blocked.

## 10. Time semantics

Proposed PH02 policy:

- occurrence authority is persisted `purchases.occurrence_time`;
- execution uses the persisted instant in UTC;
- optional time conditions use inclusive start and exclusive end;
- Time determinant buckets are UTC day, ISO week beginning Monday, or calendar
  month;
- UI may display localized labels, but configuration/result envelopes retain
  UTC bounds;
- applicable period is the minimum/maximum contributing instant constrained by
  the configured bounds;
- an empty result reports the configured period and evidence count `0`.

UTC bucketing is recommended because no Account timezone authority currently
exists and device-local bucketing could change after timezone/device changes.
An Account-timezone model remains deferred rather than inferred.

## 11. Dataset, selection, filtering and card lifetime

`AnalyticsWorkspaceController` is proposed as page-local shared state retained
by the existing `IndexedStack`. It owns:

- one complete Account-scoped `AnalyticsDataset`;
- matrix filters and selected row IDs;
- current focused evidence scope;
- ordered cards;
- card configuration revisions and results;
- pending typed History launch context.

State behavior:

1. Loading establishes the complete matrix dataset for the Account.
2. Matrix filters produce a filtered dataset without mutating raw rows.
3. Selecting matrix rows initializes a new card with that selected-row scope.
4. Creating from filters initializes a card with the filtered-dataset scope.
5. Selecting a card focuses the matrix on the exact evidence rows used by its
   latest result.
6. Reset restores all loaded Account evidence, clears matrix filters/selection
   and removes card focus; it does not reload or delete facts.
7. Reordering changes only card order.
8. Editing preserves `cardId`, increments revision and re-executes.
9. Removing a card removes only session state.

Cards are session-local and not persisted in PH02. This avoids schema/migration,
Sync and cross-version lifecycle obligations. Persistence is deferred until
real reuse evidence defines ownership and migration semantics.

## 12. History handoff

Alternatives:

| Handoff | Benefit | Cost/coupling | Classification |
| --- | --- | --- | --- |
| Purchase IDs | already stable and selected by History; Account-scoped resolution; no calculation in History | Analytics expands Purchases to item rows | proposed |
| evidence-row IDs | exact matrix focus | History does not own/expose all item IDs; forces Analytics detail into History | deferred |
| filter context | expressive and compact | current History has no typed filter model; semantic drift risk | deferred |

Recommended contract:

```text
AnalyticsLaunchContext.purchaseSelection(
  accountId,
  Set<PurchaseId>
)
```

History supplies its selected IDs through a callback owned by `MarkeiApp`.
`MarkeiApp` selects the Analytics destination and passes the typed context.
Analytics validates Account scope, resolves rows through
`AnalyticsEvidenceRepository`, initializes the matrix selection and creates no
result until the user chooses a card configuration.

History never imports the Analytics registry or executor.

## 13. Responsive parity

Analytics inherits the implemented shell, breakpoints, theme and shared
components. No PH02 shell redesign is proposed.

Wide:

- repeatable cards above;
- complete supporting matrix below;
- card configuration may use a side disclosure;
- matrix retains dense column projection and horizontal accommodation.

Compact/medium:

- same card order, configuration, results, focused scope and filters;
- cards stack vertically;
- configuration uses progressive disclosure;
- matrix becomes a faithful row-card projection with all twelve fields
  reachable through disclosure.

The compact projection is not a summary that drops evidence. Both layouts use
one workspace/controller and the same row identities. Shared widgets render
state and callbacks only.

## 14. Query boundary and N+1 prevention

Recommended read contract:

```text
AnalyticsEvidenceRepository.loadDataset(
  AccountId accountId,
  AnalyticsEvidenceScope initialScope
)
```

The Drift adapter performs one Account-predicated joined query across
Purchases, Purchase Items, Products, Stores, People and Payment Methods.
Nullable joins preserve unavailable references. It maps every item once,
normalizes fixed quantity through the existing quantity authority and derives a
typed unit-price outcome.

Application composition then:

- groups determinants;
- applies filters/scopes;
- deduplicates Purchase measures;
- invokes registry executors;
- returns result envelopes.

No executor calls a repository per evidence row. Tests must assert one dataset
request per load/retry and zero additional repository requests for filtering,
selection, card focus or reordering.

## 15. Alternatives, costs and recommendations

| Alternative | Benefits | Costs / coupling / validation | Reversibility / compatibility | Recommendation |
| --- | --- | --- | --- | --- |
| joined local query | one consistent snapshot; avoids N+1; exact Account predicate | wider adapter mapping test | additive port/adapter, reversible | proposed |
| application composition from existing History calls | reuses ports | per-Purchase detail calls, incomplete matrix, N+1 | easy initially, expensive later | contradicted |
| complete in-memory dataset | matrix completeness; instant filter/card focus; deterministic session | memory/initial-load cost | reversible behind repository port; measure volumes | proposed |
| incremental/paginated evidence | lower initial memory | cannot honestly expose complete matrix/count without server-like paging state | later adapter evolution possible | deferred |
| session-local cards | no schema/Sync/migration; simple lifetime | no cross-session reuse | highly reversible | proposed |
| locally persisted cards | reuse across sessions | schema, migration, registry-version and deletion semantics | more expensive to reverse | deferred |
| operation-specific types | prevents invalid operands and typed zero states | more types/tests | additive and explicit | proposed |
| one generic model | compact API | runtime validation and illegal combinations | easy to start, costly to harden | contradicted |
| independent multi-variable results | preserves dimensions and traceability | more result entries | compatible with later composite views | proposed |
| composite multi-variable score | compact display | invents semantics outside constitution | difficult to explain/reverse | contradicted |
| compact disclosures | shares one state/model across widths | disclosure/accessibility tests | inherits PH01 foundation | proposed |
| another compact data projection/controller | local layout freedom | state/query drift | conflicts with PH01 parity | contradicted |
| direct calculators | minimal code | scattered semantics, weak version traceability | current placeholder shows the limit | contradicted |
| versioned registry executor | stable semantics, reproducibility, compatibility gates | registry/config/result tests | extends current registry intent | proposed |

## 16. Reversibility and configuration lifetime

- The local evidence port isolates Drift joins from Analytics semantics.
- Operation types and registry definitions are additive and replaceable by
  version, not mutable global behavior.
- Session-only cards require no rollback migration.
- History handoff is an optional callback/context and does not change History
  repository contracts.
- Responsive Analytics widgets remain presentation-only and can evolve without
  changing evidence/executor types.
- Complete-dataset loading can later become incremental behind the port only
  after a protocol preserves complete counts, focus and traceability.
- No schema, dependency, Sync contract or provider topology is required by the
  proposed PH02 baseline.

## 17. Decisions and Main decisions required

Proposed Design decisions:

1. local Account-scoped joined evidence is the only Analytics source;
2. item-level stable evidence identity is `PurchaseItemId`;
3. operation-specific configs/results execute through a versioned registry;
4. complete session dataset and session-local cards are the PH02 baseline;
5. multi-variable results are independent, compatibility-keyed values;
6. Difference and Percentage compare two explicit evidence scopes;
7. Percentage zero denominator is typed unavailable state;
8. History handoff uses typed Purchase IDs;
9. UTC inclusive-start/exclusive-end time semantics are the deterministic
   baseline;
10. one workspace state drives cards and both matrix projections.

Main decisions required:

- accept UTC bucketing until an Account timezone exists;
- accept complete in-memory evidence for the first bounded PH02 unit, subject to
  volume evidence;
- accept session-local cards and defer persistence;
- accept Purchase-ID History handoff;
- accept unavailable `purchased for` and `promotion` columns rather than schema
  invention;
- choose whether `EvidenceCountVariable` defaults to item rows or must always
  require an explicit row/distinct-Purchase choice.

## 18. Bounded implementation slices

1. **Types and registry** — evidence identities, determinants, variables,
   operations, compatibility keys, time conditions and typed outcomes.
2. **Local evidence port/adapter** — one Account-scoped joined Drift query,
   matrix mapping and N+1 characterization.
3. **Executors** — Sum, Mean, Difference and Percentage with fixed arithmetic,
   mixed compatibility and zero-state tests.
4. **Workspace state** — dataset, filters, selection, focus, cards,
   reorder/edit/remove/reset and traceability.
5. **History handoff** — typed Purchase-ID context and destination callback.
6. **Responsive presentation** — cards above complete matrix, common wide and
   compact state, loading/empty/error/unavailable states.
7. **Validation/evidence** — focused, full-suite, build, responsive and
   architecture evidence.

Each slice is independently testable and should remain source-bounded by Main.

## 19. Non-goals

Deferred or blocked:

- forecasting, recommendations, rankings and advanced statistics;
- charts;
- telemetry;
- hosted, provider, Sync-event or diagnostic-derived Analytics;
- external facts;
- repair or mutation of raw Product/Purchase facts;
- persisted card dashboards;
- weighted means;
- Account-timezone schema;
- `purchased for` or promotion schema invention;
- PH01 Catalogue/History/Purchase visual convergence;
- PH03 Settings, Audit or Closure work;
- production, resilience, multiple-Account or provider acceptance.

## 20. Claim/evidence matrix

| Claim | Classification | Evidence |
| --- | --- | --- |
| local Product/Purchase facts are Analytics authority | accepted | J, 00, Design checkpoint and local schema |
| S01 shell/theme/responsive foundation exists | implemented | `1c7df53…`, source and G/H/I |
| S01 automated/build evidence exists | validated | G/H/I |
| human PH01 acceptance exists | contradicted | G/H/I explicitly record none |
| complete PH01 five-page convergence exists | contradicted | S02 implementation commit/source/evidence absent |
| Analytics destination exists | implemented | destination enum and reserved page |
| usable Analytics calculations exist | contradicted | placeholder registry returns zero; reserved page states none active |
| joined evidence adapter and workspace types | proposed | this Design investigation |
| purchased-for authority exists | blocked | no table/domain/projection field |
| promotion authority exists | blocked | no table/domain/projection field |
| History can hand off selected Purchase IDs | proposed | current `_selectedIds` and stable `PurchaseId` |
| remote Analytics authority is needed | contradicted | retained local/account-scoped constitution |

## 21. Proposed F gates and exact later I evidence

Proposed F gates:

1. exact writable paths and no schema/dependency/provider expansion;
2. every evidence query requires `AccountId` and proves the predicate;
3. one joined load; no per-row repository calls;
4. stable Purchase Item row identity and Purchase deduplication tests;
5. all twelve fields represented, with purchased-for/promotion unavailable;
6. fixed integer money/quantity arithmetic only;
7. compatibility tests for mixed currency, kind, unit and missing quantity;
8. Mean contribution-unit tests;
9. Difference operand-order and compatibility tests;
10. Percentage numerator/denominator and zero-denominator tests;
11. UTC time-boundary and bucket tests;
12. independent multi-variable result and evidence-trace tests;
13. session card add/edit/reorder/remove/reset/focus tests;
14. Purchase-ID History context tests without History calculation imports;
15. compact/medium/wide state-parity and complete-field-disclosure tests;
16. full Flutter test/analyze/build gates without live provider operations.

Later I must record:

- exact source/test paths and changed-path inventory;
- final type names, owners and dependency direction;
- registry identifiers/versions and operation definitions;
- query shape, Account predicate and observed request count;
- evidence-row identity and Purchase-deduplication behavior;
- compatibility and zero-state results;
- time policy and boundary cases;
- History handoff dependency check;
- card lifetime and cross-width parity evidence;
- confirmation that widgets contain no repository/calculation authority;
- confirmation that remote/Sync/diagnostic imports are absent from Analytics;
- focused/full test and build evidence;
- any deviation, residual risk and human/rendered acceptance ceiling.

## 22. Concise Main handoff

PH01 is PARTIAL: S01 shell/Home/Lists are implemented and validated, while S02
Catalogue/History/Purchase convergence and all human platform acceptance are
absent. This does not block PH02. Main can reconcile Analytics around one
Account-scoped joined evidence dataset, operation-specific versioned executors,
session-local cards, Purchase-ID History handoff and shared responsive state.
The six Main decisions in section 17 should be resolved before D/E/F.

```text
INSPECTED_REMOTE_HEAD=f6c1ae653bc50449f1308de72516c4bda3e39ebc
PH01_IMPLEMENTATION_COMMIT=1c7df53c095f4e7c1d85f278ba16c21fd95b25e6
PH01_MATERIALIZATION_GATE=PARTIAL
PH01_HUMAN_ACCEPTANCE=ABSENT
ANALYTICS_CURRENT_STATE=implemented-reservation;proposed-functionality
LOCAL_ANALYTICS_AUTHORITY=accepted
ACCOUNT_SCOPING=accepted
EVIDENCE_MATRIX_FIELD_AUTHORITY=proposed
OPERATION_COMPATIBILITY=proposed
TIME_SEMANTICS=proposed
HISTORY_HANDOFF=proposed-purchase-ids
WIDE_COMPACT_STATE_PARITY=implemented-foundation;proposed-analytics
STAGE_STATUS=proposed
MAIN_DECISIONS_REQUIRED=UTC-time;complete-session-dataset;session-local-cards;Purchase-ID-handoff;unavailable-fields;explicit-counting-unit
NEXT_MAIN_ACTION=Reconcile C11-PH01 evidence and the C11-PH02 A/B/C reports into one Main decision set before staging D/E/F.
CHARTS_AUTHORIZED=NO
PREDICTIVE_ANALYTICS_AUTHORIZED=NO
REMOTE_ANALYTICS_AUTHORITY=NO
SOURCE_CHANGED=NO
PERMANENT_MEMORY_CHANGED=NO
METHODOLOGY_CHANGED=NO
```


---

<!-- ROUND_MARKER:C11-PH03-R01-D-2026-07-31 -->
# Cycle C11 PH03 Round 01 — Design Investigation

## 1. Identity and authority

This is the first cumulative FLX-INV-02 / ERI-01 / FCA-02 Design round for
C11-PH03-R01.

Design [D] owns responsibility, dependency direction, identity, lifetime,
invariants, alternatives, reversibility, validation design and structural debt.
This round may append only this C stage. It does not authorize source, tests,
schema, migration, dependency, generated source, provider, Sync, permanent
memory, Main-root, J, D/E/F or Codex mutation.

Classification legend used in this round:

- retained: still supported from the preceding C round or permanent Design
  memory;
- new: first established by this PH03 repository inspection;
- corrected: an earlier broad claim narrowed by current evidence;
- superseded: a prior placement no longer recommended;
- contradicted: repository truth conflicts with the claim;
- unresolved: Main/human choice is required;
- prospective: a bounded later materialization candidate;
- deferred: explicitly outside PH03.

D/E/F and Codex remain inactive.

## 2. Inputs and repository HEAD

Repository: gus-i-gu/markei  
Branch: grm-guarded-provisioning-20260727  
Starting and inspected remote HEAD:
e8723bec10836e37bc1a7cf22fcb6de21dd03cf4  
Required baseline ancestry: identical; PASS  
J authority: J_MAIN_STAGE.md section 10  
Round: C11-PH03-R01

Recovery followed the required order:

1. J section 10;
2. 00_PROJECT_STATE current PH03 segment;
3. latest relevant 05_SESSION_LOG segment;
4. 06_SESSION_SCHEME PH03 checkpoint;
5. design/09_DESIGN_STATE.md;
6. the complete preceding C_DESIGN.md Analytics round;
7. the F_DSN_STAGE tail as provisional historical cache only;
8. I_DSN_CODEX.md for materialized PH01/PH02 boundaries.

The first-round full methodology boot was completed. PMC-02 was not triggered:
role, routing, promotion state and the selected investigative sequence were
explicit and consistent.

The complete Cycle-09-to-current tracked diff was scanned before narrowing. It
identified the Flutter client, API, contracts, generated diagnostics, database,
migrations, tests, scripts and platform surfaces. The PH03 investigation then
narrowed to the exact files listed in section 3.

## 3. New repository evidence

### 3.1 Inspected topology

| Surface | Exact path | Evidence and current responsibility |
| --- | --- | --- |
| app entry | clients/markei_flutter/lib/main.dart | creates app-private composition and runs MarkeiApp; no production close path is visible |
| app composition | clients/markei_flutter/lib/app/markei_composition.dart | creates database, local repositories, native Auth adapter, two HTTP clients, Closure diagnostics adapter, Sync/recovery coordinators and runner |
| app lifecycle/navigation | clients/markei_flutter/lib/app/markei_app.dart | owns selected destination, IndexedStack, page construction and History-to-Analytics handoff |
| destination identity | clients/markei_flutter/lib/app/navigation/markei_destination.dart | stable enum identity includes reserved audit and conditional closure |
| Settings presentation | clients/markei_flutter/lib/app/pages/settings_page.dart | edits local People, Payment Methods and shortage threshold |
| Settings ports | clients/markei_flutter/lib/application/local_references.dart | Account-predicated reference and preference interfaces |
| Settings adapter | clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart | local Account-scoped reads/writes and transactions |
| Closure presentation | clients/markei_flutter/lib/app/pages/native_closure_page.dart | one mixed surface for status, history, Auth, enrollment, network checks, Sync and recovery |
| Closure coordinator | clients/markei_flutter/lib/app/native_auth_closure_runner.dart | coordinates Auth, enrollment, hosted checks, Sync, diagnostics and recovery |
| diagnostics application types | clients/markei_flutter/lib/application/closure_diagnostics.dart | broad read, mutation-preflight, history-clear and recorder interfaces plus projection types |
| local diagnostics adapter | clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart | Account/environment/device-scoped Drift reads, diagnostic writes, preflights and deletion |
| local schema | clients/markei_flutter/lib/infrastructure/local/local_database.dart | existing v12 Sync attempts, diagnostic events, queue, Device, hosted binding and Sync facts |
| generated registry | contracts/shared_beta/diagnostics_v1/diagnostics.registry.json | canonical 159-entry machine-readable diagnostic metadata and redaction policy |
| registry schema | contracts/shared_beta/diagnostics_v1/diagnostics.schema.json | validates code, severity, outcome, cause confidence, visibility and forbidden fields |
| registry generator | scripts/generate_sync_diagnostics.mjs | generates Dart, TypeScript and Markdown projections |
| Dart registry projection | clients/markei_flutter/lib/domain/sync/sync_diagnostic_registry.g.dart | generated local lookup consumed by current Closure presentation |
| page/shell tests | clients/markei_flutter/test/app/native_closure_surface_test.dart; clients/markei_flutter/test/app/markei_app_test.dart | default-hidden flag, explicit dev surface, identity propagation and shell reachability |
| diagnostic UI tests | clients/markei_flutter/test/app/native_closure_diagnostics_test.dart | local-only Diagnostics, redaction, action confirmations and lifecycle rendering |
| adapter tests | clients/markei_flutter/test/infrastructure/closure_diagnostics_repository_test.dart | Account/environment scope, order, bounds, redaction, preflight and deletion behavior |
| hosted path tests | clients/markei_flutter/test/infrastructure/native_closure_sync_path_test.dart; native_auth_composition_test.dart | Auth/Sync composition and network behavior; not PH03 ordinary-Audit authority |

### 3.2 Current app and destination ownership

MarkeiApp owns stable destination identity and the retained IndexedStack. Audit
already has a stable reserved ID and page slot. Closure is appended only when
nativeClosureSurfaceEnabled is true. The flag requires both the compile-time
MARKEI_NATIVE_CLOSURE_SURFACE value and ready native Auth configuration.

New conclusion: removing Closure from ordinary wide and compact navigation does
not require positional migration or a navigation framework change. Remove the
conditional Closure destination/page entry, preserve audit identity, and retain
development support as a nested Settings entry rather than a destination.

### 3.3 Settings truth

Settings is already functional and Account-predicated:

- People and Payment Methods use LocalReferenceRepository;
- shortage threshold uses AccountPreferenceRepository;
- LocalQueryRepository owns the local transaction, UUID identity, visible code
  allocation, archive mutation and validation;
- Settings owns three TextEditingControllers and disposes them;
- list reads are FutureBuilder reads; saves and threshold changes call the
  parent refresh callback;
- Payment Method deliberately stores no card, bank or payment credential.

Corrected claim: PH03 does not need to invent Settings functionality. It must
preserve these responsibilities and may add separately bounded Account/status
and Advanced/Support sections without changing the existing repositories.

Observed debt: archiveReference is invoked directly from a row button without
refresh/error state owned by the page. That is retained Settings debt, not an
Audit or PH03 authority expansion.

### 3.4 Current Closure responsibility and side effects

NativeClosurePage owns transient page state:

- state code;
- running flag;
- one-session recovery lock;
- latest diagnostics snapshot;
- current action summary.

It calls diagnostics during initState. It has no stream, listener or timer. It
checks mounted after asynchronous operations but has no generation token, so
overlapping stale results are prevented mainly by disabling buttons.

NativeAuthClosureRunner is app-layer orchestration, not a read model. Its
dependencies and effects are:

| Method | Authority reached | State mutation / side effect | Network |
| --- | --- | --- | --- |
| status | Auth session | reads current session state | ordinarily none |
| signIn | Auth provider adapter | starts native sign-in and changes session | yes/provider |
| enrollOrQueryDevice | enrollment coordinator and hosted binding repository | may create/query enrollment and persist binding | yes |
| queryEnrollment | enrollment coordinator | queries/replays enrollment and may update local binding | yes |
| checkHostedConnection | hosted connection port and attempt recorder | writes one diagnostic attempt | yes |
| hostedSyncProbe | Sync coordinator, outbox, remote applier, recorder | upload/download/apply/ack plus local attempt/event writes | yes |
| unknownRetryPreflight | diagnostics query | read-only local eligibility check | no |
| retryUnresolvedSubmission | preflight then ordinary Sync | same-identity retry and Sync mutations | yes |
| inspectFailedNotAppliedRecovery | local query plus diagnostic recorder | inspection itself is read-only, but records its inspection attempt/event | no provider call |
| recoverFailedNotAppliedCandidate | recovery coordinator and recorder | revalidates, changes local failed batch, performs at most one upload, persists result | yes |
| logout | Auth adapter | clears session credentials/state | provider SDK/session effect |
| diagnostics | Auth state plus local query | read-only projection | ordinarily no |
| clearDiagnosticHistory | local diagnostics adapter | deletes Account/environment attempts and cascaded diagnostic events | no |

The runner records sanitized lifecycle/diagnostic evidence. It does not own
domain Product/Purchase truth. It is not suitable as the Audit page dependency
because possession of the runner also grants mutation and network capabilities.

### 3.5 Existing local diagnostic truth

The existing v12 database already contains the smallest usable Audit facts:

- SyncAttempts: persisted integer ID, Account, environment, operation, start/end,
  phase/stage, result/outcome/recovery, correlation fingerprint, elapsed band,
  HTTP status and header-presence flag;
- SyncDiagnosticEvents: persisted integer ID, parent attempt ID, version,
  ordinal, code, severity, outcome, phases, sanitized fingerprints, plane
  states, bounded counts, HTTP status, safe action, retryable flag, sanitized
  exception class and recorded time;
- pending/event/device/hosted-binding tables for current support status.

Existing reads are bounded but not paged:

- recent attempts: 20, ordered startedAt descending then ID descending;
- recent diagnostic events: 30, ordered recordedAt descending then ID
  descending;
- actionable events: 20, ordered enqueuedAt descending then sequence and ID;
- devices: Account-scoped and current Device first;
- last successful ordinary Sync: one latest completed result.

New conclusion: a functional read-only local Audit can be produced from current
schema. It requires a bounded application read port because the existing
ClosureDiagnosticsQuery also exposes recovery preflights and clear-history
mutation and does not expose stable persisted row IDs or paging.

### 3.6 Sanitization boundary

The adapter sanitizes codes, fingerprints, identifiers, MKS codes, summaries
and exception classes before persistence. The registry additionally declares
public/log visibility and forbids tokens, passwords, payload JSON, connection
strings, complete hashes, private URLs, stack traces and SQL.

Audit must still enforce an output allowlist. Sanitized persisted operation and
correlation identifiers are not automatically product-safe. Audit may expose:

- registry code/version, safe title/meaning/guidance;
- severity, outcome, operation kind and phase;
- timestamps, bounded duration/elapsed band and counts;
- HTTP status and response-header-presence boolean;
- already-short fingerprints only when their scope is explicit;
- sanitized exception class only in Advanced/Support disclosure.

Audit must exclude:

- access/ID tokens and credentials;
- raw payloads and event JSON;
- complete hashes and request bodies;
- raw Account, Device, submission, operation or correlation IDs;
- provider URLs and connection strings;
- SQL, stack traces and arbitrary exception text;
- unsanitized native responses.

## 4. Component, function and object additions

### 4.1 Proposed Audit application types

| Prospective type | Owner / lifetime | Identity and invariant |
| --- | --- | --- |
| AuditScope | application value object; one load | requires AccountId and environment alias; optional Device filter is explicit |
| AuditAttemptId | persisted local identity | wraps SyncAttempts.id; never list position |
| AuditEventId | persisted local identity | wraps SyncDiagnosticEvents.id; never ordinal alone |
| AuditCursor | immutable paging token | startedAt plus attempt ID; opaque to presentation |
| AuditPageRequest | request value | bounded limit, optional cursor, optional typed filters |
| AuditPage | immutable result | ordered attempt records, next cursor, loadedAt, completeness statement |
| AuditAttemptRecord | read projection | one persisted attempt with zero or more child diagnostic records |
| AuditDiagnosticRecord | read projection | one persisted diagnostic event with registry-safe meaning |
| AuditDeviceAttribution | typed value | current, fingerprinted, unavailable or mixed; never inferred |
| AuditFreshness | typed value | current-at-load, stale-after-local-change or unavailable |
| AuditUnavailableReason | typed outcome | local-read-failed, scope-unavailable or evidence-not-recorded |
| AuditState | controller state | idle, loading, ready, empty, stale or unavailable |
| AuditReadPort | application read interface | exposes only local Account/environment-predicated page reads |
| AuditController | page-session application controller | owns state, cursor, filters, Retry generation and disposal |

The first implementation should page attempts, then load child diagnostic rows
for those attempt IDs in one second local query. That is two bounded local
queries per page, not N+1. Attempts without child events remain visible.

### 4.2 Proposed support capability interfaces

Do not pass NativeAuthClosureRunner to Audit.

Prospective capability-narrow interfaces:

- SupportStatusQuery: present Auth/enrollment/queue/Device status only;
- AccountSessionActions: sign-in and logout;
- DeviceEnrollmentActions: enroll/query;
- ManualSyncAction: explicit user-requested ordinary Sync;
- SupportNetworkCheck: hosted connection check;
- RecoveryInspection: read/record bounded inspection;
- RecoveryMutation: explicit confirmed retry/recovery;
- DiagnosticHistoryMaintenance: destructive history clear.

The existing runner may implement/adapt these initially. Presentation receives
only the interfaces required by its section. This is a capability boundary, not
a new backend engine.

### 4.3 Controller and resource lifetime

Prospective Audit lifecycle:

1. the retained Audit page owns one AuditController;
2. first load is visibility-gated;
3. one load generation token ignores stale completions;
4. Retry repeats only the same local page request;
5. filter, expand/collapse and responsive transitions perform zero rereads;
6. no timer, stream, listener to database, HTTP client or background refresh is
   created;
7. dispose invalidates the generation and disposes any notifier/listener;
8. stale is shown when a known local support mutation occurs; it is not
   silently relabeled current.

Current composition debt is new evidence:

- two http.Client instances are created inside composition and not retained for
  close;
- LocalDatabase is created by main and has no visible app-root disposal path;
- tests close databases explicitly, but production main does not;
- the runner has no close contract.

Prospective PH03 correction: MarkeiComposition owns shared HTTP clients,
database and long-lived application controllers and exposes one idempotent
dispose/close boundary. MarkeiApp or a root host owns invoking it. Audit itself
creates no HTTP resource. Exact asynchronous database-close integration must be
validated without terminating in-flight work.

## 5. Retained conclusions

Retained from permanent Design memory and the preceding C round:

- destination identity is stable and enum-based;
- IndexedStack owns retained page state across responsive layouts;
- compact, medium and wide layouts must project one state;
- presentation components own no repository, Sync or calculation authority;
- Account predicates are mandatory for local data reads;
- local database facts remain authoritative offline;
- hosted coordination and provider systems are not local product truth;
- no schema, migration, dependency or generated-source change is justified
  merely to present existing local evidence;
- human screenshot, assistive-technology, keyboard-only, locale, real-device and
  comprehension acceptance remain absent;
- GCM04 and R07 remain deferred.

## 6. Corrections, supersessions and contradictions

| Claim | Classification | Correction |
| --- | --- | --- |
| Audit is merely a reserved placeholder | corrected | destination is reserved, but current local attempt/event facts can support a functional read-only page |
| ClosureDiagnosticsQuery can be injected directly into Audit | contradicted | it grants preflight and destructive history-clear capability and lacks stable IDs/paging |
| all Closure content belongs in Audit | contradicted | configuration, present status, network actions and recovery controls are not historical read evidence |
| Settings needs replacement | contradicted | its local reference/preference behavior is already functional and must be preserved |
| a new causal ledger is needed | contradicted | current v12 attempts/events are sufficient for the bounded projection |
| Audit can attribute every historical record to one Device | contradicted | attempt rows lack Device ID and many diagnostic fingerprints are null; unavailable must remain explicit |
| existing 20/30 limits are complete paging | contradicted | they are bounded latest windows without continuation |
| clear history can be an Audit action | superseded | Audit remains read-only; destructive maintenance is retired or development support |
| Closure can stay in compact/wide product navigation | superseded | Audit replaces it; support entry is nested and development-gated |
| existing persisted strings are automatically safe for product UI | contradicted | Audit requires registry/allowlist mapping and raw-identifier exclusion |

## 7. Confrontation with latest J section 10

J requires mandatory functional Settings, mandatory functional Audit, Closure
removal from ordinary navigation and explicit capability disposition. The
repository supports that boundary without new schema.

Agreement with J:

- existing Settings behavior is preserved;
- Audit can be local, Account-scoped, read-only and no-network;
- Closure can be removed from navigation independently of destination position;
- support and recovery controls can remain outside ordinary navigation;
- R07, GCM04, hosted Audit and provider observability remain inactive.

Qualification added by this round:

- existing historical attempt rows are Account/environment-scoped but not
  reliably Device-attributed;
- existing latest-window queries are not a paging contract;
- current composition lacks a complete production disposal boundary;
- recovery inspection writes diagnostic evidence even though it performs no
  provider mutation;
- a narrow Audit port is required; reusing the broad Closure query would violate
  least capability.

No contradiction with J requires stopping the investigation.

## 8. Confrontation with paired F_DSN_STAGE

The F tail is historical provisional cache for PH01/PH02 only. Retained rules
that remain useful are dependency-clean widgets, one page state across layouts,
no schema/generated/dependency expansion and exact test evidence.

Superseded for PH03:

- F's explicit exclusion of Settings/Audit/Closure work was consumed by the
  completed PH01/PH02 materialization and current J section 10;
- F does not authorize PH03 source changes;
- its Analytics query/controller types are examples, not Audit authority.

Corrected boundary: the generated Sync diagnostic registry may be reused
read-only, but no registry source, generator or generated projection change is
needed for PH03.

## 9. Cross-domain consequences

Operational consequences:

- Audit ordinary load must prove zero network calls and bounded local queries;
- support actions require separate network/mutation tests and confirmations;
- composition disposal needs process/resource lifecycle evidence;
- current data volumes must be measured before claiming paging performance;
- no live provider check is part of PH03 acceptance.

Didactic consequences:

- Audit means recorded local historical evidence, not cause proof;
- Settings means configuration and present status, not history;
- Advanced/Support actions must state side effects before confirmation;
- unavailable Device attribution and stale data need explicit language;
- safe registry meanings must not imply a provider cause beyond evidence.

Main consequences:

- Main must choose the product visibility of manual Sync, recovery and history
  deletion;
- Main must decide whether Auth sign-in/logout is ordinary Settings or Advanced;
- Main must accept that Audit is local-device evidence, not hosted cross-device
  Account history.

## 10. Prospective additions

### 10.1 Final provisional responsibility/dependency map

~~~text
MarkeiShell / MarkeiDestinationId
  -> SettingsPage
       -> existing LocalReferenceRepository / AccountPreferenceRepository
       -> optional capability-narrow AdvancedSupportController
  -> AuditPage
       -> page-owned AuditController
       -> AuditReadPort
       -> DriftClosureDiagnosticsRepository as the single existing local truth adapter
       -> SyncAttempts + SyncDiagnosticEvents

AdvancedSupportController
  -> capability-narrow adapters over NativeAuthClosureRunner
  -> existing Auth / enrollment / Sync / recovery coordinators

Diagnostic safe meaning
  -> existing generated Sync diagnostic registry
  -> no generator or registry mutation
~~~

Dependency rules:

1. Audit presentation imports only Audit application projections/controller and
   shared presentation primitives.
2. AuditController imports AuditReadPort and local-safe registry lookup, never
   HTTP/Auth/Sync coordinators.
3. DriftClosureDiagnosticsRepository remains the single local evidence mapper;
   it gains a narrow Audit interface rather than a duplicate repository.
4. Settings retains its existing local reference/preference ports.
5. Advanced/Support receives explicit action capabilities, not the entire
   composition.
6. ordinary Audit load cannot acquire an HTTP client or access token.
7. Closure destination and page map entry are removed from ordinary navigation.
8. any retained development support entry is nested under Settings and gated by
   the existing compile-time/configuration condition.

### 10.2 Complete capability-disposition matrix

| Existing Closure capability | Current presentation owner | Authority / source of truth | Effects and scope | Proposed destination | Dependency/schema consequence | Validation and reversibility |
| --- | --- | --- | --- | --- | --- | --- |
| Closure navigation label/destination | MarkeiApp | presentation flag | none; environment/config gated | retired | remove destination/page entry; no schema | shell tests; one-commit reversible |
| Audit reserved placeholder | MarkeiApp | presentation only | none | Audit | replace with functional page | destination identity retained |
| build provenance | NativeClosurePage | compile-time BuildProvenance | read-only; app build scope | Settings → Advanced/Support | no new dependency/schema | redaction tests; reversible projection |
| Auth status | page/runner | ExternalAuthenticationSession | local/session read; no raw token | Settings present status | capability-narrow status port | fake-session tests |
| Sign in | page/runner | Auth adapter/provider | session mutation and provider network | Settings Account section | reuse existing adapter; no schema | cancellation/rejection tests; reversible placement |
| Logout | page/runner | Auth adapter | clears session state | Settings Account section | reuse existing adapter | logout mapping tests |
| enrollment status | overview/repository | HostedAuthStates | local current environment/binding status | Settings → Advanced/Support | existing table | Account/environment predicate tests |
| Enroll | page/runner | enrollment coordinator | provider request plus local binding mutation | Settings → Advanced/Support | existing dependencies/schema | confirmation and mocked network tests |
| Query enrollment | runner, not separate current button | enrollment coordinator | provider request and possible local update | development-only support | no ordinary-nav exposure | mock replay tests; removable |
| hosted connection check | page/runner | HostedConnectionCheckPort | network plus diagnostic attempt write | development-only support | existing HTTP/attempt table | exactly one request/attempt; removable |
| ordinary manual Sync | page/runner | HostedSyncCoordinator | upload/download/apply/ack and local writes | Settings → Advanced/Support | existing Sync only; no new schema | existing coordinator tests plus UI confirmation |
| Diagnostics button | page | runner status + local snapshot | read-only local/session | split: Audit Retry plus Settings status refresh | narrow read/status ports | zero-network assertion |
| Sync overview | NativeClosurePage | snapshot derived from Auth/binding/queue/attempts | read-only current status | Settings present status | reuse support snapshot mapping | empty/unavailable/stale tests |
| local queue counts | NativeClosurePage | PendingEvents + SyncEvents | Account read; current Device counts where required | Settings → Advanced/Support | existing tables | Account/Device scope tests |
| recent attempts | NativeClosurePage | SyncAttempts | Account/environment read | Audit | paged stable attempt records | order/cursor tests; no schema |
| diagnostic timeline | NativeClosurePage | SyncDiagnosticEvents + registry | Account/environment read; sanitized | Audit | existing generated registry read-only | allowlist/redaction/version tests |
| Device summaries | NativeClosurePage | Devices + HostedAuthStates | Account read; fingerprinted | Settings → Advanced/Support | existing tables | current/unavailable attribution tests |
| actionable pending/failed/unknown events | NativeClosurePage | PendingEvents + SyncEvents | Account read, current operational state | Settings → Advanced/Support | existing tables | stable fingerprint/order/bound tests |
| current action diagnostic | NativeClosurePage | transient page state + latest event | session-only support result | Settings → Advanced/Support | no persistence change | action-result state tests |
| unknown-outcome preflight | page/runner/repository | submissions/events/queue/device | local read only | Settings → Advanced/Support | narrow inspection capability | malformed/foreign-scope tests |
| retry unknown outcome | page/runner | preflight + ordinary Sync | same-identity network retry and local Sync mutation | unresolved: Advanced/Support or development-only | no schema; existing Sync dependency | explicit confirmation, one-attempt and stop tests |
| failed/notApplied inspection | page/runner/repository | submissions/events/queue/device | local read plus diagnostic attempt/event write | development-only support | existing tables | prove no provider call and bounded write |
| failed/notApplied recovery | page/runner/coordinator | confirmed inspection + recovery coordinator | local batch mutation, at most one provider upload, result persistence | development-only support | existing recovery path only | session lock, exact stop boundary, no automatic retry |
| clear diagnostic history | page/repository | SyncAttempts cascade to events | destructive Account/environment local delete | unresolved: retired or development-only maintenance | no schema; never Audit | confirmation, scope/cascade tests; restore only from backup unavailable |
| recovery guidance strings | overview/registry/runner | derived local state and registry | read-only safe guidance | Settings → Advanced/Support | reuse safe mapping | vocabulary and redaction tests |
| raw diagnostic identifiers/payloads | not intentionally shown | local/hosted internals | sensitive | retired from product presentation | explicit exclusion | negative tests |

Account, Device and environment rules for every row:

- Account predicate is mandatory;
- environment predicate is mandatory for attempts/diagnostics/binding;
- Device predicate is mandatory for Device-specific queue/recovery operations;
- Audit never infers Device identity when the persisted record lacks it;
- ordinary product UI receives only fingerprints and typed unavailable values.

### 10.3 Audit read behavior

Ordering:

- attempts: startedAt descending, persisted attempt ID descending;
- child events: recordedAt ascending then event ID ascending within an attempt;
- page cursor: exclusive pair of startedAt and attempt ID;
- no ordering by display index or registry title.

Paging:

- proposed default 20 attempts, maximum 50;
- fetch limit plus one to determine next cursor;
- one attempt query and one child-event query per page;
- Retry reloads the first page or the currently documented cursor policy;
- no unbounded all-history load.

Deduplication:

- attempt identity is SyncAttempts.id;
- event identity is SyncDiagnosticEvents.id;
- diagnostic ordinal is display order only;
- the same event is never copied into independent summary and timeline truth;
- current status cards may reference the latest attempt ID but do not duplicate
  it as a new Audit record.

States:

| State | Meaning |
| --- | --- |
| idle | Audit has not been made visible |
| loading | one local page read is active |
| ready | ordered local records loaded at a named time |
| empty | no matching local records; not an error |
| stale | prior records remain visible after a known local support mutation |
| unavailable | local scope/read failed; sanitized reason only |

Ordinary behavior is local and no-network. Retry is explicit and local. There is
no automatic refresh, background poll, stream, timer or provider check.

### 10.4 Smallest materialization slices and rollback boundaries

Slice 1 — read model and local port:

- likely paths: application/audit.dart and the existing
  infrastructure/local/closure_diagnostics_repository.dart;
- add stable IDs, page/cursor/state types and AuditReadPort;
- implement Account/environment-predicated two-query page read;
- reuse existing registry output read-only;
- rollback: remove additive port/types/methods; no data migration.

Slice 2 — functional Audit presentation:

- likely paths: app/pages/audit_page.dart, optional
  app/widgets/audit_components.dart, markei_app.dart and composition;
- replace reserved Audit page;
- one page-owned controller, visibility-gated local load, Retry, states and
  responsive projections;
- rollback: restore reserved page; stored facts remain untouched.

Slice 3 — navigation and support relocation:

- remove Closure destination from ordinary destinations/page map;
- preserve current Settings repositories and behaviors;
- expose chosen Account/status/actions through a nested Advanced/Support
  disclosure or route;
- keep development-only controls behind the existing compile-time/configuration
  gate;
- rollback: restore conditional destination and old page entry.

Slice 4 — capability cleanup and lifecycle:

- split broad interfaces by read/status/action authority;
- retire or development-gate clear/recovery controls per Main decision;
- retain/close composition-owned HTTP clients and database/controller
  resources;
- rollback: adapters can continue delegating to NativeAuthClosureRunner; no
  schema rollback.

Each slice is independently reviewable. No slice authorizes live provider
validation.

## 11. Risks, non-goals and deferred work

Risks:

- mixed current/historical semantics may reappear if one snapshot is rendered
  in both Settings and Audit without typed projection boundaries;
- attempt rows do not prove Device attribution;
- diagnostic registry safe guidance can still be misread as proven cause;
- current tables have no explicit indexes dedicated to Audit paging; PH03 must
  measure before claiming performance, but may not add schema/index work;
- development actions can become ordinary product behavior if gating is tied
  only to configuration readiness;
- asynchronous composition resources currently lack one visible close owner;
- destructive history clear removes evidence and cannot be reversed from the
  app without a separately authorized backup feature.

Explicit non-goals retained:

- new diagnostic or causal ledger;
- durable causal lifecycle;
- new Sync instrumentation;
- automatic Retry or Recovery;
- hosted cross-device Audit;
- provider observability;
- multiple-Account or multiple-user work;
- Device revocation;
- retention/rebootstrap;
- GCM04;
- R07 implementation;
- live provider validation;
- History-side operational Audit;
- Analytics calculation changes;
- schema, migration, dependency or generated-source change.

Deferred:

- full Account-timezone semantics;
- hosted aggregation of Audit evidence;
- searchable/exportable Audit;
- retention policy and restore;
- provider-native observability;
- causal correlation beyond already recorded bounded fingerprints;
- production lifecycle acceptance.

## 12. Human decisions

Main/human must decide:

1. whether manual ordinary Sync is visible in Settings Advanced/Support or only
   development support;
2. whether unknown-outcome retry is product Advanced/Support or development
   only;
3. whether clear diagnostic history is retired entirely or retained only for
   development maintenance;
4. whether Sign in/Logout is an ordinary Settings Account section or behind
   Advanced disclosure;
5. whether failed/notApplied inspection and recovery remain available after
   Cycle 10 evidence work; Design recommends development-only;
6. whether the local-device-only Audit label is acceptable without hosted
   cross-device history;
7. whether composition disposal is included in PH03 Slice 4 or separately
   authorized as a bounded lifecycle correction.

Main cannot infer these choices from repository structure or green tests.

## 13. Recommendation to Main

Accept the smallest coherent PH03 architecture provisionally:

- preserve Settings local reference/preference ownership unchanged;
- make Audit a local, Account/environment-predicated, read-only paged projection
  of existing SyncAttempts and SyncDiagnosticEvents;
- require a new capability-narrow AuditReadPort rather than injecting
  ClosureDiagnosticsQuery or NativeAuthClosureRunner;
- use persisted attempt/event IDs and explicit unavailable Device attribution;
- reuse the generated diagnostic registry read-only through an output allowlist;
- remove Closure from ordinary navigation;
- move chosen identity/status/support actions under Settings Advanced/Support;
- keep recovery/network probes development-gated unless Main explicitly accepts
  product visibility;
- make Audit Retry local-only and manual;
- add one composition disposal owner without changing providers or dependencies.

Schema/dependency/provider conclusion:

~~~text
SCHEMA_CHANGE=NO
MIGRATION_CHANGE=NO
DEPENDENCY_CHANGE=NO
GENERATED_SOURCE_CHANGE=NO
API_CHANGE=NO
AUTH_CONTRACT_CHANGE=NO
SYNC_CONTRACT_CHANGE=NO
PROVIDER_CHANGE=NO
ORDINARY_AUDIT_NETWORK=NO
R07_ACTIVATED=NO
~~~

A functional bounded Audit is feasible within that conclusion. Any demand for
hosted cross-device history, complete Device attribution, durable causal
correlation, retention/restore, provider observability or new indexes is a
separate Main/human expansion and must not be normalized into PH03.

## 14. Next route

### Proposed Design F gates

1. exactly bounded PH03 paths; no schema/migration/dependency/generated change;
2. Audit page receives AuditReadPort only and has no runner/HTTP/Auth/Sync
   coordinator import;
3. every read proves Account and environment predicates;
4. attempt/event identities use persisted IDs, never positions;
5. attempt ordering and exclusive cursor paging are deterministic;
6. one attempt query plus one child query per page; no N+1;
7. empty, loading, unavailable and stale are separately tested;
8. first load is visibility-gated; Retry is local-only; layout/filter transitions
   reread zero times;
9. no timer, stream, listener leak or background network behavior;
10. tokens, payloads, complete hashes, raw IDs, URLs, SQL, stack traces and raw
    exceptions are absent from presentation;
11. registry code/version and safe mapping are tested without regenerating it;
12. unknown Device attribution renders unavailable, never current by inference;
13. existing Settings save/archive/threshold tests remain passing and behavior
    unchanged;
14. Closure is absent from both wide and compact ordinary navigation;
15. development support is reachable only through the approved nested,
    explicitly gated entry;
16. every support action declares network/write effects and requires the
    approved confirmation;
17. Audit remains read-only; clear/recovery controls are absent;
18. composition clients/database/controllers have one owner and idempotent
    disposal evidence;
19. focused Audit/Settings/navigation tests, full Flutter tests, analysis and
    Windows/Android builds are recorded;
20. screenshot, keyboard, assistive-technology, locale, real-device and human
    comprehension limits remain explicit.

### Evidence still required

- exact A and B PH03 findings and disagreements;
- measured query count and timing on ordinary/stress local histories;
- proof of cursor behavior with equal timestamps;
- actual null/non-null Device fingerprint distribution;
- Settings interaction/error behavior after support relocation;
- composition close behavior on Windows and Android lifecycle;
- rendered wide/compact Audit and Settings review;
- accessibility and human comprehension evidence;
- Main decisions in section 12.

### Performance improvement achieved by the investigation

No runtime performance claim is made. Investigation performance improved by
reducing one mixed 1,329-line page plus 1,487-line runner into four explicit
semantic surfaces: Audit read model, Settings configuration, present status and
support/recovery actions. It also bounded the proposed Audit load to two local
queries per page, eliminated N+1 as an accepted design, and reduced the
unresolved placement set to seven named Main/human choices.

### Exit gate for Main reconciliation

Exit this investigative round when A, B and C are published, the seven Main
choices are resolved or explicitly deferred, and Main can stage a schema-free
D/E/F packet whose Audit path has no mutation/network authority. If Main chooses
hosted Audit, new Device attribution, causal persistence, indexes or provider
observability, stop and create a separate decision unit.

### Sequence Handoff Envelope

~~~text
SEQUENCE=FLX-INV-02
ROUND=C11-PH03-R01
ROLE=DESIGN
INSPECTED_REMOTE_HEAD=e8723bec10836e37bc1a7cf22fcb6de21dd03cf4
RETAINED=stable-destinations;IndexedStack-state;Account-predicates;local-offline-authority;Settings-repositories
NEW=mixed-Closure-inventory;bounded-Audit-port;paged-attempt-event-projection;composition-disposal-debt
CORRECTED=Settings-already-functional;Audit-feasible-with-current-schema;Device-attribution-partial
SUPERSEDED=Closure-ordinary-navigation;clear-history-in-Audit;broad-query-injection
CONTRADICTED=new-causal-ledger-required;all-Closure-content-is-Audit;existing-limits-are-paging
UNRESOLVED=manual-Sync;unknown-retry;history-clear;Auth-placement;failed-recovery;local-only-label;disposal-slice
PROSPECTIVE=AuditReadPort;AuditController;functional-Audit-page;Settings-Advanced-Support;composition-close
DEFERRED=R07;GCM04;hosted-Audit;provider-observability;retention-rebootstrap;multiple-Account
SCHEMA_MIGRATION_DEPENDENCY_GENERATED_PROVIDER_CHANGE=NONE
D_E_F_AUTHORITY=INACTIVE
CODEX_AUTHORITY=INACTIVE
NEXT_MAIN_ACTION=Reconcile PH03 A/B/C capability placements and resolve the seven named choices before any D/E/F.
~~~

Explicit confirmation: D/E/F and Codex remain inactive.
