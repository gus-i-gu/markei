# A_OPERATIONAL.md

> Cycle: C11
> Phase: C11-PH01
> Role: Operational Chat [O]
> Status: COMPLETE OPERATIONAL INVESTIGATION — A/B/C INPUT ONLY
> Repository: `gus-i-gu/markei`
> Branch: `grm-guarded-provisioning-20260727`
> Required baseline: `861c27fdaf6ade2093d481af312d27ff895b8dc0`
> Publication base: documented descendant of `861c27f` containing only the parallel C11-PH01 Design report
> Date: 2026-07-30
> Writable scope: this file only

---

<!-- RECONCILIATION_MARKER:C11-PH01-O-2026-07-30 -->

# C11-PH01 — Visual System and Core-Page Convergence

## 1. Recovered state and evidence boundary

The selected GitHub connector explicitly resolved
`grm-guarded-provisioning-20260727`. Initial preflight reported the branch
identical to `861c27fdaf6ade2093d481af312d27ff895b8dc0`
(`ahead=0`, `behind=0`, merge base `861c27f`). Before publication the
branch advanced by one documented descendant changing only
`DEV_STAGE/C_DESIGN.md`; it remains `behind=0` with merge base
`861c27f`. That descendant is preserved. No default/older branch was used.

The required route was followed through `AGENTS.md`, `INDEX.md`,
`PROMPT_COLLECTION.md`, PRI-O and PMC-01, then the named Main, Operational,
J, ALT_DEV section 15 and staging surfaces. Cycle 10 is closed at its
two-Device development boundary. PH01 owns the shared visual system and five
core-page redesigns; PH02 owns local Analytics; PH03 owns Settings, Audit and
Closure disposition. GCM04, multi-user assays and backend resilience remain
in C12-PHASE02.

Evidence classification:

| Class | Boundary |
| --- | --- |
| Existing and verified | Source plus named carried automated/build evidence |
| Source-represented, host-unvalidated | Readable implementation not executed in this connector-only investigation |
| Visual-reference expectation | Product composition shown by the five archived PNGs; not pixel/data authority |
| Implementation gap | PH01 proof or behavior absent/not evidenced |
| Human acceptance | Requires actual Windows/Android rendering and interaction |

No Flutter, Windows, Android, emulator, device, screen-reader or golden command
was run here. Prior green evidence remains bounded to its recorded commit/host.

## 2. Present implementation inventory

### Shell, composition and theme

`markei_app.dart` uses an adaptive shell: wide layout has a labelled,
scrollable `NavigationRail`; compact layout has Home, Lists, Purchase,
History and More in a `NavigationBar`, with remaining destinations in a
modal sheet. Pages are retained in an `IndexedStack`. Present destinations
include the five pages, planned Analytics/Household, Guide, Documentation,
Settings and conditional Closure. PH01 must not activate or dispose PH02/PH03.

`markei_composition.dart` injects local application repositories and identity.
UI changes must continue through these ports and must not reconstruct database,
provider, authentication, enrollment or Sync truth.

`markei_theme.dart` provides Material 3, cream/surface/green/lavender colors,
eight-pixel cards, filled outlined inputs and rail styling.
`markei_components.dart` contains only `MarkeiCard`,
`MarkeiStatePanel` and `MarkeiStatusChip`. Shared responsive page shells,
headers, action areas, collection/detail patterns, state panels, density,
typography, focus and accessibility contracts are not yet represented.

### Five pages

| Page | Present implementation |
| --- | --- |
| Home | 24-line stateless list; reachable but materially below the target dashboard |
| Lists | async Storage/Shortage/Market/All projection; loading/error/empty, approximate total and Product-cycle rows in one linear list |
| Purchase | 1,217-line stateful monolith: Catalogue load, exact-code lookup, similarity handling, new/existing Product staging, packaged/bulk calculation, Person/Payment/Store, manual date/time, edit/remove, review/register and feedback |
| Catalogue | 440 lines: Store list/create, search, Product create, similarity override, selection/detail and retry/error/empty states |
| History | 331 lines: history/detail/price views, multi-selection, CSV export, PDF share; Analytics/Edit/Delete disabled; tap-based row interaction |

The five reference artifacts were inspected as one coherent visual family:
cream/green/lavender surfaces, stronger headings, rounded groups, denser desktop
information, filters/segments and clear primary actions. Operationally they
demand wide comparison plus compact scanability. They do not establish
breakpoints, focus order, semantics, text scaling, loading/error states or
availability of mock-up data.

## 3. Feature-preservation matrix

| Page | Functions that must survive | PH01 regression gate |
| --- | --- | --- |
| Home | reachability, local-only truth, refresh after Purchase changes | compact/wide reachability; no unsupported live/Analytics claim |
| Lists | four views, refresh, loading/error/empty, approximate total, Product-cycle facts | same projection/result identity across widths; no clipping/lost state |
| Purchase | code lookup/autofill, similarity override, staging, packaged/bulk values, derived total, optional Person/Payment, Store, occurrence time, edit/remove, review/register, typed feedback | preserve keys and invariants; draft survives resize/navigation; single register; focus/scroll to error; no implicit Product/Item creation |
| Catalogue | Store list/create, Product search/create, immutable facts, similarity, selection/detail, retry | preserve identity rules; pointer/keyboard/touch access; no edit/delete implication |
| History | load/retry/empty, selection, detail/price, select-all/clear, CSV/PDF | selected IDs and deterministic artifacts preserved; no gesture-triggered export; disabled future actions stay disabled |

Global invariants: Account/local scope; immutable registered Purchase facts;
Product identity; fixed-point money/quantity; manual occurrence time;
deterministic selected export; no automatic Retry/Recovery or provider mutation.

## 4. Desktop/mobile execution constraints

The exact current shell breakpoint must be recorded from source and tested
immediately below, at and above it. Required representative logical sizes:

| Class | Cases |
| --- | --- |
| narrow phone | 320×568, 360×800 portrait |
| ordinary phone | 412×915 portrait and landscape |
| intermediate | 600×800 plus both sides of the shell threshold |
| desktop | 1024×768, 1366×768, 1920×1080 |
| stress | critical widths with long content and 200% text scaling where supported |

Windows requires resize, pointer/hover, wheel, keyboard traversal,
Enter/Space/Escape, visible focus, display scaling, long labels and native
export/share verification. Android requires touch targets, system insets,
keyboard avoidance, Back, rotation/recreation, background/foreground and
scroll-to-error. Build success is not device or human acceptance.

`IndexedStack` preserves state but can retain hidden focus/semantics and
increase build/memory cost. This must be tested; Design owns the final choice.

## 5. Automated coverage and gaps

Carried Cycle 10 evidence records a green Flutter suite (latest ledger: 178
tests with four lab-gated skips) and successful Windows release and Android
debug builds at their named boundaries. Existing widget keys provide useful
anchors. That evidence does not prove PH01 visuals.

Missing or not evidenced:

- compact/wide/boundary shell widget tests;
- page tests at narrow, intermediate and wide widths;
- overflow tests with long content and maximum supported text scale;
- Windows keyboard/focus tests and semantic reading order;
- enabled/disabled semantics and touch-target checks;
- Android Back, modal, keyboard-inset and lifecycle tests;
- page state preservation on destination changes and resizing;
- deterministic compact/wide goldens for five pages and important
  loading/empty/error/data states;
- pinned golden font/locale/DPR and reviewed baseline-update procedure;
- accepted Catalogue/History double-click plus keyboard/touch equivalents;
- native export/share acceptance;
- pre-recomposition Purchase regression coverage for every critical state.

Goldens should detect drift; target PNGs must not be copied as literal goldens
or used instead of functional/semantic assertions.

## 6. Proposed validation ladder

From `clients/markei_flutter`:

1. `flutter pub get`.
2. Run `dart run build_runner build --delete-conflicting-outputs` only when
   generator inputs change; fail on unexpected generated drift.
3. `dart format --output=none --set-exit-if-changed lib test`.
4. `flutter analyze` and repository-root `git diff --check`.
5. Focused shell and five-page widget/application regressions.
6. New breakpoint, overflow, text-scale, semantics, focus and reviewed golden tests.
7. `flutter test`, reporting every skip and decisive producer.
8. `flutter build windows --release`.
9. `flutter build apk --debug` (build evidence only).
10. Deterministic Windows and Android human acceptance.

Never hand-edit Drift `*.g.dart`, generated plugin registrants,
`.dart_tool/**`, `build/**` or platform ephemeral outputs.

## 7. Automated and human acceptance matrix

| Concern | Automated | Windows human | Android human |
| --- | --- | --- | --- |
| shell | rail/bar/More, boundary resize, retained state | resize, mouse, wheel, keyboard/focus | touch, Back, rotation, insets |
| Home | local states, overflow | hierarchy/readability | compact scanning/targets |
| Lists | four views and all state variants | dense comparison/scroll | no sideways information loss |
| Purchase | complete draft/register/validation regression | tab order, date/time, review, single submit | keyboard inset, scroll-to-error, rotation |
| Catalogue | search/create/similarity/detail | pointer + accepted keyboard/double-click | touch selection/detail |
| History | select/detail/price/export/share state | multi-select and native dialogs | touch selection/share/back |
| accessibility | semantics, focus, text scale | Narrator/high contrast/200% spot check | TalkBack/font-scale spot check |
| convergence | reviewed compact/wide goldens | compare desktop targets | responsive interpretation, not clone |
| invariants | full domain/application/persistence suite | local end-to-end workflow | same workflow plus reopen/lifecycle |

Use a sanitized deterministic fixture containing empty state, long names,
packaged/bulk Products, optional/assigned references, multiple dates, sufficient
Lists/price history and an explicit export selection.

## 8. Risks and stop conditions

| Risk | Consequence / control |
| --- | --- |
| UI crosses application boundary | stop if query/identity/money logic moves into widgets |
| Purchase monolith | add focused regressions before extraction/recomposition |
| breakpoint coupling | test below/at/above threshold before acceptance |
| retained pages | test focus, semantics, stale state and memory |
| screenshot literalism | stop on invented data/capability |
| weak shared system | stage shared foundation before five independent rewrites |
| unstable goldens | pin environment; require reviewed rebaseline |
| generated edits | edit generators/handwritten inputs only |
| inflated evidence | keep build, runtime and human proof distinct |
| scope leak | stop on PH02/PH03, schema/provider, R07 or GCM04 work |

Also stop on dirty/overlapping A changes, remote divergence, unapproved
dependency, database/migration change, provider/account/enrollment/live Sync
access, automatic recovery, Edit/Delete activation or Household behavior.

## 9. Implementation cost and recommendation to Main

Operationally safest order:

1. freeze critical keys and acceptance fixture;
2. add responsive/overflow/semantics/focus/golden harness;
3. materialize shared tokens/components and shell;
4. recompose Home and Lists;
5. recompose Catalogue and History;
6. recompose Purchase last with stronger regressions;
7. run full automated and two-platform human acceptance.

| Unit | Cost/risk |
| --- | --- |
| test/golden harness | medium, prerequisite |
| theme/components/shell | medium-high, broad blast radius |
| Home | low-medium |
| Lists | medium |
| Catalogue | medium-high |
| History | medium-high, selection/native artifacts |
| Purchase | high, large state machine |
| human platform acceptance | medium, environment-dependent |

Do not make all five pages one indivisible Codex change. PH01 can remain one
semantic phase while using bounded cumulative implementation units.

## 10. Dependencies requested from Didactic and Design

Didactic [A] should provide state/action vocabulary; progressive disclosure;
honest local-only/disabled language; Product/Purchase/Item/estimate terminology;
screen-reader labels; and wording that does not imply Analytics, Sync or
edit/delete capability.

Design [D] should provide breakpoint and responsive ownership; shared
component/dependency boundaries; desktop-table/compact-card contract; state
ownership under resize/navigation; `IndexedStack` disposition;
selection/detail/double-click/keyboard contract; safe extraction boundaries;
generated ownership; and confirmation of the PH01/PH02/PH03 boundary.

## 11. Exact files likely requiring later inspection

Handwritten implementation:

- `clients/markei_flutter/pubspec.yaml`
- `clients/markei_flutter/lib/app/markei_app.dart`
- `clients/markei_flutter/lib/app/markei_composition.dart`
- `clients/markei_flutter/lib/app/design/markei_theme.dart`
- `clients/markei_flutter/lib/app/widgets/markei_components.dart`
- `clients/markei_flutter/lib/app/pages/home_page.dart`
- `clients/markei_flutter/lib/app/pages/lists_page.dart`
- `clients/markei_flutter/lib/app/pages/purchase_page.dart`
- `clients/markei_flutter/lib/app/pages/products_page.dart`
- `clients/markei_flutter/lib/app/pages/history_page.dart`

Behavioral dependencies when affected, not for redesign:

- `clients/markei_flutter/lib/application/catalogue_queries.dart`
- `clients/markei_flutter/lib/application/product_lists.dart`
- `clients/markei_flutter/lib/application/register_purchase.dart`
- `clients/markei_flutter/lib/application/purchase_history.dart`
- `clients/markei_flutter/lib/application/history_export.dart`
- relevant `clients/markei_flutter/test/**` located by page keys and port names;
- `clients/markei_flutter/integration_test/**` if present;
- Windows/Android host manifests only for evidenced platform problems.

Generated outputs are inspected through generator/schema unless runtime drift
requires direct reading.

## 12. Unresolved questions

1. What exact breakpoint(s) and minimum logical width does Design accept?
2. Which reference elements map to existing local data versus decoration/deferment?
3. Are Catalogue/History double-click requirements Windows-only, and what are
   keyboard/touch equivalents?
4. Which page/draft/scroll state must survive destination changes and resize?
5. What maximum text scale closes PH01?
6. Which font, locale, DPR and fixture stabilize goldens?
7. Must PH01 remain SDK-first, or may Main authorize a dependency?
8. Which existing tests cover every Purchase state before recomposition?
9. Which Android API/device and Windows display scales are mandatory?
10. How are native export artifacts cleaned after human acceptance?
11. What bounded first materialization unit will Main select?
12. Which gaps belong to C12-PHASE01 polish rather than PH01 convergence?

## 13. Operational terminal

```text
CYCLE=C11
PHASE=C11-PH01
ROLE=OPERATIONAL
BASELINE_VERIFIED=YES
A_REPORT_READY=YES
SOURCE_CHANGE_AUTHORIZED=NO
D_E_F_AUTHORIZED=NO
CODEX_AUTHORIZED=NO
PROVIDER_MUTATION_AUTHORITY=NONE
NEXT_MAIN_ACTION=Reconcile C11-PH01 A_OPERATIONAL.md with B_DIDACTIC.md and C_DESIGN.md into one bounded J synthesis before drafting D/E/F.
```
