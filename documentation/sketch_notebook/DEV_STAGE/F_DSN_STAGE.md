# F_DSN_STAGE — C11-PH01-S02 Responsive Five-Page Presentation Architecture

> Sequence: FLX-ORD-01
> Role: Main design materialization stage
> Cycle / phase / unit: C11 / C11-PH01 / C11-PH01-S02
> Required branch: `grm-guarded-provisioning-20260727`
> Required S01 implementation ancestor:
> `1c7df53c095f4e7c1d85f278ba16c21fd95b25e6`
> Reconciled Main head: `9147e59341ce5e59f60ba51756aa524f788410ac`
> Codex starting HEAD: the synchronized D/E/F publication commit pinned by the
> initiation prompt
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Architecture boundary: presentation shell, shared visual system and five
> current product pages only

## 1. Accepted S02 architecture

Retain the S01 dependency direction:

```text
MarkeiApp composition
  → stable MarkeiDestination registry
    → MarkeiShell responsive navigation
      → page-owned responsive composition
        → shared presentation-only components
          → semantic tokens / Flutter primitives
```

Repository/application ports supply facts and commands. Page state classifies
those facts for presentation. Shared components render data and callbacks.

Forbidden dependency direction:

```text
shared widget
  → repository / database / provider / Sync coordinator
```

S02 is not a state-management migration. Preserve current constructors,
repository ports, global refresh behavior and `IndexedStack` retention unless a
small presentation adapter is needed inside an authorized file.

## 2. Visual-system architecture

### 2.1 Token ownership

`app/design/markei_theme.dart` owns:

- forest-green and neutral palette;
- semantic status colors and soft tints;
- type roles;
- 4/8 spacing rhythm;
- compact/medium/wide gutters;
- radii, one-pixel borders and shadow policy;
- visible control height and minimum hit target;
- maximum content width;
- navigation dimensions;
- table density;
- focus and disabled-state defaults.

Pages must not reproduce these values as local design systems.

### 2.2 Shared component ownership

`markei_components.dart` and optional explicitly authorized component files may
own:

| Component family | Responsibility |
| --- | --- |
| Content canvas | responsive gutter and maximum width |
| Page header | noun, purpose, provenance and page-level action |
| Section surface | one bounded meaningful group |
| Summary strip/tile | desktop unified summary and compact peer summaries |
| Control band | search/filter/sort/action reflow |
| Record table | wide dense comparison structure |
| Record card | compact ordered fact projection |
| Selection band | selected count and contextual actions |
| Disclosure | explanation, detail or subordinate management |
| State panel | loading, empty, filtered empty, error and partial state |
| Feedback banner | classified operation result with safe action |
| Form section | label, controls, helper/error and action grouping |

Shared widgets accept display-ready values, stable keys and callbacks. They do
not own query timing, selection truth, filtering rules, validation, business
classification or navigation decisions.

### 2.3 Surface rules

- The page canvas is not a Card.
- Toolbars and ordinary rows are not Cards.
- One Card/section surface represents one meaningful group.
- Summary peers may share one desktop strip rather than four cards.
- Compact records may each use one card.
- Cards use one-pixel neutral borders, `8 dp` radius and no decorative shadow.
- Status tint is local and subtle; it must not color the entire page.

## 3. Responsive projection contract

Breakpoints remain:

```text
compact: width < 600
medium: 600 <= width < 1024
wide: width >= 1024
```

### Compact

- bottom navigation plus More;
- page-aware compact app bar;
- `16 dp` gutter;
- stacked control/form sections;
- record cards;
- no desktop DataTable squeezed horizontally;
- primary actions remain in normal flow and above the bottom-navigation safe
  area.

### Medium

- compact rail;
- `24 dp` gutter;
- bounded content;
- two-column sections only where controls and text remain readable;
- per-page table/card choice based on fact density;
- no unconditional wide table merely because width exceeds 600.

### Wide

- `224–240 dp` labelled navigation;
- `32 dp` gutter;
- `1200–1240 dp` content maximum;
- dense tables, unified summary/action bands and two-column workspaces where
  supported;
- content must not stretch indefinitely on large windows.

At boundary changes:

- destination ID remains stable;
- page widget/state identity remains stable;
- selected record/view/search/sort/filter/draft/review state remains stable;
- a table row and compact card refer to the same record identity and facts.

## 4. Shell architecture

`MarkeiShell` owns:

- responsive navigation chrome;
- safe areas;
- page-aware compact title presentation;
- primary/More destination access;
- selected-destination semantics;
- content-canvas placement.

It does not own:

- page title/purpose content beyond shell coordination;
- page filters, summaries, selections or drafts;
- application repository construction;
- destination behavior;
- feature-gate decisions.

Retain stable destination IDs and current availability. Do not move Catalogue
into direct compact navigation in S02. Do not activate Analytics or Audit. Do
not remove Closure or change its feature gate.

## 5. Home architecture

Home remains a static presentation projection over `home_content.dart` and
navigation callbacks.

Required structure:

```text
Home header
→ primary Register purchase action
→ current-capability card collection
→ local-first/how-it-works explanation
→ low-emphasis support/developer disclosure when truthful
```

Wide uses two columns for peer capability cards. Compact uses one ordered
column. No repository, telemetry, account, provider or Sync dependency may be
introduced.

## 6. Lists architecture

Lists retains one page controller/state and one projection request route:

```text
selected ProductListView
→ ProductListProjectionRepository.productListProjection
→ presentation classification/search/sort
→ wide table OR compact cards
```

Wide and compact projections consume the same returned items and shared helper
functions for:

- status;
- remaining/expected wording;
- approximate money;
- insufficient history;
- stable Product identity.

Required visual structure:

```text
header/provenance
→ view selector
→ search/sort band
→ wide unified summary strip OR compact 3+1 summary
→ table OR cards
→ how-it-works disclosure
```

Do not add selection/export/Analytics actions to Lists in S02.

## 7. Catalogue architecture

Catalogue page state continues to own:

- loaded Products and Stores;
- local Product search/sort state;
- selected/detail Product;
- Product draft;
- packaged/bulk state;
- similarity warnings;
- Store draft;
- messages/loading.

Use one Product presentation collection:

```text
loaded Products
→ current search
→ deterministic local sort
→ wide rows OR compact cards
```

No query is allowed per row/card or per layout change.

Required wide structure:

```text
header + search/sort
→ Product table/list
→ selected detail
→ Register product form | Similar-product decision
→ subordinate Stores disclosure
```

Required compact structure:

```text
header
→ search/sort
→ Product cards
→ details disclosure
→ Register product disclosure
→ similarity decision adjacent to form
→ Stores disclosure
```

Keep existing Product and Store repository calls exactly bounded. Catalogue may
not derive latest Purchase, price, cycle or category facts.

## 8. History architecture

History retains:

- one `listRecentPurchases` read per refresh/retry;
- page-local presentation filters over returned entries only;
- selected Purchase IDs;
- one active detail Purchase ID;
- existing export/share calls;
- detail and price-change reads through existing ports.

Required flow:

```text
returned PurchaseHistoryEntry collection
→ optional local filter adapters
→ wide rows OR compact cards
→ stable selection/detail IDs
```

Filters must be pure and deterministic. They cannot call the repository.
Selection identity must not depend on filtered list index.

Wide detail may be inline or adjacent. Compact detail is an expansion/disclosure
associated with the selected card. Both use the existing detail repository and
must avoid duplicate detail reads caused only by responsive rebuild.

Analytics/Edit/Delete remain unavailable. Their architecture is not introduced
by visual placement.

## 9. Purchase architecture

Purchase retains one stateful draft controller. S02 may extract
presentation-only widgets but must not split the business workflow into
separate repository-owning pages.

State machine remains:

```text
edit draft
  → validate context and staged Items
    → review read-only projection
      → register once
        → known success | known failure | unknown result
```

Responsive layout is a projection of the same state:

```text
wide edit workspace / compact edit stack
          share one draft
wide review panel / compact review stack
          share one review state
```

Required ownership:

- Store/date/time/reference state stays in Purchase page state;
- Product selection and Product draft stay in Purchase page state;
- quantity/price calculations remain current implementation behavior;
- staged lines remain the one source for table/cards and total;
- validation and operation-result classification remain current behavior;
- `onRegistered` remains the refresh boundary.

Do not create separate desktop/mobile controllers, new repository adapters or
duplicated form state.

## 10. Page-specific priority and fidelity matrix

| Page | Fidelity anchor | Highest preserved behavior | Explicit visual omission |
| --- | --- | --- | --- |
| Home | target card rhythm and calm hierarchy | destination callbacks and truthful copy | scheduled/household/Analytics promises |
| Lists | unified desktop summary, compact 3+1, dense table/cards | one projection query and estimate states | photos, unsupported filters/actions |
| Catalogue | dense Product collection plus lower form/similarity workspace | Product/Store creation and stable identity | category/price/cycle/image facts |
| History | filter/selection/detail hierarchy and compact expandable cards | selection, exports, detail and Retry | Analytics/Edit/Delete implementation |
| Purchase | compact context/editor/table and explicit mobile review | full draft/edit/review/register semantics | new Store/person/payment/provider behavior |

Visual fidelity is highest where the reference represents current facts. Where
the reference exceeds current authority, structural rhythm is retained while
the unsupported control or fact is omitted.

## 11. Data and behavior invariants

S02 must preserve:

1. local SQLite as product truth;
2. existing account scoping;
3. stable Product and Purchase IDs;
4. Lists projection semantics;
5. Product natural-identity and similarity behavior;
6. History export/detail behavior;
7. Purchase validation, draft preservation and registration semantics;
8. destination identity and feature gating;
9. Settings and Native Closure behavior;
10. Sync/diagnostic authority outside the five-page visual layer.

No UI widget may infer provider, Sync, inventory, price, cycle or operation
truth beyond the current application values supplied to it.

## 12. Optional local presentation behavior

S02 may add only:

- deterministic A–Z/Z–A sorting over already loaded Lists/Catalogue
  presentation collections;
- History filtering over already returned entries;
- disclosure/open state;
- view-density choice when it affects presentation only;
- neutral glyphs/initials as non-factual Product placeholders.

These behaviors:

- default to a state equivalent to current behavior;
- do not persist to the database;
- do not trigger provider/API work;
- do not alter repository contracts;
- preserve stable record identity;
- are covered by focused tests.

## 13. Error and feedback architecture

Use classified presentation models or bounded page helpers for:

- read loading/error/retry;
- first-use and filtered empty;
- insufficient history;
- Product similarity;
- form validation;
- known success;
- known failure;
- unknown registration result.

Shared feedback widgets render a supplied severity/title/message/action. They
must not parse arbitrary exception strings, assign causal codes or decide that
an operation succeeded.

Unexpected exceptions remain sanitized. Do not expose stack traces or raw
provider messages.

## 14. Reversibility and implementation order

Implement in this order:

1. characterize existing behavior and keys;
2. correct tokens/theme;
3. correct shared shell and components;
4. correct Home;
5. correct Lists;
6. recompose Catalogue;
7. recompose History;
8. recompose Purchase;
9. consolidate only genuinely shared presentation primitives;
10. run full regression and changed-path audit;
11. replace G/H/I.

Each page diff should remain reviewable independently. Do not mix unrelated
cleanup, rename public page classes or migrate repositories.

## 15. Architecture tests

Tests must prove:

- semantic tokens are consumed rather than page-local style systems;
- shell selection is stable across feature-gated destination lists;
- page state survives compact/medium/wide transitions;
- table and card projections use the same record IDs and facts;
- responsive rebuild does not introduce duplicate repository requests;
- local Catalogue sort and History filters are pure presentation transforms;
- Purchase edit/review layouts share one draft state;
- shared widgets import no repository/infrastructure layer;
- Analytics, Settings, Audit and Closure behavior remains unchanged;
- no new dependency or asset authority exists.

## 16. Design stop boundary

Stop when:

- a target field lacks a current application source;
- a shared widget requires a repository;
- page convergence requires a domain/repository interface change;
- desktop/mobile projections require separate business state;
- a new package, font or image pipeline appears necessary;
- page state cannot survive responsive switching;
- the requested look requires moving Closure capability or activating
  Analytics/Audit;
- the authorized paths are insufficient.

Report the missing design decision rather than silently expanding ownership.

## 17. Required I report

`I_DSN_CODEX.md` must include:

1. final dependency direction;
2. token/component changes;
3. shell changes;
4. one architecture summary per page;
5. table/card shared-identity evidence;
6. repository-call parity evidence;
7. optional presentation behavior introduced;
8. target features omitted by authority;
9. changed-path inventory;
10. deviations and residual debt.

Required terminal:

```text
CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S02
PRESENTATION_ARCHITECTURE=PASS | PARTIAL | FAIL | BLOCKED
SHARED_TOKEN_OWNERSHIP=PASS | FAIL | BLOCKED
SHARED_COMPONENT_BOUNDARY=PASS | FAIL | BLOCKED
RESPONSIVE_PROJECTION_PARITY=PASS | FAIL | BLOCKED
PAGE_STATE_PRESERVED=PASS | FAIL | BLOCKED
REPOSITORY_INTERFACES_CHANGED=NO | YES
DOMAIN_OR_INFRASTRUCTURE_CHANGED=NO | YES
NEW_DEPENDENCY_OR_ASSET_PIPELINE=NO | YES
ANALYTICS_SETTINGS_AUDIT_CLOSURE_BOUNDARY=PRESERVED | CONTRADICTED
NEXT_DESIGN_REVIEW=<one exact action>
```
