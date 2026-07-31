# D_OPS_STAGE — C11-PH01-S02 Five-Page Visual Convergence

> Sequence: FLX-ORD-01
> Role: Main operational materialization stage
> Cycle / phase / unit: C11 / C11-PH01 / C11-PH01-S02
> Repository: `gus-i-gu/markei`
> Required branch: `grm-guarded-provisioning-20260727`
> Required ancestor: `1c7df53c095f4e7c1d85f278ba16c21fd95b25e6`
> Reconciled Main head: `ec8953fbea4e9a80a712118665c2549a4d21528b`
> Codex starting HEAD: the direct descendant commit publishing this synchronized
> D/E/F packet, pinned by the initiation prompt
> Authority: **ACTIVE — CODEX IMPLEMENTATION AND NON-FORCED PUBLICATION AUTHORIZED**
> Provider mutation authority: none

## 1. Mission

Materialize one bounded C11-PH01 correction that makes all five current product
pages read as one compact, calm and responsive information workspace:

```text
Home
Lists
Catalogue
History
Purchase
```

S01 established stable destination identity, compact/medium/wide shell classes,
semantic tokens, shared components and first Home/Lists recompositions. S02
must retain that architecture, correct the remaining S01 visual mismatch and
apply the same visual grammar to Catalogue, History and Purchase.

This is a presentation-convergence unit. It must preserve current product,
Purchase, History, Catalogue, Lists, Settings, Closure, Sync and diagnostic
behavior.

## 2. Initial guard

Before editing:

1. explicitly target `grm-guarded-provisioning-20260727`;
2. resolve and report the exact remote HEAD;
3. verify `ec8953fbea4e9a80a712118665c2549a4d21528b` is an ancestor;
4. verify `1c7df53c095f4e7c1d85f278ba16c21fd95b25e6` is an ancestor;
5. verify the staging commit is the remote HEAD named by the initiation prompt;
6. inspect the complete staging-commit diff and accept only D/E/F changes;
7. inspect existing worktree changes before any mutation;
8. stop on divergence, unrelated work, substituted default-branch content,
   unclear ancestry or a staging packet that differs from this unit.

Do not recover application truth from `main`, an older branch, screenshots
alone or conversation paraphrase.

## 3. Controlling inputs and precedence

Read in order:

1. `AGENTS.md`
2. `documentation/sketch_notebook/INDEX.md`
3. `documentation/sketch_notebook/methodology/PROMPT_COLLECTION.md`
4. invoke `PRI-CODEX` and run `PMC-01`
5. `documentation/sketch_notebook/00_PROJECT_STATE.md`
6. `documentation/sketch_notebook/06_SESSION_SCHEME.md`
7. this D file
8. `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
9. `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`
10. the five target PNGs in section 4
11. the current S01 shell/theme/components and all five page sources
12. the focused tests named in section 14

When sources disagree, use this precedence:

```text
current domain/application behavior and data authority
↓
synchronized D/E/F requirements and exclusions
↓
target-image composition, density and hierarchy
↓
current incidental styling
```

The target images do not override repository truth. Unsupported target-image
facts and actions must be omitted or represented with an honest existing
equivalent.

## 4. Required visual references

Codex must open and inspect all five images with an image-viewing tool before
editing:

```text
documentation/sketch_notebook/DEV_STAGE/references/c09_s02/01_lists_target.png
documentation/sketch_notebook/DEV_STAGE/references/c09_s02/02_catalogue_target.png
documentation/sketch_notebook/DEV_STAGE/references/c09_s02/03_home_target.png
documentation/sketch_notebook/DEV_STAGE/references/c09_s02/04_purchase_target.png
documentation/sketch_notebook/DEV_STAGE/references/c09_s02/05_history_target.png
```

Each is a `1200 × 800` composite containing wide desktop and compact mobile
intent. They are read-only compositional targets.

For each page, report before implementation:

- wide-region structure;
- compact-region structure;
- visible hierarchy;
- repeated spacing rhythm;
- surface grouping;
- control density;
- table-to-card transformation;
- reference features omitted because current data or behavior does not support
  them.

## 5. Shared visual target

### 5.1 Typography

Use the platform UI sans stack already available to Flutter. Do not add a
package, download a font at runtime or modify `pubspec.yaml`.

Required type roles:

| Role | Size / line height | Weight | Use |
| --- | --- | --- | --- |
| Page title | `26 / 32` | `700` | one page noun |
| Section title | `16 / 22` | `600` | bounded section |
| Body | `14 / 20` | `400` | ordinary explanation |
| Control/table label | `12–13 / 16` | `500–600` | labels and headers |
| Metadata | `11–12 / 16` | `400` | provenance and secondary facts |
| Summary number | `22–24 / 28` | `700` | compact numeric emphasis |

Correct S01’s overly heavy `800` title/numeric weights. Avoid isolated
page-local `TextStyle(fontSize: ...)` literals when a semantic role applies.

### 5.2 Palette

Converge the theme toward:

```text
canvas / warm neutral       #FCFBFA
primary surface             #FFFFFF
secondary surface           #F7F6F3
primary forest green        #105028
primary soft tint           #E7F0E9
selected-navigation neutral #E8E9E6
ink                         #1E2622
muted ink                   #66706A
outline                     #DFE2DD
insight purple              #6554B2
insight soft tint           #F0ECF8
warning orange              #C96816
warning soft tint           #FBF1E7
danger red                  #B43A32
danger soft tint            #FAECEB
information blue            #3F6F8F
```

Exact nearby values may be adjusted for Material state generation and WCAG
contrast, but the result must be visually neutral, light and forest-green—not
cream-heavy or teal-heavy.

Use color only semantically:

- green: current, selected, confirmed and primary action;
- purple: secondary explanation, comparison or future-context handoff;
- orange: qualified warning;
- red: failure or destructive action;
- neutral: structure.

Text and icons must carry meaning without color.

### 5.3 Geometry and density

Use one `4 dp` sub-grid and `8 dp` base rhythm:

```text
spacing scale          4, 8, 12, 16, 24, 32
compact gutter         16
medium gutter          24
wide gutter            32
wide content maximum   1200–1240
extended navigation    224–240
visible control height 40
minimum touch target   48
surface radius         8
surface border         1
desktop table header   40–44
desktop table row      44–48
mobile record card     content-driven; target 152–168 where facts require it
```

Cards must use thin neutral borders and no visible decorative shadow. Do not
wrap every text group in another card. One bordered surface should correspond
to one meaningful group.

### 5.4 Page anatomy

Every page follows the same semantic order, omitting inapplicable zones:

1. page noun, concise purpose and optional provenance;
2. view/context selector;
3. search/filter/sort or purchase-context controls;
4. summary or current-draft band;
5. contextual selection/action band;
6. primary table, cards, form or review content;
7. disclosure, explanation or safe recovery.

Wide pages must feel like one uninterrupted workspace. Compact pages must
recompose the same state into stacked controls and record cards; they must not
be scaled-down desktop tables.

## 6. Shell and navigation correction

Retain:

- compact `< 600`;
- medium `600–1023`;
- wide `>= 1024`;
- stable `MarkeiDestinationId`;
- compact direct destinations Home, Lists, Purchase and History plus More;
- medium compact rail;
- wide labelled/extended rail;
- state preservation across resizing;
- Analytics, Household and Audit reservations;
- current Settings behavior;
- feature-gated Closure behavior.

Correct:

- wide navigation width to the `224–240 dp` target range;
- wide selected destination to a quiet neutral rounded row with forest-green
  icon/text;
- excessive cream ground and oversized navigation padding;
- compact app bar so it is page-aware and visually quiet;
- inconsistent page gutters and unbounded content widths;
- bottom navigation density while retaining `48 dp` minimum hit targets.

Do not change destination availability, routing, feature gates or page
construction ownership merely for appearance.

## 7. Home — scoped priority

### Priority

Use Home to prove the corrected typography, palette, card density and shell
without adding any data source.

### Wide composition

- branded/welcome header with concise current-purpose copy;
- one clear `Register purchase` primary action;
- compact two-column current-capability cards;
- one wide local-first/how-it-works surface;
- low-emphasis support/developer information only when already truthful;
- no giant roadmap or empty decorative area.

### Compact composition

- compact page-aware header;
- one-column ordered task cards;
- `Register purchase` remains the dominant first action;
- secondary routes remain `View lists`, `Browse catalogue` and
  `Open purchase history`;
- card text remains short enough to scan without truncation.

### Preserve and exclude

Preserve the S01 navigation callbacks and truthful local-first wording.
Do not copy target claims about scheduled updates, household collaboration,
richer Analytics, optional synchronization, release telemetry or a GitHub
project when current source does not establish them.

## 8. Lists — scoped priority

### Priority

Lists is the visual fidelity anchor. Correct S01’s fragmented summary cards,
large independent blocks and remaining cream-heavy appearance.

### Wide composition

1. page header with estimate qualification and update provenance;
2. compact Storage / Shortage / Market / All selector;
3. search and current deterministic sort controls;
4. one unified horizontal summary strip divided into:
   - in storage;
   - ending soon;
   - market;
   - approximate next-purchase total;
5. dense comparison table using the current projection only;
6. collapsible `How these lists work` explanation.

Do not render the desktop summary as four independent wrapping cards.

### Compact composition

1. page-aware app bar;
2. single view selector;
3. three equal status summary tiles in one row when width permits;
4. approximate-total card on its own row;
5. stacked Product cards with consistent fact order;
6. short detail disclosure and qualified states.

### Data boundary

Preserve:

- one account-scoped `productListProjection` request per view/refresh;
- Storage / Shortage / Market / All;
- search over current code/name/brand;
- presentation-only sort;
- same projection and classifications for table/cards;
- loading, first-use empty, filtered empty, error/read Retry and
  insufficient-history states.

Do not add category, Store, Person filters, Product photographs, inventory
facts, recorded totals, edit/delete actions or Analytics movement.

A neutral Product glyph/initial may occupy the target image slot only when it
is clearly decorative and carries no new Product fact.

## 9. Catalogue — scoped priority

### Priority

Catalogue must become a dense Product workspace while retaining all current
Store creation, Product creation, similarity and stable-identity behavior.

### Wide composition

1. page header and immediate Product search;
2. compact presentation-only A–Z / Z–A sort;
3. dense Product table/list using only:
   - Product code;
   - Product / Brand;
   - packaged/bulk mode;
   - package quantity/unit when present;
   - measurement kind;
   - details action;
4. selected/detail presentation without changing Product identity;
5. lower responsive workspace:
   - `Register product`;
   - `Similar product found` / similarity resolution;
6. Stores remain available in a compact subordinate management surface rather
   than dominating the Product catalogue.

### Compact composition

- sticky-looking visual hierarchy without `position: fixed`;
- search first, then sort/view controls;
- compact Product cards from the same Product collection;
- `Register product` and `Stores` as clear progressive disclosures or
  full-width sections;
- similarity warnings appear adjacent to the registration decision.

### Data boundary

Allowed presentation-local behavior:

- current search;
- deterministic A–Z/Z–A sort;
- selection/detail;
- existing create Product/create anyway/use existing flows;
- existing Store list/create flow.

Do not add categories, Store filtering of Products, latest-purchase facts,
latest-price facts, price-change facts, Product images, network lookup,
edit/delete or a new repository query.

## 10. History — scoped priority

### Priority

History must make selection, exports and detail hierarchy legible on both wide
and compact layouts without changing export or Purchase-history authority.

### Wide composition

1. page header;
2. compact presentation filter band when values can be derived solely from the
   already returned `PurchaseHistoryEntry` collection:
   - Store;
   - date/day;
   - Person;
   - Payment method;
3. selection/action band;
4. dense purchase rows;
5. selected Purchase detail inline or in a bounded adjacent pane;
6. explicit loading, empty, filtered-empty and error/read-Retry surfaces.

Presentation filters must default to All and must not issue new repository
queries. A filter whose value cannot be derived from existing entries must be
omitted.

### Compact composition

- stacked filter controls;
- selected-count/action row;
- selectable expandable Purchase cards;
- summary facts ordered Store → date/time → item count → total;
- detail expansion from the same selected Purchase identity;
- export/share actions remain reachable without covering content.

### Behavior boundary

Preserve CSV export, PDF share, select-all, clear-selection, detail loading,
price-change detail and safe History read Retry.

`Move to Analytics`, Edit and Delete may remain visibly unavailable only when
their disabled state is already meaningful and labelled. Do not implement
Analytics handoff, edit or delete.

## 11. Purchase — scoped priority

### Priority

Purchase has the highest regression risk. Recompose its current edit/review
workflow without changing validation, Product identity, local references,
draft preservation or registration semantics.

### Wide edit composition

1. `New purchase` header;
2. compact context band:
   - Store;
   - Purchase date;
   - time;
   - optional Person and Payment method in a subordinate disclosure;
3. `Find product` band with code and existing Product selection/search
   mechanisms;
4. staged-item editor grouped by:
   - Product identity;
   - package/measurement facts;
   - quantity;
   - price;
   - notes/current feedback when present;
5. classified feedback stack directly after the control that caused it;
6. dense staged-items table;
7. staged total and one clear `Review purchase` action.

### Compact edit/review composition

- preserve current draft in an explicit edit → review sequence;
- edit uses stacked context, Product, quantity/price and staged-item cards;
- review presents read-only Store/date/time, optional references, item rows,
  total, `Register purchase` and `Back to edit`;
- primary action remains reachable in normal document flow;
- do not use a persistent overlay that hides fields or keyboard content.

### Behavior boundary

Preserve all existing widget keys and:

- Store requirement/invalidation;
- date/time parsing;
- existing Product selection and immutable identity;
- new Product and similarity flows;
- packaged/bulk calculations;
- item add/edit/remove;
- review gate;
- known-success/known-failure/unknown registration handling;
- draft preservation and History-before-retry guidance;
- optional Person/Payment references;
- registration callback and refresh behavior.

Do not add a new Store-in-Purchase workflow, payment/person mutation,
barcode/camera access, Product network search, destructive bulk clear unless it
already exists, or any repository/domain change.

Correct the stale S01 text claiming synchronization is not active. Replace it
with bounded local-first wording that does not expose or infer Sync state.

## 12. State, interaction and accessibility requirements

Across every page:

- preserve page-local selection, search, sort, filters, draft and disclosure
  state across compact/medium/wide resizing;
- preserve `IndexedStack` page state across navigation;
- use one record identity across table and card projections;
- provide loading, first-use empty, filtered empty, error/retry and partial or
  unavailable states where the page can encounter them;
- retry only the named read operation;
- never label a page-read Retry as Sync, Recovery or unknown-outcome Retry;
- use at least `48 dp` interactive hit areas even where the visible control is
  `40 dp`;
- support 200% text scaling without clipped text or horizontal page overflow;
- supply tooltip/semantic labels for icon-only controls;
- preserve visible keyboard focus and logical tab order;
- do not use color as the only state distinction;
- avoid nested vertical scrollables that make compact pages unusable.

## 13. Characterization before replacement

Before large page edits, add or retain tests proving:

- all destinations and More routes remain reachable;
- feature-gated Closure does not shift selected destination;
- destination and page state survive both breakpoint transitions;
- Home callbacks navigate to the same destinations;
- Lists request count, selected view, classification, search/sort and read Retry
  remain correct;
- Catalogue Product/Store create, search, similarity, stable Product selection
  and detail remain correct;
- History selection, select-all/clear, detail, CSV/PDF and read Retry remain
  correct;
- Purchase Store/date/time/Product/quantity/price/draft/edit/review/register
  flows and unknown-result guidance remain correct;
- long names, empty data and 200% text scale do not overflow representative
  compact, medium and wide surfaces.

Do not delete behavioral assertions to make the redesign pass. When an existing
test encodes incidental layout, update only that incidental assertion and
retain its behavioral meaning.

## 14. Writable scope

Handwritten application/presentation files:

```text
clients/markei_flutter/lib/application/home_content.dart
clients/markei_flutter/lib/app/markei_app.dart
clients/markei_flutter/lib/app/design/markei_theme.dart
clients/markei_flutter/lib/app/navigation/markei_destination.dart
clients/markei_flutter/lib/app/widgets/markei_shell.dart
clients/markei_flutter/lib/app/widgets/markei_components.dart
clients/markei_flutter/lib/app/pages/home_page.dart
clients/markei_flutter/lib/app/pages/lists_page.dart
clients/markei_flutter/lib/app/pages/products_page.dart
clients/markei_flutter/lib/app/pages/history_page.dart
clients/markei_flutter/lib/app/pages/purchase_page.dart
```

Codex may create only these optional presentation-only component files when
they materially reduce duplication:

```text
clients/markei_flutter/lib/app/widgets/markei_data_components.dart
clients/markei_flutter/lib/app/widgets/markei_form_components.dart
```

Tests:

```text
clients/markei_flutter/test/app/markei_app_test.dart
clients/markei_flutter/test/app/markei_visual_foundation_test.dart
clients/markei_flutter/test/app/lists_page_test.dart
clients/markei_flutter/test/application/lists_and_export_test.dart
clients/markei_flutter/test/application/purchase_contracts_test.dart
```

Codex may create:

```text
clients/markei_flutter/test/app/markei_five_page_visual_convergence_test.dart
```

Reports to replace:

```text
documentation/sketch_notebook/DEV_STAGE/G_OPS_CODEX.md
documentation/sketch_notebook/DEV_STAGE/H_DDC_CODEX.md
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Stop if another handwritten source or test path is materially required.

## 15. Prohibited scope

Do not modify:

- application ports or repository interfaces;
- domain entities or business calculations;
- infrastructure, database, migrations, API, contracts or generated source;
- Native Closure, Settings or diagnostic behavior;
- Analytics registry/calculations or any Analytics handoff;
- authentication, enrollment, Sync, Retry, Recovery or provider logic;
- `pubspec.yaml`, lockfiles, platform manifests or dependencies;
- the five reference PNGs;
- A/B/C, J, REC, permanent domain memory, Main-root continuity, methodology,
  ALT_DEV, GRM or operator scripts;
- R07, GCM04 or C12 scope.

Do not execute live Sync, unknown-outcome Retry, Recovery, Query, Enroll,
provider operations, database repair, credential inspection, installation
against preserved app data or human acceptance actions.

## 16. Validation ladder

From `clients/markei_flutter`:

1. `flutter pub get`
2. do not run code generation unless an already-authorized generator input
   legitimately changes; none is expected
3. `dart format --output=none --set-exit-if-changed lib test`
4. `flutter analyze`
5. focused S01 shell/Home/Lists regressions
6. focused Catalogue/History/Purchase regressions
7. `flutter test test/app/markei_five_page_visual_convergence_test.dart` when
   created
8. `flutter test`
9. `flutter build windows --release` when supported, else `HOST_UNVALIDATED`
10. `flutter build apk --debug` when supported, else `HOST_UNVALIDATED`
11. repository-root `git diff --check`
12. exact changed-path audit

Visual inspection when the host can render Flutter:

```text
wide    1440 × 900 at 100% text scale
medium  900 × 900 at 100% text scale
compact 390 × 844 at 100% and 200% text scale
```

Inspect all five pages at wide and compact. Medium must be inspected for shell,
table/card policy and overflow. If rendering or screenshot capture is not
available, report `HOST_UNVALIDATED`; do not claim pixel parity.

Do not introduce a committed golden baseline in S02 unless the environment
already supplies a deterministic font/locale/DPR contract. None is currently
established.

## 17. Stop conditions

Stop and report without improvisation when:

- a target composition requires a new repository field or query;
- a new package, font download or platform permission appears necessary;
- responsive projection changes a business fact;
- destination or page state cannot be retained;
- Closure, Settings, Analytics, Sync or diagnostic behavior would change;
- existing user changes overlap authorized files and cannot be preserved;
- generated/source drift appears;
- a functional defect requires out-of-scope repair;
- the remote branch moves after staging verification;
- D/E/F conflict.

Partial page completion is not a successful S02 terminal. If one page blocks,
preserve passing work only when it forms a coherent reversible subset and
report `FIVE_PAGE_CONVERGENCE=PARTIAL`.

## 18. Required G/H/I terminals

```text
CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S02
STAGING_BASELINE=<exact staging commit>
SHARED_VISUAL_GRAMMAR=PASS | PARTIAL | FAIL | BLOCKED
SHELL_DENSITY_AND_HIERARCHY=PASS | PARTIAL | FAIL | BLOCKED
HOME_CONVERGENCE=PASS | PARTIAL | FAIL | BLOCKED
LISTS_CONVERGENCE=PASS | PARTIAL | FAIL | BLOCKED
CATALOGUE_CONVERGENCE=PASS | PARTIAL | FAIL | BLOCKED
HISTORY_CONVERGENCE=PASS | PARTIAL | FAIL | BLOCKED
PURCHASE_CONVERGENCE=PASS | PARTIAL | FAIL | BLOCKED
FIVE_PAGE_CONVERGENCE=PASS | PARTIAL | FAIL | BLOCKED
TABLE_CARD_FACT_PARITY=PASS | FAIL | BLOCKED
RESPONSIVE_STATE_PRESERVATION=PASS | FAIL | BLOCKED
UNSUPPORTED_REFERENCE_FEATURES_ADDED=NO | YES
PRODUCT_IMAGE_AUTHORITY_ADDED=NO | YES
ANALYTICS_BEHAVIOR_CHANGED=NO | YES
SETTINGS_BEHAVIOR_CHANGED=NO | YES
AUDIT_BEHAVIOR_ADDED=NO | YES
CLOSURE_BEHAVIOR_CHANGED=NO | YES
BUSINESS_OR_SYNC_SOURCE_CHANGED=NO | YES
FOCUSED_TESTS=<result>
FLUTTER_TEST=<result>
FLUTTER_ANALYZE=<result>
WINDOWS_BUILD=<result or HOST_UNVALIDATED>
ANDROID_BUILD=<result or HOST_UNVALIDATED>
WIDE_VISUAL_REVIEW=<result or HOST_UNVALIDATED>
MEDIUM_VISUAL_REVIEW=<result or HOST_UNVALIDATED>
COMPACT_VISUAL_REVIEW=<result or HOST_UNVALIDATED>
HUMAN_WINDOWS_ACCEPTANCE=NOT_PERFORMED
HUMAN_ANDROID_ACCEPTANCE=NOT_PERFORMED
PROVIDER_MUTATION=NONE
NEXT_MAIN_ACTION=<one exact action>
```

G must contain the exact commands, results, changed-file inventory, preserved
behavior evidence, host limits and publication status.

## 19. Publication

If implementation and available validation succeed:

- commit only authorized source, tests and replacement G/H/I;
- make the implementation commit a direct child of the synchronized staging
  commit;
- push by non-forced fast-forward to
  `grm-guarded-provisioning-20260727`;
- do not create another branch or pull request;
- verify remote HEAD equals the implementation commit.

Commit message:

```text
Converge C11 PH01 five-page visual system
```
