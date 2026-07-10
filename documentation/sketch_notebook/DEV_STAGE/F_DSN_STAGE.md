# DEV_STAGE/F_DSN_STAGE.md

> Status: Active Main materialization stage
> Authority: Main Chat
> Persistence class: Materialization stage material
> Cycle: 05
> Sprint: 01 — Windows Desktop Installation
> Domain: Design materialization
> Scope: Architectural guardrails for packaging, installation, SQLite initialization, user-data preservation, and desktop/mobile isolation
> Codex report target: `documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md`

---

# Cycle 05 Sprint 01 Design Materialization Stage

## 1. Purpose

This file is direct architectural authority for Codex.

It constrains implementation performed under D_OPS_STAGE.md and defines the design evidence to report after materialization.

Coordination:

```text
D_OPS_STAGE.md
    implementation and validation

E_DDC_STAGE.md
    learning-evidence capture

F_DSN_STAGE.md
    architectural boundaries and design evidence
```

## 2. Mandatory Context Bootstrap

Read first:

```text
AGENTS.md
```

Then load into active context in exactly this order:

```text
documentation/sketch_notebook/INDEX.md
↓
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
↓
documentation/sketch_notebook/methodology/FLUX.md
↓
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
↓
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
```

Keep the combined context active throughout implementation, validation, and design reporting.

Then read:

```text
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

D/E/F are direct materialization authority. A/B/C are supporting inputs only.

## 3. Recovery Economy

Use the least expensive sufficient source:

```text
AGENTS.md
→ INDEX.md
→ methodology bootstrap
→ F plus coordinated D/E instructions
→ only implementation files needed to verify boundaries
→ I report
```

Do not reread full architecture registers, decision history, or unrelated source modules unless a staged ambiguity, detected drift, or implementation dependency requires it.

If the selected architecture cannot be materialized without a new design decision, stop and report instead of silently redefining the boundary.

## 4. Strict Notebook Write Boundary

Codex must not modify:

```text
documentation/sketch_notebook/methodology/
documentation/sketch_notebook/operational/
documentation/sketch_notebook/didactics/
documentation/sketch_notebook/design/
documentation/sketch_notebook/[M]_STAGE/
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/00_PROJECT_STATE.md
documentation/sketch_notebook/05_SESSION_LOG.md
documentation/sketch_notebook/06_SESSION_SCHEME.md
documentation/sketch_notebook/DEV_STAGE/A_OPERATIONAL.md
documentation/sketch_notebook/DEV_STAGE/B_DIDACTIC.md
documentation/sketch_notebook/DEV_STAGE/C_DESIGN.md
documentation/sketch_notebook/DEV_STAGE/D_OPS_STAGE.md
documentation/sketch_notebook/DEV_STAGE/E_DDC_STAGE.md
documentation/sketch_notebook/DEV_STAGE/F_DSN_STAGE.md
```

The design report write authorized by this stage is:

```text
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

G and H are authorized by their corresponding stages.

Do not update permanent design memory.

## 5. Accepted Architecture

Preserve:

```text
Desktop UI
→ ProductService
→ Repository
→ SQLite
```

Add an external delivery chain:

```text
source application
→ desktop entrypoint
→ PyInstaller configuration
→ frozen one-folder runtime
→ Inno Setup configuration
→ installed application
```

Runtime state remains separate:

```text
installed application files
+
bundled read-only resources
+
external writable user-data directory
→ SQLite database
```

Packaging wraps Markei. It does not become a business layer.

## 6. Accepted Distribution Design

Primary distribution:

```text
installed one-folder Windows application
```

Primary artifact:

```text
Markei-Setup-<version>.exe
```

Locations:

```text
per-user installation
application: %LOCALAPPDATA%\Programs\Markei\
user data:  %LOCALAPPDATA%\Markei\
database:   %LOCALAPPDATA%\Markei\market.sqlite
```

A portable ZIP of the validated one-folder runtime is optional and secondary.

A single-file executable is rejected for Sprint 01.

## 7. Responsibility Map

### 7.1 Root entrypoint

Owns narrow process delegation.

Must not own schema meaning, business validation, SQL, or installer behavior.

### 7.2 Desktop startup infrastructure

Owns `QApplication`, top-level startup orchestration, main-window construction, fatal startup presentation, and diagnostic-log initiation.

Must not own product rules, list calculations, purchase calculations, repository queries, or migration semantics.

### 7.3 Runtime-path infrastructure

Owns bundled resource resolution, writable user-data resolution, source/frozen path differences, and working-directory independence.

Must not become ProductService behavior, Repository contract, domain-model state, or mobile persistence policy.

### 7.4 Database lifecycle

Owns database-directory creation, first-launch SQLite creation, schema execution, connection configuration, idempotent migration, mandatory defaults, and existing-data preservation.

Must not own installer placement, shortcuts, or sample UI content.

### 7.5 Repository

Owns SQL persistence, retrieval, row mapping, and contract-appropriate empty results.

Must not own Windows paths, PyInstaller detection, installer state, Start Menu behavior, production seed selection, or release versioning.

### 7.6 ProductService

Owns business validation, interpretation, read-model assembly, and service-level handling of empty repository results.

Must not own resource lookup, executable metadata, build dependencies, installation paths, or uninstall behavior.

### 7.7 Desktop pages

Own rendering, controls, user events, and empty-state presentation.

Must not execute schema initialization, create production sample records, inspect `_MEIPASS`, decide installer behavior, or relocate the database.

### 7.8 PyInstaller configuration

Owns runtime freezing, module collection, PySide6/Qt collection, read-only resources, executable identity, metadata, and one-folder output.

Must not own installation placement, shortcuts, uninstall, SQLite initialization, migration, or user-data deletion.

### 7.9 Inno Setup configuration

Owns per-user placement, Start Menu and optional desktop shortcuts, uninstall registration, stable upgrade identity, installer metadata, and replacement of application-owned files.

Must not own Python import analysis, Qt plugin analysis, database creation, SQL execution, migration, or business records.

## 8. Resource and State Boundary

Bundled read-only resources may include:

```text
schema.sql
application icon
Windows version metadata
Qt plugins
static UI assets
license notices
```

Writable user state includes:

```text
market.sqlite
market.sqlite-wal
market.sqlite-shm
diagnostic logs
future backups
future exports
```

Writable state must not live inside the frozen runtime, inside the installer payload as active state, beside `Markei.exe` by default, or in a protected installation location.

## 9. Schema and Seed Design

Accepted:

```text
bundled schema
→ application-owned first-launch initialization
→ empty business dataset
```

Rejected:

```text
installer deploys pre-populated market.sqlite
installer executes SQL
sample products or stores become first-user content
```

Mandatory settings may come from schema defaults, application-owned idempotent insertion, or a production-specific defaults resource with no business samples.

The current sample seed may remain only as an explicit development/test fixture. Its presence must not silently populate production.

## 10. Empty-State Design

The absence of business rows is valid state:

```text
no products ≠ database failure
no purchases ≠ History failure
no stores ≠ corrupted configuration
```

Pages and services must distinguish empty collections, missing optional records, missing prerequisites, and database exceptions.

A page may render an empty-state message. It must not manufacture fake records.

If first use requires category or store creation, the owning UI must expose that path or clearly identify the unmet prerequisite.

## 11. Version Boundary

One authoritative version should drive runtime display, executable metadata, installer metadata, and artifact naming.

Current authority candidate:

```text
app/core/config.py
```

Build and installer scripts should derive or receive that value rather than create competing truth. Report unavoidable duplication.

Application release version does not replace a future schema-version ledger.

## 12. Upgrade Design

```text
installer replaces application-owned files
→ user-data directory remains
→ new application opens existing database
→ application applies compatible migrations
→ user records remain available
```

Upgrade must not replace the database, rerun sample seed, delete active SQLite sidecars, reset settings, move migration into Inno Setup, or silently recreate incompatible data.

## 13. Uninstall Design

Normal uninstall removes application files, frozen dependencies, bundled resources, shortcuts, and uninstall registration.

Normal uninstall preserves:

```text
%LOCALAPPDATA%\Markei\
```

Application uninstall is not user-data deletion. Explicit data removal is deferred.

## 14. Startup Error Boundary

Database lifecycle raises meaningful technical failures. Desktop startup presents fatal failures.

The startup boundary may log traceback details, show a concise error, expose the log path, and exit non-zero.

It must not reset the database, suppress migration failure, create sample recovery data, silently recreate corruption, or absorb ordinary business validation.

## 15. Desktop-to-Mobile Isolation

Desktop-specific infrastructure may include:

```text
packaging/
Windows installer configuration
sys.frozen and _MEIPASS handling
LOCALAPPDATA resolution
Windows icon and version metadata
Start Menu and uninstall configuration
```

These concerns must not enter ProductService contracts, Repository contracts, domain models, business read models, database entities, or business-setting semantics.

The Sprint 02 clone should be able to omit Windows delivery files without changing business meaning.

SQLite remains accepted for Sprint 01. This does not make SQLite a public mobile or cross-device contract.

## 16. Change Classification

Required for packaging correctness:

```text
working-directory-independent resource discovery
external writable user-data location
production-safe schema initialization
seed-free first launch
Qt runtime and plugin collection
startup failure boundary
coordinated release version
stable installer upgrade identity
data-preserving uninstall
empty-database robustness
```

Optional refinements:

```text
dedicated desktop runtime-path module
dedicated desktop startup module
portable ZIP
log rotation
schema-version ledger
automated Windows build
release checksums
code signing
```

Forbidden drift:

```text
business rules in packaging
installer-owned database mutation
active database inside application files
Repository awareness of Windows installation
ProductService awareness of PyInstaller
UI pages reading _MEIPASS
sample data required for stability
API/backend/authentication/synchronization
SQLite exposed as mobile contract
silent user-data deletion
broad dependency-injection rewrite
```

## 17. Expected File Surface

Existing files that may participate:

```text
main.py
app/main.py
app/core/config.py
app/core/database.py
app/core/repository.py
app/core/services.py
app/database/schema.sql
app/database/seed.sql
app/desktop/main_window.py
app/desktop/pages/
requirements.txt
.gitignore
README.md
```

Proposed delivery files:

```text
packaging/markei.spec
packaging/windows/markei.iss
packaging/windows/version_info.txt
packaging/windows/markei.ico
requirements-build.txt
scripts/build_windows.ps1
scripts/validate_windows_package.ps1
```

Create only justified files. Do not create speculative mobile structures.

## 18. Boundary Drift to Report

Report if:

- ProductService imports packaging or installer modules;
- Repository resolves `%LOCALAPPDATA%`;
- UI pages inspect frozen-runtime variables;
- Inno Setup executes SQL;
- the installer distributes active `market.sqlite`;
- production requires sample rows;
- upgrade reruns seed;
- uninstall deletes user data;
- version truth diverges;
- packaging forces broad business-contract changes;
- desktop paths become platform-neutral domain requirements;
- Sprint 02 begins.

Do not silently normalize boundary drift.

## 19. Required Design Evidence

Report evidence that:

1. entrypoint remains narrow;
2. startup and business responsibilities remain separate;
3. resource paths remain desktop infrastructure;
4. user data remains outside installation files;
5. initialization and migrations remain application-owned;
6. Repository remains persistence-oriented;
7. ProductService remains business-oriented;
8. pages render empty state without fake data;
9. PyInstaller and Inno Setup responsibilities remain separate;
10. upgrade and uninstall preserve data;
11. Windows packaging is removable from the future mobile clone.

## 20. I_DSN_CODEX.md Report Contract

Write:

```text
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Required sections:

1. Bootstrap and stage files read.
2. Accepted design decisions materialized.
3. Files changed or created for design reasons.
4. Final packaging and installation context diagram.
5. Entrypoint and startup responsibility evidence.
6. Runtime-path ownership evidence.
7. Resource-state and user-state boundary evidence.
8. Schema initialization ownership evidence.
9. Seed/sample-fixture decision evidence.
10. Empty-state design evidence.
11. Repository, ProductService, and UI boundary evidence.
12. PyInstaller and Inno Setup responsibility evidence.
13. Version-authority evidence.
14. Upgrade and uninstall evidence.
15. Desktop-to-mobile isolation evidence.
16. Boundary drift found.
17. Decisions not materialized.
18. Deferred items and open questions.
19. Suggested Design Chat follow-up.

Keep the report compact and evidence-oriented. Do not reproduce complete files.

## 21. Completion Boundary

Complete after materializing the selected installation architecture while preserving accepted boundaries, or after reporting concrete evidence that a new Main decision is required.

Do not update permanent design memory. Do not begin Sprint 02.
