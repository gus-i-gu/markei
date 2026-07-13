# F_DSN_STAGE — Cycle 08 Product-Beta Design Directive

> Cycle: 08 — Shared-Client Product Beta
> Directive: C08-PB-01
> Status: ACTIVE — CODEX PRODUCT IMPLEMENTATION AUTHORIZED
> Authority: explicit human instruction reconciled by Main [M]
> Paired directives: `D_OPS_STAGE.md` and `E_DDC_STAGE.md`
> Control: this directive fully supersedes C08-IMP-01 and every earlier F authorization

## 1. Accepted architecture

Preserve the existing dependency direction:

```text
Flutter presentation
→ application commands/query ports
→ independent Dart domain
← infrastructure adapters
→ Drift application-private SQLite
```

Cycle 08 adds product-facing coordination and queries without replacing this structure, adding a framework or changing the schema.

Widgets render and collect input. Application-facing coordinators own workflow state. Domain objects own Product, Quantity, Money and Purchase invariants. Infrastructure owns Drift queries and the atomic transaction.

## 2. Product topology

Accepted top-level destinations:

1. Purchase;
2. Products;
3. History.

Store is selected or created inside Purchase.

All destinations come from one semantic definition used by compact and wide navigation. The shell owns selected destination and layout choice. Pages remain mounted where necessary to preserve the current app-session draft.

## 3. Presentation-state model

Use small dependency-free typed states for asynchronous/result surfaces.

Required conceptual forms:

```text
LoadState<T> =
  loading
  | empty
  | data(T)
  | failure(safeMessage, retry)

SubmissionState =
  editing
  | reviewing
  | submitting
  | succeeded(result)
  | failed(safeMessage)
```

Concrete Dart names may differ. Do not force infrastructure exceptions into presentation types.

## 4. Products structure

Add a Products presentation surface driven by `CatalogueQueryRepository`.

Responsibilities:

- load Products for the local account;
- local text filtering over the bounded current list;
- expose empty, no-match, failure and data states;
- return/select a Product for Purchase;
- initiate new Product entry.

Product resolution remains:

- `ExistingProductReference` for explicit reuse;
- `NewProductReference` for creation;
- current exact identity rules in domain/repository;
- current similarity policy as advisory only.

The creation flow must query advisory candidates before staging and capture explicit use-existing/create-anyway intent.

Do not introduce automatic merge, pagination infrastructure or a search dependency.

## 5. Purchase draft coordinator

Introduce an application-facing, dependency-free session coordinator or equivalent testable model.

It owns:

- selected existing/new Store intent;
- stable `DraftLineKey` identity;
- staged lines;
- add/replace/remove;
- running total;
- editing and review phases;
- validation/result state;
- in-flight registration guard;
- reset after success;
- retained draft after recoverable failure.

Text controllers, focus nodes and widget layout remain presentation-owned.

Draft lifetime is app-session/mounted only. Do not persist it.

## 6. Store reference boundary

The Purchase flow must expose existing Store selection and new Store creation.

Preferred application contract:

```text
StoreReference =
  ExistingStoreReference(StoreId)
  | NewStoreReference(displayName)
```

Exact names may differ. This application-contract refinement is authorized if required to prevent an explicit Store selection from collapsing back into free text.

Infrastructure resolution must:

- verify selected Store account ownership;
- preserve the selected Store UUID;
- create a new Store only for explicit new intent;
- retain current schema and current display-name facts.

No normalization, branch field, merge rule or unique index is authorized.

## 7. Registration boundary

The existing Drift transaction remains the authority for atomic Purchase, Items, Event and PendingEvent persistence.

The coordinator must:

- create one command from the reviewed draft;
- disable repeat registration while the call is in flight;
- show success only from the returned repository result;
- retain the draft on known failure;
- refresh Products/History and clear the draft after success.

This is duplicate-tap mitigation, not durable idempotency. Do not add SubmissionId or schema changes.

## 8. History and detail ports

Separate application query responsibilities:

- recent Purchase summaries;
- Purchase detail;
- Product price observations.

Add immutable query records that do not expose Drift rows.

The local adapter should:

- fetch summary Item counts without one query per Purchase where practical;
- fetch one Purchase and its Items/Products for detail;
- preserve account isolation;
- order by occurrence time deterministically;
- retain the current bounded recent-list policy unless a simple cursor/limit extension is necessary.

Widgets consume these ports only.

## 9. Comparison use case

Implement a pure, versioned comparison over observations returned by a query port.

Comparable observations require:

- same Product identity;
- same currency;
- same quantity kind;
- same canonical unit;
- positive normalized purchased amount.

Derived unit price:

```text
line total minor units / normalized purchased quantity
```

Compare the latest and immediately previous compatible observations by occurrence time. Return either:

- comparable result containing source observations, derived prices and percentage change; or
- explicit insufficient/incompatible reason.

Use deterministic integer/rational arithmetic where practical. Avoid floating-point authority for Money. No cache or schema change.

## 10. Responsive and lifecycle invariants

The implementation must preserve:

- destination selection across compact/wide resize;
- staged Purchase Items across destination changes and resize;
- no page recreation that triggers duplicate registration;
- focus and keyboard access to form actions;
- safe Back behavior from review to edit;
- readable larger-text layouts;
- Android portrait/landscape and Windows narrow/wide composition.

Process-death restoration is not promised.

## 11. Tests required

Behavior-level tests must cover:

- three-destination compact/wide shell;
- resize and draft preservation;
- Products load/search/no-match/failure;
- existing Product selection;
- similar advisory and explicit create-anyway;
- existing/new Store reference;
- multi-line add/edit/remove;
- review/back/register;
- in-flight duplicate-submit guard;
- known registration failure retaining draft;
- History loading/empty/failure/data/detail;
- summary query count behavior;
- comparable/incompatible/insufficient price comparison;
- technical identifiers absent from ordinary copy.

Repository tests must continue proving atomic rollback and reopen behavior.

## 12. Writable architectural surface

Codex may add or modify source and tests under the Flutter client for:

- app shell and composition;
- Products, Purchase and History presentation;
- dependency-free presentation/coordinator models;
- application commands and query ports;
- domain-level pure comparison structures/functions;
- local query and Purchase repository adapters;
- focused tests.

Generated Drift output must not change because schema changes are outside scope.

## 13. Explicit exclusions

Do not add:

- dependencies or frameworks;
- schema versions, migrations, tables, columns or indexes;
- optional Product code;
- Store normalization/branch identity;
- durable SubmissionId/idempotency;
- persisted drafts;
- Device relation changes;
- authentication/API/Neon/synchronization;
- export/restore implementation;
- analytics cache, forecasting or official inflation;
- registered Purchase mutation;
- Python/PySide6 changes.

If one product behavior appears to require an exclusion, isolate the blocker and continue independent units where possible.

## 14. Completion architecture

C08-PB-01 is architecturally complete when the Flutter UI visibly supports:

```text
Products
↘
Purchase: Product + Store → staged Items → review → atomic local registration
↘
History: summary → detail → compatible price comparison
```

and G/H/I accurately report implementation and validation.

A responsive shell alone, state-type refactor alone, or documentation-only result is explicitly insufficient.
