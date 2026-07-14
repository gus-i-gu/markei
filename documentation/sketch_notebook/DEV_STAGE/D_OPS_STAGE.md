# D_OPS_STAGE — Cycle 09 Sprint 02 Execution and Evidence Contract

> Sequence: FLX-ORD-01 — Main-approved materialization
> Unit: C09-S02 — Functional correction and UI convergence
> Status: ACTIVE — CODEX IMPLEMENTATION AUTHORIZED ONLY WITH E/F
> Branch: `intermid-cycle-recovery`
> Required investigation ancestor: `a4374794d707e6a2a502ed67d447c713702e1851`
> Implementation baseline: `e37cb700feeca4001cc7835b584c46bb81926af3`
> Report: replace `DEV_STAGE/G_OPS_CODEX.md`

## 1. Mandatory executive-context boot

Before inspecting or editing implementation files, Codex must load the complete operating
methodology into executive context memory:

```text
AGENTS.md
→ documentation/sketch_notebook/INDEX.md
→ methodology/METHOD_FOUNDATIONS.md
→ methodology/FLUX.md
→ methodology/PROMOTION_RULES.md
→ methodology/CHAT_PROTOCOL.md
→ [M]_STAGE/J_MAIN_STAGE.md
→ DEV_STAGE/D_OPS_STAGE.md
→ DEV_STAGE/E_DDC_STAGE.md
→ DEV_STAGE/F_DSN_STAGE.md
```

Then inspect A/B/C and the smallest relevant domain checkpoints/source/tests. State the
retained methodology, authority boundary and implementation plan before mutation. A/B/C do
not directly authorize code. D/E/F are one joint instruction; none may be applied alone.

## 2. Visual reference assets

The following target mockups are attached as persistent implementation evidence. Codex must
inspect all five before altering the shell or page compositions:

![Target 01 — Lists](references/c09_s02/01_lists_target.png)

![Target 02 — Catalogue](references/c09_s02/02_catalogue_target.png)

![Target 03 — Home](references/c09_s02/03_home_target.png)

![Target 04 — Purchase](references/c09_s02/04_purchase_target.png)

![Target 05 — History](references/c09_s02/05_history_target.png)

They define hierarchy, grouping, palette direction, information density, responsive intent
and action/state language. They are not literal pixel authority. Accessibility, truthful
data, supported interactions and platform behavior outrank decorative imitation.

## 3. Safety and baseline before mutation

1. Fetch the named branch and verify HEAD descends from the investigation ancestor and
   includes current J/D/E/F. Stop on divergence or missing stages.
2. Record branch, HEAD, remote relationship and worktree status. Preserve unrelated work;
   never reset, clean, overwrite, stash or force-push it.
3. Inventory current schema version, handwritten/generated Drift files, migrations,
   dependencies, platform registrants, application ports, pages and relevant tests.
4. Run or record baseline inability for dependency resolution, focused/full Flutter tests,
   analysis and protected Python regressions before large mutation.
5. Make incremental coherent checkpoints. After each checkpoint, format touched Dart,
   run focused tests and keep the client runnable.
6. Do not rename or create Sketch Notebook files. The five reference PNGs are read-only.
7. Write only implementation/test/dependency/generated files authorized by F and replace
   G/H/I reports at completion.

## 4. Required delivery checkpoints

### Checkpoint 1 — Markei UI foundation

- Introduce an in-repository Markei token/theme layer and shared SDK-first components.
- Implement the accepted cream/white, dark-green and lavender direction with semantic
  success/storage, warning/shortage, market/due, error and unavailable states.
- Provide shared page header, surface/section card, feedback/state panel, status chip,
  selection toolbar, responsive form grouping and desktop-table/mobile-card abstractions.
- Recompose the shell:
  - expanded grouped labelled navigation;
  - compact `Home / Lists / Purchase / History / More`;
  - More exposes Catalogue, Settings, Guide, Documentation and future/PIN destinations;
  - active destination and Purchase draft survive supported width transitions.
- Do not add a visual framework dependency. Existing SDK widgets remain preferred.

Gate: theme/component/widget tests, narrow/wide shell tests, selected-destination survival,
keyboard semantics, text-scale/overflow checks and existing app tests.

### Checkpoint 2 — Schema v4 and immutable visible identities

Advance schema only once and only for the reconciled identity requirements:

- People: non-null visible code `@001`, `@002`, …, Account-scoped unique and immutable.
- Payment Methods: non-null visible code `#001`, `#002`, …, Account-scoped unique and
  immutable.
- Sequence allocation is transactional, monotonic and non-reusing, including archived rows.
  After 999, width expands naturally (`@1000`, `#1000`).
- Backfill existing rows deterministically by Account, creation time then immutable UUID;
  assign consecutive codes without changing UUIDs, nicknames or Purchase references.
- New create operations allocate the next code atomically. Retry/failure must not produce a
  duplicate code; gaps caused by a rolled-back transaction should not persist.
- UI/application expose create only. Do not expose rename/edit or physical delete. Preserve
  existing archive/history behavior only where it remains non-destructive and code-safe.
- Products: rebuild/migrate visible and normalized code columns to NOT NULL while preserving
  Account-scoped uniqueness and immutability.
- Preflight all Products. Existing non-null codes remain unchanged. Any null/blank legacy
  code receives a deterministic reserved collision-safe legacy code before NOT NULL is
  applied; record the format and affected count in G.
- New Product creation requires a user-entered code. No ordinary Product update path may
  change it. Exact identity and code collision never merge or rewrite PurchaseItems.

Migration gates:

- fresh v4 creation;
- representative v1→v2→v3→v4 and v3→v4 file-backed migrations;
- deterministic People/Payment backfill;
- Product null/blank/collision fixtures;
- close/reopen and FK/history resolution;
- injected migration failure with rollback/no silent reset;
- generated Drift regeneration and clean analysis.

Stop before schema mutation if existing rows cannot be assigned deterministic unique codes
without changing facts or if SQLite rebuild would weaken FKs/atomic registration.

### Checkpoint 3 — Purchase occurrence, Product resolution and BULK calculation

- Place required blank `Purchase date` and `Time` fields immediately after Store.
- Do not default them to `now`; the user manually records buying time, distinct from the
  insertion/upsertion moment.
- Parse exact `dd/mm/yyyy` and `HH:mm`, validate real local civil time, combine and convert
  to the existing UTC occurrence instant at the application boundary.
- Review, registered History, CSV and PDF consistently present the manually entered value;
  exports may additionally use canonical machine-readable UTC where already required.
- Invalid input preserves Store, references, Product selection and staged Items and moves
  focus/feedback to the owning field.
- Exact Product-code entry in Purchase calls exact lookup and fills Product name, brand,
  mode, measurement kind and package quantity/unit for PACKAGED Product. Filled identity
  fields are read-only in the existing-Product path unless the user deliberately clears the
  selection and enters the new-Product path.
- Exact identifying-field lookup remains available. Similarity remains advisory.
- Selecting/filling a Product never adds an Item automatically.
- Product details have explicit accessible actions; Catalogue/Purchase desktop double-click
  opens details, not adds an Item.
- BULK exposes Amount bought, selected Unit and Price per that same selected unit. Support
  `kg/kg`, `g/g`, `L/L`, `ml/ml` and integral `un/un`; reject mixed amount/rate units.
  Normalize both operands internally, calculate integer-minor-unit line total half-up and
  render it read-only. No manual override and no competing persisted rate truth.

Gate: controlled-clock/date parsing tests, leap/invalid/date-rollover cases, manual-required
test, exact-code autofill tests, identity collision tests, details versus selection tests,
BULK kg/g/L/ml/un and half-cent boundary tests, edit/review/register/reopen consistency.

### Checkpoint 4 — Catalogue and Product details

- Build the target Catalogue hierarchy using shared components and real read models.
- Preserve broad search only when labelled `Search Catalogue`; expose exact Product code and
  exact Product details operations without conflating them.
- Row/card click/tap selects/highlights. Explicit `View Product details` opens details.
  Desktop double-click opens details. Keyboard selection/details have equivalent routes.
- Details show immutable code, Name, Brand, mode, package facts when PACKAGED, category and
  available latest Purchase/unit-price/cycle facts without inventing missing values.
- Product code cannot be edited. Exact collision never offers `Create anyway`; advisory
  similarity may offer compare/use-existing and an explicit new-Product path.
- Recompose wide table and compact cards without dropping identity or state semantics.

Gate: tap/click/double-click/keyboard equivalence, selection persistence, details isolation,
long text, empty/no-match/error/retry and 390/600/1024+ responsive tests.

### Checkpoint 5 — Relational Lists repair and composition

- Begin with every Account Product.
- Fetch PurchaseItem/Purchase observations in one joined query or bounded batch; do not use
  per-Product history queries or a persisted List/cache table.
- Retain zero-history, one-history and incompatible-history Products.
- Use deterministic latest observation ordering and expose latest date, amount/unit, line
  total, compatible derived unit price, Store and optional Person label when available.
- Cycle rule:
  - at least two compatible distinct local Purchase dates;
  - derive intervals between ordered distinct dates and the versioned personal cycle;
  - expected next date from latest compatible date plus cycle;
  - remaining > threshold → Storage;
  - remaining 0..threshold → Shortage;
  - remaining < 0 → Market.
- Default threshold is five days and remains configurable.
- `All` shows every Product/state. Filter tabs show only available-cycle Products matching
  their derived state; unavailable states remain reachable through All.
- Recompose target wide table/summary/filter/help hierarchy and equivalent compact cards.
  Never state measured inventory or hide query failure as `Not enough history`.

Gate: zero/one/two/multiple history, same-day deduplication, incompatible quantity/currency,
boundary days, account isolation, deterministic latest, query failure/retry, query-count
assertion and representative 1k Product/10k Item measurement.

### Checkpoint 6 — History, Settings and native share

- Settings presents People and Payment Methods as immutable `code · nickname`; create only,
  with no rename/edit/delete UI. `Not assigned` remains available in Purchase.
- History and exports resolve `code · nickname`, including archived history labels.
- History supports checkbox/tap/keyboard selection, select-all/clear and pointer double-click
  selection. Selection activates a clear action hierarchy.
- `Move to Analytics` remains disabled/planned. Edit/Delete remain disabled/not supported.
- CSV stays deterministic and selected-only.
- PDF groups only selected Purchases and remains deterministic.
- Attempt native OS share through a minimal, actively maintained dependency/adapter with
  Windows and Android support. Inspect license, release health, transitive graph, manifests,
  generated registrants, platform support and testability before adopting it.
- Keep PDF rendering, temporary file lifecycle and sharing behind separate ports/adapters.
  Handle cancellation, cleanup, unsupported platform and failure as typed outcomes.
- If native share cannot be validated on a host, preserve deterministic PDF save/export and
  report native sharing host-unvalidated/blocked. Never upload silently.

Gate: selected-only CSV/PDF, escaping/order, no private/unselected data, optional labels,
share success/cancel/failure/unsupported fakes, temporary cleanup and Windows/Android manual
share when those hosts are available.

### Checkpoint 7 — Final convergence and regression

- Complete Home/Lists/Purchase/History/Catalogue visual convergence using target evidence.
- Ensure Guide/Documentation/Settings/future destinations use the shared shell/states.
- Validate 390×844, 600, 720 transition, 1024+ and constrained desktop; text scales
  1.0/1.3/2.0; keyboard-only; semantics; touch targets; Back; resize/rotation; keyboard open.
- Validate loading, empty, no match, unavailable, selected, validation, typed failure,
  unknown outcome, retry, success and disabled states.
- Preserve app-private offline-first storage and protected Python boundaries.

## 5. Required command/evidence matrix

Run from `clients/markei_flutter/` and record exact command, environment and result:

1. `flutter --version`, `dart --version`, Java/Android/Windows toolchain availability.
2. `flutter pub get`; dependency diff/audit if a sharing dependency is added.
3. Drift/build-runner regeneration using the repository-established command.
4. `dart format --output=none --set-exit-if-changed lib test` after formatting touched files.
5. Focused domain/application/infrastructure/widget tests after each checkpoint.
6. File-backed fresh/migration/reopen/failure tests.
7. `flutter test` full suite.
8. `flutter analyze`.
9. `git diff --check` and changed/generated/platform path inventory.
10. `flutter build windows --release` plus bounded manual workflow/share smoke when available.
11. `flutter build apk --debug`, install/launch and lifecycle/share workflow when available.
12. Protected Python release/regression suite named by existing G evidence.

Classify source inspection, test, file-backed, build, launch, manual workflow, lifecycle,
native share and platform evidence separately. Missing host prerequisites mean
host-unvalidated, never automatic product failure or success.

## 6. Global stop conditions

Stop before broader mutation if:

- D/E/F conflict, required images/stages are unavailable, or branch ancestry is wrong;
- migration would change UUIDs, Product identity, Purchase facts, historical references or
  silently reset/merge data;
- reference sequences can duplicate/reuse codes or Product codes remain nullable/editable;
- date/time fields default automatically or record insertion time instead of buying time;
- BULK requires a competing stored price truth or editable derived total;
- Lists require invented history, N+1 queries or a persistent cache/manual List;
- native sharing needs unsupported/abandoned dependencies or unrelated platform expansion;
- responsive work removes accessible equivalents or loses draft/selection state;
- work expands into the deferred J boundaries.

Report the exact blocker and smallest safe alternative. Do not silently defer a controlling
requirement while claiming Sprint 02 complete.

## 7. G report contract

Replace G with a precise Operational evidence report containing:

- starting/final commit, branch, host/toolchain and worktree boundary;
- exact changed/created/deleted/generated paths and dependency changes;
- checkpoint-by-checkpoint completion/deviation;
- schema v4/backfill counts, sequence allocation and migration fixtures;
- exact commands/results and evidence classifications;
- Windows/Android/native-share/manual workflow status;
- blockers, host-unvalidated work, residual risks and rollback notes.

G is evidence, not permanent promotion. Keep G at or below 250 lines and do not edit
permanent notebook memory.
