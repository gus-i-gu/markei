# F_DSN_STAGE — Cycle 09 Sprint 02 Architecture and Materialization Contract

> Sequence: FLX-ORD-01 — Main-approved materialization
> Unit: C09-S02 — Functional correction and UI convergence
> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED ONLY WITH D/E
> Branch: `intermid-cycle-recovery`
> Report: replace `DEV_STAGE/I_DSN_CODEX.md`

## 1. Methodology and architecture authority

Codex must complete D's executive-context boot before repository exploration or mutation.
This F controls dependency direction, schema evolution, application/domain ownership,
presentation composition, platform adapter boundaries and incremental materialization.

Preserve:

```text
Flutter presentation and Markei components
→ application commands, query ports, read models and typed outcomes
→ independent Dart domain invariants/calculations
← local Drift repositories and platform share/file adapters
→ app-private SQLite schema v4
```

Widgets never consume Drift rows, generated table classes, raw SQL errors or platform-channel
objects. Generated Drift code is derived. Handwritten schema/migration files remain authority.
Keep composition explicit and preserve the protected Python/PySide6 application/database.

## 2. Attached target evidence

Codex must inspect these five persistent target references before designing components:

![Target 01 — Lists](references/c09_s02/01_lists_target.png)

![Target 02 — Catalogue](references/c09_s02/02_catalogue_target.png)

![Target 03 — Home](references/c09_s02/03_home_target.png)

![Target 04 — Purchase](references/c09_s02/04_purchase_target.png)

![Target 05 — History](references/c09_s02/05_history_target.png)

Architectural interpretation: shared token/component foundation; adaptive shell; page-level
compositions; wide tables/panes; compact cards/routes/sheets; explicit state and action
hierarchies. Do not encode screenshots as one giant widget or page-local style duplication.

## 3. Authorized implementation surfaces

Codex may modify the smallest coherent subset within:

```text
clients/markei_flutter/lib/app/
clients/markei_flutter/lib/application/
clients/markei_flutter/lib/domain/
clients/markei_flutter/lib/infrastructure/local/
clients/markei_flutter/test/
clients/markei_flutter/pubspec.yaml
clients/markei_flutter/pubspec.lock
clients/markei_flutter/android/       # native-share dependency only
clients/markei_flutter/windows/       # native-share dependency only
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Codex may add focused Dart files/tests under existing Flutter architecture and regenerate the
existing Drift artifact. Do not modify reference PNGs, permanent notebook files, J/D/E/F,
methodology, other clients or Python source/data.

New dependencies are prohibited except one minimal native share/save dependency set after
D's audit. Do not add a UI framework, table library, icon pack or date/time package unless
the Flutter SDK demonstrably cannot satisfy a named requirement and Codex stops for Main.

## 4. Presentation architecture

### 4.1 Token/theme layer

Create a compact in-repository design system, preferably under `lib/app/design/` or an
equally coherent existing convention:

- `MarkeiTokens` / Theme extension for canvas, surfaces, primary/secondary and semantic
  colors; spacing; radius; borders/elevation; control density; typography.
- Material 3 `ThemeData` consumes tokens rather than hard-coded page colors.
- Light theme only. Every semantic state passes contrast and non-color communication tests.
- Candidate scale from C may guide implementation: spacing 4/8/12/16/24/32/48; control
  heights 40/48/56; radius 8/12/16. Exact constants may change through evidence.

### 4.2 Shared component layer

Prefer small typed components under `lib/app/widgets/`:

- adaptive shell, expanded sidebar/rail and compact navigation/More surface;
- page header, toolbar, section/surface card and responsive form grid;
- summary/stat card, filter bar/filter sheet and status chip;
- loading, empty, no-match, unavailable, error, unknown and success panels;
- selection toolbar;
- responsive data view supporting wide table and compact card builder;
- Product row/card, Product details surface and Product selector/result;
- local occurrence date/time field group;
- reference selector/row rendering visible code + nickname;
- quantity/unit/price calculator group;
- typed failure banner.

Components accept immutable application read models and callbacks. They do not own database
queries or cross-page domain logic.

### 4.3 Page and state ownership

- Shell owns selected destination and adaptive navigation presentation.
- Purchase page owns transient draft controllers, selected Product/reference and review mode.
- Catalogue owns transient selection/filter/view state.
- Lists owns transient view/filter state; projections come from application query port.
- History owns transient selected Purchase-ID set and expanded/detail state.
- Application/domain owns validation, identity, calculations and query/command outcomes.
- Keep `IndexedStack` or an equivalent state-preserving shell only where it does not create
  stale projections; refresh Lists/History through explicit invalidation after registration.

Breakpoints begin at compact `<600`, medium `600–1023`, expanded `≥1024`. Treat them as
presentation policy constants, not domain facts; tests may justify adjustment.

## 5. Schema v4 architecture

Current schema v3 already contains People, PaymentMethods, AccountPreferences, optional
Purchase FKs and nullable BULK package count. Schema v4 adds only reconciled visible identity
and Product-code constraints.

### 5.1 People and Payment Methods visible codes

Add immutable non-null text columns:

```text
People.visibleCode          // @001, @002, …
PaymentMethods.visibleCode  // #001, #002, …
```

Constraints:

- unique `(accountId, visibleCode)` for each table;
- format generated internally, never accepted as user input;
- Account-scoped monotonically increasing numeric suffix;
- suffix rendering minimum width 3, expanding naturally after 999;
- archive never frees/reuses a code;
- UUID remains PK/FK; code is stable user-facing organizational identity;
- code has no update operation in repository/application/UI.

Sequence ownership alternatives:

1. transactionally compute `max(parsedSuffix)+1` over all active/archived Account rows;
2. store explicit next counters in AccountPreferences or a dedicated Account-scoped sequence
   table and allocate/update inside the create transaction.

Select the smallest design that proves atomic monotonic allocation, no reuse, rollback and
concurrent-create safety in Drift/SQLite. Do not infer next value from row count. If explicit
counters are used, name them narrowly (`nextPersonCode`, `nextPaymentMethodCode`) and backfill
them from the maximum assigned suffix plus one.

Backfill order per Account:

```text
createdAt ascending → immutable UUID ascending
```

Assign `@001...` and `#001...` independently. Preserve UUID, nickname, active/archive state,
timestamps and every Purchase FK. Reopening must reproduce stored codes, not recalculate them.

Repository/application contract becomes create/list/archive/reactivate as currently supported,
but Sprint 02 UI exposes no rename/edit/delete. Remove or keep internal rename methods only if
tests/current architecture require them; no public presentation path may invoke them. Physical
delete remains absent.

### 5.2 Product visible code NOT NULL and immutability

Current Product code columns are nullable in Drift even though creation/migration usually
supply values. In v4:

- `userProductCode` and normalized code representation become NOT NULL;
- `(accountId, normalizedProductCode)` remains unique;
- new Product command requires a nonblank user-entered code;
- repository update operations cannot change code;
- Product UUID and exact identity normalization remain separate;
- PACKAGED exact identity includes normalized Name/Brand/mode and canonical package amount,
  kind/unit; BULK exact identity includes normalized Name/Brand/mode and no package facts.

Preflight v3 rows before rebuild. Preserve every valid existing code exactly in display form.
For null/blank legacy rows only, derive a reserved deterministic code from immutable Product
UUID, collision-check it Account-wide and persist it before NOT NULL. Use a clearly reserved
format that cannot be confused with ordinary user entry; document it in G/I and prevent new
user codes from using that reserved namespace if necessary.

SQLite/Drift migration may require a table rebuild. Preserve all columns, unique keys, FKs,
PurchaseItem references and normalization versions. Foreign keys, migration ledger and
transactional/no-silent-reset behavior remain mandatory.

### 5.3 Migration sequence

Implement an explicit sequential v3→v4 branch. Existing v1/v2 routes must chain through v3
then v4. Required structural tests:

- fresh v4 create;
- empty v3→v4;
- populated v3→v4 with active/archived references and Purchases;
- deterministic multi-Account backfill;
- Product null/blank and reserved-code collision fixture;
- close/reopen and FK checks;
- injected failure leaving original file/facts recoverable;
- unsupported upgrade origin stops without reset.

Do not combine schema v4 with Store redesign, Product merge/correction, SubmissionId, draft
persistence, error tables or projection caches.

## 6. Product resolution and immutable details

Application ports must support:

```text
productByCode(AccountId, ProductCode) → zero or one exact Product
productByExactIdentity(AccountId, ProductIdentityDraft) → zero or one exact Product
similarProducts(AccountId, advisory draft) → candidates
productDetails(AccountId, ProductId) → immutable Product detail read model
```

Purchase exact-code flow:

1. normalize and validate entered code;
2. call exact code port;
3. if found, bind `ProductId` and return immutable Product facts needed by presentation;
4. autofill Name, Brand, mode, measurement kind and PACKAGED quantity/unit;
5. leave Purchase Item amount/count/price/notes for user input;
6. do not add an Item until explicit `Add staged Item`.

Clearing selection returns to lookup/new-Product mode without mutating the Product. Existing
Product identity fields are presentation-read-only. No correction/edit flow is authorized.

Details are a shared application read model and presentation surface. Expanded layouts may
use a pane; compact uses a route/sheet with equivalent content. Explicit details action and
keyboard path always exist; Product double-click opens details as convenience.

## 7. Purchase occurrence architecture

The persisted fact remains `Purchases.occurrenceTime` as a UTC `DateTime`; schema change is
not required.

Presentation keeps separate blank date/time text values or picker values until both are
valid. Introduce a small parser/formatter or controlled Clock abstraction where needed:

```text
dd/mm/yyyy + HH:mm
→ validated local civil DateTime
→ toUtc()
→ RegisterPurchaseCommand.occurrenceTime
```

Do not call `DateTime.now()` during submission and do not auto-initialize the fields. The
insertion/upsertion timestamp remains an implementation event and is not substituted for
occurrence. Review/back preserves the entered values. History converts persisted UTC to local
display. Document that zone/offset history and ambiguous repeated DST hour are not retained.

Parser tests must not depend on the test host's current clock/timezone without controlling or
explicitly binding them. Reject impossible calendar/time values and preserve draft state.

## 8. Quantity and BULK money architecture

Retain one fixed-decimal normalization boundary accepting comma or point and producing
locale-neutral values. Domain canonical dimensions remain:

```text
MASS → kg at 1e6 microunits
VOLUME → L at 1e6 microunits
COUNT → un at 1e6 microunits, integral display quantity only
```

For BULK, accept positive amount and positive price rate using the same selected display unit:
`kg/kg`, `g/g`, `L/L`, `ml/ml` or integral `un/un`. Reject a mixed amount/rate basis. Parse
the rate at fixed precision sufficient for small `per g`/`per ml` values (at least six
decimal currency units), then normalize amount and rate before final currency rounding.

One suitable nonnegative fixed-point representation is:

```text
(amountInSelectedUnitMicros * pricePerSelectedUnitMicroMinor + 500000000000)
  ~/ 1000000000000
→ lineTotalMinorUnits
```

Here `pricePerSelectedUnitMicroMinor` is minor currency units scaled by 1e6. Equivalent pure
integer math is acceptable when it produces the same half-up result. Use checked/bounded
arithmetic appropriate to Dart/SQLite limits and reject overflow.
The result is read-only. Persist the existing authoritative facts: normalized amount/unit and
line total. Do not add a persisted unit-price column; History/Lists derive comparable unit
price with explicit truncation/rounding policy.

PACKAGED behavior remains package quantity + positive packages bought + derived/entered
amount under existing contract. BULK package count remains null/not applicable.

## 9. Lists query and read-model architecture

The current projection begins from Products but loses important relational facts in its read
model and unavailable presentation. Replace/extend it without a List table.

### 9.1 Typed result algebra

Use sealed/typed states equivalent to:

```text
NoPurchaseHistory
LearningHistory(observationCount, latestFacts)
IncompatibleHistory(reason, latestFacts)
AvailableCycle(cycleDays, expectedDate, remainingDays, status, latestFacts)
ProjectionQueryFailure(AppFailure)
```

Read models should expose Product ID/code/name/brand/mode/package facts, latest Purchase ID and
occurrence, amount/unit, line total/currency, compatible derived unit price, Store and optional
Person display label. Absence remains nullable/typed, never fabricated zero.

### 9.2 Bounded adapter query

1. fetch all Account Products;
2. fetch observations using one joined query or bounded batch relating PurchaseItems,
   Purchases and optional Store/Person labels;
3. enforce Account isolation in each relation;
4. group by Product in adapter memory;
5. order latest deterministically by occurrence UTC, then Purchase ID, then Item ID;
6. convert occurrence to local date and deduplicate same local dates for cycle intervals;
7. group compatible measurement kind/canonical unit/currency observations;
8. feed ordered distinct dates to pure versioned `personal-cycle-v1`;
9. return every Product even when observations are absent/incompatible.

No per-row query, static placeholder, persisted status or projection cache. Add indexes only
after query-plan/volume evidence identifies a need; report each index and migration impact.

### 9.3 Accepted classification

- fewer than two compatible distinct local dates → unavailable;
- two or more → derive cycle from compatible intervals using the existing versioned rule;
- expected date = latest compatible local date + cycle;
- remaining = expected date − today local date;
- remaining > configured threshold → Storage;
- remaining from 0 through threshold inclusive → Shortage;
- remaining < 0 → Market;
- All includes all Products and unavailable states.

Changing threshold invalidates presentation projection only. Registration invalidates Lists
and History projections. No external analytics or measured stock claim.

## 10. Error registry architecture

Do not create an error database table. Define a typed/version-controlled source registry or
sealed mapping owned by application/presentation boundaries:

```text
failure code
operation
optional field
outcome: notApplied | applied | unknown
retryability
safe user message/recovery key
diagnostic cause retained internally
```

Repositories translate domain/Drift/platform failures into typed application failures.
Presentation maps typed failures to E's visible contract. Unknown Purchase outcome instructs
verification through History before retry. Raw exceptions remain diagnostic only.

Keep registry copy/localization-ready but do not introduce localization infrastructure beyond
Sprint 02 needs. Tests assert mapping coverage and draft/selection preservation.

## 11. History export and native sharing architecture

Preserve transient `Set<PurchaseId>` selection. Export DTO contains ordered selected Purchase
and Item facts only:

- Purchase ID, manual occurrence time, Store, optional `code · nickname` references,
  currency/total;
- Product immutable code/name/brand, amount/unit/package facts, line total and notes where
  already authorized.

CSV remains deterministic UTF-8, properly quoted, one row per Item with repeated Purchase
columns. PDF groups selected Purchases. Keep layers separate:

```text
Export DTO builder
→ deterministic CSV encoder / PDF renderer
→ temporary or user-selected file adapter
→ native share adapter
→ typed share outcome
```

Evaluate one maintained native share dependency supporting Windows and Android. Hide it
behind an application port so tests use fakes and unsupported platforms return a typed result.
Platform manifests/registrants may change only as required by that dependency. Handle
cancellation, temporary-file cleanup and adapter failure. Do not upload, retain externally or
claim recipient delivery.

If the chosen plugin cannot support a required host safely, retain renderer + deterministic
save/export and report native share blocked/host-unvalidated instead of adding multiple broad
plugins or platform-specific feature forks.

## 12. Incremental materialization structure

Recommended source checkpoints/commits:

1. `ui-foundation`: tokens, theme, shell and shared states; no schema/query/plugin.
2. `identity-schema-v4`: migration, generated code, repositories and fixtures; minimal UI.
3. `purchase-slice`: manual occurrence, code autofill, details and BULK calculator.
4. `catalogue-slice`: responsive selection/details and immutable code.
5. `lists-slice`: read model, bounded query and responsive composition.
6. `history-settings-slice`: reference codes and selection/action hierarchy.
7. `native-share-adapter`: audited dependency, adapter, fakes and host integration.
8. `convergence-validation`: remaining page composition, accessibility and platform fixes.

Codex may combine adjacent checkpoints only when the diff remains independently testable and
rollback-safe. It must not combine schema v4, Lists query and native plugin introduction into
one unvalidated change.

## 13. Architecture tests and invariants

At minimum, establish tests for:

- token/component semantics and responsive shell state preservation;
- reference sequence format, monotonic allocation, Account scope, archive non-reuse,
  rollback and deterministic migration;
- Product code NOT NULL, user-required creation, immutability, exact autofill and collision;
- manual-required occurrence parsing, UTC round-trip and Review/History consistency;
- Product selection/details/add separation and double-click/keyboard equivalence;
- BULK canonical conversion, half-up boundaries, overflow and read-only total;
- Lists zero/one/two/same-day/incompatible/boundary states, Account isolation, deterministic
  ordering and bounded query count;
- typed error mapping/outcomes and retained draft/selection;
- selected-only deterministic CSV/PDF and native share success/cancel/failure/unsupported;
- v4 fresh/migration/reopen/injected-failure behavior;
- protected Python regression and app-private database isolation.

## 14. Architectural stop conditions

Stop and return to Main if:

- reference codes cannot be generated atomically without reuse or schema scope expansion;
- Product NOT NULL migration requires identity merge, user interaction during migration or
  PurchaseItem rewrite;
- date/time correctness requires zone metadata to meet the accepted visible contract;
- a second persisted BULK price truth appears necessary;
- Lists cannot satisfy all-Products/no-N+1 from existing facts;
- native sharing requires unsupported dependencies, cloud services or broad host rewrites;
- UI composition violates dependency direction or loses accessible action equivalence;
- implementation requires Store redesign, Product edit/merge, Person/Payment edit/delete,
  persisted drafts, SubmissionId, registered Purchase mutation, sync/API, Analytics logic,
  Household logic, dark mode or production release.

## 15. I report contract

Replace I with a precise Design evidence report containing:

- implemented layer/component/page architecture and changed paths;
- schema v4 definitions, chosen sequence strategy, migration/backfill behavior and invariants;
- Product lookup/autofill, occurrence, BULK and Lists contracts actually materialized;
- native share dependency/adapter decision and platform boundary;
- tests and evidence supporting each invariant;
- deviations from target/reference intent and reason;
- unresolved risks, stopped scope and rollback seams.

I remains observational evidence. Keep I at or below 250 lines; do not promote permanent
Design memory or edit J/D/E/F.
