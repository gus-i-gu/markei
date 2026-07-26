# Markei General Scripts

> Canonical executable catalogue for the human-supervised GRM interface.
> Repository: `gus-i-gu/markei`; branch: `cycle10-intermid-grimoire`.

## 0. Execution contract

```text
GRM_INDEX block invokes NEON_CHECK.ps1 -Procedure GS-*
→ dispatcher loads one exact canonical GS-* procedure from this file
→ NS_COORDINATES.md supplies non-secret values
→ the GS-* body requests only remaining role/UUID/secret input
→ GS-* calls reviewed PowerShell and, when needed, one DB_MGMT SQL block
→ sanitized result returns to the operator
```

Keep this active five-file set together:

```text
documentation/GRM.md
documentation/G_SCRIPTS.md
documentation/NS_COORDINATES.md
documentation/NEON_CHECK.ps1
documentation/DB_MGMT.sql
```

Unless a procedure states otherwise, run PowerShell commands from anywhere
inside the repository. Active self-navigating procedures resolve the repository
root, enter the required package or data location, and return the terminal to
the repository root in `finally`. `G_SCRIPTS.md` remains a Markdown catalogue;
it is not renamed to `.ps1` and is not passed directly to PowerShell's `-File`
parameter. `NEON_CHECK.ps1 -Procedure <GS-ID>` is the active GRM dispatcher. It
loads one exact reviewed `GS-*` heading and executes its fenced PowerShell body.
Directly copy a GS fence only for diagnosis or when the dispatcher is
operationally unavailable. Do not replace values already supplied by
`NS_COORDINATES.md`.

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

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-01` / `connection`.

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

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-03` /
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

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-04` /
`migration-ledger`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action migration-ledger
```

### `GS-NEON-06` — Schema and RLS inventory

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-06` /
`schema-inventory`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action schema-inventory
```

### `GS-NEON-07` — Runtime privilege inventory

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-05` /
`runtime-privileges`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action runtime-privileges
```

### `GS-NEON-08` — Sanitized device inventory

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-07` /
`list-devices-sanitized`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action list-devices-sanitized
```

### `GS-NEON-09` — Verify one device's counters

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-08` / `verify-device`.

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

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-10` /
`runtime-readiness`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\NEON_CHECK.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role runtime `
  -Action runtime-readiness
```

Expected: `markei_runtime`, `markei_sync_dev`, `ready = t`, and `ROLLBACK`.

### `GS-NEON-11` — Capture the atomic provider baseline

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-09` /
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
→ GS-SQLITE-04, only when Main requests exact device-scoped correlation
```

Keep Markei closed throughout `GS-SQLITE-02`, `GS-SQLITE-03`, and
`GS-SQLITE-04`. These procedures never press Enroll, Query, Retry, or Sync and
never contact Auth0, Render, or Neon.

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
    $SearchRoots = @($SearchRoots)
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
    $Sidecars = @($Sidecars)
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

### `GS-SQLITE-04` - Run the sanitized Gate 12.6 scope-correlation probe

This procedure opens only the fixed copied database created by
`GS-SQLITE-02`, uses both SQLite `-readonly` and `PRAGMA query_only = ON`,
requires `quick_check=ok`, and stops unless exactly one failed/notApplied
candidate exists. It reports only anonymized device ranks, status classes,
counts, booleans, sequence ranges, positions, and bounded hash-equality
booleans needed to prepare a Gate 12.7 packet. It never selects identifiers,
payloads, purchase content, private paths, URLs, tokens, connection strings,
provider secrets, or complete hashes.

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

    function Invoke-MarkeiSqliteText {
        param([Parameter(Mandatory)] [string]$Sql)

        $Output = $Sql |
            & $SqliteCli -readonly $CopiedDatabase 2>&1
        $ExitCode = $LASTEXITCODE
        if ($ExitCode -ne 0) {
            $Output
            throw "The copied-database scope-correlation probe failed."
        }
        return ($Output | Out-String).Trim()
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

    $SchemaSql = @'
PRAGMA query_only = ON;
SELECT COUNT(*)
FROM sqlite_master
WHERE type = 'table'
  AND name IN (
    'sync_submissions',
    'sync_submission_events',
    'pending_events',
    'sync_events',
    'devices',
    'sync_attempts',
    'hosted_auth_states'
  );
'@
    $SchemaCount = Invoke-MarkeiSqliteText -Sql $SchemaSql
    if ($SchemaCount -ne "7") {
        throw "Expected seven local diagnostic tables; stop before inference."
    }

    $CandidateCountSql = @'
PRAGMA query_only = ON;
SELECT COUNT(*)
FROM sync_submissions
WHERE state = 'failed'
  AND outcome = 'notApplied';
'@
    $CandidateCount = Invoke-MarkeiSqliteText -Sql $CandidateCountSql
    if ($CandidateCount -ne "1") {
        [pscustomobject]@{
            FailedNotAppliedCandidateCount = $CandidateCount
            Terminal = "scope-correlation-ambiguous"
        }
        throw "Expected exactly one failed/notApplied candidate."
    }

    $ProbeSql = @'
.bail on
.headers on
.mode column
.nullvalue [null]
PRAGMA query_only = ON;
BEGIN;

.print === PROBE_0_SCOPE_SCHEMA ===
SELECT
  1 AS quick_check_already_ok,
  7 AS expected_table_count,
  COUNT(*) AS observed_table_count
FROM sqlite_master
WHERE type = 'table'
  AND name IN (
    'sync_submissions',
    'sync_submission_events',
    'pending_events',
    'sync_events',
    'devices',
    'sync_attempts',
    'hosted_auth_states'
  );

.print === PROBE_1_DEVICE_SCOPES ===
WITH device_scope AS (
  SELECT
    d.account_id,
    d.id AS device_id,
    d.next_sequence,
    ROW_NUMBER() OVER (ORDER BY d.created_at, d.id) AS device_scope_rank
  FROM devices AS d
),
hosted_scope AS (
  SELECT
    account_id,
    server_device_id AS device_id,
    MAX(enrollment_state) AS enrollment_state
  FROM hosted_auth_states
  WHERE server_device_id IS NOT NULL
  GROUP BY account_id, server_device_id
),
event_counts AS (
  SELECT
    e.account_id,
    e.device_id,
    COUNT(*) AS event_count
  FROM sync_events AS e
  GROUP BY e.account_id, e.device_id
),
queue_counts AS (
  SELECT
    e.account_id,
    e.device_id,
    SUM(CASE WHEN pe.state = 'pending' THEN 1 ELSE 0 END) AS pending_count,
    MIN(CASE WHEN pe.state = 'pending' THEN e.device_sequence END)
      AS pending_first_sequence,
    MAX(CASE WHEN pe.state = 'pending' THEN e.device_sequence END)
      AS pending_last_sequence,
    SUM(CASE WHEN pe.state = 'failed' THEN 1 ELSE 0 END) AS failed_count,
    MIN(CASE WHEN pe.state = 'failed' THEN e.device_sequence END)
      AS failed_first_sequence,
    MAX(CASE WHEN pe.state = 'failed' THEN e.device_sequence END)
      AS failed_last_sequence,
    SUM(CASE WHEN pe.state = 'unknown' THEN 1 ELSE 0 END) AS unknown_count,
    SUM(CASE WHEN pe.state = 'uploading' THEN 1 ELSE 0 END) AS uploading_count
  FROM pending_events AS pe
  JOIN sync_events AS e
    ON e.id = pe.event_id
  GROUP BY e.account_id, e.device_id
)
SELECT
  ds.device_scope_rank,
  CASE WHEN hs.device_id IS NULL THEN 0 ELSE 1 END AS is_hosted_scope,
  COALESCE(hs.enrollment_state, '[none]') AS hosted_enrollment_state,
  ds.next_sequence,
  COALESCE(ec.event_count, 0) AS event_count,
  COALESCE(qc.pending_count, 0) AS pending_count,
  COALESCE(qc.pending_first_sequence, '[null]') AS pending_first_sequence,
  COALESCE(qc.pending_last_sequence, '[null]') AS pending_last_sequence,
  COALESCE(qc.failed_count, 0) AS failed_count,
  COALESCE(qc.failed_first_sequence, '[null]') AS failed_first_sequence,
  COALESCE(qc.failed_last_sequence, '[null]') AS failed_last_sequence,
  COALESCE(qc.unknown_count, 0) AS unknown_count,
  COALESCE(qc.uploading_count, 0) AS uploading_count
FROM device_scope AS ds
LEFT JOIN hosted_scope AS hs
  ON hs.account_id = ds.account_id
 AND hs.device_id = ds.device_id
LEFT JOIN event_counts AS ec
  ON ec.account_id = ds.account_id
 AND ec.device_id = ds.device_id
LEFT JOIN queue_counts AS qc
  ON qc.account_id = ds.account_id
 AND qc.device_id = ds.device_id
ORDER BY ds.device_scope_rank;

.print === PROBE_2_FAILED_CANDIDATE_SCOPE ===
WITH device_scope AS (
  SELECT
    d.account_id,
    d.id AS device_id,
    d.next_sequence,
    ROW_NUMBER() OVER (ORDER BY d.created_at, d.id) AS device_scope_rank
  FROM devices AS d
),
hosted_scope AS (
  SELECT
    account_id,
    server_device_id AS device_id
  FROM hosted_auth_states
  WHERE server_device_id IS NOT NULL
  GROUP BY account_id, server_device_id
),
candidate AS (
  SELECT *
  FROM sync_submissions
  WHERE state = 'failed'
    AND outcome = 'notApplied'
),
members AS (
  SELECT
    c.id AS submission_id,
    c.account_id,
    c.device_id,
    c.state,
    c.outcome,
    COALESCE(c.response_code, '[null]') AS response_code,
    COALESCE(c.error_code, '[null]') AS error_code,
    c.request_hash,
    se.position,
    e.id AS event_id,
    e.device_sequence,
    pe.state AS event_state
  FROM candidate AS c
  JOIN sync_submission_events AS se
    ON se.submission_id = c.id
  JOIN sync_events AS e
    ON e.id = se.event_id
  JOIN pending_events AS pe
    ON pe.event_id = e.id
),
member_summary AS (
  SELECT
    submission_id,
    account_id,
    device_id,
    state,
    outcome,
    response_code,
    error_code,
    request_hash,
    COUNT(*) AS member_count,
    MIN(position) AS first_position,
    MAX(position) AS last_position,
    CASE
      WHEN COUNT(DISTINCT position) = COUNT(*)
       AND MIN(position) = 0
       AND MAX(position) = COUNT(*) - 1 THEN 1
      ELSE 0
    END AS positions_contiguous,
    MIN(device_sequence) AS first_sequence,
    MAX(device_sequence) AS last_sequence,
    CASE
      WHEN COUNT(DISTINCT device_sequence) = COUNT(*)
       AND MAX(device_sequence) - MIN(device_sequence) + 1 = COUNT(*) THEN 1
      ELSE 0
    END AS sequences_contiguous,
    COUNT(DISTINCT event_state) AS event_state_kinds,
    MIN(event_state) AS min_event_state,
    MAX(event_state) AS max_event_state,
    SUM(CASE WHEN event_state = 'failed' THEN 1 ELSE 0 END)
      AS failed_member_count
  FROM members
  GROUP BY
    submission_id,
    account_id,
    device_id,
    state,
    outcome,
    response_code,
    error_code,
    request_hash
),
same_hash AS (
  SELECT
    ms.submission_id,
    SUM(
      CASE
        WHEN other.state = 'superseded'
         AND other.request_hash = ms.request_hash THEN 1
        ELSE 0
      END
    ) AS superseded_same_hash_count,
    SUM(
      CASE
        WHEN other.state IN ('uploading', 'unknown')
         AND other.request_hash = ms.request_hash THEN 1
        ELSE 0
      END
    ) AS active_same_hash_count
  FROM member_summary AS ms
  LEFT JOIN sync_submissions AS other
    ON other.id <> ms.submission_id
  GROUP BY ms.submission_id
)
SELECT
  ds.device_scope_rank AS candidate_device_scope_rank,
  CASE WHEN hs.device_id IS NULL THEN 0 ELSE 1 END AS is_hosted_scope,
  ds.next_sequence AS candidate_scope_next_sequence,
  ms.state AS submission_state,
  ms.outcome AS submission_outcome,
  ms.response_code,
  ms.error_code,
  CASE WHEN length(ms.request_hash) = 64 THEN 1 ELSE 0 END
    AS request_hash_shape_64_hex,
  COALESCE(sh.superseded_same_hash_count, 0) AS superseded_same_hash_count,
  COALESCE(sh.active_same_hash_count, 0) AS active_same_hash_count,
  ms.member_count,
  ms.first_position,
  ms.last_position,
  ms.positions_contiguous,
  ms.first_sequence,
  ms.last_sequence,
  ms.sequences_contiguous,
  ms.event_state_kinds,
  ms.min_event_state,
  ms.max_event_state,
  ms.failed_member_count
FROM member_summary AS ms
JOIN device_scope AS ds
  ON ds.account_id = ms.account_id
 AND ds.device_id = ms.device_id
LEFT JOIN hosted_scope AS hs
  ON hs.account_id = ms.account_id
 AND hs.device_id = ms.device_id
LEFT JOIN same_hash AS sh
  ON sh.submission_id = ms.submission_id;

.print === PROBE_3_SIMULATED_UPLOAD_AFTER_RECOVERY ===
WITH device_scope AS (
  SELECT
    d.account_id,
    d.id AS device_id,
    ROW_NUMBER() OVER (ORDER BY d.created_at, d.id) AS device_scope_rank
  FROM devices AS d
),
candidate AS (
  SELECT *
  FROM sync_submissions
  WHERE state = 'failed'
    AND outcome = 'notApplied'
),
candidate_events AS (
  SELECT
    e.id AS event_id,
    e.account_id,
    e.device_id
  FROM candidate AS c
  JOIN sync_submission_events AS se
    ON se.submission_id = c.id
  JOIN sync_events AS e
    ON e.id = se.event_id
),
simulated_queue AS (
  SELECT
    e.id AS event_id,
    e.account_id,
    e.device_id,
    e.device_sequence,
    CASE WHEN ce.event_id IS NULL THEN 0 ELSE 1 END AS is_candidate_event,
    CASE WHEN pe.state = 'pending' THEN 1 ELSE 0 END AS already_pending
  FROM sync_events AS e
  JOIN pending_events AS pe
    ON pe.event_id = e.id
  LEFT JOIN candidate_events AS ce
    ON ce.event_id = e.id
  WHERE EXISTS (
      SELECT 1
      FROM candidate_events AS scope
      WHERE scope.account_id = e.account_id
        AND scope.device_id = e.device_id
    )
    AND (pe.state = 'pending' OR ce.event_id IS NOT NULL)
),
ordered_upload AS (
  SELECT
    sq.*,
    ROW_NUMBER() OVER (
      ORDER BY sq.device_sequence, sq.event_id
    ) AS upload_position
  FROM simulated_queue AS sq
)
SELECT
  ds.device_scope_rank AS upload_device_scope_rank,
  COUNT(*) AS simulated_upload_count_before_limit,
  SUM(CASE WHEN upload_position <= 25 THEN 1 ELSE 0 END)
    AS simulated_first_upload_count_limit_25,
  SUM(CASE WHEN upload_position <= 25 THEN is_candidate_event ELSE 0 END)
    AS candidate_events_in_first_upload,
  MIN(CASE WHEN is_candidate_event = 1 THEN upload_position END)
    AS first_candidate_upload_position,
  MAX(CASE WHEN is_candidate_event = 1 THEN upload_position END)
    AS last_candidate_upload_position,
  MIN(CASE WHEN upload_position <= 25 THEN device_sequence END)
    AS first_upload_sequence,
  MAX(CASE WHEN upload_position <= 25 THEN device_sequence END)
    AS last_upload_sequence,
  SUM(already_pending) AS already_pending_in_scope_count,
  SUM(CASE WHEN is_candidate_event = 0 THEN 1 ELSE 0 END)
    AS other_pending_in_scope_count,
  CASE
    WHEN SUM(CASE WHEN is_candidate_event = 0 THEN 1 ELSE 0 END) = 0 THEN 1
    ELSE 0
  END AS first_upload_contains_only_candidate_events
FROM ordered_upload AS ou
JOIN device_scope AS ds
  ON ds.account_id = ou.account_id
 AND ds.device_id = ou.device_id
GROUP BY ds.device_scope_rank;

.print === PROBE_4_LATEST_SYNC_ATTEMPT_CLASS ===
SELECT
  COALESCE(operation_kind, '[null]') AS operation_kind,
  result_code,
  outcome_class,
  phase,
  COALESCE(recovery_code, '[null]') AS recovery_code,
  CASE WHEN http_status IS NULL THEN 0 ELSE 1 END AS has_http_status,
  response_headers_received,
  COALESCE(elapsed_band, '[null]') AS elapsed_band
FROM sync_attempts
ORDER BY started_at DESC, id DESC
LIMIT 1;

ROLLBACK;
'@

    $ProbeOutput = Invoke-MarkeiSqliteText -Sql $ProbeSql
    $ProbeOutput

    Write-Host "SQLiteQuickCheck: ok"
    Write-Host "LiveDatabaseQueried: False"
    Write-Host "RetrySelected: False"
    Write-Host "SyncSelected: False"
    Write-Host "ProviderActionPerformed: False"
    Write-Host "CleanupPerformed: False"
    Write-Host "TerminalLocation: repository-root"
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

Run from anywhere inside the repository. The procedure loads the five public
Android Closure coordinates from `documentation/NS_COORDINATES.md`. It reuses
one connected supported Android target or starts the configured AVD and waits
for it to boot. The procedure prints only readiness booleans and Flutter's
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
$AndroidAvdName = Get-NsCoordinate "AndroidAvdName"

flutter doctor -v

$ConfigurationReady = [ordered]@{
    Auth0Domain   = -not [string]::IsNullOrWhiteSpace($Auth0Domain)
    Auth0Audience = -not [string]::IsNullOrWhiteSpace($Auth0Audience)
    AndroidClient = -not [string]::IsNullOrWhiteSpace($AndroidClientId)
    HostedOrigin  = -not [string]::IsNullOrWhiteSpace($HostedOrigin)
    AndroidAvd    = -not [string]::IsNullOrWhiteSpace($AndroidAvdName)
}
[pscustomobject]$ConfigurationReady

if ($ConfigurationReady.Values -contains $false) {
    throw "One or more Android Closure coordinates could not be loaded."
}

function Get-SupportedAndroidDevices {
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
    return @(
        $FlutterDevices | Where-Object {
            $_.targetPlatform -match "^android" -and $_.isSupported -eq $true
        }
    )
}

$AndroidDeviceId = $null
$AndroidDevices = @(Get-SupportedAndroidDevices)
$SelectedAndroidDevice = $null
if ($AndroidDevices.Count -eq 0) {
    $AndroidSdkRoot = if (
        -not [string]::IsNullOrWhiteSpace($env:ANDROID_SDK_ROOT)
    ) {
        $env:ANDROID_SDK_ROOT
    }
    else {
        Join-Path $env:LOCALAPPDATA "Android\Sdk"
    }
    $EmulatorExe = Join-Path $AndroidSdkRoot "emulator\emulator.exe"
    if (-not (Test-Path -LiteralPath $EmulatorExe -PathType Leaf)) {
        throw "Android emulator executable was not found at $EmulatorExe."
    }
    $KnownAvds = @(& $EmulatorExe -list-avds)
    if ($LASTEXITCODE -ne 0) {
        throw "Could not inspect installed Android Virtual Devices."
    }
    if ($KnownAvds -notcontains $AndroidAvdName) {
        throw "Configured Android AVD '$AndroidAvdName' is not installed."
    }

    Write-Host "Starting configured Android AVD: $AndroidAvdName"
    Start-Process -FilePath $EmulatorExe `
        -ArgumentList @("-avd", $AndroidAvdName)

    $DeviceDeadline = [DateTime]::UtcNow.AddMinutes(3)
    do {
        Start-Sleep -Seconds 3
        $AndroidDevices = @(Get-SupportedAndroidDevices)
        if ($AndroidDevices.Count -gt 1) {
            $AndroidDevices |
                Select-Object name, id, targetPlatform, sdk |
                Format-Table -AutoSize
            throw "Multiple Android devices appeared while starting the configured AVD."
        }
    } until (
        $AndroidDevices.Count -eq 1 -or
        [DateTime]::UtcNow -ge $DeviceDeadline
    )
    if ($AndroidDevices.Count -ne 1) {
        throw "Configured Android AVD did not become available within 3 minutes."
    }

    $AndroidDeviceId = $AndroidDevices[0].id
    $AdbExe = Join-Path $AndroidSdkRoot "platform-tools\adb.exe"
    if (-not (Test-Path -LiteralPath $AdbExe -PathType Leaf)) {
        throw "Android Debug Bridge was not found at $AdbExe."
    }
    $BootDeadline = [DateTime]::UtcNow.AddMinutes(3)
    do {
        Start-Sleep -Seconds 2
        $BootCompleted = (
            & $AdbExe -s $AndroidDeviceId shell getprop sys.boot_completed `
                2>$null
        ).Trim()
    } until (
        $BootCompleted -eq "1" -or
        [DateTime]::UtcNow -ge $BootDeadline
    )
    if ($BootCompleted -ne "1") {
        throw "Configured Android AVD did not finish booting within 3 minutes."
    }
}

if ($AndroidDevices.Count -eq 1) {
    $SelectedAndroidDevice = $AndroidDevices[0]
}
else {
    $AndroidDevices |
        Select-Object name, id, targetPlatform, sdk |
        Format-Table -AutoSize
    throw "Multiple Android devices are connected. Leave exactly one target connected and rerun."
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
coordinate surface, reuses exactly one selected supported Android target or
starts the configured AVD with bounded availability and boot waits, forwards
the Auth0 domain to the Android manifest without writing it elsewhere, cleans,
validates, builds the debug APK, verifies the artifact, and launches the app
with the mandatory Closure Dart definition. If the `Closure` destination is
absent after launch, this procedure has not passed and no Gate action may
continue. The Auth0 Android application must already allow the callback/logout
URI derived from package
`com.gusigu.markei`; this procedure does not modify Auth0. Launching the client
does not authorize Enroll, Query, Retry, or Sync.

## 7. Historical diagnostics and mutation record

These procedures are retained for traceability and are excluded from the
active `GRM_INDEX`.

### `GS-NEON-H01` — Gate 02 preflight diagnostic

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-02` /
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
