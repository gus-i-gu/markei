# D_OPS_STAGE — C11-PH01-S02-R01 Visual Acceptance Recovery

> Sequence: FLX-ORD-01
> Role: Main operational materialization stage
> Cycle / phase / unit: C11 / C11-PH01 / C11-PH01-S02-R01
> Repository: `gus-i-gu/markei`
> Required branch: `grm-guarded-provisioning-20260727`
> Required remote parent: `f6566a407c2215c1ade61444a7f97994994d93f8`
> Codex starting HEAD: the direct descendant commit publishing this synchronized
> D/E/F packet, pinned by the initiation prompt
> Authority: **ACTIVE — CORRECTIVE IMPLEMENTATION AND NON-FORCED PUBLICATION AUTHORIZED**
> Provider mutation authority: none

## 1. Mission

Complete and publish the preliminary S02 five-page visual convergence already
present as local working-tree changes, applying one narrow recovery pass from
the supplied Windows screenshots.

The accepted visual foundation is preserved. This is not a redesign and it
must not absorb PH02 or PH03.

## 2. Starting-state truth

GitHub currently contains:

- remote parent `f6566a407c2215c1ade61444a7f97994994d93f8`;
- the S02 staging packet;
- S01 source and S01 G/H/I evidence.

The Windows worktree additionally contains the preliminary S02 implementation:

```text
clients/markei_flutter/lib/app/design/markei_theme.dart
clients/markei_flutter/lib/app/pages/history_page.dart
clients/markei_flutter/lib/app/pages/home_page.dart
clients/markei_flutter/lib/app/pages/lists_page.dart
clients/markei_flutter/lib/app/pages/products_page.dart
clients/markei_flutter/lib/app/pages/purchase_page.dart
clients/markei_flutter/lib/app/widgets/markei_components.dart
clients/markei_flutter/lib/app/widgets/markei_shell.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Those local changes are the implementation baseline for this recovery. Preserve
them. Do not reset, discard, replace from remote, or restore/drop the retained
GRM safety stash.

## 3. Initial guard

Before editing:

1. target `grm-guarded-provisioning-20260727`;
2. fetch and report the exact remote HEAD;
3. require it to equal the staging commit pinned by the initiation prompt;
4. verify `f6566a407c2215c1ade61444a7f97994994d93f8` is its direct parent;
5. verify the staging commit changes only D/E/F;
6. inventory the local modified, staged and untracked paths;
7. require the eleven paths above to remain present as the preliminary S02
   baseline; classify any additional path before proceeding;
8. read `AGENTS.md`, `documentation/sketch_notebook/INDEX.md`, and D/E/F in
   order.

Stop on ancestry drift, unexpected source paths, merge conflict, or missing
preliminary S02 changes.

## 4. Accepted human evidence

Eight Windows debug captures at 1920×1080 establish:

- the wide shell, navigation hierarchy, visual tokens and page identity are a
  successful direction;
- Home, Lists, Catalogue and History are visually coherent;
- Analytics and Audit correctly remain reserved;
- Settings remains a PH03 surface;
- Purchase and Catalogue forms expose vertical reachability and field-geometry
  defects;
- History exposes redundant row-selection affordances.

The screenshots are visual observation only. They do not establish test,
build, accessibility, provider, Sync or production acceptance.

## 5. Required corrections

### 5.1 Purchase

- Make the complete page, including review/actions, reachable at 1920×1080 and
  at smaller supported heights.
- Use one page-owned vertical scroll surface; do not hide the lower content
  beneath the viewport or Windows taskbar.
- Remove label, outline and helper-text collisions in Product name, Brand,
  Package size and Package unit fields.
- Preserve the current wide two-area composition when space permits, but allow
  sections to wrap/stack without losing draft state.
- Preserve Store/time, optional Person/Payment, product-code lookup,
  Packaged/Bulk behavior, quantity/price, draft review and single registration.

### 5.2 Catalogue

- Make Register Product and Stores fully reachable at supported window heights.
- Remove field-outline and floating-label collisions in Product name, Brand,
  Package size and Package unit.
- Keep the table and form aligned to the shared content canvas without
  horizontal overflow.
- Preserve search, sort, product detail, similarity decision and Store behavior.

### 5.3 History

- Present exactly one row-selection control per Purchase.
- Keep select-all, selection count, CSV export, PDF share, filters and detail
  behavior coherent with that single control.
- Use the available wide table canvas more evenly without changing recorded
  values, identifiers or filter semantics.

### 5.4 Home and Lists

Preserve their accepted composition. Change them only when a shared primitive
must be corrected for Purchase/Catalogue/History. Reverify their existing
wide and responsive states after any shared change.

### 5.5 Reserved and deferred surfaces

Do not redesign or activate Analytics, Settings, Audit, Household, Guide,
Documentation or Closure. Their screenshots are boundary evidence only.

## 6. Authorized paths

Implementation changes are limited to the eight preliminary S02 source files
listed in §2.

Tests may be added or updated only under:

```text
clients/markei_flutter/test/app/
```

and only for the corrected presentation behavior.

Codex must replace:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Do not modify D/E/F, permanent-domain files, Main-root files, methodology,
pubspec/lockfile, generated source, database, API, provider, Sync, Auth,
platform manifests or packaging identity scripts.

## 7. Behavioral invariants

- no repository/domain/infrastructure interface change;
- no new dependency, asset, font, route or state-management framework;
- no Product, Purchase, list-estimate, filter, export or share semantic change;
- no provider or live operation;
- no data reset, migration, deletion or cleanup;
- responsive switching preserves selected destination, page state and Purchase
  draft state;
- shared presentation widgets remain repository-free.

## 8. Validation

Run from `clients/markei_flutter`:

```text
flutter pub get
dart format --output=none --set-exit-if-changed lib test
flutter analyze
focused tests for changed presentation behavior
flutter test test/app/markei_visual_foundation_test.dart
flutter test
flutter build windows --release
```

Also run repository changed-path and whitespace audits.

Bound the full-suite run. If the full suite alone hangs after focused tests,
analysis and the direct Windows build pass, terminate only validation-owned
processes, record the exact last test/output and classify
`FULL_FLUTTER_TEST=BLOCKED_TIMEOUT`. Do not call it PASS. A substantive test,
analysis or build failure blocks publication.

## 9. Publication

When the allowed validation boundary is satisfied:

1. stage only authorized source, tests and replacement G/H/I;
2. verify the staged inventory;
3. commit one cohesive S02-R01 implementation descendant;
4. fetch again and require remote HEAD to remain the staging commit;
5. push by non-forced fast-forward;
6. verify local HEAD equals remote HEAD and the worktree is clean;
7. leave the retained GRM safety stash untouched for the human to remove later.

Do not leave the accepted implementation only in the worktree because a
full-suite timeout was the sole blocked check.

## 10. Required G terminal

```text
CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S02-R01
PRELIMINARY_S02_BASELINE=PRESERVED | CONTRADICTED
PURCHASE_VERTICAL_REACHABILITY=PASS | FAIL | BLOCKED
CATALOGUE_VERTICAL_REACHABILITY=PASS | FAIL | BLOCKED
FORM_FIELD_GEOMETRY=PASS | FAIL | BLOCKED
HISTORY_SINGLE_SELECTION=PASS | FAIL | BLOCKED
FOCUSED_TESTS=PASS | FAIL | BLOCKED
FULL_FLUTTER_TEST=PASS | FAIL | BLOCKED_TIMEOUT
FLUTTER_ANALYZE=PASS | FAIL | BLOCKED
WINDOWS_BUILD=PASS | FAIL | BLOCKED
CHANGED_PATH_AUDIT=PASS | FAIL
PROVIDER_MUTATION=NONE | CONTRADICTED
PUBLICATION=PUSHED | NOT_PUSHED
NEXT_MAIN_ACTION=<one exact action>
```
