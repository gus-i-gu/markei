# B_DIDACTIC — C11-PH01 Visual System and Core-Page Convergence

> Cycle: C11  
> Phase: C11-PH01  
> Role: Didactic Chat [A]  
> Repository: `gus-i-gu/markei`  
> Required branch: `grm-guarded-provisioning-20260727`  
> Verified inspection baseline: `861c27fdaf6ade2093d481af312d27ff895b8dc0`  
> Writable surface: this file only  
> Status: DIDACTIC INVESTIGATION — MAIN RECONCILIATION REQUIRED  
> Authority: no source change, permanent promotion, D/E/F activation or Codex authorization

## 1. Recovered state and evidence boundary

The remote branch comparison established that
`grm-guarded-provisioning-20260727` resolves exactly to `861c27f`; the required
baseline is the remote head and merge base, with zero divergence. Inspection
explicitly used that ref. No default-branch or older-branch source was
substituted.

PRI-A and PMC-01 confirm that Didactic owns learner-facing concepts,
relationships, vocabulary, evidence-based maturity and learning history.
This investigation may replace only this active staging report. It does not
select architecture, claim operational acceptance, change KANBAN maturity,
edit Flutter or permanent Didactic memory, activate D/E/F or authorize Codex.

Recovered authority:

- Cycle 10 is closed at the two-Device, one-Account development boundary.
- C11-PH01 owns visual-system and Home, Lists, Purchase, Catalogue and History
  convergence.
- C11-PH02 owns functional local/account-scoped Analytics.
- C11-PH03 owns mandatory Settings and Audit, including removal of Closure from
  ordinary navigation only after capability disposition.
- C12-PHASE02 retains GCM04, multi-user/backend assays and conditional R07
  reassessment.

`06_SESSION_SCHEME.md` contains an older suggested six-phase order. The latest
human/Main C11 preparation and this invocation supersede that ordering. Its
product boundaries remain useful; its phase numbers do not control this report.

Evidence inspected:

- `00_PROJECT_STATE.md`, `06_SESSION_SCHEME.md`,
  `didactics/08_CONCEPT_MAP.md`, the latest C11 preparation in
  `J_MAIN_STAGE.md`, `ALT_DEV.md` section 15 and the prior
  `B_DIDACTIC.md`;
- all five target PNGs under `DEV_STAGE/references/c09_s02/`;
- current `home_page.dart`, `lists_page.dart`, `products_page.dart`,
  `purchase_page.dart`, `history_page.dart`, `markei_app.dart`,
  `design/markei_theme.dart` and `widgets/markei_components.dart`.

`H_DDC_CODEX.md` was not required. Current source directly establishes the
implemented interaction vocabulary; PH01 has no new Codex evidence yet.
The PNGs establish product intent, not pixel-perfect or data-contract authority.

## 2. Reference-by-reference interpretation

### 2.1 Lists

The Lists target teaches a prediction workspace, not merely four database
queries. Its comprehension order is:

1. choose the projection: Storage, Shortage, Market or All;
2. understand the aggregate situation through status counts and approximate
   next-purchase total;
3. narrow the result by category, store, person, search and sort;
4. scan product rows/cards;
5. disclose product detail only when needed;
6. learn how projections work and where the shortage threshold is configured.

Desktop uses a comparison table because simultaneous column reading matters.
Mobile preserves the same meaning through cards: product identity, status,
time remaining, price/package reference and detail affordance. Mobile is not a
narrow table.

The target distinguishes four prediction outcomes: in storage, ending soon,
expected ended/market, and not enough history. These must remain semantic
states rather than decorative colors. “Approximate” and “derived” must remain
visible wherever a forecast could be mistaken for a recorded fact.

Current source provides projection tabs, a history explanation, an optional
approximate total and simple cards. It lacks search, filters, summaries,
sorting, explicit retry and a desktop comparison representation. Its empty
copy, “Not enough history,” conflates an empty projection with insufficient
history for an individual product.

### 2.2 Catalogue

The Catalogue target teaches that the page is the reusable product reference
library. Browsing is primary; registration is a contextual secondary task.
The desktop hierarchy is search/filter/sort, product comparison table, then
registration and similarity resolution. Compact mode first exposes browseable
cards and moves registration/similarity guidance behind explicit actions.

Product identity should be read in this order: visible Product code, Product
and Brand, packaged/bulk mode, quantity and unit, then purchase-derived facts
such as latest price, change and remaining cycle. Category is descriptive
metadata, never identity.

“Similar product found” is a decision point, not an error. “Use existing” is
the safe/default action; “Create anyway” is explicit divergence. The interface
must explain that choosing an existing Product prevents accidental duplicates
without implying fuzzy matches are authoritative identity.

Current `ProductsPage` combines Store creation, Store listing, Product search,
Product selection/detail, Product creation, retry and similarity messages in
one long list. This blurs page purpose and makes the dangerous “Create anyway”
action permanently prominent. The source title “Products” for sections and
`ProductsPage` for implementation may remain internal, but user-facing
navigation and headings should consistently say “Catalogue.”

### 2.3 Home

The Home target teaches orientation: what Markei is, what it can do now, what
is planned, and its local-first trust boundary. Green cards describe current
value; purple cards describe scheduled or prospective capability. This is a
semantic present/future distinction, not alternating decoration.

The target’s prose contains stale product language for C11: “Household,”
optional synchronization, and developer-facing roadmap content should not be
copied blindly. Home should become an action-oriented overview of current
truth: register a purchase, understand Lists, revisit History/Catalogue, and
see concise local/sync state only where an existing projection supports it.
Planned Analytics, Settings or Audit claims must not appear as already
functional during PH01.

Current Home renders “Markei” plus generic cards from `homeCards`, with no
page-level primary action, summary, present/future legend or responsive
composition. PH01 should preserve the target’s orientation hierarchy while
rewriting copy against current accepted capability.

### 2.4 Purchase

The Purchase target teaches a staged transaction:

```text
Purchase context
→ find or describe Product
→ enter quantity and price facts
→ add staged Item
→ review staged Items
→ confirm Purchase
→ receive durable success or corrective feedback
```

The desktop target supports the complete working set on one screen. Mobile
separates editing and read-only review so confirmation is deliberate. Store,
occurrence date/time, optional Person and optional Payment Method belong to
Purchase context; Product identity and quantity belong to each staged Item.

Feedback has distinct meanings: informational lookup result, similarity
decision, validation correction, operation error and success. Technical codes
such as `product-selection-invalidated:` and `item-required:` are diagnostic
identifiers and should not lead user-facing sentences. Each message must name
what happened, what was preserved, and the next safe action.

“Register purchase” means commit the reviewed Purchase. “Add staged item”
means local draft composition and must never resemble final registration.
“Register new product” transfers the user to Catalogue or clearly opens a
Catalogue-owned subflow; it must not imply the Purchase is already registered.

Current Purchase implements much of the staged behavior, editing, review,
submission gating and typed outcomes, but concentrates all comprehension in a
1,217-line page. Its language inconsistently capitalizes domain nouns, exposes
diagnostic prefixes, uses generic catch-all failures and does not yet express
the target’s desktop/mobile task staging clearly.

### 2.5 History

The History target teaches retrieval and inspection of registered Purchases:
choose a grouping/filter mode, narrow the history, select Purchases, inspect
one Purchase, then perform contextual export or Analytics handoff.

Selection and opening are different actions. A checkbox selects for batch
actions. “Open” or row/card disclosure reveals detail. Double-click may be a
desktop accelerator but cannot be the only discoverable path; mobile needs an
explicit control. Edit/Delete shown disabled in the PNG are not authority to
implement mutation of registered Purchases.

The target provides the clearest state grammar: filtered empty state with
“Adjust filters,” loading skeleton/progress, and error state with “Retry.”
Those states should become the shared page model.

Current History provides loading, empty, error/retry, multi-selection,
CSV/PDF actions, tap/double-click/long-press detail and local price comparison.
It lacks filtering/grouping, visually conflates tap selection with detail
opening, exposes disabled Edit/Delete actions without explanatory value, and
leaves “Move to Analytics” disabled. PH01 must prepare that handoff’s visible
language but not implement PH02 Analytics.

## 3. Shared visual and interaction vocabulary

### 3.1 Page anatomy

Every core page should use the same reading order:

1. page header: stable noun plus one-sentence purpose;
2. optional summary: recorded or derived totals with qualification;
3. search/filter/sort controls;
4. primary content collection or form;
5. contextual actions tied to selection or current step;
6. explanatory or recovery disclosure.

Desktop may align header, summary and controls horizontally. Compact layouts
stack them without changing their semantic order. A top app bar saying only
“Markei” must not compete with an unstructured second title.

### 3.2 Search and filters

- Search is immediate text narrowing and must name its searchable concepts.
- Filters narrow by explicit attributes and show active state/count.
- Sort changes order, not membership.
- “Apply” is used only when filters are staged; immediate controls should not
  pretend a second confirmation is required.
- “Clear filters” restores the unfiltered result. Bare “Clear” is reserved for
  clearing a local field or selection when context is unambiguous.
- Compact layouts may place secondary filters in a sheet, but active filters
  remain visible and removable.

### 3.3 Tables and cards

Desktop tables are for comparison across repeated fields. Mobile cards preserve
the same semantic fields in priority order and may defer secondary facts under
“View details.” Neither representation may hide status, primary identity,
money/time qualification or the action required to continue.

Keyboard and screen-reader semantics must follow the data model rather than the
visual grid: column headers label cells; each card has one coherent accessible
name; selection and expansion are announced independently.

### 3.4 Status chips

Chips are concise, non-interactive classifications unless they are visibly
implemented as filters. Their text carries meaning without color:

- recorded/product mode: Packaged, Bulk;
- prediction: In storage, Ending soon, Expected ended, Not enough history;
- process: Loading, Saved, Needs attention, Unavailable only when persistent
  process state must be summarized.

Use sentence case. Avoid status synonyms for the same state across pages.
“Market” is a projection/list destination, while “Expected ended” is an item
status; they must not be used interchangeably.

### 3.5 Contextual actions

Each surface has one visually dominant next action. Secondary actions are
tonal/outlined; destructive actions use error semantics and confirmation.
Disabled actions should be absent unless their presence teaches a dependency;
when present, a label or accessible description explains what enables them.

Batch actions appear only with selection or clearly show “0 selected.” Detail
actions belong to the opened record. Overflow menus hold infrequent actions,
not the page’s primary task.

### 3.6 Forms and confirmation

Forms group by user decision, not storage model:

- Purchase context;
- Product identity;
- quantity/package and price;
- staged Items;
- review and confirmation.

Required fields show requirement in label and validation, not color alone.
Validation appears next to the affected field and in a concise summary when
multiple fields fail. User input and staged Items remain intact after
correctable failure. Success identifies the saved object and gives the next
useful route.

### 3.7 Loading, empty, error and retry

All five pages inherit one readable state contract:

- loading: name what is loading; preserve stable layout where practical;
- empty-first-use: explain what is absent and offer the creation/registration
  action;
- empty-filtered: say that filters produced no result and offer “Adjust
  filters” or “Clear filters”;
- insufficient history: explain that a derived value is unavailable while
  retaining the Product/Purchase;
- validation: point to correctable input without discarding it;
- success: identify completed action and preserved result;
- error: name the failed operation, state what remains safe, and offer Retry
  only when repeating that operation is appropriate;
- retrying: prevent duplicate activation and expose progress;
- partial/unavailable: distinguish unavailable derived detail from failure to
  load the whole page.

Automatic Sync Retry/Recovery remains excluded. This UI “Retry” contract covers
safe re-reading or explicitly idempotent local operations only.

### 3.8 Color and surfaces

- Green means current, available, selected, confirmed, or primary action. It
  must not imply success for an unvalidated operation.
- Purple means secondary guidance, comparison, explanation, derived insight or
  future-context handoff. It must not become a second primary-action color.
- Warm neutral/cream is the page ground; white/warm surface cards group content.
- Orange means time-sensitive warning; red means error, overdue/destructive or
  failed state. Neither can rely on hue alone.
- Borders, icons, labels and text must preserve meaning in monochrome,
  high-contrast and color-vision-deficiency conditions.

## 4. Page-specific comprehension requirements

### Home

- Explain current purpose in one sentence without unsupported Household or
  telemetry claims.
- Offer one clear entry to “Register purchase.”
- Summarize current local value and route to Lists/History/Catalogue.
- Mark planned or later-phase capabilities as unavailable without presenting
  them as product promises.
- Keep developer/project documentation secondary to household purchase tasks.

### Lists

- Preserve the four projection names and explain their relationship.
- Separate projection-empty, filtered-empty and insufficient-history states.
- Label every forecast as estimate/approximation and show the observation date.
- Provide summaries and filters without implying nonexistent category data.
- Keep threshold configuration as a Settings link for PH03, not an inline
  duplicate setting.

### Catalogue

- Use “Catalogue” consistently for the page and “Product” for an entry.
- Make browsing/searching primary and Product/Store creation secondary.
- Separate Store management from Product registration enough that their
  different identities are evident.
- Treat similarity as advisory; present “Use existing” before “Create anyway.”
- Do not present derived latest price/cycle fields when source data is absent.

### Purchase

- Make staged Item versus registered Purchase unmistakable.
- Keep occurrence date/time distinct from insertion or Sync time.
- Present Person and Payment Method as optional Purchase references.
- Preserve draft/staged state through validation and submission failure.
- Give read-only review on compact layouts and a clear “Back to edit” route.
- Translate typed/diagnostic errors into plain language while retaining codes
  only in expandable technical detail where later Audit/Support policy permits.

### History

- Separate filtering, batch selection and detail disclosure.
- Provide explicit Open/View details on every input mode; double-click remains
  only an accelerator.
- Use “Purchase history” consistently; use “Purchase” for a registered record.
- Do not expose Edit/Delete as inert ordinary actions.
- Keep export labels format-specific and report destination/outcome clearly.
- Prepare “View in Analytics” or “Analyze selection” vocabulary for PH02, but
  keep it disabled/absent until the handoff exists.

## 5. Terminology risks

| Risky term or pattern | Required distinction |
| --- | --- |
| Product / Item | Product is reusable Catalogue identity; Item is a line in a staged or registered Purchase. |
| Purchase / staged Item / draft | Only final confirmation registers a Purchase. |
| Catalogue / Products | Catalogue is the page/library; Product is one record. |
| Storage / Shortage / Market | Projection destinations, not recorded inventory locations. |
| Expected ended / Market | Item status versus projection membership. |
| Estimate / latest fact | Forecasts are derived; latest purchase/price are recorded facts. |
| Purchase date / created time / Sync time | User occurrence, local insertion and coordination observations are separate. |
| Person / Household | Person is an optional local reference; Household remains unimplemented. |
| Payment Method | Optional reference, not proof of payment processing. |
| Share list (PDF) | History exports selected Purchases; “list” can be confused with Lists projections. Prefer “Share purchases (PDF).” |
| Analytics (PIN) | “PIN” implies a maturity scheme or lock. Ordinary users need “Analytics”; availability comes from implementation state. |
| Product capitalization in prose | Use ordinary sentence case in UI; reserve type-style capitalization for technical documentation. |
| Technical error prefixes | Diagnostic codes must not precede user copy. |

## 6. Accessibility and readable-state requirements

- Text scaling through at least 200% must not clip headings, chip labels,
  monetary values, form help or actions; layouts must reflow rather than force
  horizontal page scrolling.
- Touch targets should be at least 48 logical pixels; compact tables/cards must
  not create tiny icon-only actions.
- Every icon-only control needs an accessible name and tooltip where pointer
  use exists.
- Keyboard order follows visual/semantic order: header controls, filters,
  content, contextual actions. Focus remains visible on warm, green and purple
  surfaces.
- Enter/Space activate the focused control; Escape closes sheets/dialogs;
  predictable shortcuts may focus search, but no task depends on a shortcut.
- After validation failure, focus moves to the first invalid field; after an
  asynchronous error, focus/announcement reaches the error summary without
  destroying entered data.
- Loading, success and error changes use live-region semantics without repeated
  announcements. Color, icon and text jointly identify state.
- Table headers, selection counts, expansion state and disabled reasons are
  screen-reader-readable.
- Money includes currency; dates/times use a consistent locale-visible format;
  derived dates retain “estimated.”
- Cards and controls must keep adequate contrast in light/dark or
  high-contrast themes if those themes are supported; unsupported theme modes
  must not be implied.

## 7. PH01 learning and acceptance criteria

PH01 is Didactically acceptable when evidence shows:

1. A user can name the purpose and primary action of each of the five pages
   from its header and first viewport.
2. The same concepts, labels and action hierarchy are preserved across desktop
   and compact layouts, while tables adapt into cards where comparison density
   changes.
3. Green, purple and neutral surfaces follow the semantic contract above; color
   is never the only state carrier.
4. Search, filter, sort, selection, detail and primary actions remain distinct.
5. Lists distinguishes facts, forecasts, projection membership, insufficient
   history and empty results.
6. Catalogue distinguishes browsing, Product identity, Store identity,
   registration and advisory similarity.
7. Purchase distinguishes context, staged Items, review, registration and
   corrective feedback; correctable failures preserve work.
8. History distinguishes filtering, selection, detail, export and future
   Analytics handoff.
9. Each page exhibits designed loading, empty, error and retry behavior
   appropriate to its operations, with readable success/validation states
   where mutation exists.
10. Keyboard-only navigation, visible focus, 200% text scaling, accessible
    names and state announcements are evidenced at representative desktop and
    compact widths.
11. Existing functional boundaries remain truthful: no invented category,
    Household, remote telemetry, destructive Purchase mutation or automatic
    Retry/Recovery behavior appears.
12. Automated widget/golden/semantics evidence and human Windows/Android
    walkthrough evidence are reported separately; neither is inferred from
    screenshots alone.

No KANBAN transition is proposed. These are product-comprehension acceptance
criteria, not learner-maturity evidence.

## 8. Inherited constraints for PH02 and PH03

### PH02 Analytics

- Reuse the PH01 header, filter, summary, card/table, loading/empty/error and
  color vocabulary.
- “Analytics” means deterministic local/account-scoped analysis of user-owned
  Purchase data, never developer telemetry.
- History handoff must carry understandable visible context: selected
  Purchases or active filters, not an opaque internal identifier alone.
- Derived totals/trends show currency, period, comparison basis and
  insufficient-history conditions.
- Purple may identify derived insight; green remains current selection/primary
  action.

### PH03 Settings and Audit

- Settings owns configuration (“what should happen”); Audit owns understandable
  observed history/state (“what happened”). Neither reconstructs provider
  truth.
- Settings inherits grouped forms, help text, validation preservation and
  success/error confirmation.
- Audit inherits History’s filter, selection, detail disclosure and
  readable-state grammar.
- Closure must not remain ordinary user vocabulary. Existing capabilities need
  retain/move/development-only/remove classification before navigation change.
- Technical codes and raw diagnostics belong only in explicit advanced/support
  disclosure when Operational and Design establish safe ownership.
- Automatic Retry/Recovery remains excluded; dangerous actions cannot be made
  prominent merely to match PH01 visual language.

## 9. Recommendations to Main

1. Adopt the shared vocabulary in section 3 as the PH01 Didactic contract for
   E staging.
2. Require one page-anatomy and responsive-state matrix covering all five pages
   before Codex scope is activated.
3. Treat `ProductsPage` as user-facing Catalogue and forbid route/header
   vocabulary drift.
4. Require diagnostic-code-to-user-copy separation in Purchase while
   preserving typed evidence internally.
5. Remove inert Edit/Delete affordances from ordinary History PH01 scope unless
   a later authorized capability supplies them.
6. Keep Analytics handoff language visible in planning but do not present a
   functional action until PH02.
7. Require shared state components to support action, qualification and
   accessibility, not only an icon plus message.
8. Ask human reviewers to evaluate task comprehension at desktop and compact
   widths, not pixel similarity alone.

## 10. Dependencies requested from Operational and Design

### From Operational

- Evidence matrix for loading, filtered-empty, first-use empty, validation,
  success, failure and safe retry on each page.
- Windows and Android test widths, 200% text-scale procedure, keyboard/focus
  checks and screen-reader feasibility.
- Confirmation of which local reads/mutations are safe to retry and how
  duplicate submission is prevented.
- Measured constraints for large Catalogue/History/Lists collections and
  responsive performance.
- Export/share destination and failure-state truth for History copy.

### From Design

- One shared responsive breakpoint/component responsibility map.
- Semantic owners for page header, summary, filter bar, state panel, status
  chip, responsive data collection and contextual action group.
- Boundary between Catalogue browsing, Product registration and Store
  management.
- Boundary between Purchase edit, staged Item review and final confirmation.
- Selection/detail state ownership in History and context contract for PH02.
- Confirmation that visual tokens remain presentation semantics and never
  become domain-state sources.

## 11. Unresolved human choices

1. Should Home be a task dashboard with current summaries, or remain a concise
   orientation/guide surface?
2. Should compact Catalogue registration open a dedicated page, a bottom
   sheet, or an inline progressive section?
3. Should Store creation remain in Catalogue during PH01, and if so under which
   secondary label?
4. Should mobile Purchase review be a separate route/step or an in-page mode
   with explicit step indication?
5. Should History use “View in Analytics” for one Purchase and “Analyze
   selection” for multiple Purchases?
6. Should “Market” remain the projection name, or would a more explicit label
   such as “To buy” better match the intended mental model? A change requires
   cross-page and permanent-vocabulary reconciliation.
7. Should the Home page expose developer/documentation links at all in ordinary
   navigation, or move them to PH03 Settings/About?

## 12. Terminal

```text
CYCLE=C11
PHASE=C11-PH01
ROLE=DIDACTIC
BASELINE_VERIFIED=YES
B_REPORT_READY=YES
KANBAN_TRANSITION_PROPOSED=NO
SOURCE_CHANGE_AUTHORIZED=NO
D_E_F_AUTHORIZED=NO
CODEX_AUTHORIZED=NO
NEXT_MAIN_ACTION=Reconcile C11-PH01 A_OPERATIONAL.md, B_DIDACTIC.md and C_DESIGN.md into one J_MAIN_STAGE.md PH01 synthesis.
```
