# J_[M]_STAGE

> Cycle: 08 — Shared-Client Product Beta
> Round: C08-R01 Main reconciliation
> Status: PROVISIONAL MAIN SYNTHESIS — NOT AUTHORIZED FOR CODEX
> Repository: `gus-i-gu/markei`
> Branch: `cycle-08-shared-client-product-beta`
> Entry baseline inspected by A/B/C: `60105fab8eac4ac858d8a36674e358737e1c9f98`
> Inputs: `A_OPERATIONAL.md`, `B_DIDACTIC.md`, `C_DESIGN.md`
> Authority: Main Chat [M] under human supervision
> Scope: Cross-domain reconciliation and next-round staging direction; no implementation authority

---

# 1. Reconciliation boundary

This section reconciles Cycle 08 Round C08-R01 functional investigation.

Input blobs:

- Operational A: `11db9c9532377296538f4eac1999961d20c0a99c`;
- Didactic B: `bfa8667f23a55860e2a2959e86730169dd286f5a`;
- Design C: `ea2ea564d098a89f23d3519989144a2602d29aba`.

The required branch contains three narrow A/B/C publication commits after the Cycle 08 entry baseline. Each report inspected repository truth against the named Cycle 08 branch. A and C used remote GitHub evidence because their working spaces were not usable checkouts; B additionally verified a clean local checkout at the entry baseline.

This difference affects local-worktree evidence only. It does not create a substantive conflict in the repository findings.

J does not promote A/B/C into permanent memory. It classifies their agreement, disagreements, proposed product direction, human decisions, and the next staging route.

# 2. Accepted carried baseline

The following is accepted prior evidence and remains protected:

- Cycle 07 closed at the shared-client technical-foundation boundary.
- The Python/PySide6 beta, its database, tests, packaging history, and rollback value remain protected.
- The Flutter client remains isolated in application-private storage and does not open the Python database.
- Flutter/Dart runs on Windows and Android within the evidenced debug/local boundary.
- The repository contains an inward dependency direction:

```text
Flutter presentation
→ application commands and query ports
→ independent Dart domain
← local infrastructure adapters implement ports
→ Drift-managed application-private SQLite
```

- Product has distinct internal identity, visible user code, display facts, and normalized identification facts.
- Exact normalized equivalence may support reuse; similarity remains advisory and never auto-merges.
- Purchase owns one or more immutable registered Items.
- Local registration atomically persists catalogue resolution, Purchase, Items, local event preparation, pending queue state, and Device-sequence advancement.
- Raw Purchase facts remain authoritative; projections and analytics remain rebuildable and versioned.
- A persistent installation-local Device UUID exists, but current-Device selection remains prototype-only.
- Local queue/event preparation is not synchronization.
- The present Flutter UI is a functional scaffold, not accepted product or visual design.
- Cycle 09 retains account/API/Neon/synchronization.
- Cycle 10 retains production hardening, signing, distribution, support, and controlled release.

# 3. Repository capacity for Cycle 08

A/B/C agree that the existing repository can support an additive local-first product-beta cycle without cloud infrastructure or an immediate framework replacement.

Existing capacity includes:

- explicit Flutter composition;
- domain/value models independent of widgets and Drift;
- Product and Store records;
- Catalogue query boundaries;
- multi-item Purchase validation;
- atomic local persistence;
- History summary projection;
- Drift v2 and one evidenced migration;
- versioned semantic fixtures/contracts;
- Flutter unit/widget coverage;
- Windows build/runtime evidence;
- Android debug build/emulator/runtime evidence;
- persistent Device identity and sequence;
- protected Python regressions.

Important gaps include:

- coherent responsive navigation;
- first-class Catalogue and Store journeys;
- staged Item edit/remove/cancel/review;
- explicit draft ownership and lifetime;
- safe duplicate-submit/retry identity;
- detailed Purchase History;
- Product observation history;
- versioned personal price comparison;
- complete empty/loading/validation/success/failure/recovery states;
- data-volume and performance evidence;
- migration failure and corruption recovery;
- backup/export promise;
- complete Windows/Android lifecycle and accessibility acceptance;
- explicit installation-to-Device invariant.

# 4. Cross-domain product spine

Main provisionally accepts the following shared product spine for further confrontation:

```text
responsive application shell
→ private reusable Catalogue
→ choose or create Store
→ choose/reuse/create Product
→ advisory similar-Product warning
→ stage Purchase Items
→ edit/remove/cancel
→ review Purchase
→ atomically register once
→ inspect detailed History
→ compare comparable personal Product observations
```

This is provisional product direction, not source authority.

Each step must expose:

- initial/empty state;
- loading or search state where relevant;
- input validation;
- reversible pre-commit editing;
- explicit commit boundary;
- success acknowledgement;
- failure classification;
- safe retry behavior;
- recovery or retained-input behavior;
- accessibility and responsive behavior.

# 5. Reconciled responsibility boundaries

## 5.1 Responsive shell

Provisionally accepted:

- semantic destinations remain shared across Windows and Android;
- narrow and wide layouts may present navigation differently;
- responsive choice follows available space and interaction conditions, not device branding;
- platform hosts do not own Product/Purchase rules;
- widgets own controllers, focus, and mounted-view mechanics;
- product/workflow state must sit below transient widget state when its required lifetime exceeds one mounted view.

Unresolved: exact destination set, breakpoint evidence, router/state mechanism, and restoration depth.

No new state-management or navigation dependency is justified in R01.

## 5.2 Catalogue and Product

Provisionally accepted:

- Catalogue is a private reusable Product collection;
- Product selection is based on visible identity and exact deterministic matching;
- exact reuse and advisory similarity remain distinct;
- similarity requires explicit human choice or “create anyway”;
- automatic merge is prohibited;
- internal UUID, user Product code, and display/identification facts remain distinct;
- Product correction, aliases, retirement, and merge policy remain deferred unless explicitly activated.

Unresolved: whether Catalogue is a top-level destination, whether Product code remains mandatory, and which visible identity facts lead the UI.

## 5.3 Store

Provisionally accepted:

- Store is an account-private reusable identity, not merely free text attached to every Purchase;
- Store selection/create should reuse one query/picker boundary;
- Store UUID is distinct from visible name;
- duplicate advice must not silently merge Stores.

Unresolved: top-level versus picker-only destination and minimum branch/location identity.

## 5.4 Purchase draft and review

Provisionally accepted:

- staged Item and registered Purchase Item are different states;
- draft state should be owned by an application-facing draft coordinator/view model rather than durable Purchase facts;
- widgets retain only view mechanics;
- the draft must support add, edit, remove, cancel, validation, running total, and review;
- registered Purchase facts remain immutable in the current Cycle 08 boundary;
- Purchase editing/deletion after registration remains deferred;
- navigation/rotation/background/process-death survival must be explicitly decided, not accidental.

Unresolved: exact draft lifetime and whether Review is a separate route/dialog or an explicit phase within an editable staged list.

## 5.5 Atomic registration and retry

Accepted distinction:

```text
atomicity
    all local Purchase facts/effects commit together or none do

idempotency
    repeating one logical submission cannot create a second Purchase effect
```

Current repository evidence establishes local atomicity, not duplicate-submit idempotency.

Provisionally favored for confrontation:

- application-generated submission/attempt UUID;
- durable uniqueness at the local persistence boundary;
- identical retry returns the prior result;
- conflicting content under the same submission identity fails atomically;
- UI busy-state prevents ordinary double taps but is not the identity guarantee.

This likely implies a schema/migration and contract decision. It is not authorized yet.

## 5.6 History and analytics

Provisionally accepted:

- History must separate list, Purchase detail, Product observations, and comparison projections;
- widgets must not traverse Drift rows or event JSON;
- comparisons derive from immutable Purchase Item facts;
- first analytics must be reproducible and versioned;
- incomparability is an explicit result, not zero;
- currency and dimensional basis must match;
- UI should initially prefer “price change in your purchases” or equivalent;
- two personal observations do not establish general or official inflation.

Unresolved: first comparison basis, treatment of package-size changes, interval selection, and whether “personal inflation/deflation” appears at all in the first beta.

# 6. User-facing vocabulary boundary

The following provisional vocabulary is safe for the next round:

| Concept | Preferred working language | Avoid |
| --- | --- | --- |
| reusable collection | Catalogue, My products, or Products pending human choice | database catalogue, central catalogue |
| exact reuse | existing Product / exact Product | fuzzy duplicate |
| advisory match | similar Product | duplicate unless exact |
| one-package content | package size | ambiguous Quantity |
| number purchased | packages bought | amount without unit |
| total acquired | total amount bought | normalized quantity as raw receipt fact |
| pre-registration line | staged Item / Item to register | Purchase Item before commit |
| commit step | register Purchase | upsert Purchase |
| derived comparison | price change in your purchases | official/general inflation |
| local preparation | registered locally | synced/uploaded/backed up |
| failure | validation failure, registration failure, or unknown outcome | saved when outcome is unknown |

No KANBAN maturity change is implied. Repository evidence remains distinct from learner mastery.

# 7. Operational validation direction

The next provisional stages should require evidence in layers:

1. repository safety and exact tracked-file inventory;
2. generated-source consistency;
3. formatting, analysis, Flutter tests, and Python regressions;
4. transaction rollback and duplicate-submit behavior;
5. migration, reopen, failed migration, and no-silent-reset;
6. Catalogue/Store/Purchase/History/analytics workflow tests;
7. responsive and lifecycle matrix;
8. bounded volume/performance tiers;
9. Windows and Android builds/runs;
10. manual product acceptance.

Required carried matrix:

- narrow/wide Windows;
- Android portrait/landscape;
- keyboard visibility and focus;
- Back behavior;
- larger text;
- background/resume;
- process termination and cold relaunch;
- registered History persistence;
- explicit draft behavior;
- no duplicate or partial registration.

Exact volume tiers, performance budgets, device classes, and manual-test cadence remain human decisions.

# 8. Migration, recovery, and backup boundary

Provisionally accepted:

- no direct opening or destructive conversion of the Python database;
- Flutter migrations remain forward, explicit, tested from representative prior state, and never silently reset local facts;
- raw facts remain authoritative and analytics rebuildable;
- recovery must distinguish missing database, migration failure, corruption, insufficient storage, and requested reset;
- diagnostics must avoid exposing Purchase contents;
- backup/export requires a versioned format, consistent read boundary, integrity check, and stated restoration promise;
- a UI export button without restoration evidence is not an accepted backup.

Human decision required: implement supported local export/restore in Cycle 08, or explicitly ship a device-local beta with a clear destructive-loss boundary until later recovery work.

# 9. Installation–Device debt

The current first-20/earliest-UUID selection remains bounded prototype debt.

Cycle 08 must:

- avoid deepening reliance on arbitrary selection;
- preserve Device identity through ordinary reopen/upgrade evidence;
- define how draft/backup/restore interacts with installation identity;
- keep Device distinct from Account authentication.

Hard requirement before Cycle 09:

```text
one local installation relation
→ references exactly one current Device
→ bootstrap is idempotent and concurrency-safe
→ sequence ledger belongs to that Device
→ historical Devices remain addressable
→ restore does not accidentally clone Device identity
```

Unresolved: materialize this during Cycle 08 hardening or carry it as an explicit Cycle 09 entry gate.

# 10. Conflicts and drift requiring handling

## 10.1 J filename drift

`INDEX.md` and some reports name `J_MAIN_STAGE.md`; the actual active file is:

`documentation/sketch_notebook/[M]_STAGE/J_[M]_STAGE.md`.

This is methodology/navigation drift. It does not authorize a rename or methodology edit during product staging.

## 10.2 Main continuity staleness

Older headers in 00/06 and the three permanent checkpoints retain Cycle 07 metadata. Their latest temporal sections control current recovery. Refresh is deferred to the appropriate reconciliation transition.

## 10.3 Local-checkout evidence asymmetry

B verified a local clean checkout. A/C lacked usable checkouts and used pinned GitHub evidence. Before Codex, a usable clean checkout plus `git ls-files` inventory is mandatory.

## 10.4 Store identity asymmetry

Product identity rules are materially stronger than Store reuse/branch rules. Store identity must be resolved before schema or UI instructions become executable.

## 10.5 Quantity ownership ambiguity

Current UI terminology collapses package size, package count, purchased amount, and normalized/comparable amount. Product-language and data-entry decisions must precede implementation.

## 10.6 Atomicity versus idempotency

The repository has atomic registration but lacks an accepted safe duplicate-submission invariant. D/E/F must not claim this is already solved.

## 10.7 Provisional D/E/F semantics

Existing methodology normally treats Main-approved D/E/F as implementation authority. Cycle 08 explicitly uses iterative D/E/F drafts.

Every intermediate file must contain:

```text
Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
```

Only explicit final human/Main activation makes D/E/F executable.

# 11. Human decision register

Decisions should be answered before enriched implementation staging.

## Product/navigation

1. Is Catalogue a top-level destination, primarily a Purchase selection surface, or both?
2. Is Store a top-level destination or picker/create flow only?
3. Should the UI title use Catalogue, Products, or My products?
4. Is Product code mandatory, optional, or advanced/internal-facing?

## Quantity and Store identity

5. For packaged goods, should users enter package size plus package count and derive total purchased amount, or enter all three with consistency validation?
6. What minimum facts distinguish Stores: normalized name only, optional branch/location label, or another visible identifier?

## Draft and registration

7. Must drafts survive tab changes, backgrounding, rotation/resize, or full process death?
8. Is Review a separate route/dialog or an explicit phase in the editable staged list?
9. Is a durable submission UUID accepted for Cycle 08?
10. For identical/conflicting retry, what result and user language should be shown?

## Analytics

11. Is the first comparison purchased-unit price, package-unit price, or a narrower Product-mode subset?
12. Should the UI use only “price change” initially, with personal inflation/deflation deferred or secondary?
13. Which two observations or time interval does the user select?

## Recovery and acceptance

14. Must Cycle 08 include supported export and restore, or may it ship with an explicit local-only data-loss warning?
15. What Catalogue/History volumes and response-time budgets define beta acceptance?
16. Which Android devices and Windows resolutions/scaling combinations are required?
17. Is manual platform acceptance required after every product sprint or at integration/final gates?
18. Must the installation–Device invariant be fixed in Cycle 08 hardening or only before Cycle 09 begins?

# 12. Provisional Cycle 08 sequence

Main provisionally recommends:

```text
Sprint 01
    product decisions + repeated A/B/C ↔ J ↔ provisional D/E/F

Sprint 02
    responsive shell + explicit presentation-state/error boundary

Sprint 03
    Catalogue + Store + Purchase draft/edit/remove/review
    + accepted duplicate-submit boundary

Sprint 04
    History detail + Product observations
    + first versioned price comparison

Sprint 05
    migration/reopen/recovery
    + backup/export decision
    + data-volume/performance
    + Windows/Android lifecycle acceptance
    + installation–Device disposition
```

Main may split schema-bearing idempotency from the broader UI workflow if risk or reviewability requires it.

# 13. Provisional D/E/F preparation constraints

The next Main transition may populate D/E/F only as enriched drafts.

Every file must begin with:

```text
Status: PROVISIONAL — NOT AUTHORIZED FOR CODEX
Round: C08-R01
Purpose: Domain confrontation; no implementation authority
```

## D_OPS_STAGE should draft

- repository/checkout preflight;
- existing validation baseline;
- responsive/lifecycle matrix;
- migration/recovery/data-volume gates;
- backup/export acceptance alternatives;
- exact cost and stop conditions;
- no host or source mutation.

## E_DDC_STAGE should draft

- selected/provisional product vocabulary;
- validation, success, failure, retry, and recovery language;
- quantity terminology;
- History/analytics claims;
- learner-evidence boundary;
- no KANBAN promotion.

## F_DSN_STAGE should draft

- responsive shell responsibility;
- destination alternatives;
- draft coordinator and lifetime alternatives;
- Product/Store identity;
- atomicity/idempotency distinction;
- History/analytics ports;
- schema/dependency consequences;
- Device invariant timing;
- reversibility and non-goals.

These drafts must expose alternatives and questions rather than prescribe source edits.

# 14. Next round route

```text
C08-R01 A/B/C
→ this J reconciliation
→ human answers the decision register where possible
→ Main writes provisional D/E/F
→ O/A/D confront J + provisional D/E/F
→ replace A/B/C as C08-R02
→ Main enriches J and replaces provisional D/E/F
→ repeat until scope, language, files, schema effects,
   rollback, validation and non-goals are stable
→ explicit final human/Main activation of D/E/F
→ PRI-CODEX
→ Codex materialization
→ G/H/I
→ PDR2 permanent reconciliation
→ Main continuity refresh
```

# 15. Authority state

```text
Cycle 08: active
Round C08-R01 domain investigation: reconciled provisionally in J
A/B/C: evidence and proposals, not canon
J: Main synthesis, not implementation
D/E/F: not yet populated for this round
Codex: inactive
source/dependency/schema/tool changes: unauthorized
permanent-domain promotion: inactive
Cycle 09/10: scheduled and inactive
```

This J section authorizes only the next human-decision and provisional-staging round. It does not authorize implementation, commits outside named staging, or Codex execution.
