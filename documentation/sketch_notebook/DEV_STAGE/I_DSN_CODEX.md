# C11-PH04-R01 Design Codex Evidence

Activation marker: `<!-- ACTIVATION_MARKER:C11-PH04-R01-2026-07-31 -->`

## Architecture Result

PH04 stayed inside the D section 34 Analytics allowlist. The dependency direction is:

- `AnalyticsPage` owns the one vertical page scroll, visibility, focus handoff and explicit temp-file export sink.
- `analytics_components.dart` renders typed snapshots for composer, saved-record browser, Chart/Table and Variables projections.
- `AnalyticsWorkspaceController` owns the loaded dataset, draft, validation, immutable session records, selected record, presentation choice, Variables projection/filter/sort/page/selection, History context and request count.
- `AnalyticsRegistry` remains the operation compatibility/fixed-point authority.
- `LocalAnalyticsRepository` remains one Account-scoped joined read and now carries stored Person/Payment Method reference identities already available from that read.
- Pure export builders produce CSV string and PDF bytes from the selected immutable record.

No widget imports Drift, HTTP, Auth, Sync, provider or diagnostics. The workspace imports domain/application types, registry and crypto only. The local adapter imports the database and domain/application evidence types only. No second Analytics controller, repository read path or persisted record truth was added.

## Closed Types And Transitions

The Analytics model now includes closed draft, timeframe, option, breakdown, measure, record, group key, grouped result, purchase projection, variables state and presentation types. Public snapshot and record collections are defensively copied/unmodifiable.

Record identity is a monotonic session sequence plus a canonical SHA-256-derived uppercase fingerprint prefix. Collision handling lengthens the visible prefix or disambiguates deterministically. Fingerprints are display references, not object identity or authenticity proof.

Grouped execution order follows the PH04 design: active Account dataset, half-open UTC timeframe, selected Item scope, selected determinant keys, determinant plus relational breakdown groups, operation/measure compatibility, checked fixed-point calculation per compatibility key, typed unavailable preservation and immutable record creation. Difference remains comparison B minus baseline A. Percentage remains part/whole. Purchase totals are deduplicated per Purchase for purchase-total measures.

Variables derives Purchases in memory from contained Item rows and uses repeated Purchase-level fact consistency checks rather than choosing arbitrary conflicting rows. Purchase selection expands to stable Item IDs; Item selection uses exact Item IDs. Search/sort/page/filter transitions are local and deterministic.

Chart and Table are projections of one frozen grouped-result list. Chart is CustomPainter presentation only; mixed incompatible keys fall back to Table. CSV/PDF builders are pure; only explicit page export writes a temp file.

## Request, Rollback And Forbidden Surface

Repository request count is initial:1, retry:+1 and local transitions:+0. Analytics network requests and database writes are 0. Successful explicit CSV/PDF exports write one temp file each.

Rollback is one implementation commit because no schema, migration, generated source, dependency, platform code or persistence conversion was introduced.

Forbidden-surface audit found no changes to schema/migrations, `local_database.dart`, generated Drift output, pubspec/lockfiles, dependencies, platform code, API, Auth, Sync, provider, diagnostic contracts/generated registry, Settings/Audit/Closure, Lists, History, shell/composition/navigation, D/E/F, A/B/C, J, Main-root, permanent memory, methodology, environment configuration or secrets.

## Validation Evidence

Focused tests, full suite, analysis, Windows release build, Android debug build, diagnostic-generator check and `git diff --check` passed. Performance measurements were captured in `analytics_workspace_test.dart`: ordinary 1,000 Purchases / 5,000 Items with 58 ms load and 66 ms grouped record creation; stress 10,000 Purchases / 50,000 Items with 263 ms load and 586 ms grouped record creation.

## Terminal

```text
CYCLE=C11
PHASE=C11-PH04
ROUND=C11-PH04-R01
ANALYTICS_DEPENDENCY_DIRECTION=PASS
COMPOSER_CLOSED_TYPES=PASS
IMMUTABLE_RECORD_IDENTITY=PASS
CANONICAL_FINGERPRINT=PASS
GROUPED_RESULT_MODEL=PASS
PH02_FIXED_POINT_COMPATIBILITY=PASS
PURCHASE_PROJECTION_DEDUPLICATION=PASS
VARIABLES_STABLE_SELECTION=PASS
CHART_TABLE_SINGLE_SOURCE=PASS
EXPORT_PURE_BOUNDARY=PASS
SESSION_ONLY_LIFETIME=PASS
RESPONSIVE_SHARED_STATE=PASS
REPOSITORY_REQUEST_COUNT=initial:1; retry:+1; local_transitions:+0
SCHEMA_MIGRATION=NONE
GENERATED_SOURCE_CHANGED=NO
DEPENDENCY_CHANGED=NO
SECOND_TRUTH_OR_CONTROLLER=ABSENT
API_AUTH_SYNC_PROVIDER_DIAGNOSTIC_IMPORTS=ABSENT
PH03_ARCHITECTURE_CHANGED=NO
ROLLBACK=ONE_COMMIT
NEXT_DESIGN_REVIEW=Reconcile PH04 I evidence and retain human visual/real-device gates.
```
