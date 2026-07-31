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
