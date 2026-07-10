# DEV_STAGE/F_DSN_STAGE.md

> Status: Active Main materialization stage
> Authority: Main Chat
> Persistence class: Materialization stage material
> Cycle: 05
> Sprint: 01 — Windows Desktop Installation
> Scope: Architectural guardrails for packaging, installation, SQLite initialization, user-data preservation, and desktop/mobile isolation

---

# Cycle 05 Sprint 01 Design Materialization Stage

## 1. Purpose

This stage translates the accepted Cycle 05 Sprint 01 design into implementation guardrails.

Coordination:

```text
D_OPS_STAGE.md
    implementation and validation

E_DDC_STAGE.md
    learning-evidence capture

F_DSN_STAGE.md
    architectural boundaries and design evidence
```

Codex must report into:

```text
documentation/sketch_notebook/DEV_STAGE/I_DSN_CODEX.md
```

Codex must not edit permanent design memory or methodology files.

## 2. Mandatory Bootstrap

Load into active context, in exactly this order:

```text
documentation/sketch_notebook/INDEX.md
documentation/sketch_notebook/methodology/METHOD_FOUNDATIONS.md
documentation/sketch_notebook/methodology/FLUX.md
documentation/sketch_notebook/methodology/PROMOTION_RULES.md
documentation/sketch_notebook/methodology/CHAT_PROTOCOL.md
```

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

Use only `documentation/sketch_notebook/` as the notebook root.

## 3. Accepted Architecture

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

Runtime data remains separate:

```text
installed application files
+
bundled read-only schema resources
+
external writable user-data directory
→ SQLite database
```

Packaging wraps Markei. It does not become a business layer.

## 4. Accepted Distribution Design

Primary distribution:

```text
installed one-folder Windows application
```

Primary artifact:

```text
Markei-Setup-<version>.exe
```

Installation scope and locations:

```text
per-user installation
application: %LOCALAPPDATA%\Programs\Markei\
user data:  %LOCALAPPDATA%\Markei\
database:   %LOCALAPPDATA%\Markei\market.sqlite
```

A portable ZIP of the validated one-folder runtime is optional and secondary.

A single-file executable is rejected for Sprint 01.

## 5. Responsibility Map

### Root entrypoint

Owns narrow process delegation. It must not own schema meaning, business validation, SQL, or installer behavior.

### Desktop startup infrastructure

Owns `QApplication`, top-level startup orchestration, main-window construction, fatal startup presentation, and diagnostic-log initiation.

It must not own product rules, list calculations, purchase calculations, repository queries, or migration semantics.

### Runtime-path infrastructure

Owns bundled resource resolution, writable user-data resolution, source/frozen path differences, and working-directory independence.

It must not become ProductService behavior, Repository contract, domain-model state, or mobile persistence policy.

### Database lifecycle

Owns database-directory creation, first-launch SQLite creation, schema execution, connection configuration, idempotent migration, mandatory database defaults, and existing-data preservation.

It must not own installer placement, shortcuts, or sample UI content.

### Repository

Owns SQL persistence, retrieval, row mapping, and contract-appropriate empty results.

It must not own Windows paths, PyInstaller detection, installer state, Start Menu behavior, production seed selection, or release versioning.

### ProductService

Owns business validation, interpretation, read-model assembly, and service-level handling of empty repository results.

It must not own resource lookup, executable metadata, build dependencies, installation paths, or uninstall behavior.

### Desktop pages

Own rendering, controls, user events, and empty-state presentation.

They must not execute schema initialization, create production sample records, inspect `_MEIPASS`, decide installer behavior, or relocate the database.

### PyInstaller configuration

Owns runtime freezing, module collection, PySide6/Qt collection, read-only resources, executable identity, metadata, and one-folder output.

It must not own installation placement, shortcuts, uninstall, SQLite initialization, migration, or user-data deletion.

### Inno Setup configuration

Owns per-user placement, Start Menu and optional desktop shortcuts, uninstall registration, stable upgrade identity, installer metadata, and replacement of application-owned files.

It must not own Python import analysis, Qt plugin analysis, database creation, SQL execution, migration, or business records.

## 6. Resource and State Boundary

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

Writable state must not live inside the frozen runtime, installer payload as active state, beside `Markei.exe` by default, or in a protected installation location.

## 7. Schema and Seed Design

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

Mandatory application settings may come from schema defaults, application-owned idempotent insertion, or a production-specific defaults resource containing no business samples.

The current sample seed may remain only as an explicit development/test fixture. Its presence must not silently populate production.

## 8. Empty-State Design

The absence of business rows is valid state:

```text
no products ≠ database failure
no purchases ≠ History failure
no stores ≠ corrupted configuration
```

Pages and services must distinguish empty collections, missing optional records, missing prerequisites, and database exceptions.

A page may render an empty-state message. It must not manufacture fake records.

If first use requires category or store creation, the owning UI must expose that path or clearly identify the unmet prerequisite.

## 9. Version Boundary

One authoritative version should drive runtime display, executable metadata, installer metadata, and artifact naming.

Current authority candidate:

```text
app/core/config.py
```

Build and installer scripts should derive or receive that value rather than create competing truth. Report unavoidable duplication.

Application release version does not replace a future schema-version ledger.

## 10. Upgrade Design

```text
installer replaces application-owned files
→ user-data directory remains
→ new application opens existing database
→ application applies compatible migrations
→ user records remain available
```

Upgrade must not replace the database, rerun sample seed, delete SQLite sidecars while active, reset settings, move migration into Inno Setup, or silently recreate incompatible data.

## 11. Uninstall Design

Normal uninstall removes application files, frozen dependencies, bundled resources, shortcuts, and uninstall registration.

Normal uninstall preserves:

```text
%LOCALAPPDATA%\Markei\
```

Application uninstall is not user-data deletion. Explicit data removal is deferred.

## 12. Startup Error Boundary

Database lifecycle raises meaningful failures. Desktop startup presents fatal failures.

The startup boundary may log traceback details, show a concise error, expose the log path, and exit non-zero.

It must not reset the database, suppress migration failure, create sample recovery data, silently recreate corruption, or absorb ordinary business validation.

## 13. Desktop-to-Mobile Isolation

Desktop-specific infrastructure may include:

```text
packaging/
Windows installer configuration
sys.frozen and _MEIPASS handling
LOCALAPPDATA resolution
Windows icon and version metadata
Start Menu and uninstall configuration
```

These concerns must not enter ProductService contracts, Repository contracts, domain models, business read models, database entities, or business setting semantics.

The Sprint 02 clone should be able to omit Windows delivery files without changing business meaning.

SQLite remains accepted for Sprint 01. This does not make SQLite a public mobile or cross-device contract.

## 14. Change Classification

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

## 15. Expected File Surface

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

## 16. Boundary Drift to Report

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

## 17. Required Design Evidence

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

## 18. I_DSN_CODEX.md Report Shape

After materialization write:

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

## 19. Completion Boundary

Complete after materializing the selected installation architecture while preserving accepted boundaries, or after reporting concrete evidence that a new Main decision is required.

Do not edit permanent design memory, methodology, or Sprint 02 implementation.
