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
<!-- ACTIVATION_MARKER:C11-PH03-R01-2026-07-31 -->

# C11-PH03-R01 — Final Design Materialization Authority

> Status: ACTIVE — CONTROLLING C11-PH03 ARCHITECTURE AUTHORITY
> Pairing: the D and E append carrying this exact activation marker
> Reversibility: high; no persistence migration or provider contract change

## 18. Controlling responsibility map

~~~text
MarkeiShell / MarkeiDestinationId
  -> SettingsPage
       -> existing local reference and preference ports
       -> capability-narrow AccountStatusPort
       -> capability-narrow SyncDeviceSupportPort
  -> AuditPage
       -> page-owned AuditController
       -> AuditReadPort
       -> DriftClosureDiagnosticsRepository
       -> SyncAttempts + SyncDiagnosticEvents
       -> generated diagnostic registry (read-only safe mapping)

Development support harness
  -> capability-narrow adapters over NativeAuthClosureRunner
  -> existing Auth / enrollment / Sync / recovery coordinators
  -> no ordinary destination
~~~

Rules:

- Audit presentation imports application Audit projections and presentation
  primitives only.
- AuditController imports AuditReadPort and safe registry meaning only. It
  cannot import HTTP, Auth mutation, enrollment, Sync or recovery coordinators.
- DriftClosureDiagnosticsRepository remains the single local evidence adapter;
  do not create a second truth reconstruction.
- Settings preserves existing reference/preference ownership.
- Settings receives capability-narrow Account/status/action interfaces, never
  the complete NativeAuthClosureRunner.
- Advanced support receives only explicitly authorized existing action
  capabilities.
- composition owns injected clients, database, controllers and idempotent close.
- Closure destination identity/page mapping is removed from ordinary app
  navigation. Existing runner/page code may remain only behind non-navigation
  development/test infrastructure.

## 19. Audit application contract

Implement explicit equivalents of:

~~~text
AuditAttemptId = persisted SyncAttempts identity
AuditEventId = persisted SyncDiagnosticEvents identity
AuditCursor(startedAtUtc, attemptId)
AuditPageRequest(accountId, environmentAlias, cursor?, limit)
AuditEventProjection
AuditAttemptProjection
AuditPageResult(records, nextCursor, loadedAtUtc, isPartialWindow)
AuditUnavailableReason
AuditReadPort.loadPage(request)
AuditWorkspaceState = idle | loading | ready | empty | stale | unavailable
AuditController
~~~

Invariants:

- default limit 20; reject or clamp above 50 at the application boundary;
- identity never uses row/list position;
- Account and environment are mandatory request values;
- Device attribution is typed optional/unavailable and never inferred;
- records expose sanitized allowlisted values only;
- raw payloads, secrets and raw identifiers never cross the port;
- page result records the local load time and partial-window state;
- controller retains one state across responsive layouts;
- Retry repeats only the local page request;
- stale generations cannot replace newer state;
- no background refresh, timer, stream or provider query.

## 20. Local query boundary

Implement one attempt query plus one child-event query per page:

1. fetch limit + 1 attempts for the requested Account/environment, ordered by
   startedAt DESC then attempt ID DESC and bounded by an exclusive composite
   cursor;
2. fetch diagnostic events for the retained attempt IDs, ordered by attempt
   membership then recordedAt ASC then event ID ASC;
3. group in the adapter without extra repository calls.

Do not load all attempts or issue one event query per attempt. Do not reuse the
seven-query mixed Closure snapshot as Audit’s application contract.

The existing generated diagnostic registry is read-only authority for known
code/version meaning. Map only an allowlist of safe title/meaning/guidance.
Unknown code/version becomes typed unavailable technical detail.

No schema/index/migration is authorized. Measure equal-timestamp cursor
stability, large histories and rendered row bounds. Stop if acceptable behavior
cannot be achieved without persistence changes.

## 21. Settings and support contracts

Keep local Settings repositories and state unchanged except for D-authorized
functional corrections.

Introduce capability-narrow interfaces or adapters for:

- reading current authentication/session status;
- invoking existing Sign in and Sign out;
- reading current local Sync/Device status;
- invoking existing Connect this Device;
- invoking existing ordinary Sync.

Each interface declares whether it can contact the network or write local/hosted
state. Presentation shows confirmation and result according to E.

Do not expose through product Settings:

- hosted connection probe;
- query enrollment;
- unknown-outcome retry;
- failed/notApplied inspection or recovery;
- clear diagnostic history;
- raw lifecycle diagnostics;
- broad NativeAuthClosureRunner access.

Those paths remain development-only/test infrastructure unless removed. Their
underlying behavior must not change.

## 22. Final capability disposition

| Capability family | Final PH03 disposition |
| --- | --- |
| Closure destination/label/page mapping | retired from ordinary product navigation |
| reserved Audit placeholder | replaced by functional Audit |
| recent attempts and diagnostic event phases | Audit, read-only paged local history |
| Audit paging/reload/detail expansion | Audit; local reads only |
| People, Payment Methods, shortage threshold | Settings Preferences; preserved and hardened |
| authentication status, Sign in, Sign out | Settings Account |
| local Sync/Device status, last local success | Settings Sync and Device |
| Connect this Device, ordinary Sync now | explicit Settings Advanced support using existing contracts |
| queue counts, Device summaries, safe current guidance | Settings current/Advanced projection |
| current action result | session-local Settings Advanced state |
| safe MKS reference, shortened fingerprints, safe build revision | progressively disclosed Advanced support |
| hosted connection check and query enrollment | development-only |
| unknown-outcome retry | development-only |
| failed/notApplied inspection and recovery | development-only |
| raw lifecycle/internal codes/exact digest | development-only |
| clear diagnostic history | absent from product UI; retained maintenance method allowed |
| raw IDs, payloads, credentials, SQL, URLs, exceptions | excluded |
| NativeAuthClosureRunner | retained implementation adapter; no broad UI injection |
| NativeClosurePage | non-navigation development/test harness or safely reduced; not a destination |

## 23. State, composition and disposal

- AuditController is created once for the destination, loads only when Audit
  first becomes visible and is disposed by composition/app lifecycle.
- breakpoint changes reuse the same controller and loaded page.
- page/filter/disclosure changes do not acquire another repository or client.
- Settings maintains one page-owned state across layouts.
- composition has exactly one close owner for database and both HTTP clients
  where owned; close is idempotent and does not outlive active callbacks.
- do not create a second Account, environment or authentication source.
- development support gating is independent from provider readiness and never
  creates an ordinary destination.

## 24. Authorized architecture surfaces

The paired D section 23 is the exhaustive writable allowlist. Preferred mapping:

| Path | Responsibility |
| --- | --- |
| application/audit.dart | Audit IDs, cursor, page/state, read port and controller |
| infrastructure/local/closure_diagnostics_repository.dart | two-query Audit adapter plus existing support behavior |
| app/pages/audit_page.dart | functional Audit composition |
| app/widgets/audit_components.dart | typed presentation-only responsive components |
| app/pages/settings_page.dart | preserved preferences plus capability-narrow Account/Sync sections |
| app/native_auth_closure_runner.dart | existing behavior delegated through narrow adapters only |
| application/closure_diagnostics.dart | shared safe status projections only when necessary |
| app/markei_composition.dart | dependency supply and close ownership |
| app/markei_app.dart | destination/page visibility and controller lifecycle |
| app/navigation/markei_destination.dart | stable Settings/Audit identity and Closure retirement |
| app/pages/native_closure_page.dart | remove ordinary-page assumptions; development harness only |
| paired focused tests | dependency, state, scope, query, sanitization and lifecycle evidence |

Shared widgets own no query, network, calculation or product state.

## 25. Architecture tests and rollback

Tests must establish every D gate plus:

- AuditPage cannot be constructed with the runner or an HTTP/Auth/Sync
  coordinator;
- ordinary Audit dependency graph contains no remote/provider import;
- persisted IDs and composite cursor survive equal timestamps;
- exactly two queries per page and no duplicate/missing record across pages;
- Settings adapters preserve current Auth/Sync behavior under fakes;
- support-only capabilities are absent from ordinary semantics/navigation;
- composition close executes once and suppresses use-after-dispose completion.

Rollback boundaries:

1. Audit port/adapter is additive and removable without data change.
2. Audit presentation can revert to the reserved page without persistence work.
3. Closure navigation removal can be reverted independently.
4. Settings support placement delegates to existing actions and can be removed
   without contract/schema rollback.
5. lifecycle correction is isolated and must retain focused regression tests.

## 26. Forbidden expansion and stop rules

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

Stop if implementation requires a new index, migration, package, generated
contract, server route, token scope, Auth/Sync behavior, provider mutation,
hosted Audit, causal lifecycle, automatic recovery, retention/export,
cross-device aggregation or a path outside D section 23.

## 27. Required I report

Replace I_DSN_CODEX.md with one complete PH03 report containing:

- final dependency direction and changed-path inventory;
- Audit types, identity, cursor and query shape;
- Account/environment predicates and sanitization boundary;
- controller state/lifetime and responsive parity;
- Settings/support capability interfaces and effect declarations;
- complete Closure disposition;
- composition ownership/disposal;
- schema/dependency/generated/Auth/Sync/provider audit;
- tests, rollback and residual architectural debt.

Required terminal:

~~~text
CYCLE=C11
PHASE=C11-PH03
ROUND=C11-PH03-R01
AUDIT_DEPENDENCY_DIRECTION=PASS | FAIL | BLOCKED
AUDIT_PERSISTED_IDENTITY=PASS | FAIL | BLOCKED
AUDIT_COMPOSITE_CURSOR=PASS | FAIL | BLOCKED
AUDIT_QUERIES_PER_PAGE=<exact count>
ACCOUNT_ENVIRONMENT_PREDICATES=PASS | FAIL | BLOCKED
AUDIT_SANITIZED_PROJECTION=PASS | FAIL | BLOCKED
AUDIT_CONTROLLER_LIFETIME=PASS | FAIL | BLOCKED
SETTINGS_CAPABILITY_BOUNDARIES=PASS | FAIL | BLOCKED
CLOSURE_CAPABILITY_DISPOSITION=PASS | PARTIAL | FAIL | BLOCKED
CLOSURE_DESTINATION_RETIRED=PASS | FAIL | BLOCKED
COMPOSITION_DISPOSAL=PASS | FAIL | BLOCKED
SCHEMA_MIGRATION=NONE | CONTRADICTED
GENERATED_SOURCE_CHANGED=NO | YES
DEPENDENCY_CHANGED=NO | YES
API_AUTH_SYNC_PROVIDER_CHANGED=NO | YES
R07_ACTIVATED=NO | YES
NEXT_DESIGN_REVIEW=<one exact action>
~~~

<!-- ACTIVATION_MARKER:C11-PH04-R01-2026-07-31 -->

# C11-PH04-R01 — Analytics Fine-Tuning Design Authority

> Status: ACTIVE — CONTROLLING C11-PH04 ARCHITECTURE AUTHORITY
> Pairing: the D and E appends carrying this exact activation marker
> Reversibility: high; one Analytics-only commit, no persistence migration

## 28. Corrected responsibility map

```text
AnalyticsPage
  -> one page ScrollController and responsive composition
  -> AnalyticsComposer (draft controls only)
  -> SavedAnalysisBrowser (record selection only)
  -> AnalyticsResultView
       -> AnalyticsChartProjection (CustomPainter, presentation only)
       -> AnalyticsResultTable (presentation only)
       -> explicit export actions
  -> AnalyticsVariablesView
       -> Purchase projection
       -> contained-Item projection

AnalyticsWorkspaceController
  -> visibility-gated AnalyticsEvidenceRepository.loadEvidence(AccountId)
  -> mutable composer draft / Variables projection state
  -> immutable session AnalyticsRecord list
  -> selected record and Chart/Table projection state
  -> pure filtering, grouping, selection, paging and record creation

AnalyticsRegistry
  -> operation compatibility and fixed-point executors
  -> grouped result series/table entries

LocalAnalyticsRepository
  -> one Account-predicated joined local read
  -> complete IDs/codes/labels needed by Variables projections

Pure Analytics export functions
  -> selected immutable record -> CSV String / PDF bytes
  -> AnalyticsPage explicit temporary-file sink
```

Dependency rules:

- page/widgets receive typed snapshots and callbacks; they do not query Drift or
  implement calculation;
- Chart/Table are projections of the same frozen result objects;
- the workspace may invoke the registry and pure export builders but never
  imports Drift, HTTP, Auth, Sync, provider or diagnostics;
- the local adapter imports the application evidence port and domain types only;
- no second Analytics controller, dataset, repository read path or result truth;
- Lists and shared Markei components remain unchanged visual references, not new
  Analytics owners.

## 29. Required types, identities and immutability

Extend the current Analytics closed types with explicit equivalents of:

```text
AnalyticsComposerDraft
  determinant
  determinantSelection
  breakdowns
  measures
  operation
  timeframe
  evidenceScope
  comparisonOperands? / percentageOperands?

AnalyticsDeterminantSelection
  all / selected stable keys / UTC point-or-period

AnalyticsRelationalBreakdown
  purchasedBy / purchasedFor / paymentMethod

AnalyticsMeasure
  quantity / unitPrice / lineTotal / purchaseTotal / evidenceCount

AnalyticsRecordId
  monotonic session sequence

AnalyticsRecordFingerprint
  canonical SHA-256-derived uppercase display prefix with session collision handling

AnalyticsRecord
  id
  fingerprint
  executedAtUtc
  frozen configuration
  frozen grouped result
  frozen contributing row IDs

AnalyticsGroupKey
  determinant stable key + zero-or-more breakdown stable keys

AnalyticsGroupedResultEntry
  group key/labels
  measure
  operation
  compatibility key
  typed value
  eligible/total/excluded counts

AnalyticsResultPresentation
  chart / table

AnalyticsVariablesProjection
  purchases / containedItems
```

Names may follow existing repository style, but all responsibilities and closed
states are required. Reuse/rename the current `AnalyticsCardConfiguration` only
when migration is complete and tests prove no mutable record escape. A record
must defensively copy configuration, conditions, scopes, row IDs, grouped entries
and results. Public snapshots expose unmodifiable collections.

Current `AnalyticsCardId` integer sequencing may become the session record ID.
The displayed fingerprint is derived from canonical UTF-8 data including registry
version, session sequence, executed time, normalized configuration, ordered
operand/scope keys, ordered contributing IDs and ordered result entries. Use the
existing direct `crypto` dependency; no dependency edit. Fingerprint equality is
not object identity. Detect visible-prefix collision within the session and
lengthen/disambiguate deterministically.

Edit/revision/delete/reorder transitions are removed from ordinary workspace
authority for PH04. Preserve no callable presentation path that mutates a saved
record. Records are session-only and retained by the existing composition-owned
`AnalyticsWorkspaceController`; no serialization port or lifecycle owner is
added.

## 30. Evidence model and grouped calculation

Preserve `AnalyticsEvidenceRowId = PurchaseItemId`. Extend
`AnalyticsEvidenceRow` only with stored values already returned by the one joined
query, notably Person and Payment Method stable IDs/codes/nicknames needed to
distinguish labels. `Purchased for` and Promotion remain typed unavailable; do
not fabricate fields.

The adapter still performs one Account-predicated join over Purchase Items,
Purchases, Products, Stores, People and Payment Methods and stable ordering by
occurrence time/Purchase/Purchase Item. No follow-up read is allowed.

Derive a Purchase projection in memory by grouping Item rows by Purchase ID.
Assert invariant equality for repeated Purchase-level facts and use Purchase
total once. A contradiction returns a typed unavailable/failure projection; do
not choose an arbitrary row.

Grouped execution order:

1. start with the active Account dataset;
2. apply half-open UTC timeframe and other draft conditions;
3. apply selected/History/Variables Item-ID scope;
4. apply selected determinant keys;
5. form deterministic `AnalyticsGroupKey`s from determinant plus relational
   breakdowns;
6. validate operation/measure/scope compatibility;
7. calculate checked fixed-point entries per group/compatibility key;
8. preserve unavailable/incompatible entries and counts;
9. freeze ordered entries and contributing IDs into the new record.

For Sum/Mean, entries exist per selected group. Difference requires exactly two
explicit group scopes and emits comparison B minus baseline A. Percentage
requires an explicit part scope contained in whole scope and emits basis points
plus both inputs. Retain existing compatibility keys and current enabled/disabled
measure matrix unless the paired D/E text narrows presentation.

Determinant labels are presentation metadata derived from stored labels; stable
IDs/UTC bucket keys own equality. Archived relational labels remain historical.
Not-assigned is a distinct nullable key. Purchased-for unavailable cannot become
a grouping key.

## 31. Workspace state and transitions

The one controller owns:

- loaded dataset and one-request/generation state;
- composer draft and validation outcome;
- Variables projection, filters, sort, page and selected Item IDs;
- immutable newest-first record list;
- selected record ID;
- Chart/Table presentation choice;
- selected-record evidence focus;
- History launch context and message.

Required transitions:

```text
visible load -> one repository request
change draft -> validate only
clear draft -> reset draft only
runAndSave -> validate -> group/calculate -> freeze -> prepend -> select
selectOlder/selectNewer -> selected record only
selectChart/selectTable -> presentation only
focusSelectedRecordEvidence -> Variables focus only
showAllVariables -> clear focus only
switchVariablesProjection -> projection only
filter/sort/page Variables -> projection only
select Purchase -> expand to Item IDs
select contained Item -> exact Item ID
useSelectedRows -> composer scope + focus/scroll request; no calculation
retry -> one local read with stale-completion suppression; preserve records
export -> pure selected-record bytes/text, then one explicit file sink write
```

If refreshed evidence differs, existing records and their frozen values/IDs
remain intact. New draft option lists use the refreshed dataset. A record may show
that some frozen contributing IDs are no longer present in the current Variables
dataset without mutating its own count or result.

Paging is 20 rows by default. Page/filter/sort state uses stable keys and resets
to page one only when a change invalidates the current page. Rendered widgets
consume only the current page. Saved cards render metadata only; only the selected
record builds Chart/Table.

## 32. Chart/Table and export architecture

`AnalyticsChartProjection` accepts immutable grouped entries and presentation
formatters. It performs layout only. Use `CustomPainter` plus semantic wrapper;
no chart package. Painter equality/`shouldRepaint` is based on the selected record
and available size. It cannot call registry/workspace/repository APIs.

Chart series require compatible numeric scale. Separate incompatible
currency/unit keys into labelled series/panes/axes or mark Chart unavailable and
route to Table. Never coerce currencies, quantity kinds or unit prices. The chart
must expose a zero baseline for signed Difference results and horizontally scroll
when category count exceeds legible width.

`AnalyticsResultTable` consumes the same ordered grouped entries. It is the exact
accessible fallback and preserves typed unavailable entries.

Pure export builders belong in `application/analytics.dart` unless extracting a
new path becomes necessary; no new path is authorized, so stop rather than invent
one. CSV and PDF consume only `AnalyticsRecord`, never the repository or mutable
workspace. The page may reuse the existing `dart:io` temporary-directory behavior
already used by History. File names include the safe lowercase fingerprint.

## 33. Page and responsive architecture

`AnalyticsPage` remains visibility-gated and owns one page scroll controller.
Use the existing `MarkeiLayoutClass` boundaries and existing theme/components.
Do not edit the theme or Lists page.

Wide composition:

- composer controls wrap in a bounded control band;
- saved metadata cards use a readable horizontal browser with explicit arrows;
- selected result is a large bounded section;
- Variables follows below with a wide table and horizontal accommodation.

Medium/compact composition:

- composer becomes progressive rows without hiding choices;
- saved cards may scroll horizontally but retain date/fingerprint/variables/time;
- chart remains bounded and horizontally accommodates categories;
- result Table and Variables use cards/vertical facts rather than compressed
  desktop tables;
- no nested vertical scroll competes with the page.

The controller/state is not recreated on breakpoint changes. `AnalyticsPage`
may issue a one-shot scroll/focus intent after `Use selected rows`; the intent is
presentation state and must not enter the domain registry.

## 34. Tests, failure injection and rollback

Required domain/application tests:

- canonical fingerprint stability, collision disambiguation and claim-neutral ID;
- defensive immutability and absence of edit/delete/reorder transitions;
- option derivation with stable IDs and duplicate labels;
- relational breakdowns, not-assigned keys and unavailable purchased-for;
- grouped Sum/Mean and all compatibility partitions;
- Difference B-minus-A and exactly-two validation;
- Percentage part/whole containment and zero denominator;
- frozen record invariance after draft/filter/retry/dataset change;
- Purchase projection deduplication and contradictory repeated-fact failure;
- Purchase-to-Item and contained-Item selection identity;
- Variables search/filter/sort/page determinism;
- one initial request, one per Retry and zero for local transitions;
- CSV/PDF deterministic metadata/result/evidence content and escaping.

Required presentation/app tests:

- full composer and disabled/explained combinations;
- no hard-coded default card creation;
- larger saved browser metadata, newest-first selection and previous/next edges;
- no enabled edit/delete/reorder action or semantics;
- Chart/Table same record/values and no reread/recalculation;
- chart scroll/zero/mixed-key fallback and semantic summary;
- explicit export busy/success/failure with one fake/temporary sink write;
- Variables below result, anchor action, Purchase/Item switch and selected-row
  draft initialization;
- compact cards and wide tables expose equivalent fields;
- state parity at 599/600/1023/1024 and 200-percent text;
- keyboard traversal, visible focus, non-color meaning and no page overflow;
- History handoff and PH03 app-shell/Audit/Settings/Closure regression.

Inject repository failure, export failure, empty data, duplicate display labels,
archived/missing references, mixed currency, mixed measurement kind, equal times,
long category labels, no plottable values, stale async completion and ordinary/
stress fixtures.

Rollback is one implementation commit to the C11-PH04 activation parent. No
migration rollback, record data conversion or provider repair exists because no
persistent Analytics record is created.

## 35. Authorized surfaces and stop rules

Use exactly the paired D §34 allowlist. Preferred ownership is:

| Path | Responsibility |
| --- | --- |
| `domain/analytics/analytics_models.dart` | draft, selections, record, fingerprint wrapper, group/result/projection closed types |
| `domain/analytics/analytics_registry.dart` | validation and grouped fixed-point operations |
| `application/analytics.dart` | evidence port, History context, pure CSV/PDF builders |
| `application/analytics_workspace.dart` | options, draft, immutable record/state transitions, Variables derivations |
| `infrastructure/local/local_analytics_repository.dart` | one joined Account-scoped evidence read and stored reference identities |
| `app/pages/analytics_page.dart` | page order, scroll/focus, explicit file export orchestration |
| `app/widgets/analytics_components.dart` | composer, browser, Chart/Table and Variables projections |

Do not change app composition or destination because the existing controller and
Analytics route are sufficient. Do not change `markei_theme.dart` or shared
components merely to imitate the mockup.

Stop if implementation needs:

- schema, migration, `local_database.dart` or generated Drift output;
- saved-record serialization, app-private JSON or preference storage;
- dependency, pubspec, lockfile, asset, font or platform change;
- another controller, repository request or truth reconstruction;
- History, Lists, shell/composition or PH03 source changes;
- API/Auth/Sync/provider/diagnostic access;
- raw fact repair, chart-derived calculations or floating-point money authority;
- prediction, ranking, recommendation, causality or advanced statistics.

## 36. Required I report

Replace I with a PH04 architecture report containing exact changed paths;
responsibility/dependency map; final closed types; record/fingerprint identity and
immutability; grouped calculation ordering; compatibility preservation; Purchase
projection derivation; workspace transitions/lifetime; Chart/Table shared source;
export boundary and write counts; responsive state ownership; request counts;
tests/performance; rollback; forbidden-surface audit and residual risks.

Required terminal:

```text
CYCLE=C11
PHASE=C11-PH04
ROUND=C11-PH04-R01
ANALYTICS_DEPENDENCY_DIRECTION=PASS | FAIL | BLOCKED
COMPOSER_CLOSED_TYPES=PASS | FAIL | BLOCKED
IMMUTABLE_RECORD_IDENTITY=PASS | FAIL | BLOCKED
CANONICAL_FINGERPRINT=PASS | FAIL | BLOCKED
GROUPED_RESULT_MODEL=PASS | FAIL | BLOCKED
PH02_FIXED_POINT_COMPATIBILITY=PASS | FAIL | BLOCKED
PURCHASE_PROJECTION_DEDUPLICATION=PASS | FAIL | BLOCKED
VARIABLES_STABLE_SELECTION=PASS | FAIL | BLOCKED
CHART_TABLE_SINGLE_SOURCE=PASS | FAIL | BLOCKED
EXPORT_PURE_BOUNDARY=PASS | FAIL | BLOCKED
SESSION_ONLY_LIFETIME=PASS | FAIL | BLOCKED
RESPONSIVE_SHARED_STATE=PASS | FAIL | BLOCKED
REPOSITORY_REQUEST_COUNT=initial:1; retry:+1; local_transitions:+0
SCHEMA_MIGRATION=NONE | CONTRADICTED
GENERATED_SOURCE_CHANGED=NO | YES
DEPENDENCY_CHANGED=NO | YES
SECOND_TRUTH_OR_CONTROLLER=ABSENT | PRESENT
API_AUTH_SYNC_PROVIDER_DIAGNOSTIC_IMPORTS=ABSENT | PRESENT
PH03_ARCHITECTURE_CHANGED=NO | YES
ROLLBACK=ONE_COMMIT | CONTRADICTED
NEXT_DESIGN_REVIEW=Reconcile PH04 I evidence and retain human visual/real-device gates.
```
