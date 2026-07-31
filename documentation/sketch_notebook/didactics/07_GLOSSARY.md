# 07_GLOSSARY.md

> Domain: Didactic
> Status: Current derivative — reconciled through C11-PH03
> Authority source: `didactics/02_KANBAN.md`
> Purpose: Compact terminology retrieval; no independent truth or maturity change
> Maturity: unchanged

## Evidence and acceptance

### Evidence state and validation boundary

**KANBAN ID:** `&&&05`

A claim is limited to the named environment, action and evidence obtained.
Source presence, tests, builds, practical assays, human platform acceptance and
learner evidence are distinct.

### Automated/build evidence

**KANBAN IDs:** `&&&05`, `%%%07`

Passing tests or builds establish only their named automated or compilation
boundary. They do not establish human comprehension, assistive-technology
acceptance, real-device acceptance or learner mastery.

### Development acceptance

**KANBAN ID:** `&&&05`

Acceptance inside a named development topology. Cycle 10 reached two Devices
and one Account in development; production acceptance remains absent.

### Client, server and provider evidence

**KANBAN IDs:** `&&&05`, `&&&09`, `&%%14`

Client declarations, server logs and provider inspection are independent
evidence sources. One source does not prove the contents of another.

### Project evidence is not learner maturity

**KANBAN ID:** `&&&05`

Implementation, tests, builds and practical assays may stabilize project
vocabulary. KANBAN maturity still requires direct learner explanation,
application, prediction, debugging or transfer under the standing rubric.

## Local-first and synchronization

### Local-first truth

**KANBAN IDs:** `&&&02`, `&&&10`

Durable Product, Purchase, queue and projection state owned locally by the
client. Local-first does not mean isolated or never synchronized.

### Hosted coordination

**KANBAN IDs:** `&&&09`, `&%%14`

Authenticated Account/Device exchange, ordering, download and acknowledgement
used to converge autonomous local truths.

### Readiness

**KANBAN IDs:** `&&&05`, `&%%14`

A bounded prerequisite/control result for hosted connectivity. It is not
ordinary Sync and does not prove upload, download, apply, cursor progress or
acknowledgement.

### Ordinary Sync

**KANBAN IDs:** `&&&09`, `&%%12`–`&%%14`

The bounded exchange that may upload, download, durably apply facts, advance a
cursor and acknowledge progress. A local queue row alone is preparation, not
Sync.

### Acknowledgement

**KANBAN IDs:** `&&&09`, `&%%13`, `&%%14`

A post-apply declaration of committed local cursor progress. It occurs only
after durable local application and is not all-Device convergence or backup.

### Same-Device proof

**KANBAN IDs:** `&&&05`, `&&&09`, `&%%14`

Hosted exchange evidence for one enrolled Device. It does not prove a second
Device or reciprocal convergence.

### Reciprocal two-Device convergence

**KANBAN IDs:** `&&&05`, `&&&09`, `&%%14`

Both preserved Devices exchange and apply facts in both directions with stable
projections, drained queues and idempotent no-op repeats. Cycle 10 proved this
only for one Account in development.

### Golden no-op repeat

**KANBAN IDs:** `&%%12`, `&%%14`

An ordinary Sync with no pending upload that downloads/acknowledges without a
duplicate business effect.

## Result and diagnostic evidence

### Current action result

**KANBAN IDs:** `&&&05`, `&&&10`

The terminal associated with the newest correctly identified action. It does
not erase prior operation evidence.

### Historical operation evidence

**KANBAN ID:** `&&&10`

Preserved chronological evidence from older actions. It remains useful for
causal learning but does not override the current action terminal.

### Transaction outcome

**KANBAN IDs:** `&%%05`, `&&&05`

Whether the intended business or protocol effect committed within its
transaction boundary.

### Diagnostic-persistence outcome

**KANBAN IDs:** `&&&05`, `&&&10`

Whether evidence about an operation was later stored and rendered. Failure here
does not erase a trusted response or committed transaction outcome.

### Blocked

**KANBAN IDs:** `&&&03`, `&&&05`, `&%%14`

A prerequisite prevented the named phase from proceeding.

### Not-applied

**KANBAN IDs:** `&&&03`, `&&&05`, `&%%14`

The intended business effect was not committed.

### Applied

**KANBAN IDs:** `&&&03`, `&&&05`, `&%%14`

The intended business effect committed within the stated boundary.

### Duplicate-equivalent

**KANBAN IDs:** `&%%12`, `&%%14`

An idempotent result: the equivalent fact already exists, so replay creates no
second business effect.

### Unknown outcome

**KANBAN IDs:** `&&&05`, `&%%12`, `&%%14`

The available evidence cannot determine the outcome. It is not a synonym for
rejected, failed or not-applied.

## Identity and catalogue

### Stable identity

**KANBAN ID:** `&&&06`

A durable identifier for one logical subject independent of mutable labels.

### Product code

**KANBAN IDs:** `&&&03`, `&&&06`, `&%%08`

The mandatory immutable user-visible code for a Product. It is not the local
Product UUID, natural identity or Event UUID.

### Natural Product identity

**KANBAN IDs:** `&&&06`, `&%%08`

The exact normalized semantic facts used to reconcile the Product subject.
Similarity is advisory and never auto-merges.

### Local Product UUID

**KANBAN ID:** `&&&06`

The opaque local relational identity for one Product record. It is not the
Product code or hosted Event UUID.

### Event UUID

**KANBAN IDs:** `&&&06`, `&%%11`

The immutable identity of one append-only synchronization event. It identifies
the event, not the Product.

### Reusable Catalogue

**KANBAN ID:** `&%%07`

The Account-private set of recurring Products referenced by Purchases.
Catalogue Products are reusable subjects, not Purchase Items.

## Purchase, history and Lists

### Purchase occurrence time

**KANBAN IDs:** `&&&03`, `&&&10`, `&%%09`

The local civil date/time when buying happened, distinct from insertion time.

### Purchase aggregate

**KANBAN ID:** `&%%09`

The consistency boundary owning one Purchase, its Items and required persistence
effects.

### Purchase Item

**KANBAN ID:** `&%%10`

A Product-specific commercial observation inside one Purchase.

### Historical integrity

**KANBAN ID:** `&&&10`

Registered facts retain their original Product and optional reference meaning;
later relabelling does not rewrite history.

### Lists projection

**KANBAN IDs:** `&&&02`, `&%%17`

A rebuildable estimate derived from registered Purchase history. It is not
recorded or measured inventory.

### Estimate

**KANBAN IDs:** `&&&02`, `&%%17`

A derived projection from compatible Purchase-history observations.

### Approximate

**KANBAN IDs:** `&&&03`, `&%%17`

A qualifier stating that the displayed projection is uncertain rather than a
recorded exact fact.

### Unavailable

**KANBAN IDs:** `&&&03`, `&%%17`

No usable estimate is available under the current data boundary.

### Not enough history

**KANBAN IDs:** `&&&02`, `&%%17`

A Product has one compatible observation but not enough intervals to estimate a
personal cycle.

### Expected ended

**KANBAN IDs:** `&&&02`, `&%%17`

A projected state derived from Purchase history. It is not recorded depletion.

## Presentation states and accessibility

### Loading

**KANBAN IDs:** `&&&03`, `%%%07`

A local read/projection is still in progress; no empty or failure conclusion is
yet justified.

### Local read error

**KANBAN IDs:** `&&&03`, `&&&05`, `%%%07`

The local projection read failed. In Lists, the message states that local data
was not changed.

### First-use empty

**KANBAN IDs:** `&&&03`, `&%%17`

No projection data exists yet; this is not a filtered result.

### Filtered empty

**KANBAN IDs:** `&&&03`, `%%%07`

Data may exist, but the current search/filter produces no visible match.

### Read-only Retry

**KANBAN IDs:** `&&&03`, `&&&05`, `%%%07`

Repeats only the failed local projection request and does not mutate local data,
perform Sync or contact a provider.

### Responsive information equivalence

**KANBAN IDs:** `%%%07`, `&&&05`

Wide tables and compact cards preserve the same meaning, state and reachable
actions even when density and grouping change.

### Accessibility evidence boundary

**KANBAN IDs:** `%%%07`, `&&&05`

Breakpoint, reachability and text-scale widget tests are automated evidence.
Narrator, TalkBack, keyboard-only and real-device acceptance require separate
human/platform evidence.

## Analytics and evidence

### Local Analytics

**KANBAN IDs:** `&&&03`, `&&&05`, `&%%17`

A deterministic, local and Account-scoped interpretation of recorded Purchase
evidence. It produces session-local records and typed results over supporting
Variables. A human-observed wrong-variable/unit mismatch remains active, so
current implementation does not establish calculation-variable integrity. It
does not forecast, recommend, rank, repair raw facts, use telemetry or claim
remote authority.

### Analysis card

**KANBAN IDs:** `&&&02`, `&&&05`, `&%%17`

A session-local result containing one determinant, one or more relational
variables, one operation, optional Time conditions, value or typed unavailable
outcome, factual interpretation, evidence count and applicable period.

### Determinant

**KANBAN IDs:** `&&&02`, `&%%17`

The named dimension that organizes an analysis: Product, Purchase, Store or UTC
Time. It is not merely a filter.

### Relational variable

**KANBAN IDs:** `&&&02`, `&%%17`

A learner-visible Purchase evidence field whose contribution is related within
the determinant groups and operation.

### Condition

**KANBAN IDs:** `&&&05`, `&%%17`

An optional restriction, including a UTC Time interval, applied to the evidence
scope. A condition narrows evidence; it does not become the determinant.

### Evidence row

**KANBAN IDs:** `&&&02`, `&&&10`

A traceable Purchase/item fact row supporting a card. The matrix exposes
Purchase, date/time, Product, Brand, Store, purchased by, purchased for, payment
method, quantity, unit price, line total and promotion with honest unavailable
states.

### Selected, filtered and focused evidence

**KANBAN IDs:** `&&&05`, `&%%17`

Selected evidence is the explicit Purchase-ID scope, bounded to 500 IDs.
Filtered evidence is the current query scope. Focused evidence is the subset
supporting one card. Reset restores the complete current evidence scope.

### Period

**KANBAN IDs:** `&&&05`, `&%%17`

The applicable UTC Time interval reported with a result. Time may instead be
the determinant; those meanings are not interchangeable.

### Result and interpretation

**KANBAN IDs:** `&&&03`, `&&&05`, `&%%17`

The result is the calculated value or typed unavailable outcome. The
interpretation is a factual sentence naming what that result means, its
determinant, evidence count and period. It is not an explanation of causes or a
recommendation.

### Sum

**KANBAN IDs:** `&&&03`, `&%%17`

The total contribution of the named variable over the evidence scope.

### Mean

**KANBAN IDs:** `&&&03`, `&%%17`

The arithmetic average contribution of the named variable over valid evidence.

### Difference

**KANBAN IDs:** `&&&03`, `&%%17`

Comparison B minus baseline A. Difference does not mean change over time unless
the named A and B comparisons explicitly make Time the comparison.

### Percentage

**KANBAN IDs:** `&&&03`, `&&&05`, `&%%17`

A named part divided by its named containing whole. It is never percentage
change. A zero denominator produces a typed unavailable outcome.

### Typed unavailable outcome

**KANBAN IDs:** `&&&05`, `&%%17`

An explicit non-result carrying its reason, such as a missing field, invalid
combination, insufficient evidence, zero denominator, read failure or numeric
overflow. It must not invent or repair a raw fact.

### Purchase and Item

**KANBAN IDs:** `&%%10`, `&&&10`

A Purchase is the transaction context. An Item is one Product contribution
inside it. They are not interchangeable evidence units.

### Purchase total and line total

**KANBAN IDs:** `&%%10`, `&%%17`

Purchase total covers the Purchase; line total covers one Item. Summing line
totals can support a Purchase total only where the evidence contract permits it.

### Store grouping and Store comparison

**KANBAN IDs:** `&&&03`, `&%%17`

Store grouping collects evidence by Store. Store comparison applies a named
operation to explicit Store groups. Grouping alone is not a comparison.

### History handoff

**KANBAN IDs:** `&&&02`, `&&&10`, `&%%17`

History transfers typed Purchase-ID context to Analytics. History does not
calculate, interpret or persist an Analytics card.

### Responsive semantic parity

**KANBAN IDs:** `%%%07`, `&&&05`

Wide tables and compact cards preserve the same field meanings, evidence scope,
selection, focus/reset behavior and reachable actions even when reading order
and density differ.

## Settings, Audit and product vocabulary

### Settings

**KANBAN IDs:** `&&&03`, `&&&05`

Local configuration and bounded Account, Device and Sync-readiness information
and actions. Settings is not Recovery, provider maintenance or a destructive
diagnostic console.

### Audit

**KANBAN IDs:** `&&&03`, `&&&05`, `&&&10`

Recent sanitized local application activity for the active Account and
environment. Audit is read-only and bounded; it is not Purchase History, current
status, hosted truth, telemetry, a complete ledger or a causal explanation.

### Purchase History

**KANBAN IDs:** `&&&02`, `&&&10`

Recorded Purchase facts and their learner-visible details. Purchase History does
not become operational Audit merely because both surfaces are chronological.

### Current status

**KANBAN IDs:** `&&&05`, `&%%14`

The latest locally observed Account, Device or Sync-readiness state. Current
status is configuration-adjacent present information; Audit is historical
evidence.

### Local activity window

**KANBAN IDs:** `&&&05`, `&&&10`

The bounded set of Audit attempts and events loaded from local persistence. A
window may be ready, empty, stale or unavailable and does not claim completeness
outside its displayed scope.

### Loading, empty, stale and unavailable

**KANBAN ID:** `&&&05`

Loading means the local read is in progress. Empty means no records exist in the
loaded window. Stale means prior records remain visible after a later read
failed. Unavailable means the requested local evidence could not be provided.
These states are not interchangeable.

### Diagnostic code

**KANBAN IDs:** `&&&03`, `&&&05`

A sanitized technical classification linked to safe guidance. It does not prove
the cause of an event or authorize repair.

### Closure

**KANBAN IDs:** `&&&03`, `&&&05`

Retired ordinary product vocabulary. Existing native Closure runners and
diagnostic infrastructure may remain unreachable for development or support;
their presence does not create a learner-facing destination.

### Bounded UI verification

**KANBAN IDs:** `&&&05`, `%%%07`

Human direction accepted the visible PH03 result for documentation closure and
deferred minor polish to C12-PH01. It does not establish a formal screenshot
set, assistive-technology behavior, locale coverage, real-device behavior or
learner comprehension.

## Current evidence boundary

- Cycle 10: same-Device hosted scope and reciprocal two-Device/one-Account
  development scope are closed; production acceptance is absent.
- C11-PH01-R01 and C11-PH02 remain implemented with focused automated and build
  evidence.
- C11-PH03 Settings, local Audit and Closure navigation retirement are
  implemented with focused automated/build evidence and bounded UI verification
  accepted for documentation closure.
- Formal screenshots, assistive technology, locale, keyboard-only practical use,
  real-device acceptance and direct learner comprehension remain unestablished.
- Minor PH03 visual polish is deferred to C12-PH01.
- Learner maturity: unchanged.
## C11-PH05 current learner vocabulary

### Optional purchase details

Independent optional Person and Payment Method metadata attached to a Purchase.
The label does not make Store, date or time optional and does not combine both
references into one tag.

### Catalogue detail activation

Opening one Product's details without selecting it for an ordinary set or bulk
action. Catalogue no longer uses checkbox, selection-count or selected-action
vocabulary.

### History detail and action selection

History detail opens one Purchase for inspection. Action selection is a separate
set containing zero, one or many Purchase IDs. Either state may exist without
the other.

### Select all shown

Select every Purchase in the current filtered loaded recent-History window. It
does not mean every matching Purchase in local persistence.

### Use in Analytics

Transfer selected Purchase IDs as an Analytics scope. It does not calculate,
save an analysis, mutate History or change Purchase facts.

### Requested, matched and unavailable Purchases

Requested counts the Purchase IDs handed off. Matched counts those resolved to
eligible local evidence. Unavailable counts requested IDs that could not be
matched. The three counts expose scope reconciliation rather than hiding gaps.

### Export and sharing

Export writes a file to an explicit destination and reports success only after a
final path exists. Sharing hands an existing artifact to another application or
person. Creating an export does not prove it was shared.

### Readiness summary

A bounded summary of locally available readiness evidence. It is not provider
Health, a causal diagnosis, a successful-Sync guarantee or a complete system
status.

### Account-first Settings

A reading order that begins with Account, then Purchase references and shortage
timeframe, Sync and Device, and Advanced actions. It is a conceptual order, not
a claim that every action has the same effect.

### Person and Payment Method reference codes

`@NNN` is the visible Person reference code. `#NNN` is the visible Payment
Method reference code. Both are local references, not credentials, hashes,
provider identities or substitutes for stable internal identity.

### Anchored Guide structure

Eight local sections with a focusable contents navigation. This structure is
implemented and automatically tested.

### Accepted Guide learner sequence

The intended teaching progression, including Lists as its own boundary plus
Getting started and local-data/export/Sync-limit concepts. The committed Guide
redistributes these concepts and therefore only partially realizes the accepted
sequence.

### Analytics learner-facing defect

A human-observed result may use or display a Quantity variable/unit unrelated to
the requested Variables and Operation. The cause is not established, and current
tests did not detect the mismatch.

### Accepted Analytics correction direction

A compact `Create analysis` composer with a unified typed `Variables`
control, two `dd-mm-yyyy` date fields, and learner-visible Date-Time of
purchase and Store name. This direction is accepted but not implemented.

### Evidence classes

- **Represented:** learner-facing meaning exists in code or copy.
- **Automated:** a named test checks a bounded behavior.
- **Built:** a named platform build completed.
- **Human-observed:** a person recorded a bounded runtime observation.
- **Learner-understood:** direct comprehension or transfer evidence exists.

These classes are not interchangeable.

## Current PH05 evidence boundary

- PH05 implementation is `426235d8b67ac719e494b53cfb23a6c3b06fb489`.
- H and J section 14 establish the automated/build ceiling and preserved
  accessibility limits.
- Guide structure is implemented/automated; accepted sequence fidelity is
  partially contradicted.
- Analytics has an active learner-facing wrong-variable/unit defect with unknown
  cause; its accepted correction direction is not implemented.
- A complete screenshot set, keyboard-only review, Narrator/TalkBack, locale,
  real-device review and learner comprehension remain unestablished.
- Learner maturity remains unchanged.\n\n`KANBAN_TRANSITIONS=NONE`.

## C11 Analytics correction — current terminology

### Variables

The one learner-visible selection set containing categorical breakdowns and
numeric measures. Selecting a category alone does not silently select or
calculate a measure.

### Purchased by

A categorical breakdown derived from recorded Person metadata. It subdivides a
numeric result and is not itself summed or averaged.

### Purchased for

A typed unavailable categorical field because current recorded evidence does
not support it. Unavailable is not an empty label, zero or inferred person.

### Payment method

A categorical breakdown derived from recorded Payment Method metadata.

### Quantity

A numeric measure displayed as a readable decimal quantity with its canonical
unit.

### Unit price

A numeric measure displayed as currency per canonical unit.

### Price paid

The learner-facing name for an Item line-total numeric measure, displayed as
currency.

### Purchase total

A numeric measure for the whole Purchase, displayed as currency. It is distinct
from one Item's Price paid.

### Evidence count

An explicit integer numeric measure counting contributing evidence rows. It is
never an implicit fallback for categorical-only selection.

### Categorical-only selection

A Variables choice containing no numeric measure. The interface asks for at
least one numeric variable and inserts neither Evidence count nor Quantity.

### Unsupported operation

A typed invalid combination whose guidance names the selected Operation and
numeric Variable and states the smallest correction.

### Initial date and Final date

Inclusive local calendar boundaries entered as `dd-mm-yyyy`. Missing, invalid
and reversed pairs receive distinct correction guidance.

### Saved analysis

An immutable session record created by `Run & save`. Later live-draft changes
or `Clear draft` do not modify it.

### Live draft

The current unsaved Group by, Variables, Operation and Timeframe choices. It is
not a saved analysis.

### Frozen record

The immutable saved analysis from which Chart, Table, interpretation, CSV and
PDF derive the same selected-variable meaning and formatted values.

### Readable result scales

Decimal quantity, decimal currency, currency per unit, percentage, signed
Difference and integer Evidence count. Raw fixed-point integers and
compatibility keys are storage/dispatch details, not ordinary result labels.

### Learner-facing evidence labels

`Date-Time of purchase`, `Store name`, Purchased by, Purchased for, Payment
method, Item count, Purchase total and Item facts. Ordinary relational UUIDs are
not evidence labels.

### Automated correction evidence

The ten-case regression matrix plus selected-variable/projection integrity,
compact/wide, 200-percent text containment and semantics tests. This evidence
classifies current automated behavior; it does not establish human acceptance
or comprehension.

### Superseded screenshot defect classification

The PH05 screenshot mismatch remains historical defect-finding evidence, but it
no longer describes the current automated implementation after correction
`17fd6529…`. No human screenshot acceptance follows.

### Guide sequence deviation

The PH05 Guide's anchored structure is implemented, while its accepted teaching
sequence remains partially contradicted. The Analytics correction does not
repair that deviation.

## Current correction evidence boundary

Implementation `17fd65296e960112787b870363b40339f535f5b6`, complete H and J
section 16 establish the automated correction boundary. Screenshot acceptance,
keyboard-only human acceptance, Narrator/TalkBack, locale, real-device
acceptance, learner comprehension and transfer remain unestablished.
`KANBAN_TRANSITIONS=NONE`.
