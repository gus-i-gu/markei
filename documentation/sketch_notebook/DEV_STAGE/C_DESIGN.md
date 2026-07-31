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
