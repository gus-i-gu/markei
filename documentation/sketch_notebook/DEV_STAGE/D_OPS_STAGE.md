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

---

<!-- ACTIVATION_MARKER:C11-PH01-S02-R01-C11-PH02-COMBINED-2026-07-31 -->

# Combined activation — C11-PH01-S02-R01 and C11-PH02

> Status: **ACTIVE — ONE COMBINED CORRECTIVE AND ANALYTICS
> MATERIALIZATION ROUND AUTHORIZED**
> Parent before this staging publication:
> `510ecf3a768a110528f6c69c7f66251fbb095f89`
> Codex starting HEAD: the direct descendant containing this synchronized
> D/E/F activation marker, pinned by the initiation prompt
> Implementation commit message:
> `Complete C11 PH01 recovery and PH02 analytics`

## 11. Authority, precedence and current repository truth

This append is the controlling authority when it conflicts with the earlier
R01 header or starting-state description. It does not discard the earlier
correction packet.

Retained unchanged:

- all Purchase, Catalogue and History corrections in §§4–5;
- Home/Lists regression protection;
- the behavioral, provider, Sync, dependency and evidence boundaries;
- the validation-timeout honesty rule;
- replacement G/H/I and one non-forced publication.

Corrected by current repository truth:

- `2e59f35b9aad4ee10a2d1831902c80d904c5b066` now contains the preliminary
  five-page PH01 source/test/G/H/I materialization and is an ancestor of
  `510ecf3a768a110528f6c69c7f66251fbb095f89`;
- the preliminary S02 baseline is therefore remote source at the combined
  starting HEAD, not an unpublished local-only worktree;
- a clean worktree is required; Codex must not require or restore the former
  preliminary local modifications;
- the earlier statements excluding PH02 are superseded only by the exact PH02
  contract below;
- PH03, provider, Sync, diagnostics, recovery, production and every other
  exclusion remain in force.

A/B/C were written against earlier parallel heads. Their Analytics findings
remain staging evidence, but their “S02 absent” classification is superseded
by the ancestry above.

## 12. Combined mission and order

Materialize one cohesive round in this order:

1. apply only the already-authorized PH01-R01 Purchase, Catalogue and History
   corrections;
2. reverify Home and Lists after shared changes;
3. implement the complete C11-PH02 local Analytics workspace defined here and
   in the paired E/F append;
4. validate the combined source state;
5. replace G/H/I with combined evidence;
6. commit once and push by non-forced fast-forward.

Do not broaden PH01 while implementing PH02. Analytics may add only one typed
History action/callback; it may not reopen the rest of History composition.

## 13. Initial guard

Before mutation:

1. target `grm-guarded-provisioning-20260727`;
2. fetch and require remote HEAD to equal the exact activation commit pinned by
   the initiation prompt;
3. require that activation commit to have direct parent
   `510ecf3a768a110528f6c69c7f66251fbb095f89`;
4. require the activation commit to change only D/E/F;
5. verify `2e59f35b9aad4ee10a2d1831902c80d904c5b066`,
   `f6c1ae653bc50449f1308de72516c4bda3e39ebc`,
   `7056ed21c0fc2fdc6d25e87d113995a8f88e67fb`,
   `ca380632f5714ce4007d694a954568c3a57828cd` and
   `3801c8b6023bfe56c4c4c677e980b75405a7c132` are ancestors;
6. report the resolved PH02 Operational commit SHA;
7. require a clean worktree before editing;
8. read AGENTS.md, INDEX.md and the complete controlling D/E/F packet.

Stop on branch mismatch, ancestry drift, unrelated local changes, missing PH01
source, unexplained remote advancement or a D/E/F contradiction.

## 14. Main-resolved PH02 decisions

These decisions are active implementation authority:

1. Analytics is deterministic, read-only, local and explicitly Account-scoped.
2. One evidence row is one persisted Purchase Item, identified by
   `PurchaseItems.id`; Purchase-level measures deduplicate by `PurchaseId`.
3. `Percentage` means part of an explicitly named whole. Relative percentage
   change is not PH02.
4. `Difference` means comparison B minus baseline A; both operands are visible
   and ordered.
5. Purchase occurrence time is authoritative. Conditions use UTC half-open
   bounds `[start, end)`; Time grouping supports UTC day and UTC month only.
6. Cards are session-local. No schema, migration, Sync or persistence is added.
7. History hands off selected Purchase IDs only. Its action is disabled when
   no Purchase is selected.
8. The adapter loads one complete Account dataset with one joined local query.
   The UI renders it in stable pages of 100 rows; card calculations use the
   complete eligible set. Selected-row scope is capped at 500 stable IDs with
   explicit feedback.
9. Reset clears matrix conditions, selection and evidence focus, but does not
   delete cards or Purchase facts.
10. `Purchased for` and `Promotion` remain visible unavailable fields. No fact
    is inferred and no schema is invented.
11. `Purchased by` is the optional Person reference recorded on a Purchase.
12. Unit price is derived only from positive normalized quantity and line
    total, with currency and canonical-unit basis visible.

## 15. Evidence authority

The complete matrix exposes these twelve fields:

| Field | Authority and PH02 behavior |
| --- | --- |
| Purchase | Purchase ID with readable date/store companion |
| Date and time | Purchase occurrence time |
| Product | Purchase Item Product ID, code and display name |
| Brand | Product display brand; unavailable when blank |
| Store | Purchase Store ID and display name |
| Purchased by | optional Person historical label |
| Purchased for | unavailable |
| Payment method | optional Payment Method historical label |
| Quantity | normalized fixed microunits plus kind/canonical unit |
| Unit price | typed derived rate or unavailable |
| Line total | exact minor units plus currency |
| Promotion | unavailable |

Every query requires `AccountId`. Do not use History’s recent-50 read,
per-Purchase detail loops, exports, Sync events, submissions, diagnostics,
telemetry, provider state or external facts as Analytics authority.

## 16. Executable calculation contract

Supported numeric variables:

- Quantity;
- Unit price;
- Line total;
- Purchase total, deduplicated once per Purchase;
- Evidence count, with an explicit Item-row counting unit.

| Variable | Sum | Mean | Difference | Percentage |
| --- | --- | --- | --- | --- |
| Quantity | enabled | enabled | enabled | enabled |
| Unit price | disabled | enabled | enabled | disabled |
| Line total | enabled | enabled | enabled | enabled |
| Purchase total | enabled | enabled | enabled | enabled |
| Evidence count | enabled | disabled | enabled | enabled |

Rules:

- determinants are Product, Purchase, Store or Time;
- conditions may use authoritative categorical fields and the UTC period;
- multiple variables produce independent labelled results;
- no mixed currencies or mixed quantity/rate compatibility keys combine into
  one value;
- Sum/Mean results may partition into independent compatibility-keyed values;
- Difference and Percentage require matching keys for both operands;
- Mean exposes its numerator and contribution unit: Item row for Quantity,
  Unit price and Line total; distinct Purchase for Purchase total;
- Difference requires exactly two explicit scopes/groups and reports B − A;
- Percentage requires a numerator scope contained in the denominator scope,
  uses the same variable/aggregation/key, reports fixed basis points, and
  returns typed unavailable when the denominator is zero;
- missing or incompatible values are never silently dropped: eligible, total
  and excluded counts are reported;
- checked integer/rational arithmetic is required; floating-point money,
  quantity or percentage authority is prohibited;
- overflow is a typed result, not a crash or wrapped integer.

Disable invalid determinant/variable/operation combinations before execution.
Do not implement forecasts, rankings, recommendations, causal explanations,
weighted means, charts, smart insights or advanced statistics.

## 17. Workspace behavior

Analytics replaces the reserved page and provides:

- repeatable analysis cards above the evidence matrix;
- card create, edit, delete and keyboard-accessible earlier/later reordering;
- determinant, one-or-more variables, one operation, optional conditions and
  selected/filtered evidence scope;
- matrix selection that starts a provisional card but does not infer an
  operation;
- results with value(s), factual interpretation, evidence count, excluded
  count when applicable and period;
- `Focus supporting evidence`, which limits the visible matrix to the exact
  evidence-row IDs used while retaining the complete loaded dataset;
- `Show all evidence`, which removes card focus;
- `Reset evidence`, which clears conditions, selection and focus while
  retaining cards and facts;
- local-read Retry preserving filters, selection and card configurations;
- stale async generation suppression.

Wide matrix and compact expandable evidence cards consume the same controller,
rows, IDs, filters, cards, results and failures. Breakpoint changes must not
reload data or reset state.

History adds `Analyze selected purchases`. `MarkeiApp` owns destination
selection and passes an immutable Account/Purchase-ID context. Analytics
revalidates the IDs against its Account dataset, selects matching Item rows and
calculates nothing until the user completes a card.

## 18. Query, volume and failure gates

The local adapter must:

- execute one Account-predicated joined load across Purchases, Purchase Items,
  Products, Stores, People and Payment Methods;
- return stable ordering by occurrence time, Purchase ID and Purchase Item ID;
- derive typed Unit price without changing raw facts;
- perform zero per-row or per-Purchase follow-up repository calls;
- expose one request per initial load or explicit Retry and no request for
  filter, selection, focus, card calculation or reorder.

Required fixtures:

- ordinary: 1,000 Purchases / 5,000 Items;
- stress: 10,000 Purchases / 50,000 Items.

Record host and elapsed time. Targets are under 250 ms for ordinary first
load/simple calculation and under one second for the stress calculation after
load. Repeatable failure, unbounded widget construction, N+1 behavior or
visible interaction hangs block publication. Do not add an index/migration in
this round; report a separate migration decision if needed.

Required typed states include loading, complete, first-use/no-data,
filtered-empty, selected-empty, incomplete card, calculating, calculated,
insufficient evidence, incompatible currency/unit, unavailable field,
zero-denominator, overflow, stale/foreign History context, local read failure,
calculation failure and superseded async result.

Retry repeats only the failed local Analytics read. It must not invoke Sync,
Recovery, Enroll, Query, provider access, migration, repair or mutation.

## 19. Authorized paths

PH01-R01 retains the eight source paths and `test/app/` authority in §§2 and 6.

PH02 may create or modify only:

```text
clients/markei_flutter/lib/domain/analytics/analytics_models.dart
clients/markei_flutter/lib/domain/analytics/analytics_registry.dart
clients/markei_flutter/lib/application/analytics.dart
clients/markei_flutter/lib/application/analytics_workspace.dart
clients/markei_flutter/lib/infrastructure/local/local_analytics_repository.dart
clients/markei_flutter/lib/app/pages/analytics_page.dart
clients/markei_flutter/lib/app/widgets/analytics_components.dart
clients/markei_flutter/lib/app/markei_composition.dart
clients/markei_flutter/lib/app/markei_app.dart
clients/markei_flutter/lib/app/pages/history_page.dart
clients/markei_flutter/test/analytics_registry_test.dart
clients/markei_flutter/test/application/analytics_test.dart
clients/markei_flutter/test/application/analytics_workspace_test.dart
clients/markei_flutter/test/infrastructure/local_analytics_repository_test.dart
clients/markei_flutter/test/app/analytics_page_test.dart
clients/markei_flutter/test/app/history_analytics_handoff_test.dart
clients/markei_flutter/test/app/markei_app_test.dart
clients/markei_flutter/test/app/markei_visual_foundation_test.dart
```

Codex may omit an authorized new file when the responsibility is cleanly
contained in another listed file; it may not invent another path without
stopping.

Codex must replace:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

No local_database.dart/g.dart, schema, migration, pubspec, lockfile, generated
source, platform, API, Auth, Sync, provider, diagnostic, Main-root, permanent
memory, methodology or D/E/F change is authorized.

## 20. Combined validation and publication

Run from `clients/markei_flutter`:

```text
flutter pub get
git diff --exit-code -- pubspec.yaml pubspec.lock
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test test/analytics_registry_test.dart
flutter test test/application/analytics_test.dart
flutter test test/application/analytics_workspace_test.dart
flutter test test/infrastructure/local_analytics_repository_test.dart
flutter test test/app/analytics_page_test.dart
flutter test test/app/history_analytics_handoff_test.dart
flutter test test/app/markei_visual_foundation_test.dart
flutter test test/app/markei_app_test.dart
flutter test
flutter build windows --release
flutter build apk --debug
```

Also run repository-root changed-path, generated-file, dependency and
`git diff --check` audits. Focused tests must cover the retained PH01-R01
corrections plus every supported/disabled Analytics combination, Account
isolation, complete-query behavior, Purchase deduplication, UTC boundaries,
selection cap, History context, Reset/focus, local Retry, stale async
suppression, 599/600/1023/1024 widths and 200-percent text.

The earlier bounded full-suite timeout rule remains. Any substantive focused
test, analyze, build, Account-scope, fixed-point, N+1 or changed-path failure
blocks publication.

When all publication gates pass:

1. replace G/H/I with combined PH01-R01 + PH02 evidence;
2. stage only authorized paths;
3. commit once with `Complete C11 PH01 recovery and PH02 analytics`;
4. fetch and require the remote still equals the activation starting HEAD;
5. push by non-forced fast-forward;
6. verify exact remote commit and clean worktree.

Do not open a pull request or create another branch.

## 21. Required combined G terminal

```text
CYCLE=C11
ROUND=C11-PH01-S02-R01+C11-PH02
STARTING_HEAD=<activation commit>
PH01_BASELINE_COMMIT=2e59f35b9aad4ee10a2d1831902c80d904c5b066
PH01_CORRECTIONS=PASS | PARTIAL | FAIL | BLOCKED
PURCHASE_VERTICAL_REACHABILITY=PASS | FAIL | BLOCKED
CATALOGUE_VERTICAL_REACHABILITY=PASS | FAIL | BLOCKED
FORM_FIELD_GEOMETRY=PASS | FAIL | BLOCKED
HISTORY_SINGLE_SELECTION=PASS | FAIL | BLOCKED
ANALYTICS_LOCAL_ACCOUNT_SCOPE=PASS | FAIL | BLOCKED
EVIDENCE_QUERY_COMPLETENESS=PASS | FAIL | BLOCKED
EVIDENCE_QUERY_COUNT=<exact count>
OPERATION_COMPATIBILITY=PASS | FAIL | BLOCKED
FIXED_POINT_AND_OVERFLOW=PASS | FAIL | BLOCKED
HISTORY_HANDOFF=PASS | FAIL | BLOCKED
WIDE_COMPACT_STATE_PARITY=PASS | FAIL | BLOCKED
ORDINARY_FIXTURE=<size, host, elapsed>
STRESS_FIXTURE=<size, host, elapsed>
FOCUSED_TESTS=PASS | FAIL | BLOCKED
FULL_FLUTTER_TEST=PASS | FAIL | BLOCKED_TIMEOUT
FLUTTER_ANALYZE=PASS | FAIL | BLOCKED
WINDOWS_BUILD=PASS | FAIL | BLOCKED
ANDROID_BUILD=PASS | FAIL | BLOCKED
SCHEMA_OR_DEPENDENCY_CHANGED=NO | YES
LIVE_SYNC_OR_PROVIDER_OPERATION=NONE | CONTRADICTED
PUBLICATION=PUSHED | NOT_PUSHED
NEXT_MAIN_ACTION=<one exact action>
```
