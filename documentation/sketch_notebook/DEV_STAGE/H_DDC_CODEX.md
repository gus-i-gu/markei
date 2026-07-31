# H_DDC_CODEX — C11-PH01-S01 Meaning Evidence

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

## Wording And Labels

- Navigation now uses ordinary labels: `Home`, `Lists`, `Purchase`, `Catalogue`, `History`, `Analytics`, `Household`, `Guide`, `Documentation`, `Settings`, `Audit`, `Closure`.
- Removed user-facing `Analytics (PIN)` and `Household (PIN)` maturity wording.
- Home now names the current purpose: register purchases locally first and inspect reusable Products, estimates and history.
- Home primary action is `Register purchase`.
- Home secondary actions are `View lists`, `Browse catalogue` and `Open purchase history`.
- Removed stale Home claim that Sync is future work.
- Documentation copy no longer foregrounds Synchronization/public distribution as user task truth.
- Analytics copy says it is planned for C11-PH02 and does not imply active calculations or telemetry.
- Audit copy says it is planned for C11-PH03 and does not imply diagnostic migration.
- Lists copy qualifies projections as estimates derived from registered Purchase history.

## State Distinctions

Lists distinguishes:

- loading: `lists.loading`, names estimated Product lists;
- read error: `lists.error`, states local data was not changed and offers `lists.retry`;
- first-use/projection empty: `lists.empty.firstUse`;
- filtered empty: `lists.filteredEmpty` with `lists.clearSearch`;
- Product-level insufficient history: `lists.insufficientHistory.<productId>`;
- data state: shared summary plus wide table or compact cards.

Lists visible wording uses `Estimate`, `Approximate`, `Unavailable`, `Not enough history` and `Expected ended` to avoid recorded-inventory or recorded-total claims.

## Accessibility Evidence And Limits

Automated/widget evidence added:

- exact breakpoint tests for 599, 600, 1023 and 1024 logical pixels;
- 200 percent text-scale Home render check with no Flutter overflow/exception;
- compact More reachability for secondary destinations and feature-gated Closure;
- responsive selected-destination preservation across compact, medium and wide boundaries;
- Lists wide table and compact cards consume the same returned projection/search/sort state;
- icon-only medium rail destinations have tooltips through `MarkeiShell`.

Limits:

- Windows Narrator, Android TalkBack, keyboard-only manual traversal and real-device visual review were not performed.
- PNG references were inspected as composition references only; no pixel parity claim is made.

## Evidence Boundaries

Codex evidence supports implemented, test-validated and build-validated for S01 presentation scope only. It does not prove PH01 completion, Analytics calculations, Settings/Audit redesign, Closure migration, production readiness, provider acceptance, live Sync success or human platform acceptance.

## Commands And Results

- `flutter analyze`: pass, `No issues found!`.
- `flutter test test/app/markei_visual_foundation_test.dart test/app/lists_page_test.dart`: pass, `All tests passed!`.
- `flutter test test/app/markei_app_test.dart`: pass, `All tests passed!`.
- `flutter test`: pass, `All tests passed!`.
- `flutter build windows --release`: pass, built Windows executable.
- `flutter build apk --debug`: pass, built Android Debug APK.

Artifact evidence:

- Windows executable SHA-256: `23C0A337594ECC51437FD6F950F1F8BEC04C40DE7737130DFBFB5EF62EAA3523`.
- Android APK SHA-256: `B55E0FB4AAB70F5C08AC2E4826D7930AC79204B5F9B7F1BA45C3AD897F604983`.

## Requested But Not Implemented

- Analytics calculations remain deferred to C11-PH02.
- Settings/Audit redesign remains deferred to C11-PH03.
- Closure behavior and page implementation remain unchanged.
- Catalogue, History and Purchase recomposition remain later PH01 work.
- No golden boundary was introduced; smallest later recommendation is one shell/Home/Lists golden set at compact 390px, medium 600px and wide 1200px after font/locale/DPR policy is approved.
