# 07_GLOSSARY.md

> Domain: Didactic
> Status: Persistent derivative — Cycle 06 Sprint 02
> Authority source: `didactics/02_KANBAN.md`
> Purpose: Compact retrieval without independent truth

---

# Release-Evidence Spine

```text
installer configuration
→ compiled installer
→ per-user installation
→ Start Menu launch
→ technical workflow evidence
→ close/reopen
→ same-version reinstall
→ uninstall retention
→ reinstall recovery
→ human-visible acceptance — pending
```

Current evidence:

```text
configured: validated
built: validated
launched: validated — frozen and installed shortcut
installed: validated — automated per-user lifecycle
validated: partial-to-strong technical evidence
accepted: no
SmartScreen visible behavior: unknown
```

## Evidence State
**KANBAN ID:** `&&&05`  
The strongest truthful claim supported by observed evidence. Sprint 02 reached compiled installer, installed execution, technical workflows, retention, and recovery.

## Validation Boundary
**KANBAN ID:** `&&&05`  
The environment, lifecycle stage, conditions, and behavior covered by evidence. Automated service-backed workflow evidence is not a complete human UI walkthrough.

## Source Execution
**KANBAN ID:** `&&%04`  
Repository modules run through a development Python interpreter.

## Frozen Application
**KANBAN ID:** `&&%04`  
A generated executable distribution containing collected code, resources, and runtime dependencies.

## Installed Application
**KANBAN ID:** `&&%04`  
A frozen runtime placed and registered through an installer. Markei was launched through its Start Menu shortcut under the current ordinary Windows user.

## Packaging Artifact
**KANBAN ID:** `&%%06`  
The generated one-folder distribution produced from `Markei.spec`.

## Installer Configuration
**KANBAN ID:** `&%%06`  
Source instructions for producing setup media. `installer/Markei.iss` is configuration, not the installer executable.

## Installer Artifact
**KANBAN ID:** `&%%06`  
Compiled setup media. Sprint 02 produced `dist/installer/Markei-Setup-0.1.0-x64.exe`.

## Installed Program Files
**KANBAN ID:** `&%%06`, `%%%05`  
Replaceable application files placed under `%LOCALAPPDATA%\Programs\Markei`.

## Retained User Data
**KANBAN ID:** `%%%05`  
Mutable state under `%LOCALAPPDATA%\Markei`. The database survived uninstall and reopened after reinstall.

## Structural Default
**KANBAN ID:** `%%%01`  
A required baseline row or setting needed for valid application operation. Category `F` / `General` and store `1` / `Default Store` are structural defaults, not sample business data.

## Seed Data
**KANBAN ID:** `%%%01`  
Optional predefined rows used for development, testing, or demonstrations. Production excludes `seed.sql`.

## Build-Time Dependency
**KANBAN ID:** `%%%06`  
A dependency required to produce the frozen artifact. PyInstaller is the Markei example.

## Runtime Dependency
**KANBAN ID:** `%%%06`  
A dependency required by the executing application. Collected PySide6/Qt components are Markei examples.

## Installer-Time Dependency
**KANBAN ID:** `%%%06`  
A dependency required to compile installation tooling. Inno Setup's `ISCC.exe` is installed on the builder and is not required by installed Markei.

## Same-Version Reinstall
**KANBAN ID:** `&%%06`  
Reapplying the same installer identity/version. Sprint 02 observed retained compatible data.

## Uninstall Retention
**KANBAN ID:** `&%%06`, `%%%05`  
Removal of installed program files while preserving accepted external user state. Markei's database remained after uninstall.

## Reinstall Recovery
**KANBAN ID:** `&%%06`, `%%%05`  
Reinstalling program files and reopening previously retained compatible user data.

## Windows Reputation Observation
**KANBAN ID:** `&&&05`  
A platform-security or reputation observation distinct from application correctness. Defender was enabled and binaries were unsigned; human-visible SmartScreen behavior remains unknown.

---

# Existing Retrieval Terms

- **Responsibility boundary** — allocation of knowledge and behavior. `&&&01`
- **Naming as data contract** — precise labels preserve meaning. `&&&03`
- **Resource ownership and lifetime** — creation, use, and release responsibility. `&&&04`
- **Deterministic cleanup** — release tied to a visible scope or lifecycle event. `&&%03`
- **Statement versus workflow atomicity** — one statement can be atomic while a multi-step use case is not. `&%%05`
- **SQLite initialization versus migration** — fresh structure versus compatible adaptation; seeding is distinct. `%%%01`
- **SQLite connection ownership** — session and cursor lifetime. `%%%02`
- **Bundled resource versus writable user data** — replaceable application content versus retained mutable state. `%%%05`

---

# Supervision Notes

- `02_KANBAN.md` remains authoritative.
- No concept became Green.
- Installed technical validation does not prove learner mastery.
- Human-visible Register, Lists, History, Settings, close/reopen, and SmartScreen observations remain learner-facing evidence gaps.
- Tool names remain project examples rather than standalone concepts.
