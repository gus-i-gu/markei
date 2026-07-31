# F_DSN_STAGE — C11-PH01-S02-R01 Layout Architecture Recovery

> Sequence: FLX-ORD-01
> Role: Main design materialization stage
> Cycle / phase / unit: C11 / C11-PH01 / C11-PH01-S02-R01
> Required branch: `grm-guarded-provisioning-20260727`
> Required remote parent: `f6566a407c2215c1ade61444a7f97994994d93f8`
> Codex starting HEAD: the synchronized D/E/F publication commit pinned by the
> initiation prompt
> Authority: **ACTIVE — CORRECTIVE IMPLEMENTATION AUTHORIZED**

## 1. Architecture decision

The preliminary S02 visual architecture is accepted. Recovery changes refine
constraint ownership; they do not replace the token, shell, component or page
system.

## 2. Constraint ownership

- `MarkeiShell` owns navigation and the bounded content canvas.
- Each long-form page owns exactly one primary vertical scroll surface.
- Page sections use natural height; no section may depend on a fixed viewport
  height to expose required controls.
- Shared field/group primitives own consistent gaps between floating labels,
  outlines, values, helper text and adjacent fields.
- Responsive layout changes projection only; it does not create separate
  business or draft state.
- Tables and compact cards consume the same page-owned records and identifiers.
- Shared widgets remain presentation-only and import no repository or
  infrastructure layer.

## 3. Page decisions

### Purchase

Keep one draft controller/state across all layout classes. At wide width, Product
and Quantity/price may remain adjacent; at narrower width or larger text scale,
sections wrap vertically. The page scroll surface must expose review/actions
without nested-scroll traps or clipped controls.

### Catalogue

Keep one page state for search, sort, product creation, similarity resolution
and Stores. Product registration fields may wrap, but field groups must retain
clear vertical separation. Register Product and Stores remain within the same
reachable page scroll surface.

### History

Selection has one source of truth and one visible row control. The header
select-all control updates the same set. Wide columns should consume the
available table surface without inventing values or changing filter/export
ports.

### Home and Lists

Treat their captured wide layouts as accepted regression anchors. Shared fixes
must not alter their information hierarchy, request count, state retention or
estimate semantics.

## 4. Forbidden architecture changes

- repository, domain, database, API, Sync, Auth or provider changes;
- new navigation/state-management framework;
- new dependency, asset or font pipeline;
- duplicate page state for layout classes;
- a repository call from a shared visual component;
- nested scroll surfaces that make final actions unreachable;
- activation or redesign of Analytics, Settings, Audit or Closure.

## 5. Architecture evidence

Tests and `I_DSN_CODEX.md` must establish:

- a single page state survives layout changes;
- one vertical-scroll owner per long-form page;
- final Purchase/Catalogue controls are reachable;
- History selection uses one page-owned set and one row affordance;
- shared components remain dependency-clean;
- repository-call parity is unchanged;
- Home/Lists regression anchors remain intact;
- changed paths stay within D authority.

## 6. Required I report

Replace `I_DSN_CODEX.md` with combined S02-R01 evidence containing:

1. final dependency direction;
2. constraint/scroll ownership;
3. field-group primitive changes;
4. Purchase, Catalogue and History architecture summaries;
5. responsive state-parity evidence;
6. repository-call parity;
7. changed-path inventory;
8. deferred PH02/PH03 boundaries;
9. residual design debt.

Required terminal:

```text
CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S02-R01
PRESENTATION_ARCHITECTURE=PASS | PARTIAL | FAIL | BLOCKED
SINGLE_SCROLL_OWNER=PASS | FAIL | BLOCKED
FIELD_GROUP_CONSTRAINTS=PASS | FAIL | BLOCKED
RESPONSIVE_STATE_PARITY=PASS | FAIL | BLOCKED
HISTORY_SELECTION_SOURCE=PASS | FAIL | BLOCKED
SHARED_COMPONENT_BOUNDARY=PASS | FAIL | BLOCKED
REPOSITORY_INTERFACES_CHANGED=NO | YES
DOMAIN_OR_INFRASTRUCTURE_CHANGED=NO | YES
NEW_DEPENDENCY_OR_ASSET_PIPELINE=NO | YES
PH02_PH03_BOUNDARY=PRESERVED | CONTRADICTED
NEXT_DESIGN_REVIEW=<one exact action>
```

---

<!-- ACTIVATION_MARKER:C11-PH01-S02-R01-C11-PH02-COMBINED-2026-07-31 -->

# Combined activation — PH01 layout recovery and PH02 Analytics architecture

> Status: **ACTIVE — CONTROLLING DESIGN MATERIALIZATION AUTHORITY**
> Pairing: the D and E append carrying the same activation marker

## 7. Precedence and phase boundary

The existing PH01-R01 constraint ownership remains active: one scroll owner per
long page, one page state across layouts, one History selection source, and
repository-free shared presentation components.

The former PH02 exclusion is superseded only for the architecture below. The
preliminary five-page implementation at
`2e59f35dd7b45902f707fcf33c73024e868787de` is the remote baseline; Codex must
correct it rather than reconstruct it from an old worktree.

No PH01 redesign, PH03 structure, schema, migration, dependency, generated
source, Sync/provider topology or persistence of Analytics cards is
authorized.

## 8. Controlling responsibility map

```text
AnalyticsPage / Analytics presentation components
  -> AnalyticsWorkspaceController
  -> operation-specific registry definitions and executors
  -> AnalyticsEvidenceRepository port
  -> LocalAnalyticsRepository
  -> Account-scoped Drift Purchase/Product facts
```

Ownership:

- `AnalyticsPage` renders typed state and dispatches callbacks;
- `AnalyticsWorkspaceController` owns the session dataset, conditions,
  selection, focus, ordered cards, revisions, results, launch context and async
  generation;
- domain Analytics models own closed determinants, variables, operations,
  compatibility keys, evidence/result identities and typed unavailable states;
- the registry owns stable operation identifier/version, validation, execution
  and interpretation inputs;
- the application port owns the complete Account-scoped evidence load;
- the local adapter owns one joined Drift query and row mapping;
- `MarkeiComposition` supplies the local adapter, registry and active Account;
- `MarkeiApp` owns History-to-Analytics navigation/context transfer;
- History owns selected Purchase IDs only and imports no executor;
- shared widgets own no query, calculation or state truth.

## 9. Required types and identities

Implement explicit equivalents of:

```text
AnalyticsEvidenceRowId = persisted PurchaseItemId
AnalyticsEvidenceRow
AnalyticsDataset
AnalyticsDeterminant = Product | Purchase | Store | Time(day|month UTC)
AnalyticsVariable = Quantity | UnitPrice | LineTotal | PurchaseTotal | EvidenceCount
AnalyticsOperation = Sum | Mean | Difference | Percentage
AnalyticsCondition
AnalyticsEvidenceScope = filtered | selected | comparison operand
AnalyticsCompatibilityKey
AnalyticsCardId
AnalyticsCardRevision
AnalyticsCardConfiguration
AnalyticsResultValue
AnalyticsResultEnvelope
AnalyticsUnavailableReason
AnalyticsLaunchContext.purchaseSelection(AccountId, Set<PurchaseId>)
```

Invariants:

- evidence identity is never list position;
- all evidence rows retain `AccountId`, `PurchaseId` and Purchase Item ID;
- Product/Store/reference IDs remain available with display labels;
- Purchase total deduplicates by Purchase ID;
- card ID survives edit/reorder; edit increments revision;
- card removal removes only session state;
- every result stores registry ID/version, configuration snapshot, exact
  contributing row IDs, eligible/total/excluded counts and period;
- unavailable facts/results are typed, not magic strings or numeric sentinels.

## 10. Evidence adapter and query boundary

`AnalyticsEvidenceRepository` requires `AccountId` for every load. The local
adapter performs one joined read across Purchases, Purchase Items, Products,
Stores, People and Payment Methods with:

- Purchase Account predicate applied in the query;
- stable order by occurrence time, Purchase ID and Purchase Item ID;
- nullable reference joins;
- complete evidence without History’s 50-row limit;
- one mapped row per Purchase Item;
- normalized fixed quantity through existing quantity types;
- typed Unit-price derivation from positive quantity;
- explicit unavailable Purchased-for/Promotion values.

The adapter may read generated Drift accessors but must not modify handwritten
schema or generated source. No application grouping or registry executor may
call the repository per row, Purchase, card or result.

Tests assert one repository request on load/Retry and zero requests for
filtering, selection, card execution, focus, reset and reordering.

The first PH02 baseline loads the complete dataset once into session state.
The presentation renders stable pages of 100 rows, so widget count is bounded
without weakening complete calculation/evidence authority. Selected scope is
capped at 500 row IDs; filtered scope remains the route for larger analyses.

## 11. Operation architecture

Use operation-specific configuration/result types behind a common registry
envelope. Stable definitions:

```text
local.sum@1
local.mean@1
local.difference@1
local.percentage@1
```

The registry replaces the zero-input placeholder contract. Unknown
identifier/version returns a typed blocked outcome.

Compatibility:

| Variable | Sum | Mean | Difference | Percentage |
| --- | --- | --- | --- | --- |
| Quantity | yes | yes | yes | yes |
| Unit price | no | yes | yes | no |
| Line total | yes | yes | yes | yes |
| Purchase total | yes | yes | yes | yes |
| Evidence count | yes | no | yes | yes |

Calculations use checked integer/rational arithmetic. Compatibility keys are:

- money: currency;
- quantity: MeasurementKind + canonical unit;
- Unit price: currency + MeasurementKind + canonical unit;
- Purchase total: currency + distinct Purchase identity;
- Evidence count: Item row.

Sum/Mean may return independent values per compatibility key. Multi-variable
cards return independent result entries, never tuples/composite scores.

Mean records numerator and contributing unit. Difference contains explicit
`baseline` and `comparison` operands and calculates comparison minus baseline.
Percentage contains a numerator scope and containing denominator scope, uses
the same aggregation/key, and returns basis points plus both inputs. Zero
denominator, incompatibility, missing values and overflow are typed outcomes.
Percentage change is not implemented.

Conditions use authoritative fields only. UTC periods use inclusive start and
exclusive end. Time determinants support UTC day and month. Device-local,
Account-timezone, week/year grouping and DST policy are deferred.

## 12. Workspace state and transitions

One `AnalyticsWorkspaceController` instance is retained in the existing
`IndexedStack` and drives every layout.

Required transitions:

1. load complete Account dataset;
2. apply matrix conditions without mutating raw rows;
3. select stable row IDs, enforcing the 500-ID cap;
4. row selection starts a provisional card without guessing operation;
5. complete/edit card validates and executes synchronously over local state;
6. card focus limits the visible projection to its result row IDs;
7. show-all clears focus only;
8. reset clears conditions, selection, focus and page cursor but retains cards;
9. reorder changes card order only;
10. remove deletes one card/result only;
11. Retry reloads the same local Account dataset, preserves card
    configurations, and uses a generation token to ignore stale completions.

Cards are session-local. No serialization, schema, cross-session restore, Sync
or registry migration is permitted.

## 13. History handoff

Use only:

```text
AnalyticsLaunchContext.purchaseSelection(
  accountId,
  selectedPurchaseIds,
)
```

`HistoryPage` exposes a callback enabled only with selected IDs.
`MarkeiApp` selects the Analytics destination and supplies the context.
Analytics verifies the Account, resolves Purchase IDs to its loaded Item rows,
reports unavailable/foreign IDs and establishes selection. It does not
calculate or create a complete card.

History must not import the registry, workspace controller, local adapter or
Analytics presentation. Evidence-row and filter-context handoffs remain
deferred.

## 14. Responsive architecture

Analytics inherits the existing shell, breakpoints, theme, content bounds and
presentation primitives.

Wide:

- ordered cards above a dense matrix;
- bounded horizontal matrix accommodation;
- stable page controls and row identity.

Medium/compact:

- same cards, configuration, results and evidence state;
- progressive editor disclosure;
- expandable evidence-row cards exposing all twelve fields.

Layout may change projection only. It may not create another controller,
dataset, card set, result, query path or interpretation. Breakpoint changes
must not reload or reset.

Analytics-specific widgets remain in `analytics_components.dart` and accept
typed values/callbacks only. Do not move query/calculation responsibility into
`markei_components.dart`.

## 15. Authorized architecture surfaces

Use only the paths listed in the paired D §19. The preferred mapping is:

| Path | Responsibility |
| --- | --- |
| `domain/analytics/analytics_models.dart` | identities, closed types, configurations and outcomes |
| `domain/analytics/analytics_registry.dart` | definitions, versions, validation and executors |
| `application/analytics.dart` | evidence port and launch context |
| `application/analytics_workspace.dart` | session controller/state/transitions |
| `infrastructure/local/local_analytics_repository.dart` | one joined local adapter |
| `app/pages/analytics_page.dart` | page composition |
| `app/widgets/analytics_components.dart` | presentation-only cards/editor/matrix projections |
| `app/markei_composition.dart` | dependency composition |
| `app/markei_app.dart` | destination and context transfer |
| `app/pages/history_page.dart` | selected-Purchase callback only |

No local_database.dart/g.dart edit is required or authorized.

## 16. Architecture tests and stop conditions

Focused evidence must establish:

- Account predicate and foreign-ID exclusion;
- one joined load and no N+1;
- stable Item identity/order and Purchase-total deduplication;
- all twelve field outcomes;
- compatibility-key partitioning;
- every enabled and disabled operation pair;
- Mean contribution unit;
- Difference B − A;
- Percentage part/whole containment and zero denominator;
- checked overflow behavior;
- independent multi-variable results and exact evidence-row trace;
- UTC half-open day/month boundaries;
- card add/edit/reorder/remove/focus/reset and revision behavior;
- session-only lifetime;
- stale async suppression and local-only Retry;
- History dependency direction and selected-ID context;
- compact/medium/wide controller/state parity;
- dependency-clean widgets and absence of remote/Sync/diagnostic imports.

Stop rather than expanding scope if implementation needs a schema/index,
dependency, generated-file edit, remote read, persisted card model, History
filter model or a second state/query path.

## 17. Required combined I report

Replace I with one combined report containing:

1. PH01 final scroll/constraint/selection ownership;
2. exact changed paths and dependency direction;
3. final Analytics types and owners;
4. registry identifiers, versions and operation semantics;
5. query shape, Account predicate and request count;
6. stable row identity and Purchase deduplication;
7. compatibility, fixed-point and typed failure evidence;
8. controller state/lifetime and transition evidence;
9. History handoff dependency check;
10. wide/compact shared-state evidence;
11. confirmation of no schema/dependency/generated/provider/Sync change;
12. residual performance, rendering and human-acceptance limits.

Required terminal:

```text
CYCLE=C11
ROUND=C11-PH01-S02-R01+C11-PH02
PH01_PRESENTATION_ARCHITECTURE=PASS | PARTIAL | FAIL | BLOCKED
PH01_SINGLE_SCROLL_OWNER=PASS | FAIL | BLOCKED
PH01_HISTORY_SELECTION_SOURCE=PASS | FAIL | BLOCKED
ANALYTICS_DEPENDENCY_DIRECTION=PASS | FAIL | BLOCKED
ACCOUNT_SCOPED_JOIN=PASS | FAIL | BLOCKED
EVIDENCE_ROW_IDENTITY=PASS | FAIL | BLOCKED
PURCHASE_TOTAL_DEDUPLICATION=PASS | FAIL | BLOCKED
REGISTRY_VERSIONING=PASS | FAIL | BLOCKED
OPERATION_SPECIFIC_TYPES=PASS | FAIL | BLOCKED
CHECKED_FIXED_POINT_ARITHMETIC=PASS | FAIL | BLOCKED
SESSION_LOCAL_CARD_STATE=PASS | FAIL | BLOCKED
HISTORY_PURCHASE_ID_HANDOFF=PASS | FAIL | BLOCKED
RESPONSIVE_SHARED_STATE=PASS | FAIL | BLOCKED
WIDGETS_REPOSITORY_AND_CALCULATION_FREE=PASS | FAIL | BLOCKED
REPOSITORY_REQUEST_COUNT=<exact count>
SCHEMA_MIGRATION=NONE | CONTRADICTED
GENERATED_SOURCE_CHANGED=NO | YES
DEPENDENCY_CHANGED=NO | YES
REMOTE_SYNC_DIAGNOSTIC_IMPORTS=ABSENT | CONTRADICTED
NEXT_DESIGN_REVIEW=<one exact action>
```
