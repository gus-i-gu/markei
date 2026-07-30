# D_OPS_STAGE — C11-PH01-S01 Visual Foundation, Shell, Home and Lists

> Sequence: FLX-ORD-01
> Role: Main operational materialization stage
> Cycle / phase / unit: C11 / C11-PH01 / C11-PH01-S01
> Repository: `gus-i-gu/markei`
> Branch: `grm-guarded-provisioning-20260727`
> Cycle-entry baseline: `861c27fdaf6ade2093d481af312d27ff895b8dc0`
> Reconciled A/B/C head: `4b1abc01a93351f5910ea8af5001782b59a784f7`
> Codex starting HEAD: the direct descendant commit publishing this synchronized
> D/E/F packet, pinned by the seeding prompt
> Authority: **ACTIVE — CODEX IMPLEMENTATION AUTHORIZED**
> Provider mutation authority: none

## 1. Purpose

Materialize the first reversible unit of C11-PH01:

1. characterize the existing shell, Home, Lists and retained page state;
2. establish a semantic visual token and shared-component foundation;
3. replace positional navigation identity with stable destination identity;
4. implement compact, medium and wide presentation policies;
5. recompose Home into a truthful task-oriented entry surface;
6. recompose Lists into responsive table/card projections with readable states;
7. reserve Analytics, Settings and Audit destinations without implementing
   PH02 Analytics or PH03 Settings/Audit behavior.

This unit proves the shared visual language before Catalogue, History and
Purchase are recomposed. It is not the whole of C11-PH01.

## 2. Reconciled implementation decisions

### 2.1 Responsive policy

Use semantic layout classes:

```text
compact: width < 600 logical pixels
medium: 600 <= width < 1024 logical pixels
wide: width >= 1024 logical pixels
```

The implementation may centralize these thresholds as presentation tokens.
Tests must cover immediately below, at and immediately above both boundaries.

- Compact uses a bottom navigation bar with Home, Lists, Purchase and History
  directly available plus More.
- Medium uses a compact rail with accessible labels/tooltips.
- Wide uses a persistent labelled or extended rail/sidebar and bounded content
  canvas.
- Resizing must preserve the selected destination, Home/Lists page state and
  hidden-page state already retained by the application.
- Destination identity must not depend on an array index that changes when a
  feature-gated destination appears.

### 2.2 Destination contract

Stable IDs must exist for at least:

```text
home
lists
purchase
catalogue
history
analytics
household
guide
documentation
settings
audit
closure
```

Current ordinary labels:

- `Catalogue`, not `Products`;
- `Analytics`, not `Analytics (PIN)`;
- `Settings`;
- `Audit`;
- `Closure` only while its existing feature gate is enabled.

Analytics remains an honest disabled/planned presentation until C11-PH02.
Audit is an honest C11-PH03 placeholder. Settings retains its current
functionality. Closure remains feature-gated, reachable when enabled, and
behaviorally unchanged. Household remains planned and secondary. Guide and
Documentation remain secondary More destinations during PH01.

Reservation must not imply that Analytics or Audit is functional, that Closure
has been migrated, or that PH03 ownership has been materialized.

### 2.3 Shared visual foundation

Expand `app/design` and shared widgets only as demanded by this unit:

- semantic colors: primary/current green, insight/accent purple, warning,
  danger, information, neutral ink, warm canvas and elevated surface;
- type roles: page title, section title, body, label, metadata and numeric
  emphasis;
- spacing, radius, border/elevation, control-height, content-width, responsive
  gutter, focus and disabled-state tokens;
- bounded page content and shared page header;
- summary/stat surface;
- responsive section/collection support;
- action/filter grouping;
- state presentation for loading, first-use empty, filtered empty, error,
  insufficient history and partial/unavailable content;
- semantic banner/status presentation whose text carries meaning without color.

Shared widgets accept presentation data and callbacks. They must not query
repositories, infer product-cycle or Sync truth, translate arbitrary raw
exceptions, or own navigation/application composition.

No new package is authorized. Prefer Flutter/Material primitives.

## 3. Home requirements

Home becomes a task-oriented overview rather than a developer roadmap.

Required:

- one page header with a concise current-purpose sentence;
- one primary `Register purchase` action navigating to Purchase;
- clear secondary routes to Lists, Catalogue and History;
- truthful local-first language based only on current accepted capability;
- green for current/primary meaning and purple for secondary explanation;
- compact one-column and medium/wide card/grid composition;
- retained `home.page` key and stable keys for the primary/secondary actions;
- layout and semantics that remain usable at 200% text scale.

Remove or rewrite stale claims that Sync is future work. Do not show provider,
queue, account, household or telemetry state without an existing projection.
Developer and roadmap material must not dominate the page.

`application/home_content.dart` may change only to supply truthful static
presentation copy/descriptors. It must not gain repository, telemetry or
provider behavior.

## 4. Lists requirements

Preserve the existing account-scoped
`ProductListProjectionRepository.productListProjection` query and the four
views:

```text
Storage
Shortage
Market
All
```

Do not rename `Market` in this unit.

Required composition:

- page header and qualified explanation that Lists are estimates;
- responsive view selector;
- immediate search over currently available Product code, name and brand;
- deterministic presentation sort options using only fields already present;
- summary surfaces derived from the current returned projection;
- qualified approximate total when present;
- wide desktop comparison table;
- compact/appropriate-medium Product cards;
- one shared record identity and selection/detail meaning across projections;
- readable first-use empty, filtered empty, loading, error/retry and
  Product-level insufficient-history states;
- a safe Retry that repeats only the Lists read;
- stable existing keys where present and additional stable keys for new states,
  filters, summaries, rows/cards and Retry.

The wide table and compact cards must consume the same projection and
presentation classifications. They must not issue different repository queries
or calculate different cycle truth.

Do not invent categories, Store/Person filters, Product images, inventory
facts, edit/delete actions or recorded totals absent from current data.

## 5. Characterization and regression requirements

Before replacing presentation, add or retain tests that prove:

- all existing destinations remain reachable;
- conditional Closure presence does not shift the selected destination;
- compact More reaches Catalogue, Analytics, Household, Guide, Documentation,
  Settings, Audit and feature-gated Closure as applicable;
- resizing below/at/above both boundaries preserves destination identity;
- Home primary/secondary callbacks navigate correctly;
- Lists preserves its selected view across responsive recomposition;
- Lists uses one account-scoped projection per refresh/view request;
- search/sort operate only on the returned presentation collection;
- loading, first-use empty, filtered empty, error/retry, insufficient-history
  and data states are distinguishable;
- long names and 200% text scaling produce no overflow at representative
  compact, medium and wide sizes;
- icon-only controls have accessible names/tooltips;
- focus order and semantics separate navigation, filtering and content;
- existing Purchase, Catalogue, History, Settings and Closure behaviors are not
  changed by the shell.

Keep existing widget keys used by current regressions unless an exact duplicate
key defect requires a documented correction.

## 6. Writable scope

Handwritten implementation:

```text
clients/markei_flutter/lib/application/home_content.dart
clients/markei_flutter/lib/app/markei_app.dart
clients/markei_flutter/lib/app/design/markei_theme.dart
clients/markei_flutter/lib/app/widgets/markei_components.dart
clients/markei_flutter/lib/app/pages/home_page.dart
clients/markei_flutter/lib/app/pages/lists_page.dart
```

Codex may create these presentation-only files when they keep the above owners
smaller and explicit:

```text
clients/markei_flutter/lib/app/navigation/markei_destination.dart
clients/markei_flutter/lib/app/widgets/markei_shell.dart
```

Tests:

```text
clients/markei_flutter/test/app/markei_app_test.dart
clients/markei_flutter/test/app/markei_visual_foundation_test.dart
clients/markei_flutter/test/app/lists_page_test.dart
clients/markei_flutter/test/application/lists_and_export_test.dart
```

The three new named test files may be created only when useful. Existing
relevant test helpers may be adjusted inside the named files.

Codex reports to replace:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Stop if another handwritten source path is materially required. Report the
dependency to Main instead of silently expanding scope.

## 7. Prohibited scope

Do not modify:

- Catalogue, History, Purchase, Settings or Native Closure page behavior;
- application/domain/repository interfaces except the static Home descriptors
  explicitly named above;
- Analytics calculations, registry or History handoff;
- authentication, enrollment, Sync, diagnostics, recovery or provider logic;
- schema, migrations, API, contracts, generated source or platform manifests;
- `pubspec.yaml`, lockfiles or dependencies;
- reference PNGs;
- A/B/C, J, REC diagnostics, permanent domain memory, Main continuity,
  methodology, ALT_DEV, GRM or operator scripts;
- R07, GCM04 or C12 scope.

Do not execute live Sync, Retry, Recovery, Query, Enroll, provider operations,
database repair, credential inspection, installation against preserved app
data or human acceptance actions.

## 8. Validation ladder

From `clients/markei_flutter`:

1. `flutter pub get`.
2. Do not run code generation unless a generator input unexpectedly and
   legitimately changes; none is expected.
3. `dart format --output=none --set-exit-if-changed lib test`.
4. `flutter analyze`.
5. focused shell/Home/Lists tests, including the new files that exist.
6. existing `test/app/markei_app_test.dart`.
7. `flutter test`.
8. `flutter build windows --release` when the host supports Windows; otherwise
   mark host-unvalidated.
9. `flutter build apk --debug` when Android tooling is available; otherwise
   mark host-unvalidated.
10. repository-root `git diff --check`.
11. exact changed-path audit against this stage.

Do not add or rebaseline golden images in S01 because the repository does not
yet own a pinned font/locale/DPR review contract. G/H/I should recommend the
smallest later golden boundary if the new shell proves stable. Behavioral and
semantic tests plus later Windows/Android human review remain controlling.

## 9. Stop conditions

Stop and report without improvising when:

- destination identity cannot be stabilized without changing application or
  domain ownership;
- Home or Lists requires new data/query fields;
- a new dependency appears necessary;
- responsive projection changes business facts;
- hidden pages lose retained interaction state;
- Closure capability or feature gating changes;
- tests expose an existing functional defect requiring out-of-scope repair;
- generated/source drift appears;
- remote branch moved or the worktree contains unrelated changes.

## 10. Required G/H/I terminals

```text
CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S01
STAGING_BASELINE=<exact staging commit>
VISUAL_FOUNDATION=IMPLEMENTED | PARTIAL | BLOCKED
STABLE_DESTINATION_IDENTITY=PASS | FAIL | BLOCKED
COMPACT_MEDIUM_WIDE_SHELL=PASS | FAIL | BLOCKED
HOME_RECOMPOSITION=PASS | FAIL | BLOCKED
LISTS_RECOMPOSITION=PASS | FAIL | BLOCKED
ANALYTICS_RESERVATION=PASS | FAIL
SETTINGS_PRESERVED=PASS | FAIL
AUDIT_RESERVATION=PASS | FAIL
CLOSURE_BEHAVIOR_CHANGED=NO | YES
BUSINESS_OR_SYNC_SOURCE_CHANGED=NO | YES
FOCUSED_TESTS=<result>
FLUTTER_TEST=<result>
FLUTTER_ANALYZE=<result>
WINDOWS_BUILD=<result or HOST_UNVALIDATED>
ANDROID_BUILD=<result or HOST_UNVALIDATED>
HUMAN_WINDOWS_ACCEPTANCE=NOT_PERFORMED
HUMAN_ANDROID_ACCEPTANCE=NOT_PERFORMED
PROVIDER_MUTATION=NONE
NEXT_MAIN_ACTION=<one exact action>
```

## 11. Publication

If the implementation and available validations succeed:

- commit only the authorized implementation, tests and G/H/I paths;
- make the implementation commit a direct child of the staging commit;
- push by non-forced fast-forward to
  `grm-guarded-provisioning-20260727`;
- do not create another branch or pull request;
- verify the remote branch equals the implementation commit.
