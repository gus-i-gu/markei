# Markei Operational Grimoire

## Purpose

This collection reduces repeated operational typing while keeping the human
decision points visible. It is hemi-automated: scripts perform mechanical
validation; the operator confirms provider targets and authorizes mutations.

## The five files

| File | Responsibility |
| --- | --- |
| `GENERAL_SCRIPTS.md` | Short copy/paste commands and expected outcomes |
| `NEON_CHECK.ps1` | Role selection, masked credentials, Docker psql, guards |
| `NEON_ACTION.sql` | Named, reviewable SQL inspection blocks |
| `NEON_CRED.md` | Non-secret coordinates and aligned role names |
| `GRIMOIRE.md` | Architecture, setup, maintenance, and failure guidance |

## First setup

1. Place the five files together, preferably in `documentation/`.
2. Fill only the placeholders in `NEON_CRED.md`.
3. Keep passwords and complete URLs out of every file.
4. Start Docker Desktop.
5. Open PowerShell in the file directory.
6. Run:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\NEON_CHECK.ps1 -Role migrator -Action connection
```

`-Scope Process` affects only the current terminal. If organizational policy
blocks it, do not bypass that policy; run the script using the locally approved
PowerShell method.

## Normal use

For guided selection:

```powershell
.\NEON_CHECK.ps1
```

For deterministic reuse:

```powershell
.\NEON_CHECK.ps1 -Role <runtime|migrator|dbowner> -Action <action>
```

The password prompt is masked. The script temporarily passes the password to
the Docker container using `PGPASSWORD`, removes the container after the
action, and clears the temporary process variables in `finally`.

## Role boundaries

| Role | Routine purpose | Must not become |
| --- | --- | --- |
| `runtime` | Hosted API and least-privilege smoke checks | Migration identity |
| `migrator` | Migrations, ledger, catalog checks | Render runtime identity |
| `dbowner` | Explicit owner-only recovery | Default operational role |

Migration and Gate 02 actions are locked to `migrator`.

## How SQL actions work

Each action in `NEON_ACTION.sql` is delimited by:

```sql
-- ACTION: action-name
...
-- END ACTION
```

`NEON_CHECK.ps1` extracts only the selected block. To add an action:

1. Prefer a read-only transaction.
2. Return sanitized evidence only.
3. Add its name to both PowerShell `ValidateSet` and `$Actions`.
4. Add role restrictions when necessary.
5. Update `GENERAL_SCRIPTS.md`.
6. Test against the disposable development target.

## Migration design

`apply-migration` accepts a path instead of embedding SQL. It verifies that the
file is tracked and clean, shows its SHA-256, performs a role/database/TLS
preflight, and asks for `APPLY-ONCE`.

The operator must still confirm the Neon dashboard branch. A PostgreSQL
hostname/database response cannot independently prove a human-readable Neon
branch alias.

## Credential and coordinate map

| Requested item | Source | Storage |
| --- | --- | --- |
| Direct host | Neon Connect, intended branch | `NEON_CRED.md` |
| Database/role names | Neon/Markei configuration | `NEON_CRED.md` |
| Role password | Current rotated secret | Masked prompt only |
| Complete runtime URL | Neon pooled connector | Private secret store/Render |
| Render origin | Render service | Private note or prompt |
| Render API token/service ID | Render | Private secret store only |
| Auth0 issuer/audience/client ID | Auth0 application/API | Private configuration |
| Auth0 client secret/tokens | Auth0 | Secret store only; never mobile client |
| Device/account UUID | Local/provider evidence | Prompt when action requires it |

## Failure classifications

| Failure | Meaning / next move |
| --- | --- |
| Docker unavailable | Start Docker Desktop; no database call occurred |
| Placeholder remains | Complete non-secret coordinate file |
| Authentication rejected | Confirm selected role and current rotated password |
| Identity mismatch | Stop; coordinate or credential is wrong |
| TLS mismatch | Stop; do not open shell or mutate |
| Migration dirty/untracked | Restore an exact committed migration first |
| Migration reports error | Do not retry; inspect ledger/postflight read-only |
| Wrong branch uncertainty | Stop and verify Neon dashboard target |

## Gate 02 order

```text
connection proof
→ Gate 02 preflight
→ exact committed migration once
→ Gate 02 postflight
→ runtime readiness proof
→ authorized Git/Render deployment
→ health checks
→ only then a controlled Sync action
```

No script in this collection triggers Sync, enrollment, revocation, or replay.

## Maintenance rule

Treat variable and action names as an interface. When one changes, search all
five files and update every reference in the same commit:

```powershell
rg "NEON_CHECK|NEON_ACTION|NEON_CRED|gate02|markei_" documentation
```
