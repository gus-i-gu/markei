# C_DESIGN — C11-PH01 Visual System and Core-Page Convergence

> Role: Design Chat [D]
> Cycle / phase: C11 / C11-PH01
> Date: 2026-07-30
> Repository / branch: `gus-i-gu/markei` / `grm-guarded-provisioning-20260727`
> Inspected remote HEAD: `861c27fdaf6ade2093d481af312d27ff895b8dc0`
> Required baseline: `861c27fdaf6ade2093d481af312d27ff895b8dc0`
> Authority: Design investigation and Main handoff only
> Writable surface: `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
> Status: COMPLETE PH01 DESIGN REPORT — NO SOURCE, D/E/F, CODEX, R07 OR GCM04 AUTHORITY

## 1. Recovered state and evidence boundary

PRI-D and PMC-01 confirm this chat as Design [D]: it owns architectural interpretation, responsibility boundaries, dependency direction, invariants, alternatives, reversibility and design risks. The only active writable surface is this temporary C report. Permanent Design memory, source, methodology, Main continuity, D/E/F and Codex evidence remain prohibited.

The explicit branch resolved to the required SHA. Comparison from `861c27f` to the branch was `identical` (ahead 0, behind 0); no default or older branch supplied evidence.

Recovered direction:

- Cycle 10 is closed at GCM03 two-Device development scope.
- C11 is in fresh A/B/C investigation; source authority is inactive.
- PH01 owns responsive foundations and the five core-page redesigns.
- PH02 owns functional local/account-scoped Analytics.
- PH03 owns mandatory Settings and Audit, Closure disposition and removal of Closure from ordinary navigation.
- C12-PHASE02 retains GCM04, multiple-user assays and R07 reassessment.

Evidence inspected: AGENTS, INDEX, PROMPT_COLLECTION (PRI-D/PMC-01), 00, 06, current Design checkpoint, latest C11 Main preparation in J, ALT_DEV 15.1–15.5, prior C report, all five target PNGs, named Flutter shell/theme/component/page/composition files, and the minimal Analytics registry. `I_DSN_CODEX.md` was not required: PH01 asks for current structure and the named source supplied it. No operational execution or visual parity is claimed.

## 2. Current UI topology

`MarkeiApp` owns navigation, page construction and a cross-page integer refresh signal inside one stateful root. At width >=600 it renders a scrollable labelled `NavigationRail`; below 600 it renders Home, Lists, Purchase and History plus a More sheet. Destination identity is positional. Pages live in an `IndexedStack`.

Current destinations mix stable product areas, planned placeholders, informational pages and a feature-gated native Closure page. Analytics and Household are disabled placeholders. Settings is present. Audit does not yet exist.

`MarkeiComposition` constructs application repositories, account/device scope, native authentication, enrollment, Sync, diagnostics and recovery coordinators. This is an application composition boundary and must not migrate into visual widgets.

The theme currently owns five colors and a small set of Material themes. Shared widgets currently comprise `MarkeiCard`, `MarkeiStatePanel` and `MarkeiStatusChip`. Most pages directly compose raw Material widgets and local private components.

The five pages already delegate business work to application/repository ports, but their presentation composition is page-local:

- Home renders static `homeCards`.
- Lists requests a transient account-scoped projection and switches Storage/Shortage/Market/All.
- Purchase owns dense draft interaction state while registration/catalogue/reference facts remain application-owned.
- Catalogue uses catalogue query/mutation boundaries.
- History uses purchase-history/export boundaries.
- Closure currently combines account/session actions, Sync, diagnostic evidence, recovery controls and build provenance.

Architectural debt: positional navigation, shell/page construction coupling, a global refresh counter, duplicated spacing/state presentation, monolithic Purchase/Closure presentation, and no shared responsive projection contract.

## 3. Proposed responsive shell

Introduce a presentation-only shell model with stable destination identifiers rather than array positions. The registry should describe label, icon, ordinary-navigation visibility, compact priority and page builder. It must reserve `analytics`, `settings` and `audit` now without implementing their PH02/PH03 internals.

Recommended destination groups:

1. Core: Home, Lists, Purchase, Catalogue, History.
2. Insight: Analytics (reserved).
3. Administration: Settings and Audit (reserved).
4. Support: Guide and Documentation.
5. Planned/feature-gated: Household, outside primary PH01 emphasis.

Wide layout should use a persistent labelled rail/sidebar and a bounded content canvas. Compact layout should retain four direct destinations plus More; Catalogue, Analytics, Settings and Audit remain discoverable in More. Destination IDs—not indexes—must preserve selection when feature gates or ordering change.

Use breakpoint semantics rather than one magic width:

- compact: single-column page, bottom navigation, cards and stacked actions;
- medium: navigation rail, bounded content, adaptive two-column sections where safe;
- wide: extended rail/sidebar, desktop tables, summary/action bands and optional supporting panes.

Exact thresholds are an implementation choice to validate against available widths and text scaling; Design does not canonize 600 px. The shell owns navigation chrome, safe area, page title/action slot, content width and route selection. Pages own page-specific layout. Domain/application layers own truth and commands.

## 4. Shared token and component model

Token ownership belongs under `app/design`; components consume semantic tokens without importing domain repositories.

Recommended token families:

- semantic colors: primary/positive green, insight/accent purple, warning, danger, information, neutral ink, warm canvas and elevated surface;
- type roles: display, page title, section title, body, label, metadata and numeric emphasis;
- spacing scale, radii, borders/elevation, icon sizes, control heights;
- content widths and responsive gutters;
- motion/focus/disabled-state rules.

Avoid page-specific literal colors and one-off font sizes. Semantic status colors must never determine meaning alone.

Recommended shared component taxonomy:

| Family | Responsibility |
| --- | --- |
| Shell | app frame, destination model, page header, compact More surface |
| Layout | bounded content, responsive section/grid, desktop/mobile projection switch |
| Surface | card, summary tile, section panel, disclosure panel |
| Controls | filter bar/sheet, segmented selector, search, action group |
| Data | desktop table frame, mobile record card, selection bar, key/value group |
| State | loading skeleton/progress, empty, error, validation, partial/insufficient-history |
| Feedback | semantic banner, status chip, confirmation surface |
| Detail | expandable record/detail pane and metadata rows |

Shared components accept already-classified presentation data and callbacks. They must not query repositories, infer Sync outcomes, rebuild Analytics, or translate raw exceptions independently.

## 5. Five-page recomposition map

| Page | Desktop composition | Compact composition | Preserved owner |
| --- | --- | --- | --- |
| Home | welcome header; two-column informational cards; wide “how it works” and developer/support rows | ordered single-column cards with concise copy | existing `home_content`; no invented telemetry or household facts |
| Lists | view tabs; filter/sort/search/action band; summary tiles; selectable table; explanatory disclosure | view selector; summary cards; filter sheet; product cards and detail disclosure | `ProductListProjectionRepository`; projection remains transient/rebuildable |
| Purchase | purchase-context band; find/select product; staged-item editor; classified feedback stack; staged-items table/review | explicit edit→review flow, stacked facts/items, fixed or prominent final action | registration, catalogue queries, local references and existing validation/application failures |
| Catalogue | search/filter/sort/view band; dense product table; registration and similarity panels | search/filter controls, product cards, progressive registration/similarity surfaces | catalogue query/mutation boundaries and stable Product-ID selection |
| History | filter band; selection/action band; expandable purchase rows with detail pane | stacked filters, selectable expandable cards, bottom/flow action group | purchase-history/export boundaries; Analytics handoff only reserved in PH01 |

Desktop tables and mobile cards are two projections of the same page view model and stable record identity. They must not run different queries or compute different business classifications. Shared selection/filter state survives projection changes. Table column policy and card disclosure order belong to presentation adapters; fact derivation remains application-owned.

The PNGs are compositional targets only. Unsupported categories, images, edit/delete actions, totals or telemetry must not be synthesized merely because they appear visually.

## 6. Navigation reservations

PH01 must create or define stable reservations for:

- Analytics: ordinary destination, disabled/placeholder presentation allowed until PH02; no remote telemetry.
- Settings: always-present ordinary destination; current settings behavior remains intact until PH03 recomposition.
- Audit: always-present destination contract; its content can remain an explicit PH03 placeholder until ownership is materialized.

Closure remains untouched and feature-gated during PH01. PH01 must not claim that reserving Audit replaces or relocates Closure capability.

## 7. Provisional Closure capability matrix

| Current capability | Provisional owner | PH01 disposition |
| --- | --- | --- |
| Sign in / Logout | Settings/Advanced | preserve; classify only |
| Enroll or query Device | Settings/Advanced | preserve; separate configuration/lifecycle from observed health |
| Check hosted connection | Settings/Advanced | preserve as user-invoked connection check; last observation may be linked to Audit |
| Ordinary Sync | Settings/Advanced | preserve existing command boundary; do not reconstruct outcome |
| Diagnostics snapshot / Sync overview | Audit | read existing diagnostic authority |
| Local queue counts and actionable events | Audit | present observed local state with evidence boundaries |
| Recent attempts and grouped diagnostic timeline | Audit | primary operation-history surface |
| Device diagnostic summary | Audit, with Settings summary link | Audit owns detailed observations; Settings may show bounded configuration summary |
| Current action result / MKS meaning | Audit | reuse existing registry/diagnostic truth |
| Build provenance | development-only support | keep out of ordinary product emphasis; Advanced/support placement later |
| Retry unknown-outcome submission | unresolved | retain capability and tests; requires Operational/Design decision before ordinary exposure |
| Inspect failed/notApplied recovery | development-only support | preserve outside ordinary navigation pending PH03 authority |
| Recover failed/notApplied candidate | development-only support | preserve gated/manual semantics; do not relocate in PH01 |
| Clear diagnostic history | Audit | user-controlled local history action with confirmation; retention/export policy needed |
| “Native Closure” page/container | deliberate retirement candidate | retire only after every retained capability has a tested owner in PH03 |

Classification is COMPLETE as an inventory and PROVISIONAL as final product disposition. No capability is removed, relocated or reimplemented in PH01.

## 8. Dependency and ownership rules

1. Shell and components depend inward on Flutter presentation primitives and semantic view data.
2. Pages may depend on application ports and domain value types already required for interaction; shared visual widgets must not depend on repositories.
3. Composition creates repositories/coordinators and injects them; navigation does not instantiate infrastructure.
4. Business facts, validation, projections, exports, Sync outcomes and diagnostic categories remain owned by existing application/domain boundaries.
5. Error adapters map typed application failures to presentation models once; widgets render severity, title, message and safe action.
6. Unexpected exceptions remain sanitized and observable; visual widgets must not assign causal truth.
7. Settings can invoke configuration/session commands and display bounded summaries, but cannot become diagnostic authority.
8. Audit reads durable/local diagnostic projections and registry meanings; it cannot create an independent event model.
9. Analytics in PH02 must use deterministic local/account-scoped query/calculation ports. Shared filters and surfaces may be reused, but PH01 must not add calculation behavior.
10. No developer telemetry, remote behavioral collection or UI-derived Sync truth enters the dependency graph.

## 9. Implementation slices and reversibility

Recommended PH01 sequence:

1. Characterization tests: destination reachability, current callbacks, refresh behavior and key page states.
2. Semantic tokens: expand theme while retaining aliases for current colors.
3. Shell registry: stable IDs, grouped destinations and responsive shell behind a reversible presentation boundary.
4. Shared layout/state primitives: bounded content, page header, responsive projection, state panels and action/filter shells.
5. Home recomposition: lowest domain risk; proves shell/card language.
6. Lists recomposition: proves summary/table-card/state patterns without changing projection semantics.
7. Catalogue recomposition: proves data projection, selection and similarity surfaces.
8. History recomposition: proves filters, selection, expandable detail and reserved Analytics action.
9. Purchase recomposition: highest interaction risk; last, with edit/review/registration regressions.
10. Reserved Analytics/Settings/Audit destinations and cross-width/accessibility characterization.

Keep existing repository interfaces and page public constructors stable where possible. Introduce adapters incrementally, preserve old components until all consumers migrate, and avoid a single wholesale rewrite. Each page slice should be independently revertible. No schema, migration, API, provider or domain-model change is justified by PH01 aesthetics.

## 10. Risks, alternatives and tradeoffs

| Risk/choice | Tradeoff and disposition |
| --- | --- |
| One 600 px breakpoint | simple but fragile under text scale/window resizing; use semantic compact/medium/wide policy |
| One widget tree with extensive conditionals | less duplication but unreadable monoliths; share view model/state and use explicit table/card projections |
| Separate desktop/mobile pages | clear layouts but behavior drift; reject separate business controllers/queries |
| Global refresh integer | cheap but broad and implicit; preserve initially, request later bounded invalidation design rather than coupling PH01 to state-management replacement |
| Indexed positional navigation | easy but feature gates shift indexes; replace with stable destination IDs |
| Giant “design system” first | consistency but delays evidence; build only primitives demanded by the five pages and PH02/PH03 reuse |
| Pixel-copying PNGs | quick visual resemblance but invents unsupported behavior/data; treat references as composition vocabulary |
| Moving Closure early | reduces navigation clutter but risks losing authority and recovery controls; prohibit until PH03 ownership/test mapping |
| Purchase first | visibly valuable but highest regression density; stage it after primitives and lower-risk pages |
| Full state-management migration | may improve maintainability but expands scope; reject for PH01 unless Main stages a proven prerequisite |

## 11. Recommendations to Main

1. Accept stable destination identity and a semantic three-layout shell as PH01 architecture.
2. Stage tokens, shell and shared state/data primitives before page-by-page recomposition.
3. Preserve application/repository constructors and business ownership; require characterization tests before visual replacement.
4. Require desktop-table/mobile-card parity tests from one view model.
5. Reserve Analytics, Settings and Audit destinations now, but prohibit their PH02/PH03 functionality.
6. Keep Closure intact and feature-gated throughout PH01.
7. Sequence pages Home → Lists → Catalogue → History → Purchase.
8. Require visual/manual acceptance at representative compact, medium and wide widths without calling it operational validation in Design evidence.

## 12. Dependencies requested from Operational and Didactic

Operational:

- identify supported Windows/Android window sizes, resize/orientation paths and feasible screenshot/golden strategy;
- define build/test commands and regression gates for shell navigation, text scale, keyboard/focus and page workflows;
- measure whether large tables/cards require paging or virtualization before PH01 changes query behavior;
- inventory current test keys and feature-flag behavior, especially Closure.

Didactic:

- establish user-facing terminology for Catalogue/Product, Lists modes, insufficient history, Purchase edit/review and History selection;
- define progressive-disclosure copy for filters, status chips, errors and empty states;
- distinguish Settings configuration, Audit observation and Analytics interpretation;
- verify accessibility wording does not encode meaning solely through color or icons.

## 13. Unresolved decisions

- Exact compact/medium/wide thresholds and maximum content widths.
- Whether medium uses compact cards or reduced desktop tables per page.
- Which four compact destinations remain direct once Analytics/Audit are active.
- Whether Guide and Documentation remain destinations or move under support/settings later.
- Whether Household stays visible as planned during C11.
- Stable presentation-state mechanism after the global refresh signal; no PH01-wide framework migration is presently justified.
- Whether product images are available local assets; references alone do not authorize them.
- Final exposure of Retry/recovery and build provenance.
- Audit export/retention/filter contract and diagnostic-history clearing policy.
- Settings’ exact split between account/session, Sync controls and Advanced diagnostics.
- Analytics filter model and History context-handoff contract, deferred to PH02.
- Keyboard double-click/detail behavior and destructive-action policy where the references exceed current capability.

## 14. PRI-D / PMC-01 terminal

Confirmed role: Design [D].
Current workflow: C11-PH01 fresh functional investigation before Main J and D/E/F.
Authorized scope: inspect architecture and replace only C_DESIGN.
Prohibited: source, permanent Design, methodology, Main files, D/E/F, Codex authorization and operational claims.
Files consulted: prescribed methodology/state/J/ALT/C sources, five PNGs and named Flutter files.
Remaining uncertainty: implementation thresholds, compact priority and final Closure disposition require Main plus O/A evidence.

```text
CYCLE=C11
PHASE=C11-PH01
ROLE=DESIGN
BASELINE_VERIFIED=YES
C_REPORT_READY=YES
CLOSURE_CLASSIFICATION=PROVISIONAL
SOURCE_CHANGE_AUTHORIZED=NO
D_E_F_AUTHORIZED=NO
CODEX_AUTHORIZED=NO
R07_AUTHORIZED=NO
GCM04_AUTHORIZED=NO
NEXT_MAIN_ACTION=Reconcile the completed C11-PH01 A/B/C reports into one append-only J_MAIN_STAGE section.
```
