# J_MAIN_STAGE — Cycle 09 Sprint 02 Controlling Reconciliation

> Sequence: FLX-INV-02 → Main synthesis → FLX-ORD-01 materialization staging
> Unit: C09-S02 — Functional correction and UI convergence
> Status: RECONCILED; D/E/F PREPARATION AUTHORIZED; CODEX ACTIVE ONLY THROUGH D/E/F
> Branch: `intermid-cycle-recovery`
> Reconciled investigation HEAD: `a4374794d707e6a2a502ed67d447c713702e1851`
> Implementation baseline: `e37cb700feeca4001cc7835b584c46bb81926af3`
> Inputs: A/B/C Sprint 02 stages, observations, human decisions and target images 01–05
> Authority: human-supervised Main synthesis

---

<!-- ROUND_MARKER:C09-S02-CONTROLLING-RECONCILIATION-2026-07-14 -->

## 1. Purpose and authority

This J closes the Sprint 02 investigative decision round and supplies the controlling
cross-domain synthesis for D/E/F. A/B/C remain provisional investigation. D/E/F jointly
authorize Codex materialization; no instruction should be inferred from J alone.

Earlier J states remain recoverable in Git. Sprint 01 implementation evidence remains
historical truth and must not be relabelled as Sprint 02 validation.

## 2. Evidence reconciliation

- A at `a437479` confirms current source gaps, SDK-first feasibility, validation needs,
  dependency risk and incremental rollback boundaries. It reran no host command.
- B at `0b475b9` defines the visible language, interaction semantics, recovery copy and
  accessibility equivalence. It changes no learner maturity.
- C at `16cd3ec` defines the token/component architecture, data boundaries, query repair,
  migration alternatives and incremental materialization order. It reran no tests.
- Current screenshots 06–10 remain observational evidence of the sparse scaffold.
- Target images 01–05 are now persistent DEV_STAGE reference assets and define accepted
  product direction, not literal pixel authority.
- Current application truth remains `e37cb70`: schema v3, optional local references,
  Home/Lists/Settings, exact lookup ports, typed failures, CSV/PDF bytes and prior tests.
- Sprint 02 functionality, schema v4, native sharing and visual convergence remain
  unimplemented until Codex reports evidence through G/H/I.

## 3. Management decisions accepted

### 3.1 Person and Payment Method identity

- People receive immutable visible sequential codes `@001`, `@002`, ….
- Payment Methods receive immutable visible sequential codes `#001`, `#002`, ….
- Sequences are Account-scoped, monotonically increasing and never reuse an issued code.
- Width expands after 999 (`@1000`, `#1000`); leading zeros apply only below 1000.
- Opaque UUID remains the database/FK identity; visible code is organizational identity.
- UI presents `code · nickname` and always permits `Not assigned` during Purchase.
- Create is allowed. Rename/edit and physical delete are not exposed in Sprint 02.
- Existing archive/history integrity must remain; archive is non-destructive and must never
  permit code reuse. No Payment credential is stored.

### 3.2 Product code

- Every Product must have a non-null, normalized, Account-scoped unique visible code.
- New codes are entered by the user when the Product is first established.
- Product code is immutable after creation and remains one code for one exact identity set.
- PACKAGED identity is Name + Brand + Package quantity/unit; BULK identity is Name + Brand.
- Exact code entry in Purchase resolves one Product and fills Product Name, Brand, mode and
  package quantity/unit when applicable. It does not add a Purchase Item automatically.
- Exact identity collision and exact code collision select/explain the existing Product;
  similarity remains advisory and never auto-merges.
- Legacy null codes require deterministic reserved backfill before a NOT NULL constraint;
  migration-assigned legacy codes are the sole exception to user establishment.

### 3.3 BULK pricing

- BULK requires Amount bought, Unit and Price per that same selected unit.
- The pair is explicit: `kg × price/kg`, `g × price/g`, `L × price/L`, `ml × price/ml`
  or integral `un × price/un`; mixed amount/rate units are rejected.
- The calculator normalizes amount and rate internally before final currency rounding.
- Line total is calculated half-up in integer minor units and remains read-only.
- There is no override in Sprint 02 and no second persisted authoritative price fact.

### 3.4 Purchase occurrence date/time

- Purchase date and time represent the buying moment, not insertion/upsertion time.
- Fields appear immediately after Store, start blank and are manually required.
- Visible format is `dd/mm/yyyy` and `HH:mm`; Review/History show both consistently.
- The entered local civil value converts to the existing UTC occurrence instant at the
  application boundary. Zone/offset metadata is deferred; repeated-hour limitation is
  documented. Invalid or nonexistent values retain the draft and focus the field.

### 3.5 Lists

- `All` includes every Account Product, including zero-history Products.
- Two or more compatible distinct local Purchase dates are required for an available cycle.
- Zero history → `No Purchase history`; one compatible date → `Not enough history`.
- Incompatible facts remain visible with a reason; they do not become zero or disappear.
- Cycle is derived from compatible date intervals. Shortage threshold defaults to five days
  and remains locally configurable.
- Remaining days greater than threshold → Storage; zero through threshold → Shortage;
  negative remaining days → Market. Boundary-day tests are mandatory.
- Lists remain transient projections; no manual List, inventory count or cache table.

### 3.6 Errors and sharing

- Error descriptions and recovery methods use a typed, version-controlled source registry,
  not a database table. User data stores no error catalogue.
- UI failures expose code/operation, field when applicable, reason, retained-state promise,
  next action and known-applied/not-applied/unknown outcome without raw exceptions.
- Sprint 02 should attempt native OS sharing for selected-Purchase PDF output through a
  minimal maintained adapter/dependency that supports Windows and Android.
- If native sharing is host-blocked or unsupported after bounded investigation, PDF bytes
  and deterministic save/export must remain usable and the limitation must be reported;
  no silent upload or unrelated platform expansion is allowed.

## 4. Accepted UI direction

- Target palette direction: cream canvas, white primary surfaces, dark-green primary
  navigation/actions, lavender secondary/informational surfaces and explicit semantic states.
- Expanded layouts use grouped labelled navigation, page headers, cards/panels and tables.
- Compact layouts use Product/Purchase cards and `Home / Lists / Purchase / History / More`.
- `More` exposes Catalogue, Settings, Guide, Documentation and future/PIN destinations.
- Product selection, Product details and adding an Item remain separate actions.
- Catalogue/Purchase Product double-click opens Product details; explicit Select/Use remains.
- History double-click toggles/selects its Purchase row; checkboxes/tap/keyboard remain primary.
- Loading, empty, no-match, unavailable, validation, failure, unknown, selected, disabled and
  success states must be visibly and semantically distinct.
- Light theme is sufficient in Sprint 02; dark mode is deferred.
- Candidate breakpoints `<600`, `600–1023`, `≥1024` begin testing but may change from evidence.

## 5. Materialization order

```text
1. Safety/baseline and tests
2. Markei tokens, shared components and adaptive shell
3. Schema v4: visible reference codes + Product code NOT NULL
4. Purchase occurrence, exact Product fill, Product details and BULK calculator
5. Catalogue selection/details and immutable-code presentation
6. Lists query/read model and responsive page
7. History/Settings identity and action hierarchy
8. Native share adapter with deterministic fallback
9. Full responsive, accessibility, file-backed and platform validation
10. G/H/I evidence reports
```

Horizontal foundation precedes vertical slices. Each checkpoint must keep the app runnable,
preserve registered facts and allow independent rollback. Codex must not execute one broad
restyle/schema/query/plugin mutation without intermediate tests.

## 6. Preserved boundaries

Deferred: authentication, API/cloud sync, developer analytics, Store redesign, Product
merge/correction, Product-code editing, Person/Payment rename/delete, SubmissionId,
persisted drafts, registered Purchase mutation, manual Lists, Analytics calculations,
Household behavior, dark mode and production distribution.

Protected: Python/PySide6 source/database and its release tests, except running regressions.

## 7. Controlling handoff

D owns execution, migration, validation, dependency and stop gates. E owns visible language,
interaction meaning, state semantics and accessibility equivalence. F owns dependency
direction, schema/domain/application contracts, component architecture and query boundaries.

All three must be read together after AGENTS/INDEX and the full methodology boot. If D/E/F
conflict, omit a decided requirement, cannot preserve migration data, or require scope beyond
section 6, Codex stops before mutation and returns the contradiction to Main.

```text
state: decisions reconciled
Codex authority: D + E + F jointly
evidence destination: replace G + H + I
permanent promotion: not authorized until post-Codex reconciliation
```
