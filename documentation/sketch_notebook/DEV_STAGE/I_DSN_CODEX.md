# I_DSN_CODEX - Final PH01 Layout and PH02 Analytics Architecture Evidence

Source stages:

- `documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md`
- `documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md`

Architecture implemented:

- `domain/analytics/analytics_models.dart` owns Analytics identities, evidence
  rows, datasets, determinants, variables, operation requests, operation
  results, scopes, card configuration and typed unavailable reasons.
- `domain/analytics/analytics_registry.dart` owns versioned operation
  definitions `local.sum@1`, `local.mean@1`, `local.difference@1` and
  `local.percentage@1`, including checked integer/rational arithmetic and typed
  unavailable results.
- `application/analytics.dart` owns the read-only evidence repository port and
  typed History launch context.
- `application/analytics_workspace.dart` owns session-local dataset, cards,
  conditions, selection, focus, reset, retry, generation, 100-row pages,
  500-ID selected-scope cap and request counts.
- `infrastructure/local/local_analytics_repository.dart` owns the local
  Account-predicated joined load across Purchase Items, Purchases, Products,
  Stores, People and Payment Methods.
- `app/pages/analytics_page.dart` and
  `app/widgets/analytics_components.dart` own presentation only.
- `markei_composition.dart` supplies the local adapter, registry and workspace.
- `markei_app.dart` owns destination selection, visible destination state and
  typed History-to-Analytics launch context.
- `history_page.dart` owns selected Purchase IDs and handoff only; it imports no
  Analytics registry, workspace controller or local adapter.

R02 lifecycle correction:

- `AnalyticsPage` now accepts visible destination state and defers the local
  evidence read while hidden, preventing hidden app-shell tabs from owning
  background SQLite resources in tests.
- `test/app/markei_app_test.dart` helper scrolling now uses tester-owned
  bounded `ensureVisible` calls. Assertions remained substantive.
- No validation-owned Dart, Flutter or sqlite process remained after the
  focused and full validation runs.

Preserved boundaries:

- No schema, migration, generated source, dependency, lockfile, platform, API,
  Auth, Sync, provider or diagnostic source changed.
- Analytics cards remain session-local and are not serialized or synchronized.
- Widgets remain repository-free and calculation-free.
- Account scoping is enforced in the local repository join.
- Evidence identity is based on persisted Purchase Item IDs, with Purchase total
  kept separate from row Line total to avoid duplicate Purchase totals.

Evidence:

- Account-scoped join, complete evidence loading, request counts, no local
  transition rereads, selected-scope cap, fixed-point operation behavior,
  Difference B-minus-A, Percentage part-of-whole and overflow typed-block
  behavior are covered by focused tests.
- Ordinary and stress fixtures exercised 1,000/5,000 and 10,000/50,000
  Purchase/Item datasets with 100-row rendering and 500-ID selected-scope
  boundary evidence.
- Wide/compact state shares one workspace/controller; visual foundation and
  app-shell tests cover breakpoint retention and 200-percent text scale.

Residual limits:

- Screenshot-based rendered review was not performed.
- Assistive-technology, human acceptance, locale and real-device review remain
  absent.

## Terminal

```text
CYCLE=C11
ROUND=C11-PH01-S02-R01+C11-PH02
PH01_PRESENTATION_ARCHITECTURE=PASS
PH01_SINGLE_SCROLL_OWNER=PASS
PH01_HISTORY_SELECTION_SOURCE=PASS
ANALYTICS_DEPENDENCY_DIRECTION=PASS
ACCOUNT_SCOPED_JOIN=PASS
EVIDENCE_ROW_IDENTITY=PASS
PURCHASE_TOTAL_DEDUPLICATION=PASS
REGISTRY_VERSIONING=PASS
OPERATION_SPECIFIC_TYPES=PASS
CHECKED_FIXED_POINT_ARITHMETIC=PASS
SESSION_LOCAL_CARD_STATE=PASS
HISTORY_PURCHASE_ID_HANDOFF=PASS
RESPONSIVE_SHARED_STATE=PASS
WIDGETS_REPOSITORY_AND_CALCULATION_FREE=PASS
REPOSITORY_REQUEST_COUNT=initial_load:1; retry:+1; local_transitions:+0
SCHEMA_MIGRATION=NONE
GENERATED_SOURCE_CHANGED=NO
DEPENDENCY_CHANGED=NO
REMOTE_SYNC_DIAGNOSTIC_IMPORTS=ABSENT
NEXT_DESIGN_REVIEW=Reconcile final Analytics architecture evidence into Design memory.
```
