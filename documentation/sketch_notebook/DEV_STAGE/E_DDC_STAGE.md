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
<!-- ACTIVATION_MARKER:C11-PH03-R01-2026-07-31 -->

# C11-PH03-R01 — Final Didactic Materialization Authority

> Status: ACTIVE — CONTROLLING C11-PH03 LEARNER-FACING AUTHORITY
> Pairing: the D and F append carrying this exact activation marker
> KANBAN_TRANSITIONS: NONE

## 18. Accepted concept split

Use these non-overlapping learner meanings:

- Settings: choices and Account/Device actions the user can change or invoke.
- Audit: recent, sanitized, read-only activity recorded locally for the active
  Account and environment.
- Purchase history: recorded Purchases and their facts; never application
  operational evidence.
- Current Sync status: the newest dated local observation of prerequisites and
  outcomes; never durable history or provider-wide health.
- Advanced support: progressively disclosed technical references and explicit
  existing actions; never the default path.
- Closure: no learner-facing product concept and no ordinary navigation label.

The navigation label is Audit. Its title/subtitle must qualify it as recent
local activity history. Do not rename the destination to Activity in this unit.

## 19. Settings information architecture and wording

Required section order:

1. Preferences — People, Payment Methods and shortage threshold.
2. Account — current sign-in state, Sign in to Sync, Sign out on this Device.
3. Sync and Device — locally observed status, observation time, last locally
   recorded successful Sync and Device connection state.
4. Advanced support — progressively disclosed Connect this Device and Sync now
   actions plus safe technical summaries approved by D/F.

Required action meaning:

- Sign in to Sync: opens the existing Account sign-in flow; local Purchase data
  is not uploaded merely by opening sign-in.
- Sign out on this Device: states what local Purchase data, Device registration
  and queued work remain according to existing behavior before activation.
- Connect this Device: registers this installation for the signed-in Account;
  it does not prove Sync succeeded.
- Sync now: states that local work may upload and downloaded facts may be
  applied locally; confirmation and result must be explicit.
- Refresh local status: reads locally recorded status only and contacts no
  provider.

Do not show generic Enroll, Diagnostics, Probe, Retry, Recover, Clear history,
notApplied, lifecycle, or raw state-code labels in ordinary Settings.

Settings state copy:

| State | Required leading meaning |
| --- | --- |
| loading | Loading local settings… |
| empty references | No People/Payment Methods saved for this Account. |
| invalid threshold | Enter a whole number of days from 0 through 365. |
| save failure | This setting could not be saved locally. Your entered value is still available. |
| archive success | {label} archived. Existing Purchase history keeps its recorded label. |
| status unavailable | Current Sync status is unavailable. |
| signed out | Sign in is required before Device or Sync actions. |
| Device unavailable | No connected Device is recorded locally for this Account. |
| blocked action | This action did not start: {named prerequisite}. |
| unresolved result | The final result could not be confirmed. No automatic retry was started. |

Technical codes follow plain-language meaning and appear only in Advanced
support when safe.

## 20. Audit vocabulary and evidence ceiling

Required title model:

~~~text
Audit
Recent activity recorded locally for this Account and environment.
~~~

Required qualification:

- show when the view was loaded or refreshed locally;
- disclose the current page/window and that older records may exist;
- describe an attempt as one locally recorded requested operation, not success;
- describe a diagnostic code as a technical classification, not cause;
- describe fingerprints as shortened references, not identities or secrets;
- describe completed as completion of the named client operation only;
- never infer hosted receipt, cross-device completeness or future success.

Required state language:

| State | Required leading copy |
| --- | --- |
| loading | Loading locally recorded activity… |
| empty | No application activity has been recorded here yet. |
| unavailable | Local activity could not be loaded. |
| retry help | Try loading local activity again. No Purchase or Sync data will be changed. |
| stale | Last loaded locally at {time}. Refresh to read local records again. |
| partial window | Showing {count} recent local attempts. Older records may exist. |
| missing detail | This technical detail was not recorded. |
| unknown Device | Device attribution is unavailable for this record. |

Audit’s only action is a local read/reload plus paging and disclosure controls.
It has no Sign in, Connect, Sync, connection check, retry upload, recovery or
delete-history control.

## 21. Evidence-state distinctions

Preserve distinct meanings:

- unavailable: cannot obtain or present the value now;
- not recorded: no durable local record is available;
- stale: displayed evidence predates a named refresh boundary;
- partial: only some evidence is present or the visible window is bounded;
- blocked: a named prerequisite prevented the action from starting/continuing;
- failed: the named attempt reached a classified failure;
- unresolved: available evidence cannot classify the final outcome;
- pending: local work is waiting, not hosted backlog;
- completed: the named client operation met its completion contract, not a
  provider-wide guarantee.

Current status and historical evidence must be separate sections and semantics.
Readiness never means successful Sync. A connection check never means provider
health or future Sync success.

## 22. Visibility and exclusion

Visible by default:

- Settings preferences and clear Account state;
- dated current Sync/Device status;
- last locally recorded successful Sync;
- Audit attempt summary, result, timestamp and local-source qualification.

Expandable:

- operation phases;
- queue meanings;
- unavailable fields;
- safe support explanation.

Advanced support only:

- shortened fingerprints;
- MKS technical references after plain meaning;
- safe build revision;
- Connect this Device and Sync now actions.

Development-only or absent from product UI:

- provider-oriented connection probes;
- query enrollment;
- unknown-outcome retry;
- failed/notApplied inspection and recovery;
- raw lifecycle fields and internal state codes;
- exact tree digest;
- clear diagnostic history;
- raw identifiers, payloads, tokens, URLs, SQL, paths, stack traces and
  exceptions;
- the Closure route.

## 23. Responsive and accessibility gates

Wide/medium/compact projections must expose the same concepts, records, states,
actions, confirmations and results. Compact disclosure may collapse secondary
technical detail but cannot remove it when that detail is within product scope.

Tests must establish:

- logical keyboard and screen-reader order;
- visible focus and focus return after dialogs/disclosures;
- non-color text/icon meaning for every state;
- accessible names containing action, result, local source and timestamp;
- headings/regions separating Preferences, Account, Sync and Device, Advanced
  support, current status and Audit history;
- paging controls announce page/window changes without excessive live updates;
- 200-percent text reflow without clipped controls or page-level overflow;
- state retention at 599/600/1023/1024 widths;
- destructive/development-only actions absent from the semantics tree.

Screenshots, Windows Narrator, Android TalkBack, keyboard-only human review,
locale/date-time review, real-device review and comprehension remain
NOT_PERFORMED unless Codex actually records them. Automated and build evidence
cannot establish learner understanding.

## 24. Forbidden claims and KANBAN

Do not claim:

- complete, immutable, compliance-grade or hosted Audit;
- causal diagnosis, telemetry or provider observability;
- readiness as success;
- local queue as hosted backlog;
- Device fingerprint as identity;
- automatic repair or universally safe retry;
- cross-device completeness;
- raw-fact repair;
- charts, prediction, ranking or recommendation;
- human comprehension from passing tests/builds.

KANBAN_TRANSITIONS=NONE. Codex changes representation and executable behavior
only; permanent maturity requires later independent evidence and reconciliation.

## 25. Required H report

Replace H_DDC_CODEX.md with one complete PH03 report separating:

1. Settings vocabulary and state/action copy;
2. Audit versus Purchase History;
3. current status versus historical evidence;
4. local/bounded/freshness qualifications;
5. every evidence-state distinction;
6. capability visibility and dangerous-action absence;
7. wide/compact semantic parity;
8. focus, keyboard, semantics, non-color and 200-percent text evidence;
9. automated, rendered, build and human evidence ceilings;
10. KANBAN confirmation and forbidden-claim audit.

Required terminal:

~~~text
CYCLE=C11
PHASE=C11-PH03
ROUND=C11-PH03-R01
SETTINGS_PURPOSE_LEGIBLE=PASS | FAIL | BLOCKED
AUDIT_PURPOSE_LEGIBLE=PASS | FAIL | BLOCKED
AUDIT_VS_PURCHASE_HISTORY=PASS | FAIL | BLOCKED
CURRENT_STATUS_VS_HISTORY=PASS | FAIL | BLOCKED
LOCAL_BOUNDED_FRESHNESS_COPY=PASS | FAIL | BLOCKED
EVIDENCE_STATE_VOCABULARY=PASS | FAIL | BLOCKED
ACTION_EFFECT_LANGUAGE=PASS | FAIL | BLOCKED
DANGEROUS_ACTIONS_ORDINARY_UI=ABSENT | PRESENT | BLOCKED
WIDE_COMPACT_SEMANTIC_PARITY=PASS | FAIL | BLOCKED
KEYBOARD_FOCUS_SEMANTICS=PASS | FAIL | BLOCKED
TEXT_SCALE_200=PASS | FAIL | BLOCKED
PH03_SCREENSHOTS=NOT_PERFORMED | PERFORMED
HUMAN_ASSISTIVE_TECH_ACCEPTANCE=NOT_PERFORMED | PERFORMED
LOCALE_REAL_DEVICE_REVIEW=NOT_PERFORMED | PERFORMED
HUMAN_COMPREHENSION=NOT_ESTABLISHED | ESTABLISHED
KANBAN_TRANSITIONS=NONE | CONTRADICTED
CAUSAL_TELEMETRY_COMPLETE_AUDIT_CLAIMS=ABSENT | CONTRADICTED
NEXT_DIDACTIC_REVIEW=<one exact action>
~~~

<!-- ACTIVATION_MARKER:C11-PH04-R01-2026-07-31 -->

# C11-PH04-R01 — Analytics Fine-Tuning Didactic Authority

> Status: ACTIVE — CONTROLLING C11-PH04 LEARNER-FACING AUTHORITY
> Pairing: the D and F appends carrying this exact activation marker
> KANBAN_TRANSITIONS: NONE

## 26. Corrected learner model

Analytics remains deterministic calculation over locally registered Purchase
evidence for the active Account. PH04 changes how a learner composes, saves,
revisits and inspects a calculation; it does not add prediction, recommendation,
causality, telemetry, hosted truth or data repair.

Use these page concepts:

| Learner term | Meaning | Must not imply |
| --- | --- | --- |
| Create analysis | Complete a draft configuration before calculation | automatic or inferred analysis |
| Group by | Choose the primary evidence category: Product, Purchase, Store or Time | causal determinant |
| Choose | Choose the actual products, purchases, stores, date or period | hidden selection |
| Variables | Choose relational breakdowns and numeric measures | every field is numerically summable |
| Operation | Sum, Mean, Difference or Percentage with explicit operands | advanced statistics |
| Timeframe | All recorded time or a custom UTC interval applied to the record | live or hosted time |
| Saved analyses — this session | Immutable records retained while this workspace lives | persistence across restart or Sync |
| Record fingerprint | Short reference for one frozen session record | security, signature or authenticity proof |
| Chart | Visual projection of a frozen result | a different calculation from Table |
| Table | Exact accessible projection of the same frozen result | raw database dump |
| Variables | Registered Purchase evidence used or available for analysis | causal explanation or repaired facts |
| Purchases | One deduplicated view per registered Purchase | one row per contained item |
| Contained items | Persisted Purchase Items belonging to Purchases | product catalogue inventory |

Do not use `determinant variable` in ordinary copy. `Group by` is the accepted
learner-facing label; code may retain `AnalyticsDeterminantKind`. Do not call the
lower surface `Evidence` alone. `Variables` must be qualified at first use as
registered Purchase evidence available locally for analysis.

## 27. Composer language and compatibility disclosure

The composer uses this reading order:

1. Group by;
2. Choose values;
3. Variables;
4. Operation;
5. Timeframe;
6. scope/operand explanation;
7. Run & save analysis;
8. Clear draft.

The Variables menu groups choices semantically:

- `Break down the result`: Purchased by, Payment method, Purchased for;
- `Measure`: Quantity, Unit price, Price paid (line total), Purchase total,
  Evidence count.

`Purchased for` is visible and disabled with `Unavailable in recorded data`.
Purchased by and Payment method are labels used to subdivide evidence. Copy must
never suggest adding, averaging or subtracting a person or payment method. Run is
disabled until at least one measure exists.

Use operation meanings:

| Operation | Required meaning |
| --- | --- |
| Sum | Adds compatible recorded values within each chosen group |
| Mean | Compatible total divided by the disclosed contribution count |
| Difference | Comparison B minus baseline A for exactly two comparable scopes |
| Percentage | Named part divided by a named containing whole; not percentage change |

Retain the PH02 compatibility contract. Unsupported choices are disabled where
possible and otherwise blocked before execution with a specific explanation.
Required messages include:

- `Choose at least one Product, Purchase, Store, date or period.`
- `Choose at least one measure.`
- `Purchased for is unavailable in recorded data.`
- `This operation is unavailable for the selected measure.`
- `Difference needs exactly two comparable groups: baseline A and comparison B.`
- `Percentage needs a named part contained in a named whole.`
- `The end of the custom timeframe must be after its start.`
- `Run & save analysis becomes available when the draft is complete.`

`Clear draft` means only the composer. It must not clear registered Purchases,
Variables selection imported from History, or saved analysis records without an
explicit explanation of which provisional selection is released.

## 28. Saved-record meaning

The record browser is a chronological track of analyses executed in the current
workspace. Its heading must include `this session`. Every card exposes:

- created date/time;
- `Record #…` fingerprint;
- Group by and chosen variables;
- timeframe;
- selection state;
- a lock or `Saved record` meaning.

New records appear first and become selected. Previous/next buttons must have
semantic labels such as `Select older saved analysis` and `Select newer saved
analysis`; disabled boundary buttons explain that no older/newer record exists.
Selection cannot be communicated only by border color.

Do not display enabled Edit, Delete or Reorder actions. If disabled Edit/Delete
controls remain for discoverability, their accessible description is `Saved
analyses cannot be edited/deleted in this version.` A saved record is a frozen
calculation snapshot; it is not a durable audit log, database history, legal
record, Sync fact or guarantee that current Purchase evidence is unchanged.

Use `record fingerprint` or `record reference`, not `hash`, in explanatory copy.
The visible `#ABC123` form is acceptable. State that it helps distinguish records
in this session and proves nothing about authenticity.

## 29. Result language: Chart, Table and traceability

The selected-result heading combines, in a readable order:

```text
{Group by} · {measures/breakdowns} · Record #{fingerprint}
{created time} · {timeframe} · {evidence count}
```

Chart and Table are presentation choices, not analysis choices. Switching must
retain the exact interpretation, categories, results, units, counts and period.

Chart requirements:

- visible title and explicit x/category meaning;
- every series named in a legend and directly distinguishable without color;
- currency/unit shown with the series or axis;
- negative/zero meaning where applicable;
- semantic summary naming categories, series and values;
- no decorative trend line, extrapolation or `insight` copy;
- no silent omission when categories require horizontal scrolling.

Table requirements:

- one row per grouped result entry;
- Group by label, relational breakdown labels, measure, operation, value,
  unit/currency, eligible count and excluded count;
- typed unavailable rows remain visible with their reason;
- same ordering and record identity as the Chart.

The explanation below the result must state factual calculation meaning, applied
period and evidence counts. Example form:

`Mean Unit price and Quantity grouped by Product from 1–31 July 2026. Calculated
from 42 contained items; 2 incompatible values were excluded and are listed in
Table.`

Do not use causal phrasing such as `Product caused price`, evaluative phrasing
such as `best`, or predictive phrasing such as `will cost`.

Export actions are `Export CSV` and `Export PDF`. Success copy identifies the
temporary file location; failure copy is sanitized. Export never means cloud
upload or native share unless the existing platform behavior actually performs
it. The exported artifact must identify the record fingerprint, timeframe,
operation, evidence counts and local-snapshot limitation.

## 30. Variables language and Purchase/Item distinction

Use this heading:

```text
Variables
Registered Purchase evidence available locally for analysis.
```

When focused on a record, add:

`Showing variables that contributed to Record #{fingerprint}.`

`Show all variables` removes that focus without changing the saved record.

The `Purchases` and `Contained items` switch changes representation only:

- Purchases summarizes each Purchase once and reports its item count and recorded
  Purchase total;
- Contained items shows each persisted Purchase Item and its Product, quantity,
  price and relational Purchase context;
- selecting a Purchase selects its contained Item identities for analysis;
- selecting a contained item selects only that item;
- `Use selected rows` prepares a new draft and performs no calculation.

Purchased-for and Promotion remain `Unavailable in recorded data`, never `None`,
`No`, zero or empty. Missing Person/Payment Method is `Not assigned`; an archived
reference keeps its historical label and archived qualification. Product, Store,
Person and Payment Method references should show readable labels with stable
codes/IDs where available, without presenting raw internal identifiers as the
primary meaning.

Search, Filter, Sort, selected count and pagination must use ordinary, concise
labels. Empty distinctions:

- `No Purchase evidence yet. Register a Purchase to begin local Analytics.`
- `No Purchase evidence is available for this Account.`
- `No variables match these filters.`
- `No variable rows are selected.`
- `Select rows, then use them to prepare a new analysis draft.`

## 31. Responsive, accessibility and human-evidence ceiling

Wide and compact have the same semantic sections and state. Wide may use a dense
table and horizontal saved-card strip. Compact stacks the composer, permits
horizontal saved-card browsing, preserves a readable Chart/Table result and uses
evidence cards rather than a compressed data table.

Required automated evidence:

- logical keyboard/focus order and visible focus;
- semantic names for composer controls, disabled reasons, record selection,
  previous/next navigation, Chart/Table, exports and Variables actions;
- Chart semantic summary plus Table alternative;
- non-color selection, series, unavailable, error and busy meaning;
- 200-percent text reflow without clipped controls or page-level horizontal
  overflow;
- stable reading order and state at 599/600/1023/1024 widths;
- compact cards expose the same Purchase/Item facts as the wide table.

The two approved mockup plates establish intended hierarchy and responsive
composition, not proof of rendered implementation. Codex widget tests and builds
cannot establish visual fidelity, Narrator/TalkBack quality, locale behavior,
physical-device usability or human comprehension. These remain
`NOT_PERFORMED` unless separately observed after implementation.

## 32. Prohibited claims and required H report

No PH04 UI, export or report may claim:

- analysis-record persistence across app restart;
- Sync/hosted storage of records;
- causal explanation;
- forecasting, recommendations, rankings or automatic market comparison;
- statistical significance or advanced statistics;
- repaired missing data;
- complete truth beyond the loaded active-Account local dataset;
- chart insight beyond the exact Table values.

Do not change Didactic KANBAN maturity. Replace H with a PH04 learner-facing
report covering composer vocabulary, all compatibility/disabled explanations,
session-record meaning, fingerprint ceiling, Chart/Table parity, exports,
Variables Purchase/Item distinction, missing/unavailable language, responsive/
accessibility evidence and the human evidence ceiling.

Required terminal:

```text
CYCLE=C11
PHASE=C11-PH04
ROUND=C11-PH04-R01
GROUP_BY_AND_CHOOSE_VOCABULARY=PASS | FAIL | BLOCKED
VARIABLES_BREAKDOWN_MEASURE_DISTINCTION=PASS | FAIL | BLOCKED
UNSUPPORTED_COMBINATION_EXPLANATIONS=PASS | FAIL | BLOCKED
SESSION_RECORD_MEANING=PASS | FAIL | BLOCKED
FINGERPRINT_CLAIM_CEILING=PASS | FAIL | BLOCKED
CHART_TABLE_SEMANTIC_PARITY=PASS | FAIL | BLOCKED
RESULT_TRACEABILITY_LANGUAGE=PASS | FAIL | BLOCKED
PURCHASE_CONTAINED_ITEM_DISTINCTION=PASS | FAIL | BLOCKED
UNAVAILABLE_FIELD_LANGUAGE=PASS | FAIL | BLOCKED
EXPORT_LANGUAGE=PASS | FAIL | BLOCKED
WIDE_COMPACT_SEMANTIC_PARITY=PASS | FAIL | BLOCKED
KEYBOARD_FOCUS_SEMANTICS=PASS | FAIL | BLOCKED
TEXT_SCALE_200=PASS | FAIL | BLOCKED
SCREENSHOT_FIDELITY_REVIEW=NOT_PERFORMED | PERFORMED
HUMAN_ASSISTIVE_TECH_ACCEPTANCE=NOT_PERFORMED | PERFORMED
LOCALE_REAL_DEVICE_REVIEW=NOT_PERFORMED | PERFORMED
HUMAN_COMPREHENSION=NOT_ESTABLISHED | ESTABLISHED
KANBAN_TRANSITIONS=NONE | CONTRADICTED
PREDICTION_CAUSAL_RECOMMENDATION_CLAIMS=ABSENT | CONTRADICTED
NEXT_DIDACTIC_REVIEW=Reconcile PH04 H evidence and run human rendered comparison against the approved plates.
```

---

<!-- ACTIVATION_MARKER:C11-PH05-R01-2026-07-31 -->

# C11-PH05-R01 — Didactic Materialization Authority

> Status: ACTIVE — AUTHORIZED FOR CODEX
> Source reconciliation: J section 13
> Required starting remote ancestor: `42cb6fcac60a5033c72864201786f7fcfab9a35b`

## 33. Learner model and vocabulary

PH05 clarifies existing local capabilities. It must not imply public release,
live News, complete History, automatic Analytics, provider health, causal
diagnosis, native sharing or Android public Downloads.

### 33.1 Page vocabulary

| Surface | Required learner term | Meaning | Must not imply |
| --- | --- | --- | --- |
| Home | `News` | build-bundled preview notice | live feed, store availability, public release |
| Home | `Updates follow-up` | local completed/in progress/planned summary dated as bundled copy | remote tracker, automatic freshness |
| Purchase | `Purchase details` | required Store, purchase date and time | optional context |
| Purchase | `Optional purchase details` | independent optional Person and Payment Method references | one tag object, Account identity, credentials |
| Catalogue | `View details` / `Open Product details` | open one Product detail | selection count, bulk action, deletion |
| History | `No purchases selected` | selected action set is empty | no detail is open |
| History | `1 purchase selected` | one Purchase is in the action set | only one Purchase exists |
| History | `{N} purchases selected` | exact action-set size | filtered-result count |
| History | `Select all shown` | select filtered rows in the loaded recent History window | entire Account History or unseen results |
| History | `Clear selection` | selected action set becomes empty | filters or Purchase facts are cleared |
| History | `Use in Analytics` | transfer selected Purchase context to the Analytics composer | move/mutate records or run calculation |
| Export | `Export CSV` / `Export PDF` | explicitly create one file at a supported destination | native share or cloud upload |
| Audit | `System` | local Account/environment and bounded-window context | complete system/provider truth |
| Audit | `Readiness summary` | interpretation of loaded local Audit availability and outcomes | successful future Sync or provider health |
| Audit | `Diagnostics` | sanitized recorded classifications and guidance | proven cause or automatic repair |
| Audit | `Activity history` | bounded persisted local attempts/events | complete ledger |

## 34. Exact copy and claim ceilings

### 34.1 Home

Use concise static copy. Recommended intent:

- News: `Preview notice` followed by wording that Markei is being prepared and
  tested locally. Do not say it is released, available in stores or validated on
  all devices.
- Updates follow-up: show explicit `Completed`, `In progress` and `Planned`
  labels only for statements supported by committed repository state. Use a
  visible qualification such as `Bundled update · 31 Jul 2026` so the date is
  understood as content packaged with the build.

The two cards are information, not actionable live destinations. Their status
must use words/icons, not color alone, and remain concise at 200-percent text.

### 34.2 Purchase and Catalogue

Store/date/time remain visibly required. Person and Payment Method are optional
metadata saved as separate nullable references on the Purchase. Payment Method
is a nickname/reference and never financial credentials.

Catalogue checkbox removal must not say Products were removed. No selection
count or bulk-action copy may remain. `View details` stays keyboard reachable.

### 34.3 History selection and disabled reasons

Selected count and semantics are independent from open detail. Every explicit
checkbox names its Purchase context and whether the action will select or
deselect it. The last selected row can be unchecked.

Disabled controls require an adjacent or semantic reason:

- `Select at least one purchase to use it in Analytics.`
- `Select at least one purchase to export a CSV.`
- `Select at least one purchase to export a PDF.`
- `All purchases currently shown are selected.`
- `No selected purchases to clear.`
- `An export is already in progress.`

Filters prune the action set. After a filter change, announce the new selected
count. `Select all shown` always means the current filtered rows within the
loaded recent-50 window.

### 34.4 Analytics handoff

Use `Use in Analytics`. Destination copy must communicate:

```text
Received {requested} purchases from History.
{matched} are available in this Account and prepared as the analysis scope.
{unavailable} could not be matched and were not used.
Choose the remaining analysis settings, then Run & save analysis.
```

Omit the unavailable sentence when the count is zero. Do not say `Analytics will
calculate`. The handoff performs no calculation, creates no saved record and
does not change History. Analytics owns the selected Item scope and retains the
PH04 maximum of 500 Item IDs.

### 34.5 Export destination and failures

Success is announced only after the final write succeeds and must name the
actual user-visible destination:

- Windows: `Exported {format} to Downloads: {final path}.`
- unsupported Android: `Public Downloads export is unavailable on this Android build. No file was created.`

Do not display success after resolving a path but before writing. Do not call a
temporary or app-private path Downloads.

Sanitized failure classes:

- destination unavailable: `Downloads is unavailable. No file was created.`
- permission denied: `Markei could not write to Downloads. Check access and try again.`
- name/collision exhaustion: `A safe export name could not be created. No existing file was replaced.`
- write failure: `The export could not be completed. No completed file is available.`
- already in progress: `An export is already in progress.`

Export and sharing remain different. There is no `Share list (PDF)` action in
PH05. Filenames may include format, UTC timestamp and a sanitized record or set
cue. They must not reveal Account, Device or raw database IDs.

## 35. Guide learning sequence

Create a local Guide with a contents list and eight focusable anchored sections.
No search, remote content or expandable topics are required.

| Section | Learner goal | Required concepts and action | Common misconception / claim ceiling |
| --- | --- | --- | --- |
| 1. Getting started | understand local-first navigation | Account scope, Home, ordinary pages | local app is not public/hosted truth |
| 2. Register a Purchase | record one immutable Purchase | Store/date/time, Products, optional Person/Payment, validation | optional references are not Account identity or credentials |
| 3. Catalogue and History | reuse Products and review facts | open Product details, filters, detail vs selection | Catalogue is not bulk selection; History window is bounded |
| 4. Lists | read derived Storage/Shortage/Market/All projections | projections from recorded Purchase history | projections are not inventory mutation or prediction |
| 5. Analytics | create and save one session analysis | Group by, Choose, Variables, Operation, Timeframe, Run & save | no automatic calculation, causality, prediction or restart persistence |
| 6. Settings, Account and devices | configure local references and distinguish support actions | Account, Person, Payment Method, threshold, Refresh/Connect/Sync | Person is not Account; Refresh is not Sync |
| 7. Audit and local diagnostics | interpret bounded local evidence | System, Readiness summary, Diagnostics, Activity history | no provider health, complete ledger, cause or repair |
| 8. Local data, export and Sync limits | understand storage and evidence boundaries | local data, Windows Downloads, Android unavailable state, explicit Sync | export is not share/upload; tests/builds are not production acceptance |

Every section must identify unavailable/deferred behavior honestly and avoid
calling a feature complete without named implementation/test/build evidence.
Anchored navigation moves keyboard focus to the section heading.

## 36. Audit state language

Use these meanings consistently:

- `Ready`: named local prerequisites appear ready in the bounded observation;
  it does not predict successful Sync.
- `Attention needed`: recorded local evidence warrants review; it does not prove
  a provider fault.
- `Unavailable`: a value or projection cannot be obtained now.
- `Unknown`: present evidence cannot classify the state.
- `Not yet checked`: no qualifying observation was requested or recorded.
- `Stale`: an older dated observation remains visible after a newer read failed
  or passed its accepted freshness boundary.
- `No recent records`: none exist in the displayed bounded local window; it does
  not prove nothing occurred elsewhere.

Audit cards are read-only. They contain no Sign in, Enroll, Sync, protocol Retry,
Recovery, clear-history or repair action. Existing Audit Retry repeats only the
same local read and must say that no Purchase or Sync fact is changed.

## 37. Settings meaning and short codes

Required reading order:

1. Account;
2. Purchase references and shortage timeframe;
3. Sync and Device;
4. Advanced.

Advanced is visible and non-collapsible. It contains only the existing explicit
`Connect this Device` and `Sync now` actions with consequence copy. Hosted probes,
Recovery and diagnostic deletion remain development-only/absent.

Distinct action language:

- `Refresh local status`: read local Account/Device/queue status only;
- `Connect this Device`: establish or confirm this installation's coordination
  record through the existing coordinator;
- `Sync now`: exchange eligible facts through the existing coordinator;
- `Action already in progress`: no duplicate starts;
- `Current local status is unavailable`: no provider-cause inference.

`@NNN` is the Person short/reference code. `#NNN` is the Payment Method
short/reference code. Both are sequential stored visible references; neither is
a hash, fingerprint, credential or complete internal identity. Existing codes
remain stable and legible. `$NNN` is absent and must not appear.

## 38. Accessibility and evidence gates

Automated evidence must cover:

- checkbox select/deselect semantics with Purchase context;
- selected-count announcements and disabled reasons;
- visible keyboard focus and predictable return after handoff/export/Guide jump;
- Catalogue detail activation without selection semantics;
- Guide heading hierarchy and anchor focus;
- Audit card summary naming card, state, bounded source and observation time;
- Settings action/loading/already-in-progress/final-result announcements;
- non-color state meaning and 200-percent-text reachability;
- equivalent compact/medium/wide meaning at 599/600/1023/1024.

Automated semantics tests do not establish Narrator/TalkBack quality or learner
comprehension. H must distinguish represented, executable, automated, rendered,
build, platform, human-observed and learner-understood evidence.

## 39. Prohibited claims and H report

Do not claim live News, public release, complete History, Account-wide select-all,
automatic Analytics, Purchase mutation, native sharing, Android public Downloads,
provider health, causal diagnosis, repair, prediction, ranking, recommendation,
production acceptance or KANBAN maturity.

`KANBAN_TRANSITIONS=NONE`.

Replace H with exact final vocabulary, copy decisions, disabled/failure states,
Guide sections, Audit meanings, Settings distinctions, short-code interpretation,
accessibility evidence and the human/learner evidence ceiling.

Required terminal:

```text
CYCLE=C11
PHASE=C11-PH05
ROUND=C11-PH05-R01
HOME_STATIC_CLAIM_CEILING=PASS | FAIL | BLOCKED
PURCHASE_REQUIRED_OPTIONAL_MEANING=PASS | FAIL | BLOCKED
CATALOGUE_SELECTION_VOCABULARY_REMOVED=PASS | FAIL | BLOCKED
HISTORY_ZERO_ONE_MANY_VOCABULARY=PASS | FAIL | BLOCKED
HISTORY_SELECT_ALL_SHOWN_SCOPE=PASS | FAIL | BLOCKED
USE_IN_ANALYTICS_COPY=PASS | FAIL | BLOCKED
NO_AUTOMATIC_ANALYSIS_OR_RECORD=PASS | FAIL | BLOCKED
EXPORT_DESTINATION_COPY=PASS | FAIL | BLOCKED
EXPORT_SHARING_DISTINCTION=PASS | FAIL | BLOCKED
GUIDE_EIGHT_SECTIONS=PASS | FAIL | BLOCKED
AUDIT_READINESS_CLAIM_CEILING=PASS | FAIL | BLOCKED
SETTINGS_CONCEPTUAL_ORDER=PASS | FAIL | BLOCKED
REFERENCE_CODE_LANGUAGE=PASS | FAIL | BLOCKED
TEXT_SCALE_200=PASS | FAIL | BLOCKED
KEYBOARD_FOCUS_SEMANTICS=PASS | FAIL | BLOCKED
SCREENSHOT_REVIEW=NOT_PERFORMED | PERFORMED
ASSISTIVE_TECH_REVIEW=NOT_PERFORMED | PERFORMED
LOCALE_REAL_DEVICE_REVIEW=NOT_PERFORMED | PERFORMED
HUMAN_COMPREHENSION=NOT_ESTABLISHED | ESTABLISHED
KANBAN_TRANSITIONS=NONE | CONTRADICTED
PROHIBITED_CLAIMS=ABSENT | CONTRADICTED
NEXT_DIDACTIC_REVIEW=Reconcile PH05 H and run bounded human comprehension/accessibility review.
```
