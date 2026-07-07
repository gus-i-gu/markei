# Design Decisions

## Preserve the Repository Object Boundary

Status: Accepted for current MVP repair.

Context:

`services.py` imports and instantiates `Repository`, but `repository.py` did not
expose a top-level `Repository` class.

Decision:

Restore a concrete `Repository` class in `app/core/repository.py`, compatible
with `RepositoryContract`.

Consequences:

- The service layer remains free of SQL.
- The repository layer remains the persistence adapter.
- `database.py` remains responsible for SQLite lifecycle.
- Later dependency injection may allow `ProductService(repository:
  RepositoryContract | None = None)`.

## Keep Price Variation Color Mapping in the UI Layer

Status: Accepted for current MVP repair.

Context:

`StoragePage` failed with `KeyError: "color"` because it expected
`ProductService` price-variation output to contain a presentation key named
`color`.

Decision:

`ProductService` should remain responsible for price variation semantics only.
`StoragePage`, or a future UI-side presentation mapper, should translate
semantic price variation into `QColor` or other visual styling.

Consequences:

- The service layer remains free of PySide6/Qt.
- Service return values remain semantic rather than presentation-specific.
- UI remains responsible for visual choices.
- Future interfaces can reuse `ProductService` without importing Qt.
