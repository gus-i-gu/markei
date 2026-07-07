# [M] Session 001 | 10:05_07_07_2026 | Markei

# F_DSN_STAGE — Main Design Materialization Stage

> Source stages:
> - `DEV_STAGE/C_DESIGN.md`
> - `DEV_STAGE/A_OPERATIONAL.md`
> - `DEV_STAGE/B_DIDACTIC.md`
>
> Purpose: Codex-ready design notebook update brief.
> Status: Main-approved for Codex materialization after user review.

---

# 1. Main Design Synthesis

Design and Operational reports agree that the ImportError is not an architectural reason to remove the repository layer.

The intended architecture remains:

```text
UI
↓
ProductService
↓
Repository
↓
SQLite/database.py
```

`ProductService` should remain the business orchestration layer.

`Repository` should remain the persistence adapter.

`database.py` should remain the SQLite lifecycle/configuration module.

The current failure indicates that `repository.py` is malformed or incomplete, not that the service/repository architecture should be abandoned.

---

# 2. Design Decision Approved for Materialization

Approved design decision:

```text
ProductService should depend on a repository object compatible with RepositoryContract.

The default concrete implementation should be a module-level class named Repository exported by app/core/repository.py.
```

Do not convert service calls to direct module-level repository functions.

Do not move SQL into services.

Do not duplicate database lifecycle responsibilities in repository beyond opening/owning an instance connection through `database.connect()`.

---

# 3. Permanent Design Updates Required

Create or update design files under:

```text
documentation/sketch_notebook/design/
```

Recommended files if not already present:

```text
documentation/sketch_notebook/design/01_ARCHITECTURE.md
documentation/sketch_notebook/design/03_DECISIONS.md
documentation/sketch_notebook/design/09_DOMAIN_MODEL.md
```

If these files already exist, append/update conservatively.

Do not edit methodology files.

---

# 4. Codex Prompt — Design Materialization

Codex, read first:

```text
AGENTS.md
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/FLUX.md
```

Do not modify:

```text
documentation/sketch_notebook/methodology/
```

Task:

Use:

```text
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
```

as the primary design source, and synthesize it into permanent design notes under:

```text
documentation/sketch_notebook/design/
```

Include only stable design conclusions.

Do not preserve raw conflict markers or duplicate staged fragments.

---

# 5. Architecture Note to Persist

Add/update architecture content stating:

```text
Core application dependency direction:

UI -> ProductService -> Repository -> database.py -> SQLite
```

Responsibilities:

```text
ProductService:
    business workflows, receipt registration, product lifecycle calculations, status classification.

Repository:
    SQL operations, persistence methods, row-to-model mapping, database access through database.py.

database.py:
    SQLite connection lifecycle, schema initialization, reset, database existence checks.

models.py:
    passive domain data structures.

contracts.py:
    abstract responsibility declarations.
```

---

# 6. Decision Note to Persist

Add/update decision content:

```text
Decision: Preserve the Repository object boundary.

Status: Accepted for current MVP repair.

Context:
`services.py` imports and instantiates `Repository`, but `repository.py` does not currently expose a top-level Repository class.

Decision:
Restore a concrete `Repository` class in `app/core/repository.py`, preferably compatible with `RepositoryContract`.

Consequences:
- service layer remains free of SQL;
- repository layer remains the persistence adapter;
- `database.py` remains responsible for SQLite lifecycle;
- later dependency injection may allow ProductService(repository: RepositoryContract | None = None).
```

---

# 7. Domain/Boundary Note to Persist

Add/update domain model or boundary content:

```text
Repository is not a domain entity.

Repository is an infrastructure/persistence adapter that reconstructs domain models from database rows.

Product, Purchase, Category, and Store remain domain data structures.

Promotion support should remain deferred unless the model/schema clearly support it.
```

---

# 8. Expected Codex Report

Codex must report:

1. design files created/updated;
2. architecture note added;
3. decision note added;
4. domain/boundary note added;
5. whether raw stage conflict markers were ignored/removed in materialized notes;
6. unresolved design risks.
