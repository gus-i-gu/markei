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

- `2e59f35dd7b45902f707fcf33c73024e868787de` now contains the preliminary
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
5. verify `2e59f35dd7b45902f707fcf33c73024e868787de`,
   `f6c1ae653bc50449f1308de72516c4bda3e39ebc`,
   `7056ed2670ec21181da1fef3bb84c196f3577049`,
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
PH01_BASELINE_COMMIT=2e59f35dd7b45902f707fcf33c73024e868787de
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
<!-- ACTIVATION_MARKER:C11-PH03-R01-2026-07-31 -->

# C11-PH03-R01 — Final Operational Materialization Authority

> Sequence: FLX-INV-02 final activation after C11-PH03-R01 A/B/C reconciliation
> Role: Main operational materialization stage
> Required branch: grm-guarded-provisioning-20260727
> Investigation baseline: e8723bec10836e37bc1a7cf22fcb6de21dd03cf4
> A/B/C publication HEAD: b50c6f195800438f20073112e58503f70cb5d6ef
> Codex starting HEAD: the synchronized D/E/F publication commit pinned by the initiation prompt
> Authority: ACTIVE — CONTROLLING C11-PH03 IMPLEMENTATION AUTHORITY
> Pairing: the E and F append carrying this exact activation marker

## 18. Precedence and reconciled boundary

This append supersedes earlier PH03 deferrals only for the bounded implementation
below. Earlier PH01/PH02 authority and evidence remain historical; they do not
expand this unit.

C11-PH03 must:

1. keep Settings functional and correct its demonstrated local-state defects;
2. replace the reserved Audit page with a functional, sanitized, read-only,
   Account/environment-scoped local activity-history view;
3. remove Closure from ordinary wide, medium and compact navigation under every
   feature-flag value;
4. dispose every existing Closure capability through Audit, Settings,
   explicitly gated development support, retained non-navigation infrastructure,
   or product-UI retirement;
5. preserve current Auth, enrollment, Sync, diagnostics and recovery contracts.

PH03 does not authorize the former R07 causal/backend engine.

## 19. Final product placement decisions

Main resolves the A/B/C questions as follows:

- Navigation label remains Audit. Page copy explains “recent local activity
  history”; it must not imply compliance, completeness, causality, telemetry or
  hosted cross-device truth.
- Audit uses cursor-paged local attempts and diagnostic events: default page 20
  attempts, hard maximum 50, plus-one cursor detection, deterministic order and
  explicit local/window/freshness qualification.
- Settings sections are Preferences, Account, Sync and Device, and Advanced
  support.
- Account status, Sign in to Sync and Sign out on this Device are ordinary
  Settings capabilities using existing adapters.
- Connect this Device and Sync now may appear only in the explicit Sync and
  Device / Advanced disclosure, with exact effect copy, visible results and
  confirmation where the existing action can change local or hosted state.
- Current local authentication, enrollment, readiness, queue, Device and last
  successful-Sync observations belong to Settings status, not Audit history.
- Build information, fingerprints, MKS references and raw lifecycle details are
  not ordinary content; safe summaries may appear only in Advanced support.
- Hosted connection checks, query-enrollment, unknown-outcome retry,
  failed/notApplied inspection or recovery, raw provider diagnostics and exact
  build digests remain development-only and have no ordinary navigation entry.
- Clear diagnostic history has no product UI in PH03. Its repository method may
  remain as development/test infrastructure; Audit itself exposes no delete,
  retry, recovery, enrollment, Sync or provider action.
- NativeClosurePage and NativeAuthClosureRunner may remain only as
  non-navigation implementation/support infrastructure while capability-narrow
  adapters replace broad UI injection. Closure is not a product destination.

## 20. Settings functional correction

Preserve People, Payment Methods and shortage-threshold behavior and Account
scope. Correct the established defects:

- load and display the persisted shortage threshold instead of overwriting it
  with the default;
- accept only whole values from 0 through 365 and preserve invalid draft input
  while displaying guidance;
- distinguish loading, true empty, read failure, save failure and success;
- refresh the affected list after archive and retain historical Purchase facts;
- prevent duplicate async save/archive activation;
- preserve entered values after failure;
- perform no network, diagnostic or provider work for local preference actions;
- retain one Settings state across responsive projections.

Account and Sync/Device additions must delegate to existing composition
capabilities. Do not change their domain contracts or persistence behavior.

## 21. Audit read and runtime gates

Ordinary Audit behavior is local-only and read-only.

Required behavior:

- visibility-gated first load; hidden IndexedStack pages perform no read;
- one attempts query and one child-events query per page; no N+1;
- Account and environment predicates on every attempt/event read;
- persisted attempt/event identity, never list position;
- attempts ordered by startedAt descending then persisted ID descending;
- events ordered by recordedAt ascending then persisted ID ascending within an
  attempt;
- exclusive cursor using startedAt plus attempt ID;
- explicit local refresh only; no timer, stream, polling or background refresh;
- layout, filter, expansion and semantic transitions issue zero rereads;
- stale async completion is ignored;
- previous records remain visible in a typed stale state when appropriate;
- loading, ready, empty, stale, partial-window and unavailable states are
  distinct;
- Audit Retry means retry the same local read only;
- no HTTP client, access token, Auth mutation, enrollment, Sync, Retry, Recovery
  or database write is reachable from Audit;
- sanitized allowlist excludes tokens, credentials, raw payloads, SQL, paths,
  stack traces, raw exceptions, full hashes, raw Account/Device/submission IDs,
  private URLs and provider secrets;
- unknown Device attribution renders unavailable rather than inferred.

A failed performance fixture does not authorize an index or migration. Stop and
report the measured blocker.

## 22. Capability and lifecycle tests

Focused evidence must prove:

1. Closure absent from all ordinary navigation/layouts with
   MARKEI_NATIVE_CLOSURE_SURFACE both false and true;
2. Audit reachable from wide/medium navigation and compact More;
3. Audit zero-network and zero-write using instrumented fakes and before/after
   table counts or hashes;
4. two-Account and mismatched-environment fixtures cannot leak hosted status,
   attempts, events, queue or Device data;
5. cursor stability with equal timestamps, plus-one page detection and no
   duplicates across pages;
6. fixed two-query page count and bounded rendered rows on large fixtures;
7. local history caps/window/freshness and partial lifecycle meaning remain
   honest;
8. Settings persisted-threshold, validation, async, archive-refresh and
   loading/empty/error behavior;
9. existing Sign in, Sign out, Connect Device and Sync action delegation uses
   fakes only and changes no existing contract;
10. dangerous/support-only actions are absent from ordinary Settings/Audit;
11. wide/compact state parity at 599, 600, 1023 and 1024 logical pixels and at
    200-percent text;
12. keyboard order, focus restoration, non-color meaning and semantic labels;
13. controller generation/disposal and one idempotent composition close owner;
14. generated diagnostic registry remains unchanged and passes its drift check;
15. no regression to PH01/PH02, History, Analytics, Sync or provider boundaries.

Live Sign in, enrollment, hosted connection, Sync, Retry, Recovery, Auth0, Neon
and Render operations are forbidden during Codex validation.

## 23. Authorized writable paths

Codex may create or modify only these implementation/test/report paths:

- clients/markei_flutter/lib/app/markei_app.dart
- clients/markei_flutter/lib/app/markei_composition.dart
- clients/markei_flutter/lib/app/navigation/markei_destination.dart
- clients/markei_flutter/lib/app/pages/settings_page.dart
- clients/markei_flutter/lib/app/pages/audit_page.dart
- clients/markei_flutter/lib/app/pages/native_closure_page.dart
- clients/markei_flutter/lib/app/widgets/audit_components.dart
- clients/markei_flutter/lib/app/native_auth_closure_runner.dart
- clients/markei_flutter/lib/application/audit.dart
- clients/markei_flutter/lib/application/closure_diagnostics.dart
- clients/markei_flutter/lib/infrastructure/local/closure_diagnostics_repository.dart
- clients/markei_flutter/test/app/settings_page_test.dart
- clients/markei_flutter/test/app/audit_page_test.dart
- clients/markei_flutter/test/app/native_closure_surface_test.dart
- clients/markei_flutter/test/app/native_closure_diagnostics_test.dart
- clients/markei_flutter/test/app/markei_app_test.dart
- clients/markei_flutter/test/app/markei_visual_foundation_test.dart
- clients/markei_flutter/test/application/audit_test.dart
- clients/markei_flutter/test/infrastructure/closure_diagnostics_repository_test.dart
- clients/markei_flutter/test/infrastructure/native_auth_composition_test.dart
- clients/markei_flutter/test/infrastructure/native_closure_sync_path_test.dart
- documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
- documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md

If an authorized new file proves unnecessary, do not create it. Stop before
touching any other path and report the exact needed expansion.

## 24. Forbidden surfaces and stop conditions

Do not change:

- database schema, migrations, local_database.dart or generated Drift output;
- pubspec, lockfiles, packages, fonts or assets;
- diagnostic contracts, generator or generated registry;
- server/API, Auth contract, Sync contract, provider, environment or secrets;
- Analytics, Purchase History calculations or Account identity;
- methodology, permanent memory, A/B/C, D/E/F or J;
- R07/GCM04, causal persistence, hosted Audit, telemetry, automatic repair,
  retention, export, cross-device aggregation, multiple-user work or revocation.

Stop on any need for those surfaces, on contradictory D/E/F, on missing
Account/environment predicates, or when an ordinary Audit action can write or
contact the network.

## 25. Validation sequence

From clients/markei_flutter:

~~~text
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test test/app/settings_page_test.dart
flutter test test/app/audit_page_test.dart
flutter test test/application/audit_test.dart
flutter test test/infrastructure/closure_diagnostics_repository_test.dart
flutter test test/app/native_closure_surface_test.dart
flutter test test/app/native_closure_diagnostics_test.dart
flutter test test/app/markei_app_test.dart
flutter test test/app/markei_visual_foundation_test.dart
flutter test test/infrastructure/native_auth_composition_test.dart
flutter test test/infrastructure/native_closure_sync_path_test.dart
flutter test
flutter build windows --release
flutter build apk --debug
~~~

From repository root:

~~~text
node scripts/generate_sync_diagnostics.mjs --check
git diff --check
git status --short
~~~

If the current host cannot build Windows, record NOT_PERFORMED with the exact
host limitation; do not claim a pass. Android and Windows real-device,
assistive-technology, locale and human comprehension remain separate evidence.

## 26. Required G report

Replace G_OPS_CODEX.md with one complete PH03 execution report containing:

- starting and final HEAD;
- exact changed paths;
- capability-disposition result;
- Audit read/write/network/request-count evidence;
- Account/environment isolation and sanitization evidence;
- Settings corrections and action delegation;
- Closure navigation removal under both flag values;
- performance fixtures and lifecycle/disposal;
- every command and result;
- live operations not performed;
- blocked/skipped items and residual risk.

Required terminal:

~~~text
CYCLE=C11
PHASE=C11-PH03
ROUND=C11-PH03-R01
SETTINGS_FUNCTIONAL=PASS | PARTIAL | FAIL | BLOCKED
AUDIT_FUNCTIONAL=PASS | PARTIAL | FAIL | BLOCKED
AUDIT_LOCAL_READ_ONLY=PASS | FAIL | BLOCKED
AUDIT_NETWORK_CALLS=<exact count>
AUDIT_WRITE_CALLS=<exact count>
AUDIT_QUERIES_PER_PAGE=<exact count>
ACCOUNT_ENVIRONMENT_ISOLATION=PASS | FAIL | BLOCKED
SANITIZATION=PASS | FAIL | BLOCKED
CLOSURE_ORDINARY_NAVIGATION=ABSENT | PRESENT | BLOCKED
DANGEROUS_PRODUCT_CONTROLS=ABSENT | PRESENT | BLOCKED
SETTINGS_REGRESSION=PASS | FAIL | BLOCKED
RESOURCE_DISPOSAL=PASS | FAIL | BLOCKED
SCHEMA_MIGRATION=NONE | CONTRADICTED
GENERATED_SOURCE_CHANGED=NO | YES
DEPENDENCY_CHANGED=NO | YES
AUTH_SYNC_PROVIDER_CONTRACT_CHANGED=NO | YES
LIVE_PROVIDER_OPERATIONS=NOT_PERFORMED | PERFORMED
WINDOWS_RELEASE_BUILD=PASS | FAIL | NOT_PERFORMED
ANDROID_DEBUG_BUILD=PASS | FAIL | NOT_PERFORMED
NEXT_OPERATIONAL_REVIEW=<one exact action>
~~~

<!-- ACTIVATION_MARKER:C11-PH04-R01-2026-07-31 -->

# C11-PH04-R01 — Analytics Fine-Tuning Operational Authority

> Status: ACTIVE — CONTROLLING C11-PH04 CORRECTIVE IMPLEMENTATION AUTHORITY
> Phase type: exceptional, human-directed corrective phase
> Required implementation ancestry: `0924e743931ea7aba2c9cc5d2e28063e737b2ff5`
> Pairing: the E and F appends carrying this exact activation marker

## 27. Precedence, activation and retained truth

This append activates one Analytics-only correction after the implemented PH02
workspace and the implemented PH03 Settings/Audit/Closure round. It does not
reopen or reinterpret PH03. Permanent PH03 reconciliation may still occur
afterward from its existing G/H/I evidence.

The human C11-PH04 direction recorded on 2026-07-31 supersedes J section 11's
earlier scheduling of all UI fine-tuning to C12-PH01, but only for this bounded
Analytics correction. J's completed PH03 result, evidence ceiling, capability
disposition and requirement that PH03 source remain closed are retained. The
intervening PH03 permanent-domain/J reconciliation commits are compatible
publication ancestry when they leave D/E/F and implementation surfaces unchanged.

For Analytics behavior, this append and its paired E/F append supersede the
earlier PH02 presentation and card-transition instructions where they conflict.
They retain PH02's implemented evidence, calculation and isolation foundation:

- visibility-gated one-request local loading and explicit local-read Retry;
- active-Account-predicated joined evidence with no N+1 reads;
- Product, Purchase, Store and Time determinants;
- Sum, Mean, Difference and Percentage semantics;
- fixed-point/integer calculation, compatibility partitions, typed unavailable
  results, overflow protection and Purchase-total deduplication;
- stable Purchase Item evidence identity and History Purchase-ID handoff;
- one shared workspace/controller across compact, medium and wide layouts;
- no Analytics network, Auth, Sync, provider, diagnostic or causal authority.

The following earlier PH02 behaviors are corrected and must not survive in the
ordinary Analytics UI:

- creating a hard-coded default Product/Sum/Line-total card;
- passive determinant fields that do not let the user choose determinant values;
- every card expanding into a result and action stack at once;
- active edit, delete, manual reorder or destructive card controls;
- `Supporting evidence matrix` as the primary lower-section vocabulary;
- absence of Chart/Table presentation and Analytics CSV/PDF export;
- presentation in which the evidence matrix competes with the selected result in
  the initial viewport.

The approved visual proposal is a composition target, not a bitmap specification.
Codex must reuse the actual Lists-page theme, typography, spacing, content width,
cards, tables, control bands and responsive breakpoints. Do not copy literal
mockup colors, fonts, pixel coordinates, operating-system chrome or sample data.

## 28. Required page order and scroll ownership

`AnalyticsPage` owns one vertical `ListView`/scroll controller. The ordinary
reading and scroll order is:

1. existing Analytics page header and local/Account qualification;
2. `Create analysis` composer;
3. enlarged `Saved analyses — this session` record browser;
4. dominant selected-analysis result with `Chart` / `Table` switch and exports;
5. a truthful interpretation, timeframe and evidence-count summary;
6. `Variables` below the initial viewport;
7. Variables scope switch, controls, result-linked evidence and pagination.

Wide layouts must make items 2–4 the clear initial-viewport focus where ordinary
window height permits. The Variables section must remain reachable by the same
vertical page scroll, never by a competing nested vertical scroll. A compact
`Variables continue below` affordance may scroll to the Variables heading.

## 29. Functional analysis composer

Replace `New analysis card` with an explicit composer. It must expose:

- `Group by`: Product, Purchase, Store or Time;
- `Choose`: one or more Product, Purchase or Store values; for Time, a punctual
  date or period plus day/month grouping where supported;
- `Variables`: one or more relational breakdowns and quantitative measures;
- `Operation`: Sum, Mean, Difference or Percentage;
- `Timeframe`: All recorded time or a valid custom half-open UTC interval;
- selected-row scope when initialized from History or the lower Variables view;
- one primary `Run & save analysis` action;
- one `Clear draft` action that affects only the composer.

The Variables menu is one user-facing control with two disclosed groups:

- breakdowns: Purchased by, Payment method and Purchased for;
- measures: Quantity, Unit price, Price paid/Line total, Purchase total and
  Evidence count.

`Purchased for` remains visible but disabled as `Unavailable in recorded data`.
Purchased by and Payment method subdivide/label evidence; an operation is never
applied numerically to their identifiers or labels. At least one quantitative
measure is required. Empty, foreign or unavailable determinant choices, invalid
time intervals and unsupported operation/measure/scope combinations disable Run
and provide an adjacent explanation. No invalid combination may execute
silently.

Sum/Mean may group every selected determinant value. Difference requires exactly
two explicit comparable determinant groups or row scopes and remains comparison B
minus baseline A. Percentage requires a named part contained by a named whole and
remains part/whole, not percentage change. The composer must disclose the A/B or
part/whole selection it requires when those operations are chosen.

The user can type or choose a custom interval without losing an invalid draft.
All recorded time remains a distinct choice. A custom period applies as a
condition to Product, Purchase and Store analyses and as the grouping range for a
Time analysis.

## 30. Immutable session analysis records

`Run & save analysis` validates, executes and appends one immutable in-memory
record. The record freezes:

- creation/execution time in UTC;
- a short stable uppercase record fingerprint;
- registry identifier/version;
- determinant, chosen determinant values and labels;
- selected breakdowns, measures and operation;
- applied timeframe and explicit comparison/percentage operand meaning;
- evidence scope and stable contributing Purchase Item IDs;
- grouped result series/table values;
- eligible, total and excluded counts plus unavailable outcomes;
- factual interpretation.

Use the existing direct `crypto` dependency to derive the fingerprint from a
canonical representation of the frozen record. It is a compact record reference,
not a security, authenticity or causal proof. Collision handling within the
session must extend the displayed prefix or append a stable disambiguator.

Records are newest-first and remain available only for the lifetime of the
retained Analytics workspace. The UI must say `Saved analyses — this session` and
must not imply restart persistence, Sync or hosted storage. No schema, file-backed
record repository, preferences payload or migration is authorized.

Creating a record selects it. Previous/next arrow controls move between saved
records without changing them. The browser exposes scan-sized cards containing
date/time, fingerprint, Group by, variables and timeframe. The selected card has
non-color selection meaning. Remove active edit, delete and manual reorder
actions. A lock/`Saved record` indicator may be shown; any Edit/Delete control
that is rendered must be disabled and semantically explain immutability.

Repository Retry or Variables filtering must not recalculate, revise or delete
an existing record. A newly run record uses the then-current loaded evidence.

## 31. Selected result: Chart, Table and exports

Only the selected saved record owns the dominant result surface.

- `Chart` and `Table` are two projections of the same frozen grouped result;
- switching projection performs no repository read, calculation or record write;
- Chart is the default when the result has plottable compatible values;
- Table is always available and is the default/fallback for unplottable or typed
  unavailable results;
- the result header includes fingerprint, determinant/variables, created time,
  timeframe and evidence count;
- the explanation below states operation meaning, eligible/total/excluded counts,
  period and any compatibility partition.

Implement the chart with Flutter SDK primitives/`CustomPainter`; add no chart
dependency. Provide labelled determinant categories, legend, units/currencies,
zero baseline when relevant and non-color series distinction. Mixed incompatible
units/currencies must use separate explicitly labelled series/axes or remain in
the Table projection; never normalize or plot them as one scale. Long category
sets use a bounded-height horizontally scrollable plot rather than silent
truncation. No chart animation may block interaction or change evidence.

`Export CSV` and `Export PDF` export the selected frozen record, not the mutable
current Variables view. CSV contains metadata, grouped result rows and exact
contributing evidence rows. PDF contains the same factual metadata and result
table; including a raster/vector chart is optional and must not block the PDF.
Reuse the existing pure export/PDF approach and explicit temporary-file behavior;
add no dependency. Only a deliberate export may write a temporary file. Report
success path or sanitized failure while preserving the record.

Operational counts for ordinary Analytics are therefore:

- initial visible load: exactly one local evidence request;
- explicit Retry: exactly one additional local evidence request;
- composer, Run, record selection, Chart/Table, Variables scope/filter/sort/page,
  row selection and navigation: zero repository requests;
- Analytics database writes: zero;
- Analytics network requests: zero;
- export temporary-file writes: exactly one per successful explicit export.

## 32. Variables below the fold

Rename the lower surface `Variables`, qualified as registered Purchase evidence
available locally for analysis. It provides one shared selection state and two
projections:

- `Purchases`: one row/card per distinct Purchase, with Purchase ID, occurrence
  time, Store, Purchased by, Purchased for unavailable, Payment method, item
  count, Purchase total and currency;
- `Contained items`: one row/card per persisted Purchase Item, with Purchase ID,
  date/time, Product ID/code/name/brand, Store ID/name, Purchased-by
  ID/code/nickname when available, Purchased-for unavailable, Payment Method
  ID/code/nickname when available, quantity/unit, Unit price, Line total and
  Promotion unavailable.

Wide uses the Lists-page dense table language with horizontal accommodation;
compact/medium use readable evidence cards. Do not compress the desktop table
into a phone-width table.

Both projections provide search, available categorical filters, deterministic
sort, selection count, 20-row default pagination and previous/next controls.
Sorting/filtering/paging never rereads the repository. Purchase selection expands
to that Purchase's stable Item IDs; contained-item selection uses exact Item IDs.
`Use selected rows` initializes a new composer scope and returns focus/scroll to
the composer without guessing determinant, variables or operation.

When a saved record is selected, Variables initially shows its contributing
evidence and a selected-record banner. `Show all variables` removes only that
record focus. Selection and filter changes never alter the frozen record.

## 33. State, accessibility and performance gates

Required states include loading, first use, no Account data, ready with no saved
records, invalid draft, saved record selected, Chart unavailable/Table available,
Variables filtered empty, Variables selection empty, export busy/success/failure,
local read failure and stale async completion.

At 599, 600, 1023 and 1024 logical pixels, and after crossing those widths:

- one controller, draft, record list, selected record, result projection,
  Variables scope/filter/sort/page and selection survive;
- compact reading order matches the wide meaning;
- controls remain reachable at 200-percent text scale;
- keyboard traversal, focus, semantics and non-color state remain coherent;
- chart semantics summarize title, categories, series, units and evidence count;
- the Table projection remains an accessible equivalent.

Retain the PH02 ordinary/stress fixtures. Record load, record creation, grouped
calculation, Chart build and Table build elapsed time. No N+1 query, unbounded
widget creation, synchronous visible hang or category-label overlap at tested
sizes may pass silently. Render only the current Variables page and selected
record result; do not build every historical result chart.

## 34. Authorized writable paths

Only these paths may change:

```text
clients/markei_flutter/lib/domain/analytics/analytics_models.dart
clients/markei_flutter/lib/domain/analytics/analytics_registry.dart
clients/markei_flutter/lib/application/analytics.dart
clients/markei_flutter/lib/application/analytics_workspace.dart
clients/markei_flutter/lib/infrastructure/local/local_analytics_repository.dart
clients/markei_flutter/lib/app/pages/analytics_page.dart
clients/markei_flutter/lib/app/widgets/analytics_components.dart
clients/markei_flutter/test/analytics_registry_test.dart
clients/markei_flutter/test/application/analytics_test.dart
clients/markei_flutter/test/application/analytics_workspace_test.dart
clients/markei_flutter/test/infrastructure/local_analytics_repository_test.dart
clients/markei_flutter/test/app/analytics_page_test.dart
clients/markei_flutter/test/app/analytics_components_test.dart
clients/markei_flutter/test/app/history_analytics_handoff_test.dart
clients/markei_flutter/test/app/markei_app_test.dart
clients/markei_flutter/test/app/markei_visual_foundation_test.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Codex may omit a new authorized test when the responsibility is covered cleanly
by another authorized test. It may not invent a source, test or artifact path.

Do not modify `markei_theme.dart`, Lists, History, app shell/composition,
`local_database.dart`, generated Drift source, schema, migrations, pubspec,
lockfiles, dependencies, assets, fonts, platform code, API, Auth, Sync, provider,
diagnostic, PH03 source/tests, D/E/F, A/B/C, J, Main-root, permanent memory or
methodology. Stop if the result requires any forbidden path.

## 35. Validation, publication and required G report

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
flutter test test/app/analytics_components_test.dart
flutter test test/app/history_analytics_handoff_test.dart
flutter test test/app/markei_visual_foundation_test.dart
flutter test test/app/markei_app_test.dart
flutter test --concurrency=1
flutter build windows --release
flutter build apk --debug
```

If an authorized optional test file is not created, record `NOT_CREATED` and run
the owning alternate focused test. Also run the repository diagnostic-generator
drift check, exact changed-path audit, forbidden-import audit, secret audit and
`git diff --check`. A missing host tool/build is `NOT_PERFORMED`, never PASS.

Replace G with a C11-PH04 report containing exact changed paths; retained PH02
invariants; composer options and validation; saved-record metadata/fingerprint,
immutability and session lifetime; grouped result behavior; Chart/Table parity;
CSV/PDF file-write counts; Variables Purchase/Item behavior; repository/network/
database-write counts; performance; responsive/accessibility evidence; commands;
builds; forbidden-surface audit; deviations and residual risk.

Required terminal:

```text
CYCLE=C11
PHASE=C11-PH04
ROUND=C11-PH04-R01
PH03_IMPLEMENTATION_ANCESTOR=0924e743931ea7aba2c9cc5d2e28063e737b2ff5
STARTING_HEAD=<C11-PH04 D/E/F activation commit>
ANALYTICS_COMPOSER=PASS | FAIL | BLOCKED
DETERMINANT_VALUE_SELECTION=PASS | FAIL | BLOCKED
VARIABLE_OPERATION_VALIDATION=PASS | FAIL | BLOCKED
IMMUTABLE_SESSION_RECORDS=PASS | FAIL | BLOCKED
RECORD_FINGERPRINT=PASS | FAIL | BLOCKED
CHART_TABLE_PARITY=PASS | FAIL | BLOCKED
CSV_EXPORT=PASS | FAIL | BLOCKED
PDF_EXPORT=PASS | FAIL | BLOCKED
VARIABLES_PURCHASE_ITEM_PROJECTIONS=PASS | FAIL | BLOCKED
VARIABLES_SELECTION_HANDOFF=PASS | FAIL | BLOCKED
ANALYTICS_REPOSITORY_REQUESTS=initial:1; retry:+1; local_ui:+0
ANALYTICS_DATABASE_WRITES=0
ANALYTICS_NETWORK_REQUESTS=0
EXPLICIT_EXPORT_FILE_WRITES=<exact count>
ACCOUNT_ISOLATION=PASS | FAIL | BLOCKED
PH02_CALCULATION_REGRESSION=PASS | FAIL | BLOCKED
RESPONSIVE_ACCESSIBILITY=PASS | FAIL | BLOCKED
FOCUSED_TESTS=PASS | FAIL | BLOCKED
FULL_FLUTTER_TEST=PASS | FAIL | BLOCKED_TIMEOUT
WINDOWS_RELEASE_BUILD=PASS | FAIL | NOT_PERFORMED
ANDROID_DEBUG_BUILD=PASS | FAIL | NOT_PERFORMED
SCHEMA_MIGRATION=NONE | CONTRADICTED
GENERATED_SOURCE_CHANGED=NO | YES
DEPENDENCY_CHANGED=NO | YES
PH03_SURFACES_CHANGED=NO | YES
LIVE_PROVIDER_OPERATIONS=NOT_PERFORMED | CONTRADICTED
PUBLICATION=PUSHED | NOT_PUSHED
NEXT_MAIN_ACTION=Reconcile C11-PH04 G/H/I evidence and schedule human rendered review.
```

---

<!-- ACTIVATION_MARKER:C11-PH05-R01-2026-07-31 -->

# C11-PH05-R01 — Operational Materialization Authority

> Status: ACTIVE — AUTHORIZED FOR CODEX
> Source reconciliation: J section 13
> Required starting remote ancestor: `42cb6fcac60a5033c72864201786f7fcfab9a35b`
> Required PH04 implementation ancestor: `1aea7a5b531b56484e999aa8989978902b8db2c0`

## 36. Mission and stop boundary

Materialize the schema-free PH05 UI/UX and local-export correction described in
the synchronized D/E/F tails. Do not modify permanent memory, methodology,
Main-root continuity, A/B/C, J or D/E/F. Replace G/H/I only after source work and
validation.

Stop before editing if:

- the branch is not `grm-guarded-provisioning-20260727`;
- either named ancestor is missing;
- remote HEAD advanced beyond the PH05 activation commit with unrelated paths;
- the worktree contains unrelated changes that cannot be preserved;
- the solution requires schema, migration, generated Drift, a dependency or
  lockfile change, Android/Windows platform-file changes, Auth, Sync, provider,
  diagnostic registry or Closure expansion;
- a truthful Android public Downloads implementation is treated as mandatory.

Android public Downloads is deliberately unavailable in this packet. Do not
substitute `Directory.systemTemp`, app-private storage or broad storage
permission and call it Downloads.

## 37. Operational work units

### 37.1 Home, Purchase and Catalogue

Home adds two static local information cards: `News` and `Updates follow-up`.
Their build, refresh, layout and navigation budgets are zero repository calls,
zero writes and zero network. They are not a feed and should not poll.

Purchase recomposes Store/date/time beside independent optional Person and
Payment Method controls at medium/wide widths and stacks them in the same logical
order on compact. Preserve all existing draft values, validation, focus targets,
load calls and registration payload. Layout changes add zero calls.

Catalogue removes `_selectedProduct`, generated `DataTable` checkbox chrome,
selection highlighting, selected copy and selection callbacks as one complete
responsibility. Preserve `_selectedDetail`, filters, sorting, create operations,
Retry and explicit `View details`. Hiding chrome while retaining dormant state
is a failure.

### 37.2 History selection and handoff

Retain exactly one `Set<PurchaseId>` for selected-for-action state and keep it
separate from open-detail identity. Required transitions:

```text
zero -> one -> many -> one -> zero
toggle one -> only that stable ID changes
final uncheck -> zero is allowed
clear selection -> zero
select all shown -> exactly the current filtered loaded window
filter change -> prune selection to rows now shown
successful reload -> intersect selection and detail with returned Account rows
Account/repository replacement -> no foreign or stale action identity
```

Wide rows must not render an automatic DataTable checkbox column in addition to
the explicit selection checkbox. Checkbox activation must not open detail.
Detail activation must not alter the selected set.

All set actions capture one immutable copy of selected IDs when started. Export
and handoff actions expose busy, disabled, success and sanitized failure states;
repeated taps cannot overlap. `Use in Analytics` performs no History read/write,
no calculation and no record creation.

The final PH04 `AnalyticsWorkspaceController._applyLaunchContext` already maps
Purchase IDs to stable Item IDs. Preserve it and change only what is necessary
to report requested, matched and unavailable Purchase counts and to remove the
misleading `Analytics will calculate` message. The selected scope cap remains
500 Item IDs. No second controller or dataset request is allowed.

### 37.3 Set-based History export

Replace the current per-ID `getPurchaseDetail` loop with two set-based,
Account-scoped queries:

1. selected Purchase/Store/Person/Payment rows;
2. selected Purchase Item/Product rows.

Reject or omit foreign IDs through Account predicates and preserve deterministic
Purchase and Item ordering. For N selected IDs, export data reads remain exactly
two when N is non-zero, not `2N`. Empty selection starts no export.

Keep `purchaseBundleCsv` and `purchaseBundlePdfBytes` pure. Capture one frozen
bundle before writing. No database write or network request is allowed.

### 37.4 Shared export destination

Create one application port and one composition-injected adapter used by both
History and final PH04 Analytics exports. Required transition:

```text
explicit action
-> validate selected frozen export object
-> resolve supported destination
-> generate safe unique filename
-> create one file exclusively
-> write complete bytes/text
-> report user-visible destination
```

Success creates exactly one final file. Preview, selection, navigation, disabled
actions, unsupported platform, destination failure and builder failure create
zero final files. Collision handling must never overwrite: append `-2`, `-3`,
and so on with a bounded search. Remove only an attributable incomplete file
after a failed current write.

Filename base rules: lower-case ASCII `[a-z0-9._-]`, collapsed separators, no
path separators/traversal/reserved device names, bounded length, correct `.csv`
or `.pdf`, a non-private stable cue and UTC timestamp. Do not expose Account,
Device or raw database identifiers.

Windows uses `getDownloadsDirectory()` from the existing direct
`path_provider` dependency and reports the final path only after write success.
Android and unsupported platforms return a typed unavailable result with zero
write. Native sharing is not implemented.

### 37.5 Guide, Audit and Settings

Guide is local/static. It performs zero repository calls, writes and network
requests. Its eight sections must remain reachable on compact/wide and at
200-percent text.

Audit System, Readiness summary and Diagnostics cards are pure projections of
the already-loaded `AuditPageResult`. Initial visible load stays exactly two
local queries; local Retry adds two; card build/expand/reflow adds zero. Audit
database writes and network requests remain zero.

Settings retains one page state and the existing five initial capability calls:
People, Payment Methods, threshold, Account status and local Sync/Device status.
No Device collection read is added. Recompose sections, bound reference-list
height where needed and keep Advanced visible/non-collapsible. Fix support-action
post-refresh through an internal status load that may run while the public busy
guard remains held; do not permit duplicate actions or stale completion.

Reference save/archive/threshold behavior and 0–365 validation remain unchanged.
Duplicate nicknames remain allowed by current repository truth. `@NNN` and
`#NNN` allocation and stored values remain unchanged.

## 38. Exact writable path allowlist

Codex may change only these source and existing test paths:

```text
clients/markei_flutter/lib/application/home_content.dart
clients/markei_flutter/lib/app/pages/home_page.dart
clients/markei_flutter/lib/app/pages/purchase_page.dart
clients/markei_flutter/lib/app/pages/products_page.dart
clients/markei_flutter/lib/app/pages/history_page.dart
clients/markei_flutter/lib/application/history_export.dart
clients/markei_flutter/lib/infrastructure/local/local_query_repository.dart
clients/markei_flutter/lib/app/markei_app.dart
clients/markei_flutter/lib/application/analytics.dart
clients/markei_flutter/lib/application/analytics_workspace.dart
clients/markei_flutter/lib/app/pages/analytics_page.dart
clients/markei_flutter/lib/app/markei_composition.dart
clients/markei_flutter/lib/application/audit.dart
clients/markei_flutter/lib/app/pages/audit_page.dart
clients/markei_flutter/lib/app/widgets/audit_components.dart
clients/markei_flutter/lib/app/pages/settings_page.dart
clients/markei_flutter/test/app/history_analytics_handoff_test.dart
clients/markei_flutter/test/application/analytics_workspace_test.dart
clients/markei_flutter/test/app/analytics_page_test.dart
clients/markei_flutter/test/app/settings_page_test.dart
clients/markei_flutter/test/app/audit_page_test.dart
clients/markei_flutter/test/app/markei_app_test.dart
clients/markei_flutter/test/app/markei_visual_foundation_test.dart
```

These new paths are explicitly authorized when needed:

```text
clients/markei_flutter/lib/application/export_destination.dart
clients/markei_flutter/lib/infrastructure/platform/local_export_destination.dart
clients/markei_flutter/lib/app/pages/guide_page.dart
clients/markei_flutter/test/application/export_destination_test.dart
clients/markei_flutter/test/app/history_page_test.dart
clients/markei_flutter/test/app/guide_page_test.dart
clients/markei_flutter/test/infrastructure/local_query_repository_export_test.dart
```

Codex may omit a new focused test path only when its full responsibility is
proved clearly in an existing authorized test. Do not invent another path.

After implementation, replace exactly:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

## 39. Forbidden surfaces

Do not change:

```text
pubspec.yaml / pubspec.lock / dependencies
android/, windows/, ios/, linux/, macos/ platform files
local_database.dart / generated Drift files / schema / migrations
Analytics registry, fixed-point calculation or record identity semantics
Purchase persistence models or registration repository
Auth / API / Sync / provider / diagnostics registry and generator
Closure implementation or ordinary navigation disposition
theme, assets or fonts unless an existing authorized page cannot compile
A/B/C, D/E/F, J, Main-root, permanent memory or methodology
environment files, credentials or secrets
```

## 40. Validation and failure injection

Run from `clients/markei_flutter`:

```text
flutter pub get
git diff --exit-code -- pubspec.yaml pubspec.lock
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test test/application/export_destination_test.dart
flutter test test/app/history_page_test.dart
flutter test test/app/history_analytics_handoff_test.dart
flutter test test/application/analytics_workspace_test.dart
flutter test test/app/analytics_page_test.dart
flutter test test/app/guide_page_test.dart
flutter test test/app/settings_page_test.dart
flutter test test/app/audit_page_test.dart
flutter test test/app/markei_visual_foundation_test.dart
flutter test test/app/markei_app_test.dart
flutter test --concurrency=1
flutter build windows --release
flutter build apk --debug
```

If an optional authorized focused test was not created, record `NOT_CREATED`
and run the exact alternate owner test. Also run from repository root:

```text
node scripts/generate_sync_diagnostics.mjs --check
git diff --check
```

Instrument and prove:

- zero Home/Guide I/O;
- unchanged Purchase/Catalogue request and write budgets;
- History zero/one/many/final-uncheck/filter-prune/reload-intersection;
- no checkbox-to-detail coupling;
- History export reads `2`, database writes `0`, network `0`;
- each successful explicit export writes `1` final file;
- unsupported Android export writes `0`;
- collision, unavailable directory and write failure;
- Analytics initial request `1`, Retry `+1`, handoff/export/local UI `+0`;
- Audit initial queries `2`, Retry `+2`, projection `+0`, writes/network `0`;
- Settings initial calls `5`, local refresh `+2`, duplicate action blocked and
  post-action status actually refreshed;
- 599/600/1023/1024 widths, 200-percent text, long copy, keyboard focus,
  semantics and non-color meaning.

Keep screenshot, Narrator/TalkBack, locale, real-device and comprehension
evidence separate and mark unperformed unless observed.

## 41. Publication and G report

Before committing, fetch the branch again and accept advancement only when it is
a compatible documentation-only descendant explicitly authorized by Main. Stop
on source overlap. Require every changed path to match section 38. Do not rebase,
force-push or open a pull request.

Replace G with exact changed paths, commands, results, request/write counts,
Windows Downloads and Android-unavailable evidence, performance measurements,
failure injection, build artifacts, forbidden-surface audit, deviations and
residual human gates.

Required terminal:

```text
CYCLE=C11
PHASE=C11-PH05
ROUND=C11-PH05-R01
STARTING_HEAD=<PH05 D/E/F activation commit>
PH04_IMPLEMENTATION_ANCESTOR=1aea7a5b531b56484e999aa8989978902b8db2c0
HOME_LOCAL_INFORMATION=PASS | FAIL | BLOCKED
PURCHASE_REDISTRIBUTION=PASS | FAIL | BLOCKED
CATALOGUE_SELECTION_REMOVAL=PASS | FAIL | BLOCKED
HISTORY_MULTI_SELECTION=PASS | FAIL | BLOCKED
HISTORY_SET_EXPORT_READS=2 | CONTRADICTED
ANALYTICS_SCOPE_HANDOFF=PASS | FAIL | BLOCKED
WINDOWS_DOWNLOADS_EXPORT=PASS | FAIL | NOT_PERFORMED
ANDROID_PUBLIC_DOWNLOADS=UNAVAILABLE_BY_AUTHORITY | CONTRADICTED
EXPORT_FINAL_WRITE_COUNT=1_PER_SUCCESS | CONTRADICTED
GUIDE=PASS | FAIL | BLOCKED
AUDIT_PROJECTION_IO=initial:2; retry:+2; projection:+0; writes:0; network:0
SETTINGS_INITIAL_CALLS=5 | CONTRADICTED
SETTINGS_POST_ACTION_REFRESH=PASS | FAIL | BLOCKED
REFERENCE_CODES=UNCHANGED | CONTRADICTED
FOCUSED_TESTS=PASS | FAIL | BLOCKED
FULL_FLUTTER_TEST=PASS | FAIL | BLOCKED_TIMEOUT
WINDOWS_RELEASE_BUILD=PASS | FAIL | NOT_PERFORMED
ANDROID_DEBUG_BUILD=PASS | FAIL | NOT_PERFORMED
SCHEMA_MIGRATION=NONE | CONTRADICTED
GENERATED_SOURCE_CHANGED=NO | YES
DEPENDENCY_CHANGED=NO | YES
PLATFORM_FILES_CHANGED=NO | YES
LIVE_PROVIDER_OPERATIONS=NOT_PERFORMED | CONTRADICTED
PUBLICATION=PUSHED | NOT_PUSHED
NEXT_MAIN_ACTION=Reconcile PH05 G/H/I and perform bounded human UI/export review.
```

---

<!-- MATERIALIZATION_AUTHORITY:C11-ANALYTICS-CORRECTION-R01-2026-07-31 -->

# C11 Analytics Correction Round 01 — Operational Materialization Authority

## 42. Precedence, activation and evidenced diagnosis

This section is the controlling Operational authority for the bounded
post-PH05 Analytics correction. It supersedes C11-PH04 sections 27–35 only where
the later human decisions or this correction contract conflict. C11-PH05
invariants remain active.

```text
REPOSITORY=gus-i-gu/markei
BRANCH=grm-guarded-provisioning-20260727
ACTIVATION_BASE=e6ced7fe3945925bf5f314ee11c4538029e18d44
PH05_IMPLEMENTATION=426235d8b67ac719e494b53cfb23a6c3b06fb489
PH05_AUTHORITY=b59b2ecdfb69ca98c431b9f36694f011332fbef3
UNIT=C11-ANALYTICS-CORRECTION-R01
```

The human runtime evidence is accepted. Source inspection establishes a bounded
diagnosis rather than an evidenced default-Quantity calculation leak:

- grouped entries iterate only the measures in the current draft;
- the immutable record copies the selected measures, breakdowns, operation and
  timeframe;
- Chart, Table, interpretation, CSV and PDF consume that frozen record;
- no current source path evidences silent insertion of Quantity when it was not
  selected;
- result rendering and export do expose fixed-point storage integers and raw
  compatibility keys. Quantity therefore appears as values such as
  `5000000 quantity:mass:kg`, and money/unit-price results can likewise expose
  internal minor-unit or compatibility representations;
- existing tests assert individual paths, but do not prove one multi-variable
  selection stays identical through every result and export projection.

Treat raw fixed-point/internal-key presentation as the confirmed defect. Retain
calculation-variable leakage as a regression risk that must be disproved by the
required end-to-end tests; do not invent an unrelated replacement variable.

The human also executed the diagnostic full suite on Windows with:

```powershell
flutter test --concurrency=1 --no-pub -r expanded
```

and recorded `TestExit=0`. This distinguishes the earlier bare-parallel
procedure failure from an Analytics source regression. It does not establish
rendered UI, Windows launch, accessibility or real-device acceptance.

## 43. Correction work units

### 43.1 Calculation and projection integrity

Preserve one explicit path:

```text
visible composer selection
→ one AnalyticsComposerDraft truth
→ typed validation
→ immutable AnalyticsRecord
→ grouped entries
→ Chart/Table
→ interpretation
→ CSV/PDF
```

Every consumer must expose exactly the determinant, categorical breakdowns,
numeric measures, operation, scope and timeframe frozen in the selected record.
Changing the live draft after saving must not mutate or relabel an existing
record. Selecting another saved record must not reuse the current draft.

Convert fixed-point values only for presentation:

- Quantity: convert microunits through `NormalizedQuantity.factor` and show the
  canonical user-facing unit;
- Unit price: convert minor units per canonical unit and show currency per unit;
- Price paid and Purchase total: convert currency minor units to a decimal money
  value;
- Evidence count: show an integer item-row count;
- Percentage: convert basis points to percent;
- Difference: preserve sign and use the selected measure's display scale;
- compatibility keys remain internal identity and must not appear as the normal
  unit/currency label.

Chart scaling may continue to use exact integer values internally, but Chart
semantics, Table, interpretation, CSV and PDF must use equivalent human-facing
values and units. Pure export builders and one-write destination behavior remain.

### 43.2 Compact composer and evidence status

The visible primary order is:

```text
Group by | Variables | Operation | Timeframe | Run & save
```

Wide layouts use one compact primary row where space permits. Compact/mobile
layouts use a responsive two-by-two control grid followed by a full-width
`Run & save` action. Saved analyses follow immediately below the composer, then
the selected result, then Variables evidence.

Reduce the vertical cost of `Local evidence scope`; preserve its loaded/read
failure state, requested/matched/unavailable handoff counts and Retry action.
It may become a compact status strip or concise state block, but initial load is
still one local repository request and each Retry adds exactly one. Local UI,
selection, calculation and export add zero repository requests, database writes
or network requests.

Retain `Clear draft` as a compact secondary action near the composer. It resets
only the live draft and preserves immutable saved analyses. Do not silently
remove this behavior.

### 43.3 Unified typed Variables behavior

Expose one multi-select `Variables` control. Do not render separate visible
pill banks for categorical breakdowns and numeric measures. Maintain one source
of truth; a typed adapter may derive the existing breakdown and measure sets, or
a single typed selection may replace them atomically. Do not keep two mutable
selection owners.

Mapping:

| Visible choice | Typed role | Calculation behavior |
| --- | --- | --- |
| Purchased by | categorical | breakdown dimension |
| Purchased for | categorical | unavailable with explanation until recorded data supports it |
| Payment method | categorical | breakdown dimension |
| Quantity | numeric | measure, unit-compatible buckets only |
| Unit price | numeric | measure, currency/kind/unit-compatible buckets only |
| Price paid | numeric | line-total money measure |
| Purchase total | numeric | counted once per Purchase |
| Evidence count | numeric | explicit item-row count; never an implicit fallback |

Required states:

- categorical-only: block Run & save and explain that a numeric variable is
  required; never insert Evidence count;
- numeric-only: valid when determinant keys, operation and timeframe are valid;
- mixed categorical/numeric: categorical choices subdivide the selected numeric
  measures;
- multiple numeric units: calculate each compatible series independently;
  disable Chart with an explanation when one comparable axis is impossible,
  while Table/CSV/PDF retain all typed series;
- unsupported operation/measure: block with a selection-specific explanation;
- Difference/Percentage: require exactly two determinant groups and compatible
  evidence; otherwise block or return typed unavailable evidence without
  substituting another measure.

### 43.4 Custom local-calendar timeframe

Replace the user-facing ISO/UTC interval string with two fields:

```text
Initial date | Final date
dd-mm-yyyy   | dd-mm-yyyy
```

Parsing must be strict and reject overflow-normalized dates. The user meaning is
inclusive on both dates. Convert device-local calendar boundaries to the
existing start-inclusive/end-exclusive UTC interval:

```text
startUtc = local midnight at Initial date converted to UTC
endUtc   = local midnight on the calendar day after Final date converted to UTC
```

Construct the next local calendar day before converting to UTC so DST or offset
changes do not truncate the final day. Invalid dates, missing paired fields and
Final-before-Initial block `Run & save` with local guidance. Preserve internal
UTC purchase timestamps and interval conditions.

### 43.5 Variables evidence identity and columns

Keep Purchase, Item, Product, Store and reference IDs internally for Account
scope, selection, History handoff, paging, record reconstruction and widget keys.
Remove UUIDs from ordinary user-facing wide tables and compact cards.

Purchase projection presents separate `Date-Time of purchase` and `Store name`
information plus Purchased by, Purchased for, Payment method, Item count and
Purchase total as available. Item projection presents Date-Time of purchase,
Product code/name/brand, Store name, relational facts, Quantity/unit, Unit price,
Price paid and Promotion. Product, Purchase and Store UUIDs must not be embedded
in visible labels. Compact cards carry the same facts at lower density.

Use device-local, human-readable purchase date-time presentation while retaining
stored UTC authority internally. Search, sort, pagination, selection, History
scope and frozen-record evidence identity remain stable-ID based.

## 44. Regression matrix

Add focused tests for all cases below. Each test must assert requested draft,
frozen record, grouped entries, Chart availability/semantics, Table labels,
interpretation and CSV/PDF agreement where applicable.

1. Product + Price paid and Quantity + Mean.
2. Store + Price paid + Sum.
3. Time by month + Quantity + Sum.
4. Product + Payment method + compatible numeric variable.
5. Purchase + Purchase total + Mean and Sum without duplicate item counting.
6. one-day custom range includes the complete Final date.
7. invalid date and reversed range block Run & save.
8. multiple numeric variables with incompatible units retain separate typed
   Table/export series and explain Chart unavailability.
9. categorical-only selection blocks without implicit count/Quantity.
10. History-selected Purchase scope preserves requested/matched/unavailable
    counts and calculates only matched rows.

Also assert draft changes do not mutate saved records, selecting records does not
reuse the live draft, no UUID appears in Variables UI, and raw fixed-point values
or compatibility keys do not appear in user-facing result/export fields.

## 45. Writable paths and forbidden surfaces

Authorized handwritten source/test paths:

```text
clients/markei_flutter/lib/domain/analytics/analytics_models.dart
clients/markei_flutter/lib/domain/analytics/analytics_registry.dart
clients/markei_flutter/lib/application/analytics.dart
clients/markei_flutter/lib/application/analytics_workspace.dart
clients/markei_flutter/lib/app/pages/analytics_page.dart
clients/markei_flutter/lib/app/widgets/analytics_components.dart
clients/markei_flutter/test/application/analytics_test.dart
clients/markei_flutter/test/application/analytics_workspace_test.dart
clients/markei_flutter/test/app/analytics_page_test.dart
clients/markei_flutter/test/app/analytics_components_test.dart
clients/markei_flutter/test/app/history_analytics_handoff_test.dart
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Change `analytics_registry.dart` only if typed compatibility/operation validation
requires it. No new source or test file is authorized without a documented stop
and Main approval.

Forbidden:

- schema, migrations, generated files, dependencies and native platform files;
- Auth, API, Sync, provider, diagnostics, PH03, Closure or non-Analytics pages;
- new repository/network/write authority;
- a second Analytics controller, persistence owner or calculation path;
- deletion of stable internal identities;
- `documentation/GRM.md`, `documentation/G_SCRIPTS.md`,
  `documentation/I_SCRIPTS.ps1`, `documentation/NS_COORDINATES.md` and
  `documentation/DB_MGMT.sql`;
- J, A/B/C, permanent domains and methodology.

## 46. Validation, build/run boundary and required G report

Run from `clients/markei_flutter`:

```powershell
flutter pub get
git diff --exit-code -- pubspec.yaml pubspec.lock
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test --concurrency=1 --no-pub test/application/analytics_test.dart test/application/analytics_workspace_test.dart test/app/analytics_page_test.dart test/app/analytics_components_test.dart test/app/history_analytics_handoff_test.dart
flutter test --concurrency=1 --no-pub
flutter build windows --release
flutter build apk --debug
node ..\..\scripts\generate_sync_diagnostics.mjs --check
```

If the host cannot perform a platform build, report `NOT_PERFORMED` rather than
claiming success. Do not invoke live Auth, provider or Sync operations. Do not
edit the GRM/GS procedure family to make this implementation pass.

Before publication, require a clean named-branch preflight, compatible ancestry,
the exact allowlist, and no unrelated changes. Commit source/tests plus replaced
G/H/I as one focused implementation commit and push without force or PR.

G must report the diagnosis, changed paths, regression matrix, request/write
counts, serial full-suite result, both build results, raw-value/UUID absence,
date-boundary evidence, forbidden-surface audit and residual human gates.

Required terminal:

```text
CYCLE=C11
UNIT=C11-ANALYTICS-CORRECTION-R01
CALCULATION_SELECTION_INTEGRITY=PASS | FAIL | BLOCKED
RAW_FIXED_POINT_PRESENTATION=REMOVED | PRESENT
UNIFIED_VARIABLES=PASS | FAIL | BLOCKED
CUSTOM_DATE_RANGE=PASS | FAIL | BLOCKED
FINAL_DATE_INCLUSIVE=PASS | FAIL | BLOCKED
VISIBLE_UUIDS=ABSENT | PRESENT
CHART_TABLE_EXPORT_PARITY=PASS | FAIL | BLOCKED
ANALYTICS_REQUESTS=initial:1; retry:+1; other:+0
ANALYTICS_DATABASE_WRITES=0 | CONTRADICTED
ANALYTICS_NETWORK_CALLS=0 | CONTRADICTED
SERIAL_FULL_FLUTTER_TEST=PASS | FAIL | BLOCKED_TIMEOUT
WINDOWS_RELEASE_BUILD=PASS | FAIL | NOT_PERFORMED
ANDROID_DEBUG_BUILD=PASS | FAIL | NOT_PERFORMED
SCHEMA_MIGRATION=NONE | CONTRADICTED
DEPENDENCY_GENERATED_PLATFORM_CHANGE=NO | YES
GRM_GS_FILES_CHANGED=NO | CONTRADICTED
PUBLICATION=PUSHED | NOT_PUSHED
NEXT_MAIN_ACTION=Reconcile G/H/I and perform human wide/compact, keyboard, locale and real-device review.
```
