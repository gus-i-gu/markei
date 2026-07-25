# Markei General Scripts

> Canonical executable catalogue for the human-supervised GRIMOIRE interface.
> Repository: `gus-i-gu/markei`; branch: `cycle10-intermid-grimoire`.

## 0. Execution contract

```text
GRIMOIRE_INDEX block
→ canonical GS-* procedure in this file
→ NS_COORDINATES.md supplies non-secret values
→ terminal requests only the remaining role/UUID/secret input
→ reviewed PowerShell or SQL performs the operation
→ sanitized result returns to the operator
```

Keep this active five-file set together:

```text
documentation/GRIMOIRE.md
documentation/G_SCRIPTS.md
documentation/NS_COORDINATES.md
documentation/NEON_CHECK.ps1
documentation/NEON_ACTION.sql
```

Unless a procedure states otherwise, run PowerShell commands from anywhere
inside the repository. Active self-navigating procedures resolve the repository
root, enter the required package or data location, and return the terminal to
the repository root in `finally`. `G_SCRIPTS.md` remains a Markdown catalogue;
it is not renamed to `.ps1` and is not passed directly to PowerShell's `-File`
parameter. A `GRIMOIRE_INDEX` block may load one exact reviewed `GS-*` heading
and execute its fenced PowerShell body. When no indexed loader is provided,
copy only a complete fenced code body. Do not replace values already supplied
by `NS_COORDINATES.md`.

The canonical Neon launcher form is process-scoped and does not permanently
alter PowerShell execution policy:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role <runtime|migrator|dbowner> `
  -Action <action>
```

Passwords are requested through `Read-Host -AsSecureString`, converted only
for the current process/container call, and cleared in `finally`.

## 1. Neon terminal and read-only actions

Requirements: Windows PowerShell, Docker Desktop running, access to the
`postgres:18-alpine` image, and verified non-secret Neon coordinates. Local
`psql` is not required.

### `GS-NEON-00` — Guided role/action launcher

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md"
```

The terminal requests the role number, action number, and selected role
password. An action-specific UUID or confirmation is requested only when
required.

### `GS-NEON-01` — Migrator connection proof

Canonical SQL block: `NEON_ACTION.sql` → `NA-01` / `connection`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action connection
```

### `GS-NEON-02` — Open migrator psql

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action shell
```

Exit `psql` with `\q`.

### `GS-NEON-03` — Open runtime psql

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role runtime `
  -Action shell
```

Exit `psql` with `\q`.

### `GS-NEON-04` — Gate 02 postflight

Canonical SQL block: `NEON_ACTION.sql` → `NA-03` /
`gate02-postflight`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action gate02-postflight
```

Required current result:

- migration `007_account_cursor_provisioning` exists with checksum
  `c10-mcg02-account-cursor-provisioning-v1`;
- readiness-v2 is true;
- provisioning function exists and trigger count is `1`;
- missing/orphan cursor-state counts are `0`;
- runtime `SELECT=true`, `INSERT=false`, `DELETE=false`;
- runtime can update only `next_cursor`;
- runtime can execute readiness-v2 but not provisioning;
- transaction ends with `ROLLBACK`; action ends with `PASS`.

### `GS-NEON-05` — Migration ledger

Canonical SQL block: `NEON_ACTION.sql` → `NA-04` /
`migration-ledger`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action migration-ledger
```

### `GS-NEON-06` — Schema and RLS inventory

Canonical SQL block: `NEON_ACTION.sql` → `NA-06` /
`schema-inventory`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action schema-inventory
```

### `GS-NEON-07` — Runtime privilege inventory

Canonical SQL block: `NEON_ACTION.sql` → `NA-05` /
`runtime-privileges`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action runtime-privileges
```

### `GS-NEON-08` — Sanitized device inventory

Canonical SQL block: `NEON_ACTION.sql` → `NA-07` /
`list-devices-sanitized`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action list-devices-sanitized
```

### `GS-NEON-09` — Verify one device's counters

Canonical SQL block: `NEON_ACTION.sql` → `NA-08` / `verify-device`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action verify-device
```

The terminal requests the device UUID locally. It is passed as a `psql`
variable, not written to any repository file.

### `GS-NEON-10` — Runtime readiness-v2 query

Run only inside the runtime `psql` opened by `GS-NEON-03`:

```sql
BEGIN TRANSACTION READ ONLY;
SELECT
    current_user AS connected_role,
    current_database() AS connected_database,
    public.markei_hosted_runtime_ready_v2() AS ready;
ROLLBACK;
```

Expected: `markei_runtime`, `markei_sync_dev`, `ready = t`, and `ROLLBACK`.

### `GS-NEON-11` — Capture the atomic provider baseline

Canonical SQL block: `NEON_ACTION.sql` → `NA-09` /
`provider-baseline`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action provider-baseline
```

The terminal requests the exact fixture Device UUID locally and the current
migrator password through masked prompts. The UUID is passed only as a `psql`
variable. The action opens one `REPEATABLE READ`, read-only transaction and
returns:

- exact global counts for `accounts`, `devices`, `account_cursor_state`,
  `submissions`, `sync_events`, and `device_acknowledgements`;
- missing/orphan cursor-state counts;
- fixture-account six-table counts and sanitized Device state;
- Account cursor/hosted-high-water consistency;
- Device sequence/high-water consistency;
- truncated submission/request and event/content replay fingerprints;
- explicit `ROLLBACK` and final launcher `PASS`.

The action fails closed if the UUID does not identify exactly one provider
Device. It returns no UUID, Account identifier, payload, stored result, full
hash, password, or connection string. `PASS` proves successful read-only
execution only; Gate 12.5 closes only after the values are reconciled against
the accepted 12.5a–c evidence.

## 2. Git alignment

### `GS-GIT-01` — Verify exact branch/remote alignment

This procedure reads `RepositoryBranch` from `NS_COORDINATES.md`, requires a
clean worktree, stops on branch or SHA divergence, and returns the terminal to
the repository root. The divergence result is split on arbitrary whitespace so
PowerShell cannot mistake Git's tab-separated `0 0` result for divergence.

```powershell
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$RepositoryRoot = (& git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0 -or
    [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
    throw "Run this command from inside the Markei repository."
}

try {
    Set-Location -LiteralPath $RepositoryRoot
    $NsPath = Join-Path $RepositoryRoot "documentation\NS_COORDINATES.md"
    $NsText = Get-Content -LiteralPath $NsPath -Raw

    function Get-NsCoordinate {
        param([Parameter(Mandatory)] [string]$Name)
        $Matches = [regex]::Matches(
            $NsText,
            "(?m)^$([regex]::Escape($Name)):\s*(.*?)\s*$"
        )
        if ($Matches.Count -ne 1) {
            throw "Expected exactly one '$Name' coordinate in $NsPath."
        }
        $Value = $Matches[0].Groups[1].Value.Trim()
        if ([string]::IsNullOrWhiteSpace($Value) -or
            $Value -match '^<[^>]+>$') {
            throw "Replace the '$Name' placeholder in $NsPath."
        }
        return $Value
    }

    $ExpectedBranch = Get-NsCoordinate "RepositoryBranch"
    $CurrentBranch = (& git branch --show-current).Trim()
    if ($LASTEXITCODE -ne 0 -or $CurrentBranch -ne $ExpectedBranch) {
        throw "Expected branch '$ExpectedBranch'; found '$CurrentBranch'."
    }

    $Dirty = @(& git status --porcelain)
    if ($LASTEXITCODE -ne 0 -or $Dirty.Count -ne 0) {
        throw "Working tree is not clean."
    }

    & git fetch --prune origin
    if ($LASTEXITCODE -ne 0) {
        throw "git fetch failed."
    }

    $LocalSha = (& git rev-parse HEAD).Trim()
    if ($LASTEXITCODE -ne 0) { throw "Could not read local HEAD." }
    $RemoteSha = (& git rev-parse "origin/$ExpectedBranch").Trim()
    if ($LASTEXITCODE -ne 0) { throw "Could not read remote HEAD." }
    $DivergenceRaw = (& git rev-list --left-right --count `
        "origin/$ExpectedBranch...HEAD").Trim()
    if ($LASTEXITCODE -ne 0) {
        throw "Could not calculate branch divergence."
    }
    $Divergence = @($DivergenceRaw -split '\s+')

    if ($Divergence.Count -ne 2 -or
        $Divergence[0] -ne "0" -or
        $Divergence[1] -ne "0" -or
        $LocalSha -ne $RemoteSha) {
        throw "Local and remote branch state diverged."
    }

    [pscustomobject]@{
        Branch = $CurrentBranch
        LocalHead = $LocalSha
        RemoteHead = $RemoteSha
        Behind = [int]$Divergence[0]
        Ahead = [int]$Divergence[1]
        Worktree = "clean"
    }
}
finally {
    Set-Location -LiteralPath $RepositoryRoot
}
```

### `GS-GIT-02` — Fast-forward pull and verify exact alignment

This procedure reads `RepositoryBranch` from `NS_COORDINATES.md`, requires the
correct branch and a clean worktree, fetches `origin`, performs only a
fast-forward pull, and then applies the same exact SHA and whitespace-safe
divergence checks as `GS-GIT-01`.

```powershell
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$RepositoryRoot = (& git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0 -or
    [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
    throw "Run this command from inside the Markei repository."
}

try {
    Set-Location -LiteralPath $RepositoryRoot
    $NsPath = Join-Path $RepositoryRoot "documentation\NS_COORDINATES.md"
    $NsText = Get-Content -LiteralPath $NsPath -Raw
    $BranchMatches = [regex]::Matches(
        $NsText,
        "(?m)^RepositoryBranch:\s*(.*?)\s*$"
    )
    if ($BranchMatches.Count -ne 1) {
        throw "Expected exactly one RepositoryBranch coordinate."
    }
    $ExpectedBranch = $BranchMatches[0].Groups[1].Value.Trim()
    if ([string]::IsNullOrWhiteSpace($ExpectedBranch) -or
        $ExpectedBranch -match '^<[^>]+>$') {
        throw "Replace the RepositoryBranch placeholder."
    }

    $CurrentBranch = (& git branch --show-current).Trim()
    if ($LASTEXITCODE -ne 0 -or $CurrentBranch -ne $ExpectedBranch) {
        throw "Expected branch '$ExpectedBranch'; found '$CurrentBranch'."
    }
    $Dirty = @(& git status --porcelain)
    if ($LASTEXITCODE -ne 0 -or $Dirty.Count -ne 0) {
        throw "Working tree is not clean."
    }

    & git fetch --prune origin
    if ($LASTEXITCODE -ne 0) { throw "git fetch failed." }
    & git pull --ff-only origin $ExpectedBranch
    if ($LASTEXITCODE -ne 0) { throw "Fast-forward pull failed." }

    $LocalSha = (& git rev-parse HEAD).Trim()
    if ($LASTEXITCODE -ne 0) { throw "Could not read local HEAD." }
    $RemoteSha = (& git rev-parse "origin/$ExpectedBranch").Trim()
    if ($LASTEXITCODE -ne 0) { throw "Could not read remote HEAD." }
    $DivergenceRaw = (& git rev-list --left-right --count `
        "origin/$ExpectedBranch...HEAD").Trim()
    if ($LASTEXITCODE -ne 0) {
        throw "Could not calculate branch divergence."
    }
    $Divergence = @($DivergenceRaw -split '\s+')

    if ($Divergence.Count -ne 2 -or
        $Divergence[0] -ne "0" -or
        $Divergence[1] -ne "0" -or
        $LocalSha -ne $RemoteSha) {
        throw "Pull completed but exact alignment did not pass."
    }

    [pscustomobject]@{
        Branch = $CurrentBranch
        LocalHead = $LocalSha
        RemoteHead = $RemoteSha
        Behind = [int]$Divergence[0]
        Ahead = [int]$Divergence[1]
        Worktree = "clean"
        PullMode = "ff-only"
    }
}
finally {
    Set-Location -LiteralPath $RepositoryRoot
}
```

## 3. Local SQLite diagnostics

These procedures operate only on the Windows application database used by the
Flutter client. The database file and the SQLite command-line program are
different objects: finding `markei_shared_beta.sqlite` does not prove that
`sqlite3.exe` is installed or discoverable.

The diagnostic sequence is:

```text
GS-SQLITE-01
→ GS-SQLITE-02
→ GS-SQLITE-03
```

Keep Markei closed throughout `GS-SQLITE-02` and `GS-SQLITE-03`. These
procedures never press Enroll, Query, Retry, or Sync and never contact Auth0,
Render, or Neon.

### `GS-SQLITE-01` — Verify the SQLite CLI

This procedure searches `PATH`, WinGet's portable-command link, and the local
WinGet package directory. It prints no executable path. If the CLI is absent,
install package `SQLite.SQLite`, open a fresh PowerShell terminal, and rerun
this procedure.

```powershell
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$RepositoryRoot = (& git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0 -or
    [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
    throw "Run this command from inside the Markei repository."
}

try {
    Set-Location -LiteralPath $RepositoryRoot

    function Resolve-MarkeiSqliteCli {
        $PathCommand = Get-Command sqlite3.exe `
            -CommandType Application `
            -ErrorAction SilentlyContinue
        if ($null -ne $PathCommand) {
            return [pscustomobject]@{
                Source = $PathCommand.Source
                Discovery = "PATH"
            }
        }

        $Candidates = @()
        if (-not [string]::IsNullOrWhiteSpace($env:LOCALAPPDATA)) {
            $WinGetLink = Join-Path $env:LOCALAPPDATA `
                "Microsoft\WinGet\Links\sqlite3.exe"
            if (Test-Path -LiteralPath $WinGetLink -PathType Leaf) {
                $Candidates += Get-Item -LiteralPath $WinGetLink
            }

            $PackageRoot = Join-Path $env:LOCALAPPDATA `
                "Microsoft\WinGet\Packages"
            if (Test-Path -LiteralPath $PackageRoot -PathType Container) {
                $Candidates += Get-ChildItem `
                    -LiteralPath $PackageRoot `
                    -Directory `
                    -Filter "SQLite.SQLite_*" `
                    -ErrorAction SilentlyContinue |
                    ForEach-Object {
                        Get-ChildItem `
                            -LiteralPath $_.FullName `
                            -Filter "sqlite3.exe" `
                            -File `
                            -Recurse `
                            -ErrorAction SilentlyContinue
                    }
            }
        }

        $Selected = @(
            $Candidates |
                Sort-Object LastWriteTime -Descending |
                Select-Object -First 1
        )
        if ($Selected.Count -ne 1) {
            throw @"
sqlite3.exe is unavailable.
Install it with:
winget install --exact --id SQLite.SQLite --accept-package-agreements --accept-source-agreements
Then open a fresh PowerShell terminal and rerun GS-SQLITE-01.
"@
        }
        return [pscustomobject]@{
            Source = $Selected[0].FullName
            Discovery = "WinGet"
        }
    }

    $Sqlite = Resolve-MarkeiSqliteCli
    $VersionOutput = (& $Sqlite.Source --version 2>&1 | Out-String).Trim()
    if ($LASTEXITCODE -ne 0 -or
        [string]::IsNullOrWhiteSpace($VersionOutput)) {
        throw "sqlite3.exe did not return a version."
    }

    [pscustomobject]@{
        SQLiteAvailable = $true
        Discovery = $Sqlite.Discovery
        Version = ($VersionOutput -split '\s+')[0]
        InstallRequired = $false
        TerminalLocation = $RepositoryRoot
    }
}
finally {
    Set-Location -LiteralPath $RepositoryRoot
}
```

### `GS-SQLITE-02` — Create and verify the Gate 12.6 copy

This procedure fails if a Markei/Flutter/Dart process or SQLite sidecar is
present, requires exactly one `markei_shared_beta.sqlite` below the current
user's application-data roots, and creates one hash-verified copy in a fixed
temporary probe directory. It does not open or query the live database and
prints neither its private path nor either SHA-256 value.

```powershell
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$RepositoryRoot = (& git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0 -or
    [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
    throw "Run this command from inside the Markei repository."
}

try {
    Set-Location -LiteralPath $RepositoryRoot

    $ActiveProcesses = @(
        Get-Process -ErrorAction SilentlyContinue |
            Where-Object {
                $_.ProcessName -in @(
                    "markei",
                    "markei_flutter",
                    "flutter",
                    "dart"
                )
            }
    )
    if ($ActiveProcesses.Count -ne 0) {
        $ActiveProcesses |
            Select-Object ProcessName, Id |
            Format-Table -AutoSize
        throw "Close Markei and its Flutter run terminal before copying."
    }

    $SearchRoots = @(
        $env:APPDATA
        $env:LOCALAPPDATA
    ) |
        Where-Object {
            -not [string]::IsNullOrWhiteSpace($_) -and
            (Test-Path -LiteralPath $_ -PathType Container)
        } |
        Select-Object -Unique
    if ($SearchRoots.Count -eq 0) {
        throw "No Windows application-data search roots are available."
    }

    $DatabaseCandidates = @(
        foreach ($Root in $SearchRoots) {
            Get-ChildItem `
                -LiteralPath $Root `
                -Filter "markei_shared_beta.sqlite" `
                -File `
                -Recurse `
                -ErrorAction SilentlyContinue
        }
    ) |
        Sort-Object FullName -Unique
    $DatabaseCandidates = @($DatabaseCandidates)

    if ($DatabaseCandidates.Count -ne 1) {
        [pscustomobject]@{
            DatabaseCandidateCount = $DatabaseCandidates.Count
        }
        throw "Expected exactly one Markei database; do not guess."
    }

    $LiveDatabase = $DatabaseCandidates[0].FullName
    $Sidecars = @(
        "$LiveDatabase-wal"
        "$LiveDatabase-shm"
    ) | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf }
    if ($Sidecars.Count -ne 0) {
        throw "A SQLite WAL/SHM sidecar remains. Keep Markei closed and stop."
    }

    $ProbeDirectory = Join-Path `
        ([System.IO.Path]::GetTempPath()) `
        "markei-gate-12-6-current"
    if (Test-Path -LiteralPath $ProbeDirectory) {
        throw @"
The current Gate 12.6 probe directory already exists.
Do not overwrite it. Preserve it for interpretation or remove it only after
explicit cleanup authorization, then rerun GS-SQLITE-02.
"@
    }
    New-Item `
        -ItemType Directory `
        -Path $ProbeDirectory `
        -ErrorAction Stop |
        Out-Null

    $CopiedDatabase = Join-Path `
        $ProbeDirectory `
        "markei_gate_12_6_copy.sqlite"
    Copy-Item `
        -LiteralPath $LiveDatabase `
        -Destination $CopiedDatabase `
        -ErrorAction Stop

    $SourceInfo = Get-Item -LiteralPath $LiveDatabase
    $CopyInfo = Get-Item -LiteralPath $CopiedDatabase
    $SourceHash = (
        Get-FileHash -LiteralPath $LiveDatabase -Algorithm SHA256
    ).Hash
    $CopyHash = (
        Get-FileHash -LiteralPath $CopiedDatabase -Algorithm SHA256
    ).Hash
    $SizeMatches = $SourceInfo.Length -eq $CopyInfo.Length
    $HashMatches = $SourceHash -eq $CopyHash
    if (-not $SizeMatches -or -not $HashMatches) {
        throw "Database-copy verification failed."
    }

    [pscustomobject]@{
        MarkeiClosed = $true
        DatabaseCandidateCount = 1
        DatabaseName = $DatabaseCandidates[0].Name
        DatabaseSizeBytes = $DatabaseCandidates[0].Length
        DatabaseModified = $DatabaseCandidates[0].LastWriteTime
        SidecarCount = 0
        CopyCreated = $true
        SizeMatches = $SizeMatches
        HashMatches = $HashMatches
        HashValuesPrinted = $false
        LiveDatabaseQueried = $false
        ProbeDirectoryName = Split-Path $ProbeDirectory -Leaf
        TerminalLocation = $RepositoryRoot
    }
}
finally {
    Set-Location -LiteralPath $RepositoryRoot
}
```

### `GS-SQLITE-03` — Run the sanitized Gate 12.6 probe

This procedure opens only the fixed copied database created by
`GS-SQLITE-02`, uses both SQLite `-readonly` and `PRAGMA query_only = ON`,
checks integrity and required schema, then reports sanitized state,
classification, membership, sequence, and recent-attempt fields. It never
selects identifiers, payloads, complete hashes, product/purchase content,
provider configuration, tokens, URLs, or private paths.

```powershell
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$RepositoryRoot = (& git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0 -or
    [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
    throw "Run this command from inside the Markei repository."
}

try {
    Set-Location -LiteralPath $RepositoryRoot

    function Resolve-MarkeiSqliteCli {
        $PathCommand = Get-Command sqlite3.exe `
            -CommandType Application `
            -ErrorAction SilentlyContinue
        if ($null -ne $PathCommand) {
            return $PathCommand.Source
        }

        $Candidates = @()
        if (-not [string]::IsNullOrWhiteSpace($env:LOCALAPPDATA)) {
            $WinGetLink = Join-Path $env:LOCALAPPDATA `
                "Microsoft\WinGet\Links\sqlite3.exe"
            if (Test-Path -LiteralPath $WinGetLink -PathType Leaf) {
                $Candidates += Get-Item -LiteralPath $WinGetLink
            }
            $PackageRoot = Join-Path $env:LOCALAPPDATA `
                "Microsoft\WinGet\Packages"
            if (Test-Path -LiteralPath $PackageRoot -PathType Container) {
                $Candidates += Get-ChildItem `
                    -LiteralPath $PackageRoot `
                    -Directory `
                    -Filter "SQLite.SQLite_*" `
                    -ErrorAction SilentlyContinue |
                    ForEach-Object {
                        Get-ChildItem `
                            -LiteralPath $_.FullName `
                            -Filter "sqlite3.exe" `
                            -File `
                            -Recurse `
                            -ErrorAction SilentlyContinue
                    }
            }
        }
        $Selected = @(
            $Candidates |
                Sort-Object LastWriteTime -Descending |
                Select-Object -First 1
        )
        if ($Selected.Count -ne 1) {
            throw "sqlite3.exe is unavailable. Run GS-SQLITE-01."
        }
        return $Selected[0].FullName
    }

    $SqliteCli = Resolve-MarkeiSqliteCli
    $ProbeDirectory = Join-Path `
        ([System.IO.Path]::GetTempPath()) `
        "markei-gate-12-6-current"
    $CopiedDatabase = Join-Path `
        $ProbeDirectory `
        "markei_gate_12_6_copy.sqlite"
    if (-not (Test-Path -LiteralPath $CopiedDatabase -PathType Leaf)) {
        throw "Verified Gate 12.6 copy not found. Run GS-SQLITE-02."
    }

    $QuickCheck = (
        & $SqliteCli -readonly $CopiedDatabase "PRAGMA quick_check;" 2>&1 |
            Out-String
    ).Trim()
    if ($LASTEXITCODE -ne 0 -or $QuickCheck -ne "ok") {
        throw "Copied-database quick_check did not return exactly 'ok'."
    }

    $ProbeSql = @'
.bail on
.headers on
.mode column
.nullvalue [null]
PRAGMA query_only = ON;
BEGIN;

.print === PROBE_0_SCHEMA ===
SELECT
  SUM(name = 'sync_submissions')       AS sync_submissions,
  SUM(name = 'sync_submission_events') AS sync_submission_events,
  SUM(name = 'pending_events')         AS pending_events,
  SUM(name = 'sync_events')            AS sync_events,
  SUM(name = 'devices')                AS devices,
  SUM(name = 'sync_attempts')           AS sync_attempts
FROM sqlite_master
WHERE type = 'table';

.print === PROBE_1_SUBMISSION_CLASS_COUNTS ===
SELECT
  state,
  COALESCE(outcome, '[null]')       AS outcome,
  COALESCE(response_code, '[null]') AS response_code,
  COALESCE(error_code, '[null]')    AS error_code,
  COUNT(*)                          AS submission_count
FROM sync_submissions
GROUP BY state, outcome, response_code, error_code
ORDER BY state, outcome, response_code, error_code;

.print === PROBE_2_SUBMISSION_MEMBERSHIP ===
WITH submission_summaries AS (
  SELECT
    s.id,
    s.created_at,
    s.state,
    COALESCE(s.outcome, '[null]')       AS outcome,
    COALESCE(s.response_code, '[null]') AS response_code,
    COALESCE(s.error_code, '[null]')    AS error_code,
    COUNT(se.event_id)                  AS member_count,
    MIN(e.device_sequence)              AS first_sequence,
    MAX(e.device_sequence)              AS last_sequence,
    COUNT(DISTINCT pe.state)            AS event_state_kinds,
    COALESCE(MIN(pe.state), '[null]')   AS min_event_state,
    COALESCE(MAX(pe.state), '[null]')   AS max_event_state,
    MIN(se.position)                    AS first_position,
    MAX(se.position)                    AS last_position
  FROM sync_submissions AS s
  LEFT JOIN sync_submission_events AS se
    ON se.submission_id = s.id
  LEFT JOIN sync_events AS e
    ON e.id = se.event_id
  LEFT JOIN pending_events AS pe
    ON pe.event_id = e.id
  GROUP BY
    s.id,
    s.created_at,
    s.state,
    s.outcome,
    s.response_code,
    s.error_code
),
numbered AS (
  SELECT
    ROW_NUMBER() OVER (ORDER BY created_at, id) AS local_submission_number,
    state,
    outcome,
    response_code,
    error_code,
    member_count,
    first_sequence,
    last_sequence,
    event_state_kinds,
    min_event_state,
    max_event_state,
    first_position,
    last_position
  FROM submission_summaries
)
SELECT *
FROM numbered
ORDER BY local_submission_number;

.print === PROBE_3_DEVICE_SEQUENCE_SUMMARY ===
SELECT
  next_sequence,
  COUNT(*) AS device_count
FROM devices
GROUP BY next_sequence
ORDER BY next_sequence;

.print === PROBE_4_PENDING_EVENT_SUMMARY ===
SELECT
  pe.state,
  COUNT(*)               AS event_count,
  MIN(e.device_sequence) AS first_sequence,
  MAX(e.device_sequence) AS last_sequence
FROM pending_events AS pe
JOIN sync_events AS e
  ON e.id = pe.event_id
GROUP BY pe.state
ORDER BY pe.state;

.print === PROBE_5_RECENT_SYNC_ATTEMPTS ===
SELECT
  COALESCE(operation_kind, '[null]') AS operation_kind,
  result_code,
  outcome_class,
  phase,
  COALESCE(recovery_code, '[null]') AS recovery_code,
  CASE
    WHEN http_status IS NULL THEN 0
    ELSE 1
  END AS has_http_status,
  response_headers_received,
  COALESCE(elapsed_band, '[null]') AS elapsed_band
FROM sync_attempts
ORDER BY started_at DESC, id DESC
LIMIT 5;

ROLLBACK;
'@

    $ProbeOutput = $ProbeSql |
        & $SqliteCli -readonly $CopiedDatabase 2>&1
    $ProbeExitCode = $LASTEXITCODE
    $ProbeOutput
    if ($ProbeExitCode -ne 0) {
        throw "The copied-database probe failed."
    }

    Write-Host "SQLiteQuickCheck: ok"
    Write-Host "LiveDatabaseQueried: False"
    Write-Host "RetrySelected: False"
    Write-Host "SyncSelected: False"
    Write-Host "ProviderActionPerformed: False"
    Write-Host "TerminalLocation: $RepositoryRoot"
}
finally {
    Set-Location -LiteralPath $RepositoryRoot
}
```

## 4. Render public health

### `GS-HOST-01` — Verify live and ready contracts

This procedure reads the public origin and route paths from
`NS_COORDINATES.md`. It rejects placeholders, non-HTTPS origins, embedded
credentials, query strings, fragments, redirects, non-200 responses, and
unexpected response classes.

```powershell
$NsPath = Resolve-Path ".\documentation\NS_COORDINATES.md"
$NsText = Get-Content -LiteralPath $NsPath -Raw

function Get-NsCoordinate {
    param([Parameter(Mandatory)] [string]$Name)
    $Match = [regex]::Match(
        $NsText,
        "(?m)^$([regex]::Escape($Name)):\s*(.+?)\s*$"
    )
    if (-not $Match.Success) {
        throw "Missing '$Name' in $NsPath."
    }
    $Value = $Match.Groups[1].Value.Trim()
    if ($Value -match '^<[^>]+>$') {
        throw "Replace the '$Name' placeholder in $NsPath."
    }
    return $Value
}

$Origin = (Get-NsCoordinate "RenderPublicOrigin").TrimEnd("/")
$LivePath = Get-NsCoordinate "RenderLivePath"
$ReadyPath = Get-NsCoordinate "RenderReadyPath"

$OriginUri = $null
if (-not [uri]::TryCreate(
        $Origin,
        [UriKind]::Absolute,
        [ref]$OriginUri
    ) -or
    $OriginUri.Scheme -ne "https" -or
    -not [string]::IsNullOrEmpty($OriginUri.UserInfo) -or
    -not [string]::IsNullOrEmpty($OriginUri.Query) -or
    -not [string]::IsNullOrEmpty($OriginUri.Fragment)) {
    throw "RenderPublicOrigin must be a secret-free HTTPS origin."
}

$OriginBase = [uri]($Origin + "/")
$LiveUri = [uri]::new(
    $OriginBase,
    $LivePath.TrimStart([char]"/")
).AbsoluteUri
$ReadyUri = [uri]::new(
    $OriginBase,
    $ReadyPath.TrimStart([char]"/")
).AbsoluteUri

$LiveResponse = Invoke-WebRequest `
    -UseBasicParsing `
    -Uri $LiveUri `
    -Method Get `
    -MaximumRedirection 0
$ReadyResponse = Invoke-WebRequest `
    -UseBasicParsing `
    -Uri $ReadyUri `
    -Method Get `
    -MaximumRedirection 0

$LiveBody = $LiveResponse.Content | ConvertFrom-Json
$ReadyBody = $ReadyResponse.Content | ConvertFrom-Json
if ([int]$LiveResponse.StatusCode -ne 200 -or
    [int]$ReadyResponse.StatusCode -ne 200 -or
    $LiveBody.status -ne "live" -or
    $ReadyBody.status -ne "ready") {
    throw "Hosted health contract did not pass."
}

[pscustomobject]@{
    Origin = $Origin
    LiveStatus = [int]$LiveResponse.StatusCode
    LiveClass = $LiveBody.status
    ReadyStatus = [int]$ReadyResponse.StatusCode
    ReadyClass = $ReadyBody.status
}
```

## 5. Auth0 public metadata

### `GS-AUTH-01` — Verify OIDC discovery and RS256 JWKS

This procedure reads only public Auth0 coordinates. It never requests or
prints an access token or client secret.

```powershell
$NsPath = Resolve-Path ".\documentation\NS_COORDINATES.md"
$NsText = Get-Content -LiteralPath $NsPath -Raw

function Get-NsCoordinate {
    param([Parameter(Mandatory)] [string]$Name)
    $Match = [regex]::Match(
        $NsText,
        "(?m)^$([regex]::Escape($Name)):\s*(.+?)\s*$"
    )
    if (-not $Match.Success) {
        throw "Missing '$Name' in $NsPath."
    }
    $Value = $Match.Groups[1].Value.Trim()
    if ($Value -match '^<[^>]+>$') {
        throw "Replace the '$Name' placeholder in $NsPath."
    }
    return $Value
}

$Issuer = (Get-NsCoordinate "Auth0Issuer").TrimEnd("/")
$Audience = Get-NsCoordinate "Auth0Audience"
$Algorithm = Get-NsCoordinate "Auth0Algorithm"
$DiscoveryPath = Get-NsCoordinate "Auth0DiscoveryPath"
$JwksPath = Get-NsCoordinate "Auth0JwksPath"

$IssuerUri = $null
if (-not [uri]::TryCreate(
        $Issuer,
        [UriKind]::Absolute,
        [ref]$IssuerUri
    ) -or
    $IssuerUri.Scheme -ne "https" -or
    -not [string]::IsNullOrEmpty($IssuerUri.UserInfo) -or
    -not [string]::IsNullOrEmpty($IssuerUri.Query) -or
    -not [string]::IsNullOrEmpty($IssuerUri.Fragment)) {
    throw "Auth0Issuer must be a secret-free HTTPS URL."
}

$IssuerBase = [uri]($Issuer + "/")
$DiscoveryUri = [uri]::new(
    $IssuerBase,
    $DiscoveryPath.TrimStart([char]"/")
).AbsoluteUri
$JwksUri = [uri]::new(
    $IssuerBase,
    $JwksPath.TrimStart([char]"/")
).AbsoluteUri

$Discovery = Invoke-RestMethod -Method Get -Uri $DiscoveryUri
$Jwks = Invoke-RestMethod -Method Get -Uri $JwksUri

$IssuerMatches = (
    $Discovery.issuer.TrimEnd("/") -eq $Issuer
)
$DiscoveryJwksMatches = (
    $Discovery.jwks_uri.TrimEnd("/") -eq $JwksUri.TrimEnd("/")
)
$MatchingKeys = @($Jwks.keys | Where-Object {
    $_.kty -eq "RSA" -and
    $_.use -eq "sig" -and
    $_.alg -eq $Algorithm
})

if (-not $IssuerMatches -or
    -not $DiscoveryJwksMatches -or
    $Algorithm -ne "RS256" -or
    $MatchingKeys.Count -lt 1) {
    throw "Auth0 public metadata contract did not pass."
}

[pscustomobject]@{
    Issuer = $Issuer
    AudienceCoordinate = $Audience
    IssuerMatches = $IssuerMatches
    DiscoveryJwksMatches = $DiscoveryJwksMatches
    Algorithm = $Algorithm
    MatchingSigningKeys = $MatchingKeys.Count
}
```

This verifies public provider metadata and the configured audience coordinate.
It does not prove that a real token was issued for that audience.

### `GS-AUTH-02` — Verify exact hosted Auth0 binding

This read-only procedure validates one fresh Auth0 user access token against
the committed issuer, audience, and RS256 contract, then asks the deployed API
to authorize the token's membership and one exact enrolled Device. It never
prints the token, subject, Device UUID, authorization header, or response
bodies.

```powershell
$NsPath = Resolve-Path ".\documentation\NS_COORDINATES.md"
$NsText = Get-Content -LiteralPath $NsPath -Raw

function Get-NsCoordinate {
    param([Parameter(Mandatory)] [string]$Name)
    $Match = [regex]::Match(
        $NsText,
        "(?m)^$([regex]::Escape($Name)):\s*(.+?)\s*$"
    )
    if (-not $Match.Success) {
        throw "Missing '$Name' in $NsPath."
    }
    $Value = $Match.Groups[1].Value.Trim()
    if ($Value -match '^<[^>]+>$') {
        throw "Replace the '$Name' placeholder in $NsPath."
    }
    return $Value
}

function ConvertFrom-Base64UrlJson {
    param([Parameter(Mandatory)] [string]$Segment)
    $Base64 = $Segment.Replace("-", "+").Replace("_", "/")
    switch ($Base64.Length % 4) {
        0 { }
        2 { $Base64 += "==" }
        3 { $Base64 += "=" }
        default { throw "JWT contains invalid base64url." }
    }
    try {
        $Json = [Text.Encoding]::UTF8.GetString(
            [Convert]::FromBase64String($Base64)
        )
        return $Json | ConvertFrom-Json
    }
    catch {
        throw "JWT header or payload is not valid encoded JSON."
    }
}

function Invoke-SanitizedGet {
    param(
        [Parameter(Mandatory)] [uri]$Uri,
        [Parameter(Mandatory)] [hashtable]$Headers,
        [Parameter(Mandatory)] [string]$Label
    )
    try {
        return Invoke-WebRequest `
            -UseBasicParsing `
            -Uri $Uri `
            -Method Get `
            -Headers $Headers `
            -MaximumRedirection 0
    }
    catch {
        $Status = $null
        if ($null -ne $_.Exception.Response) {
            $Status = [int]$_.Exception.Response.StatusCode
        }
        if ($null -ne $Status) {
            throw "$Label rejected the request with HTTP $Status."
        }
        throw "$Label could not be verified."
    }
}

$Origin = (Get-NsCoordinate "RenderPublicOrigin").TrimEnd("/")
$IdentityPath = Get-NsCoordinate "RenderIdentityPath"
$Issuer = (Get-NsCoordinate "Auth0Issuer").TrimEnd("/")
$Audience = Get-NsCoordinate "Auth0Audience"
$Algorithm = Get-NsCoordinate "Auth0Algorithm"
$DeviceHeaderName = Get-NsCoordinate "DeviceHeaderName"

$OriginUri = $null
if (-not [uri]::TryCreate(
        $Origin,
        [UriKind]::Absolute,
        [ref]$OriginUri
    ) -or
    $OriginUri.Scheme -ne "https" -or
    -not [string]::IsNullOrEmpty($OriginUri.UserInfo) -or
    -not [string]::IsNullOrEmpty($OriginUri.Query) -or
    -not [string]::IsNullOrEmpty($OriginUri.Fragment)) {
    throw "RenderPublicOrigin must be a secret-free HTTPS origin."
}

$TokenSecure = Read-Host `
    "Paste a fresh Auth0 USER access token (masked; session only)" `
    -AsSecureString
$DeviceSecure = Read-Host `
    "Paste the enrolled Device UUID (masked; session only)" `
    -AsSecureString

$TokenBstr = [IntPtr]::Zero
$DeviceBstr = [IntPtr]::Zero
$AccessToken = $null
$DeviceId = $null
$AuthorizationHeaders = $null
$DeviceHeaders = $null

try {
    $TokenBstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR(
        $TokenSecure
    )
    $AccessToken = [Runtime.InteropServices.Marshal]::PtrToStringBSTR(
        $TokenBstr
    ).Trim()
    $DeviceBstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR(
        $DeviceSecure
    )
    $DeviceId = [Runtime.InteropServices.Marshal]::PtrToStringBSTR(
        $DeviceBstr
    ).Trim()

    if ([string]::IsNullOrWhiteSpace($AccessToken) -or
        $AccessToken.StartsWith("Bearer ", [StringComparison]::OrdinalIgnoreCase)) {
        throw "Enter only the raw access token, without the Bearer prefix."
    }

    $ParsedDeviceId = [guid]::Empty
    if (-not [guid]::TryParse($DeviceId, [ref]$ParsedDeviceId) -or
        $ParsedDeviceId -eq [guid]::Empty) {
        throw "The locally entered Device identifier is not a valid UUID."
    }

    $Parts = $AccessToken.Split(".")
    if ($Parts.Count -ne 3) {
        throw "The access token is not a three-part JWT."
    }

    $Header = ConvertFrom-Base64UrlJson $Parts[0]
    $Claims = ConvertFrom-Base64UrlJson $Parts[1]
    $IssuerMatches = (
        $Claims.iss -is [string] -and
        $Claims.iss.TrimEnd("/") -eq $Issuer
    )
    $AudienceMatches = (@($Claims.aud) -contains $Audience)
    $AlgorithmMatches = (
        $Header.alg -eq $Algorithm -and
        $Algorithm -eq "RS256"
    )
    $SubjectPresent = (
        $Claims.sub -is [string] -and
        -not [string]::IsNullOrWhiteSpace($Claims.sub)
    )

    $Now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $ExpiryValid = (
        $null -ne $Claims.exp -and
        [long]$Claims.exp -gt $Now
    )
    $NotBeforeValid = (
        $null -eq $Claims.nbf -or
        [long]$Claims.nbf -le $Now
    )
    $TimeWindowValid = $ExpiryValid -and $NotBeforeValid

    if (-not $IssuerMatches -or
        -not $AudienceMatches -or
        -not $AlgorithmMatches -or
        -not $SubjectPresent -or
        -not $TimeWindowValid) {
        throw "The token claims do not match the hosted Auth0 contract."
    }

    $OriginBase = [uri]($Origin + "/")
    $IdentityUri = [uri]::new(
        $OriginBase,
        $IdentityPath.TrimStart([char]"/")
    )
    $DeviceStatusUri = [uri]::new(
        $OriginBase,
        "v1/devices/$DeviceId/status"
    )

    $AuthorizationHeaders = @{
        Authorization = "Bearer $AccessToken"
    }
    $IdentityResponse = Invoke-SanitizedGet `
        -Uri $IdentityUri `
        -Headers $AuthorizationHeaders `
        -Label "Hosted identity endpoint"

    $DeviceHeaders = $AuthorizationHeaders.Clone()
    $DeviceHeaders[$DeviceHeaderName] = $DeviceId
    $DeviceResponse = Invoke-SanitizedGet `
        -Uri $DeviceStatusUri `
        -Headers $DeviceHeaders `
        -Label "Hosted Device status endpoint"

    if ([int]$IdentityResponse.StatusCode -ne 200 -or
        [int]$DeviceResponse.StatusCode -ne 200) {
        throw "Hosted identity binding did not return the required statuses."
    }

    [pscustomobject]@{
        IssuerMatches = $IssuerMatches
        AudienceMatches = $AudienceMatches
        AlgorithmMatches = $AlgorithmMatches
        SubjectPresent = $SubjectPresent
        TimeWindowValid = $TimeWindowValid
        IdentityStatus = [int]$IdentityResponse.StatusCode
        DeviceStatus = [int]$DeviceResponse.StatusCode
        TokenAccepted = $true
        ExactDeviceBinding = $true
        BindingClass = "exact-binding-confirmed"
    }
}
finally {
    if ($null -ne $DeviceHeaders) {
        $DeviceHeaders.Clear()
    }
    if ($null -ne $AuthorizationHeaders) {
        $AuthorizationHeaders.Clear()
    }
    $AccessToken = $null
    $DeviceId = $null
    if ($TokenBstr -ne [IntPtr]::Zero) {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($TokenBstr)
    }
    if ($DeviceBstr -ne [IntPtr]::Zero) {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($DeviceBstr)
    }
    Remove-Variable TokenSecure, DeviceSecure -ErrorAction SilentlyContinue
}
```

The local JWT read is only a compatibility precheck. The hosted API performs
the cryptographic signature, issuer, audience, expiry, membership, enrollment,
and Device authorization decisions. HTTP `200` from both read-only endpoints
therefore confirms the exact binding without sending a Sync submission.

## 6. Build and regression checks

### `GS-BUILD-01` — Sync API validation

```powershell
Push-Location ".\services\markei_sync_api"
try {
    npm ci --include=dev
    if ($LASTEXITCODE -ne 0) { throw "npm ci failed." }
    npm run format:check
    if ($LASTEXITCODE -ne 0) { throw "format:check failed." }
    npm run lint
    if ($LASTEXITCODE -ne 0) { throw "lint failed." }
    npm run typecheck
    if ($LASTEXITCODE -ne 0) { throw "typecheck failed." }
    npm test
    if ($LASTEXITCODE -ne 0) { throw "tests failed." }
    npm run build
    if ($LASTEXITCODE -ne 0) { throw "build failed." }
}
finally {
    Pop-Location
}
```

### `GS-BUILD-02` — Flutter validation

```powershell
Push-Location ".\clients\markei_flutter"
try {
    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed." }
    flutter analyze
    if ($LASTEXITCODE -ne 0) { throw "flutter analyze failed." }
    flutter test
    if ($LASTEXITCODE -ne 0) { throw "flutter test failed." }
    flutter build windows --release
    if ($LASTEXITCODE -ne 0) { throw "Windows release build failed." }
    flutter build apk --debug
    if ($LASTEXITCODE -ne 0) { throw "Android debug build failed." }
}
finally {
    Pop-Location
}
```

### `GS-FLUTTER-WIN` — Prepare, build, register, and run Windows Closure

Run from anywhere inside the repository. The procedure loads the four public
Closure coordinates from `documentation/NS_COORDINATES.md` into the current
PowerShell scope and prints only readiness booleans, never their values.

Historical identifier `GS-BUILD-03` resolves to this procedure. Use
`GS-FLUTTER-WIN` in new instructions.

```powershell
$RepositoryRoot = (& git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0 -or
    [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
    throw "Run this command from inside the Markei repository."
}

$ClientRoot = Join-Path $RepositoryRoot "clients\markei_flutter"
if (-not (Test-Path (Join-Path $ClientRoot "pubspec.yaml"))) {
    throw "Flutter client not found at $ClientRoot."
}

$NsPath = Join-Path $RepositoryRoot "documentation\NS_COORDINATES.md"
if (-not (Test-Path -LiteralPath $NsPath -PathType Leaf)) {
    throw "Coordinate file not found at $NsPath."
}
$NsText = Get-Content -LiteralPath $NsPath -Raw

function Get-NsCoordinate {
    param([Parameter(Mandatory)] [string]$Name)
    $CoordinateMatches = [regex]::Matches(
        $NsText,
        "(?m)^$([regex]::Escape($Name)):\s*(.*?)\s*$"
    )
    if ($CoordinateMatches.Count -ne 1) {
        throw "Expected exactly one '$Name' coordinate in $NsPath."
    }
    $Value = $CoordinateMatches[0].Groups[1].Value.Trim()
    if ([string]::IsNullOrWhiteSpace($Value) -or
        $Value -match '^<[^>]+>$') {
        throw "Replace the '$Name' placeholder in $NsPath."
    }
    return $Value
}

$Auth0Domain = Get-NsCoordinate "Auth0TenantDomain"
$Auth0Audience = Get-NsCoordinate "Auth0Audience"
$WindowsClientId = Get-NsCoordinate "Auth0WindowsClientId"
$HostedOrigin = Get-NsCoordinate "RenderPublicOrigin"

flutter config --enable-windows-desktop
if ($LASTEXITCODE -ne 0) {
    throw "Could not enable Flutter Windows desktop support."
}

flutter doctor -v

$WindowsDevices = (& flutter devices 2>&1 | Out-String)
if ($LASTEXITCODE -ne 0) {
    throw "Could not inspect Flutter devices."
}
Write-Host $WindowsDevices
if ($WindowsDevices -notmatch "(?im)\bwindows\b") {
    throw "Flutter does not currently expose a Windows desktop device."
}

$VcpkgRoot = "C:\vcpkg"
if (-not (Test-Path "$VcpkgRoot\vcpkg.exe")) {
    if (Test-Path $VcpkgRoot) {
        throw "C:\vcpkg exists but is incomplete. Inspect it before continuing."
    }

    git clone https://github.com/microsoft/vcpkg.git $VcpkgRoot
    if ($LASTEXITCODE -ne 0) {
        throw "Could not download vcpkg."
    }

    & "$VcpkgRoot\bootstrap-vcpkg.bat" -disableMetrics
    if ($LASTEXITCODE -ne 0) {
        throw "Could not bootstrap vcpkg."
    }
}

$CppRestDir = "$VcpkgRoot\installed\x64-windows\share\cpprestsdk"
$CppRestConfig = Get-ChildItem $CppRestDir `
    -Filter "*cpprestsdk*config.cmake" `
    -File `
    -ErrorAction SilentlyContinue

if (-not $CppRestConfig) {
    & "$VcpkgRoot\vcpkg.exe" install cpprestsdk:x64-windows
    if ($LASTEXITCODE -ne 0) {
        throw "cpprestsdk installation failed."
    }

    $CppRestConfig = Get-ChildItem $CppRestDir `
        -Filter "*cpprestsdk*config.cmake" `
        -File `
        -ErrorAction SilentlyContinue
}

if (-not $CppRestConfig) {
    throw "cpprestsdk CMake configuration was not found in $CppRestDir."
}

$env:VCPKG_ROOT = $VcpkgRoot
$env:VCPKG_DEFAULT_TRIPLET = "x64-windows"
$env:VCPKG_TARGET_TRIPLET = "x64-windows"
$env:CMAKE_TOOLCHAIN_FILE = "$VcpkgRoot\scripts\buildsystems\vcpkg.cmake"
$env:CMAKE_PREFIX_PATH = "$VcpkgRoot\installed\x64-windows"
$env:cpprestsdk_DIR = $CppRestDir

$ConfigurationReady = [ordered]@{
    Auth0Domain   = -not [string]::IsNullOrWhiteSpace($Auth0Domain)
    Auth0Audience = -not [string]::IsNullOrWhiteSpace($Auth0Audience)
    WindowsClient = -not [string]::IsNullOrWhiteSpace($WindowsClientId)
    HostedOrigin  = -not [string]::IsNullOrWhiteSpace($HostedOrigin)
}
[pscustomobject]$ConfigurationReady

if ($ConfigurationReady.Values -contains $false) {
    throw "One or more Windows Closure coordinates could not be loaded."
}

$RequiredClosureSurfaceDefine = "--dart-define=MARKEI_NATIVE_CLOSURE_SURFACE=true"
$FlutterDefines = @(
    $RequiredClosureSurfaceDefine
    "--dart-define=MARKEI_AUTH0_DOMAIN=$Auth0Domain"
    "--dart-define=MARKEI_AUTH0_AUDIENCE=$Auth0Audience"
    "--dart-define=MARKEI_AUTH0_WINDOWS_CLIENT_ID=$WindowsClientId"
    "--dart-define=MARKEI_HOSTED_HTTPS_ORIGIN=$HostedOrigin"
)
if ($FlutterDefines -notcontains $RequiredClosureSurfaceDefine) {
    throw "Windows Closure UI define is missing; refusing to build or run."
}

Push-Location $ClientRoot
try {
    flutter clean
    if ($LASTEXITCODE -ne 0) { throw "flutter clean failed." }

    if (Test-Path ".\windows\flutter\ephemeral") {
        Remove-Item ".\windows\flutter\ephemeral" -Recurse -Force
    }

    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed." }

    flutter analyze
    if ($LASTEXITCODE -ne 0) { throw "flutter analyze failed." }

    flutter test
    if ($LASTEXITCODE -ne 0) { throw "flutter test failed." }

    flutter build windows --release @FlutterDefines
    if ($LASTEXITCODE -ne 0) {
        throw "Windows Closure release build failed."
    }

    $MarkeiExecutable = Join-Path $PWD `
        "build\windows\x64\runner\Release\markei.exe"
    if (-not (Test-Path $MarkeiExecutable)) {
        throw "markei.exe was not found at $MarkeiExecutable."
    }

    powershell.exe -NoProfile -ExecutionPolicy Bypass `
      -File ".\tool\register_windows_auth0flutter_protocol.ps1" `
      -ExecutablePath $MarkeiExecutable
    if ($LASTEXITCODE -ne 0) {
        throw "Auth0 Flutter callback registration failed."
    }

    Write-Host "Launching the freshly built Markei Windows Closure client."
    Write-Host "Required UI destination: Closure."
    & $MarkeiExecutable
}
finally {
    Pop-Location
}
```

This is the full recovery path. It verifies the Windows device, provisions
`vcpkg`/`cpprestsdk` only when absent, exposes the native CMake paths, loads
the public Closure coordinates without printing values, cleans, validates,
builds, registers the per-user `auth0flutter` callback, and launches the
resulting release executable with the mandatory Closure Dart definition. If the
`Closure` destination is absent after launch, this procedure has not passed and
no Gate action may continue. Launching the client does not authorize Enroll,
Query, Retry, or Sync; those remain separate human actions.

### `GS-FLUTTER-AND` — Prepare, build, install, and run Android Closure

Run from anywhere inside the repository. The procedure loads the four public
Android Closure coordinates from `documentation/NS_COORDINATES.md`. Connect
and unlock one Android device with USB debugging already authorized, or start
one emulator. The procedure prints only readiness booleans and Flutter's
public device metadata, never configuration values.

```powershell
$RepositoryRoot = (& git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0 -or
    [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
    throw "Run this command from inside the Markei repository."
}

$ClientRoot = Join-Path $RepositoryRoot "clients\markei_flutter"
if (-not (Test-Path (Join-Path $ClientRoot "pubspec.yaml"))) {
    throw "Flutter client not found at $ClientRoot."
}

$NsPath = Join-Path $RepositoryRoot "documentation\NS_COORDINATES.md"
if (-not (Test-Path -LiteralPath $NsPath -PathType Leaf)) {
    throw "Coordinate file not found at $NsPath."
}
$NsText = Get-Content -LiteralPath $NsPath -Raw

function Get-NsCoordinate {
    param([Parameter(Mandatory)] [string]$Name)
    $CoordinateMatches = [regex]::Matches(
        $NsText,
        "(?m)^$([regex]::Escape($Name)):\s*(.*?)\s*$"
    )
    if ($CoordinateMatches.Count -ne 1) {
        throw "Expected exactly one '$Name' coordinate in $NsPath."
    }
    $Value = $CoordinateMatches[0].Groups[1].Value.Trim()
    if ([string]::IsNullOrWhiteSpace($Value) -or
        $Value -match '^<[^>]+>$') {
        throw "Replace the '$Name' placeholder in $NsPath."
    }
    return $Value
}

$Auth0Domain = Get-NsCoordinate "Auth0TenantDomain"
$Auth0Audience = Get-NsCoordinate "Auth0Audience"
$AndroidClientId = Get-NsCoordinate "Auth0AndroidClientId"
$HostedOrigin = Get-NsCoordinate "RenderPublicOrigin"

flutter doctor -v

$ConfigurationReady = [ordered]@{
    Auth0Domain   = -not [string]::IsNullOrWhiteSpace($Auth0Domain)
    Auth0Audience = -not [string]::IsNullOrWhiteSpace($Auth0Audience)
    AndroidClient = -not [string]::IsNullOrWhiteSpace($AndroidClientId)
    HostedOrigin  = -not [string]::IsNullOrWhiteSpace($HostedOrigin)
}
[pscustomobject]$ConfigurationReady

if ($ConfigurationReady.Values -contains $false) {
    throw "One or more Android Closure coordinates could not be loaded."
}

$FlutterDevicesJson = (& flutter devices --machine 2>&1 | Out-String)
if ($LASTEXITCODE -ne 0) {
    throw "Could not inspect Flutter devices."
}

try {
    $FlutterDevices = @($FlutterDevicesJson | ConvertFrom-Json)
}
catch {
    throw "Flutter returned an unreadable device inventory."
}

$AndroidDevices = @(
    $FlutterDevices | Where-Object {
        $_.targetPlatform -match "^android" -and $_.isSupported -eq $true
    }
)

$SelectedAndroidDevice = $null
if (-not [string]::IsNullOrWhiteSpace($AndroidDeviceId)) {
    $SelectedAndroidDevice = @(
        $AndroidDevices | Where-Object { $_.id -eq $AndroidDeviceId }
    )
    if ($SelectedAndroidDevice.Count -ne 1) {
        throw "AndroidDeviceId does not resolve to exactly one supported connected device."
    }
    $SelectedAndroidDevice = $SelectedAndroidDevice[0]
}
elseif ($AndroidDevices.Count -eq 1) {
    $SelectedAndroidDevice = $AndroidDevices[0]
}
elseif ($AndroidDevices.Count -eq 0) {
    throw "No supported Android device or emulator is connected."
}
else {
    $AndroidDevices |
        Select-Object name, id, targetPlatform, sdk |
        Format-Table -AutoSize
    throw "Multiple Android devices are connected. Set AndroidDeviceId to one displayed id and rerun."
}

$SelectedAndroidDevice |
    Select-Object name, id, targetPlatform, sdk |
    Format-List
$SelectedAndroidDeviceId = $SelectedAndroidDevice.id

$RequiredClosureSurfaceDefine = "--dart-define=MARKEI_NATIVE_CLOSURE_SURFACE=true"
$FlutterDefines = @(
    $RequiredClosureSurfaceDefine
    "--dart-define=MARKEI_AUTH0_DOMAIN=$Auth0Domain"
    "--dart-define=MARKEI_AUTH0_AUDIENCE=$Auth0Audience"
    "--dart-define=MARKEI_AUTH0_ANDROID_CLIENT_ID=$AndroidClientId"
    "--dart-define=MARKEI_HOSTED_HTTPS_ORIGIN=$HostedOrigin"
)
if ($FlutterDefines -notcontains $RequiredClosureSurfaceDefine) {
    throw "Android Closure UI define is missing; refusing to build or run."
}

$PreviousGradleAuth0Domain = $env:ORG_GRADLE_PROJECT_MARKEI_AUTH0_DOMAIN
$env:ORG_GRADLE_PROJECT_MARKEI_AUTH0_DOMAIN = $Auth0Domain

Push-Location $ClientRoot
try {
    flutter clean
    if ($LASTEXITCODE -ne 0) { throw "flutter clean failed." }

    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed." }

    flutter analyze
    if ($LASTEXITCODE -ne 0) { throw "flutter analyze failed." }

    flutter test
    if ($LASTEXITCODE -ne 0) { throw "flutter test failed." }

    flutter build apk --debug @FlutterDefines
    if ($LASTEXITCODE -ne 0) {
        throw "Android Closure debug build failed."
    }

    $AndroidArtifact = Join-Path $PWD `
        "build\app\outputs\flutter-apk\app-debug.apk"
    if (-not (Test-Path $AndroidArtifact)) {
        throw "app-debug.apk was not found at $AndroidArtifact."
    }

    Write-Host "Android debug artifact created at:"
    Write-Host $AndroidArtifact
    Write-Host "Launching Markei on the selected Android device."
    Write-Host "Required UI destination: Closure."

    flutter run --debug -d $SelectedAndroidDeviceId @FlutterDefines
    if ($LASTEXITCODE -ne 0) {
        throw "Flutter Android run failed."
    }
}
finally {
    Pop-Location
    if ($null -eq $PreviousGradleAuth0Domain) {
        Remove-Item Env:\ORG_GRADLE_PROJECT_MARKEI_AUTH0_DOMAIN `
            -ErrorAction SilentlyContinue
    }
    else {
        $env:ORG_GRADLE_PROJECT_MARKEI_AUTH0_DOMAIN = `
            $PreviousGradleAuth0Domain
    }
}
```

This is the full Android recovery path. It loads and verifies the public
coordinate surface, requires exactly one selected supported Android target,
forwards the Auth0 domain to the Android manifest without writing it elsewhere,
cleans, validates, builds the debug APK, verifies the artifact, and launches
the app with the mandatory Closure Dart definition. If the `Closure`
destination is absent after launch, this procedure has not passed and no Gate
action may continue. The Auth0 Android application must already
allow the callback/logout URI derived from package
`com.gusigu.markei`; this procedure does not modify Auth0. Launching the client
does not authorize Enroll, Query, Retry, or Sync.

## 7. Historical diagnostics and mutation record

These procedures are retained for traceability and are excluded from the
active `GRIMOIRE_INDEX`.

### `GS-NEON-H01` — Gate 02 preflight diagnostic

Canonical SQL block: `NEON_ACTION.sql` → `NA-02` /
`gate02-preflight`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action gate02-preflight
```

Gate 02 is closed; current inspection should use `GS-NEON-04`.

### `GS-MIG-H01` — Migration 007 apply command; do not rerun

Migration 007 was applied successfully on 2026-07-23 with file SHA-256:

```text
89AB11302F8B860C52AA1C74FBFEDF6A4DB3A0EE62FE7CB715B20B74AEF99AC6
```

The command below is append-oriented evidence only:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action apply-migration `
  -MigrationPath ".\services\markei_sync_api\migrations\007_account_cursor_provisioning.sql"
```

Do not copy or execute it during ordinary recovery. Use `GS-NEON-04` or
`GS-NEON-05` for read-only verification.

## 8. Stop conditions

Stop before mutation if:

- the target branch may be production;
- the selected identity is not the intended role;
- any non-secret coordinate remains unknown or disagrees with its provider;
- a password, token, complete connection URL, or real identity UUID would be
  written to Git, chat, Markdown, SQL, screenshots, or shell history;
- migration prerequisites or checksums disagree;
- migration 007 is already present or its outcome is uncertain;
- the migration file is dirty or untracked;
- GitHub advanced, the local/remote SHAs diverge, or the worktree overlaps;
- another deployment is active or the watched Render branch is uncertain;
- a health, readiness, identity, or provider baseline differs from the
  procedure's expected boundary;
- `sqlite3.exe` cannot be resolved and version-verified;
- Markei, Flutter, or Dart remains active during local-database copying;
- the local Markei database candidate count is not exactly one;
- a SQLite WAL/SHM sidecar remains after Markei closes;
- the verified temporary copy already exists, differs in size/hash, fails
  `quick_check`, lacks a required table, or produces a probe error.

After an unclear migration result, use only read-only postflight and ledger
checks. Never reconstruct or partially rerun a migration by hand.
