# F_DSN_STAGE — C11-PH01-S01 Responsive Presentation Architecture

> Sequence: FLX-ORD-01
> Role: Main design stage
> Cycle / phase / unit: C11 / C11-PH01 / C11-PH01-S01
> Branch: `grm-guarded-provisioning-20260727`
> Reconciled A/B/C head: `4b1abc01a93351f5910ea8af5001782b59a784f7`
> Codex starting HEAD: the synchronized D/E/F publication commit pinned by the
> seeding prompt
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Architecture boundary: presentation shell, shared visual foundation, Home
> and Lists only

## 1. Accepted architecture

S01 introduces a presentation architecture with this dependency direction:

```text
Flutter/Material primitives
        ↓
semantic design tokens
        ↓
shared presentation components and responsive shell
        ↓
page presentation adapters
        ↓ callbacks / already-classified view data
application ports and domain value types
```

Shared visual code must not depend on repositories, infrastructure,
authentication, Sync coordinators, diagnostic authorities or provider state.

## 2. Stable navigation identity

Replace index-as-identity with a stable destination identifier.

A destination descriptor may own:

```text
id
label
icon
group
compact priority
ordinary-navigation visibility
feature availability
page builder
```

The exact Dart representation is Codex’s bounded implementation choice. The
following invariants are mandatory:

- selection is stored by stable ID;
- feature-gated Closure insertion/removal cannot redirect another selection;
- compact and rail presentations consume one destination registry;
- the More surface is derived from the same registry;
- page builders receive dependencies from `MarkeiComposition`;
- navigation does not instantiate repositories or infrastructure;
- each `IndexedStack` child has stable identity;
- hidden focus/semantics do not leak into the active page.

Retain `IndexedStack` for S01 unless characterization proves an actual blocker.
A state-management or routing-framework migration is not authorized.

## 3. Responsive shell ownership

The shell owns:

- layout-class resolution;
- navigation chrome;
- safe area;
- bounded content canvas and responsive gutters;
- destination selection;
- page title/action slot only when consumed consistently;
- compact More presentation.

Pages own:

- page-specific composition;
- local presentation state;
- table/card field priority;
- contextual controls;
- callbacks into existing application ports.

Application/domain owners retain:

- Product and Purchase identity;
- cycle calculations and projection membership;
- money, quantity and date semantics;
- validation and registration;
- exports;
- Sync, diagnostics and recovery truth.

The semantic thresholds are compact `<600`, medium `600–1023`, wide `>=1024`
logical pixels. Threshold constants belong to presentation design, not page
business logic.

## 4. Token and component boundaries

Tokens belong under `app/design`. Avoid page-local literal spacing, colors and
type sizes when a semantic token exists.

Shared components may cover:

| Family | Responsibility |
| --- | --- |
| Shell | app frame, navigation registry consumption, More surface |
| Layout | bounded content, page header, responsive sections |
| Surface | card, summary tile, section/disclosure panel |
| Controls | search/sort/action group wrappers |
| Data | table frame, mobile record card, key/value group |
| State | loading, first-use empty, filtered empty, error, insufficient history |
| Feedback | semantic banner, status chip |

Components render already-classified presentation models and callbacks. A
component must not infer a Product cycle, query a repository, translate an
arbitrary exception or decide whether an operation is retryable.

## 5. Home boundary

Home remains driven by truthful static content plus navigation callbacks.

It may:

- arrange orientation/task cards;
- invoke stable destination callbacks;
- use shared headers/surfaces.

It may not:

- query provider/Sync/queue state;
- synthesize Household or Analytics facts;
- become a developer telemetry surface;
- instantiate application dependencies.

Changing `home_content.dart` is limited to static presentation descriptors and
copy. If a live summary is desired later, it requires a separately designed
application projection.

## 6. Lists boundary

`ProductListProjectionRepository` remains the sole source of Lists projection
truth in S01.

Recommended internal flow:

```text
selected Lists view + refresh signal
        ↓
one repository projection request
        ↓
page-local presentation adapter
        ↓
search/sort over returned items
        ↓
wide table or compact/medium cards
```

Both collection projections use:

- the same returned item set;
- the same stable Product ID;
- the same qualified cycle classification;
- the same search/sort state.

Search and sort are presentation operations. Adding category, Store or Person
filtering would require new projection facts and is prohibited in S01.

## 7. Reservation boundaries

S01 reserves navigation identity only:

- Analytics: PH02 owns deterministic local/account-scoped query/calculation
  ports and History context handoff.
- Settings: current behavior stays intact; PH03 owns recomposition.
- Audit: PH03 owns durable diagnostic projection and readable operational
  history.
- Closure: existing feature-gated page and all capabilities stay intact.

Audit/Settings must not create independent diagnostic authority. Visual widgets
must not reconstruct Sync truth. No Closure capability is removed, moved or
renamed in S01.

## 8. Reversibility

Implement in this order:

1. characterization tests;
2. semantic tokens with compatibility aliases for existing consumers;
3. stable destination registry;
4. responsive shell;
5. shared layout/state primitives;
6. Home;
7. Lists;
8. reserved destination tests;
9. full regression/build evidence.

Keep old shared component APIs as compatibility wrappers when inexpensive.
Avoid a wholesale rewrite. If a step fails, later steps must remain removable
without touching application/domain state.

## 9. Rejected alternatives

- separate desktop and mobile business controllers or repository queries;
- page-local copies of shell/breakpoint logic;
- full routing or state-management framework migration;
- Product-cycle recomputation in widgets;
- PNG pixel copying that invents unsupported fields/actions;
- dependency addition for convenience;
- Closure migration during PH01;
- Analytics calculations or Audit event modelling during S01.

## 10. Design acceptance

S01 Design evidence passes only when:

- stable destination identity survives feature-gate and width changes;
- one registry feeds rail, bar and More;
- semantic tokens/components are presentation-only;
- Home and Lists consume the shared system;
- Lists table/cards remain two projections of one view state;
- current application/repository ownership is preserved;
- Closure behavior is unchanged;
- later Catalogue, History, Purchase, Analytics, Settings and Audit work can
  reuse the foundation without depending on S01 page internals;
- I reports any architectural deviation or required new owner explicitly.

`I_DSN_CODEX.md` must include the final component/dependency map, new files,
reversibility notes, deviations, and residual risks.
