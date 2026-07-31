# I_DSN_CODEX — C11-PH01-S01 Design Evidence

## Classification

```text
CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S01
STAGING_BASELINE=1e4cd0aa8e6f0eabd856decfadba21f67d04426c
VISUAL_FOUNDATION=IMPLEMENTED
STABLE_DESTINATION_IDENTITY=PASS
COMPACT_MEDIUM_WIDE_SHELL=PASS
HOME_RECOMPOSITION=PASS
LISTS_RECOMPOSITION=PASS
ANALYTICS_RESERVATION=PASS
SETTINGS_PRESERVED=PASS
AUDIT_RESERVATION=PASS
CLOSURE_BEHAVIOR_CHANGED=NO
BUSINESS_OR_SYNC_SOURCE_CHANGED=NO
FOCUSED_TESTS=PASS
FLUTTER_TEST=PASS
FLUTTER_ANALYZE=PASS
WINDOWS_BUILD=PASS
ANDROID_BUILD=PASS
HUMAN_WINDOWS_ACCEPTANCE=NOT_PERFORMED
HUMAN_ANDROID_ACCEPTANCE=NOT_PERFORMED
PROVIDER_MUTATION=NONE
NEXT_MAIN_ACTION=human Windows and Android visual acceptance for C11-PH01-S01
```

## Component And Dependency Map

```text
Flutter / Material primitives
  -> app/design/markei_theme.dart
     semantic color, type, spacing, radius and breakpoint tokens
  -> app/widgets/markei_components.dart
     presentation-only cards, content canvas, headers, summary/state surfaces
  -> app/navigation/markei_destination.dart
     stable destination IDs and descriptors
  -> app/widgets/markei_shell.dart
     layout-class resolution, rail/bar/More navigation, content canvas
  -> app/markei_app.dart
     destination registry, IndexedStack page composition, dependency injection
  -> app/pages/home_page.dart
     static Home presentation and navigation callbacks
  -> app/pages/lists_page.dart
     Lists view state, search/sort adapter, table/cards/state presentation
  -> application/domain ports and value objects
     existing ProductListProjectionRepository, IDs, Product-cycle results
```

No shared visual component queries repositories, reads provider state, translates arbitrary exceptions, owns Sync truth or instantiates infrastructure.

## Navigation Architecture

- Selection is stored as `MarkeiDestinationId`, not an array index.
- Stable IDs exist for `home`, `lists`, `purchase`, `catalogue`, `history`, `analytics`, `household`, `guide`, `documentation`, `settings`, `audit` and `closure`.
- One destination registry feeds wide/medium rail, compact bottom bar and compact More.
- Compact direct destinations remain Home, Lists, Purchase, History and More.
- Closure remains inserted only when `nativeClosureSurfaceEnabled` is true.
- `IndexedStack` is retained with stable child keys.
- Resizing and Closure gate changes preserve the selected destination in tests.

## Responsive Policy

- `MarkeiLayoutClass.compact`: width `<600`.
- `MarkeiLayoutClass.medium`: width `>=600 && <1024`.
- `MarkeiLayoutClass.wide`: width `>=1024`.
- Compact uses a bottom navigation bar and More sheet.
- Medium uses icon rail with tooltips.
- Wide uses extended labelled rail and bounded content canvas.
- Shared content canvas provides responsive gutters and bounded width.

## Home Design

Home depends only on static descriptors from `application/home_content.dart` and navigation callbacks from `MarkeiApp`. It does not query provider, Sync, telemetry, Household, Analytics or repository state.

## Lists Design

Lists flow:

```text
selected ProductListView + refresh/retry
  -> one ProductListProjectionRepository.productListProjection request
  -> page-local presentation adapter
  -> search/sort over returned Product code/name/brand and existing facts
  -> wide DataTable or compact/medium cards
```

Both table and cards consume the same filtered/sorted item list. Search uses only returned Product code, name and brand. Sort uses remaining estimate, Product name, Product code or latest price already present in `ProductListProjectionItem`. Product-level insufficient history remains attached to the visible Product.

## Reversibility Notes

- `markei_destination.dart` and `markei_shell.dart` are presentation-only additions and can be removed with corresponding `markei_app.dart` wiring.
- Existing page APIs for Purchase, Catalogue, History, Settings and Closure were not changed.
- `ProductListProjectionRepository` interface was not changed.
- No dependency, routing framework, state-management framework or generated source was added.

## Deviations

- `MarkeiResponsiveGrid` uses natural-height wrapping instead of fixed-aspect grid tiles to preserve 200 percent text-scale usability.
- Full `flutter test` was run because D required it, even though it includes existing local Sync test files and diagnostic output. This is recorded as automated test evidence only, not live Sync acceptance.

## Validation Results

- Format check: pass.
- Analyze: pass.
- Focused shell/Home/Lists tests: pass.
- `test/app/markei_app_test.dart`: pass.
- Full `flutter test`: pass.
- Windows Release build: pass.
- Android Debug APK build: pass.
- `git diff --check`: pass with LF-to-CRLF working-copy warnings only.
- Changed-path audit: pass; all changed paths are D-authorized implementation, test or report paths.

## Residual Risks

- Human visual review is still required for the PNG-reference family on real Windows and Android candidates.
- Real screen-reader behavior is not established by widget tests.
- Catalogue, History, Purchase, Analytics, Settings and Audit recomposition remain outside this S01 implementation.
