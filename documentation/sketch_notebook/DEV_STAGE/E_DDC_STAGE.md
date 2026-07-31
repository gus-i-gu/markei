# E_DDC_STAGE — C11-PH01-S02-R01 Meaning and Accessibility Recovery

> Sequence: FLX-ORD-01
> Role: Main didactic/evidence materialization stage
> Cycle / phase / unit: C11 / C11-PH01 / C11-PH01-S02-R01
> Required branch: `grm-guarded-provisioning-20260727`
> Required remote parent: `f6566a407c2215c1ade61444a7f97994994d93f8`
> Codex starting HEAD: the synchronized D/E/F publication commit pinned by the
> initiation prompt
> Authority: **ACTIVE — CORRECTIVE IMPLEMENTATION AUTHORIZED**

## 1. Objective

Preserve the successful S02 language and information hierarchy while removing
presentation defects that make valid controls ambiguous, duplicated or
unreachable.

## 2. Required meaning corrections

- Floating labels, field values, outlines and helper text must remain visually
  distinct at rest, focus and validation states.
- Purchase and Catalogue lower sections must be discoverable by ordinary
  scrolling; no required action may appear clipped or absent.
- History must expose one understandable selection action per row. The header
  select-all control, row controls and selection count must describe the same
  selection state.
- Table and compact-card projections must retain the same Product/Purchase
  facts and IDs.
- Existing estimate qualifiers remain intact: estimates must not become claims
  of recorded inventory or recorded future totals.
- Existing optional Person and Payment labels remain presentation context only.
- Product code remains required and immutable after Product creation.
- Unknown registration guidance and single-registration semantics remain
  unchanged.

## 3. Accessibility checks

Add or update focused widget evidence for:

- no overflow or Flutter exception at the supported wide viewport and at
  200-percent text scale;
- Purchase and Catalogue vertical scrolling reaches their final interactive
  control;
- Product form fields do not overlap after responsive wrapping;
- History has one semantic row-selection control;
- keyboard focus can reach scrolling-page controls in logical order;
- existing compact/medium/wide navigation and retained state still pass.

Do not claim Narrator, TalkBack, real-device or locale acceptance without human
evidence.

## 4. Wording boundary

Do not rewrite accepted labels merely for stylistic novelty. Do not introduce
Cycle identifiers into ordinary task copy. Analytics, Settings and Audit retain
their current maturity boundaries; no PH02 or PH03 teaching is materialized.

## 5. Required H report

Replace `H_DDC_CODEX.md` with combined S02-R01 evidence containing:

1. corrected ambiguity/reachability map;
2. labels or helper text changed, with reasons;
3. selection semantics before/after;
4. responsive and text-scale evidence;
5. preserved qualifiers and optionality;
6. accessibility evidence and explicit human-evidence limits;
7. deferred PH02/PH03 meaning.

Required terminal:

```text
CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S02-R01
FIELD_MEANING_LEGIBLE=PASS | FAIL | BLOCKED
REQUIRED_ACTIONS_REACHABLE=PASS | FAIL | BLOCKED
HISTORY_SELECTION_UNAMBIGUOUS=PASS | FAIL | BLOCKED
ESTIMATE_QUALIFIERS_PRESERVED=PASS | FAIL
OPTIONAL_LABEL_SEMANTICS_PRESERVED=PASS | FAIL
RESPONSIVE_TEXT_SCALE_EVIDENCE=PASS | FAIL | BLOCKED
HUMAN_ASSISTIVE_TECH_ACCEPTANCE=NOT_PERFORMED | PERFORMED
PH02_PH03_BOUNDARY=PRESERVED | CONTRADICTED
NEXT_DIDACTIC_REVIEW=<one exact action>
```

---

<!-- ACTIVATION_MARKER:C11-PH01-S02-R01-C11-PH02-COMBINED-2026-07-31 -->

# Combined activation — PH01 meaning recovery and PH02 Analytics

> Status: **ACTIVE — CONTROLLING DIDACTIC MATERIALIZATION AUTHORITY**
> Pairing: the D and F append carrying the same activation marker

## 6. Precedence and retained PH01 scope

The earlier PH01-R01 meaning/accessibility corrections remain fully active and
narrow. Their statements deferring PH02 are superseded only by this Analytics
append. PH03 vocabulary, KANBAN maturity, human-evidence limits and every
provider/Sync boundary remain unchanged.

The preliminary five-page source now exists at
`2e59f35dd7b45902f707fcf33c73024e868787de`; do not repeat the earlier A/B/C
claim that S02 is absent. Codex must report correction evidence separately
from the preliminary implementation and must not convert automated or build
evidence into human acceptance.

## 7. Accepted learner contract

Analytics means:

> A deterministic local calculation over the active Account’s recorded
> Purchase evidence, with the supporting rows available for inspection.

Use these terms consistently:

| Term | Required meaning |
| --- | --- |
| Analysis card | session-local configuration plus current result; deleting it never deletes evidence |
| Determinant | the one axis that separates results: Product, Purchase, Store or Time |
| Relational variable | a supported numeric measure related to the determinant |
| Operation | Sum, Mean, Difference or Percentage |
| Condition | an optional rule narrowing eligible evidence without changing the determinant |
| Evidence row | one persisted Purchase Item with its related Purchase/Product facts |
| Selected evidence | rows explicitly selected by the user |
| Filtered evidence | all rows remaining after active conditions |
| Period | contributing Purchase occurrence-time range in UTC |
| Result | calculated value(s), count, period and qualifications |
| Interpretation | factual restatement without cause, advice, ranking or prediction |

Required distinctions:

- determinant answers “results by what”; condition answers “which evidence”;
- Purchase is the registered event; an evidence row is one Purchase Item;
- Purchase total is deduplicated once per Purchase; Line total belongs to one
  Item;
- Difference is B minus A, not an unnamed trend;
- Percentage is part of a named whole, never percentage change;
- Store grouping is not Store ranking or a dedicated comparison feature;
- Unit price is derived, not a raw stored fact;
- an explanation states how/what was calculated; it is not a recommendation.

## 8. Field labels and availability

Use exactly these matrix labels:

1. Purchase
2. Purchase date and time
3. Product
4. Brand
5. Store
6. Purchased by
7. Purchased for
8. Payment method
9. Quantity
10. Unit price
11. Line total
12. Promotion

`Purchased for` and `Promotion` display `Unavailable in recorded data`.
`Brand`, `Purchased by`, `Payment method` and derived `Unit price` display
`Unavailable` when the particular row has no authoritative value. Blank,
unavailable, zero and insufficient evidence must remain distinct.

Product code is supporting Product identity. Unit price includes currency and
canonical basis, for example `BRL per kg`. Purchase total, when used by a card,
is labelled `Purchase total` and is never represented as a matrix Line total.

## 9. Operation language and disabled combinations

### Sum

Use: `Add the eligible values.`

Enable Quantity, Line total, Purchase total and Evidence count. Disable Unit
price and categorical fields.

Template:

`Sum of {variable} by {determinant}: {value}. Based on {eligible} of {total}
evidence rows. Period: {period}.`

### Mean

Use: `Add the eligible values and divide by their eligible contribution count.`

Enable Quantity, Unit price, Line total and Purchase total. Disable Evidence
count and categorical fields. Every result states `per Purchase Item` or
`per Purchase`.

Template:

`Mean {variable} for {determinant}: {value} per {contribution unit}. Based on
{eligible} eligible values. Period: {period}.`

### Difference

Use: `Subtract baseline A from comparison B.`

Require exactly two visible, ordered, compatible scopes/groups. Equality uses:
`The compared values were equal in the selected evidence.`

Template:

`{B label} was {difference} higher/lower than {A label} for {variable}. Based
on {count} evidence rows. Period: {period}.`

Do not use trend, cause, improvement, saving or prediction language.

### Percentage

Use: `Show an explicitly named part as a share of an explicitly named whole.`

Require numerator evidence to be contained in denominator evidence, compatible
variable/basis and a denominator greater than zero. Enable Quantity, Line
total, Purchase total and Evidence count. Disable Unit price and percentage
change.

Template:

`{part label} represented {percentage} of {whole label} for {variable}. Based
on {count} evidence rows. Period: {period}.`

Zero denominator:

`Percentage unavailable — the total is zero.`

Multiple variables always produce separately labelled results with their own
unit/currency, eligible count and qualification.

## 10. Card, matrix and History interaction language

Card creation labels:

- `New analysis card`
- `Determinant`
- `Variables`
- `Operation`
- `Conditions (optional)`
- `Evidence scope`
- `Create card`
- `Cancel`

Matrix selection starts a provisional card:

`Card started from {count} selected evidence rows. Choose its determinant,
variables and operation.`

Card actions:

- `Edit card`
- `Delete card`
- `Move card earlier`
- `Move card later`
- `Focus supporting evidence`
- `Show all evidence`

Deletion confirmation:

`Delete this analysis card? Purchase evidence will not be changed.`

`Focus supporting evidence` may limit the visible matrix to the exact
supporting rows, but the complete dataset remains loaded. `Show all evidence`
removes only that focus. `Reset evidence` clears conditions, selection and
focus; it does not delete cards or Purchase evidence.

History action:

- `Analyze selected purchases`
- disabled when selection is empty.

Analytics confirmation:

`Using {count} purchases from History. Analytics will calculate from their
local evidence.`

History transfers context only. It never sends a calculated result.

## 11. State and recovery wording

| State/action | Required user-visible wording |
| --- | --- |
| Loading | `Loading local Purchase evidence…` |
| First use | `No Purchase evidence yet. Register a Purchase to begin local Analytics.` |
| No Account data | `No Purchase evidence is available for this Account.` |
| Filtered empty | `No evidence matches these conditions.` |
| No selection | `No evidence rows are selected.` |
| Incomplete card | `Choose a determinant, variable and operation to calculate this card.` |
| Insufficient | `Not enough comparable evidence for this operation.` |
| Invalid combination | `This determinant, variable and operation cannot be combined.` |
| Unavailable field | `{field} is unavailable in the recorded data.` |
| Selection cap | `Select up to 500 evidence rows, or use filtered evidence.` |
| Partial | `Result calculated from {eligible} of {total} evidence rows.` |
| Calculation error | `This result could not be calculated. The evidence and card were preserved.` |
| Read error | `Local Purchase evidence could not be loaded. No Purchase data was changed.` |
| Retry | `Retry local evidence read` |
| Retry help | `Try loading the local evidence again. No Purchase data will be changed.` |
| Reset result | `All evidence is shown. Cards and Purchase data were not changed.` |
| Stale History IDs | `{count} transferred purchases were unavailable for this Account and were not used.` |

Technical codes must not lead user-visible copy. Empty evidence is not an
error. Missing/incompatible rows are counted and disclosed, never silently
discarded.

## 12. Reading order, responsive parity and accessibility

Wide order:

1. page header and local/Account qualification;
2. History context, current evidence scope and period;
3. cards and their results;
4. card editor;
5. complete matrix and page controls;
6. state/qualification detail.

Compact order:

1. same header/context;
2. vertically stacked cards;
3. progressive card editor;
4. expandable evidence-row cards;
5. focus/reset and state detail.

Both projections expose the same fields, cards, results, counts, periods,
selection, focus and errors. Compact disclosure may collapse secondary fields
but cannot remove them.

Tests must establish:

- logical keyboard/focus order and visible focus;
- separate selection and row-detail actions;
- accessible names containing result, unit/currency, evidence count and period;
- matrix headers associated with cells and coherent compact-card semantics;
- non-color meaning for sign, selection, unavailable, partial and error states;
- keyboard alternatives for reordering;
- restrained live announcements for load/result/error;
- 200-percent text reflow without clipped controls or page-level horizontal
  overflow;
- state preservation at 599/600/1023/1024 widths.

Narrator, TalkBack, locale, physical-device and human comprehension remain
unvalidated unless separately performed and reported.

## 13. Required combined H report

Replace H with one combined report that separates:

1. PH01-R01 field/reachability/selection corrections;
2. Analytics vocabulary and the twelve field outcomes;
3. every enabled and disabled operation combination;
4. Difference operand order and Percentage part/whole meaning;
5. result/qualification wording;
6. card/matrix/focus/reset behavior;
7. History context language and absence of History calculation;
8. wide/compact reading and semantic parity;
9. focus, keyboard, semantics, non-color and text-scale evidence;
10. automated, rendered, build and human evidence ceilings;
11. confirmation that KANBAN maturity did not change;
12. absence of charts, prediction, recommendation, ranking, causes, telemetry,
    remote facts and raw-fact repair.

Required terminal:

```text
CYCLE=C11
ROUND=C11-PH01-S02-R01+C11-PH02
PH01_FIELD_MEANING_LEGIBLE=PASS | FAIL | BLOCKED
PH01_REQUIRED_ACTIONS_REACHABLE=PASS | FAIL | BLOCKED
PH01_HISTORY_SELECTION_UNAMBIGUOUS=PASS | FAIL | BLOCKED
ANALYTICS_VOCABULARY=PASS | FAIL | BLOCKED
TWELVE_FIELD_WORDING=PASS | FAIL | BLOCKED
UNAVAILABLE_FIELDS_HONEST=PASS | FAIL
SUM_MEAN_LANGUAGE=PASS | FAIL | BLOCKED
DIFFERENCE_B_MINUS_A=PASS | FAIL | BLOCKED
PERCENTAGE_PART_OF_WHOLE=PASS | FAIL | BLOCKED
RESULT_TRACEABILITY_WORDING=PASS | FAIL | BLOCKED
HISTORY_CONTEXT_WITHOUT_CALCULATION=PASS | FAIL | BLOCKED
WIDE_COMPACT_SEMANTIC_PARITY=PASS | FAIL | BLOCKED
KEYBOARD_FOCUS_SEMANTICS=PASS | FAIL | BLOCKED
TEXT_SCALE_200=PASS | FAIL | BLOCKED
HUMAN_ASSISTIVE_TECH_ACCEPTANCE=NOT_PERFORMED | PERFORMED
KANBAN_TRANSITIONS=NONE | CONTRADICTED
CHARTS_PREDICTION_RECOMMENDATIONS=ABSENT | CONTRADICTED
NEXT_DIDACTIC_REVIEW=<one exact action>
```
