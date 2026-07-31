# H_DDC_CODEX - Final PH01 Meaning Recovery and PH02 Analytics Evidence

Source stages:

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

PH01 learner-visible correction:

- Purchase product, brand, package and price-entry controls now keep readable
  vertical separation and remain reachable at constrained heights.
- Catalogue product and package fields wrap into readable rows instead of
  compressing required input meaning.
- History presents one checkbox-based row-selection affordance and keeps detail
  opening as a separate row/card activation behavior.
- Home and Lists were preserved except for shared presentation compatibility
  required by the carried implementation.

Analytics learner-visible behavior:

- Analytics presents deterministic local calculations over the active Account's
  recorded Purchase evidence.
- Repeatable session-local cards appear above the supporting evidence matrix.
- The evidence matrix exposes twelve fields: Purchase, Purchase date and time,
  Product, Brand, Store, Purchased by, Purchased for, Payment method, Quantity,
  Unit price, Line total and Promotion.
- Unavailable states are honest: missing Brand, optional Purchased by, optional
  Payment method, derived Unit price, Purchased for and Promotion are displayed
  distinctly from zero or calculated results.
- Determinants are Product, Purchase, Store and UTC Time.
- Supported operations are Sum, Mean, Difference and Percentage.
- Difference wording and calculation use comparison B minus baseline A.
- Percentage wording and calculation mean part of a named containing whole, not
  percentage change.
- Zero denominator and overflow return typed unavailable results without
  invented values.
- History uses `Analyze selected purchases` to pass typed Purchase IDs into
  Analytics; History performs no calculation.
- Filtering, selected evidence, focused evidence, reset, retry and reorder
  behavior preserve the same learner-visible state across wide and compact
  layouts.

R02 evidence:

- The app-shell timeout was corrected without weakening assertions. Formerly
  blocked Purchase/App-shell cases now pass independently and inside the full
  app file.
- Keyboard/focus behavior is covered by focused widget and app-shell tests.
- Text-scale evidence includes the retained 200 percent Home visual foundation
  test.

Evidence limits:

- Automated/widget evidence exists for wording, unavailable states, operation
  compatibility, row-selection meaning, History handoff, request counts,
  fixed-point behavior and responsive state parity.
- Rendered evidence was not collected through screenshots in this run.
- Build evidence exists for Windows release and Android debug only.
- Human comprehension review, Narrator, TalkBack, real-device and locale review
  were not performed.
- KANBAN maturity was not changed.
- Charts, prediction, recommendations, rankings, causal language, telemetry,
  remote facts and raw-fact repair were not introduced.

## Terminal

```text
CYCLE=C11
ROUND=C11-PH01-S02-R01+C11-PH02
PH01_FIELD_MEANING_LEGIBLE=PASS
PH01_REQUIRED_ACTIONS_REACHABLE=PASS
PH01_HISTORY_SELECTION_UNAMBIGUOUS=PASS
ANALYTICS_VOCABULARY=PASS
TWELVE_FIELD_WORDING=PASS
UNAVAILABLE_FIELDS_HONEST=PASS
SUM_MEAN_LANGUAGE=PASS
DIFFERENCE_B_MINUS_A=PASS
PERCENTAGE_PART_OF_WHOLE=PASS
RESULT_TRACEABILITY_WORDING=PASS
HISTORY_CONTEXT_WITHOUT_CALCULATION=PASS
WIDE_COMPACT_SEMANTIC_PARITY=PASS
KEYBOARD_FOCUS_SEMANTICS=PASS
TEXT_SCALE_200=PASS
HUMAN_ASSISTIVE_TECH_ACCEPTANCE=NOT_PERFORMED
KANBAN_TRANSITIONS=NONE
CHARTS_PREDICTION_RECOMMENDATIONS=ABSENT
NEXT_DIDACTIC_REVIEW=Classify final G/H/I evidence for permanent Didactic absorption.
```
