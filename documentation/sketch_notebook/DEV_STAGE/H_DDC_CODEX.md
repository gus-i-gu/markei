# H_DDC_CODEX - Explicit Store Selection Semantics

- Authority marker: C10-MCG02-STORE-SELECTION-CORRECTION_20260720T201904Z
- Baseline HEAD before correction: f37dfb49502756a21c6de02fc1a8c662311b1e6a
- Final commit SHA: self-referential Git SHA is reported in the Codex terminal response.
- Evidence boundary: local Flutter source, widget tests, repository regressions, local Android/Windows builds. No provider operation.

## Materialized Vocabulary

- `store-available`: a Store appears in the active Account-scoped list; this no longer selects it.
- `store-selection-required`: no Store ID has been deliberately selected.
- `store-selected`: the visible Store name resolves to one stable same-Account Store ID.
- `store-selection-invalidated`: the selected ID disappeared from the refreshed active Account list and no fallback was inferred.
- `item-required`: a Store is selected but no Purchase Item is staged.
- `purchase-registered-locally`: selected Store and staged Items committed atomically to local Drift.

## UI Semantics

Purchase now starts with a visible `Select Store` placeholder whenever Stores are available but no Store has been selected. It does not silently select the first Store, including when only one Store exists. After explicit choice, it shows `Selected Store: <name>` and never exposes Store UUIDs.

Refresh and IndexedStack navigation preserve selection only by Store ID. If the selected Store is missing from the refreshed Account-scoped list, the selection clears and the UI reports `store-selection-invalidated`. If a valid Store is selected and no Item is staged, the UI reports only `item-required`, not a missing Store.

Draft preservation semantics from the prior correction remain: staged in-memory Items remain available after typed or unexpected registration failures. This unit does not claim durable Purchase draft persistence.

## Named Tests

- `no implicit Store selection after load`
- `explicit selection with one Store`
- `selection uses stable StoreId`
- `selection survives Store-list object reconstruction`
- `selection survives Catalogue navigation and refresh`
- `deleted or missing selected Store clears safely`
- `cross-Account Store cannot be selected`
- `Store selected plus no Item reports item-required`
- `complete Catalogue-create-to-Purchase-register flow`
- Existing retained tests: `Purchase requires an existing Store`, `registration failure preserves the staged draft`, `typed AppFailure produces sanitized UI diagnostics`, `unexpected failure produces a stable generic code and logs no provider credentials or facts`, local-only and hosted-bound repository registration, rollback, event/outbox counts, and close/reopen persistence.

## Wording Guard

No source, test or report claims provider convergence, provider synchronization completion, MCG-02 closure, MCG-03 activation or MCG-04 activation. This is a local corrective selection and registration-readiness boundary only.

## Exclusions

No provider credentials, tokens, callback URLs, identity subjects, Neon strings, Render secrets, SQL connection strings or private provider files were read or persisted.
