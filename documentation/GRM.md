# Markei Operational Grimoire

## 1. Purpose

The GRIMOIRE is Markei's concise, human-supervised operational entrypoint.
Each active `GRM-*` block summons exactly one canonical `GS-*` procedure.
Operational logic, variable requests, database queries, and expected results do
not live in the invocation block.

```text
human copies one GRM-* block
→ NEON_CHECK.ps1 dispatches one exact GS-* procedure
→ GS-* loads reviewed NS_COORDINATES values
→ GS-* requests only missing secret or operation-specific input
→ GS-* calls PowerShell and/or one DB_MGMT automation query
→ sanitized evidence returns to the human
→ the human stops on any mismatch
```

The interface is hemi-automated. Scripts own mechanical execution; the human
owns target confirmation, interpretation, and mutation authority.

### 1.1 Ordered command glossary

This is the complete active command sequence. Select the `GRM-*` code here,
then copy its fenced block from `GRM_INDEX` below. Procedure details remain in
the matching `GS-*` section of `G_SCRIPTS.md`.

| Code              | Name                                    |
| ----------------- | --------------------------------------- |
| `GRM-NEON-00`     | Guided Neon role/action selection       |
| `GRM-NEON-01`     | Migrator connection proof               |
| `GRM-NEON-02`     | Migrator psql terminal                  |
| `GRM-NEON-03`     | Runtime psql terminal                   |
| `GRM-NEON-04`     | Gate 02 postflight verification         |
| `GRM-NEON-05`     | Migration-ledger inspection             |
| `GRM-NEON-06`     | Schema and RLS inspection               |
| `GRM-NEON-07`     | Runtime-privilege inspection            |
| `GRM-NEON-08`     | Sanitized Device inventory              |
| `GRM-NEON-09`     | Exact Device-counter verification       |
| `GRM-NEON-10`     | Runtime readiness-v2 verification       |
| `GRM-NEON-11`     | Atomic provider baseline                |
| `GRM-GIT-01`      | Exact Git-alignment verification        |
| `GRM-GIT-02`      | Fast-forward pull and verification      |
| `GRM-SQLITE-01`   | Local SQLite CLI verification           |
| `GRM-SQLITE-02`   | Verified Gate 12.6 copy creation        |
| `GRM-SQLITE-03`   | Sanitized classification probe          |
| `GRM-SQLITE-04`   | Sanitized scope-correlation probe       |
| `GRM-HOST-01`     | Render live/ready verification          |
| `GRM-AUTH-01`     | Auth0 public-metadata verification      |
| `GRM-AUTH-02`     | Exact hosted Auth0-binding verification |
| `GRM-BUILD-01`    | Sync API validation                     |
| `GRM-BUILD-02`    | Flutter-client validation               |
| `GRM-FLUTTER-WIN` | Windows Closure build/run               |
| `GRM-FLUTTER-AND` | Android Closure build/install/run       |

## 2. Canonical five-file system

| File                              | Single responsibility                                                 |
| --------------------------------- | --------------------------------------------------------------------- |
| `documentation/GRM.md`            | Concise `GRM-*` invocation index and safety boundary                  |
| `documentation/G_SCRIPTS.md`      | Canonical expanded `GS-*` procedures, inputs, expectations, and stops |
| `documentation/NS_COORDINATES.md` | Reviewed non-secret coordinate allowlist                              |
| `documentation/NEON_CHECK.ps1`    | `GS-*` dispatcher plus guarded Neon/Docker/psql launcher              |
| `documentation/DB_MGMT.sql`       | Manual SQL library and indexed automation-query catalogue             |

`DB_MGMT.sql` replaces the former singular `NEON_ACTION.sql`. Historical
references to `NEON_ACTION.sql` or `NEON_ACTIONS.sql` in J and Git remain
observational history; they are not live interfaces.

## 3. Interface cascade

| Identifier   | Owner          | Responsibility                                               |
| ------------ | -------------- | ------------------------------------------------------------ |
| `GRM-*`      | `GRM.md`       | Human-selectable invocation only                             |
| `GS-*`       | `G_SCRIPTS.md` | Complete operational procedure                               |
| `DBM-MAN-*`  | `DB_MGMT.sql`  | Manually copied, read-only SQL for the named database client |
| `DBM-AUTO-*` | `DB_MGMT.sql`  | SQL extracted by an automated `GS-*`/launcher path           |

Example:

```text
GRM-NEON-04
→ NEON_CHECK.ps1 -Procedure GS-NEON-04
→ G_SCRIPTS.md / GS-NEON-04
→ NEON_CHECK.ps1 -Action gate02-postflight
→ DB_MGMT.sql / DBM-AUTO-03
```

The outer dispatcher does not contact a provider. It only finds one exact
`GS-*` heading and executes that heading's PowerShell fence. The selected
`GS-*` body owns subsequent coordinates, prompts, commands, and database
selection.

## 4. Input and query placement protocol

- `GRM-*` bodies contain only a stable `GS-*` invocation.
- `GS-*` owns target guards, non-secret coordinate loading, runtime prompts,
  commands, expected evidence, and stop conditions.
- `NS_COORDINATES.md` owns only reviewed non-secret values.
- `DB_MGMT.sql / DBM-MAN-*` owns common manual PostgreSQL/SQLite verification
  queries that have no repository variable dependency.
- `DB_MGMT.sql / DBM-AUTO-*` owns reusable SQL selected by automated
  procedures.
- `NEON_CHECK.ps1` owns exact GS dispatch, secure password handling, guarded
  Docker/psql execution, and automation-block extraction.

Exceptions require an operational reason. If a GRM block starts requesting
variables or reproducing a GS procedure, move that logic down the cascade.

## 5. SQL management boundary

`DB_MGMT.sql` is a mixed-dialect catalogue and must never be executed as one
script.

Its two sections are:

```text
## MANUAL SQL MGMT ##
    DBM-MAN-PG-*      Neon SQL Editor, remote psql, or local PostgreSQL
    DBM-MAN-SQLITE-*  sqlite3 against an explicitly selected safe target

### AUTOMATION QUERIES ###
    DBM-AUTO-*        extracted between ACTION / END ACTION markers
```

Prefer the matching `GRM-*`/`GS-*` procedure whenever one exists. Manual blocks
are for direct inspection when Main or the human explicitly chooses the target
and client. SQLite Gate 12.6 procedures continue to query only the verified
copy, never the live Markei database.

## 6. Coordinate and secret policy

`NS_COORDINATES.md` may contain public origins, branch names, paths, runtime
versions, database/role names without passwords, and other reviewed non-secret
coordinates.

Never commit:

- passwords, tokens, client secrets, API keys, private keys, cookies, or
  authorization headers;
- complete database URLs or secret-bearing URLs;
- real user subjects or account/device/submission/event identifiers;
- payloads, provider environment dumps, or unsafe terminal transcripts.

Secrets remain outside Git and are entered only through masked, session-only
prompts in the selected `GS-*` procedure.

## 7. Operating rules

1. Run active `GRM-*` blocks from the repository root.
2. Copy the whole fenced block and change nothing inside it.
3. Read the matching `GS-*` section before any provider mutation.
4. Confirm development targets independently before provider work.
5. Stop on branch, role, database, TLS, version, identity, schema, or evidence
   mismatch.
6. Never rerun a migration merely because its first output was unclear.
7. Keep Retry, ordinary Sync, provider mutation, and database repair outside
   Gate 12.6 unless a later authorization packet explicitly enables them.

The dispatcher form is process-scoped and does not permanently alter PowerShell
execution policy:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -Procedure "GS-NEON-01"
```

## 8. Failure classes

| Failure                                              | Terminal response                                      |
| ---------------------------------------------------- | ------------------------------------------------------ |
| GS procedure missing or without a PowerShell fence   | Stop; repair catalogue mapping                         |
| Coordinate placeholder or target ambiguity           | Stop; verify only the missing non-secret value         |
| Docker/SQLite/tool unavailable                       | Stop; restore the named prerequisite                   |
| Provider identity or database mismatch               | Stop; do not continue to the selected action           |
| TLS/channel-binding/PostgreSQL-version mismatch      | Stop; do not open a shell or mutate                    |
| Migration dirty, untracked, or failed                | Stop; inspect ledger/postflight read-only              |
| Auth0/Render/Neon mismatch                           | Stop before authenticated request, deployment, or Sync |
| Multiple local databases or SQLite sidecar ambiguity | Stop; do not guess or query live data                  |
| Copied-database integrity failure                    | Stop; do not query, repair, Retry, or Sync             |

## 9. Maintenance contract

When the cascade changes, reconcile together:

1. the `GRM-*` ID;
2. its exact `GS-*` heading and PowerShell fence;
3. any `NS_COORDINATES` keys;
4. any `DBM-AUTO-*` ID and `ACTION` name;
5. `NEON_CHECK.ps1` `ValidateSet` and `$Actions`;
6. safety and expected-result text in `G_SCRIPTS.md`.

Required static checks include:

```powershell
rg "GRM-|GS-|DBM-MAN-|DBM-AUTO-|NS_COORDINATES|NEON_CHECK|DB_MGMT" `
  documentation\GRM.md `
  documentation\G_SCRIPTS.md `
  documentation\NS_COORDINATES.md `
  documentation\NEON_CHECK.ps1 `
  documentation\DB_MGMT.sql
```

Historical names may remain inside append-only J. They must not remain in the
live five-file interface.

---

<!-- LANDLINE: GRM_INDEX -->

## GRM_INDEX

Copy only the fenced block for the selected ID. Inputs, expectations, and stops
are canonical in the mapped `GS-*` section.

**Neon and PostgreSQL**

| GRM ID        | Canonical procedure | Function                          |
| ------------- | ------------------- | --------------------------------- |
| `GRM-NEON-00` | `GS-NEON-00`        | Guided Neon role/action selection |
| `GRM-NEON-01` | `GS-NEON-01`        | Prove migrator connection         |
| `GRM-NEON-02` | `GS-NEON-02`        | Open migrator psql                |
| `GRM-NEON-03` | `GS-NEON-03`        | Open runtime psql                 |
| `GRM-NEON-04` | `GS-NEON-04`        | Verify Gate 02 postflight         |
| `GRM-NEON-05` | `GS-NEON-05`        | Inspect migration ledger          |
| `GRM-NEON-06` | `GS-NEON-06`        | Inspect schema and RLS            |
| `GRM-NEON-07` | `GS-NEON-07`        | Inspect runtime privileges        |
| `GRM-NEON-08` | `GS-NEON-08`        | List devices without UUIDs        |
| `GRM-NEON-09` | `GS-NEON-09`        | Verify exact device counters      |
| `GRM-NEON-10` | `GS-NEON-10`        | Verify runtime readiness-v2       |
| `GRM-NEON-11` | `GS-NEON-11`        | Capture atomic provider baseline  |

### `GRM-NEON-00`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-00"
```

### `GRM-NEON-01`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-01"
```

### `GRM-NEON-02`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-02"
```

### `GRM-NEON-03`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-03"
```

### `GRM-NEON-04`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-04"
```

### `GRM-NEON-05`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-05"
```

### `GRM-NEON-06`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-06"
```

### `GRM-NEON-07`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-07"
```

### `GRM-NEON-08`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-08"
```

### `GRM-NEON-09`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-09"
```

### `GRM-NEON-10`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-10"
```

### `GRM-NEON-11`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-NEON-11"
```

**Git alignment**

| GRM ID       | Canonical procedure | Function                     |
| ------------ | ------------------- | ---------------------------- |
| `GRM-GIT-01` | `GS-GIT-01`         | Verify exact Git alignment   |
| `GRM-GIT-02` | `GS-GIT-02`         | Fast-forward pull and verify |

### `GRM-GIT-01`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-GIT-01"
```

### `GRM-GIT-02`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-GIT-02"
```

**Local SQLite**

| GRM ID          | Canonical procedure | Function                              |
| --------------- | ------------------- | ------------------------------------- |
| `GRM-SQLITE-01` | `GS-SQLITE-01`      | Verify local SQLite CLI               |
| `GRM-SQLITE-02` | `GS-SQLITE-02`      | Create verified Gate 12.6 copy        |
| `GRM-SQLITE-03` | `GS-SQLITE-03`      | Run sanitized classification probe    |
| `GRM-SQLITE-04` | `GS-SQLITE-04`      | Run sanitized scope-correlation probe |

### `GRM-SQLITE-01`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-SQLITE-01"
```

### `GRM-SQLITE-02`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-SQLITE-02"
```

### `GRM-SQLITE-03`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-SQLITE-03"
```

### `GRM-SQLITE-04`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-SQLITE-04"
```

**Hosted service and Auth0**

| GRM ID        | Canonical procedure | Function                            |
| ------------- | ------------------- | ----------------------------------- |
| `GRM-HOST-01` | `GS-HOST-01`        | Verify Render live and ready        |
| `GRM-AUTH-01` | `GS-AUTH-01`        | Verify Auth0 public metadata        |
| `GRM-AUTH-02` | `GS-AUTH-02`        | Verify exact account/Device binding |

### `GRM-HOST-01`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-HOST-01"
```

### `GRM-AUTH-01`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-AUTH-01"
```

### `GRM-AUTH-02`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-AUTH-02"
```

**Validation and Flutter clients**

| GRM ID            | Canonical procedure | Function                          |
| ----------------- | ------------------- | --------------------------------- |
| `GRM-BUILD-01`    | `GS-BUILD-01`       | Validate Sync API                 |
| `GRM-BUILD-02`    | `GS-BUILD-02`       | Validate Flutter clients          |
| `GRM-FLUTTER-WIN` | `GS-FLUTTER-WIN`    | Build/run Windows Closure         |
| `GRM-FLUTTER-AND` | `GS-FLUTTER-AND`    | Build/install/run Android Closure |

### `GRM-BUILD-01`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-BUILD-01"
```

### `GRM-BUILD-02`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-BUILD-02"
```

### `GRM-FLUTTER-WIN`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-FLUTTER-WIN"
```

### `GRM-FLUTTER-AND`

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\NEON_CHECK.ps1" -Procedure "GS-FLUTTER-AND"
```
