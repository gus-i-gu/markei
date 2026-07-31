# I_DSN_CODEX - C11-PH05-R01

## Design Result

- `ExportDestinationPort` is the single application export destination boundary. `LocalExportDestination` is the single composition-injected platform adapter.
- History and Analytics keep pure export builders separate from file writes. Only explicit export calls the destination.
- History export now uses two set-based Account-scoped local reads for non-empty selected sets: attempts to reconstruct Purchases in one joined purchase read and contained Items in one joined item read.
- Android public Downloads export is a typed unavailable result with zero writes. Windows uses the existing `path_provider` dependency to resolve Downloads and never overwrites collisions.
- Home presentation is source-local static content with no repository, network, database or file dependency.
- Catalogue selection owner was removed from ordinary UI. Product detail owner remains page-local.
- History selection owner remains a single stable Purchase-ID set. Detail selection is a separate Purchase-ID.
- Analytics keeps one composition-owned workspace/controller, existing record fingerprints, fixed-point semantics, Chart/Table parity, and zero Analytics database/network writes.
- Guide content is a single local typed list owned by `guide_page.dart`; anchors use page-local focus nodes.
- Audit cards depend only on loaded `AuditPageResult` state; no Audit network, write, broad auth, sync, retry/recovery or closure-runner capability was imported.
- Settings controller ownership remains page-local. The support action lifecycle now refreshes Account/Sync status while the duplicate-action busy guard stays active.
- Schema, generated Drift source, dependencies, platform files, Auth/API/Sync/provider/diagnostic contracts and PH03 Closure surfaces were not changed.

## Rollback

- Rollback is the single PH05 implementation chain from `b59b2ecdfb69ca98c431b9f36694f011332fbef3`.

## Terminal

```text
CYCLE=C11
PHASE=C11-PH05
ROUND=C11-PH05-R01
HOME_PRESENTATION_OWNER=PASS
PURCHASE_DRAFT_OWNER_UNCHANGED=PASS
CATALOGUE_SELECTION_OWNER=REMOVED
HISTORY_SELECTION_OWNER=SINGLE_STABLE_ID_SET
HISTORY_DETAIL_SELECTION_ISOLATION=PASS
ANALYTICS_TYPED_HANDOFF=PASS
ANALYTICS_SECOND_CONTROLLER=ABSENT
EXPORT_DESTINATION_OWNER=SINGLE_SHARED_PORT
HISTORY_EXPORT_QUERY_BOUNDARY=TWO_SET_BASED
ANDROID_EXPORT_WRITES=0
GUIDE_CONTENT_OWNER=SINGLE_LOCAL_TYPED
AUDIT_PROJECTION_DEPENDENCY=LOADED_LOCAL_STATE_ONLY
SETTINGS_CONTROLLER_OWNER=UNCHANGED
SETTINGS_ASYNC_REFRESH=PASS
REFERENCE_IDENTITY=UUID_PLUS_STABLE_AT_HASH_CODES
RESPONSIVE_SHARED_STATE=PASS
SCHEMA_MIGRATION=NONE
DEPENDENCY_PLATFORM_CHANGE=NONE
API_AUTH_SYNC_PROVIDER_DIAGNOSTIC_IMPORTS=ABSENT
ROLLBACK=PH05_IMPLEMENTATION_CHAIN
NEXT_DESIGN_REVIEW=Reconcile PH05 I and retain deferred Android/human evidence gates.
```
