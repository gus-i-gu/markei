# E_DDC_STAGE — C11-PH01-S01 Meaning and Evidence Contract

> Sequence: FLX-ORD-01
> Role: Main didactic/evidence stage
> Cycle / phase / unit: C11 / C11-PH01 / C11-PH01-S01
> Branch: `grm-guarded-provisioning-20260727`
> Reconciled A/B/C head: `4b1abc01a93351f5910ea8af5001782b59a784f7`
> Codex starting HEAD: the synchronized D/E/F publication commit pinned by the
> seeding prompt
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Evidence boundary: visual foundation, shell, Home and Lists only

## 1. Purpose

Constrain the S01 implementation so the new visual system improves
comprehension without overstating capability, erasing distinctions or turning
the reference PNGs into false product truth.

The five PNGs are compositional references. They do not authorize unsupported
data, actions, images, categories, filters, telemetry or later-phase behavior.

## 2. Shared page language

S01 establishes this reading order:

1. stable page noun and one-sentence purpose;
2. optional qualified summary;
3. search/filter/sort controls;
4. primary content;
5. contextual actions;
6. explanation or safe recovery disclosure.

Across widths, the semantic order remains the same even when controls stack or
tables become cards.

Action hierarchy:

- one visually dominant next action;
- secondary actions are tonal/outlined;
- dangerous/destructive actions are absent from S01;
- disabled actions are absent unless their presence teaches a real dependency;
- icon-only controls have an accessible name and pointer tooltip.

## 3. Color and surface meaning

- Green: current, available, selected, confirmed or primary action.
- Purple: secondary explanation, guidance, comparison or future-context
  handoff.
- Warm neutral/cream: page ground.
- Warm/white surface: grouped content.
- Orange: qualified warning.
- Red: error or destructive/failed meaning.

Text and iconography must carry every meaning without color. Green must not
invent success; purple must not become a second primary-action color.

## 4. Navigation vocabulary

Use ordinary product labels:

```text
Home
Lists
Purchase
Catalogue
History
Analytics
Settings
Audit
```

Do not expose `PIN` maturity terminology to ordinary users. `Catalogue` is the
page/library; `Product` is an entry. `Audit` is not `Closure`.

During S01:

- Analytics copy says it is planned for C11-PH02 and does not imply current
  calculations or telemetry.
- Audit copy says it is planned for C11-PH03 and does not imply current
  diagnostic migration.
- Settings remains current and functional.
- Closure remains feature-gated and unchanged.
- Household remains clearly planned and secondary.

## 5. Home comprehension contract

Home must answer:

```text
What is Markei for now?
What can I do next?
Where do I inspect results?
```

Required meaning:

- purchases are registered locally first;
- Lists are estimates derived from Purchase history;
- Catalogue contains reusable Products;
- History contains registered Purchases;
- the primary next action is `Register purchase`.

Do not claim:

- Sync is future work;
- Sync/provider state without a current projection;
- Household is functional;
- Analytics or Audit is functional;
- developer usage telemetry exists;
- public distribution/release status as a primary user task.

Secondary navigation actions should use `View lists`, `Browse catalogue` and
`Open purchase history` or equally clear wording.

## 6. Lists comprehension contract

The four terms remain:

```text
Storage
Shortage
Market
All
```

They are projections, not recorded inventory locations.

Required distinctions:

- recorded Product identity versus derived cycle estimate;
- projection-empty versus search-filtered empty;
- Product-level `Not enough history` versus an empty page;
- approximate next-purchase total versus a recorded total;
- `Market` projection membership versus an `Expected ended` item status;
- Search changes visible membership; Sort changes order.

All forecasts must visibly use `Estimate`, `Approximate` or equivalent
qualification. Money includes currency. Dates remain locale-readable and
estimated dates are marked as estimated.

Safe Retry means re-reading Lists only. It must not resemble automatic Sync,
unknown-outcome Retry or recovery.

## 7. Readable-state contract

Required states:

- loading: name what is loading;
- first-use empty: explain what is absent and point to Purchase when useful;
- filtered empty: say that the current search produced no result and offer
  clear search removal;
- insufficient history: keep the Product visible and explain why an estimate
  is unavailable;
- error: name the failed Lists read, state that local data is unchanged and
  offer one explicit read Retry;
- partial/unavailable: keep available facts while qualifying unavailable
  derived detail.

User input, selected view and search/sort state should survive safe Retry and
responsive resizing.

## 8. Accessibility evidence

Implementation evidence must cover:

- usable reflow at 200% text scale;
- minimum 48-logical-pixel touch targets where controls are interactive;
- accessible names for navigation and icon-only actions;
- visible keyboard focus;
- semantic reading order matching page anatomy;
- independent announcement of selected destination, selected Lists view and
  state changes;
- no horizontal page overflow at representative compact, medium and wide
  widths.

Automated semantics/widget evidence is distinct from human Windows Narrator,
Android TalkBack, real device and visual-comparison evidence. The latter remain
not performed in this Codex unit.

## 9. Evidence and promotion ceiling

Codex may report:

```text
implemented
test-validated
build-validated
host-unvalidated
blocked
```

Do not report:

- pixel parity from source inspection;
- Windows/Android human acceptance from widget tests;
- PH01 completion from S01;
- Analytics, Settings/Audit redesign or Closure migration;
- KANBAN/learner maturity change;
- provider, Sync, production or multi-user acceptance.

No KANBAN transition is authorized.

## 10. Required H report

`H_DDC_CODEX.md` must name:

- wording and labels changed;
- stale or misleading copy removed;
- state distinctions implemented;
- navigation terms implemented;
- color semantics represented without color-only meaning;
- accessibility assertions added and their limits;
- copy/behavior requested but not implemented;
- exact automated, build and human evidence boundaries.
