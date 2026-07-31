# B_DIDACTIC — C11-PH02 Analytics comprehension investigation

> Role: Didactic Chat [A]
> Cycle / phase: C11 / C11-PH02
> Sequence: MSU-02
> Repository: `gus-i-gu/markei`
> Branch: `grm-guarded-provisioning-20260727`
> Inspected remote HEAD: `f6566a407c2215c1ade61444a7f97994994d93f8`
> Date: 2026-07-31
> Writable surface: this file only
> Status: proposed for Main reconciliation

## 1. Recovered state and authority

Cycle 10 is accepted only at the two-Device, one-Account development boundary.
Production, multiple-Account, revocation, outage-recovery, retention and
rebootstrap claims remain deferred. None supplies Analytics authority.

C11-PH01-S01 is implemented and validated at the automated/build boundary. It
established stable destination identity, compact/medium/wide shell behavior,
shared presentation primitives, Home and Lists recomposition, and a reserved
Analytics destination. Human visual, screen-reader, keyboard-only and
real-device acceptance is absent.

C11-PH01-S02 is not materialized on the inspected branch. The branch contains
the synchronized S02 D/E/F packet and repinning continuity, but no later
five-page source/test/G–I implementation. PH01 is therefore classified
`PARTIAL`. PH02 proceeds independently, inheriting only the verified S01
shell/Home/Lists vocabulary and qualifying all other visual inheritance.

This report proposes learner-facing meanings, distinctions, labels, states,
accessibility requirements and evidence gates. It does not select technical
architecture, change KANBAN maturity, authorize charts, or implement source.

## 2. Recovery route and justified deeper reads

Required recovery:

1. `AGENTS.md`
2. `documentation/sketch_notebook/INDEX.md`
3. `methodology/PROMPT_COLLECTION.md` — PRI-A, PMC-01 and MSU-02
4. latest `J_MAIN_STAGE.md` reconciliation
5. `00_PROJECT_STATE.md`
6. latest relevant `05_SESSION_LOG.md` segment
7. active `06_SESSION_SCHEME.md`
8. `didactics/08_CONCEPT_MAP.md`
9. current G/H/I

Deeper permanent read:

- `didactics/08_CONCEPT_MAP.md` was required as the Didactic checkpoint and was
  sufficient. No other permanent Didactic file was needed.

Repository descent was justified because Analytics implementation truth,
field authority, Account scoping, History handoff and test coverage could not
be established from the checkpoint:

- `clients/markei_flutter/lib/app/markei_app.dart`
- `clients/markei_flutter/lib/app/markei_composition.dart`
- `clients/markei_flutter/lib/app/pages/history_page.dart`
- `clients/markei_flutter/lib/application/purchase_history.dart`
- `clients/markei_flutter/lib/domain/purchase/purchase.dart`
- `clients/markei_flutter/lib/domain/catalogue/product.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_database.dart`
- `clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart`
- `clients/markei_flutter/test/app/markei_app_test.dart`

Two guessed test paths were unavailable and were not treated as evidence:
`test/app/history_page_test.dart` and
`test/application/purchase_history_test.dart`.

## 3. PH01 evidence classification

| Evidence class | Classification | Evidence and limit |
| --- | --- | --- |
| S01 implementation | validated | `1c7df53c095f4e7c1d85f278ba16c21fd95b25e6`; shell, Home and Lists only |
| S02 five-page implementation | absent | no descendant source/test/G–I materialization after S01 |
| Automated checks | validated | focused/full Flutter tests and analysis reported in G/H/I for S01 |
| Build checks | validated | Windows release and Android debug builds reported in G/H/I for S01 |
| Rendered reference parity | absent | PNGs were composition references; no approved golden/pixel boundary |
| Accessibility automation | validated | breakpoint and Home 200% text-scale widget evidence only |
| Screen-reader/keyboard/real-device | absent | Narrator, TalkBack, keyboard-only and real-device evidence not performed |
| Human acceptance | absent | no recorded Windows/Android human acceptance |

PH01 conclusion: `PARTIAL`. Analytics may inherit the validated S01 layout
classes, content canvas, page header, state panel, summary surface, calm
green/purple/neutral semantics and equivalent wide/compact information rule.
Catalogue, History and Purchase visual convergence is unavailable and must not
be described as inherited.

## 4. Analytics current state of union

Analytics is implemented as a reserved destination and reserved page. Its copy
correctly states that no calculation or telemetry is active. No Analytics
card, calculation, evidence matrix, filter, History context handoff or
Analytics-specific test exists.

Current local evidence is accepted as the only PH02 truth source:

- composition supplies one active `AccountId`;
- recent Purchase and Purchase detail reads filter by that Account;
- Product and Store records are Account-scoped;
- Purchase details expose Product, Brand, Store, optional Person, optional
  Payment Method, quantity/unit and line total;
- Purchase occurrence time is distinct from insertion and Sync time;
- Purchase total is a Purchase-level stored result;
- an existing Product price comparison derives compatible unit price and a
  two-observation percentage change.

Current limitations:

- `listRecentPurchases` is limited to 50, so it cannot supply the required
  complete matrix;
- `purchased for` is absent;
- `promotion` is absent;
- unit price is derived, not a stored fact;
- current History handoff is disabled;
- current price comparison is Product-specific and does not implement the
  retained Analytics constitution.

## 5. Retained Analytics constitution

Analytics means a deterministic, local, Account-scoped way to ask a factual
question of recorded Purchase evidence and inspect the rows supporting the
answer.

Each card has:

- exactly one determinant: Product, Purchase, Store or Time;
- one or more relational variables;
- exactly one operation: Sum, Mean, Difference or Percentage;
- optional conditions, including Time;
- an explicit selected or filtered evidence scope;
- result value or values;
- factual interpretation;
- evidence count;
- applicable period.

Cards appear above one complete supporting evidence matrix. Selecting a matrix
row initializes a card from that evidence. Focusing a card focuses its
supporting rows without removing non-supporting rows. Reset restores all
evidence and the neutral matrix state.

History may transfer selected-Purchase or filtered-History context. Analytics
performs the calculation locally; History never calculates Analytics.

## 6. Twelve-field authority and label matrix

| Learner label | Current authority | Analytics role | Availability and wording |
| --- | --- | --- | --- |
| Purchase | `PurchaseId`; stored Purchase total and item membership | determinant; evidence identity; condition | implemented. Label `Purchase`; expose a human-readable date/store companion, not the opaque ID alone |
| Date and time | `Purchase.occurrenceTime` | Time determinant; period; condition | implemented. Label `Purchase date and time`; never call insertion or Sync time |
| Product | `ProductId`, Product code and display name | determinant; condition; row identity | implemented. Label `Product`; show code as supporting identity |
| Brand | Product display brand | relational categorical variable; condition | implemented but may be blank. Label `Brand`; blank becomes `Unavailable`, not an invented brand |
| Store | Account-scoped Store identity and display name | determinant; condition | implemented. Label `Store`; grouping and comparison remain distinct |
| Purchased by | optional historical Person label | relational categorical variable; condition | implemented when recorded. Label `Purchased by`; it does not mean Account owner or Household |
| Purchased for | no current field or relation | unavailable relational variable | blocked. Show `Purchased for — Unavailable in recorded data`; do not substitute `Purchased by` |
| Payment method | optional historical Payment Method label | relational categorical variable; condition | implemented when recorded. Label `Payment method`; it is not proof of payment processing |
| Quantity | Purchase Item amount and canonical unit | numeric relational variable | implemented. Label `Quantity`; results require compatible units or separate values by unit |
| Unit price | line total divided by positive purchased quantity with currency/unit basis | derived numeric relational variable | provisional. Label `Unit price`; disclose currency and basis such as `BRL per kg`; zero/missing quantity makes it unavailable |
| Line total | stored Purchase Item line total and currency | numeric relational variable | implemented. Label `Line total`; never call it Purchase total |
| Promotion | no current field or relation | unavailable relational variable | blocked. Show `Promotion — Unavailable in recorded data`; do not infer from price differences |

Purchase total remains a valid Purchase-level fact but is not one of the
twelve matrix fields requested for each Item row. When shown, label it
`Purchase total`. It must be counted once per Purchase and must never be
re-summed once for every Item row.

## 7. Concise vocabulary

| Term | Meaning |
| --- | --- |
| Analytics | Local, deterministic calculation over the active Account’s recorded Purchase evidence, with inspectable support |
| Card | A repeatable saved-on-screen analysis definition and its current result; deletion removes the card, not Purchase evidence |
| Determinant | The single axis that separates results into Product, Purchase, Store or Time groups |
| Relational variable | A recorded or explicitly derived field related to the determinant and used as a value, comparison, grouping detail or condition |
| Operation | The one calculation applied by a card: Sum, Mean, Difference or Percentage |
| Condition | An optional rule that narrows eligible evidence without changing the determinant |
| Evidence row | One matrix row that identifies a Purchase Item and carries its related Purchase, Product, Store, time and available reference facts |
| Selected evidence | Rows explicitly chosen by the user |
| Filtered evidence | All rows remaining after active conditions or transferred History filters |
| Period | Earliest through latest Purchase occurrence time represented by the evidence; a single-time result states that one date/time |
| Result | The calculated value or values produced from eligible evidence |
| Interpretation | A factual sentence that restates the result, determinant, scope and period without cause, advice or prediction |

## 8. Required conceptual distinctions

### Determinant versus condition

The determinant answers “results by what?” A condition answers “which evidence
is included?” `Store` as determinant produces one result per Store. `Store is
Central Market` as a condition narrows rows while Product, Purchase or Time
remains the determinant. The UI must not label conditions as determinants or
silently change one into the other.

### Purchase versus Item

A Purchase is the registered event with Store, occurrence time, optional
references, currency and total. An evidence row represents one Purchase Item
joined to that Purchase and Product. Several rows may belong to one Purchase.
Purchase-level values must be deduplicated before Purchase-level calculation.

### Purchase total versus line total

`Purchase total` is the total of the registered Purchase. `Line total` is the
recorded total for one Item. Summing line totals may reproduce a Purchase total
only within exactly that Purchase and currency; the labels remain different.

### Difference versus change

`Difference` means value B minus value A between two explicitly named,
comparable endpoints. Positive and negative signs are factual direction, not a
trend. `Change` is broader language and must not be used unless the two
endpoints and their order are visible.

### Percentage versus percentage change

`Percentage` means a selected or grouped part divided by an explicitly named
whole. `Percentage change` is a different operation based on an earlier value
as denominator. PH02’s retained operation is `Percentage`; percentage change
is blocked unless Main separately defines and authorizes that meaning.

### Store grouping versus Store comparison

Store grouping lists one result per Store. Store comparison requires two
explicit Store results and an operation that relates them. A grouped Store
table must not imply that the first Store ranks above the next.

### Raw fact versus derived interpretation

An evidence row carries recorded facts and clearly marked derived values such
as Unit price. An interpretation is generated from a result. It may say what
was greater, lower, equal or represented a stated share. It cannot repair raw
facts, infer causes, recommend action or import external facts.

### Explanation versus recommendation

An explanation defines how a result was calculated and which evidence it used.
A recommendation tells the user what to do. PH02 authorizes explanations, not
recommendations.

## 9. Operation explanations and compatibility

### Sum

Meaning: “Add the eligible values.”

Minimum evidence:

- one eligible numeric value;
- compatible currency for money;
- compatible unit for quantity.

Valid variables:

- Quantity, separated by canonical unit when more than one unit is present;
- Line total, separated by currency;
- Purchase total only at one value per Purchase.

Invalid combinations:

- categorical variables;
- Unit price, because adding rates does not produce a useful factual total;
- mixed currencies in one value;
- mixed quantity units in one value;
- repeated Purchase totals across Item rows.

Missing and zero:

- missing values are excluded and the excluded count is disclosed;
- recorded zero is included;
- no eligible values produces `Not enough evidence`.

Multiple variables:

- show one separately labelled result per variable;
- never combine quantity and money into one value.

Factual template:

`Sum of {variable} by {determinant}: {value}. Based on {count} evidence rows from {period}.`

### Mean

Meaning: “Add eligible values and divide by their eligible evidence count.”

Minimum evidence:

- one eligible numeric value;
- compatible currency/unit basis.

Valid variables:

- Quantity by compatible unit;
- Unit price by compatible currency and unit basis;
- Line total by currency;
- Purchase total once per Purchase.

Invalid combinations:

- categorical variables;
- mixed currency or unit basis in one mean;
- Purchase totals repeated per Item.

Missing and zero:

- missing values are excluded and disclosed;
- recorded zero is included;
- no eligible values produces `Not enough evidence`.

Multiple variables:

- each variable has its own mean, unit, eligible count and missing count.

Factual template:

`Mean {variable} for {determinant}: {value}. Based on {count} eligible values from {period}.`

### Difference

Meaning: “Subtract explicitly named value A from explicitly named value B.”

Minimum evidence:

- two comparable values or two comparable aggregate groups;
- visible A/B labels and order;
- matching currency and unit basis.

Valid use:

- two Products, Purchases, Stores or Time groups selected explicitly;
- Quantity, Unit price, Line total or deduplicated Purchase total.

Invalid combinations:

- fewer or more than two unresolved endpoints;
- mixed currency/unit basis;
- categorical variables;
- implicit “first versus last” without visible Time order;
- causal or predictive wording.

Missing and zero:

- either missing endpoint produces `Not enough comparable evidence`;
- zero values are valid;
- equality produces `No difference in the selected evidence`.

Multiple variables:

- show one A, B and signed difference block per variable.

Factual template:

`{B label} was {difference} {higher/lower/equal} than {A label} for {variable}. Based on {count} evidence rows from {period}.`

### Percentage

Meaning: “Show an explicitly named part as a share of an explicitly named
whole.”

Minimum evidence:

- a numerator scope;
- a denominator scope containing that numerator;
- one compatible count or numeric variable;
- a denominator greater than zero.

Valid use:

- selected evidence as a share of filtered evidence;
- one Product, Purchase, Store or Time group as a share of the card’s complete
  eligible scope;
- evidence count, Quantity, Line total or deduplicated Purchase total with
  compatible units/currency.

Invalid combinations:

- numerator outside the denominator scope;
- mixed currency/unit basis;
- categorical values without count semantics;
- zero denominator;
- percentage-change wording.

Missing and zero:

- missing eligible values are excluded and disclosed;
- zero numerator with positive denominator produces `0%`;
- zero denominator produces `Percentage unavailable — the total is zero`.

Multiple variables:

- show one percentage and denominator basis per variable.

Factual template:

`{part label} represented {percentage} of {whole label} for {variable}. Based on {count} evidence rows from {period}.`

## 10. Time, evidence and History language

### Time

`Purchase date and time` always means recorded occurrence time. It never means
local insertion, export, Sync, upload, acknowledgement or provider time.

Time as determinant requires a visible grouping such as day, month or year.
Time as condition uses an explicit From/To range. The result period is derived
from eligible occurrence times, not from the current clock. A single
occurrence states its one date/time.

Proposed labels:

- `Group by time`
- `Time grouping`
- `Purchase date range`
- `From`
- `To`
- `Period: {start}–{end}`
- `Period: {date/time}` for one occurrence

### Evidence scope and focus

Proposed labels:

- `All evidence`
- `Filtered evidence`
- `Selected evidence`
- `{count} evidence rows`
- `Focus supporting evidence`
- `Show all evidence`
- `Reset evidence`

Focus changes matrix emphasis and position, not dataset membership. Reset
clears row selection, card focus and transient matrix filters, then restores
the full Account-scoped evidence matrix. Reset does not delete cards or facts.

### History handoff

Proposed History actions:

- `Analyze selected purchases`
- `Analyze filtered history`

Transferred context must visibly identify selected Purchase count or active
History conditions. Analytics confirms:

`Using {count} purchases from History. Analytics will calculate from their local evidence.`

History does not send a calculated result. If transferred context resolves to
no eligible evidence:

`No eligible Purchase evidence was transferred. Return to History or show all Analytics evidence.`

## 11. Card creation, management and result templates

Proposed creation labels:

- `New analysis card`
- `Determinant`
- `Variables`
- `Operation`
- `Conditions (optional)`
- `Evidence scope`
- `Create card`
- `Cancel`

Matrix selection initializes a provisional card:

`Card started from {count} selected evidence rows. Review its determinant, variables and operation.`

Deletion:

- action: `Delete card`;
- confirmation: `Delete this analysis card? Purchase evidence will not be changed.`;
- result: `Analysis card deleted. Purchase evidence was not changed.`

Optional reordering:

- actions: `Move card earlier`, `Move card later`;
- compact alternative: `Reorder analysis cards`;
- semantics announce the new position;
- order affects presentation only, never calculation.

Generic result structure:

1. `{Operation} of {variable} by {determinant}`
2. result value or separate values with currency/unit;
3. factual interpretation;
4. `{count} evidence rows`;
5. `Period: {period}`;
6. missing/unavailable disclosure when applicable;
7. `Focus supporting evidence`.

Equality template:

`The compared values were equal in the selected evidence.`

Unavailable-field template:

`{field} is unavailable in the recorded data and was not used.`

Partial-evidence template:

`Result calculated from {eligible} of {total} evidence rows. {excluded} rows did not contain a compatible {field} value.`

## 12. State, feedback and error wording

| State/action | Proposed label or message |
| --- | --- |
| Retry | `Retry local evidence read` |
| Retry explanation | `Try loading the local evidence again. No Purchase data will be changed.` |
| Retrying | `Loading local evidence again…` |
| Loading | `Loading local Purchase evidence…` |
| First use | `No Purchase evidence yet. Register a Purchase to begin local Analytics.` |
| No data | `No Purchase evidence is available for this Account.` |
| Filtered empty | `No evidence matches these conditions.` Actions: `Adjust conditions`, `Clear conditions` |
| Selected empty | `No evidence rows are selected.` Action: `Show all evidence` |
| Insufficient evidence | `Not enough comparable evidence for this operation.` |
| Invalid configuration | `This determinant, variable and operation cannot be combined.` |
| Unavailable field | `{field} is unavailable in the recorded data.` |
| Zero denominator | `Percentage unavailable — the total is zero.` |
| Calculation error | `This result could not be calculated. The evidence and card were preserved.` |
| Read error | `Local Purchase evidence could not be loaded. No Purchase data was changed.` |
| Partial evidence | `Result calculated from {eligible} of {total} evidence rows.` |
| History handoff | `Using {count} purchases from History.` |
| Matrix-row initiation | `Analysis card started from the selected evidence.` |
| Focus | `Showing support for {card title}. All evidence remains available.` |
| Reset | `All evidence is shown. Cards and Purchase data were not changed.` |
| Card created | `Analysis card created from {count} evidence rows.` |
| Card deleted | `Analysis card deleted. Purchase evidence was not changed.` |

Errors must not lead with technical codes. If a stable code is retained for
later Audit/support policy, it belongs in optional technical detail after the
plain-language meaning.

## 13. Wide and compact reading order

### Wide

1. page header and local/Account-scoped qualification;
2. transferred History context, period and evidence scope;
3. analysis cards in user order;
4. card creation/editor controls;
5. complete evidence matrix with column headers;
6. state, missing-field and calculation explanations.

Cards remain above the matrix. The matrix may use horizontal scrolling only
inside its bounded region, with frozen row identity where implemented. All
twelve field labels and unavailable states remain reachable.

### Compact

1. page header and qualification;
2. History context/evidence-scope summary;
3. cards as a vertical list;
4. one-card editor with progressive sections;
5. complete evidence rows as expandable cards;
6. focus/reset and state explanations.

Compact evidence cards preserve the same facts and availability markers as
wide matrix rows. Secondary fields may be collapsed but must remain reachable;
no field disappears because of width.

### State parity

Wide and compact views must consume the same card definitions, eligible row
set, operation results, counts, periods, unavailable fields and errors.
Layout may change; meaning and result may not.

## 14. Accessibility findings and requirements

- Keyboard focus follows header/context, cards, card actions, editor, evidence
  controls, matrix rows and reset.
- Selecting a row and opening row detail are separate keyboard/screen-reader
  actions.
- Card focus announces card title, result, evidence count, period and focused
  row count.
- Focus remains visible on green, purple and neutral surfaces.
- Reordering has buttons and keyboard actions; drag is never the only method.
- Matrix headers label every cell. Compact evidence cards expose one coherent
  accessible name plus expandable detail.
- Loading, retry, calculation result and error updates use restrained live
  announcements without repeatedly reading the full matrix.
- Color never carries operation, positive/negative difference, selection,
  unavailable state or error alone. Text, icon and sign are retained.
- At 200% text, cards, result values, controls and evidence rows reflow without
  clipping or page-level horizontal scrolling.
- Currency, quantity unit, Unit-price basis, signs and percentage denominator
  are included in accessible values.
- `Unavailable`, `Not enough evidence`, `0`, and blank are never represented as
  the same state.

S01 provides validated automated breakpoint and Home 200% text-scale evidence.
Analytics-specific keyboard, semantics, compact/wide parity and 200% text
evidence remain proposed.

## 15. Decisions for Main

1. Accept an evidence row as one Purchase Item joined to its Purchase, Product,
   Store and available local references.
2. Accept `Purchase total` as a separate Purchase-level fact that is
   deduplicated for calculations.
3. Accept `Percentage` as part-of-whole; keep percentage change blocked.
4. Accept `Purchased by` as the current Person reference meaning; keep
   `Purchased for` unavailable.
5. Keep `Promotion` unavailable rather than infer it from price.
6. Require a complete Account-scoped Analytics evidence read; the current
   recent-50 History query is insufficient.
7. Accept History transfer as selected Purchase IDs or visible filter context,
   followed by local Analytics calculation.
8. Decide the smallest supported Time grouping set; proposed labels are day,
   month and year.
9. Decide whether cards are transient per app session or locally persisted.
   This report defines deletion/reordering meaning but does not select lifetime.
10. Accept charts, forecasting, recommendations and rankings as deferred.

## 16. Smallest teachable slices

### Slice 1 — Evidence before calculation

Teach Purchase versus Item, the twelve fields, unavailable values, selected
versus filtered evidence, and Account scope. Materialization target: complete
read-only matrix, selection, focus and reset without cards calculating yet.

### Slice 2 — One card, one operation

Teach determinant, relational variable, condition, operation, result, count and
period through Sum and Mean. Materialization target: one card with compatible
money/quantity rules and factual interpretation.

### Slice 3 — Explicit comparison

Teach grouping versus comparison and Difference with visible A/B endpoints.
Materialization target: deterministic two-endpoint Difference and equality.

### Slice 4 — Part of a named whole

Teach Percentage, numerator, denominator and zero-denominator behavior.
Materialization target: selected/filtered part-of-whole Percentage only.

### Slice 5 — Context and parity

Teach History handoff, multiple cards, optional ordering, deletion and
wide/compact evidence equivalence.

## 17. Exact later H evidence required

Later `H_DDC_CODEX.md` must report:

1. Analytics destination is functional and no longer reserved.
2. No remote/Sync/provider/telemetry source is used.
3. Every Analytics query is scoped to the active Account.
4. The evidence matrix is complete for the active scope and is not capped by
   History’s recent-50 query.
5. Each of the twelve fields is mapped to implemented, derived or unavailable
   authority exactly as section 6 states.
6. Purchase totals are not duplicated across Item rows.
7. Quantity, currency and Unit-price compatibility rules are tested.
8. Sum, Mean, Difference and Percentage each have valid, invalid, missing,
   zero and multiple-variable evidence.
9. Percentage is part-of-whole and no percentage-change wording appears.
10. Result values, factual interpretations, counts and periods agree with
    matrix evidence.
11. Matrix selection initializes a provisional card; card focus preserves the
    complete matrix; reset restores all evidence.
12. History transfers context but performs no calculation.
13. Loading, Retry, first-use, no-data, filtered/selected empty, insufficient,
    invalid, unavailable, zero-denominator, read/calculation and partial states
    use the accepted wording boundary.
14. Wide and compact layouts expose identical card/evidence/result state.
15. Keyboard order, focus restoration, semantics, non-color meaning,
    reordering alternatives and 200% text are validated by focused tests.
16. Rendered compact, medium and wide evidence is reported separately from
    automated semantics and human acceptance.
17. Human Windows/Android, Narrator/TalkBack, keyboard-only and real-device
    results are reported separately and remain host-unvalidated when absent.
18. No charts, prediction, recommendation, ranking, causal claim, external
    fact or raw-fact repair is introduced.

## 18. Non-goals

- forecasting or predictive Analytics;
- recommendations, rankings or goals;
- advanced statistics;
- charts or graph libraries;
- telemetry or usage analytics;
- remote, provider or Sync-derived Analytics;
- causal claims;
- external facts, prices or benchmarks;
- repair, merge or mutation of recorded facts;
- Product, Purchase, Store or reference mutation;
- schema/dependency selection by Didactic Chat;
- PH03 Settings/Audit/Closure work;
- KANBAN maturity change;
- PH01 redesign.

## 19. Claim/evidence matrix

| Claim | Classification | Evidence |
| --- | --- | --- |
| Analytics exists as a destination | implemented | `markei_app.dart`; stable destination ID |
| Analytics calculations exist | absent | reserved-page copy explicitly says none are active |
| Analytics uses telemetry | absent | reserved-page copy and composition inspection |
| Local Account scope exists | implemented | composition `AccountId`; local queries filter Purchase/Product/Store |
| Current History read is complete Analytics authority | contradicted | `listRecentPurchases` has `limit(50)` |
| Purchase/Item/Product/Store/time facts are available | implemented | domain types, History port and local query repository |
| Purchased by and Payment method are available | implemented | optional historical labels in Purchase history/detail |
| Purchased for is available | absent | no inspected source field, relation or projection |
| Promotion is available | absent | no inspected source field, relation or projection |
| Unit price is a raw fact | contradicted | current model stores quantity and line total; unit price is derived |
| Narrow Product price comparison exists | implemented | `priceChangeForProduct` and History detail presentation |
| Narrow price comparison proves PH02 operations | contradicted | Product-only two-observation behavior is not the retained card/matrix contract |
| History handoff exists | absent | disabled `Move to Analytics` action |
| S01 visual vocabulary is inheritable | validated | S01 source plus G/H/I automated/build evidence |
| Full PH01 visual vocabulary is inheritable | contradicted | S02 materialization absent |
| Analytics-specific accessibility is validated | absent | no Analytics implementation or tests |

## 20. Proposed E gates

1. Preserve the retained constitution verbatim in user-visible meaning.
2. Keep one determinant and one operation per card.
3. Supply a complete local Account-scoped evidence matrix.
4. Represent unavailable `Purchased for` and `Promotion` honestly.
5. Derive Unit price only with positive quantity and visible currency/unit
   basis.
6. Enforce the compatibility and missing/zero rules in section 9.
7. Keep Percentage as part-of-whole.
8. Make selected/filtered evidence, count and period visible in every result.
9. Implement History context transfer without History calculation.
10. Preserve complete matrix visibility during card focus and reset.
11. Require wide/compact semantic parity, keyboard operation, non-color
    meaning, semantics and 200% text.
12. Separate automated, rendered, accessibility and human evidence in H.
13. Keep charts, prediction, recommendation, ranking, telemetry, remote truth,
    causes and fact repair out of scope.

## 21. Main handoff

Main should reconcile this B with PH02 A/C while carrying PH01 as `PARTIAL`.
The smallest coherent PH02 materialization is a read-only, complete,
Account-scoped evidence matrix plus one-card Sum/Mean foundation, provided
Main resolves matrix authority, Time grouping and card lifetime. Difference,
Percentage and History handoff may follow as bounded slices without weakening
the retained constitution.

```text
INSPECTED_REMOTE_HEAD=f6566a407c2215c1ade61444a7f97994994d93f8
PH01_IMPLEMENTATION_COMMIT=1c7df53c095f4e7c1d85f278ba16c21fd95b25e6
PH01_MATERIALIZATION_GATE=PARTIAL
PH01_HUMAN_ACCEPTANCE=ABSENT
ANALYTICS_CURRENT_STATE=IMPLEMENTED_AS_RESERVED_PAGE
LOCAL_ANALYTICS_AUTHORITY=PROPOSED_COMPLETE_ACCOUNT_SCOPED_LOCAL_EVIDENCE
ACCOUNT_SCOPING=ACCEPTED
EVIDENCE_MATRIX_FIELD_AUTHORITY=PARTIAL
OPERATION_COMPATIBILITY=PROPOSED
TIME_SEMANTICS=PROPOSED
HISTORY_HANDOFF=PROPOSED
WIDE_COMPACT_STATE_PARITY=PROPOSED
STAGE_STATUS=PROPOSED
MAIN_DECISIONS_REQUIRED=EVIDENCE_READ_AUTHORITY_TIME_GROUPING_CARD_LIFETIME
NEXT_MAIN_ACTION=Reconcile C11-PH02 A_OPERATIONAL.md, B_DIDACTIC.md and C_DESIGN.md with PH01 classified PARTIAL, then decide the bounded PH02 materialization slices.
CHARTS_AUTHORIZED=NO
PREDICTIVE_ANALYTICS_AUTHORIZED=NO
REMOTE_ANALYTICS_AUTHORITY=NO
SOURCE_CHANGED=NO
PERMANENT_MEMORY_CHANGED=NO
METHODOLOGY_CHANGED=NO
```
