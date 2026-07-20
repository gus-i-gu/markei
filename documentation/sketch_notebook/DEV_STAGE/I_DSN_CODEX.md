# I_DSN_CODEX - Explicit Store Selection Design Evidence

- Authority marker: C10-MCG02-STORE-SELECTION-CORRECTION_20260720T201904Z
- Baseline HEAD before correction: f37dfb49502756a21c6de02fc1a8c662311b1e6a
- Final commit SHA: self-referential Git SHA is reported in the Codex terminal response.

## Dependency Direction

The correction preserves the selected boundary:

`Purchase UI -> selected Store ID -> Account-scoped CatalogueQueryRepository Store list -> ExistingStoreReference -> LocalPurchaseRepository transaction`

Widgets still depend on application ports. Drift operations remain in infrastructure. No domain object, event payload contract, server API, server authorization path, sync protocol or schema version changed.

## Selection State Model

Purchase now stores `String? _selectedStoreId` as the stable selection value. The display name and command reference are resolved from the current Account-scoped `List<Store>`. A null ID renders `Select Store`; a resolved ID renders `Selected Store: <name>`; an unresolved ID clears and reports `store-selection-invalidated`.

The previous implementation stored `Store? _selectedStore` and assigned `stores.first` after load when no previous selection existed. Tests reproduced that this erased the distinction between Store availability and Store selection. The final implementation removes first-row fallback and no longer treats a reconstructed Store object as authoritative selection.

## Account Boundary

The only selectable IDs come from `widget.catalogueQueries.listStores(widget.accountId)`. `_storeReference()` resolves the selected ID against that active list and produces `ExistingStoreReference` only for a matching Store. Foreign or stale Store IDs cannot become command references through the UI.

## Refresh Behavior

`didUpdateWidget` still reloads catalogue data when the app refresh signal changes. A valid selected ID is retained across Catalogue navigation, Product/Store refreshes and reconstructed Store objects. If the Store disappears, selection is cleared with deterministic feedback and no new Store is inferred.

## Registration Invariants

Registration remains delegated to `LocalPurchaseRepository` and still uses only `ExistingStoreReference` from Purchase UI. The prior `bf78a39` invariants are preserved by retained repository tests:

- same hosted AccountId and server DeviceId after restart;
- existing same-Account Store and Product;
- one atomic Purchase;
- exactly one `purchase.registered` payload-version-3 SyncEvent;
- exactly one PendingEvent;
- one Device sequence advance on success;
- no partial mutation or sequence advance on rollback;
- local-only registration remains functional;
- hosted binding/enrollment state remains unchanged.

## Transaction Boundaries

This unit does not add transaction code. It prevents invalid UI command construction before the repository boundary and preserves repository atomicity. Failure feedback differentiates Store selection from Item staging before registration starts; typed and unexpected repository failures still preserve the staged draft.

## Deviations and Deferrals

No schema migration was needed. No durable draft storage, Store edit/archive UX, broader Catalogue redesign, provider synchronization proof, MCG-02 closure, MCG-03 or MCG-04 work was attempted.
