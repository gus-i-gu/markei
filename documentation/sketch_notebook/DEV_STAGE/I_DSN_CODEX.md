# I_DSN_CODEX - C11 PH01 S02 Preliminary Design Evidence

## Architecture Summary

Theme and presentation tokens remain owned by `markei_theme.dart`. Shared presentation-only primitives remain in `markei_components.dart`. The shell keeps stable destination identity and only changes density, selected row styling and compact header behavior.

Home, Lists, Catalogue, History and Purchase were recomposed as presentation changes over existing repositories and page state. Desktop tables and compact cards project the same in-memory records for Lists, Catalogue, History and Purchase staged Items.

No shared widget calls a repository, database, provider or Sync coordinator.

## Page Boundaries

- Home: route hierarchy and local-first explanation only.
- Lists: one projection future per view/refresh, search/sort presentation only, unified summary strip and compact status/total surfaces.
- Catalogue: one loaded Product/Store collection, local search/sort, table/cards and subordinate create/similarity/Stores surfaces.
- History: one retained History read per refresh/retry, local filters from loaded entries, table/cards and selected detail.
- Purchase: one draft, one edit/review/register flow, shared staged-line table/card projection.

## Residual Design Risk

The Purchase review interaction cannot be promoted because required app-level widget tests time out. Visual screenshot review was not completed. The implementation should not be committed or published until that validation is resolved.

## Terminals

CYCLE=C11
PHASE=C11-PH01
UNIT=C11-PH01-S02
PRESENTATION_ARCHITECTURE=PARTIAL
SHARED_TOKEN_OWNERSHIP=PASS
SHARED_COMPONENT_BOUNDARY=PASS
RESPONSIVE_PROJECTION_PARITY=PASS
PAGE_STATE_PRESERVED=BLOCKED
REPOSITORY_INTERFACES_CHANGED=NO
DOMAIN_OR_INFRASTRUCTURE_CHANGED=NO
NEW_DEPENDENCY_OR_ASSET_PIPELINE=NO
ANALYTICS_SETTINGS_AUDIT_CLOSURE_BOUNDARY=PRESERVED
BUSINESS_OR_SYNC_SOURCE_CHANGED=NO
NEXT_DESIGN_REVIEW=Investigate the hanging Purchase review cases in test/app/markei_app_test.dart before publication.
