# E_DDC_STAGE — C11-PH01-S02 Meaning, State and Evidence Contract

> Sequence: FLX-ORD-01
> Role: Main didactic/evidence materialization stage
> Cycle / phase / unit: C11 / C11-PH01 / C11-PH01-S02
> Required branch: `grm-guarded-provisioning-20260727`
> Reconciled Main head: `ec8953fbea4e9a80a712118665c2549a4d21528b`
> Codex starting HEAD: the synchronized D/E/F publication commit pinned by the
> initiation prompt
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Evidence boundary: five-page presentation and comprehension only

## 1. Purpose

Constrain the S02 visual convergence so all five product pages communicate one
coherent model without overstating capability, obscuring current behavior or
turning target-image details into false product truth.

The target PNGs control visual composition. Current application contracts
control meaning.

## 2. Cross-page reading grammar

Every page must answer, in order:

```text
Where am I?
What is this page for?
What context or view is active?
What can I inspect or enter?
What is the next primary action?
What happened, or why is something unavailable?
```

Required semantic order:

1. page noun and one-sentence purpose;
2. active context/view and qualified summary;
3. search/filter/sort or purchase-context controls;
4. primary content;
5. contextual actions;
6. explanation, validation or recovery.

Wide and compact layouts may rearrange geometry but must preserve that reading
order and the same facts.

## 3. Shared language and action hierarchy

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

Keep `Market` as the Lists term in PH01.

Use title case or sentence case consistently. Do not expose methodology codes,
`PIN`, repository terminology, raw exceptions or developer diagnostics in the
ordinary five-page experience.

Action hierarchy:

- one dominant next action per active task region;
- secondary actions are outlined or low-emphasis;
- destructive actions use red only when already functional and require their
  existing confirmation/guard;
- unavailable actions appear only when their dependency is useful to explain;
- icon-only actions have visible tooltips and accessible names;
- text links are not styled as primary buttons.

## 4. Color and surface meaning

Use:

- forest green for current, selected, available, confirmed and primary;
- purple for explanation, comparison or deferred-context handoff;
- orange for warnings and approaching thresholds;
- red for failure or destructive meaning;
- neutral borders/backgrounds for structure.

Do not use:

- green to imply a successful operation that was not established;
- purple as a competing primary-action color;
- orange/red as decoration;
- color alone to distinguish state.

One card equals one meaningful group. Nested cards must not make hierarchy
harder to understand.

## 5. Home comprehension contract

Home must answer:

```text
What is Markei for now?
What can I do next?
Where can I inspect what I registered?
```

Required meaning:

- Purchases are registered locally first;
- Lists are estimates derived from registered Purchase history;
- Catalogue contains reusable Products and Stores;
- History contains registered Purchases;
- the primary action is `Register purchase`.

Required secondary routes:

```text
View lists
Browse catalogue
Open purchase history
```

Do not claim:

- scheduled automatic updates;
- functional Household collaboration;
- functional Analytics or Audit;
- absence or presence of current Sync without an authorized projection;
- developer-held behavior telemetry;
- public release or GitHub project status as a core user task.

## 6. Lists comprehension contract

The views remain:

```text
Storage
Shortage
Market
All
```

They are derived projections, not recorded physical locations.

Required distinctions:

- Product identity versus cycle estimate;
- projection-empty versus filtered-empty;
- Product-level `Not enough history` versus empty page;
- approximate next-purchase total versus recorded Purchase total;
- Market membership versus a more specific item status;
- search changes visible membership;
- sort changes only order;
- read Retry repeats only the Lists projection read.

Every forecasted date, remaining period or total must be visibly qualified with
`Estimated`, `Approximate`, `Expected` or equivalent wording.

The compact three-status row and separate total surface must retain complete
labels at 200% text scale; stacking is preferable to truncation.

## 7. Catalogue comprehension contract

Catalogue is the reusable Product and Store library.

Required distinctions:

- Product code is user-visible identity, not the local Product UUID;
- Product/Brand describe the reusable entry;
- packaged/bulk and quantity/unit are stable Product facts;
- search filters the already loaded collection;
- sort changes order only;
- selected Product and viewed Product detail refer to the same stable Product;
- `Similar product found` is a decision point, not an automatic rejection;
- `Create anyway` remains explicit and subordinate;
- Stores are supporting Catalogue data, not Product categories.

Do not display target-image columns for latest price, price change, remaining
cycle or latest Purchase because the current Catalogue result does not own
those facts.

Do not call a generic Product glyph a photograph or imply that a network image
was found.

## 8. History comprehension contract

History represents registered Purchases.

Required distinctions:

- filtering narrows the already returned history collection;
- selecting Purchases controls contextual actions;
- opening/expanding a Purchase controls detail inspection;
- CSV export and PDF sharing act on the current selection;
- total is a recorded Purchase total;
- Product price change belongs to loaded Purchase detail and may be unavailable;
- read Retry repeats only History loading.

If local presentation filters are implemented:

- default is All;
- active filters are visible;
- filtered-empty differs from first-use empty;
- clearing filters does not clear Purchase selection unless required to avoid a
  hidden selection, in which case the UI must state the change;
- Store, Person and Payment labels come only from returned entries;
- date labels are locale-readable and time zones are not misrepresented.

`Move to Analytics` remains unavailable in PH01. Edit and Delete remain
unimplemented. Their presence must not imply functionality.

## 9. Purchase comprehension contract

Purchase is an explicit edit → review → register flow.

### Edit

The user must be able to identify:

1. Purchase context: Store, date, time and optional local labels;
2. Product choice: existing stable Product or new Product draft;
3. quantity and price facts;
4. staged-item action;
5. current staged items and total;
6. `Review purchase`.

### Review

The review surface is read-only except for:

- `Back to edit`;
- `Register purchase`.

It must repeat Store/date/time, optional references, staged items and total so
the user can verify the command before registration.

### Feedback

Preserve the meanings of:

- input validation failure;
- Product similarity warning;
- Product selection invalidation/conflict;
- registration known success;
- registration known failure;
- registration result unknown.

Unknown registration result must continue to preserve the draft and direct the
user to check History before retrying. It must not be restyled as ordinary
failure or automatic Retry.

Remove the stale statement that synchronization is not active. Replace it with
truthful local-first wording that says only what Purchase itself establishes.

## 10. State language

All applicable pages require distinct presentations for:

| State | Required meaning |
| --- | --- |
| Loading | name the exact local content being loaded |
| First-use empty | state what has not been registered and offer a valid next route |
| Filtered empty | state that current search/filter produced no visible result |
| Insufficient history | keep the Product visible and qualify the unavailable estimate |
| Error | name the failed read/operation without inventing cause |
| Partial/unavailable | preserve available facts and qualify the missing ones |
| Selection | name or count what contextual actions will affect |
| Review | distinguish reversible editing from final registration |

A page-read Retry must say what it re-reads. It must never resemble Sync,
Recovery or unknown-outcome Retry.

## 11. Responsive comprehension and accessibility

Evidence must cover:

- one semantic reading order across wide/medium/compact;
- 200% text scale without loss of content;
- minimum `48 dp` interactive hit targets;
- visible focus for keyboard users;
- accessible names for navigation, disclosures and icon-only actions;
- independent announcement of selected destination, selected Lists view,
  selected records, filter changes, review state and feedback changes;
- no color-only status;
- no mobile horizontal page overflow;
- tables replaced by cards where reading order would otherwise collapse;
- compact More remains discoverable and labels reserved destinations honestly.

Automated widget/semantics evidence is not human Narrator, TalkBack, real-device
or visual-parity evidence.

## 12. Reference-image interpretation guard

The images authorize:

- hierarchy;
- relative density;
- layout grouping;
- table/card composition;
- responsive ordering;
- compact action placement;
- visual vocabulary.

They do not authorize:

- Product photographs or image ingestion;
- category data;
- unsupported Store/Person/Payment filters;
- latest Product price or price-change fields in Catalogue;
- Analytics calculations or movement;
- Household behavior;
- edit/delete behavior;
- remote lookup;
- telemetry;
- changed Sync/Settings/Audit/Closure behavior.

When a pictured feature is unsupported, omit it cleanly. Do not render a
decorative enabled control with no action.

## 13. Evidence and promotion ceiling

Codex may report:

```text
implemented
test-validated
build-validated
visually inspected on available host
host-unvalidated
partial
blocked
```

Codex must not report:

- exact pixel parity from source inspection;
- human Windows or Android acceptance from widget tests;
- PH01 completion when any of the five pages remains partial;
- functional Analytics, Audit or Household;
- Settings or Closure migration;
- Product image support;
- provider, Sync, production or multi-user acceptance;
- learner/KANBAN maturity.

No KANBAN transition is authorized.

## 14. Required H report

`H_DDC_CODEX.md` must report:

1. cross-page vocabulary and action hierarchy implemented;
2. wording changed or removed per page;
3. state distinctions implemented per page;
4. reference-image features intentionally omitted and why;
5. table/card reading-order parity;
6. accessible labels, focus and semantics assertions;
7. 200% text-scale assertions and limits;
8. automated evidence;
9. build evidence;
10. visual-host evidence;
11. human evidence not performed;
12. any remaining misleading copy or comprehension risk.

Required terminal:

```text
CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S02
FIVE_PAGE_MEANING_PARITY=PASS | PARTIAL | FAIL | BLOCKED
TRUTHFUL_CAPABILITY_LANGUAGE=PASS | FAIL | BLOCKED
STATE_DISTINCTIONS=PASS | PARTIAL | FAIL | BLOCKED
COLOR_ONLY_MEANING=NO | YES
UNSUPPORTED_REFERENCE_CLAIMS=NONE | PRESENT
KANBAN_TRANSITION=NONE
HUMAN_ACCESSIBILITY_ACCEPTANCE=NOT_PERFORMED
```
