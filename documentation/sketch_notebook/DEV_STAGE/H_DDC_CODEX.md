# C11-PH04-R01 Didactic Codex Evidence

Activation marker: `<!-- ACTIVATION_MARKER:C11-PH04-R01-2026-07-31 -->`

## Learner-Facing Result

Analytics remains described as deterministic calculation over local Purchase evidence for the active Account. PH04 changes the learner workflow from passive cards to an explicit `Create analysis` draft: Group by, Choose, Variables, Operation, Timeframe, Run & save analysis, and Clear draft.

The Variables control distinguishes relational breakdowns from numeric measures. `Purchased by` and `Payment method` label/subdivide evidence; their identifiers are never treated as numeric values. `Purchased for` remains visible but disabled as unavailable in recorded data. Run requires at least one measure and one selected determinant value.

Disabled explanations are explicit and adjacent to the composer: missing determinant value, missing measure, unavailable Purchased for, unsupported operation/measure, invalid custom UTC interval, empty or stale selection, invalid Difference operands, and invalid Percentage containment.

Saved records use `Saved analyses — this session`. A record fingerprint is presented only as a compact session reference, not as a security, authenticity, causality or persistence proof. Saved record navigation selects older/newer records without mutation. Ordinary enabled edit/delete/reorder controls are absent.

Chart and Table are presented as two views of one frozen result. Chart includes a semantic summary, categories, series, units and evidence count; Table exposes the full exact result rows including typed unavailable reasons. Switching presentation does not imply recalculation. CSV/PDF export language identifies local temp-file output and does not imply cloud upload or sharing.

The lower surface is `Variables` with the qualification `Registered Purchase evidence available locally for analysis.` The `Purchases` projection is one row/card per Purchase and expands selection to contained Item IDs. `Contained items` is one row/card per persisted Purchase Item. `Use selected rows` prepares scope for a draft and performs no calculation.

## Evidence Limits

Automated widget tests covered compact/wide reachable facts, responsive breakpoints, 200-percent text regressions from existing visual foundation coverage, focus/semantics keys for chart and disabled controls, export actions, History handoff, and PH03 app-shell regressions. Human screenshot fidelity, assistive technology acceptance, locale/real-device review and comprehension evidence were not performed.

No prediction, recommendation, ranking, causal explanation, hosted truth, telemetry, repair, Sync or provider claim was added.

## Terminal

```text
CYCLE=C11
PHASE=C11-PH04
ROUND=C11-PH04-R01
GROUP_BY_AND_CHOOSE_VOCABULARY=PASS
VARIABLES_BREAKDOWN_MEASURE_DISTINCTION=PASS
UNSUPPORTED_COMBINATION_EXPLANATIONS=PASS
SESSION_RECORD_MEANING=PASS
FINGERPRINT_CLAIM_CEILING=PASS
CHART_TABLE_SEMANTIC_PARITY=PASS
RESULT_TRACEABILITY_LANGUAGE=PASS
PURCHASE_CONTAINED_ITEM_DISTINCTION=PASS
UNAVAILABLE_FIELD_LANGUAGE=PASS
EXPORT_LANGUAGE=PASS
WIDE_COMPACT_SEMANTIC_PARITY=PASS
KEYBOARD_FOCUS_SEMANTICS=PASS
TEXT_SCALE_200=PASS
SCREENSHOT_FIDELITY_REVIEW=NOT_PERFORMED
HUMAN_ASSISTIVE_TECH_ACCEPTANCE=NOT_PERFORMED
LOCALE_REAL_DEVICE_REVIEW=NOT_PERFORMED
HUMAN_COMPREHENSION=NOT_ESTABLISHED
KANBAN_TRANSITIONS=NONE
PREDICTION_CAUSAL_RECOMMENDATION_CLAIMS=ABSENT
NEXT_DIDACTIC_REVIEW=Reconcile PH04 H evidence and run human rendered comparison against the approved plates.
```
