# [M] Session 004 | 11:??_07_07_2026 | Markei

# E_DDC_STAGE — Main Didactic Materialization Stage

> Source stages:
> - `documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md`
> - `documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md`
> - `documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md`
>
> Purpose: Codex-ready didactic notebook update brief for turning Markei from a developer-run Python project into a user-run desktop application.
> Status: Main-approved for Codex materialization after user review.

---

# 1. Main Didactic Synthesis

The current learning milestone is:

```text
Turning Markei into an installable/executable user-run application.
```

The central didactic distinction is:

```text
Developer-run project
    A developer has Python, dependencies, source files, terminal commands, and repository-relative paths.

User-run application
    A user launches an app, uses visible workflows, and expects their data to persist safely without knowing Python or the repository structure.
```

This milestone should teach that packaging is not only making an `.exe`.

It also changes the execution contract:

```text
from command-based execution
    to application launch

from source-folder assumptions
    to packaged runtime assumptions

from repository database
    to user-owned app data
```

---

# 2. Didactic Promotions Approved

Codex may create or update permanent didactic material under:

```text
documentation/sketch_notebook/didactics/
```

Do not modify methodology files.

Do not modify application code as part of this didactic materialization.

Approved didactic promotions:

1. Script vs application.
2. Executable vs installer.
3. Dependency and packaging.
4. Local database and app data folder.
5. User-facing interface vs developer interface.
6. Release artifact.
7. User data ownership.
8. Frozen Python application.
9. Path assumptions as part of runtime contract.
10. Release workflow: build, test, package, install, verify data preservation.

---

# 3. Recommended Permanent File Targets

If these files already exist, append/update conservatively.

If they do not exist, create focused versions:

```text
documentation/sketch_notebook/didactics/02_KANBAN.md
documentation/sketch_notebook/didactics/07_GLOSSARY.md
documentation/sketch_notebook/didactics/08_CONCEPT_MAP.md
```

Do not invent a large didactic system.

Keep the material focused on the installable/user-run application transition.

---

# 4. KANBAN Material to Add

Add a KANBAN-style learning entry titled:

```text
From developer-run script to user-run desktop application
```

Recommended concept markers:

```text
&&& Script vs Application
&&& Executable
&&& Installer
&&& User-Facing Interface
&&& Developer Interface
&&& Release Artifact
&&& User Data Ownership
%%% Dependency
%%% Packaging
%%% Frozen Python Application
&%% Local Database
&%% App Data Folder
&%% Packaged Runtime
&%% Runtime Path Contract
```

Core explanation:

```text
A developer-run Markei assumes a Python environment, a repository folder, installed packages, and terminal knowledge.

A user-run Markei should launch like a normal desktop app, hide Python startup details, and store user data in a stable user-owned location.
```

Project connection:

```text
Markei already has a PySide6 interface, but it still needs packaging-safe runtime paths and user-data handling before it can be trusted as an installable desktop application.
```

---

# 5. Glossary Entries to Add

Add concise project-contextual glossary entries for:

```text
script
application
entry point
executable
installer
dependency
runtime dependency
development dependency
packaging
release artifact
frozen Python application
local database
SQLite database file
app data folder
user data
program files
resource file
bundled resource
runtime path
path assumption
user-facing interface
developer interface
build artifact
installer
portable app folder
```

Suggested definitions should be short and grounded in Markei.

Example style:

```text
App data folder
    A user-specific location where an installed app stores persistent data. For Markei, this should contain the live `market.sqlite` database rather than placing user data inside the installed program folder.
```

```text
Frozen Python application
    A Python application bundled into a form that can run without the user manually installing Python packages. Markei can use this approach through a tool such as PyInstaller.
```

---

# 6. Concept Map Update

Add relationships similar to:

```text
Developer-run project
    -> Python interpreter
    -> virtual environment
    -> requirements.txt
    -> terminal command
    -> repository-relative paths

User-run application
    -> executable
    -> installer or portable folder
    -> app data folder
    -> visible interface
    -> persistent user data

Packaging
    -> dependencies
    -> bundled resources
    -> executable
    -> release artifact

Local database
    -> SQLite database file
    -> user data ownership
    -> app data folder
    -> backup/export later

Runtime path contract
    -> source-tree paths
    -> frozen application paths
    -> bundled resources
    -> user-writable data paths
```

---

# 7. Didactic Boundary Rules

Codex must not use didactic materialization to decide exact packaging implementation.

The didactic notebook may explain:

```text
An executable launches an app.
An installer places an app on a user's system.
A dependency is something the app needs to run.
A local database should be treated as user-owned data.
Packaged apps must separate bundled resources from writable user data.
```

The didactic notebook must not claim:

```text
PyInstaller is the only possible packaging tool forever.
The final installer must be Inno Setup / NSIS / MSIX.
All database path details are permanently settled.
```

Operational choices belong to D_OPS_STAGE.
Design/product choices belong to F_DSN_STAGE.

---

# 8. Expected Codex Report

Codex must report:

1. didactic files created/updated;
2. KANBAN concepts added;
3. glossary entries added;
4. concept-map relationships added;
5. whether material stayed focused on developer-run to user-run transition;
6. unresolved didactic risks or duplicated concepts found.
