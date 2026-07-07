# B_DIDACTICS.md

> Authority: Didactic Chat
> Scope: Staging notes only
> Status: Waiting for Main Chat synthesis

---

# 2026-07-07 — Didactic staging: Repository ImportError

## Trigger

```text
ImportError: cannot import name 'Repository'
```

Concrete project context:

```python
from .repository import Repository
```

appears in `app/core/services.py`, and `ProductService.__init__` later does:

```python
self.repository = Repository()
```

Therefore the service layer expects `app.core.repository` to expose an importable top-level symbol named `Repository`.

Current `app/core/repository.py` does not visibly expose such a top-level class. It begins with database helper functions, and repository-like methods appear nested below `if __name__ == "__main__":`, which prevents them from acting as methods of an importable `Repository` class.

---

# Concepts discovered

## 1. Python module imports

Marker: `&&%`

A Python import has two separate moments:

```text
1. Find/load the module.
2. Retrieve a name from that module's namespace.
```

For:

```python
from .repository import Repository
```

Python interprets the dot relative to `app.core.services`:

```text
current package: app.core
module requested: app.core.repository
name requested: Repository
```

So the import can fail even if `repository.py` exists. The file can be found, loaded, and executed, but still not contain the requested name.

Learning distinction:

```text
ModuleNotFoundError
    Python cannot find the module.

ImportError: cannot import name
    Python found the module, but the requested symbol is absent or unavailable.
```

---

## 2. Exported symbols

Marker: `&&%`

In ordinary Python usage, an "exported symbol" means a name available at module top level after the module has executed.

Example:

```python
# repository.py

class Repository:
    pass
```

This makes `Repository` available as:

```python
from .repository import Repository
```

But this does not:

```python
# repository.py

def connect():
    ...
```

because `connect` is exported, but `Repository` is not.

A file name does not automatically create a class name. `repository.py` gives the module name `repository`; it does not automatically create the symbol `Repository`.

---

## 3. Repository Pattern

Marker: `&%%`

The Repository Pattern gives the service layer a persistence-facing object that hides SQL and database details.

In Markei, the intended learning shape is:

```text
ProductService
    knows workflows, rules, calculations

Repository
    knows persistence operations and SQL mapping

SQLite
    stores the data
```

The service docstring already expresses this separation:

```text
ProductService → Repository → SQLite
```

This means the didactic point is not merely "fix the import". The deeper lesson is layer boundary:

```text
services.py should not need to know SQL.
repository.py should provide the persistence abstraction services.py depends on.
```

---

## 4. Why this import fails

Marker: `&%%`

The import fails because `services.py` asks for this symbol:

```python
Repository
```

from this module:

```python
app.core.repository
```

but `repository.py` does not currently define `Repository` at module scope.

The failure sequence is:

```text
1. Python imports app.core.services.
2. services.py reaches: from .repository import Repository
3. Python locates app.core.repository.
4. Python loads repository.py.
5. Python looks for repository.Repository.
6. The name is absent.
7. ImportError is raised.
```

So this error is best understood as:

```text
module found, symbol missing
```

rather than:

```text
file missing
```

---

# Suggested KANBAN

Yes — a future KANBAN should be created, but not directly from this staging file until Main Chat synthesis.

Suggested card:

```text
Title:
    Understand Python import namespaces through Repository ImportError

Marker:
    &&% / &%%

Status:
    Yellow

Learning objective:
    Distinguish module discovery from symbol lookup, then connect that distinction to Markei's service/repository boundary.

Practical anchor:
    `from .repository import Repository` fails because `repository.py` exists but does not export a top-level `Repository` symbol.

Promotion condition:
    Move to Green after the repaired `Repository` class is inspected and the import succeeds in execution.
```

Reason for KANBAN:

This is a reusable debugging pattern. The same mental model will help with future errors involving models, services, UI pages, package paths, or renamed classes/functions.

---

# Suggested glossary additions

A glossary update would be useful, but should be staged as suggestions only because permanent notebook files must not be modified in this pass.

Suggested entries or refinements:

```text
Module
    A Python file/package loaded as a code namespace.

Module namespace
    The set of names available inside a module after it executes.

Exported symbol
    A top-level name that another module can import.

Relative import
    An import that starts from the current package, such as `from .repository import Repository`.

ImportError: cannot import name
    The module was found, but the requested symbol was not available.

ModuleNotFoundError
    Python could not find the requested module path.

Repository Pattern
    A persistence abstraction that lets services request data operations without knowing SQL/database details.
```

Existing glossary coverage already includes several import terms. Main Chat should decide whether to merge, refine, or avoid duplication.

---

# Didactic conclusion

The error teaches one central distinction:

```text
Importing a module is not the same as importing a name from that module.
```

For Markei, the immediate meaning is:

```text
services.py can find repository.py,
but repository.py does not currently provide Repository.
```

The architectural learning is:

```text
ProductService depends on a persistence abstraction.
That abstraction must exist as an importable symbol if services.py imports it as a class.
```

Status: staged for Main Chat synthesis.
