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

<!-- ROUND_MARKER:C11-PH03-R01-A-2026-07-31 -->
# Cycle C11 PH03 Round 01 — Didactic Investigation

## 1. Identity and authority

Role: established Didactic Chat [A].

Round: \`C11-PH03-R01\`.

Sequence: \`SEQ-INV-02 -> ERI-01 -> FCA-02\`.

Authority is limited to learner-facing concept identity, vocabulary, distinctions,
misconceptions, evidence-qualified teaching boundaries and a cumulative append
to this file. This round does not select architecture, authorize source
materialization, change permanent Didactic memory, alter KANBAN maturity,
activate provider work or decide operational acceptance.

Claim-state key for this round:

- **retained** — still supported from prior accepted memory;
- **new** — first established by this investigation;
- **corrected** — earlier wording narrowed by repository truth;
- **superseded** — an earlier provisional statement is no longer current;
- **contradicted** — current evidence opposes the claim;
- **unresolved** — Main or human judgment is required;
- **prospective** — proposed learner-facing materialization, not implemented;
- **deferred** — explicitly outside PH03.

\`KANBAN_TRANSITIONS=NONE\`. Existing concept identities and maturity were
inspected only to avoid duplication. Represented, executable, automatically
tested, human-reviewed and learner-understood evidence remain separate.

## 2. Inputs and repository HEAD

Repository: \`gus-i-gu/markei\`.

Required branch: \`grm-guarded-provisioning-20260727\`.

Inspected remote HEAD:
\`e8723bec10836e37bc1a7cf22fcb6de21dd03cf4\`.

The required baseline was the exact remote HEAD at investigation start.
There was no intervening advancement to classify.

Recovery followed the required order:

1. \`[M]_STAGE/J_MAIN_STAGE.md\` section 10;
2. \`00_PROJECT_STATE.md\` current PH03 segment;
3. the latest relevant \`05_SESSION_LOG.md\` segment;
4. \`06_SESSION_SCHEME.md\` current PH03 checkpoint;
5. \`didactics/08_CONCEPT_MAP.md\`;
6. \`didactics/02_KANBAN.md\`, only for identity and maturity verification;
7. the preceding complete \`B_DIDACTIC.md\` round;
8. the \`E_DDC_STAGE.md\` tail as provisional historical cache;
9. relevant \`H_DDC_CODEX.md\` evidence limits;
10. the complete tracked topology and exact PH03 source/test surfaces.

The full first-round methodology boot was completed sequentially through
\`AGENTS.md\`, \`INDEX.md\`, \`PROMPT_COLLECTION.md\`,
\`METHOD_FOUNDATIONS.md\`, \`FLUX.md\`, \`PROMOTION_RULES.md\`,
\`CHAT_PROTOCOL.md\`, \`CHAT_BEHAVIOUR.md\` and
\`METHOD_GLOSSARY.md\`. No PMC-02 confidence trigger remained after that full
boot.

## 3. New repository evidence

### 3.1 Current navigation and page truth

| Surface | Repository evidence | Current state | Didactic classification |
| --- | --- | --- | --- |
| Settings destination | \`lib/app/markei_app.dart\`, \`pages/settings_page.dart\` | ordinary secondary destination | retained functional configuration surface |
| Audit destination | \`lib/app/markei_app.dart\` | ordinary secondary destination with reserved page | corrected: represented, not functional |
| Closure destination | \`markei_app.dart\`, \`markei_composition.dart\` | visible only with \`MARKEI_NATIVE_CLOSURE_SURFACE\` | new: development-gated mixed-purpose surface |
| Wide navigation | \`widgets/markei_shell.dart\` | scrollable rail; labels visible only when wide | automatically represented |
| Compact navigation | \`widgets/markei_shell.dart\` | Home, Lists, Purchase, History plus More sheet | automatically represented |
| Audit compact location | \`markei_shell.dart\` | inside More with reservation description | represented but misleading as a usable page |
| Closure compact location | \`markei_shell.dart\` | inside More only when development flag is enabled | development-only by current composition |

The enum retains distinct \`settings\`, \`audit\` and \`closure\` identifiers.
That implementation distinction does not prove that all three should remain
learner-visible vocabulary.

### 3.2 Current Settings capability

\`SettingsPage\` currently manages:

- locally stored optional People labels;
- locally stored optional Payment Method labels;
- archive state for those local references;
- the locally stored shortage-threshold day value.

It does not currently present authentication, Device enrollment, connection
state, Sync configuration, build information or diagnostic history. Its fields
and save actions are Account-scoped through the supplied \`AccountId\`, but its
page copy emphasizes on-device storage.

### 3.3 Current Closure capability inventory

\`NativeClosurePage\` and \`NativeAuthClosureRunner\` currently combine:

1. source revision and source-tree SHA-256 display;
2. current authentication state;
3. sign in and logout;
4. enroll-or-query Device;
5. hosted connection check;
6. ordinary Sync;
7. current action result;
8. local queue counts and next Device sequence;
9. recent attempt summaries;
10. grouped diagnostic lifecycle;
11. sanitized raw lifecycle details;
12. Account-scoped Devices with fingerprints and enrollment state;
13. actionable pending, failed and unknown events;
14. unknown-outcome retry preflight and confirmed retry;
15. failed/notApplied read-only inspection;
16. confirmed bounded failed/notApplied recovery;
17. clearing local attempt history;
18. recovery guidance and MKS diagnostic codes.

The surface therefore mixes at least six different learner responsibilities:
configuration, current state, historical evidence, technical support,
consequential action and development provenance.

### 3.4 Audit evidence authority and limits

\`DriftClosureDiagnosticsRepository.snapshot\` reads local persisted evidence
for the active Account and environment alias. It creates sanitized
fingerprints, does not expose raw Account/Device/submission identifiers, and
returns a refresh timestamp.

The query is deliberately bounded:

- recent attempts: at most 20;
- recent diagnostic events: at most 30;
- actionable events: at most 20;
- local queue counts: all currently classified pending rows for the active
  Account;
- Devices: locally available Devices for the active Account;
- last successful Sync: latest locally recorded completed ordinary-Sync result.

Therefore the current data can support a **recent local activity view**, not a
complete or immutable audit ledger. It cannot establish hosted truth, provider
state, causal explanation, successful Sync, cross-device completeness,
retention guarantees or evidence that was never locally recorded.

### 3.5 Current presentation defects

New repository-derived findings:

- \`Native closure\`, \`Closure actions\`, \`Recent Closure attempts\`,
  \`notApplied\`, \`MKS code\`, \`last proved phase\`, fingerprints, queue
  states and client declaration scope are implementation vocabulary.
- The page exposes raw state codes such as \`diagnostics-ready\`,
  \`failed-work-needs-review\` and \`unknown-retry-queue-not-isolated\` as
  primary text.
- \`Diagnostics\` performs a local read; its label sounds like a test or causal
  diagnosis.
- \`Sync overview\` mixes current status with the newest historical attempt.
- The snapshot has \`refreshedAt\`, but the page does not visibly state when
  current status was observed.
- ISO-8601 UTC is shown directly for last successful Sync; locale review and
  learner comprehension are absent.
- ellipsis is used for diagnostic values, so expanded/readable access to long
  values is not guaranteed.
- three-column technical grids and one-column compact grids exist, but their
  semantic association, 200-percent text behavior and screen-reader order are
  not directly tested.
- the displayed recent histories are capped without telling the user that they
  are bounded subsets.
- Settings reference lists collapse loading, read error and genuine empty into
  the same empty rendering; save/archive failures have no bounded visible
  recovery, and shortage-threshold parsing can fail before learner guidance.
- archiving a reference does not currently provide explicit completion copy or
  an immediate refresh owned by the control.
- \`Audit is planned...\` incorrectly says Audit is not a diagnostic or Sync
  surface, while PH03 must now decide a sanitized local operational-evidence
  boundary. That reservation copy is superseded as planning text, not yet by
  implementation.

## 4. Component, function and object additions to the cumulative index

| Path / symbol | Type and responsibility | Inputs / results | State, side effects and evidence |
| --- | --- | --- | --- |
| \`lib/app/navigation/markei_destination.dart / MarkeiDestinationId\` | stable navigation identity | destination enum | Settings, Audit and Closure are distinct implementation IDs |
| \`lib/app/markei_app.dart / _destinations, _pages\` | navigation vocabulary and page composition | composition feature flag | Audit reserved; Closure conditionally visible |
| \`lib/app/pages/settings_page.dart / SettingsPage\` | local preference/reference UI | Account, repositories, callbacks | saves/archives local references and threshold |
| \`lib/app/pages/native_closure_page.dart / NativeClosurePage\` | mixed development support UI | runner, build provenance | reads history; invokes network and local mutations through controls |
| \`lib/app/native_auth_closure_runner.dart / NativeAuthClosureRunner\` | orchestration adapter | auth, enrollment, connection, Sync, recovery and diagnostic ports | can contact provider and mutate local/hosted coordination state |
| \`lib/application/closure_diagnostics.dart / ClosureDiagnosticsSnapshot\` | sanitized presentation contract | authentication state | current state, recent history, queues, Devices, events and refresh time |
| \`lib/infrastructure/local/closure_diagnostics_repository.dart / snapshot\` | Account/environment-scoped local read | authentication state | no network; bounded local evidence |
| same / \`clearAttemptHistory\` | local deletion | active Account and environment | deletes locally stored Sync attempt rows |
| same / retry and recovery preflights | validation | current auth, Device and queue state | read-only transactional classification before action |
| \`lib/domain/sync/sync_diagnostic_registry.g.dart\` | generated technical registry | MKS code | many generic titles/meanings are support vocabulary, not ordinary copy |
| \`contracts/shared_beta/diagnostics_v1\` | generator authority | registry JSON/schema | diagnostics are versioned technical evidence, not product taxonomy |
| \`lib/app/build_provenance.dart / BuildProvenance\` | sanitized build identity | full revision and tree digest | rejects malformed or unsafe visible metadata |
| \`widgets/markei_shell.dart / MarkeiShell\` | adaptive navigation | destinations and selected ID | rail at medium/wide; More sheet at compact |
| \`test/app/native_closure_surface_test.dart\` | feature-flag and provenance tests | wide widget host | proves default absence and explicit development enablement |
| \`test/app/native_closure_diagnostics_test.dart\` | behavior/widget evidence | wide and compact fixtures | proves current labels, local Diagnostics read and sanitized display |
| \`test/infrastructure/closure_diagnostics_repository_test.dart\` | repository evidence | local database fixture | proves scoped persistence/query behavior |
| \`test/infrastructure/native_closure_sync_path_test.dart\` | orchestration evidence | fakes/fixtures | proves bounded action paths, not human comprehension |

Function-level Didactic reading:

- \`snapshot(authenticationState)\` returns an observed local view. It does not
  refresh hosted truth.
- \`status()\` reads auth state; it is not a health assay.
- \`checkHostedConnection()\` makes a bounded hosted connection check; it does
  not prove future availability or Sync success.
- \`hostedSyncProbe()\` performs ordinary Sync work; “probe” is an internal
  name and must not become learner copy.
- \`unknownSubmissionRetryPreflight()\` is read-only classification; the
  confirmed retry is consequential.
- \`inspectFailedNotAppliedRecovery()\` is read-only; the confirmed recovery
  may mutate local coordination state and send one provider upload.
- \`clearAttemptHistory()\` permanently removes local attempt-history evidence
  for the current Account/environment scope.

Object-level Didactic reading:

- an **attempt** is one locally recorded operation attempt, not proof of
  success;
- a **queue count** is a current local classification, not hosted backlog;
- a **Device fingerprint** is a shortened privacy-preserving reference, not a
  Device name or identity credential;
- a **diagnostic code** identifies a recorded technical classification, not a
  cause;
- **readiness** means local prerequisites and queue conditions permit a next
  step; it is not Sync success;
- **recovery guidance** is a bounded safe next action derived from recorded
  state, not automatic repair;
- **build provenance** identifies the built source when valid and available; it
  does not certify runtime integrity or release acceptance.

## 5. Retained conclusions

1. **Retained:** Settings and Audit are mandatory PH03 product destinations.
2. **Retained:** ordinary navigation must not keep \`Closure\`.
3. **Retained:** Audit must be sanitized, read-only and local.
4. **Retained:** current action result and durable historical evidence are
   different concepts.
5. **Retained:** readiness and successful Sync are different concepts.
6. **Retained:** implementation and passing tests do not establish learner
   understanding or KANBAN maturity.
7. **Retained:** screenshots, Narrator, TalkBack, keyboard-only review, locale
   review, real-device review and human comprehension remain not performed.
8. **Retained:** wide and compact surfaces must preserve information and state,
   even when disclosure differs.
9. **Retained:** no charts, prediction, causal claims, telemetry, provider
   detail or raw diagnostic overload belongs in the smallest PH03 boundary.
10. **Retained:** PH03 must not revive R07 or authorize hosted/backend work.

## 6. Corrections and conceptual distinctions

### 6.1 Required vocabulary distinctions

| Distinction | Learner-facing rule |
| --- | --- |
| Settings / observed state | Settings changes preferences or account/device choices; status reports what was last observed |
| Audit / History | Audit records application operations; History records Purchases |
| Audit / Diagnostics | Audit is the readable history; diagnostics are optional technical classification details |
| current status / historical evidence | current status is the latest observation; history is a sequence of recorded past facts |
| recorded fact / inference | label recorded values as facts; label interpretation or guidance separately |
| local / hosted observation | state where evidence was recorded; never turn a client declaration into provider truth |
| configuration / last-observed state | configured values describe intended setup; observed state describes a dated result |
| action result / durable history | immediate result answers “what just happened”; history answers “what was recorded over time” |
| readiness / Sync success | readiness permits an attempt; success requires completed Sync evidence |
| connection check / Sync | connection check tests a bounded path; Sync performs upload/download/apply/acknowledgement work |
| inspection / recovery | inspection is read-only; recovery can change state and must require explicit confirmation |
| fingerprint / identity | fingerprint is a shortened reference for comparison, not a public identity or secret |

### 6.2 Evidence-state vocabulary

| Term | Required meaning | Must not mean |
| --- | --- | --- |
| Unavailable | the application cannot obtain or present the value now | failure necessarily occurred |
| Not recorded | no durable local record is available | the event never happened anywhere |
| Stale | the displayed observation is older than its stated refresh/validity boundary | incorrect by definition |
| Partial | some expected evidence is missing or excluded | the available facts are false |
| Blocked | a named prerequisite prevented the action from starting or continuing | retry is always safe |
| Failed | the attempted action reached a classified failure result | no effect occurred unless separately proved |
| Unresolved | available evidence cannot classify the final outcome | failed or safe to retry |
| Pending | local work is waiting | hosted receipt or acceptance |
| Uploading | a local operation was marked in progress | provider commit |
| Completed | the named local client operation reached its completion contract | every remote fact is permanently correct |

### 6.3 Corrected and superseded claims

- **Corrected:** Audit can use existing diagnostic evidence, but Audit is not
  synonymous with Diagnostics.
- **Corrected:** the current local repository supports bounded recent evidence,
  not a “complete Audit history.”
- **Corrected:** Devices are locally observed Account-scoped coordination
  records, not hosted membership truth.
- **Corrected:** “System Health” is too broad for the existing evidence. The
  available evidence can support \`Sync status\` and \`Connection check\`.
- **Superseded:** the reserved-page claim that Audit is categorically not a
  diagnostic or Sync surface. Audit may present sanitized Sync-operation
  evidence while remaining read-only.
- **Contradicted:** \`Closure\` is an ordinary product concept. It is an
  implementation-era development container.
- **Contradicted:** \`Diagnostics\` is a suitable ordinary action label. The
  current action only refreshes local status/history.
- **Contradicted:** \`Recent Closure attempts\` communicates user meaning. The
  history is about application/Sync operations, not “closure.”
- **Unresolved:** whether the navigation label must literally be \`Audit\` or
  may be the clearer \`Activity\` / \`Activity history\` while retaining Audit
  as the capability name.

## 7. Confrontation with latest J section 10

J §10 and repository truth agree that:

- Settings is already functional but incomplete for PH03;
- Audit is represented but non-functional;
- Closure is development-gated and must be disposed;
- source authority remains inactive;
- the current diagnostic repository may be reused without granting hosted or
  causal authority;
- all human evidence gaps remain open.

J requires every Closure capability to be classified. The Didactic proposal is:

| Current Closure capability | Proposed disposition | Default visibility | Learner-facing meaning | Status |
| --- | --- | --- | --- | --- |
| Sign in | Settings: Account | visible | connect this app session to the Account | prospective; human wording needed |
| Logout | Settings: Account | visible, consequential | end the authenticated session on this device; local Purchase data is not deleted | prospective; consequence assay required |
| Enroll | Settings: Devices | visible after sign-in | connect this installation as a Device for Sync | prospective |
| Check hosted connection | Support / Sync status | visible read-only action | run one connection check now | prospective |
| Sync | Settings or product-level Sync area | visible only with explicit current-result copy | synchronize eligible local/hosted changes | unresolved placement |
| Current action result | Sync status | visible by default | plain-language result of the newest requested action | prospective |
| Authentication/enrollment/readiness | Sync status | visible by default | current locally observed prerequisite state | prospective |
| Queue summary | Audit summary or Support | expandable | local work waiting/in progress/failed/unresolved | prospective |
| Last successful Sync | Sync status | visible with timestamp/source | last locally recorded successful ordinary Sync | prospective |
| Recovery guidance | Support | visible when relevant | bounded next step; never automatic repair | prospective |
| Recent attempts | Audit | visible summary | recent locally recorded application/Sync operations | prospective |
| Grouped lifecycle | Audit technical details | collapsed | ordered recorded phases; not error count or cause | prospective |
| Sanitized raw lifecycle | Advanced Support | collapsed and secondary | technical evidence for support review | prospective |
| Devices and fingerprints | Settings summary; Audit detail | names/state visible; fingerprints collapsed | locally known Devices and current installation | prospective |
| Actionable events | Audit / Support | summary visible when non-empty | local pending, failed or unresolved work | prospective |
| MKS codes | Audit technical details | collapsed | technical classification reference | prospective |
| Build provenance | Support / About | collapsed | source identity of this build when available | prospective |
| Retry unknown outcome | Advanced Support | hidden until exact eligible state | retry the same unresolved submission after confirmation | prospective; human acceptance required |
| Inspect failed/notApplied | Support | read-only and contextual | check whether one failed local candidate is eligible | prospective |
| Recover failed/notApplied | development-only or later authorized Support | absent from ordinary navigation | consequential bounded recovery | unresolved; default recommendation development-only |
| Clear diagnostic history | Audit management / Advanced | hidden, confirmed | delete local operation-attempt history only | unresolved; evidence-loss wording required |
| Native closure title/route | retire | absent | no learner-facing meaning retained | prospective retirement |

The proposed disposition is semantic only. It does not authorize moving
functions, adding pages or exposing controls.

## 8. Confrontation with provisional E tail and H evidence

The preceding E tail is a provisional PH01/PH02 cache. It correctly preserves:

- plain language before technical codes;
- wide/compact semantic parity;
- keyboard, focus, semantics, non-color and 200-percent expectations;
- strict separation of automated and human evidence.

It does not authorize PH03 implementation. Its statement that PH03 teaching
was not materialized remains retained historical truth.

H establishes automated/build evidence for PH01/PH02, not PH03. PH03 inherits
the visual system and the evidence-separation rule, but no PH03 screenshot,
semantics, assistive-technology, locale, real-device or comprehension result
exists. The current Closure widget tests prove feature gating, control presence,
bounded local reads, wide/compact reachability and sanitization. They do not
prove terminology comprehension, focus recovery, screen-reader order,
keyboard-only operation or safe human use of consequential controls.

## 9. Cross-domain consequences

### 9.1 Provisional vocabulary table

| Current term | Observed source/UI use | Proposed learner-facing term | Intended meaning | Prohibited implication | Evidence needed | Unresolved choice |
| --- | --- | --- | --- | --- | --- | --- |
| Settings | local People, Payment Methods, threshold | Settings | choices the user can change | current state or history | usability and comprehension review | sections and navigation order |
| Audit | reserved destination | Activity history or Audit: Activity history | sanitized read-only recent local operation evidence | causal explanation, telemetry, hosted truth, completeness | source mapping, screenshots, human comprehension | literal nav label |
| History | Purchase records and selection | Purchase history | recorded Purchases and details | application-operation audit | existing PH01 evidence plus locale review | none |
| Closure | mixed development surface | no product term; Sync support lab in development | internal development container only | completed product lifecycle or security guarantee | absence-by-default test | exact development label |
| System Health | not a dedicated source term; concept implied by overview | Sync status | locally observed prerequisites and last result | whole-system or provider health | state/source/timestamp tests | whether “Status” suffices |
| Status | raw state codes | Current sync status | newest locally observed state with timestamp | durable history or success guarantee | wording/comprehension assay | page vs section label |
| Advanced | not currently separated | Advanced support | optional technical evidence and rare controls | recommended ordinary action | disclosure/focus tests | Settings subsection or Support route |
| Support | current guidance strings, no dedicated destination | Troubleshooting | safe explanation and bounded next steps | automatic repair or live operator help | comprehension assay | dedicated page vs contextual panels |
| Diagnostics | button and raw lifecycle | Refresh local status; Technical details | read locally recorded state; optionally expose technical classification | causal diagnosis or network test | no-network test, terminology assay | retain word only in collapsed detail |
| Attempt | recent Closure attempts | Operation attempt | one locally recorded requested operation | success or provider receipt | timestamp/result tests | whether “Sync attempt” when scoped |
| Queue | pending/uploading/failed/unknown counts | Local Sync work | local events waiting or needing review | hosted backlog | Account-scope and state tests | default summary depth |
| Devices | Account-scoped local Device rows | Devices | installations locally known to this Account | hosted membership completeness | sanitization and stale-state tests | show local-only rows by default |
| MKS code | current action and raw history | Technical reference | stable support classification | root cause or user fault | registry mapping/human support review | visible only on expansion |
| Fingerprint | operation/device/event shortened hash | Reference | privacy-preserving short comparison token | identity credential or secret | collision/label policy review | prefix and copy behavior |
| Readiness | Sync overview state | Ready to sync / Needs review | prerequisite and local-queue classification | successful Sync | explicit negative test and comprehension assay | exact positive label |
| Recovery guidance | raw code | Suggested next step | bounded action supported by current local evidence | guaranteed fix | state-to-copy mapping tests | contextual button availability |
| Build provenance | source revision/tree digest | Build information | which source identity the build reports | certification or untampered runtime | packaging and human support review | About vs Advanced Support |
| Clear diagnostic history | destructive button | Delete local activity history | remove local attempt-history records | deleting Purchases, queue work or hosted records | exact deletion-scope tests and confirmation assay | keep or development-only |

### 9.2 Visibility hierarchy

**Visible by default**

- plain current Sync status;
- when status was refreshed;
- sign-in and Device-connection state;
- last locally recorded successful Sync;
- plain current action result;
- recent activity summaries with timestamps and local-source qualification;
- actionable blocked/failed/unresolved state with non-color text;
- read-only refresh.

**Expandable**

- queue counts and exact state definitions;
- operation phase summaries;
- Device references;
- why an action is blocked;
- evidence-source and freshness explanation.

**Advanced Support only**

- MKS codes;
- fingerprints;
- raw lifecycle fields;
- request/response declaration scope;
- sequence ranges and hashes;
- build provenance;
- bounded preflight details;
- any eligible retry control.

**Development-only**

- provider-oriented raw diagnostics;
- failed/notApplied recovery until separately accepted;
- exact tree digest when ordinary users have no support need;
- internal native state codes;
- the old Closure route.

**Absent**

- secrets, tokens, raw Account/Device/submission identifiers;
- SQL/provider internals;
- causal claims without proof;
- telemetry claims;
- charts, ranking and prediction;
- automatic recovery;
- hosted completeness claims.

### 9.3 Proposed safe action wording

| Current action | Proposed visible label | Required consequence/result language |
| --- | --- | --- |
| Sign in | Sign in to Sync | “Opens the Account sign-in flow. Local Purchase data is not uploaded until Sync runs.” |
| Enroll | Connect this Device | “Registers this installation for the signed-in Account. It does not prove Sync succeeded.” |
| Check hosted connection | Check connection | “Runs one connection check now. A successful check does not prove Sync will complete.” |
| Sync | Sync now | state what local work may upload and that downloaded facts may be applied locally |
| Logout | Sign out on this Device | state whether local Purchase data, Device registration and queued work remain |
| Diagnostics | Refresh local status | “Reads locally recorded status and history. It does not contact the provider.” |
| Retry unknown outcome | Retry the same unresolved upload | identify exact candidate, no duplicate local event creation, hosted outcome still unresolved before retry |
| Inspect failed/notApplied | Check recovery eligibility | “Reads local evidence only. No Sync or recovery runs.” |
| Recover failed/notApplied | Recover this failed upload | name every allowed mutation/network effect and exclusions; default development-only |
| Clear diagnostic history | Delete local activity history | “Deletes locally recorded operation attempts for this Account/environment. Purchases and Sync queue work are not deleted. This history cannot be restored here.” |

Every action must show a plain result after activation. A blocked preflight is a
result, not a silent no-op. Error copy leads with meaning, preserves draft/data
state, and puts technical references after the explanation.


### 9.4 Proposed state, empty and recovery wording

| Situation | Proposed primary wording | Evidence/consequence qualification |
| --- | --- | --- |
| Loading current state | \`Loading local Sync status…\` | no network contact unless the selected action explicitly says so |
| Loading Audit | \`Loading locally recorded activity…\` | read-only |
| First-use Audit empty | \`No application activity has been recorded here yet.\` | absence of a local record does not prove no hosted event occurred |
| No successful Sync recorded | \`No successful Sync is recorded on this device.\` | do not say “Never synced” |
| Audit read error | \`Local activity could not be loaded.\` | \`Try loading again. No Purchase or Sync data will be changed.\` |
| Status unavailable | \`Current Sync status is unavailable.\` | retain the last dated observation separately if one exists |
| Stale observation | \`Last observed locally at {time}. Refresh to check local status again.\` | refresh remains a local read |
| Partial evidence | \`Some activity details were not recorded or are unavailable.\` | show which fields and preserve known facts |
| Signed out | \`Sign in is required before Device or Sync actions.\` | local Purchase review remains separate |
| Device not connected | \`Connect this Device before Sync.\` | does not imply Account membership beyond available evidence |
| Blocked | \`This action did not start: {prerequisite}.\` | no automatic retry |
| Failed | \`{action} did not complete. {known effect statement}\` | avoid claiming not-applied unless proved |
| Unresolved | \`The final result could not be confirmed.\` | preserve exact candidate and prevent generic retry |
| Connection check unavailable | \`The connection check could not establish a result.\` | not equivalent to provider outage |
| Technical detail unavailable | \`Technical detail was not recorded.\` | do not fabricate a code or fingerprint |
| Settings list empty | \`No {People/Payment Methods} saved for this Account.\` | distinct from loading and read error |
| Invalid threshold | \`Enter a whole number of days within the supported range.\` | preserve the entered value and focus the field |
| Settings save error | \`This setting could not be saved locally. Your entered value is still available.\` | provide read-only retry only when safe |
| Archive complete | \`{label} archived. Existing Purchase history keeps its recorded label.\` | archive does not delete historical facts |

A generic \`Retry\` label is insufficient. Read-only recovery uses
\`Try loading again\` or \`Refresh local status\`; consequential repetition
uses an exact object/action label and an eligibility confirmation.

## 10. Prospective additions

### Addition A — functional Audit reading boundary

- **Problem:** Audit is reserved while readable local evidence is trapped in
  Closure.
- **Proposed responsibility:** present sanitized, read-only, recent local
  operation evidence with source, scope, timestamp and bounded-history copy.
- **Likely owner/layer:** presentation over the existing diagnostics query.
- **Affected structures:** Audit destination/page, snapshot presentation,
  navigation descriptions.
- **Possible surfaces:** \`markei_app.dart\`, a dedicated Audit page,
  presentation components and widget tests.
- **Dependency consequence:** no new provider or analytics dependency proposed.
- **Schema/migration consequence:** none proposed; existing retained data only.
- **Validation:** local-only read count, Account/environment scope, caps,
  sanitization, empty/error/stale/partial states and responsive semantics.
- **Reversibility:** high if built as presentation over the existing port.
- **Alternative:** keep Audit reserved and leave Closure development-only.
- **Provisional reason:** satisfies the smallest mandatory Audit meaning without
  inventing a ledger.

### Addition B — Settings information architecture

- **Problem:** current Settings mixes local reference management but has no
  learner structure for Account, Device or Sync choices.
- **Proposed responsibility:** separate Preferences, Account, Devices and
  optional Advanced Support.
- **Likely owner/layer:** Settings presentation using existing ports only.
- **Affected structures:** Settings page sections and navigation/focus order.
- **Possible surfaces:** \`settings_page.dart\`, shared state panels, focused
  widget tests.
- **Dependency consequence:** reuse existing composition; no provider redesign.
- **Schema/migration consequence:** none proposed.
- **Validation:** every displayed value distinguishes configured from observed.
- **Reversibility:** high.
- **Alternative:** separate Account/Devices destination.
- **Provisional reason:** ordinary users expect changeable choices under
  Settings, not historical evidence.

### Addition C — Support disclosure

- **Problem:** raw diagnostics and rare recovery controls overload ordinary
  navigation.
- **Proposed responsibility:** contextual Troubleshooting with progressively
  disclosed technical evidence.
- **Likely owner/layer:** presentation policy over existing codes/actions.
- **Affected structures:** Audit/Settings panels, technical-detail expansion.
- **Possible surfaces:** shared support components and tests.
- **Dependency consequence:** none proposed.
- **Schema/migration consequence:** none.
- **Validation:** disclosure semantics, focus restoration, technical-copy
  isolation and exact action gating.
- **Reversibility:** high.
- **Alternative:** keep all support capability development-only.
- **Provisional reason:** preserves useful evidence without raw overload.

### Addition D — explicit freshness model in copy

- **Problem:** snapshot refresh time exists but is not presented.
- **Proposed responsibility:** show “Observed locally at …” and explain stale,
  unavailable and not-recorded states.
- **Likely owner/layer:** presentation formatting.
- **Affected structures:** Sync status and Audit summaries.
- **Possible surfaces:** Audit/Settings state components and locale tests.
- **Dependency consequence:** no network requirement.
- **Schema/migration consequence:** none.
- **Validation:** clock/locale fixtures and screen-reader reading order.
- **Reversibility:** high.
- **Alternative:** manual refresh label without freshness copy.
- **Provisional reason:** prevents current/historical confusion.

## 11. Risks and non-goals

### Risks

1. “Audit” may imply a complete, immutable or compliance-grade ledger.
2. “System Health” may imply provider-wide or causal certainty.
3. “Ready” may be mistaken for successful Sync.
4. “Retry” may be mistaken for universally safe repetition.
5. “Clear history” may remove evidence needed for support.
6. fingerprints may be mistaken for identities or secrets.
7. raw codes may shift cognitive burden from the product to the user.
8. capped recent histories may be mistaken for complete history.
9. compact disclosure may hide evidence or actions without semantic parity.
10. current raw status strings may be inaccessible to ordinary users and
    localization.

### Non-goals and deferred claims

- former R07 causal/backend engine;
- new diagnostic ledger or durable lifecycle;
- schema or migration changes;
- hosted cross-device Audit;
- provider observability and telemetry;
- automatic Retry, Recovery or repair;
- causal explanation of failures;
- charts, prediction, ranking or recommendation;
- production, multiple-Account or multiple-user acceptance;
- revocation, outage, retention, snapshot and rebootstrap work;
- GCM04 and provider fine tuning;
- KANBAN maturity change.

These remain **deferred**, not silently rejected as future possibilities.

## 12. Human decisions and evidence required

Main cannot infer the following decisions:

1. literal navigation label: \`Audit\`, \`Activity\` or
   \`Activity history\`;
2. whether Sync status is a Settings section, Audit summary or distinct
   destination;
3. whether sign in, Device connection and Sync now belong in Settings;
4. whether any retry control may be user-visible;
5. whether failed/notApplied recovery remains development-only;
6. whether deleting local activity history is a product requirement;
7. how much recent history is sufficient and how caps are disclosed;
8. whether fingerprints and build provenance help ordinary support journeys;
9. whether “Advanced Support” is a page, section or contextual disclosure;
10. acceptable wording and consequence model for logout;
11. locale/date-time presentation and time-zone explanation;
12. the human comprehension threshold for status, readiness and unresolved
    outcomes.

Evidence still required later:

- screenshots at compact, medium and wide widths;
- 200-percent text and long localized-string review;
- keyboard-only traversal, activation and focus return;
- semantic-tree inspection and screen-reader reading order;
- Narrator and TalkBack review;
- non-color verification for every status and action;
- locale/date/time review, including UTC-to-local explanation;
- Windows and Android real-device review;
- empty, read-error, stale, partial, blocked, failed and unresolved state
  screenshots;
- destructive-action confirmation and recovery-language assay;
- human comprehension tests for Audit versus Purchase History, local versus
  hosted, readiness versus Sync success and record versus inference;
- support-person review of MKS code/fingerprint/build-provenance usefulness.

Current evidence classification:

| Evidence kind | State |
| --- | --- |
| represented in code | present |
| executable behavior | present for Closure/Settings; absent for Audit |
| automated widget/repository tests | present but PH03 comprehension incomplete |
| Windows/Android build evidence | inherited from PH01/PH02 only |
| PH03 screenshots | not performed |
| PH03 assistive technology | not performed |
| PH03 locale review | not performed |
| PH03 real-device review | not performed |
| PH03 human acceptance | not performed |
| learner understanding | not established |

## 13. Recommendation to Main

### Proposed capability and vocabulary disposition

Accept the semantic split:

- **Settings** changes preferences and Account/Device choices.
- **Sync status** reports the latest locally observed prerequisite/action state.
- **Audit / Activity history** reads sanitized recent local operational
  evidence.
- **Troubleshooting / Advanced Support** explains blocked or unresolved states
  and exposes technical references progressively.
- **Closure** has no ordinary learner-facing meaning and should be retired from
  product navigation.
- **Purchase History** remains exclusively the history of Purchases.

Use the existing diagnostics query only as bounded local evidence authority.
Do not call it a complete ledger and do not imply hosted or causal truth.

### Proposed Didactic E gates

1. No ordinary navigation label \`Closure\`.
2. Settings, Audit and Purchase History have non-overlapping purposes in header
   and empty-state copy.
3. Audit is read-only, Account/environment-scoped, sanitized and explicitly
   recent/bounded.
4. Every status value states source and observation time.
5. Current action result is visually and semantically separate from history.
6. Unavailable, not recorded, stale, partial, blocked, failed and unresolved
   have distinct copy and tests.
7. Readiness never implies Sync success.
8. Connection check never implies Sync success or provider health.
9. Diagnostics technical terms are collapsed after plain-language meaning.
10. attempt, queue, Device, timestamp, fingerprint and build information use
    the meanings in this round.
11. destructive/consequential actions state effects, exclusions and
    reversibility before confirmation.
12. blocked actions produce visible explanations; no silent no-op.
13. failed/notApplied recovery is development-only unless Main/human evidence
    explicitly promotes it to Support.
14. wide/compact surfaces preserve navigation, information, states and actions.
15. keyboard, focus, semantics, non-color and 200-percent text tests are
    focused on PH03, not inherited by assertion.
16. H separates represented, executable, automated, rendered, build and human
    evidence.
17. no chart, prediction, causal, telemetry, provider-detail or raw-overload
    scope enters PH03.
18. KANBAN maturity remains unchanged.

### KANBAN confirmation

\`KANBAN_TRANSITIONS=NONE\`.

Rationale: repository structures and automated tests establish represented and
executable project meaning. They do not provide direct learner explanation,
comparison, prediction, debugging, transfer or comprehension evidence under
the existing maturity rubric.

### Performance improvement achieved

This investigation reduced PH03 ambiguity by converting one mixed Closure
surface into:

- six distinct learner responsibilities;
- twenty-one capability dispositions;
- an explicit visibility hierarchy;
- a seven-state evidence vocabulary;
- bounded local Audit authority;
- eighteen proposed Didactic gates;
- twelve named human decisions.

It also identifies the current repository limits that prevent “complete Audit”
and “System Health” claims, reducing later implementation and validation scope.

## 14. Next route

Main should reconcile this B append with the PH03 Operational and Design
rounds. The next valid route is:

1. preserve A/B/C disagreements;
2. select the literal navigation vocabulary and capability disposition;
3. decide whether consequential controls remain development-only;
4. bound a schema-free/provider-free D/E/F packet only after reconciliation;
5. keep Codex inactive until that packet is explicitly authorized.

### Sequence Handoff Envelope

\`\`\`text
SEQUENCE=FLX-INV-02
ROUND=C11-PH03-R01
ROLE=A
REMOTE_HEAD=e8723bec10836e37bc1a7cf22fcb6de21dd03cf4
STAGE_PATH=documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
CLAIMS_RETAINED=SETTINGS_AND_AUDIT_MANDATORY;CLOSURE_REMOVED_FROM_ORDINARY_NAVIGATION;LOCAL_READ_ONLY_AUDIT;NO_R07
CLAIMS_NEW=BOUNDED_RECENT_LOCAL_AUDIT_AUTHORITY;SIX_RESPONSIBILITY_SPLIT;TWENTY_ONE_CAPABILITY_DISPOSITIONS
CLAIMS_CORRECTED=AUDIT_MAY_PRESENT_SANITIZED_SYNC_OPERATION_EVIDENCE;SYSTEM_HEALTH_TOO_BROAD;DEVICES_LOCAL_OBSERVATIONS
CLAIMS_SUPERSEDED=AUDIT_RESERVED_COPY_AS_CURRENT_PH03_MEANING
CLAIMS_CONTRADICTED=CLOSURE_AS_PRODUCT_VOCABULARY;DIAGNOSTICS_AS_ORDINARY_ACTION;COMPLETE_AUDIT_LEDGER
CLAIMS_UNRESOLVED=NAV_LABEL;SYNC_STATUS_PLACEMENT;RETRY_VISIBILITY;RECOVERY_VISIBILITY;CLEAR_HISTORY;LOGOUT_COPY
CLAIMS_PROSPECTIVE=FUNCTIONAL_AUDIT;SETTINGS_INFORMATION_ARCHITECTURE;SUPPORT_DISCLOSURE;VISIBLE_FRESHNESS
CLAIMS_DEFERRED=R07;HOSTED_AUDIT;SCHEMA;PROVIDER_OBSERVABILITY;AUTOMATIC_REPAIR;GCM04
KANBAN_TRANSITIONS=NONE
DIDACTIC_E_GATES=PROPOSED
HUMAN_COMPREHENSION=NOT_ESTABLISHED
NEXT_MAIN_ACTION=Reconcile C11-PH03-R01 A/B/C and decide vocabulary, capability disposition and the smallest schema-free provider-free materialization boundary.
CODEX_STATUS=INACTIVE
\`\`\`

Codex remains explicitly inactive. No source, test, schema, dependency,
provider, Sync, permanent-memory, methodology, Main-root, J, A/C, D/E/F or
G/H/I change is authorized by this round.

---

<!-- ROUND_MARKER:C11-PH05-R01-A-2026-07-31 -->
# Cycle C11 PH05 Round 01 — Didactic Investigation

## 1. Identity and authority

Role: established Didactic Chat [A].

Round: `C11-PH05-R01`.

Sequence: `SEQ-INV-02 -> ERI-01 -> FCA-02`.

This is an investigative B-stage append. It owns learner-facing meaning,
vocabulary, misconceptions, claim ceilings, comprehension gates and proposed
Didactic evidence gates. It does not select architecture, authorize source
materialization, modify permanent memory, change KANBAN maturity or activate
Codex.

Claim classes remain separate:

- `REMOTE_REPOSITORY_FACT` — observed at the named remote branch HEAD;
- `ACTIVE_PH04_AUTHORITY` — controlling D/E/F meaning not yet remotely
  materialized;
- `WORKTREE_CANDIDATE` — local draft work, if visible, without repository-fact
  status;
- `PH05_PROPOSAL` — learner-facing recommendation from this investigation;
- `VALIDATED_RESULT` — a named check passed within its stated scope;
- `HUMAN_OBSERVATION` — a separately recorded human review.

Round-delta labels:

- **retained** — still supported and carried forward;
- **new** — first established by this round;
- **corrected** — earlier wording narrowed by current evidence;
- **superseded** — prior provisional meaning replaced for current use;
- **contradicted** — repository evidence opposes the claim;
- **unresolved** — Main or human judgment remains necessary;
- **prospective** — proposed PH05 behavior or wording, not implementation;
- **deferred** — explicitly outside the PH05 boundary.

`KANBAN_TRANSITIONS=NONE`. Represented, executable, automatically tested,
human-reviewed and learner-understood evidence remain distinct.

## 2. Inputs and repository HEAD

Repository: `gus-i-gu/markei`.

Required branch: `grm-guarded-provisioning-20260727`.

Starting inspected remote HEAD:
`7d9b82cb7ed7c1abb9788b553e71d245f3189662`.

Required PH04 activation ancestor:
`35cf23602060fd3a186a2470d7ac322c795e5fce`.

The activation ancestor remains the merge base and the branch is one commit
ahead. The only descendant is the accepted documentation-only Main continuity
commit `7d9b82cb7ed7c1abb9788b553e71d245f3189662`, which changes only:

- `documentation/sketch_notebook/00_PROJECT_STATE.md`;
- `documentation/sketch_notebook/05_SESSION_LOG.md`;
- `documentation/sketch_notebook/06_SESSION_SCHEME.md`;
- `documentation/sketch_notebook/[M]_STAGE/J_MAIN_STAGE.md`.

No source, test, D/E/F, G/H/I, schema, dependency, environment or unrelated
change intervenes.

No local Git checkout was visible in the current workspace. Consequently there
is no observable local branch, HEAD or dirty-path inventory and no
`WORKTREE_CANDIDATE` claim is made. No user worktree was reset, cleaned,
stashed, restored, staged, rebased, committed or overwritten.

Required recovery was completed in order through `AGENTS.md`, `INDEX.md`,
`PROMPT_COLLECTION.md`, PRI-A, PMC-01, `FLX-SEQ-00`, `FLX-INV-02`, PRC-01,
the Didactic checkpoint, latest J section 12, all three active PH04 D/E/F
tails, the preceding B round, current H, and the exact source/test surfaces
listed below. PMC-02 was not triggered because routing, authority and promotion
state were unambiguous.

## 3. New repository evidence

### 3.1 Inspected topology and surfaces

| Path | Relevant responsibility | Evidence classification |
| --- | --- | --- |
| `clients/markei_flutter/lib/app/markei_app.dart` | destinations, page composition, Guide static copy, History-to-Analytics callback | `REMOTE_REPOSITORY_FACT` |
| `lib/application/home_content.dart` | four existing Home task descriptors | `REMOTE_REPOSITORY_FACT` |
| `lib/app/pages/home_page.dart` | Home hierarchy and responsive task grid | `REMOTE_REPOSITORY_FACT` |
| `lib/app/pages/purchase_page.dart` | Store/time, optional Person/Payment, draft validation and layout | `REMOTE_REPOSITORY_FACT` |
| `lib/app/pages/products_page.dart` | Catalogue row/card activation and detail | `REMOTE_REPOSITORY_FACT` |
| `lib/app/pages/history_page.dart` | filters, selection, Analytics handoff, CSV/PDF file writes | `REMOTE_REPOSITORY_FACT` |
| `lib/application/purchase_history.dart` | History entry/detail contracts | `REMOTE_REPOSITORY_FACT` |
| `lib/infrastructure/local/local_query_repository.dart` | recent-50 History query and visible-code allocation | `REMOTE_REPOSITORY_FACT` |
| `lib/application/analytics.dart` | typed Account/Purchase-ID launch context | `REMOTE_REPOSITORY_FACT` |
| `lib/application/analytics_workspace.dart` | selected evidence scope and History context message | `REMOTE_REPOSITORY_FACT` |
| `lib/app/pages/analytics_page.dart` | current PH02 card UI and local evidence scope | `REMOTE_REPOSITORY_FACT` |
| `lib/app/pages/audit_page.dart` | visible local Audit page and visibility-gated loading | `REMOTE_REPOSITORY_FACT` |
| `lib/app/widgets/audit_components.dart` | bounded attempt/event cards and state copy | `REMOTE_REPOSITORY_FACT` |
| `lib/application/audit.dart` | local Audit page/cursor/state model | `REMOTE_REPOSITORY_FACT` |
| `lib/app/pages/settings_page.dart` | current Settings information order and actions | `REMOTE_REPOSITORY_FACT` |
| `lib/domain/references/local_reference.dart` | visible short-code/reference labels | `REMOTE_REPOSITORY_FACT` |
| `test/app/history_analytics_handoff_test.dart` | one-Purchase typed handoff without calculation | `VALIDATED_RESULT` limited to existing named widget test evidence |
| `test/app/audit_page_test.dart` | visibility gate, one local read, local Retry, no network/write | `VALIDATED_RESULT` from existing PH03 H/test record |
| `test/app/settings_page_test.dart` | threshold, archive refresh and fake support actions | `VALIDATED_RESULT` from existing PH03 H/test record |
| `test/app/markei_app_test.dart` | integrated page flows and responsive shell cases | existing automated evidence, not PH05 validation |
| `test/app/markei_visual_foundation_test.dart` | breakpoints, compact More, Home 200% text | existing automated evidence, not PH05 validation |

The path prefix for unqualified Flutter paths in this table is
`clients/markei_flutter/`.

### 3.2 Home

`homeCards` contains Register purchases, View lists, Browse catalogue and Open
purchase history. `HomePage` omits the Purchase descriptor from its secondary
grid because Register purchase is already the primary button. There is no News
card, Updates Follow-up card, release feed, network news source or milestone
model.

Therefore:

- **new repository fact:** News and Updates Follow-up are absent;
- **contradicted:** any claim that the remote app currently publishes live news
  or release status;
- **prospective:** two concise local informational cards may be added without
  implying a live service.

### 3.3 Purchase

`PurchasePage` currently presents `Store and time` and `Optional local labels`
as two consecutive full-width sections. Store, Purchase date and Time are
required context. Person and Payment Method are independent optional references;
the registration command stores their independent nullable IDs.

The current subtitle `Person and payment references are presentation context
only` is too weak: the references are optional metadata attached to the
Purchase, not merely decorative copy. The grouping must not suggest that Person
and Payment Method form one stored object.

### 3.4 Catalogue

`ProductsPage` contains no checkbox. Wide rows and compact cards retain an
active selection/detail state, `View details`, and row/card activation. The
selected Product highlight is not bulk selection and does not delete, archive
or remove the Product.

This corrects the PH05 premise from “checkbox removal to implement” to
“checkbox absence to preserve and obsolete selection wording to audit.” No
focused test currently states that Catalogue checkboxes and bulk-action copy are
absent.

### 3.5 History selection

History owns two separate states:

- `_selectedIds`: zero, one or many Purchases chosen for set actions;
- `_selectedPurchaseId`: one Purchase whose detail is open.

Every row/card checkbox toggles membership. The last selected Purchase can be
unchecked, so the selected set can return to zero. Current actions are disabled
when the set is empty. `Clear` empties the set.

Current `Select all` clears prior selection and selects every filtered entry in
the loaded list. The repository loads at most 50 recent Purchases, and History
has no page control. Therefore `Select all` does not mean every matching
Purchase in persistence and does not currently mean “current page.” The only
focused handoff test selects one Purchase; it does not establish multi-select,
zero-after-uncheck, select-all scope, selected-count announcements, disabled
reasons or export failure behavior.

### 3.6 Analytics context handoff

History currently labels the action `Analyze selected purchases` and hands a
typed `Set<PurchaseId>` to app composition. Analytics matches those IDs to local
Purchase Item evidence and exposes a selected evidence scope. The focused test
correctly proves an ID handoff without History-side calculation.

Current Analytics copy says `Using N purchases from History. Analytics will
calculate from their local evidence.` This can be read as automatic execution.
The active, unmaterialized PH04 authority instead requires a draft followed by
`Run & save analysis`; it does not authorize describing that behavior as a
remote fact yet.

### 3.7 History exports

History currently:

- requests an Account-scoped selected-Purchase export bundle;
- writes CSV to `Directory.systemTemp/markei-selected-purchases.csv`;
- writes PDF to `Directory.systemTemp/markei-selected-list.pdf`;
- reports the temporary path after the write;
- tells the learner to share the PDF manually;
- has no visible busy state, permission failure, unavailable-directory failure
  or write-failure classification around these methods.

This is export creation, not native sharing and not verified Downloads-folder
delivery. A file must not be claimed before the final write succeeds.

### 3.8 Guide

Guide is a `_StaticPage` with one sentence. It has no sections, anchors,
search, expandable topics, task sequence, claim boundaries or feature-specific
completion evidence. Navigation identity exists, but a functional learning
surface does not.

### 3.9 Audit

Remote Audit is a visibility-gated, Account/environment-scoped, read-only local
window of attempts and diagnostic events. It supports loading, empty,
unavailable, stale, retry and older-page states. The default page limit is 20
and maximum is 50.

It does not contain separate System, Health or Diagnostics interpretation
cards. Current attempt titles expose operation kind/result code and the detail
exposes code, title, meaning, guidance, phase, severity and outcome. Audit
remains recent local history, not provider status, a causal engine or automatic
repair.

### 3.10 Settings and short codes

Settings currently orders:

1. Preferences — People, Payment Methods and shortage threshold;
2. Account;
3. Sync and Device;
4. a collapsible Advanced support section containing Connect this Device and
   Sync now.

The proposed PH05 order differs: Account first, then local references and
threshold, then Sync/devices, then visible non-collapsible Advanced actions.

`LocalReference.visibleCode` is stored and displayed with the nickname.
`LocalQueryRepository._allocateReferenceCode` allocates:

- Person: `@` plus a zero-padded three-digit Account-local sequence;
- Payment Method: `#` plus a zero-padded three-digit Account-local sequence.

These are stored visible reference codes and presentation identity, not
cryptographic hashes. `$NNN` is neither allocated nor established in remote
source. Existing `#NNN` entries must remain readable and stable if any future
prefix choice changes.

## 4. Component, function, object and vocabulary additions

| Component / function / object | Current responsibility | PH05 learner-facing consequence |
| --- | --- | --- |
| `HomeCardDescriptor` | title, body, destination ID | informational cards need an explicit non-navigation or safe destination model |
| `PurchasePage._storeSection` | required Store/date/time | compact required-context group; no optional implication |
| `PurchasePage._referenceSection` | nullable Person/Payment references | two optional metadata fields, not one compound object |
| `ProductsPage._selectedProduct` | active row/card context | use “Open/View details,” never selection-count or bulk-action language |
| `HistoryPage._selectedIds` | selected Purchase set | zero/one/many semantics and set-action scope |
| `HistoryPage._selectedPurchaseId` | open detail | must remain distinct from checkbox selection |
| `HistoryPage._toggleSelection` | adds/removes one ID | final row remains uncheckable; announce updated count |
| `HistoryPage._actionBand` | selected-set actions | labels and disabled reasons must name exact scope |
| `HistoryPage._exportCsv/_sharePdf` | temporary file creation | success only after final write; classify destination/failure |
| `AnalyticsPurchaseSelectionLaunchContext` | Account plus Purchase IDs | context handoff, not record movement or calculation |
| `AnalyticsWorkspaceController._applyLaunchContext` | maps Purchases to Item rows | destination must expose matched/unavailable counts |
| `_StaticPage` Guide | one sentence | insufficient for the proposed eight-part sequence |
| `AuditPageResult` | bounded local window | Audit history, not complete operational truth |
| `AuditWorkspaceKind` | idle/loading/ready/empty/stale/unavailable | basis for honest state cards, not provider health |
| `SettingsPage` sections | preferences/readiness/actions | proposed order must preserve distinct Account/reference/Device concepts |
| `LocalReference.visibleCode` | stable stored short reference | say short code/reference code; never hash |

## 5. Retained conclusions

1. **Retained:** Purchase History and Audit history are different concepts.
2. **Retained:** local state, hosted fact, recorded event, interpretation and
   causal explanation remain distinct.
3. **Retained:** Person is a Purchase reference, not an Account identity.
4. **Retained:** Payment Method is a nickname/reference, never financial
   credentials.
5. **Retained:** History may transfer typed context but must not calculate
   Analytics.
6. **Retained:** Analytics scope transfer must not mutate Purchase records.
7. **Retained:** Audit is local, sanitized, bounded and read-only.
8. **Retained:** diagnostic codes classify recorded evidence and safe guidance;
   they do not prove a cause.
9. **Retained:** passing tests or builds do not establish learner comprehension
   or KANBAN maturity.
10. **Retained:** wide/compact parity, keyboard/focus, non-color meaning and
    200-percent text require feature-specific evidence.
11. **Retained:** prediction, recommendation, causal claims, provider detail,
    automatic repair and raw diagnostic overload are outside this teaching
    boundary.
12. **Retained:** PH04 is active authority but unmaterialized at the inspected
    remote HEAD.

## 6. Corrections

1. **Corrected:** Catalogue checkbox removal is already represented remotely;
   PH05 must preserve that absence and clarify row activation.
2. **Corrected:** current History already supports multiple selection and a
   zero-item selected set, but focused automated evidence is incomplete.
3. **Corrected:** `Select all` currently means all filtered entries in the
   loaded recent-50 window, not all persistent results and not a page.
4. **Corrected:** `Analyze selected purchases` is a handoff action, not an
   instruction to calculate inside History.
5. **Corrected:** current CSV/PDF operations create temporary files; they do
   not prove Downloads delivery or native sharing.
6. **Corrected:** Guide is represented as a destination but is not yet a
   structured learning surface.
7. **Corrected:** remote Audit has attempt/event cards, not System/Health/
   Diagnostics interpretation cards.
8. **Corrected:** current Settings keeps Advanced support collapsible; PH05's
   visible non-collapsible order is prospective.
9. **Corrected:** `#NNN` is current stored Payment Method compatibility truth.
10. **Superseded:** wording that Person/Payment are “presentation context only.”
    They are optional local Purchase metadata references.
11. **Contradicted:** `$NNN` as current Payment Method code.
12. **Contradicted:** “all systems operational” from absence of recent local
    diagnostic errors.

## 7. Confrontation with latest J

J section 12 establishes PH03 permanent closure and unconsumed PH04
Analytics-only authority. PH05 does not reopen either boundary.

Agreement with J:

- Settings and Audit meanings remain as permanently reconciled in PH03;
- Closure remains retired from ordinary navigation;
- PH04 source is not remotely materialized;
- no new schema, dependency, Auth, Sync, provider or diagnostic authority is
  available;
- human assistive-technology, locale, real-device and comprehension evidence
  remains unestablished;
- `KANBAN_TRANSITIONS=NONE` remains required.

PH05 is therefore a new prospective presentation/learning investigation. Its
Home, Purchase, Catalogue, History, Downloads, Guide, Audit-card and Settings
recommendations are not accepted product truth merely because this round
records them.

## 8. Confrontation with active PH04 D/E/F

The active PH04 packet requires:

- explicit `Create analysis` composition;
- `Run & save analysis` before an immutable session record exists;
- selected-record Chart/Table parity and export;
- Variables Purchase/contained-Item projections;
- a typed History selection scope;
- no automatic analysis, record persistence or Purchase mutation.

Those statements are `ACTIVE_PH04_AUTHORITY`, not remote implementation facts.
PH05 should preserve the learner model and avoid wording that conflicts with it.

The current remote History-to-Analytics message must eventually be corrected
from “Analytics will calculate” to a draft/scope statement. PH05 must not claim
that this correction already exists.

No PH05 recommendation modifies D/E/F. D/E/F and Codex remain inactive for this
investigative round.

## 9. Cross-domain consequences

### 9.1 Page-by-page vocabulary table

| Page / area | Current term or copy | Proposed learner-facing term | Intended meaning | Prohibited implication | Evidence needed | Unresolved choice |
| --- | --- | --- | --- | --- | --- | --- |
| Home | no News card | `News` with `Pre-release notice` | local product-status notice bundled with this build | live feed, public launch, store availability | exact static source, no-network test, compact/200% render | final title: News or About this preview |
| Home | no follow-up card | `Updates follow-up` | dated local list of completed/in-progress/planned milestones | live tracker or validated completion without evidence | claim-source mapping and date semantics | card vs link to Guide/Documentation |
| Purchase | `Store and time` | `Purchase details` or retain `Store and time` | required Store, date and time | optional context | validation/focus tests | final group title |
| Purchase | `Optional local labels` | `Optional purchase details` | independent optional Person and Payment Method metadata | one stored object; Account/credential identity | registration/model tests and comprehension | retain “Tags” as secondary helper only? |
| Catalogue | selected Product | `Open Product details` | one active detail context | checkbox/bulk selection or deletion | absence, activation and focus tests | row click vs explicit button |
| History | `N selected` | `N purchases selected` | exact selected set | open detail or filtered count | semantic announcements | singular copy |
| History | `Select all` | `Select all shown` | every filtered Purchase in the loaded window | complete database or unseen results | recent-50 scope test | later page/all-filtered pair |
| History | `Clear` | `Clear selection` | selected set becomes zero | clearing filters/history | zero-state test | none |
| History | `Analyze selected purchases` | `Use in Analytics` | send selected Purchase IDs as a new Analytics scope | moving records or automatic analysis | handoff/count/no-mutation tests | Main chooses final label |
| History | `Export CSV` | `Export selected as CSV` | create one file from selected Purchases | sharing or pre-existing file | destination/write/failure tests | shorter label on compact |
| History | `Share list (PDF)` | `Export selected as PDF` | create one PDF from selected Purchases | native share or completed delivery before write | platform-destination tests | whether native Share is later separate |
| Guide | one sentence | `Guide` with eight task sections | bounded in-app learning sequence | complete manual or live support | content/source/link/accessibility review | anchors only vs search/expanders |
| Audit | attempt/event list | `Activity history` within Audit | persisted bounded local attempts/events | complete ledger | cap/cursor/source tests | retain page title Audit |
| Audit | proposed `System` | `System` | local app, Account and environment context already available | provider/system-wide status | provenance and source mapping | exact included fields |
| Audit | proposed `Health` | `Health` or `Readiness summary` | bounded interpretation of already observed local readiness | provider health or “all operational” | state mapping and comprehension | recommend Readiness summary if ambiguity persists |
| Audit | proposed `Diagnostics` | `Diagnostics` | sanitized recent classifications and evidence availability | causal engine, test action or repair | registry mapping/no-action tests | expanded by default? |
| Settings | Preferences first | `Account` first | current sign-in state and Account-scoped choices | Person identity | section-order/focus tests | exact sign-out placement |
| Settings | People | `People` | optional Purchase references | Account users or permissions | code/selection/history tests | singular field label `Person` |
| Settings | Payment Methods | `Payment methods` | nicknamed Purchase references | card/bank credentials | persistence/comprehension tests | `#NNN` retained |
| Settings | threshold | `Shortage timeframe` | whole-number day threshold | forecast guarantee | 0–365 validation and helper copy | exact range visibility |
| Settings | `Sync and Device` | `Sync and devices` | local readiness, Device references and distinct actions | one combined action or hosted truth | action/state mapping | singular current Device vs list |
| Settings | collapsible Advanced | `Advanced` | visible rare explicit actions with consequences | hidden recovery or automatic repair | reachability/disabled-reason tests | exact controls admitted |

### 9.2 Home claim ceilings

Recommended pre-release copy:

> `Markei is still in a development preview. Features and stored-data behavior
> may change before a public release. This notice is bundled with the app and is
> not a live availability update.`

Permitted update states:

| State | Meaning | Example form |
| --- | --- | --- |
| Completed | named work has accepted evidence at a stated boundary | `Completed — Settings and local Audit are available in this build.` |
| In progress | work is actively authorized or being reviewed | `In progress — Analytics presentation is being refined.` |
| Planned | no implementation claim | `Planned — additional interface polish.` |

Dates should mean `Status recorded for this build on {local date}` or use an
explicit UTC date if technical reproducibility requires it. A milestone label
identifies project sequence, not a release channel, release date or user-facing
version guarantee. Do not use `Launched`, `Available now`, `Latest news`,
`Released`, `Validated` or store-distribution language without matching
evidence.

Compact/200-percent copy should show one status sentence plus at most three
short milestone rows, with a link or expansion only if a destination exists.

### 9.3 History selection vocabulary and semantics

Required selected-set states:

| State | Visible copy | Semantic announcement | Action behavior |
| --- | --- | --- | --- |
| zero | `No purchases selected` | `No purchases selected` | set actions disabled with named reason |
| one | `1 purchase selected` | announce after toggle | actions apply to that Purchase |
| many | `{N} purchases selected` | announce exact new count | actions apply to the complete selected set |
| cleared | `Selection cleared. No purchases selected.` | live-region announcement | selected set is zero |

The open-detail state should say `Details open` or use a separate non-checkbox
visual marker. Opening details must not select the Purchase for set actions.

If pagination is introduced, the actions must be distinct:

- `Select current page` — only visible rows on the current page;
- `Select all filtered results` — all matching results in the declared loaded or
  repository scope, with the exact count and any cap disclosed.

For the current recent-50 unpaged implementation, use `Select all shown` and
qualify `Selects all filtered purchases in this loaded recent-history window.`
Do not render a misleading all-filtered-results action until its scope exists.

Disabled reasons:

- `Select at least one purchase to use it in Analytics.`
- `Select at least one purchase to export a CSV file.`
- `Select at least one purchase to export a PDF file.`
- `All shown purchases are already selected.`
- `There is no selection to clear.`

Every checkbox requires a label such as
`Select purchase from {Store} on {date/time}` or `Deselect …`, plus selected-set
position/count where useful. The final selected row remains uncheckable.

### 9.4 Analytics-handoff alternatives and recommendation

| Candidate | Strength | Risk | Recommendation |
| --- | --- | --- | --- |
| `Move to Analytics` | mirrors human wording | implies record movement/mutation | reject for ordinary copy |
| `Analyze selected` | concise | may imply immediate calculation | acceptable only with adjacent explanation |
| `Use in Analytics` | accurately describes context use | slightly less explicit about selection | recommended |
| `Prepare analysis from selection` | precise | long on compact layouts | best extended/semantic label |

Recommended button: `Use in Analytics`.

Required result/destination copy:

> `Received {N} selected purchases from History. They define this analysis
> draft's evidence scope. No analysis has run, and History records are
> unchanged.`

Before `Run & save analysis`:

> `Complete the draft, then run it to create a saved analysis for this session.`

The destination must expose requested, matched and unavailable Purchase counts
when they differ. No saved analysis exists merely because context arrived.

### 9.5 Downloads export wording

Export creation and sharing remain separate:

- `Export selected as CSV/PDF` creates a file;
- `Share` invokes an actual platform share action only if implemented and
  observed separately.

Success is reported only after the final write succeeds:

- Windows: `CSV exported to Downloads: {safe filename}.` Optionally expose the
  full path in secondary copy.
- Android: `PDF saved to Downloads as {safe filename}.` If Android uses a
  platform document picker or another user-visible destination, name that exact
  destination instead.

Do not say `saved`, `created` or `available` before final write completion.

Required failure vocabulary:

| Failure | Primary copy | Next step |
| --- | --- | --- |
| permission denied | `Markei does not have permission to save this export.` | `Choose another destination or allow file access, then try again.` |
| directory unavailable | `The Downloads destination is unavailable.` | `Choose another available destination.` |
| write failed | `The export could not be written.` | `No completed export file was created by this attempt. Try again.` |
| source/export build failed | `The selected purchases could not be prepared for export.` | preserve selection; expose sanitized reference if available |

File names may contain a local date/time, file type and non-private short export
reference. Do not include raw Account, Device, Purchase or person identifiers.
If a fingerprint is displayed, call it an `export reference`, explain its
scope, and do not imply security/authenticity.

### 9.6 Guide minimum learning sequence

| Section | Learner goal | Required concepts and actions | Optional/unavailable behavior | Common misconception | Claim ceiling | Link vocabulary | Completion evidence |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1. Getting started | understand local-first navigation | Home, local Account/device scope, primary Register action | Sync may be unavailable | local means cloud backup | explain current build only | `Open Home`, `Open Settings` | destination and copy tests; comprehension assay |
| 2. Registering a purchase | create one local Purchase safely | choose Store/date/time; optional Person/Payment; add Items; review; register | optional metadata may remain unassigned | Product, Item and Purchase are interchangeable | no unknown-result guarantee | `Register a purchase` | happy/failure/draft-preservation tests plus human sequence |
| 3. Catalogue and History | reuse Products and review Purchases | open Product details; filter History; open detail; select zero/one/many | Catalogue has no bulk checkbox | opening detail selects for action | loaded recent-window scope only | `Browse Catalogue`, `Open Purchase history` | checkbox-absence, detail/selection and scope tests |
| 4. Lists | interpret estimates | Storage/Shortage/Market/All; estimate vocabulary | insufficient history/unavailable | Lists are measured inventory | local historical estimate only | `View Lists` | state/copy tests and learner comparison |
| 5. Analytics | configure and inspect factual calculations | scope, Group by, variables, operation, timeframe, Run & save, Chart/Table | combinations may be unavailable | automatic insight/prediction | deterministic local evidence only | `Use in Analytics`, `Open Analytics` | PH04 implementation evidence plus human comprehension |
| 6. Settings, Account and devices | distinguish configuration and readiness | Account, references, threshold, Refresh, Enroll/Connect, Sync | actions depend on sign-in/readiness | Person is Account; Refresh is Sync | locally observed state, no hosted guarantee | `Open Settings`, `Refresh local status` | state/action/disabled copy and comprehension |
| 7. Audit and local diagnostics | read bounded local evidence | System context, readiness summary, diagnostics, activity history | details may be unavailable/stale | Audit explains cause or provider health | sanitized bounded local record only | `Open Audit`, `Show technical details` | caps/source/state tests plus terminology assay |
| 8. Local data, export and Sync boundaries | know where evidence/files go | local data, Downloads export, sharing distinction, explicit Sync | export/Sync may fail or be unavailable | export is backup; Sync is guaranteed | exact observed destination/action only | `Export selected`, `Sync now` | platform export, Sync boundary and human consequence review |

Smallest useful Guide structure: one scrollable page with a contents list and
eight anchored headings. Search is unnecessary for the initial bounded content.
Expandable topics are optional only for technical details; core action sequences
must remain visible and keyboard/screen-reader reachable. This avoids hidden
learning order and keeps implementation reversible.

### 9.7 Audit System, Health, Diagnostics and history distinctions

| Card / section | Permitted meaning | Required states | Prohibited claims |
| --- | --- | --- | --- |
| System | local app/build, active Account reference, environment alias and Device context already available | Available, Unavailable, Not yet checked | provider-wide environment truth; security certification |
| Health / Readiness summary | bounded interpretation of already observed local prerequisites and recorded result | Ready, Attention needed, Unknown, Stale, Not yet checked, Unavailable | `All systems operational`; provider health; future Sync success |
| Diagnostics | sanitized recent technical classifications and evidence availability | No recent records, Attention needed, Unknown, Stale, Unavailable | cause, live test, repair, Retry/Recovery/enrollment action |
| Activity history | persisted bounded local attempts/events | Loading, Empty/No recent records, Stale, Unavailable | complete ledger or current status |

Honest state language:

- `Ready` — named local prerequisites currently appear ready; does not predict a
  successful Sync.
- `Attention needed` — recorded local evidence requires review; does not prove a
  provider fault.
- `Unavailable` — the value cannot be obtained or presented now.
- `Unknown` — available evidence cannot classify the state.
- `Not yet checked` — no qualifying observation has been requested/recorded.
- `Stale` — the card shows a dated older observation after a newer read failed
  or passed its freshness boundary.
- `No recent records` — no records exist in the displayed bounded local window;
  it does not prove no event occurred elsewhere.

Audit interpretation cards remain read-only. Do not include Sign in, Enroll,
Sync, Retry submission, Recovery or clear-history controls in them. Audit Retry
may only repeat the local Audit read and must say so.

### 9.8 Settings conceptual hierarchy

Proposed reading order:

1. `Account` — current sign-in state and explicit sign-in/sign-out actions;
2. `Purchase references and shortage timeframe` — People, Payment methods and
   whole-number day threshold;
3. `Sync and devices` — current local readiness, Device references, Refresh,
   Connect/Enroll and Sync as distinct actions;
4. `Advanced` — visible, non-collapsible rare actions admitted by Main, each
   with consequence and disabled-reason copy.

Required distinctions:

- Account is authentication scope; Person is a Purchase reference.
- Payment Method is a local nickname/reference; never request credentials,
  account numbers or card secrets.
- Shortage timeframe is a whole-number day threshold, not a prediction.
- Device identity is the stable installation identity used by coordination;
  Device display reference is a learner-safe label.
- Refresh reads current local status; Connect/Enroll establishes Device
  coordination; Sync exchanges eligible facts. They are not aliases.
- loading, success, failed, unavailable and already-in-progress are separate
  visible results.

Proposed action wording:

- `Refresh local status` — local read only;
- `Connect this device` — establish/confirm this installation's Device record;
- `Sync now` — perform eligible Sync work;
- `Action already in progress` — preserve the current action; do not silently
  start a duplicate;
- `Current local status is unavailable` — do not infer hosted failure.

### 9.9 `@NNN`, `#NNN`, `$NNN` compatibility interpretation

| Form | Remote truth | Learner term | Decision |
| --- | --- | --- | --- |
| `@NNN` | stored Person visible code, Account-local sequential allocation | Person short code/reference code | preserve |
| `#NNN` | stored Payment Method visible code, Account-local sequential allocation | Payment Method short code/reference code | preserve while compatibility unresolved |
| `$NNN` | absent from inspected allocator and model | proposed visual alternative only | do not introduce as current truth |

The code is both stored reference identity and visible presentation reference;
it is not the database's only internal identity. Never call it a hash,
fingerprint or security code. Existing codes remain legible and stable across
archiving, History display and future UI changes. If Main later selects `$NNN`,
it must decide migration-free display compatibility for existing `#NNN`
entries; Didactic recommends retaining `#NNN` in PH05.

### 9.10 Accessibility and comprehension gates

Required automated gates:

1. every History checkbox exposes select/deselect semantics with Purchase
   context;
2. selected-count changes are announced and not color-only;
3. set actions expose disabled reasons;
4. focus remains visible and returns predictably after selection, handoff,
   export and Guide navigation;
5. Catalogue row/detail activation is distinct from checkbox selection;
6. Home status labels include text/icon meaning, not color alone;
7. Guide headings form a logical semantic hierarchy and anchored navigation
   moves focus to the heading;
8. Audit card summary semantics include card name, state, evidence source and
   observation time;
9. wide/compact reading order and information are equivalent;
10. all controls and state copy remain reachable at 200-percent text;
11. export busy/success/failure is announced without claiming success early;
12. Settings actions announce already-in-progress and final result states.

Automated semantics/widget tests do not establish screen-reader quality or
human comprehension. Later evidence must include Narrator, TalkBack, keyboard-
only traversal, locale/long-string review, Windows/Android real-device review,
and comprehension assays for selection scope, Analytics handoff, Downloads,
Audit claim ceilings, Account/Person distinction and short-code meaning.

## 10. Prospective additions

### A. Static Home status cards

- **Problem:** no learner-visible pre-release/news or update follow-up surface.
- **Proposed responsibility:** build-bundled local status copy with explicit
  completion/in-progress/planned states.
- **Likely owner/layer:** Home content descriptors/presentation.
- **Affected structures:** `home_content.dart`, `home_page.dart`, Home tests.
- **Dependency consequence:** none; live network feed prohibited.
- **Schema/migration consequence:** none.
- **Validation:** claim-source mapping, no-network behavior, compact and 200%.
- **Reversibility:** high.
- **Alternative:** put all status copy in Guide/Documentation.
- **Provisional reason:** requested Home visibility without false live-news
  implications.

### B. History selection and handoff vocabulary

- **Problem:** current selection scope and `Select all` are ambiguous; focused
  evidence covers only one Purchase.
- **Proposed responsibility:** precise zero/one/many, loaded-window scope,
  disabled reasons and `Use in Analytics` handoff.
- **Likely owner/layer:** History presentation over existing ID set/callback.
- **Affected structures:** `history_page.dart`, handoff and app tests.
- **Dependency consequence:** none proposed.
- **Schema/migration consequence:** none.
- **Validation:** multi-select, final-uncheck, all-shown, detail distinction,
  matched count and no mutation/calculation.
- **Reversibility:** high.
- **Alternative:** keep current labels with explanatory subtitle.
- **Provisional reason:** removes action-scope ambiguity.

### C. User-visible export destination

- **Problem:** current temporary-file success is not Downloads delivery and
  lacks classified failure copy.
- **Proposed responsibility:** explicit platform destination, final-write
  success, sanitized failures and separate sharing.
- **Likely owner/layer:** History export presentation/file sink.
- **Affected structures:** History page, platform/file helpers and tests as
  Design/Operational permit.
- **Dependency consequence:** unresolved; stop if a new package is required
  without authority.
- **Schema/migration consequence:** none.
- **Validation:** Windows and Android destination/permission/write cases.
- **Reversibility:** medium/high.
- **Alternative:** retain temporary export and label it accurately.
- **Provisional reason:** learner-visible completion must name where the file
  actually became available.

### D. Initial anchored Guide

- **Problem:** Guide is one sentence.
- **Proposed responsibility:** eight visible task sections with a contents list
  and anchored focus navigation.
- **Likely owner/layer:** static Guide presentation/content.
- **Affected structures:** app composition/static page or a dedicated Guide
  page, plus navigation/accessibility tests.
- **Dependency consequence:** none.
- **Schema/migration consequence:** none.
- **Validation:** content claim audit, headings, focus, links, 200%, locale and
  human task completion.
- **Reversibility:** high.
- **Alternative:** plain eight sections without anchors.
- **Provisional reason:** smallest coherent teaching sequence.

### E. Read-only Audit interpretation cards

- **Problem:** raw attempt/event list requires too much interpretation.
- **Proposed responsibility:** System context, bounded readiness summary and
  sanitized Diagnostics above Activity history.
- **Likely owner/layer:** Audit presentation/controller projection over existing
  evidence only.
- **Affected structures:** Audit application/presentation/tests if evidence
  already exists.
- **Dependency consequence:** no provider or parallel registry.
- **Schema/migration consequence:** none; stop if missing facts require schema.
- **Validation:** source/time/state mapping, read-only counts and claim ceiling.
- **Reversibility:** high.
- **Alternative:** one compact summary plus current history.
- **Provisional reason:** reduces raw diagnostic overload without inventing
  cause or provider health.

### F. Settings order and code explanation

- **Problem:** current conceptual order starts with Preferences and hides
  Advanced actions; code semantics are unexplained.
- **Proposed responsibility:** Account-first hierarchy, explicit action
  differences and short-code helper copy.
- **Likely owner/layer:** Settings presentation using existing ports.
- **Affected structures:** `settings_page.dart` and focused tests.
- **Dependency consequence:** none proposed.
- **Schema/migration consequence:** none; preserve `@NNN`/`#NNN`.
- **Validation:** state/action/disabled copy, focus order, 200%, comprehension.
- **Reversibility:** high.
- **Alternative:** retain current order and add a contents summary.
- **Provisional reason:** aligns navigation meaning without changing identity.

## 11. Risks and non-goals

### Risks

1. News may imply a live feed, public release or current availability.
2. Completed/in-progress/planned labels may overstate evidence or become stale.
3. visual regrouping may make required Store/time appear optional.
4. “Optional Tags” may imply one object or arbitrary taxonomy.
5. removing Catalogue checkboxes may be mistaken for losing Product activation.
6. `Select all` may silently exceed or understate the learner's intended scope.
7. open detail and selected-for-action state may remain confused.
8. “Analyze” may imply immediate calculation or Purchase mutation.
9. export success may be announced before a durable user-visible write.
10. Android “Downloads” may be inaccurate for the actual platform sink.
11. Guide text may claim PH04/PH05 completeness before evidence exists.
12. Health may imply provider health or complete-system certainty.
13. Diagnostics may imply causal diagnosis or an executable repair.
14. visible Advanced actions may invite unsafe repetition without consequences.
15. `$NNN` may break recognition/history compatibility with `#NNN`.

### Non-goals and deferred work

- source implementation in this round;
- PH04 materialization or acceptance;
- live News, remote release feed or telemetry;
- chart, prediction, ranking, recommendation or causal explanation;
- provider health, hosted Audit or complete operational ledger;
- a second diagnostic registry;
- automatic Retry, Recovery, enrollment or repair inside Audit;
- raw-fact repair;
- schema, migration, generated-source or dependency change;
- native sharing unless separately authorized and proved;
- permanent-memory or KANBAN change;
- production, provider or live Sync acceptance.

## 12. Human decisions

Main or the human must decide:

1. Home title `News`, `Preview notice` or `About this preview`.
2. whether Updates Follow-up is a static Home card or links to Guide/
   Documentation.
3. which evidence source authorizes each Completed milestone.
4. Purchase group title: `Optional purchase details`, `Optional Tags`, or
   another concise label.
5. Catalogue row activation: row click, explicit View details, or both.
6. current History selection label: `Select all shown` vs a future paginated
   current-page/all-filtered model.
7. final Analytics-handoff label: recommended `Use in Analytics` vs
   `Analyze selected`.
8. exact Windows and Android export destinations and whether native sharing is
   separately required.
9. export filename and short-reference policy.
10. whether initial Guide uses plain anchors only or optional expandable
    technical topics.
11. Audit card title `Health` vs recommended narrower `Readiness summary`.
12. which existing local facts are sufficient for System and readiness cards.
13. which Advanced Settings actions remain ordinarily visible.
14. exact sign-out, Connect/Enroll and Sync consequence wording.
15. whether `#NNN` remains final Payment Method vocabulary; Didactic recommends
    preservation until compatibility is explicitly resolved.
16. the human comprehension threshold for selection scope, handoff, export,
    Audit state and short codes.

Evidence still required after any implementation:

- exact changed-path and copy audit;
- focused model/widget/app tests for every PH05 surface;
- compact/medium/wide screenshots and 200-percent text;
- keyboard-only traversal and focus return;
- semantics-tree inspection;
- Narrator and TalkBack;
- locale/date/time/long-string review;
- Windows/Android real-device export destination review;
- permission/directory/write-failure observations;
- human comprehension and task-completion assays;
- PH04 materialization/evidence before Guide describes it as complete.

## 13. Recommendation to Main

### Proposed capability and vocabulary disposition

- Add build-bundled Home `Preview notice`/News and `Updates follow-up` cards with
  explicit static/non-live claim ceilings.
- Keep Store/date/time required; group Person and Payment Method as independent
  `Optional purchase details`, not one tag object.
- Preserve Catalogue's checkbox absence and retain `View/Open Product details`.
- Use exact History zero/one/many copy, `Select all shown`, `Clear selection`,
  and named disabled reasons.
- Prefer `Use in Analytics`; state selected count, draft scope, no automatic
  analysis, no saved record before Run & save, and unchanged History facts.
- Name the actual user-visible export destination only after a completed write;
  separate export from share.
- Implement the initial Guide as eight visible anchored sections without search.
- Keep Audit read-only: System context, narrower Readiness summary, Diagnostics
  classifications and bounded Activity history.
- Reorder Settings Account-first and preserve distinct Refresh, Connect/Enroll
  and Sync meanings.
- Preserve `@NNN` and `#NNN` as stored short/reference codes; reject `$NNN` as
  current truth.

### Proposed Didactic E gates

1. Home status copy is static/local and never implies live News or release.
2. every update status has an evidence source and date interpretation.
3. Store/date/time remain visibly required after regrouping.
4. Person and Payment Method remain independent optional metadata.
5. Catalogue contains no checkbox, selection count or bulk-action copy.
6. Catalogue detail activation remains reachable and semantically distinct.
7. History supports and announces zero, one and many selected Purchases.
8. the final selected row can be unchecked.
9. select-all scope names loaded page/window/filtered boundaries exactly.
10. selected-set actions name scope and disabled reason.
11. open detail does not imply selected-for-action.
12. Analytics handoff transfers typed IDs/scope only and exposes counts.
13. no analysis runs and no record exists until `Run & save analysis`.
14. Purchase records remain unchanged by handoff.
15. export busy/success/failure waits for final write and names destination.
16. export and sharing are distinct actions.
17. filenames expose no private raw identifier.
18. Guide includes all eight sections and current feature claim ceilings.
19. Guide headings/anchors preserve reading and focus order.
20. Audit cards use existing local evidence and introduce no second registry.
21. Ready/Attention/Unknown/Not checked/Stale/Unavailable/No records remain
    distinct and non-color.
22. Audit contains no provider-health, causal, repair or action implication.
23. Settings order and action meanings remain non-overlapping.
24. Person is not Account identity; Payment Method is not a credential.
25. threshold is a whole-number day setting, not a forecast.
26. `@NNN` and `#NNN` remain stable short/reference codes; `$NNN` is absent
    unless Main resolves compatibility explicitly.
27. wide/compact parity, visible focus, semantics, non-color and 200-percent
    reachability have focused automated evidence.
28. H later separates represented, executable, automated, rendered, build,
    platform, human and learner evidence.
29. `KANBAN_TRANSITIONS=NONE` unless independent learner evidence satisfies the
    existing rubric.
30. prediction, causal claims, provider detail and raw overload remain absent.

### KANBAN confirmation

`KANBAN_TRANSITIONS=NONE`.

Rationale: this investigation records repository facts and PH05 proposals.
Existing PH03 tests and the one History handoff test establish limited project
behavior, not direct learner explanation, comparison, prediction, debugging,
transfer or comprehension. PH04 and PH05 are not remotely validated results at
the inspected HEAD.

### Performance improvement achieved

This round reduces investigation cost by:

- classifying eight PH05 page areas against exact remote source;
- correcting Catalogue and History assumptions before implementation staging;
- isolating the recent-50 `Select all` scope ambiguity;
- separating temporary export creation from Downloads and sharing;
- converting the Guide request into eight bounded teaching sections;
- bounding four Audit meanings without a new evidence authority;
- resolving current short-code truth in favor of `@NNN`/`#NNN`;
- reducing sixteen broad product questions to explicit Main/human decisions and
  thirty proposed Didactic gates.

## 14. Next route

Main should wait for the paired PH05 Operational A and Design C appends, then
reconcile A/B/C. Main must decide vocabulary, export/platform scope, Audit card
evidence, Guide structure and short-code compatibility before any D/E/F packet
is frozen.

### Sequence Handoff Envelope

```text
SEQUENCE=FLX-INV-02
ROUND=C11-PH05-R01
ROLE=A
STARTING_REMOTE_HEAD=7d9b82cb7ed7c1abb9788b553e71d245f3189662
PH04_ACTIVATION_ANCESTOR=35cf23602060fd3a186a2470d7ac322c795e5fce
STAGE_PATH=documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
REMOTE_SOURCE_STATE=PH03_IMPLEMENTED_PH04_NOT_MATERIALIZED
CLAIMS_RETAINED=LOCAL_FIRST;AUDIT_LOCAL_BOUNDED_READ_ONLY;HISTORY_HANDOFF_NO_CALCULATION;NO_KANBAN_PROMOTION
CLAIMS_NEW=HOME_STATIC_STATUS_CEILING;HISTORY_RECENT50_SCOPE;DOWNLOADS_FAILURE_VOCABULARY;EIGHT_SECTION_GUIDE;AUDIT_CARD_DISTINCTIONS;SHORT_CODE_COMPATIBILITY
CLAIMS_CORRECTED=CATALOGUE_CHECKBOX_ALREADY_ABSENT;HISTORY_MULTISELECT_ALREADY_EXECUTABLE;SELECT_ALL_IS_LOADED_FILTERED_WINDOW;EXPORT_IS_TEMP_FILE
CLAIMS_SUPERSEDED=OPTIONAL_REFERENCES_AS_PRESENTATION_ONLY;MOVE_TO_ANALYTICS_AS_PREFERRED_COPY
CLAIMS_CONTRADICTED=LIVE_NEWS;COMPLETE_SELECT_ALL;CURRENT_DOWNLOADS_DELIVERY;AUDIT_PROVIDER_HEALTH;PAYMENT_CODE_DOLLAR_PREFIX
CLAIMS_UNRESOLVED=HOME_LABELS;OPTIONAL_GROUP_LABEL;SELECTION_SCOPE_MODEL;HANDOFF_LABEL;EXPORT_DESTINATIONS;AUDIT_HEALTH_LABEL;ADVANCED_ACTIONS
CLAIMS_PROSPECTIVE=HOME_CARDS;PURCHASE_REGROUPING;HISTORY_COPY;DOWNLOADS_EXPORT;ANCHORED_GUIDE;AUDIT_INTERPRETATION_CARDS;SETTINGS_REORDER
CLAIMS_DEFERRED=LIVE_NEWS;PREDICTION;CAUSALITY;PROVIDER_HEALTH;AUTOMATIC_REPAIR;SCHEMA;DEPENDENCY;PRODUCTION_ACCEPTANCE
KANBAN_TRANSITIONS=NONE
D_E_F_STATUS=INACTIVE_FOR_PH05
CODEX_STATUS=INACTIVE
PERFORMANCE_IMPROVEMENT=AMBIGUITY_AND_VALIDATION_SCOPE_REDUCED
NEXT_MAIN_ACTION=Wait for PH05 A and C, then reconcile A/B/C and decide the bounded PH05 vocabulary and implementation boundary.
```

Codex remains explicitly inactive. This round changes no source, tests, J,
D/E/F, G/H/I, permanent memory, methodology, KANBAN, schema, dependency,
provider or Sync surface.
