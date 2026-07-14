<!-- TEMPORAL_MARKER:C09-S02-ENTRY-2026-07-14 -->
> Cycle 09 Sprint 02 Didactic staging. Project-language evidence only; no learner-maturity or canonical-memory promotion.

# C09-S02 Didactic Semantic and UX Contract

> Role: Didactic and UX-language lead
> Sequence: investigative staging for Main reconciliation
> Branch: `intermid-cycle-recovery`
> Starting boundary: `c67d573f1335ffd55c659a9ee795982ca72c2c32`
> Inspected remote head: `54f90934196491f573cadeed52516521737c54e5`
> Implementation baseline: `e37cb700feeca4001cc7835b584c46bb81926af3`
> Visual evidence: images 6–10 current; images 1–5 proposed direction only

## 1. Authority and evidence

This file stages visible terminology, interaction semantics, recovery language and test expectations. It does not select storage/timezone architecture, change source/schema, promote KANBAN maturity, or make mockups pixel authority.

Evidence classes:

- current screenshots: what the present interface communicates visually;
- handwritten Flutter source: implemented controls, copy and interaction paths;
- widget/application tests: bounded executable behavior, not manual/platform acceptance;
- target mockups: proposed hierarchy, palette and behavior requiring Main acceptance;
- project evidence: never learner explanation, transfer or mastery evidence.

Current implementation gaps retained as incomplete: editable Purchase occurrence, accessible Catalogue selection, exact visible lookup, full Product details, relational Lists presentation, BULK unit pricing, specific recovery messages, adaptive hierarchy and native sharing.

## 2. Global interaction-language rules

Every page/state should answer: where am I; what can I do; what is selected; what happened; what remains safe; what should I do next.

Preferred state vocabulary:

| State | Preferred visible pattern | Avoid |
| --- | --- | --- |
| Loading | `Loading [content]…` | silent blank surface |
| Empty | `No [records] yet.` + first useful action | failure styling |
| No match | `No Products match this search.` + clear/change search | `Empty` |
| Success | specific completed operation, e.g. `Purchase registered locally.` | generic `Done` |
| Warning | consequence + reversible next action | warning by color alone |
| Validation | field + reason + correction | `Invalid input` |
| Failure | failed operation + known reason + retained state + next action | raw exception/generic retry |
| Unknown outcome | `Markei could not confirm whether…` + safe verification route | definite success/failure |
| Disabled | label + `Planned`/`PIN` where relevant + explanation | enabled-looking dead control |

Accessibility: announce state changes; move focus to the first invalid field or feedback summary without destroying entered data; never encode state only by color/icon. Compact layouts keep the message adjacent to its owning section and allow wrapping.

## 3. Navigation and responsive composition

Canonical destination labels: `Home`, `Lists`, `Purchase`, `History`, `Catalogue`, `Analytics`, `Household`, `Guide`, `Documentation`, `Settings`. `Analytics (PIN)` and `Household (PIN)` are visible future destinations, not implemented features.

Preferred behavior:

- desktop: persistent labelled navigation rail; active destination has shape, icon, text and semantic selected state;
- mobile: bottom navigation contains only accepted primary destinations that fit; remaining destinations use an explicit `More` surface;
- page title repeats the current destination and does not substitute a task label for it;
- active destination survives responsive transitions; focus order follows visual order;
- disabled/PIN destinations remain distinguishable from loading or permission failure.

Alternative considered: all ten destinations in one rail/bar. Rejected as preferred language because it flattens primary, secondary and future destinations and risks overflow. Main must freeze which mobile destinations are primary.

Recovery copy: `This destination is planned and is not available in this beta.` Evidence: widget tests at narrow/wide breakpoints, large text, keyboard navigation, selected-state survival and overflow absence; manual screen-reader/touch-target checks.

## 4. Purchase date and time

Visible contract:

```text
Purchase date   dd/mm/yyyy
Time            HH:mm
```

Place both immediately after Store. Default to the user’s current local date/time when a new draft starts; communicate that they are editable before registration. Review and History show `dd/mm/yyyy · HH:mm` under the Purchase heading.

Preferred helper: `Date and time of this Purchase.` Alternative `Purchased at` is compact but less explicit in forms. Do not call the value `Registration time` unless it truly records submission rather than occurrence.

Validation/recovery:

- `Enter the date as dd/mm/yyyy.`
- `Enter a valid time from 00:00 to 23:59.`
- `This date and time do not exist. Check both fields.`
- Ambiguous numeric input must not be guessed; keep the draft and focus the field.

The UI may display local time while persistence uses another representation, but wording must not decide UTC conversion, timezone retention or daylight-saving policy. Main/Design must freeze occurrence semantics separately.

Accessibility/compact: native-accessible picker plus editable text; labels remain visible; date/time stack on narrow screens. Evidence: default-now under controlled clock, edit/review/register/History consistency, invalid dates/times, locale rendering, keyboard entry, screen reader and file-backed reopen. Unresolved: timezone metadata, future dates, precision and whether seconds are discarded.

## 5. Product selection, lookup and details

Preserve:

```text
internal Product ID != visible Product code != exact identifying-field set
exact identity != advisory similarity
select Product != open Product details != add staged Item
```

Preferred actions:

| Context/action | Visible wording and behavior |
| --- | --- |
| Catalogue row click/tap | select/highlight row; do not silently add to Purchase |
| Catalogue primary action | `View Product details` |
| Purchase result primary action | `Use existing Product` |
| Purchase next action | `Add staged Item` after Item values are complete |
| Pointer double-click | shortcut to the context’s declared primary action |
| Keyboard | arrows/tab focus; Space selects; Enter invokes declared primary action |

Alternative: click opens details immediately. Acceptable only if selection has a separate explicit control and state. Double-click is optional convenience, never the only route.

Lookup labels:

- `Find by Product code` — exact visible-code lookup;
- `Find by Product details` — exact normalized identifying fields;
- `Search Catalogue` — clearly described broad filtering only.

PACKAGED exact details: Name + Brand + Package quantity/unit. BULK: Name + Brand. A similar spelling produces `Similar Product found` with `View details` and a carefully scoped create-new route. Exact collision: `This Product already exists. Use the existing Product or view its details.` Never offer `Create anyway` for exact collision; never merge automatically.

Selection feedback: visible selected row, `Selected: [code] · [name] · [brand]`, and an enabled primary action. Compact: details open as route/sheet; desktop may use a detail pane. Error copy: `Products could not be loaded. Your Purchase draft is unchanged. Try again.` Evidence: tap/click/double-click/keyboard equivalence, exact code, exact fields, advisory similarity, collision, focus/selection persistence and screen-reader labels. Unresolved: Product-code nullability and whether Catalogue selection transfers into Purchase or only scopes details.

## 6. Lists: derived history, never manual inventory

Page helper: `Lists are personal estimates derived from your registered Purchase history. They are not manually created inventory counts.`

| Status | Preferred wording | Alternative considered |
| --- | --- | --- |
| Storage | `Estimated available` | `Storage` as tab label |
| Shortage | `Ending soon` | `Shortage` where established |
| Market | `Expected ended` | `Market` as tab label |
| unavailable | `Not enough history` | `Cycle unavailable` |

Each Product may show, when supported: Product/Brand/code; latest Purchase; amount bought and unit; latest unit price; expected next Purchase; remaining time; approximate replenishment total; evidence-limiting label `Based on your history`/`Estimate`.

Never state `remaining` as measured stock. Prefer `Estimated time remaining` and `Expected next Purchase`. `Approximate total` must identify included Products and currency; absent/incompatible price history yields an unavailable explanation rather than zero.

Filters may be labelled `Store`, `Person`, `Product` and `Category` only where the query actually supports them. `All` means all derived statuses, not all Catalogue Products; a Catalogue Product with insufficient compatible history belongs in `Not enough history` when the selected view supports it.

Compact: desktop table becomes mobile Product cards without dropping status/evidence limits. Errors: `Lists could not be calculated. Your registered Purchases are unchanged. Try again.` Evidence: zero/one/multiple compatible Purchases, relation refresh after registration, each filter, boundary dates, units/currencies, unavailable state and table/card semantic parity. Unresolved: accepted Shortage/Market labels, compatible-history rule, thresholds, category support and total algorithm.

## 7. Person and Payment Method identity

Both are optional local organizational labels. `Not assigned` must always remain selectable and must never block Purchase registration. A Payment Method stores no credentials.

Alternatives:

| Model | Usability/privacy | Migration/collision/editing |
| --- | --- | --- |
| full opaque UUID + nickname | exact but noisy; exposes device-local identifier unnecessarily | stable; no user collision; nickname editable |
| generated short code + nickname | readable stable reference; modest metadata exposure | needs durable mapping, collision policy and legacy backfill |
| user-defined code + nickname | memorable but burdens registration | requires uniqueness, correction and migration policy |

Preferred pending Main decision: generated short visible code + nickname, e.g. `P-004 · Alex`, while keeping UUID internal. This is a recommendation, not current truth. If no visible-code migration is accepted, show nickname alone in ordinary selectors and reserve full UUID for diagnostics—not a misleading truncated UUID.

Consistent labels:

- Settings collections: `People`, `Payment Methods`;
- record field: `Nickname` with `The label you recognize.`;
- Purchase selectors: `Person (optional)`, `Payment Method (optional)`, default `Not assigned`;
- History/export: `[code] · [nickname]`, adding `Archived` without losing the historical label;
- lifecycle actions: `Archive`, `Restore`; statuses `Active`, `Archived`.

Validation: `Enter a nickname.` / `This active nickname is already in use. Choose another or open the existing record.` Preserve form and explain archive conflicts. Accessibility/compact: never rely on struck-through text/color; allow wrapping and search by code/nickname. Evidence: optional registration, archive/history/export resolution, rename stability, collision/backfill and screen-reader labels. Unresolved: identity model, code format, nickname uniqueness among archived rows, rename audit expectations and diagnostic UUID visibility.

## 8. BULK pricing

Preserve:

```text
Amount bought + Unit + Price per unit → Calculated line total
Package quantity and Packages bought apply to PACKAGED, not BULK
```

Preferred labels: `Amount bought`, `Unit`, `Price per kg`/`Price per L`/unit-derived label, `Calculated line total`. Alternative generic `Price per unit` needs an adjacent explicit unit. Never label manually entered `Line total` as price per unit.

Default recommendation: derived total is read-only. A manual override requires a separately accepted product rule, explicit `Override calculated total`, original calculation retained for review, and an explanation of analytic consequences.

Helper: `Line total = amount bought × price per unit. Markei rounds to the nearest cent.` Exact rounding mode remains a Design contract; do not silently promise it before acceptance.

Validation/recovery:

- `Enter the amount bought using comma or point for decimals.`
- `Choose the unit that matches the Product.`
- `Enter a price per [unit] greater than zero.`
- `Markei could not calculate the line total. Check amount, unit and price.`

Compact: amount/unit share a responsive group only when labels remain visible; calculated total follows immediately and updates accessibly without disruptive announcements. Evidence: kg/g/L/ml/un, comma/point, conversion policy, zero/negative/large values, rounding boundaries, edit/review/register/History consistency. Unresolved: canonical price unit, conversions, override permission and persisted authoritative values.

## 9. Aesthetic communication contract

Target direction: dark green for primary navigation/actions; lavender for selected, secondary or informational surfaces; cream canvas with white content surfaces; status colors with text/icon; cards and summaries for grouped tasks; tables on wide layouts and equivalent cards on mobile; hierarchy through spacing, typography and grouping; concise helper copy; visible focus, selection and disabled states.

Meaning-bearing features: active/selected emphasis, status chips, grouping, action priority, table/card equivalence, readable feedback, contrast, focus order and responsive information priority. Decorative features: exact cream/lavender shades, corner radius, shadows, illustration and ornamental spacing. Decorative choices cannot carry meaning alone.

Alternative all-standard Material styling remains technically viable but does not communicate the proposed domain hierarchy. Exact tokens are Design/Main decisions. Evidence: contrast checks, color-blind/state-without-color review, 390×844 and desktop widths, large text, keyboard focus, touch targets, long translations, loading/empty/error/selected/disabled snapshots and manual comparison to numbered mockup intentions.

## 10. Main decisions and handoff

Main must resolve before D/E/F:

1. mobile primary/overflow navigation and disabled/PIN placement;
2. Purchase occurrence semantics, timezone/storage boundary and edit rules;
3. Product row selection/details/transfer semantics and double-click shortcut;
4. Product-code nullability and exact-search presentation;
5. Lists labels, compatible-history rule, thresholds, filters and totals;
6. Person/Payment visible identity model and migration/collision policy;
7. BULK canonical unit price, rounding, conversions and override policy;
8. adaptive details/table/card breakpoints and accepted visual tokens;
9. recovery guarantees for retained drafts and unknown registration outcomes;
10. widget, manual desktop/mobile and accessibility acceptance matrix.

Disposition:

```text
accepted for staging: terminology distinctions and evidence limits
recommended: visible wording and interaction model above
requires Main acceptance: product decisions and mockup-derived direction
implemented only where source/tests prove it: current e37cb70 behavior
partial: errors, exact lookup, BULK pricing, Product details, Lists presentation, sharing
learner maturity: unchanged; no learner evidence claimed
deferred: auth/API/Neon/sync/release, registered Purchase mutation, manual Lists
```
