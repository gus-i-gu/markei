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
