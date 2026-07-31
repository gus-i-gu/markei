# Markei General Scripts

> Canonical executable catalogue for the human-supervised GRM interface.
> Repository: `gus-i-gu/markei`; branch: `grm-guarded-provisioning-20260727`.

## 0. Execution contract

```text
GRM_INDEX block invokes I_SCRIPTS.ps1 -Procedure GS-*
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
documentation/I_SCRIPTS.ps1
documentation/DB_MGMT.sql
```

Unless a procedure states otherwise, run PowerShell commands from anywhere
inside the repository. Active self-navigating procedures resolve the repository
root, enter the required package or data location, and return the terminal to
the repository root in `finally`. `G_SCRIPTS.md` remains a Markdown catalogue;
it is not renamed to `.ps1` and is not passed directly to PowerShell's `-File`
parameter. `I_SCRIPTS.ps1 -Procedure <GS-ID>` is the active GRM dispatcher. It
loads one exact reviewed `GS-*` heading and executes its fenced PowerShell body.
Directly copy a GS fence only for diagnosis or when the dispatcher is
operationally unavailable. Do not replace values already supplied by
`NS_COORDINATES.md`.

The canonical Neon launcher form is process-scoped and does not permanently
alter PowerShell execution policy:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\I_SCRIPTS.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role <runtime|migrator|dbowner> `
  -Action <action>
```

Passwords are requested through `Read-Host -AsSecureString`, converted only
for the current process/container call, and cleared in `finally`.

## 1. Neon and migration actions

Requirements: Windows PowerShell, Docker Desktop running, access to the
`postgres:18-alpine` image, and verified non-secret Neon coordinates. Local
`psql` is not required.

### `GS-NEON-00` — Guided role/action launcher

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\I_SCRIPTS.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md"
```

The terminal requests the role number, action number, and selected role
password. An action-specific UUID or confirmation is requested only when
required.

### `GS-NEON-01` — Migrator connection proof

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-01` / `connection`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\I_SCRIPTS.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action connection
```

### `GS-NEON-02` — Open migrator psql

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\I_SCRIPTS.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action shell
```

Exit `psql` with `\q`.

### `GS-NEON-03` — Open runtime psql

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\I_SCRIPTS.ps1" `
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
  -File ".\documentation\I_SCRIPTS.ps1" `
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
  -File ".\documentation\I_SCRIPTS.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action migration-ledger
```

### `GS-NEON-06` — Schema and RLS inventory

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-06` /
`schema-inventory`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\I_SCRIPTS.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action schema-inventory
```

### `GS-NEON-07` — Runtime privilege inventory

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-05` /
`runtime-privileges`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\I_SCRIPTS.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action runtime-privileges
```

### `GS-NEON-08` — Sanitized device inventory

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-07` /
`list-devices-sanitized`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\I_SCRIPTS.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action list-devices-sanitized
```

### `GS-NEON-09` — Verify one device's counters

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-08` / `verify-device`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\I_SCRIPTS.ps1" `
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
  -File ".\documentation\I_SCRIPTS.ps1" `
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
  -File ".\documentation\I_SCRIPTS.ps1" `
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
- selected-Device acknowledgement row count, acknowledged cursor, and
  consistency against the hosted high-water (`count=0, cursor=0` means no
  acknowledgement row);
- truncated submission/request and event/content replay fingerprints;
- explicit `ROLLBACK` and final launcher `PASS`.

The action fails closed if the UUID does not identify exactly one provider
Device. It returns no UUID, Account identifier, payload, stored result, full
hash, password, or connection string. `PASS` proves successful read-only
execution only; Gate 12.5 closes only after the values are reconciled against
the accepted 12.5a–c evidence.

### `GS-MIG-01` — Ordered open-ended migration walker

Canonical registry and state queries:

```text
DB_MGMT.sql → DBM-MIGRATION entries
DB_MGMT.sql → DBM-AUTO-11 / migration-state
DB_MGMT.sql → DBM-AUTO-04 / migration-ledger
```

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\I_SCRIPTS.ps1" `
  -ConfigPath ".\documentation\NS_COORDINATES.md" `
  -Role migrator `
  -Action migrate-to
```

The terminal requests:

1. `latest`, `000`, or one registered numeric target;
2. the migrator password through the masked prompt;
3. exact `OK NNN` confirmation before each planned step.

`STOP` at any step preserves the last successfully committed provider version.
The password is entered once for the complete walk.

The walker does not hard-code migration 007 or any future ceiling. It:

1. parses physically ordered `DBM-MIGRATION` entries;
2. requires a contiguous sequence beginning at `001`;
3. treats the last valid entry in `DB_MGMT.sql` as `latest`;
4. verifies every referenced SQL file is inside the repository, tracked,
   clean, correctly named, and equal to its registered SHA-256;
5. detects version `000`/`001` from the six migration-001 baseline tables
   because migration 001 predates the ledger;
6. validates every migration-002+ ledger ID and semantic checksum against the
   registry;
7. builds the complete UP or DOWN plan before the first mutation;
8. applies one file per `psql --single-transaction` call;
9. strips only a matching outer `BEGIN`/terminal `COMMIT`, leaving the file
   body unchanged inside the runner-owned transaction;
10. executes a ledger/baseline assertion before that transaction can commit;
11. verifies the committed provider version before offering the next step;
12. returns one consolidated start/current/target result.

For example, a provider at 006 with registry entries through 009 receives:

```text
UP 007
UP 008
UP 009
```

A provider at 009 targeting 006 receives:

```text
DOWN 009
DOWN 008
DOWN 007
```

but only when all three entries register reviewed paired down files. The
walker rejects the entire descent before its first mutation if any required
down file is `NONE`.

Current migrations 001–007 remain registered as forward-only because no
reviewed reverse files exist. Therefore the new runner can build a fresh
provider upward from 000 to 007 now, while a request to descend through any of
001–007 stops safely before mutation. Open-ended DOWN execution becomes
available automatically as paired `NNN_name.down.sql` files and exact SHA-256
values are reviewed and registered.

Every up migration numbered 002 or later must insert exactly its registered
`migration_id` and ledger checksum. Every paired down migration must remove
that current ledger row and restore the immediately preceding compatible
state. A down file may not delete unrelated ledger rows or silently claim
reversibility for data it cannot restore.

SQL or in-transaction assertion failure is rolled back automatically. A
transport interruption remains an unclear outcome: stop, run the read-only
ledger/state inspection, and never retry blindly.

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

### `GS-GIT-BRN` — Guarded branch handoff with updates reconciliation

This procedure requests the exact destination branch in the terminal. It does
not read `RepositoryBranch`, select a default branch, or hard-code any file
scope. It identifies the current local branch, fetches `origin`, requires the
destination to exist remotely, and reconciles both branch history and local
work. Selecting the current branch is valid: it performs a same-branch
state-of-union reconciliation instead of requiring a separate command.

Committed source history is merged into the destination without rebasing,
resetting, or deleting. A distinct source branch reference remains unchanged;
same-branch reconciliation advances the current branch through the merge.
Staged, unstaged, and untracked updates are preserved in a named Git safety
stash and reapplied after the history merge. The safety stash is retained even
after a successful reapplication; remove it manually only after reviewing and
committing the reconciled result.

The procedure stops before handoff if a Git operation is already active, the
destination is checked out in another worktree, or a pre-existing local
destination contains commits absent from its remote. It never pushes and never
chooses a conflict winner. A merge or stash-application conflict remains on the
destination for explicit human reconciliation while the source branch and
safety stash remain recoverable.

```powershell
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$RepositoryRoot = (& git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0 -or
    [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
    throw "Run this command from inside the Markei repository."
}

$SourceBranch = $null
$TargetBranch = $null
$SourceSha = $null
$RemoteTargetSha = $null
$StashSha = $null

function Get-GitDivergence {
    param([Parameter(Mandatory)] [string]$Range)

    $DivergenceRaw = (& git rev-list --left-right --count $Range).Trim()
    if ($LASTEXITCODE -ne 0) {
        throw "Could not calculate Git divergence for '$Range'."
    }
    $Divergence = @($DivergenceRaw -split '\s+')
    if ($Divergence.Count -ne 2 -or
        $Divergence[0] -notmatch '^\d+$' -or
        $Divergence[1] -notmatch '^\d+$') {
        throw "Git returned an invalid divergence result for '$Range'."
    }

    return [pscustomobject]@{
        LeftOnly = [int]$Divergence[0]
        RightOnly = [int]$Divergence[1]
    }
}

try {
    Set-Location -LiteralPath $RepositoryRoot

    foreach ($OperationMarker in @(
            "MERGE_HEAD",
            "CHERRY_PICK_HEAD",
            "REVERT_HEAD",
            "BISECT_LOG",
            "rebase-apply",
            "rebase-merge"
        )) {
        $OperationPath = (
            & git rev-parse --git-path $OperationMarker
        ).Trim()
        if ($LASTEXITCODE -ne 0) {
            throw "Could not inspect Git operation state."
        }
        if (Test-Path -LiteralPath $OperationPath) {
            throw (
                "Git operation '$OperationMarker' is already active. " +
                "Complete or abort it before branch handoff."
            )
        }
    }

    $SourceBranch = (& git branch --show-current).Trim()
    if ($LASTEXITCODE -ne 0 -or
        [string]::IsNullOrWhiteSpace($SourceBranch)) {
        throw "Branch handoff requires a named current branch, not detached HEAD."
    }
    $SourceSha = (& git rev-parse "refs/heads/$SourceBranch").Trim()
    if ($LASTEXITCODE -ne 0) {
        throw "Could not resolve the current source branch."
    }

    Write-Host ""
    Write-Host "Current local branch: $SourceBranch"
    $TargetBranch = (
        Read-Host "Exact destination branch to check, pull, and receive current work"
    ).Trim()
    if ([string]::IsNullOrWhiteSpace($TargetBranch)) {
        throw "Destination branch cannot be empty."
    }
    & git check-ref-format --branch $TargetBranch *> $null
    if ($LASTEXITCODE -ne 0) {
        throw "Destination branch '$TargetBranch' is not a valid branch name."
    }
    $SameBranchReconciliation = $TargetBranch -ceq $SourceBranch

    & git remote get-url origin *> $null
    if ($LASTEXITCODE -ne 0) {
        throw "The repository has no usable 'origin' remote."
    }
    $TargetFetchRefspec = (
        "+refs/heads/{0}:refs/remotes/origin/{0}" -f $TargetBranch
    )
    & git fetch --prune origin $TargetFetchRefspec
    if ($LASTEXITCODE -ne 0) {
        throw "Exact fetch of 'origin/$TargetBranch' failed."
    }

    & git show-ref `
        --verify `
        --quiet `
        "refs/remotes/origin/$TargetBranch"
    if ($LASTEXITCODE -ne 0) {
        throw "Remote destination 'origin/$TargetBranch' does not exist."
    }
    $RemoteTargetSha = (
        & git rev-parse "refs/remotes/origin/$TargetBranch"
    ).Trim()
    if ($LASTEXITCODE -ne 0) {
        throw "Could not resolve the remote destination branch."
    }

    $LocalTargetExists = $true
    & git show-ref --verify --quiet "refs/heads/$TargetBranch"
    if ($LASTEXITCODE -ne 0) {
        $LocalTargetExists = $false
    }

    if ($LocalTargetExists) {
        $ActiveWorktreePath = $null
        $WorktreeLines = @(& git worktree list --porcelain)
        if ($LASTEXITCODE -ne 0) {
            throw "Could not inspect repository worktrees."
        }
        foreach ($WorktreeLine in $WorktreeLines) {
            if ($WorktreeLine.StartsWith("worktree ")) {
                $ActiveWorktreePath = $WorktreeLine.Substring(9)
                continue
            }
            if ($WorktreeLine -ceq "branch refs/heads/$TargetBranch" -and
                -not [string]::IsNullOrWhiteSpace($ActiveWorktreePath)) {
                $ResolvedWorktreePath = [IO.Path]::GetFullPath(
                    $ActiveWorktreePath
                )
                $ResolvedRepositoryRoot = [IO.Path]::GetFullPath(
                    $RepositoryRoot
                )
                if ($ResolvedWorktreePath -ine $ResolvedRepositoryRoot) {
                    throw (
                        "Destination '$TargetBranch' is checked out in " +
                        "another worktree: $ActiveWorktreePath"
                    )
                }
            }
        }

        $TargetPreflight = Get-GitDivergence `
            "origin/$TargetBranch...$TargetBranch"
        if (-not $SameBranchReconciliation -and
            $TargetPreflight.RightOnly -ne 0) {
            throw (
                "Local destination '$TargetBranch' contains commits absent " +
                "from origin. Reconcile that branch separately first."
            )
        }
    }

    $InitialStatus = @(
        & git status --porcelain=v1 --untracked-files=all
    )
    if ($LASTEXITCODE -ne 0) {
        throw "Could not inspect the current working tree."
    }
    $HasLocalUpdates = $InitialStatus.Count -ne 0

    Write-Host ""
    Write-Host "Branch handoff preflight:"
    Write-Host "  source branch       = $SourceBranch"
    Write-Host "  source HEAD         = $SourceSha"
    Write-Host "  destination branch  = $TargetBranch"
    Write-Host "  remote target HEAD  = $RemoteTargetSha"
    Write-Host "  local updates       = $HasLocalUpdates"
    Write-Host "  reconciliation      = merge; no rebase or force update"
    Write-Host "  push                = never"
    Write-Host ""

    $OperationName = if ($SameBranchReconciliation) {
        "RECONCILE"
    }
    else {
        "HANDOFF"
    }
    $ExpectedConfirmation = "$OperationName $SourceBranch -> $TargetBranch"
    $Confirmation = (
        Read-Host "Type '$ExpectedConfirmation' or STOP"
    ).Trim()
    if ($Confirmation -ceq "STOP") {
        throw "Branch handoff stopped before local mutation."
    }
    if ($Confirmation -cne $ExpectedConfirmation) {
        throw "Branch handoff cancelled: confirmation did not match."
    }

    if ($HasLocalUpdates) {
        $PreviousStashSha = (
            & git rev-parse --verify --quiet refs/stash 2>$null
        )
        if ($LASTEXITCODE -eq 0) {
            $PreviousStashSha = $PreviousStashSha.Trim()
        }
        else {
            $PreviousStashSha = $null
        }

        $StashMessage = (
            "GRM-GIT-BRN {0} -> {1} {2}" -f
            $SourceBranch,
            $TargetBranch,
            [DateTime]::UtcNow.ToString("yyyyMMddTHHmmssZ")
        )
        & git stash push `
            --include-untracked `
            --message $StashMessage
        if ($LASTEXITCODE -ne 0) {
            throw "Could not preserve local updates in a Git safety stash."
        }
        $StashSha = (& git rev-parse --verify refs/stash).Trim()
        if ($LASTEXITCODE -ne 0 -or
            [string]::IsNullOrWhiteSpace($StashSha) -or
            $StashSha -ceq $PreviousStashSha) {
            throw "Git did not create the expected branch-handoff safety stash."
        }

        $PostStashStatus = @(
            & git status --porcelain=v1 --untracked-files=all
        )
        if ($LASTEXITCODE -ne 0) {
            throw "Could not verify the preserved working tree."
        }
        if ($PostStashStatus.Count -ne 0) {
            Write-Host (
                "Safety stash retained at $StashSha; restoring preserved work."
            ) -ForegroundColor Yellow
            & git stash apply --index $StashSha
            throw (
                "The safety stash did not capture the complete working tree. " +
                "Branch handoff stopped on '$SourceBranch'."
            )
        }
    }

    if ($SameBranchReconciliation) {
        & git merge --no-edit "origin/$TargetBranch"
        if ($LASTEXITCODE -ne 0) {
            Write-Host ""
            Write-Host (
                "Same-branch history reconciliation requires manual resolution."
            ) -ForegroundColor Yellow
            Write-Host "Run: git status"
            Write-Host "Resolve each conflict explicitly, then commit the merge."
            if (-not [string]::IsNullOrWhiteSpace($StashSha)) {
                Write-Host "Safety stash retained: $StashSha"
                Write-Host (
                    "Apply it only after the merge is committed: " +
                    "git stash apply --index $StashSha"
                )
            }
            throw "Same-branch merge stopped on '$TargetBranch'."
        }
        $PulledTargetSha = $RemoteTargetSha
        $HistoryReconciliation = "same-branch-state-of-union"
    }
    elseif ($LocalTargetExists) {
        & git switch $TargetBranch
        if ($LASTEXITCODE -ne 0) {
            throw "Could not switch to local destination '$TargetBranch'."
        }
        & git merge --ff-only "origin/$TargetBranch"
        if ($LASTEXITCODE -ne 0) {
            throw "Fast-forward pull of '$TargetBranch' failed."
        }
    }
    else {
        & git switch `
            --create $TargetBranch `
            --track "origin/$TargetBranch"
        if ($LASTEXITCODE -ne 0) {
            throw "Could not create the tracked destination '$TargetBranch'."
        }
    }

    if (-not $SameBranchReconciliation) {
        $PulledTargetSha = (& git rev-parse HEAD).Trim()
        if ($LASTEXITCODE -ne 0 -or
            $PulledTargetSha -cne $RemoteTargetSha) {
            throw (
                "Destination checkout did not reach the exact fetched remote tip."
            )
        }
        $PulledAlignment = Get-GitDivergence `
            "origin/$TargetBranch...HEAD"
        if ($PulledAlignment.LeftOnly -ne 0 -or
            $PulledAlignment.RightOnly -ne 0) {
            throw "Destination did not pass exact remote-alignment verification."
        }

        & git merge-base --is-ancestor $SourceBranch HEAD
        if ($LASTEXITCODE -eq 0) {
            $HistoryReconciliation = "source-already-contained"
        }
        elseif ($LASTEXITCODE -eq 1) {
            & git merge --no-edit $SourceBranch
            if ($LASTEXITCODE -ne 0) {
                Write-Host ""
                Write-Host (
                    "Committed-history reconciliation requires manual resolution."
                ) -ForegroundColor Yellow
                Write-Host "Run: git status"
                Write-Host "Resolve each conflict explicitly, then commit the merge."
                if (-not [string]::IsNullOrWhiteSpace($StashSha)) {
                    Write-Host (
                        "After the merge is committed, reapply local updates with:"
                    )
                    Write-Host "git stash apply --index $StashSha"
                    Write-Host "Safety stash retained: $StashSha"
                }
                throw "Branch-history merge stopped on '$TargetBranch'."
            }
            $HistoryReconciliation = "source-merged"
        }
        else {
            throw "Could not determine source/destination ancestry."
        }
    }

    & git branch `
        --set-upstream-to "origin/$TargetBranch" `
        $TargetBranch
    if ($LASTEXITCODE -ne 0) {
        throw "Could not set the exact destination upstream."
    }
    $ConfiguredUpstream = (
        & git rev-parse `
            --abbrev-ref `
            --symbolic-full-name `
            "@{upstream}"
    ).Trim()
    if ($LASTEXITCODE -ne 0 -or
        $ConfiguredUpstream -cne "origin/$TargetBranch") {
        throw "Destination upstream verification failed."
    }

    if (-not [string]::IsNullOrWhiteSpace($StashSha)) {
        & git stash apply --index $StashSha
        if ($LASTEXITCODE -ne 0) {
            Write-Host ""
            Write-Host (
                "Local-update reconciliation requires manual resolution."
            ) -ForegroundColor Yellow
            Write-Host "Run: git status"
            Write-Host "Resolve each conflict explicitly."
            Write-Host "Safety stash retained: $StashSha"
            throw "Preserved local updates did not apply cleanly."
        }
        $LocalUpdateReconciliation = "reapplied; safety stash retained"
    }
    else {
        $LocalUpdateReconciliation = "no local updates"
    }

    if (-not $SameBranchReconciliation) {
        $PreservedSourceSha = (
            & git rev-parse "refs/heads/$SourceBranch"
        ).Trim()
        if ($LASTEXITCODE -ne 0 -or
            $PreservedSourceSha -cne $SourceSha) {
            throw "Source branch reference changed unexpectedly."
        }
    }
    $CurrentBranch = (& git branch --show-current).Trim()
    if ($LASTEXITCODE -ne 0 -or
        $CurrentBranch -cne $TargetBranch) {
        throw "Branch handoff did not finish on '$TargetBranch'."
    }

    $FinalDivergence = Get-GitDivergence `
        "origin/$TargetBranch...HEAD"
    if ($FinalDivergence.LeftOnly -ne 0) {
        throw "Destination is behind the fetched remote target after handoff."
    }
    $FinalHead = (& git rev-parse HEAD).Trim()
    if ($LASTEXITCODE -ne 0) {
        throw "Could not resolve the reconciled destination HEAD."
    }
    $FinalStatus = @(
        & git status --porcelain=v1 --untracked-files=all
    )
    if ($LASTEXITCODE -ne 0) {
        throw "Could not inspect the reconciled working tree."
    }
    $SafetyStashReport = "none"
    if (-not [string]::IsNullOrWhiteSpace($StashSha)) {
        $SafetyStashReport = $StashSha
    }

    [pscustomobject][ordered]@{
        SourceBranch = $SourceBranch
        SourceHead = $SourceSha
        SourceReference = if ($SameBranchReconciliation) {
            "reconciled-current-branch"
        }
        else {
            "unchanged"
        }
        DestinationBranch = $TargetBranch
        ConfiguredUpstream = $ConfiguredUpstream
        PulledRemoteHead = $RemoteTargetSha
        FinalHead = $FinalHead
        RemoteBehind = $FinalDivergence.LeftOnly
        RemoteAhead = $FinalDivergence.RightOnly
        HistoryReconciliation = $HistoryReconciliation
        LocalUpdates = $LocalUpdateReconciliation
        ReconciledStatusEntries = $FinalStatus.Count
        SafetyStash = $SafetyStashReport
        PushPerformed = $false
    }

    Write-Host ""
    Write-Host "Branch reconciliation completed locally." -ForegroundColor Green
    Write-Host "Review with: git status"
    Write-Host "Review history with: git log --graph --oneline --decorate -12"
    if (-not [string]::IsNullOrWhiteSpace($StashSha)) {
        Write-Host "Safety stash retained: $StashSha"
        Write-Host (
            "After review and commit, verify it with 'git stash list', then " +
            "remove only that backup with: git stash drop 'stash@{0}'"
        )
    }
    Write-Host "Nothing was pushed."
}
finally {
    Set-Location -LiteralPath $RepositoryRoot
}
```

`GS-GIT-BRN` transfers no ignored files and does not treat ignored build,
credential, or application-data artifacts as branch updates. It preserves the
source branch pointer, but the destination may gain a local merge commit and
reapplied uncommitted work. Therefore `GRM-GIT-01` should be used only after
reviewing, committing, and intentionally publishing or otherwise reconciling
the destination.

## 3. Local SQLite diagnostics

`GS-SQLITE-02/03/04` operate only on the Windows application database used by
the Flutter client. `GS-SQLITE-05/06/07` provide the symmetric Android path:
ADB selects exactly one debug-capable Android target, force-stops Markei,
extracts a hash-verified app-private snapshot with binary-safe streaming, and
queries only that snapshot. The database file and the SQLite command-line
program are different objects: finding `markei_shared_beta.sqlite` does not
prove that `sqlite3.exe` is installed or discoverable.

The diagnostic sequence is:

```text
GS-SQLITE-01
→ GS-SQLITE-02
→ GS-SQLITE-03
→ GS-SQLITE-04, only when Main requests exact device-scoped correlation

GS-SQLITE-01
→ GS-SQLITE-05
→ GS-SQLITE-06
→ GS-SQLITE-07, only when Main requests Android apply-state correlation
```

Keep Markei closed throughout `GS-SQLITE-02`, `GS-SQLITE-03`, and
`GS-SQLITE-04`. `GS-SQLITE-05` force-stops the Android app and leaves it
stopped; keep it stopped throughout `GS-SQLITE-06` and `GS-SQLITE-07`. These
procedures never press Enroll, Query, Retry, or Sync, never clear or replace
application data, and never contact Auth0, Render, or Neon.

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
        $PathCommand = @(
            Get-Command sqlite3.exe `
                -CommandType Application `
                -All `
                -ErrorAction SilentlyContinue |
                Select-Object -First 1
        )
        if ($PathCommand.Count -eq 1) {
            return [pscustomobject]@{
                Source = $PathCommand[0].Source
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
        $PathCommand = @(
            Get-Command sqlite3.exe `
                -CommandType Application `
                -All `
                -ErrorAction SilentlyContinue |
                Select-Object -First 1
        )
        if ($PathCommand.Count -eq 1) {
            return $PathCommand[0].Source
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
        $PathCommand = @(
            Get-Command sqlite3.exe `
                -CommandType Application `
                -All `
                -ErrorAction SilentlyContinue |
                Select-Object -First 1
        )
        if ($PathCommand.Count -eq 1) {
            return $PathCommand[0].Source
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

### `GS-SQLITE-05` — Create and verify the Android SQLite snapshot

This is the Android counterpart of `GS-SQLITE-02`. It requires exactly one
connected, ready Android target, proves that the debug package supports
`run-as`, force-stops Markei without clearing its data, and extracts the
app-private database plus any present WAL/SHM companions. Missing sidecars are
a normal SQLite state and do not fail the procedure. Extraction uses a redirected
.NET byte stream rather than PowerShell text redirection. Each file's remote
size and SHA-256 are compared with the copied file before and after extraction.
The private manifest is retained only in the fixed temporary snapshot
directory; no serial, private path, UUID, hash value, or file content is
printed.

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

    function Resolve-MarkeiAdb {
        $PathCommand = Get-Command adb.exe `
            -CommandType Application `
            -ErrorAction SilentlyContinue
        if ($null -ne $PathCommand) {
            return $PathCommand.Source
        }

        $SdkRoots = @(
            $env:ANDROID_SDK_ROOT
            $env:ANDROID_HOME
            if (-not [string]::IsNullOrWhiteSpace($env:LOCALAPPDATA)) {
                Join-Path $env:LOCALAPPDATA "Android\Sdk"
            }
        ) |
            Where-Object {
                -not [string]::IsNullOrWhiteSpace($_)
            } |
            Select-Object -Unique
        $Candidates = @(
            foreach ($SdkRoot in $SdkRoots) {
                $Candidate = Join-Path $SdkRoot "platform-tools\adb.exe"
                if (Test-Path -LiteralPath $Candidate -PathType Leaf) {
                    Get-Item -LiteralPath $Candidate
                }
            }
        ) |
            Sort-Object FullName -Unique
        $Candidates = @($Candidates)
        if ($Candidates.Count -ne 1) {
            throw @"
Android Debug Bridge is unavailable or ambiguous.
Install Android SDK Platform-Tools or set ANDROID_SDK_ROOT, then rerun
GS-SQLITE-05.
"@
        }
        return $Candidates[0].FullName
    }

    function Invoke-MarkeiAdbText {
        param(
            [Parameter(Mandatory)] [string[]]$Arguments,
            [string]$Failure = "ADB command failed."
        )

        $Output = @(& $AdbExe @Arguments 2>&1)
        $ExitCode = $LASTEXITCODE
        if ($ExitCode -ne 0) {
            throw $Failure
        }
        return ($Output | Out-String).Trim()
    }

    function Test-MarkeiAndroidPrivateFile {
        param([Parameter(Mandatory)] [string]$RemotePath)

        if ($RemotePath -notmatch '^[A-Za-z0-9._/-]+$' -or
            $DeviceSerial -notmatch '^[A-Za-z0-9._:-]+$') {
            throw "Android private-file probe arguments contain unexpected characters."
        }

        $StartInfo = New-Object System.Diagnostics.ProcessStartInfo
        $StartInfo.FileName = $AdbExe
        $StartInfo.Arguments = (
            "-s {0} shell run-as {1} ls {2}" -f
            $DeviceSerial,
            $PackageName,
            $RemotePath
        )
        $StartInfo.UseShellExecute = $false
        $StartInfo.CreateNoWindow = $true
        $StartInfo.RedirectStandardOutput = $true
        $StartInfo.RedirectStandardError = $true

        $Process = New-Object System.Diagnostics.Process
        $Process.StartInfo = $StartInfo
        try {
            if (-not $Process.Start()) {
                throw "ADB private-file existence probe did not start."
            }
            $OutputTask = $Process.StandardOutput.ReadToEndAsync()
            $ErrorTask = $Process.StandardError.ReadToEndAsync()
            $Process.WaitForExit()
            $OutputTask.GetAwaiter().GetResult() | Out-Null
            $ErrorTask.GetAwaiter().GetResult() | Out-Null
            $ExitCode = $Process.ExitCode
        }
        finally {
            $Process.Dispose()
        }

        if ($ExitCode -eq 0) {
            return $true
        }
        if ($ExitCode -eq 1) {
            return $false
        }
        throw "Could not inspect an Android private-file presence state."
    }

    function Get-MarkeiAndroidPrivateFileMetadata {
        param([Parameter(Mandatory)] [string]$RemotePath)

        $SizeText = Invoke-MarkeiAdbText `
            -Arguments @(
                "-s", $DeviceSerial,
                "shell", "run-as", $PackageName,
                "stat", "-c", "%s", $RemotePath
            ) `
            -Failure "Could not inspect an Android database-file size."
        if ($SizeText -notmatch '^\d+$') {
            throw "Android database-file size had an unexpected shape."
        }

        $HashText = Invoke-MarkeiAdbText `
            -Arguments @(
                "-s", $DeviceSerial,
                "shell", "run-as", $PackageName,
                "sha256sum", $RemotePath
            ) `
            -Failure "Android sha256sum is unavailable for the private file."
        $HashMatch = [regex]::Match(
            $HashText,
            '^(?<Hash>[A-Fa-f0-9]{64})(?:\s|$)'
        )
        if (-not $HashMatch.Success) {
            throw "Android database-file SHA-256 had an unexpected shape."
        }

        return [pscustomobject]@{
            Length = [int64]$SizeText
            Sha256 = $HashMatch.Groups["Hash"].Value.ToUpperInvariant()
        }
    }

    function Copy-MarkeiAndroidPrivateFile {
        param(
            [Parameter(Mandatory)] [string]$RemotePath,
            [Parameter(Mandatory)] [string]$Destination
        )

        if ($RemotePath -notmatch '^[A-Za-z0-9._/-]+$' -or
            $DeviceSerial -notmatch '^[A-Za-z0-9._:-]+$') {
            throw "Android extraction arguments contain unexpected characters."
        }

        $StartInfo = New-Object System.Diagnostics.ProcessStartInfo
        $StartInfo.FileName = $AdbExe
        $StartInfo.Arguments = (
            "-s {0} exec-out run-as {1} cat {2}" -f
            $DeviceSerial,
            $PackageName,
            $RemotePath
        )
        $StartInfo.UseShellExecute = $false
        $StartInfo.CreateNoWindow = $true
        $StartInfo.RedirectStandardOutput = $true
        $StartInfo.RedirectStandardError = $true

        $Process = New-Object System.Diagnostics.Process
        $Process.StartInfo = $StartInfo
        $CopySucceeded = $false
        try {
            if (-not $Process.Start()) {
                throw "ADB binary extraction did not start."
            }
            $ErrorTask = $Process.StandardError.ReadToEndAsync()
            $DestinationStream = [IO.File]::Open(
                $Destination,
                [IO.FileMode]::CreateNew,
                [IO.FileAccess]::Write,
                [IO.FileShare]::None
            )
            try {
                $Process.StandardOutput.BaseStream.CopyTo($DestinationStream)
            }
            finally {
                $DestinationStream.Dispose()
            }
            $Process.WaitForExit()
            $ErrorTask.GetAwaiter().GetResult() | Out-Null
            if ($Process.ExitCode -ne 0) {
                throw "ADB binary extraction failed."
            }
            $CopySucceeded = $true
        }
        finally {
            $Process.Dispose()
            if (-not $CopySucceeded -and
                (Test-Path -LiteralPath $Destination -PathType Leaf)) {
                Remove-Item -LiteralPath $Destination -Force
            }
        }
    }

    $AdbExe = Resolve-MarkeiAdb
    $Inventory = @(& $AdbExe devices 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw "Could not inspect connected Android targets."
    }
    $DeviceRows = @(
        $Inventory |
            ForEach-Object {
                [string]$_
            } |
            Where-Object {
                $_ -match '^\S+\s+\S+(?:\s|$)' -and
                $_ -notmatch '^List of devices' -and
                $_ -notmatch '^\*'
            }
    )
    $DeviceMatches = @(
        $DeviceRows | ForEach-Object {
            [regex]::Match(
                $_,
                '^(?<Serial>\S+)\s+(?<State>\S+)(?:\s|$)'
            )
        }
    )
    if ($DeviceMatches.Count -ne 1 -or
        -not $DeviceMatches[0].Success -or
        $DeviceMatches[0].Groups["State"].Value -ne "device") {
        [pscustomobject]@{
            AndroidTargetCount = $DeviceMatches.Count
            ReadyTargetCount = @(
                $DeviceMatches | Where-Object {
                    $_.Groups["State"].Value -eq "device"
                }
            ).Count
        }
        throw "Leave exactly one authorized, ready Android target connected."
    }

    $DeviceSerial = $DeviceMatches[0].Groups["Serial"].Value
    if ($DeviceSerial -notmatch '^[A-Za-z0-9._:-]+$') {
        throw "The selected Android target identifier has an unsafe shape."
    }
    $PackageName = "com.gusigu.markei"
    $PackageProof = Invoke-MarkeiAdbText `
        -Arguments @(
            "-s", $DeviceSerial,
            "shell", "pm", "path", $PackageName
        ) `
        -Failure "The Markei Android package is not installed."
    if ($PackageProof -notmatch '^package:') {
        throw "The Markei Android package proof had an unexpected shape."
    }

    $RunAsProof = Invoke-MarkeiAdbText `
        -Arguments @(
            "-s", $DeviceSerial,
            "shell", "run-as", $PackageName, "id"
        ) `
        -Failure "The installed Markei package does not permit debug run-as."
    if ($RunAsProof -notmatch '\buid=\d+') {
        throw "Android run-as proof had an unexpected shape."
    }

    Invoke-MarkeiAdbText `
        -Arguments @(
            "-s", $DeviceSerial,
            "shell", "am", "force-stop", $PackageName
        ) `
        -Failure "Could not force-stop Markei before extraction." |
        Out-Null
    $PidOutput = (
        & $AdbExe -s $DeviceSerial shell pidof $PackageName 2>$null |
            Out-String
    ).Trim()
    if ($LASTEXITCODE -eq 0 -and
        -not [string]::IsNullOrWhiteSpace($PidOutput)) {
        throw "Markei remained active after force-stop."
    }

    $RemoteDatabase = "files/markei_shared_beta.sqlite"
    if (-not (Test-MarkeiAndroidPrivateFile -RemotePath $RemoteDatabase)) {
        throw "The Markei app-private SQLite database is absent."
    }

    $FilesToCopy = @(
        [pscustomobject]@{
            RemotePath = $RemoteDatabase
            LocalName = "markei_shared_beta.sqlite"
            Required = $true
        }
        [pscustomobject]@{
            RemotePath = "$RemoteDatabase-wal"
            LocalName = "markei_shared_beta.sqlite-wal"
            Required = $false
        }
        [pscustomobject]@{
            RemotePath = "$RemoteDatabase-shm"
            LocalName = "markei_shared_beta.sqlite-shm"
            Required = $false
        }
    )
    $PresentFiles = @(
        $FilesToCopy | Where-Object {
            $_.Required -or
            (Test-MarkeiAndroidPrivateFile -RemotePath $_.RemotePath)
        }
    )

    $SnapshotDirectory = Join-Path `
        ([System.IO.Path]::GetTempPath()) `
        "markei-android-sqlite-current"
    if (Test-Path -LiteralPath $SnapshotDirectory) {
        throw @"
The current Android SQLite snapshot directory already exists.
Do not overwrite it. Preserve it for interpretation or remove it only after
explicit cleanup authorization, then rerun GS-SQLITE-05.
"@
    }
    New-Item `
        -ItemType Directory `
        -Path $SnapshotDirectory `
        -ErrorAction Stop |
        Out-Null

    $ManifestEntries = @()
    foreach ($FileToCopy in $PresentFiles) {
        $Before = Get-MarkeiAndroidPrivateFileMetadata `
            -RemotePath $FileToCopy.RemotePath
        $Destination = Join-Path `
            $SnapshotDirectory `
            $FileToCopy.LocalName
        Copy-MarkeiAndroidPrivateFile `
            -RemotePath $FileToCopy.RemotePath `
            -Destination $Destination
        $After = Get-MarkeiAndroidPrivateFileMetadata `
            -RemotePath $FileToCopy.RemotePath
        $LocalInfo = Get-Item -LiteralPath $Destination
        $LocalHash = (
            Get-FileHash -LiteralPath $Destination -Algorithm SHA256
        ).Hash.ToUpperInvariant()

        if ($Before.Length -ne $After.Length -or
            $Before.Sha256 -cne $After.Sha256 -or
            $LocalInfo.Length -ne $Before.Length -or
            $LocalHash -cne $Before.Sha256) {
            throw "Android database snapshot verification failed."
        }
        $ManifestEntries += [pscustomobject]@{
            Name = $FileToCopy.LocalName
            Length = $LocalInfo.Length
            Sha256 = $LocalHash
        }
    }

    $ManifestPath = Join-Path $SnapshotDirectory "snapshot-manifest.json"
    [pscustomobject]@{
        Format = "markei-android-sqlite-snapshot-v1"
        Files = @($ManifestEntries)
    } |
        ConvertTo-Json -Depth 4 |
        Set-Content -LiteralPath $ManifestPath -Encoding UTF8

    $PidOutputAfter = (
        & $AdbExe -s $DeviceSerial shell pidof $PackageName 2>$null |
            Out-String
    ).Trim()
    if ($LASTEXITCODE -eq 0 -and
        -not [string]::IsNullOrWhiteSpace($PidOutputAfter)) {
        throw "Markei restarted during Android database extraction."
    }

    [pscustomobject]@{
        AndroidTargetCount = 1
        ReadyTargetCount = 1
        PackageInstalled = $true
        DebugRunAsAvailable = $true
        MarkeiForceStopped = $true
        DatabasePresent = $true
        SidecarCount = $PresentFiles.Count - 1
        SnapshotFileCount = $PresentFiles.Count
        SizeMatches = $true
        HashMatches = $true
        ManifestCreated = $true
        HashValuesPrinted = $false
        DeviceIdentifierPrinted = $false
        PrivatePathPrinted = $false
        LiveDatabaseQueried = $false
        AppDataCleared = $false
        AppDataReplaced = $false
        ProbeDirectoryName = Split-Path $SnapshotDirectory -Leaf
        TerminalLocation = $RepositoryRoot
    }
}
finally {
    Set-Location -LiteralPath $RepositoryRoot
}
```

### `GS-SQLITE-06` — Run the sanitized Android local-state probe

This is the Android counterpart of `GS-SQLITE-03`. It re-verifies the private
snapshot manifest created by `GS-SQLITE-05`, opens only the copied database
with SQLite `-readonly`, an `immutable=1` URI, and
`PRAGMA query_only = ON`, requires both
`integrity_check=ok` and an empty foreign-key check, and requires one active
hosted binding. It reports only schema presence, binding classes, local
Device/cursor counts, business-fact cardinalities, inbox/queue cardinalities,
and the latest ordinary-Sync attempt and sanitized diagnostic phases.

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
        $PathCommand = @(
            Get-Command sqlite3.exe `
                -CommandType Application `
                -All `
                -ErrorAction SilentlyContinue |
                Select-Object -First 1
        )
        if ($PathCommand.Count -eq 1) {
            return $PathCommand[0].Source
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

    function Invoke-MarkeiAndroidSqliteText {
        param([Parameter(Mandatory)] [string]$Sql)

        $Output = $Sql |
            & $SqliteCli -readonly $CopiedDatabaseUri 2>&1
        $ExitCode = $LASTEXITCODE
        if ($ExitCode -ne 0) {
            $Output
            throw "The copied Android database probe failed."
        }
        return ($Output | Out-String).Trim()
    }

    function Assert-MarkeiAndroidSnapshot {
        if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) {
            throw "Android snapshot manifest not found. Run GS-SQLITE-05."
        }
        try {
            $Manifest = Get-Content -LiteralPath $ManifestPath -Raw |
                ConvertFrom-Json
        }
        catch {
            throw "Android snapshot manifest is unreadable."
        }
        if ($Manifest.Format -cne "markei-android-sqlite-snapshot-v1") {
            throw "Android snapshot manifest format is unsupported."
        }
        $ManifestFiles = @($Manifest.Files)
        if ($ManifestFiles.Count -lt 1 -or $ManifestFiles.Count -gt 3) {
            throw "Android snapshot manifest file count is invalid."
        }
        $AllowedNames = @(
            "markei_shared_beta.sqlite"
            "markei_shared_beta.sqlite-wal"
            "markei_shared_beta.sqlite-shm"
        )
        if (@($ManifestFiles.Name | Select-Object -Unique).Count -ne
            $ManifestFiles.Count -or
            $ManifestFiles.Name -notcontains "markei_shared_beta.sqlite") {
            throw "Android snapshot manifest membership is invalid."
        }
        foreach ($Entry in $ManifestFiles) {
            if ($Entry.Name -notin $AllowedNames -or
                ([string]$Entry.Length) -notmatch '^\d+$' -or
                ([string]$Entry.Sha256) -notmatch '^[A-Fa-f0-9]{64}$') {
                throw "Android snapshot manifest entry is invalid."
            }
            $SnapshotFile = Join-Path $SnapshotDirectory $Entry.Name
            if (-not (Test-Path -LiteralPath $SnapshotFile -PathType Leaf)) {
                throw "An Android snapshot file is absent."
            }
            $SnapshotInfo = Get-Item -LiteralPath $SnapshotFile
            $SnapshotHash = (
                Get-FileHash -LiteralPath $SnapshotFile -Algorithm SHA256
            ).Hash
            if ($SnapshotInfo.Length -ne [int64]$Entry.Length -or
                $SnapshotHash -ine [string]$Entry.Sha256) {
                throw "Android snapshot no longer matches its manifest."
            }
        }
    }

    $SqliteCli = Resolve-MarkeiSqliteCli
    $SnapshotDirectory = Join-Path `
        ([System.IO.Path]::GetTempPath()) `
        "markei-android-sqlite-current"
    $CopiedDatabase = Join-Path `
        $SnapshotDirectory `
        "markei_shared_beta.sqlite"
    $ManifestPath = Join-Path `
        $SnapshotDirectory `
        "snapshot-manifest.json"
    Assert-MarkeiAndroidSnapshot
    $CopiedDatabaseUri = (
        New-Object System.Uri($CopiedDatabase)
    ).AbsoluteUri + "?immutable=1"

    $IntegrityCheck = Invoke-MarkeiAndroidSqliteText `
        -Sql "PRAGMA integrity_check;"
    if ($IntegrityCheck -ne "ok") {
        throw "Copied Android database integrity_check was not exactly 'ok'."
    }
    $ForeignKeyCheck = Invoke-MarkeiAndroidSqliteText `
        -Sql "PRAGMA foreign_key_check;"
    if (-not [string]::IsNullOrWhiteSpace($ForeignKeyCheck)) {
        throw "Copied Android database foreign_key_check returned rows."
    }

    $SchemaSql = @'
PRAGMA query_only = ON;
SELECT COUNT(*)
FROM sqlite_master
WHERE type = 'table'
  AND name IN (
    'local_accounts',
    'devices',
    'installation_metadata',
    'hosted_auth_states',
    'sync_state',
    'purchases',
    'purchase_items',
    'sync_inbox',
    'sync_events',
    'pending_events',
    'sync_submissions',
    'sync_attempts',
    'sync_diagnostic_events'
  );
'@
    $SchemaCount = Invoke-MarkeiAndroidSqliteText -Sql $SchemaSql
    if ($SchemaCount -ne "13") {
        throw "Expected thirteen Android diagnostic tables; stop before inference."
    }

    $BindingCountSql = @'
PRAGMA query_only = ON;
SELECT COUNT(*)
FROM hosted_auth_states
WHERE enrollment_state IN ('device-enrolled', 'duplicate-equivalent')
  AND account_id IS NOT NULL
  AND server_device_id IS NOT NULL;
'@
    $BindingCount = Invoke-MarkeiAndroidSqliteText -Sql $BindingCountSql
    if ($BindingCount -ne "1") {
        [pscustomobject]@{
            ActiveHostedBindingCount = $BindingCount
            Terminal = "android-hosted-scope-ambiguous"
        }
        throw "Expected exactly one active Android hosted binding."
    }

    $ProbeSql = @'
.bail on
.headers on
.mode column
.nullvalue [null]
PRAGMA query_only = ON;
BEGIN;

.print === ANDROID_PROBE_0_SCHEMA ===
SELECT
  13 AS expected_table_count,
  COUNT(*) AS observed_table_count
FROM sqlite_master
WHERE type = 'table'
  AND name IN (
    'local_accounts',
    'devices',
    'installation_metadata',
    'hosted_auth_states',
    'sync_state',
    'purchases',
    'purchase_items',
    'sync_inbox',
    'sync_events',
    'pending_events',
    'sync_submissions',
    'sync_attempts',
    'sync_diagnostic_events'
  );

.print === ANDROID_PROBE_1_ACTIVE_BINDING ===
SELECT
  enrollment_state,
  CASE WHEN account_id IS NULL THEN 0 ELSE 1 END AS has_account_id,
  CASE WHEN server_device_id IS NULL THEN 0 ELSE 1 END AS has_server_device_id,
  CASE WHEN generation IS NULL THEN 0 ELSE 1 END AS has_generation,
  COUNT(*) AS binding_count
FROM hosted_auth_states
WHERE enrollment_state IN ('device-enrolled', 'duplicate-equivalent')
  AND account_id IS NOT NULL
  AND server_device_id IS NOT NULL
GROUP BY
  enrollment_state,
  has_account_id,
  has_server_device_id,
  has_generation;

.print === ANDROID_PROBE_2_HOSTED_LOCAL_SCOPE ===
WITH active_binding AS (
  SELECT account_id, server_device_id
  FROM hosted_auth_states
  WHERE enrollment_state IN ('device-enrolled', 'duplicate-equivalent')
    AND account_id IS NOT NULL
    AND server_device_id IS NOT NULL
)
SELECT
  (SELECT COUNT(*) FROM local_accounts AS a
    JOIN active_binding AS b ON b.account_id = a.id)
    AS local_account_count,
  (SELECT COUNT(*) FROM devices AS d
    JOIN active_binding AS b
      ON b.account_id = d.account_id
     AND b.server_device_id = d.id)
    AS current_device_count,
  COALESCE((
    SELECT d.next_sequence
    FROM devices AS d
    JOIN active_binding AS b
      ON b.account_id = d.account_id
     AND b.server_device_id = d.id
  ), '[null]') AS current_device_next_sequence,
  (SELECT COUNT(*) FROM installation_metadata AS m
    JOIN active_binding AS b
      ON b.account_id = m.account_id
     AND b.server_device_id = m.current_device_id)
    AS current_installation_count,
  (SELECT COUNT(*) FROM sync_state AS s
    JOIN active_binding AS b ON b.account_id = s.account_id)
    AS sync_state_count,
  COALESCE((
    SELECT s.account_cursor
    FROM sync_state AS s
    JOIN active_binding AS b ON b.account_id = s.account_id
  ), '[null]') AS account_cursor;

.print === ANDROID_PROBE_3_FACT_AND_INBOX_COUNTS ===
WITH active_binding AS (
  SELECT account_id, server_device_id
  FROM hosted_auth_states
  WHERE enrollment_state IN ('device-enrolled', 'duplicate-equivalent')
    AND account_id IS NOT NULL
    AND server_device_id IS NOT NULL
)
SELECT
  (SELECT COUNT(*) FROM purchases AS p
    JOIN active_binding AS b ON b.account_id = p.account_id)
    AS hosted_purchase_count,
  (SELECT COUNT(*) FROM purchase_items AS pi
    JOIN purchases AS p ON p.id = pi.purchase_id
    JOIN active_binding AS b ON b.account_id = p.account_id)
    AS hosted_purchase_item_count,
  (SELECT COUNT(*) FROM sync_inbox AS i
    JOIN active_binding AS b ON b.account_id = i.account_id)
    AS sync_inbox_count,
  (SELECT COUNT(DISTINCT i.event_id) FROM sync_inbox AS i
    JOIN active_binding AS b ON b.account_id = i.account_id)
    AS distinct_inbox_event_count,
  (SELECT COUNT(DISTINCT i.server_cursor) FROM sync_inbox AS i
    JOIN active_binding AS b ON b.account_id = i.account_id)
    AS distinct_inbox_cursor_count,
  COALESCE((SELECT SUM(CASE WHEN i.state = 'applied' THEN 1 ELSE 0 END)
    FROM sync_inbox AS i
    JOIN active_binding AS b ON b.account_id = i.account_id), 0)
    AS applied_inbox_count,
  (SELECT COUNT(*) FROM sync_events AS e
    JOIN active_binding AS b
      ON b.account_id = e.account_id
     AND b.server_device_id = e.device_id)
    AS android_originated_event_count,
  (SELECT COUNT(*) FROM sync_submissions AS s
    JOIN active_binding AS b
      ON b.account_id = s.account_id
     AND b.server_device_id = s.device_id)
    AS android_submission_count;

.print === ANDROID_PROBE_4_QUEUE_COUNTS ===
WITH active_binding AS (
  SELECT account_id, server_device_id
  FROM hosted_auth_states
  WHERE enrollment_state IN ('device-enrolled', 'duplicate-equivalent')
    AND account_id IS NOT NULL
    AND server_device_id IS NOT NULL
)
SELECT
  COALESCE(SUM(CASE WHEN pe.state = 'pending' THEN 1 ELSE 0 END), 0)
    AS pending_count,
  COALESCE(SUM(CASE WHEN pe.state = 'uploading' THEN 1 ELSE 0 END), 0)
    AS uploading_count,
  COALESCE(SUM(CASE WHEN pe.state = 'failed' THEN 1 ELSE 0 END), 0)
    AS failed_count,
  COALESCE(SUM(CASE WHEN pe.state = 'unknown' THEN 1 ELSE 0 END), 0)
    AS unknown_count
FROM pending_events AS pe
JOIN sync_events AS e ON e.id = pe.event_id
JOIN active_binding AS b
  ON b.account_id = e.account_id
 AND b.server_device_id = e.device_id;

.print === ANDROID_PROBE_5_LATEST_ORDINARY_SYNC ===
SELECT
  operation_kind,
  result_code,
  outcome_class,
  phase,
  COALESCE(latest_stage, '[null]') AS latest_stage,
  COALESCE(recovery_code, '[null]') AS recovery_code,
  CASE WHEN http_status IS NULL THEN 0 ELSE 1 END AS has_http_status,
  response_headers_received,
  COALESCE(elapsed_band, '[null]') AS elapsed_band
FROM sync_attempts
WHERE operation_kind = 'ordinary-sync'
ORDER BY started_at DESC, id DESC
LIMIT 1;

.print === ANDROID_PROBE_6_LATEST_SYNC_DIAGNOSTICS ===
WITH latest_attempt AS (
  SELECT id
  FROM sync_attempts
  WHERE operation_kind = 'ordinary-sync'
  ORDER BY started_at DESC, id DESC
  LIMIT 1
)
SELECT
  d.ordinal,
  d.code,
  COALESCE(d.native_code, '[null]') AS native_code,
  d.severity,
  d.outcome,
  d.phase,
  d.last_proved_phase,
  d.local_mutation_state,
  d.provider_contact_state,
  d.provider_transaction_state,
  d.trusted_response_state,
  d.result_persistence_state,
  COALESCE(d.sanitized_exception_class, '[null]')
    AS sanitized_exception_class,
  d.safe_action,
  d.retryable
FROM sync_diagnostic_events AS d
JOIN latest_attempt AS a ON a.id = d.attempt_id
ORDER BY d.ordinal
LIMIT 25;

ROLLBACK;
'@

    $ProbeOutput = Invoke-MarkeiAndroidSqliteText -Sql $ProbeSql
    $ProbeOutput

    Write-Host "SQLiteIntegrityCheck: ok"
    Write-Host "SQLiteForeignKeyCheckRows: 0"
    Write-Host "SnapshotManifestVerified: True"
    Write-Host "LiveDatabaseQueried: False"
    Write-Host "AndroidAppForceStoppedByGS05: Required"
    Write-Host "RetrySelected: False"
    Write-Host "SyncSelected: False"
    Write-Host "ProviderActionPerformed: False"
    Write-Host "TerminalLocation: repository-root"
}
finally {
    Set-Location -LiteralPath $RepositoryRoot
}
```

### `GS-SQLITE-07` — Correlate Android rollback or convergence state

This is the Android counterpart of `GS-SQLITE-04`. It opens only the
manifest-verified snapshot from `GS-SQLITE-05` through an immutable read-only
URI, requires one active hosted binding and exactly one matching local Device,
and correlates the selected
Account's cursor, facts, inbox, local producer state, queue, latest ordinary
Sync terminal, and sanitized phase chain. The final classification is one of
`failed-download-empty-local-state`, `coherent-local-download-state`, or
`partial-or-ambiguous-local-state`. The classification is local evidence only;
it does not authorize Retry, Sync, repair, acknowledgement, or provider work.

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
        $PathCommand = @(
            Get-Command sqlite3.exe `
                -CommandType Application `
                -All `
                -ErrorAction SilentlyContinue |
                Select-Object -First 1
        )
        if ($PathCommand.Count -eq 1) {
            return $PathCommand[0].Source
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

    function Invoke-MarkeiAndroidSqliteText {
        param([Parameter(Mandatory)] [string]$Sql)

        $Output = $Sql |
            & $SqliteCli -readonly $CopiedDatabaseUri 2>&1
        $ExitCode = $LASTEXITCODE
        if ($ExitCode -ne 0) {
            $Output
            throw "The Android apply-state correlation probe failed."
        }
        return ($Output | Out-String).Trim()
    }

    function Assert-MarkeiAndroidSnapshot {
        if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) {
            throw "Android snapshot manifest not found. Run GS-SQLITE-05."
        }
        try {
            $Manifest = Get-Content -LiteralPath $ManifestPath -Raw |
                ConvertFrom-Json
        }
        catch {
            throw "Android snapshot manifest is unreadable."
        }
        if ($Manifest.Format -cne "markei-android-sqlite-snapshot-v1") {
            throw "Android snapshot manifest format is unsupported."
        }
        $ManifestFiles = @($Manifest.Files)
        if ($ManifestFiles.Count -lt 1 -or $ManifestFiles.Count -gt 3) {
            throw "Android snapshot manifest file count is invalid."
        }
        $AllowedNames = @(
            "markei_shared_beta.sqlite"
            "markei_shared_beta.sqlite-wal"
            "markei_shared_beta.sqlite-shm"
        )
        if (@($ManifestFiles.Name | Select-Object -Unique).Count -ne
            $ManifestFiles.Count -or
            $ManifestFiles.Name -notcontains "markei_shared_beta.sqlite") {
            throw "Android snapshot manifest membership is invalid."
        }
        foreach ($Entry in $ManifestFiles) {
            if ($Entry.Name -notin $AllowedNames -or
                ([string]$Entry.Length) -notmatch '^\d+$' -or
                ([string]$Entry.Sha256) -notmatch '^[A-Fa-f0-9]{64}$') {
                throw "Android snapshot manifest entry is invalid."
            }
            $SnapshotFile = Join-Path $SnapshotDirectory $Entry.Name
            if (-not (Test-Path -LiteralPath $SnapshotFile -PathType Leaf)) {
                throw "An Android snapshot file is absent."
            }
            $SnapshotInfo = Get-Item -LiteralPath $SnapshotFile
            $SnapshotHash = (
                Get-FileHash -LiteralPath $SnapshotFile -Algorithm SHA256
            ).Hash
            if ($SnapshotInfo.Length -ne [int64]$Entry.Length -or
                $SnapshotHash -ine [string]$Entry.Sha256) {
                throw "Android snapshot no longer matches its manifest."
            }
        }
    }

    $SqliteCli = Resolve-MarkeiSqliteCli
    $SnapshotDirectory = Join-Path `
        ([System.IO.Path]::GetTempPath()) `
        "markei-android-sqlite-current"
    $CopiedDatabase = Join-Path `
        $SnapshotDirectory `
        "markei_shared_beta.sqlite"
    $ManifestPath = Join-Path `
        $SnapshotDirectory `
        "snapshot-manifest.json"
    Assert-MarkeiAndroidSnapshot
    $CopiedDatabaseUri = (
        New-Object System.Uri($CopiedDatabase)
    ).AbsoluteUri + "?immutable=1"

    $IntegrityCheck = Invoke-MarkeiAndroidSqliteText `
        -Sql "PRAGMA integrity_check;"
    if ($IntegrityCheck -ne "ok") {
        throw "Copied Android database integrity_check was not exactly 'ok'."
    }
    $ForeignKeyCheck = Invoke-MarkeiAndroidSqliteText `
        -Sql "PRAGMA foreign_key_check;"
    if (-not [string]::IsNullOrWhiteSpace($ForeignKeyCheck)) {
        throw "Copied Android database foreign_key_check returned rows."
    }

    $GuardSql = @'
PRAGMA query_only = ON;
WITH active_binding AS (
  SELECT account_id, server_device_id
  FROM hosted_auth_states
  WHERE enrollment_state IN ('device-enrolled', 'duplicate-equivalent')
    AND account_id IS NOT NULL
    AND server_device_id IS NOT NULL
)
SELECT
  (SELECT COUNT(*) FROM active_binding) || '|' ||
  (SELECT COUNT(*)
   FROM devices AS d
   JOIN active_binding AS b
     ON b.account_id = d.account_id
    AND b.server_device_id = d.id);
'@
    $GuardResult = Invoke-MarkeiAndroidSqliteText -Sql $GuardSql
    if ($GuardResult -ne "1|1") {
        [pscustomobject]@{
            BindingAndDeviceGuard = $GuardResult
            Terminal = "android-apply-scope-ambiguous"
        }
        throw "Expected one active binding and one matching local Device."
    }

    $ProbeSql = @'
.bail on
.headers on
.mode column
.nullvalue [null]
PRAGMA query_only = ON;
BEGIN;

.print === ANDROID_CORRELATION_0_SCOPE ===
WITH active_binding AS (
  SELECT account_id, server_device_id, enrollment_state
  FROM hosted_auth_states
  WHERE enrollment_state IN ('device-enrolled', 'duplicate-equivalent')
    AND account_id IS NOT NULL
    AND server_device_id IS NOT NULL
)
SELECT
  b.enrollment_state,
  COUNT(DISTINCT b.account_id) AS active_account_scope_count,
  COUNT(d.id) AS current_device_count,
  MIN(d.next_sequence) AS current_device_next_sequence,
  COUNT(m.id) AS current_installation_count
FROM active_binding AS b
JOIN devices AS d
  ON d.account_id = b.account_id
 AND d.id = b.server_device_id
LEFT JOIN installation_metadata AS m
  ON m.account_id = b.account_id
 AND m.current_device_id = b.server_device_id
GROUP BY b.enrollment_state;

.print === ANDROID_CORRELATION_1_CURSOR_INBOX_FACTS ===
WITH active_binding AS (
  SELECT account_id
  FROM hosted_auth_states
  WHERE enrollment_state IN ('device-enrolled', 'duplicate-equivalent')
    AND account_id IS NOT NULL
    AND server_device_id IS NOT NULL
),
inbox_summary AS (
  SELECT
    COUNT(*) AS inbox_count,
    COUNT(DISTINCT i.event_id) AS distinct_event_count,
    COUNT(DISTINCT i.server_cursor) AS distinct_cursor_count,
    SUM(CASE WHEN i.state = 'applied' THEN 1 ELSE 0 END)
      AS applied_count,
    MAX(
      CASE
        WHEN i.server_cursor GLOB 'c10b:[0-9]*'
        THEN CAST(substr(i.server_cursor, 6) AS INTEGER)
      END
    ) AS cursor_high_water
  FROM sync_inbox AS i
  JOIN active_binding AS b ON b.account_id = i.account_id
)
SELECT
  (SELECT COUNT(*) FROM sync_state AS s
    JOIN active_binding AS b ON b.account_id = s.account_id)
    AS sync_state_count,
  COALESCE((
    SELECT s.account_cursor
    FROM sync_state AS s
    JOIN active_binding AS b ON b.account_id = s.account_id
  ), '[null]') AS account_cursor,
  CASE
    WHEN (
      SELECT s.account_cursor
      FROM sync_state AS s
      JOIN active_binding AS b ON b.account_id = s.account_id
    ) GLOB 'c10b:[0-9]*'
    THEN CAST(substr((
      SELECT s.account_cursor
      FROM sync_state AS s
      JOIN active_binding AS b ON b.account_id = s.account_id
    ), 6) AS INTEGER)
    ELSE NULL
  END AS account_cursor_number,
  COALESCE(ins.inbox_count, 0) AS inbox_count,
  COALESCE(ins.distinct_event_count, 0) AS distinct_inbox_event_count,
  COALESCE(ins.distinct_cursor_count, 0) AS distinct_inbox_cursor_count,
  COALESCE(ins.applied_count, 0) AS applied_inbox_count,
  COALESCE(ins.cursor_high_water, 0) AS inbox_cursor_high_water,
  (SELECT COUNT(*) FROM purchases AS p
    JOIN active_binding AS b ON b.account_id = p.account_id)
    AS hosted_purchase_count,
  (SELECT COUNT(*) FROM purchase_items AS pi
    JOIN purchases AS p ON p.id = pi.purchase_id
    JOIN active_binding AS b ON b.account_id = p.account_id)
    AS hosted_purchase_item_count
FROM inbox_summary AS ins;

.print === ANDROID_CORRELATION_2_LOCAL_PRODUCER_QUEUE ===
WITH active_binding AS (
  SELECT account_id, server_device_id
  FROM hosted_auth_states
  WHERE enrollment_state IN ('device-enrolled', 'duplicate-equivalent')
    AND account_id IS NOT NULL
    AND server_device_id IS NOT NULL
),
queue_summary AS (
  SELECT
    SUM(CASE WHEN pe.state = 'pending' THEN 1 ELSE 0 END)
      AS pending_count,
    SUM(CASE WHEN pe.state = 'uploading' THEN 1 ELSE 0 END)
      AS uploading_count,
    SUM(CASE WHEN pe.state = 'failed' THEN 1 ELSE 0 END)
      AS failed_count,
    SUM(CASE WHEN pe.state = 'unknown' THEN 1 ELSE 0 END)
      AS unknown_count
  FROM pending_events AS pe
  JOIN sync_events AS e ON e.id = pe.event_id
  JOIN active_binding AS b
    ON b.account_id = e.account_id
   AND b.server_device_id = e.device_id
)
SELECT
  d.next_sequence AS current_device_next_sequence,
  (SELECT COUNT(*) FROM sync_events AS e
    JOIN active_binding AS b
      ON b.account_id = e.account_id
     AND b.server_device_id = e.device_id)
    AS android_originated_event_count,
  (SELECT COUNT(*) FROM sync_submissions AS s
    JOIN active_binding AS b
      ON b.account_id = s.account_id
     AND b.server_device_id = s.device_id)
    AS android_submission_count,
  COALESCE(q.pending_count, 0) AS pending_count,
  COALESCE(q.uploading_count, 0) AS uploading_count,
  COALESCE(q.failed_count, 0) AS failed_count,
  COALESCE(q.unknown_count, 0) AS unknown_count
FROM devices AS d
JOIN active_binding AS b
  ON b.account_id = d.account_id
 AND b.server_device_id = d.id
CROSS JOIN queue_summary AS q;

.print === ANDROID_CORRELATION_3_LATEST_SYNC_CHAIN ===
WITH latest_attempt AS (
  SELECT *
  FROM sync_attempts
  WHERE operation_kind = 'ordinary-sync'
  ORDER BY started_at DESC, id DESC
  LIMIT 1
)
SELECT
  a.operation_kind,
  a.result_code,
  a.outcome_class,
  a.phase,
  COALESCE(a.latest_stage, '[null]') AS latest_stage,
  COALESCE(a.recovery_code, '[null]') AS recovery_code,
  CASE WHEN a.http_status IS NULL THEN 0 ELSE 1 END AS has_http_status,
  a.response_headers_received,
  SUM(CASE WHEN d.native_code = 'download-response-received'
           THEN 1 ELSE 0 END) AS download_response_received_count,
  SUM(CASE WHEN d.native_code = 'acknowledgement-request-started'
           THEN 1 ELSE 0 END) AS acknowledgement_started_count,
  SUM(CASE WHEN d.native_code = 'sync-completed'
           THEN 1 ELSE 0 END) AS sync_completed_count,
  SUM(CASE WHEN d.native_code = 'closure-runner-exception'
           THEN 1 ELSE 0 END) AS closure_runner_exception_count,
  COALESCE(MAX(d.sanitized_exception_class), '[null]')
    AS sanitized_exception_class
FROM latest_attempt AS a
LEFT JOIN sync_diagnostic_events AS d ON d.attempt_id = a.id
GROUP BY
  a.operation_kind,
  a.result_code,
  a.outcome_class,
  a.phase,
  a.latest_stage,
  a.recovery_code,
  a.http_status,
  a.response_headers_received;

.print === ANDROID_CORRELATION_4_SANITIZED_PHASES ===
WITH latest_attempt AS (
  SELECT id
  FROM sync_attempts
  WHERE operation_kind = 'ordinary-sync'
  ORDER BY started_at DESC, id DESC
  LIMIT 1
)
SELECT
  d.ordinal,
  d.code,
  COALESCE(d.native_code, '[null]') AS native_code,
  d.phase,
  d.last_proved_phase,
  d.local_mutation_state,
  d.provider_contact_state,
  d.provider_transaction_state,
  d.trusted_response_state,
  d.result_persistence_state,
  COALESCE(d.sanitized_exception_class, '[null]')
    AS sanitized_exception_class,
  d.safe_action,
  d.retryable
FROM sync_diagnostic_events AS d
JOIN latest_attempt AS a ON a.id = d.attempt_id
ORDER BY d.ordinal
LIMIT 25;

.print === ANDROID_CORRELATION_5_LOCAL_STATE_CLASS ===
WITH active_binding AS (
  SELECT account_id, server_device_id
  FROM hosted_auth_states
  WHERE enrollment_state IN ('device-enrolled', 'duplicate-equivalent')
    AND account_id IS NOT NULL
    AND server_device_id IS NOT NULL
),
state_summary AS (
  SELECT
    (SELECT s.account_cursor FROM sync_state AS s
      JOIN active_binding AS b ON b.account_id = s.account_id)
      AS account_cursor,
    (SELECT COUNT(*) FROM sync_inbox AS i
      JOIN active_binding AS b ON b.account_id = i.account_id)
      AS inbox_count,
    (SELECT COUNT(DISTINCT i.event_id) FROM sync_inbox AS i
      JOIN active_binding AS b ON b.account_id = i.account_id)
      AS distinct_inbox_events,
    (SELECT COUNT(DISTINCT i.server_cursor) FROM sync_inbox AS i
      JOIN active_binding AS b ON b.account_id = i.account_id)
      AS distinct_inbox_cursors,
    (SELECT SUM(CASE WHEN i.state = 'applied' THEN 1 ELSE 0 END)
      FROM sync_inbox AS i
      JOIN active_binding AS b ON b.account_id = i.account_id)
      AS applied_inbox_count,
    (SELECT MAX(
       CASE
         WHEN i.server_cursor GLOB 'c10b:[0-9]*'
         THEN CAST(substr(i.server_cursor, 6) AS INTEGER)
       END
     ) FROM sync_inbox AS i
      JOIN active_binding AS b ON b.account_id = i.account_id)
      AS inbox_cursor_high_water,
    (SELECT COUNT(*) FROM purchases AS p
      JOIN active_binding AS b ON b.account_id = p.account_id)
      AS purchase_count,
    (SELECT COUNT(*) FROM purchase_items AS pi
      JOIN purchases AS p ON p.id = pi.purchase_id
      JOIN active_binding AS b ON b.account_id = p.account_id)
      AS purchase_item_count,
    (SELECT COUNT(*) FROM sync_events AS e
      JOIN active_binding AS b
        ON b.account_id = e.account_id
       AND b.server_device_id = e.device_id)
      AS local_event_count,
    (SELECT COUNT(*) FROM pending_events AS pe
      JOIN sync_events AS e ON e.id = pe.event_id
      JOIN active_binding AS b
        ON b.account_id = e.account_id
       AND b.server_device_id = e.device_id)
      AS queue_count,
    (SELECT COUNT(*) FROM sync_diagnostic_events AS d
      JOIN sync_attempts AS a ON a.id = d.attempt_id
      WHERE a.operation_kind = 'ordinary-sync'
        AND a.id = (
          SELECT id FROM sync_attempts
          WHERE operation_kind = 'ordinary-sync'
          ORDER BY started_at DESC, id DESC LIMIT 1
        )
        AND d.native_code = 'download-response-received')
      AS download_response_received_count,
    (SELECT result_code FROM sync_attempts
      WHERE operation_kind = 'ordinary-sync'
      ORDER BY started_at DESC, id DESC LIMIT 1)
      AS latest_sync_result
)
SELECT
  CASE
    WHEN account_cursor IS NULL
     AND inbox_count = 0
     AND purchase_count = 0
     AND purchase_item_count = 0
     AND local_event_count = 0
     AND queue_count = 0
     AND latest_sync_result = 'sync-failed'
     AND download_response_received_count > 0
      THEN 'failed-download-empty-local-state'
    WHEN account_cursor GLOB 'c10b:[0-9]*'
     AND inbox_count > 0
     AND inbox_count = distinct_inbox_events
     AND inbox_count = distinct_inbox_cursors
     AND inbox_count = COALESCE(applied_inbox_count, 0)
     AND CAST(substr(account_cursor, 6) AS INTEGER) =
         inbox_cursor_high_water
     AND purchase_count > 0
     AND purchase_item_count > 0
     AND local_event_count = 0
     AND queue_count = 0
      THEN 'coherent-local-download-state'
    ELSE 'partial-or-ambiguous-local-state'
  END AS android_local_state_class
FROM state_summary;

ROLLBACK;
'@

    $ProbeOutput = Invoke-MarkeiAndroidSqliteText -Sql $ProbeSql
    $ProbeOutput

    Write-Host "SQLiteIntegrityCheck: ok"
    Write-Host "SQLiteForeignKeyCheckRows: 0"
    Write-Host "SnapshotManifestVerified: True"
    Write-Host "ExactHostedScopeGuard: 1|1"
    Write-Host "LiveDatabaseQueried: False"
    Write-Host "RetrySelected: False"
    Write-Host "SyncSelected: False"
    Write-Host "RecoverySelected: False"
    Write-Host "ProviderActionPerformed: False"
    Write-Host "LocalDatabaseModified: False"
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
    $NotBeforeProperty = $Claims.PSObject.Properties["nbf"]
    $NotBeforeSeconds = 0L
    $NotBeforeValid = (
        $null -eq $NotBeforeProperty -or
        (
            [long]::TryParse(
                [string]$NotBeforeProperty.Value,
                [ref]$NotBeforeSeconds
            ) -and
            $NotBeforeSeconds -le $Now
        )
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

### `GS-AUTH-03` — Guarded Account/membership provisioning

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-12` /
`account-membership-provision`.

This development-only bridge provisions the Account/membership required before
the rebuilt Windows client can enroll its Device. It accepts one fresh raw
Auth0 user access token through a masked prompt, derives the identity subject
locally, and never asks the operator to transcribe a subject or UUID.

The hosted `GET /v1/identity?verification=token` mode must first accept the
token cryptographically and return `token-accepted` without requiring or
querying provider membership state. The procedure then invokes one
migrator-only database action. The launcher independently requests exact
`PROVISION <BranchAlias> <Database>` confirmation and the migrator password.
After the transaction commits, the ordinary `GET /v1/identity` membership mode
must return `membership-confirmed`.

```powershell
$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$RepositoryRoot = (& git rev-parse --show-toplevel).Trim()
if ($LASTEXITCODE -ne 0 -or
    [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
    throw "Run this command from inside the Markei repository."
}

$Launcher = Join-Path $RepositoryRoot "documentation\I_SCRIPTS.ps1"
$NsPath = Join-Path $RepositoryRoot "documentation\NS_COORDINATES.md"
if (-not (Test-Path -LiteralPath $Launcher -PathType Leaf) -or
    -not (Test-Path -LiteralPath $NsPath -PathType Leaf)) {
    throw "The canonical GRM launcher or coordinate file is missing."
}

try {
    Set-Location -LiteralPath $RepositoryRoot

    # Provisioning is allowed only from the exact clean remote-aligned source.
    & $Launcher -Procedure "GS-GIT-01"
    # Re-prove the live and database-readiness contracts immediately before
    # accepting a session-only token or permitting provider provisioning.
    & $Launcher -Procedure "GS-HOST-01"

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

    function Get-JsonProperty {
        param(
            [Parameter(Mandatory)] [object]$Object,
            [Parameter(Mandatory)] [string]$Name
        )
        $Property = $Object.PSObject.Properties[$Name]
        if ($null -eq $Property) {
            return $null
        }
        return $Property.Value
    }

    function Invoke-HostedIdentityState {
        param(
            [Parameter(Mandatory)] [uri]$Uri,
            [Parameter(Mandatory)] [hashtable]$Headers,
            [Parameter(Mandatory)] [string]$Phase
        )
        try {
            $Response = Invoke-WebRequest `
                -UseBasicParsing `
                -Uri $Uri `
                -Method Get `
                -Headers $Headers `
                -MaximumRedirection 0
        }
        catch {
            $Status = $null
            $FailureResponse = $_.Exception.Response
            if ($null -ne $FailureResponse) {
                $Status = [int]$FailureResponse.StatusCode
            }
            if ($null -ne $Status) {
                $FailureContent = $null
                $FailureStream = $null
                $FailureReader = $null
                try {
                    $ContentProperty = $FailureResponse.PSObject.Properties[
                        "Content"
                    ]
                    if ($null -ne $ContentProperty -and
                        $ContentProperty.Value -is [string]) {
                        $FailureContent = [string]$ContentProperty.Value
                    }
                    elseif ($null -ne $FailureResponse.PSObject.Methods[
                            "GetResponseStream"
                        ]) {
                        $FailureStream = $FailureResponse.GetResponseStream()
                        if ($null -ne $FailureStream) {
                            $FailureReader = [IO.StreamReader]::new(
                                $FailureStream
                            )
                            $FailureContent = $FailureReader.ReadToEnd()
                        }
                    }
                    elseif ($null -ne $ContentProperty -and
                        $null -ne $ContentProperty.Value -and
                        $null -ne $ContentProperty.Value.PSObject.Methods[
                            "ReadAsStringAsync"
                        ]) {
                        $ContentTask =
                            $ContentProperty.Value.ReadAsStringAsync()
                        $FailureContent =
                            $ContentTask.GetAwaiter().GetResult()
                        $ContentTask = $null
                    }
                }
                catch {
                    $FailureContent = $null
                }
                finally {
                    if ($null -ne $FailureReader) {
                        $FailureReader.Dispose()
                    }
                    if ($null -ne $FailureStream) {
                        $FailureStream.Dispose()
                    }
                }

                $SafeFailureFields = @()
                if (-not [string]::IsNullOrWhiteSpace($FailureContent) -and
                    [Text.Encoding]::UTF8.GetByteCount($FailureContent) -le
                        16384) {
                    try {
                        $FailureBody = $FailureContent | ConvertFrom-Json
                        foreach ($FieldName in @(
                                "code",
                                "diagnosticCode",
                                "operation",
                                "phase",
                                "lastProvedPhase",
                                "correlationFingerprint"
                            )) {
                            $FieldProperty = $FailureBody.PSObject.Properties[
                                $FieldName
                            ]
                            if ($null -ne $FieldProperty -and
                                $FieldProperty.Value -is [string] -and
                                $FieldProperty.Value -match
                                    '^[A-Za-z0-9._:-]{1,96}$') {
                                $SafeFailureFields += (
                                    "{0}={1}" -f
                                    $FieldName,
                                    $FieldProperty.Value
                                )
                            }
                        }
                    }
                    catch {
                        $SafeFailureFields = @()
                    }
                    finally {
                        $FailureBody = $null
                    }
                }
                $FailureContent = $null
                $FailureResponse = $null
                $FailureSummary = if ($SafeFailureFields.Count -gt 0) {
                    $SafeFailureFields -join "; "
                }
                else {
                    "no-sanitized-diagnostic"
                }
                throw (
                    "$Phase hosted identity verification returned HTTP " +
                    "$Status; $FailureSummary."
                )
            }
            throw "$Phase hosted identity verification was unavailable."
        }
        if ([int]$Response.StatusCode -ne 200) {
            throw "$Phase hosted identity verification did not return HTTP 200."
        }
        try {
            $Body = $Response.Content | ConvertFrom-Json
        }
        catch {
            throw "$Phase hosted identity response was not valid JSON."
        }
        $StateProperty = $Body.PSObject.Properties["state"]
        if ($null -eq $StateProperty -or
            $StateProperty.Value -isnot [string] -or
            [string]::IsNullOrWhiteSpace($StateProperty.Value)) {
            throw "$Phase hosted identity response had no state classification."
        }
        $State = [string]$StateProperty.Value
        $Body = $null
        $Response = $null
        return $State
    }

    $ExpectedEnvironment = Get-NsCoordinate "Environment"
    $ExpectedBranchAlias = Get-NsCoordinate "BranchAlias"
    $ExpectedDatabase = Get-NsCoordinate "Database"
    $ExpectedMigrator = Get-NsCoordinate "MigratorUser"
    $Origin = (Get-NsCoordinate "RenderPublicOrigin").TrimEnd("/")
    $IdentityPath = Get-NsCoordinate "RenderIdentityPath"
    $IssuerCoordinate = Get-NsCoordinate "Auth0Issuer"
    $Audience = Get-NsCoordinate "Auth0Audience"
    $Algorithm = Get-NsCoordinate "Auth0Algorithm"
    $JwksPath = Get-NsCoordinate "Auth0JwksPath"

    if ($ExpectedEnvironment -ne "development" -or
        $ExpectedBranchAlias -notmatch '^[A-Za-z0-9][A-Za-z0-9_-]*$' -or
        $ExpectedDatabase -notmatch '^[A-Za-z_][A-Za-z0-9_-]*$' -or
        $ExpectedMigrator -notmatch '^[A-Za-z_][A-Za-z0-9_-]*$') {
        throw "Guarded provisioning is locked to the reviewed development target."
    }

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

    $IssuerUri = $null
    if (-not [uri]::TryCreate(
            $IssuerCoordinate,
            [UriKind]::Absolute,
            [ref]$IssuerUri
        ) -or
        $IssuerUri.Scheme -ne "https" -or
        -not [string]::IsNullOrEmpty($IssuerUri.UserInfo) -or
        -not [string]::IsNullOrEmpty($IssuerUri.Query) -or
        -not [string]::IsNullOrEmpty($IssuerUri.Fragment)) {
        throw "Auth0Issuer must be a secret-free HTTPS issuer."
    }

    $OriginBase = [uri]($Origin + "/")
    $IdentityUri = [uri]::new(
        $OriginBase,
        $IdentityPath.TrimStart([char]"/")
    )
    $TokenVerificationBuilder = [UriBuilder]::new($IdentityUri)
    $TokenVerificationBuilder.Query = "verification=token"
    $TokenVerificationUri = $TokenVerificationBuilder.Uri
    $IssuerBase = [uri]($IssuerCoordinate.TrimEnd("/") + "/")
    $JwksUri = [uri]::new(
        $IssuerBase,
        $JwksPath.TrimStart([char]"/")
    )

    $TokenSecure = Read-Host `
        "Paste a fresh Auth0 USER access token (masked; session only)" `
        -AsSecureString

    $TokenBstr = [IntPtr]::Zero
    $AccessToken = $null
    $Subject = $null
    $AuthorizationHeaders = $null
    $Claims = $null
    $Header = $null
    $Jwks = $null
    $JwksKeys = $null
    $MatchingTokenKeys = $null
    $TokenIssuer = $null
    $TokenAudience = $null
    $TokenSubject = $null
    $TokenExpiry = $null
    $TokenNotBefore = $null
    $TokenAlgorithm = $null
    $TokenKeyId = $null

    try {
        $TokenBstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR(
            $TokenSecure
        )
        $AccessToken = [Runtime.InteropServices.Marshal]::PtrToStringBSTR(
            $TokenBstr
        ).Trim()
        if ([string]::IsNullOrWhiteSpace($AccessToken) -or
            $AccessToken.StartsWith(
                "Bearer ",
                [StringComparison]::OrdinalIgnoreCase
            )) {
            throw "Enter only the raw access token, without the Bearer prefix."
        }
        if ([Text.Encoding]::UTF8.GetByteCount($AccessToken) -gt 8192) {
            throw "The access token exceeds the hosted verifier limit."
        }

        $Parts = $AccessToken.Split(".")
        if ($Parts.Count -ne 3) {
            throw "The access token is not a three-part JWT."
        }
        $Header = ConvertFrom-Base64UrlJson $Parts[0]
        $Claims = ConvertFrom-Base64UrlJson $Parts[1]

        $TokenIssuer = Get-JsonProperty $Claims "iss"
        $TokenAudience = Get-JsonProperty $Claims "aud"
        $TokenSubject = Get-JsonProperty $Claims "sub"
        $TokenExpiry = Get-JsonProperty $Claims "exp"
        $TokenNotBefore = Get-JsonProperty $Claims "nbf"
        $TokenAlgorithm = Get-JsonProperty $Header "alg"
        $TokenKeyId = Get-JsonProperty $Header "kid"

        $IssuerMatches = (
            $TokenIssuer -is [string] -and
            $TokenIssuer.TrimEnd("/") -eq $IssuerCoordinate.TrimEnd("/")
        )
        $AudienceMatches = (@($TokenAudience) -contains $Audience)
        $AlgorithmMatches = (
            $TokenAlgorithm -eq $Algorithm -and
            $Algorithm -eq "RS256"
        )
        $KidPresent = (
            $TokenKeyId -is [string] -and
            -not [string]::IsNullOrWhiteSpace($TokenKeyId)
        )
        $SubjectPresent = (
            $TokenSubject -is [string] -and
            -not [string]::IsNullOrWhiteSpace($TokenSubject) -and
            $TokenSubject.Length -le 256 -and
            $TokenSubject -notmatch '[\x00-\x1f\x7f]'
        )

        $Now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
        $ExpirySeconds = 0L
        $ExpiryValid = (
            $null -ne $TokenExpiry -and
            [long]::TryParse(
                [string]$TokenExpiry,
                [ref]$ExpirySeconds
            ) -and
            $ExpirySeconds -gt ($Now + 30)
        )
        $NotBeforeSeconds = 0L
        $NotBeforeValid = (
            $null -eq $TokenNotBefore -or
            (
                [long]::TryParse(
                    [string]$TokenNotBefore,
                    [ref]$NotBeforeSeconds
                ) -and
                $NotBeforeSeconds -le ($Now + 30)
            )
        )
        $TimeWindowValid = $ExpiryValid -and $NotBeforeValid

        if (-not $IssuerMatches -or
            -not $AudienceMatches -or
            -not $AlgorithmMatches -or
            -not $KidPresent -or
            -not $SubjectPresent -or
            -not $TimeWindowValid) {
            throw "The token claims do not match the guarded Auth0 contract."
        }

        $Jwks = Invoke-RestMethod -Method Get -Uri $JwksUri
        $JwksKeys = Get-JsonProperty $Jwks "keys"
        if ($null -eq $JwksKeys) {
            throw "The JWKS document had no keys collection."
        }
        $MatchingTokenKeys = @($JwksKeys | Where-Object {
            (Get-JsonProperty $_ "kid") -eq $TokenKeyId -and
            (Get-JsonProperty $_ "kty") -eq "RSA" -and
            (Get-JsonProperty $_ "use") -eq "sig" -and
            (Get-JsonProperty $_ "alg") -eq $Algorithm
        })
        if ($MatchingTokenKeys.Count -ne 1) {
            throw "The token kid did not select exactly one RS256 signing key."
        }

        $AuthorizationHeaders = @{
            Authorization = "Bearer $AccessToken"
        }
        $PreProvisioningState = Invoke-HostedIdentityState `
            -Uri $TokenVerificationUri `
            -Headers $AuthorizationHeaders `
            -Phase "Pre-provisioning"
        if ($PreProvisioningState -ne "token-accepted") {
            throw "Hosted identity did not cryptographically accept the token."
        }

        $Subject = [string]$TokenSubject
        Write-Host (
            "PASS: hosted token accepted; pre-provisioning state = {0}" -f
            $PreProvisioningState
        ) -ForegroundColor Green

        & $Launcher `
            -ConfigPath $NsPath `
            -Role migrator `
            -Action account-membership-provision `
            -IdentitySubject $Subject

        $PostProvisioningState = Invoke-HostedIdentityState `
            -Uri $IdentityUri `
            -Headers $AuthorizationHeaders `
            -Phase "Post-provisioning"
        if ($PostProvisioningState -ne "membership-confirmed") {
            throw "Hosted identity did not confirm the provisioned membership."
        }

        [pscustomobject]@{
            IssuerMatches = $IssuerMatches
            AudienceMatches = $AudienceMatches
            AlgorithmMatches = $AlgorithmMatches
            TokenSigningKeyMatches = $MatchingTokenKeys.Count
            HostedTokenAccepted = $true
            PreProvisioningState = $PreProvisioningState
            DatabaseProvisioning = "committed-or-idempotent"
            PostProvisioningState = $PostProvisioningState
            ReadyForDeviceEnrollment = $true
        }
    }
    finally {
        if ($null -ne $AuthorizationHeaders) {
            $AuthorizationHeaders.Clear()
        }
        $AccessToken = $null
        $Subject = $null
        $Claims = $null
        $Header = $null
        $Jwks = $null
        $JwksKeys = $null
        $MatchingTokenKeys = $null
        $TokenIssuer = $null
        $TokenAudience = $null
        $TokenSubject = $null
        $TokenExpiry = $null
        $TokenNotBefore = $null
        $TokenAlgorithm = $null
        $TokenKeyId = $null
        if ($TokenBstr -ne [IntPtr]::Zero) {
            [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($TokenBstr)
        }
        Remove-Variable TokenSecure -ErrorAction SilentlyContinue
    }
}
finally {
    Set-Location -LiteralPath $RepositoryRoot
}
```

The database action generates independent random Account and identity UUIDs in
the launcher. It never derives identifiers from the Auth0 subject. New
provisioning is allowed only when all application tables are empty. A same-user
rerun succeeds only when the provider still has exactly one Account, one
external identity, one active owner membership, and one Account cursor row.
Every mismatch aborts and rolls back.

The complete reconstruction-to-enrollment route is:

```text
GRM-GIT-01
→ GRM-HOST-01
→ GRM-AUTH-01
→ GRM-FLUTTER-WIN
→ GRM-FLUTTER-DBW
→ launch `Markei Windows Closure (debug)` with F5
→ Sign in under the required breakpoint; do not Enroll
→ acquire one fresh raw user access token through the established secure path
→ GRM-AUTH-03
→ Enroll exactly once in the same Windows client
→ close and reopen the client
→ Diagnostics
→ GRM-AUTH-02
→ GRM-NEON-11
→ stop before Sync until the controlled assay is explicitly authorized
```

Never paste the token, subject, Account UUID, identity UUID, Device UUID,
password, or database URL into chat, Git, or notebook files. The Windows
client retains its own token for Enroll; `GS-AUTH-03` does not export,
intercept, or print client credentials.

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
    flutter test --concurrency=1 --no-pub
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

$SourceIdentityHelper = Join-Path `
    $ClientRoot `
    "tool\resolve_markei_source_identity.ps1"
if (-not (Test-Path -LiteralPath $SourceIdentityHelper -PathType Leaf)) {
    throw "Shared Markei source identity helper is missing."
}
$SourceIdentity = & $SourceIdentityHelper `
    -RepositoryRoot $RepositoryRoot `
    -Json |
    ConvertFrom-Json
if ($LASTEXITCODE -ne 0) {
    throw "Shared Markei source identity resolution failed."
}
if ($SourceIdentity.SourceRevision -notmatch '^[a-f0-9]{40}$' -or
    $SourceIdentity.SourceTreeSha256 -notmatch '^[a-f0-9]{64}$') {
    throw "Shared Markei source identity returned malformed fields."
}

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
    "--dart-define=MARKEI_SOURCE_REVISION=$($SourceIdentity.SourceRevision)"
    "--dart-define=MARKEI_SOURCE_TREE_SHA256=$($SourceIdentity.SourceTreeSha256)"
    "--dart-define=MARKEI_AUTH0_DOMAIN=$Auth0Domain"
    "--dart-define=MARKEI_AUTH0_AUDIENCE=$Auth0Audience"
    "--dart-define=MARKEI_AUTH0_WINDOWS_CLIENT_ID=$WindowsClientId"
    "--dart-define=MARKEI_HOSTED_HTTPS_ORIGIN=$HostedOrigin"
)
if ($FlutterDefines -notcontains $RequiredClosureSurfaceDefine) {
    throw "Windows Closure UI define is missing; refusing to build or run."
}

$GeneratedStateTargets = @(
    [pscustomobject][ordered]@{
        Name = "Dart package tool state"
        RelativePath = ".dart_tool"
        Kind = "directory"
    }
    [pscustomobject][ordered]@{
        Name = "Windows Flutter ephemeral state"
        RelativePath = "windows\flutter\ephemeral"
        Kind = "directory"
    }
    [pscustomobject][ordered]@{
        Name = "Windows build output"
        RelativePath = "build\windows"
        Kind = "directory"
    }
)

function Get-ContainedClientGeneratedPath {
    param([Parameter(Mandatory)] [string]$RelativePath)

    if ([string]::IsNullOrWhiteSpace($RelativePath) -or
        [IO.Path]::IsPathRooted($RelativePath) -or
        $RelativePath -match '[*?]' -or
        $RelativePath -split '[\\/]' -contains '..') {
        throw "Generated-state target is not one bounded relative path."
    }

    $ClientDirectory = Get-Item -LiteralPath $ClientRoot
    $ClientFullName = $ClientDirectory.FullName.TrimEnd([char[]]@('\', '/'))
    $ResolvedPath = [IO.Path]::GetFullPath(
        (Join-Path $ClientDirectory.FullName $RelativePath)
    ).TrimEnd([char[]]@('\', '/'))

    if ([string]::Equals(
        $ResolvedPath,
        $ClientFullName,
        [StringComparison]::OrdinalIgnoreCase
    )) {
        throw "Generated-state target resolves to the Flutter client root."
    }
    if (-not $ResolvedPath.StartsWith(
        $ClientFullName + [IO.Path]::DirectorySeparatorChar,
        [StringComparison]::OrdinalIgnoreCase
    )) {
        throw "Generated-state target resolves outside the Flutter client."
    }

    return $ResolvedPath
}

function Get-WindowsBuildProcessObservations {
    $ObservedNames = @("markei", "flutter", "dart")
    $ClientDirectory = Get-Item -LiteralPath $ClientRoot
    $ClientFullName = $ClientDirectory.FullName.TrimEnd([char[]]@('\', '/'))
    $BuildWindowsPath = Get-ContainedClientGeneratedPath `
        -RelativePath "build\windows"
    $ProcessesById = @{}
    foreach ($ObservedName in $ObservedNames) {
        Get-Process -Name $ObservedName -ErrorAction SilentlyContinue |
            ForEach-Object { $ProcessesById[[int]$_.Id] = $_ }
    }

    $ProcessMetadata = @{}
    try {
        Get-CimInstance Win32_Process `
            -Filter "name = 'markei.exe' or name = 'flutter.bat' or name = 'flutter.exe' or name = 'dart.exe'" |
            ForEach-Object { $ProcessMetadata[[int]$_.ProcessId] = $_ }
    }
    catch {
        Write-Host "Process command metadata unavailable; cleanup postconditions remain authoritative."
    }

    $Observations = @()
    foreach ($ProcessId in $ProcessesById.Keys) {
        $Process = $ProcessesById[$ProcessId]
        $Metadata = $ProcessMetadata[$ProcessId]
        $ExecutablePath = if ($null -ne $Metadata) {
            [string]$Metadata.ExecutablePath
        } else {
            ""
        }
        $CommandLine = if ($null -ne $Metadata) {
            [string]$Metadata.CommandLine
        } else {
            ""
        }

        $Classification = "ProcessCandidate"
        $Evidence = "name-only-observation"
        $PathLower = $ExecutablePath.ToLowerInvariant()
        $CommandLower = $CommandLine.ToLowerInvariant()
        $ClientLower = $ClientFullName.ToLowerInvariant()
        $BuildLower = $BuildWindowsPath.ToLowerInvariant()
        $HasClientEvidence = (
            -not [string]::IsNullOrWhiteSpace($ExecutablePath) -and
                $PathLower.StartsWith($ClientLower)
        ) -or (
            -not [string]::IsNullOrWhiteSpace($CommandLine) -and
                $CommandLower.Contains($ClientLower)
        )
        $HasBuildOutputEvidence = (
            -not [string]::IsNullOrWhiteSpace($ExecutablePath) -and
                $PathLower.StartsWith($BuildLower)
        ) -or (
            -not [string]::IsNullOrWhiteSpace($CommandLine) -and
                $CommandLower.Contains($BuildLower)
        )
        $HasBuildOrRunVerb = $CommandLower -match '(^|\s)(build|run)(\s|$)'
        $IsAnalysisActivity = $CommandLower -match `
            'analysis_server|language-server|dartdevc|frontend_server'

        if ([string]::IsNullOrWhiteSpace($ExecutablePath) -and
            [string]::IsNullOrWhiteSpace($CommandLine)) {
            $Classification = "UnknownMetadata"
            $Evidence = "metadata-unavailable"
        }
        elseif ($Process.ProcessName -ieq "markei" -and
            $HasBuildOutputEvidence) {
            $Classification = "DefiniteRelevantOwner"
            $Evidence = "markei-executable-in-client-build-output"
        }
        elseif ($Process.ProcessName -in @("flutter", "dart") -and
            $HasClientEvidence -and $HasBuildOrRunVerb -and
            -not $IsAnalysisActivity) {
            $Classification = "DefiniteRelevantOwner"
            $Evidence = "flutter-or-dart-build-run-for-client"
        }
        elseif ($Process.ProcessName -in @("flutter", "dart") -and
            $IsAnalysisActivity) {
            $Classification = "BenignAnalysisActivity"
            $Evidence = "analysis-or-language-server-without-build-run-ownership"
        }
        elseif ($HasClientEvidence -or $HasBuildOutputEvidence) {
            $Classification = "ProcessCandidate"
            $Evidence = "client-path-candidate-without-build-run-proof"
        }

        $Observations += [pscustomobject][ordered]@{
            Id = $ProcessId
            ProcessName = $Process.ProcessName
            Classification = $Classification
            Evidence = $Evidence
        }
    }
    return @($Observations)
}

function Assert-NoRelevantWindowsBuildOwners {
    param([Parameter(Mandatory)] [string]$Stage)

    $Owners = @(
        Get-WindowsBuildProcessObservations | Where-Object {
            $_.Classification -eq "DefiniteRelevantOwner"
        }
    )
    if ($Owners.Count -gt 0) {
        Write-Host "Definite Markei/Flutter/Dart process ownership was detected during $Stage."
        $Owners |
            Sort-Object ProcessName, Id |
            Select-Object Id, ProcessName, Classification, Evidence |
            Format-Table -AutoSize
        throw @"
Close Markei, active Flutter run/build terminals, and VS Code debug/build
activity that owns this Flutter client, then rerun GS-FLUTTER-WIN. The
procedure does not terminate processes automatically.
"@
    }
}

function Assert-GeneratedTargetsAbsent {
    param([Parameter(Mandatory)] [string]$Stage)

    $RemainingTargets = @()
    foreach ($Target in $GeneratedStateTargets) {
        $ResolvedPath = Get-ContainedClientGeneratedPath `
            -RelativePath $Target.RelativePath
        if (Test-Path -LiteralPath $ResolvedPath) {
            $RemainingTargets += [pscustomobject][ordered]@{
                Name = $Target.Name
                Path = $ResolvedPath
            }
        }
    }
    if ($RemainingTargets.Count -gt 0) {
        Write-Host "Generated-state cleanup postcondition failed during $Stage."
        $RemainingTargets | Format-Table -AutoSize
        throw "Generated Flutter state remains; stopping before flutter pub get."
    }
}

function Remove-BoundedGeneratedState {
    Assert-NoRelevantWindowsBuildOwners -Stage "bounded generated-state cleanup"
    foreach ($Target in $GeneratedStateTargets) {
        $ResolvedPath = Get-ContainedClientGeneratedPath `
            -RelativePath $Target.RelativePath
        if (Test-Path -LiteralPath $ResolvedPath) {
            try {
                Remove-Item -LiteralPath $ResolvedPath -Recurse -Force
            }
            catch {
                Write-Host "Generated-state removal failed at bounded path: $ResolvedPath"
                Get-WindowsBuildProcessObservations |
                    Sort-Object Classification, ProcessName, Id |
                    Select-Object Id, ProcessName, Classification, Evidence |
                    Format-Table -AutoSize
                throw "Generated Flutter state could not be removed. Inspect or close relevant activity manually, then rerun."
            }
        }
        if (Test-Path -LiteralPath $ResolvedPath) {
            Write-Host "Generated-state target remained after removal: $ResolvedPath"
            Get-WindowsBuildProcessObservations |
                Sort-Object Classification, ProcessName, Id |
                Select-Object Id, ProcessName, Classification, Evidence |
                Format-Table -AutoSize
            throw "Generated Flutter state could not be removed: $ResolvedPath"
        }
    }
    Assert-GeneratedTargetsAbsent -Stage "bounded generated-state cleanup"
    Assert-NoRelevantWindowsBuildOwners -Stage "post-clean reappearance check"
}

function Assert-WindowsPluginRegeneration {
    $PackageConfigPath = Join-Path $ClientRoot ".dart_tool\package_config.json"
    if (-not (Test-Path -LiteralPath $PackageConfigPath -PathType Leaf)) {
        throw "flutter pub get did not create .dart_tool\package_config.json."
    }
    try {
        $PackageConfig = Get-Content -LiteralPath $PackageConfigPath -Raw |
            ConvertFrom-Json
    }
    catch {
        throw "Generated package_config.json is unreadable."
    }
    $Auth0Packages = @(
        $PackageConfig.packages | Where-Object {
            $_.name -is [string] -and $_.name -ceq "auth0_flutter"
        }
    )
    if ($Auth0Packages.Count -ne 1) {
        throw "package_config.json does not contain exactly one auth0_flutter package."
    }

    $PluginSymlinkPath = Join-Path `
        $ClientRoot `
        "windows\flutter\ephemeral\.plugin_symlinks\auth0_flutter"
    if (-not (Test-Path -LiteralPath $PluginSymlinkPath -PathType Container)) {
        throw "auth0_flutter Windows plugin symlink was not regenerated."
    }
    $Auth0WindowsCMake = Join-Path `
        $PluginSymlinkPath `
        "windows\CMakeLists.txt"
    if (-not (Test-Path -LiteralPath $Auth0WindowsCMake -PathType Leaf)) {
        throw "auth0_flutter generated Windows target is incomplete."
    }
    $GeneratedPluginsCmake = Join-Path `
        $ClientRoot `
        "windows\flutter\generated_plugins.cmake"
    if (-not (Test-Path -LiteralPath $GeneratedPluginsCmake -PathType Leaf)) {
        throw "Windows generated_plugins.cmake was not found at windows\flutter\generated_plugins.cmake."
    }
    $GeneratedPluginsText = Get-Content `
        -LiteralPath $GeneratedPluginsCmake `
        -Raw
    $Auth0GeneratedMentions = [regex]::Matches(
        $GeneratedPluginsText,
        '(?m)^\s*auth0_flutter\s*$'
    )
    if ($Auth0GeneratedMentions.Count -ne 1) {
        throw "Windows generated_plugins.cmake does not contain exactly one auth0_flutter target."
    }

    [pscustomobject][ordered]@{
        PackageConfigPresent = $true
        Auth0PackageEntries = $Auth0Packages.Count
        Auth0WindowsPluginDirectory = $true
        Auth0WindowsCMake = $true
        GeneratedPluginsCmake = $true
        Auth0GeneratedTargets = $Auth0GeneratedMentions.Count
    }
}

Push-Location $ClientRoot
try {
    Assert-NoRelevantWindowsBuildOwners -Stage "pre-clean preflight"

    flutter clean
    if ($LASTEXITCODE -ne 0) { throw "flutter clean failed." }

    Remove-BoundedGeneratedState
    Assert-GeneratedTargetsAbsent -Stage "before flutter pub get"

    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed." }

    Assert-WindowsPluginRegeneration

    flutter analyze
    if ($LASTEXITCODE -ne 0) { throw "flutter analyze failed." }

    flutter test --concurrency=1 --no-pub
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
    $MarkeiExecutableItem = Get-Item -LiteralPath $MarkeiExecutable
    $MarkeiExecutableHash = Get-FileHash `
        -LiteralPath $MarkeiExecutable `
        -Algorithm SHA256

    powershell.exe -NoProfile -ExecutionPolicy Bypass `
      -File ".\tool\register_windows_auth0flutter_protocol.ps1" `
      -ExecutablePath $MarkeiExecutable
    if ($LASTEXITCODE -ne 0) {
        throw "Auth0 Flutter callback registration failed."
    }

    Write-Host "Launching the freshly built Markei Windows Closure client."
    Write-Host "Required UI destination: Closure."
    Write-Host "Windows release artifact: $MarkeiExecutable"
    Write-Host "Windows release artifact bytes: $($MarkeiExecutableItem.Length)"
    Write-Host "Windows release artifact SHA-256: $($MarkeiExecutableHash.Hash)"
    Write-Host "Source revision visible in Closure: #$($SourceIdentity.DisplayRevision)"
    Write-Host "Source tree SHA-256 visible in Closure: $($SourceIdentity.SourceTreeSha256)"
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

### `GS-FLUTTER-DBW` — Prepare VS Code Windows Closure debugging

Run from anywhere inside the repository before using VS Code `F5`. This
procedure closes the gap between a successful PowerShell build and an
independent Dart debug launch: it validates `cpprestsdk`, writes the four
reviewed public Closure coordinates to an ignored local define file, proves a
Windows Debug build beside the existing Release build without cleaning either
configuration, and registers that Debug executable for the Auth0 callback.

The repository root must be the VS Code workspace. Select the tracked launch
configuration `Markei Windows Closure (debug)`. Its pre-launch task runs this
procedure; after the debugger stops, its post-debug task restores the callback
to the byte-identical Release executable. The procedure neither signs in nor
performs Enroll, Query, Retry, or Sync.

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

$LaunchPath = Join-Path $RepositoryRoot ".vscode\launch.json"
$TasksPath = Join-Path $RepositoryRoot ".vscode\tasks.json"
if (-not (Test-Path -LiteralPath $LaunchPath -PathType Leaf) -or
    -not (Test-Path -LiteralPath $TasksPath -PathType Leaf)) {
    throw "Tracked VS Code Debug launch/task configuration is incomplete."
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

$SourceIdentityHelper = Join-Path `
    $ClientRoot `
    "tool\resolve_markei_source_identity.ps1"
if (-not (Test-Path -LiteralPath $SourceIdentityHelper -PathType Leaf)) {
    throw "Shared Markei source identity helper is missing."
}
$SourceIdentity = & $SourceIdentityHelper `
    -RepositoryRoot $RepositoryRoot `
    -Json |
    ConvertFrom-Json
if ($LASTEXITCODE -ne 0) {
    throw "Shared Markei source identity resolution failed."
}
if ($SourceIdentity.SourceRevision -notmatch '^[a-f0-9]{40}$' -or
    $SourceIdentity.SourceTreeSha256 -notmatch '^[a-f0-9]{64}$') {
    throw "Shared Markei source identity returned malformed fields."
}

$VcpkgRoot = "C:\vcpkg"
$VcpkgExe = Join-Path $VcpkgRoot "vcpkg.exe"
$ToolchainPath = Join-Path `
    $VcpkgRoot `
    "scripts\buildsystems\vcpkg.cmake"
$CppRestDir = Join-Path `
    $VcpkgRoot `
    "installed\x64-windows\share\cpprestsdk"

if (-not (Test-Path -LiteralPath $VcpkgExe -PathType Leaf)) {
    if (Test-Path -LiteralPath $VcpkgRoot) {
        throw "C:\vcpkg exists but is incomplete. Inspect it before continuing."
    }
    & git clone https://github.com/microsoft/vcpkg.git $VcpkgRoot
    if ($LASTEXITCODE -ne 0) {
        throw "Could not download vcpkg."
    }
    & (Join-Path $VcpkgRoot "bootstrap-vcpkg.bat") -disableMetrics
    if ($LASTEXITCODE -ne 0) {
        throw "Could not bootstrap vcpkg."
    }
}
if (-not (Test-Path -LiteralPath $ToolchainPath -PathType Leaf)) {
    throw "vcpkg toolchain file is missing at $ToolchainPath."
}

$CppRestConfig = @(
    Get-ChildItem -LiteralPath $CppRestDir `
        -Filter "*cpprestsdk*config.cmake" `
        -File `
        -ErrorAction SilentlyContinue
)
if ($CppRestConfig.Count -eq 0) {
    & $VcpkgExe install cpprestsdk:x64-windows
    if ($LASTEXITCODE -ne 0) {
        throw "cpprestsdk installation failed."
    }
    $CppRestConfig = @(
        Get-ChildItem -LiteralPath $CppRestDir `
            -Filter "*cpprestsdk*config.cmake" `
            -File `
            -ErrorAction SilentlyContinue
    )
}
if ($CppRestConfig.Count -eq 0) {
    throw "cpprestsdk CMake configuration was not found in $CppRestDir."
}

$env:VCPKG_ROOT = $VcpkgRoot
$env:VCPKG_DEFAULT_TRIPLET = "x64-windows"
$env:VCPKG_TARGET_TRIPLET = "x64-windows"
$env:CMAKE_TOOLCHAIN_FILE = $ToolchainPath
$env:CMAKE_PREFIX_PATH = Join-Path `
    $VcpkgRoot `
    "installed\x64-windows"
$env:cpprestsdk_DIR = $CppRestDir

$MarkeiReleaseExecutable = Join-Path `
    $ClientRoot `
    "build\windows\x64\runner\Release\markei.exe"
$ReleaseExistedBefore = Test-Path `
    -LiteralPath $MarkeiReleaseExecutable `
    -PathType Leaf
$ReleaseHashBefore = $null
if ($ReleaseExistedBefore) {
    $ReleaseHashBefore = (
        Get-FileHash `
            -LiteralPath $MarkeiReleaseExecutable `
            -Algorithm SHA256
    ).Hash
}

$RunningMarkei = @(Get-Process -Name "markei" -ErrorAction SilentlyContinue)
if ($RunningMarkei.Count -gt 0) {
    throw "Close every running Markei instance before preparing Debug."
}

$DebugDefinesPath = Join-Path `
    $ClientRoot `
    ".markei_dbw_defines.json"
$DebugDefines = [ordered]@{
    MARKEI_NATIVE_CLOSURE_SURFACE = "true"
    MARKEI_SOURCE_REVISION = $SourceIdentity.SourceRevision
    MARKEI_SOURCE_TREE_SHA256 = $SourceIdentity.SourceTreeSha256
    MARKEI_AUTH0_DOMAIN = $Auth0Domain
    MARKEI_AUTH0_AUDIENCE = $Auth0Audience
    MARKEI_AUTH0_WINDOWS_CLIENT_ID = $WindowsClientId
    MARKEI_HOSTED_HTTPS_ORIGIN = $HostedOrigin
}
$DebugDefinesJson = $DebugDefines | ConvertTo-Json
[IO.File]::WriteAllText(
    $DebugDefinesPath,
    $DebugDefinesJson,
    [Text.UTF8Encoding]::new($false)
)
if (-not (Test-Path -LiteralPath $DebugDefinesPath -PathType Leaf)) {
    throw "Could not create the ignored local Flutter define file."
}

$IgnoreResult = & git -C $RepositoryRoot check-ignore `
    --quiet `
    -- "clients/markei_flutter/.markei_dbw_defines.json"
if ($LASTEXITCODE -ne 0) {
    throw "The local Flutter debug define file is not ignored by Git."
}

flutter config --enable-windows-desktop
if ($LASTEXITCODE -ne 0) {
    throw "Could not enable Flutter Windows desktop support."
}

$WindowsDevices = (& flutter devices 2>&1 | Out-String)
if ($LASTEXITCODE -ne 0 -or
    $WindowsDevices -notmatch "(?im)\bwindows\b") {
    throw "Flutter does not currently expose a Windows desktop device."
}

Push-Location $ClientRoot
try {
    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed." }

    if (-not $ReleaseExistedBefore) {
        Write-Host (
            "Release artifact absent; building the callback-restoration " +
            "baseline automatically."
        )
        flutter build windows `
            --release `
            --dart-define-from-file=".markei_dbw_defines.json"
        if ($LASTEXITCODE -ne 0) {
            throw "Windows Closure Release prerequisite build failed."
        }
        if (-not (
                Test-Path `
                    -LiteralPath $MarkeiReleaseExecutable `
                    -PathType Leaf
            )) {
            throw "Release prerequisite executable was not created."
        }
        $ReleaseHashBefore = (
            Get-FileHash `
                -LiteralPath $MarkeiReleaseExecutable `
                -Algorithm SHA256
        ).Hash
    }

    flutter build windows `
        --debug `
        --dart-define-from-file=".markei_dbw_defines.json"
    if ($LASTEXITCODE -ne 0) {
        throw "Windows Closure Debug build failed."
    }

    $MarkeiDebugExecutable = Join-Path $PWD `
        "build\windows\x64\runner\Debug\markei.exe"
    if (-not (Test-Path -LiteralPath $MarkeiDebugExecutable -PathType Leaf)) {
        throw "Debug markei.exe was not found at $MarkeiDebugExecutable."
    }

    if (-not (
            Test-Path `
                -LiteralPath $MarkeiReleaseExecutable `
                -PathType Leaf
        )) {
        throw "Debug build removed the preserved Release executable."
    }
    $ReleaseHashAfter = (
        Get-FileHash `
            -LiteralPath $MarkeiReleaseExecutable `
            -Algorithm SHA256
    ).Hash
    if ($ReleaseHashAfter -cne $ReleaseHashBefore) {
        throw "Debug build modified the preserved Release executable."
    }

    powershell.exe -NoProfile -ExecutionPolicy Bypass `
      -File ".\tool\register_windows_auth0flutter_protocol.ps1" `
      -ExecutablePath $MarkeiDebugExecutable
    if ($LASTEXITCODE -ne 0) {
        throw "Auth0 Flutter Debug callback registration failed."
    }
}
finally {
    Pop-Location
}

[pscustomobject][ordered]@{
    DebugPreparation = "ready"
    SourceRevision = $SourceIdentity.DisplayRevision
    SourceTreeSha256 = $SourceIdentity.SourceTreeSha256
    WindowsDevice = $true
    VcpkgToolchain = $true
    CppRestSdk = $true
    LocalDefinesIgnored = $true
    DebugBuild = $true
    ReleaseArtifactPreserved = $true
    ReleaseArtifactCreated = -not $ReleaseExistedBefore
    CallbackRegistered = $true
    ReleaseCallbackRestore = "configured-post-debug"
}

Write-Host ""
Write-Host "Next:"
Write-Host "1. Open the Markei repository root in VS Code."
Write-Host "2. Open Run and Debug."
Write-Host "3. Select 'Markei Windows Closure (debug)'."
Write-Host "4. Set the required breakpoint and press F5."
Write-Host "5. Stop normally; VS Code restores the Release callback."
```

`GS-FLUTTER-DBW` does not call `flutter clean` or remove the shared CMake
tree. When Release is absent it creates the Release callback-restoration
baseline automatically, then builds Debug beside it. When Release already
exists it is not rebuilt. In both cases the procedure proves the Release
executable's SHA-256 is unchanged by the Debug build.

The only local configuration artifact it writes is
`clients/markei_flutter/.markei_dbw_defines.json`, which is excluded by
`.gitignore`. It contains reviewed public coordinates, not tokens, passwords,
subjects, Device identifiers, or connection strings. Never add a raw access
token to this file or to `.vscode/launch.json`.

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

$RepositoryDirectory = Get-Item -LiteralPath $RepositoryRoot
$ClientDirectory = Get-Item -LiteralPath $ClientRoot
$RepositoryRoot = $RepositoryDirectory.FullName
$ResolvedClientRoot = $ClientDirectory.FullName
$CandidateDirectory = $ClientDirectory
$ClientInsideRepository = $false
while ($null -ne $CandidateDirectory) {
    if ([string]::Equals(
        $CandidateDirectory.FullName.TrimEnd([char[]]@('\', '/')),
        $RepositoryDirectory.FullName.TrimEnd([char[]]@('\', '/')),
        [System.StringComparison]::OrdinalIgnoreCase
    )) {
        $ClientInsideRepository = $true
        break
    }
    $CandidateDirectory = $CandidateDirectory.Parent
}
if (-not $ClientInsideRepository) {
    throw "Resolved Flutter client is outside the repository root."
}

$Branch = (& git -C $RepositoryRoot branch --show-current).Trim()
if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($Branch)) {
    throw "Could not determine the active Git branch."
}
$InspectedHead = (
    & git -C $RepositoryRoot rev-parse HEAD
).Trim().ToLowerInvariant()
if ($LASTEXITCODE -ne 0 -or $InspectedHead -notmatch '^[a-f0-9]{40}$') {
    throw "Could not determine the inspected Git HEAD."
}

Write-Host "Repository root: $RepositoryRoot"
Write-Host "Flutter client root: $ResolvedClientRoot"
Write-Host "Active branch: $Branch"
Write-Host "Inspected HEAD: $InspectedHead"

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
$ExpectedBranch = Get-NsCoordinate "RepositoryBranch"
$RequiredPublishedAncestor = "ec96f93d71efd261adc2b3b75a17453130e437a0"

if ($Branch -ne $ExpectedBranch) {
    throw "Active branch '$Branch' does not match reviewed coordinate '$ExpectedBranch'."
}
& git -C $RepositoryRoot merge-base `
    --is-ancestor `
    $RequiredPublishedAncestor `
    $InspectedHead
if ($LASTEXITCODE -ne 0) {
    throw "Inspected HEAD does not contain the required published Android Closure baseline."
}

$DirtyOverlap = @(
    & git -C $RepositoryRoot status --porcelain -- `
        "clients/markei_flutter/lib" `
        "clients/markei_flutter/android" `
        "clients/markei_flutter/pubspec.yaml" `
        "clients/markei_flutter/test" `
        "documentation/GRM.md" `
        "documentation/G_SCRIPTS.md" `
        "documentation/I_SCRIPTS.ps1" `
        "documentation/NS_COORDINATES.md"
)
if ($DirtyOverlap.Count -gt 0) {
    $DirtyOverlap | ForEach-Object { Write-Host $_ }
    throw "Dirty source overlap affects Flutter or Android build-provenance inputs."
}

$SourceIdentityHelper = Join-Path `
    $ResolvedClientRoot `
    "tool\resolve_markei_source_identity.ps1"
if (-not (Test-Path -LiteralPath $SourceIdentityHelper -PathType Leaf)) {
    throw "Shared Markei source identity helper is missing."
}
$SourceIdentity = & $SourceIdentityHelper `
    -RepositoryRoot $RepositoryRoot `
    -Json |
    ConvertFrom-Json
if ($LASTEXITCODE -ne 0) {
    throw "Shared Markei source identity resolution failed."
}
if ($SourceIdentity.SourceRevision -notmatch '^[a-f0-9]{40}$' -or
    $SourceIdentity.SourceTreeSha256 -notmatch '^[a-f0-9]{64}$') {
    throw "Shared Markei source identity returned malformed fields."
}

$FlutterCommandCandidates = @(
    Get-Command flutter.bat `
        -CommandType Application `
        -All `
        -ErrorAction SilentlyContinue |
        ForEach-Object { [string]$_.Source } |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
        Select-Object -Unique
)
$UsableFlutterCandidates = @()
foreach ($FlutterCommandCandidate in $FlutterCommandCandidates) {
    if (-not (Test-Path -LiteralPath $FlutterCommandCandidate -PathType Leaf)) {
        continue
    }
    $CandidateFlutterSdkRoot = Split-Path -Parent (
        Split-Path -Parent $FlutterCommandCandidate
    )
    $CandidateMaterialLibrary = Join-Path `
        $CandidateFlutterSdkRoot `
        "packages\flutter\lib\material.dart"
    if (Test-Path -LiteralPath $CandidateMaterialLibrary -PathType Leaf) {
        $UsableFlutterCandidates += [pscustomobject]@{
            Executable = $FlutterCommandCandidate
            SdkRoot = $CandidateFlutterSdkRoot
            MaterialLibrary = $CandidateMaterialLibrary
        }
    }
}
if ($UsableFlutterCandidates.Count -eq 0) {
    throw @"
No usable Flutter SDK was resolved from PATH.
The procedure requires flutter.bat whose SDK contains
packages\flutter\lib\material.dart. Repair Flutter PATH/SDK installation,
open a new terminal, and rerun GS-FLUTTER-AND.
"@
}

$SelectedFlutter = $UsableFlutterCandidates[0]
$FlutterExecutable = [string]$SelectedFlutter.Executable
$FlutterSdkRoot = [string]$SelectedFlutter.SdkRoot
$FlutterMaterialLibrary = [string]$SelectedFlutter.MaterialLibrary

[pscustomobject][ordered]@{
    FlutterCommandCandidates = $FlutterCommandCandidates.Count
    UsableFlutterSdks = $UsableFlutterCandidates.Count
    FlutterSdkSelected = $true
    FlutterMaterialLibraryPresent = (
        Test-Path -LiteralPath $FlutterMaterialLibrary -PathType Leaf
    )
}

& $FlutterExecutable doctor -v
if ($LASTEXITCODE -ne 0) {
    throw "Selected Flutter SDK failed doctor inspection."
}

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
    $FlutterDevicesJson = (& $FlutterExecutable devices --machine 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) {
        throw "Could not inspect Flutter devices."
    }
    try {
        $ParsedFlutterDevices = $FlutterDevicesJson | ConvertFrom-Json
    }
    catch {
        throw "Flutter returned an unreadable device inventory."
    }

    $FlutterDevices = @()
    if ($null -ne $ParsedFlutterDevices) {
        if ($ParsedFlutterDevices -is [System.Array]) {
            foreach ($ParsedFlutterDevice in $ParsedFlutterDevices) {
                $FlutterDevices += ,$ParsedFlutterDevice
            }
        }
        else {
            $FlutterDevices = @($ParsedFlutterDevices)
        }
    }

    return @(
        $FlutterDevices | Where-Object {
            $TargetPlatformProperty = $_.PSObject.Properties["targetPlatform"]
            $SupportedProperty = $_.PSObject.Properties["isSupported"]
            $IdProperty = $_.PSObject.Properties["id"]
            $null -ne $TargetPlatformProperty -and
                $TargetPlatformProperty.Value -is [string] -and
                $TargetPlatformProperty.Value -match "^android" -and
                $null -ne $SupportedProperty -and
                $SupportedProperty.Value -is [bool] -and
                $SupportedProperty.Value -eq $true -and
                $null -ne $IdProperty -and
                $IdProperty.Value -is [string] -and
                -not [string]::IsNullOrWhiteSpace($IdProperty.Value) -and
                $IdProperty.Value -notmatch '[\s\x00-\x1F\x7F]'
        }
    )
}

function Assert-AdbTargetSerial {
    param(
        [Parameter(Mandatory)] [string]$AdbExecutable,
        [Parameter(Mandatory)] [object]$CandidateId
    )

    if ($CandidateId -isnot [string] -or
        [string]::IsNullOrWhiteSpace($CandidateId) -or
        $CandidateId -match '[\s\x00-\x1F\x7F]' -or
        $CandidateId -eq "windows") {
        throw "Selected Android device ID is not one safe scalar serial."
    }

    $AdbInventoryLines = @(& $AdbExecutable devices 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw "Could not inspect the Android Debug Bridge device inventory."
    }
    $MatchingSerials = @(
        $AdbInventoryLines | ForEach-Object {
            $InventoryMatch = [regex]::Match(
                [string]$_,
                '^(?<serial>[^\s]+)\s+device$'
            )
            if ($InventoryMatch.Success -and
                $InventoryMatch.Groups["serial"].Value -ceq $CandidateId) {
                $InventoryMatch.Groups["serial"].Value
            }
        }
    )
    if ($MatchingSerials.Count -ne 1) {
        throw (
            "Selected Android device ID was not exactly present as one " +
            "ready ADB serial."
        )
    }
    return [string]$MatchingSerials[0]
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
    $AndroidDeviceId = Assert-AdbTargetSerial `
        -AdbExecutable $AdbExe `
        -CandidateId $AndroidDeviceId
    $BootDeadline = [DateTime]::UtcNow.AddMinutes(3)
    do {
        Start-Sleep -Seconds 2
        $BootProbeArguments = @(
            "-s"
            $AndroidDeviceId
            "shell"
            "getprop"
            "sys.boot_completed"
        )
        $BootCompleted = (
            & $AdbExe @BootProbeArguments 2>$null
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
$AndroidSdkRoot = if (
    -not [string]::IsNullOrWhiteSpace($env:ANDROID_SDK_ROOT)
) {
    $env:ANDROID_SDK_ROOT
}
else {
    Join-Path $env:LOCALAPPDATA "Android\Sdk"
}
$AdbExe = Join-Path $AndroidSdkRoot "platform-tools\adb.exe"
if (-not (Test-Path -LiteralPath $AdbExe -PathType Leaf)) {
    throw "Android Debug Bridge was not found at $AdbExe."
}
$SelectedAndroidDeviceId = Assert-AdbTargetSerial `
    -AdbExecutable $AdbExe `
    -CandidateId $SelectedAndroidDeviceId

$RequiredClosureSurfaceDefine = "--dart-define=MARKEI_NATIVE_CLOSURE_SURFACE=true"
$FlutterDefines = @(
    $RequiredClosureSurfaceDefine
    "--dart-define=MARKEI_SOURCE_REVISION=$($SourceIdentity.SourceRevision)"
    "--dart-define=MARKEI_SOURCE_TREE_SHA256=$($SourceIdentity.SourceTreeSha256)"
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

Push-Location $ResolvedClientRoot
try {
    & $FlutterExecutable clean
    if ($LASTEXITCODE -ne 0) { throw "flutter clean failed." }

    & $FlutterExecutable pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed." }

    $PackageConfigPath = Join-Path `
        $ResolvedClientRoot `
        ".dart_tool\package_config.json"
    if (-not (Test-Path -LiteralPath $PackageConfigPath -PathType Leaf)) {
        throw @"
flutter pub get returned success without creating
.dart_tool\package_config.json. Stop before analysis and repair the selected
Flutter SDK/package cache.
"@
    }
    try {
        $PackageConfig = Get-Content -LiteralPath $PackageConfigPath -Raw |
            ConvertFrom-Json
    }
    catch {
        throw "Generated Flutter package_config.json is unreadable."
    }
    $ConfiguredFlutterPackages = @(
        $PackageConfig.packages | Where-Object {
            $_.name -is [string] -and $_.name -ceq "flutter"
        }
    )
    if ($ConfiguredFlutterPackages.Count -ne 1) {
        throw @"
Generated package_config.json does not contain exactly one Flutter SDK
package. Stop before analysis and repair Flutter dependency resolution.
"@
    }
    $ConfiguredFlutterRootUri = [string]$ConfiguredFlutterPackages[0].rootUri
    try {
        $ConfiguredFlutterUri = [Uri]::new(
            $ConfiguredFlutterRootUri,
            [UriKind]::Absolute
        )
    }
    catch {
        throw "Generated Flutter SDK package root URI is invalid."
    }
    if (-not $ConfiguredFlutterUri.IsFile) {
        throw "Generated Flutter SDK package root is not a local file URI."
    }
    $ConfiguredFlutterRoot = [IO.Path]::GetFullPath(
        $ConfiguredFlutterUri.LocalPath
    ).TrimEnd([char[]]@('\', '/'))
    $ExpectedFlutterPackageRoot = [IO.Path]::GetFullPath(
        (Join-Path $FlutterSdkRoot "packages\flutter")
    ).TrimEnd([char[]]@('\', '/'))
    if (-not [string]::Equals(
        $ConfiguredFlutterRoot,
        $ExpectedFlutterPackageRoot,
        [StringComparison]::OrdinalIgnoreCase
    )) {
        throw @"
Generated package_config.json points to a different Flutter SDK than the
selected flutter.bat. Stop before analysis, remove the conflicting Flutter
PATH entry, open a new terminal, and rerun GS-FLUTTER-AND.
"@
    }
    $ConfiguredMaterialLibrary = Join-Path `
        $ConfiguredFlutterRoot `
        "lib\material.dart"
    if (-not (
        Test-Path -LiteralPath $ConfiguredMaterialLibrary -PathType Leaf
    )) {
        throw @"
Generated Flutter package configuration does not resolve
package:flutter/material.dart. Stop before analysis and repair the Flutter SDK.
"@
    }

    [pscustomobject][ordered]@{
        PackageConfigPresent = $true
        FlutterPackageEntryCount = $ConfiguredFlutterPackages.Count
        PackageConfigMatchesSelectedSdk = $true
        MaterialImportResolvable = $true
    }

    & $FlutterExecutable analyze
    if ($LASTEXITCODE -ne 0) { throw "flutter analyze failed." }

    & $FlutterExecutable test --concurrency=1 --no-pub
    if ($LASTEXITCODE -ne 0) { throw "flutter test failed." }

    & $FlutterExecutable build apk --debug @FlutterDefines
    if ($LASTEXITCODE -ne 0) {
        throw "Android Closure debug build failed."
    }

    $AndroidArtifact = Join-Path $PWD `
        "build\app\outputs\flutter-apk\app-debug.apk"
    if (-not (Test-Path $AndroidArtifact)) {
        throw "app-debug.apk was not found at $AndroidArtifact."
    }
    $AndroidArtifactItem = Get-Item -LiteralPath $AndroidArtifact
    $AndroidArtifactHash = Get-FileHash -LiteralPath $AndroidArtifact `
        -Algorithm SHA256

    Write-Host "Android debug artifact created at:"
    Write-Host $AndroidArtifact
    Write-Host "Android debug artifact bytes: $($AndroidArtifactItem.Length)"
    Write-Host "Android debug artifact SHA-256: $($AndroidArtifactHash.Hash)"
    Write-Host "Source revision visible in Closure: #$($SourceIdentity.DisplayRevision)"
    Write-Host "Source tree SHA-256 visible in Closure: $($SourceIdentity.SourceTreeSha256)"
    Write-Host "Local APK hash alone does not prove installed-package identity."
    Write-Host "Installing package com.gusigu.markei with data preservation."

    $InstallArguments = @(
        "-s"
        $SelectedAndroidDeviceId
        "install"
        "-r"
        $AndroidArtifact
    )
    & $AdbExe @InstallArguments
    if ($LASTEXITCODE -ne 0) {
        throw "ADB install failed for com.gusigu.markei."
    }

    Write-Host "Installed package evidence for selected target:"
    $PackagePathArguments = @(
        "-s"
        $SelectedAndroidDeviceId
        "shell"
        "pm"
        "path"
        "com.gusigu.markei"
    )
    & $AdbExe @PackagePathArguments
    $PackageInspectionArguments = @(
        "-s"
        $SelectedAndroidDeviceId
        "shell"
        "dumpsys"
        "package"
        "com.gusigu.markei"
    )
    & $AdbExe @PackageInspectionArguments |
        Select-String -Pattern "versionName|versionCode|firstInstallTime|lastUpdateTime" |
        ForEach-Object { $_.Line.Trim() }

    Write-Host "Launching Markei package com.gusigu.markei on the selected Android device."
    $LaunchArguments = @(
        "-s"
        $SelectedAndroidDeviceId
        "shell"
        "monkey"
        "-p"
        "com.gusigu.markei"
        "-c"
        "android.intent.category.LAUNCHER"
        "1"
    )
    & $AdbExe @LaunchArguments | Out-Host
    if ($LASTEXITCODE -ne 0) {
        throw "ADB launch failed for com.gusigu.markei."
    }
    Write-Host "Required human verification:"
    Write-Host "  Closure destination is visible."
    Write-Host "  Source revision shows #$($SourceIdentity.DisplayRevision)."
    Write-Host "  Source tree SHA-256 shows $($SourceIdentity.SourceTreeSha256)."
    Write-Host "  Consolidated Diagnostics surface is visible."
    Write-Host "Do not Enroll, Sync, Retry, recover, clear storage, or sign out."
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

This is the full Android recovery path. It resolves and reports the repository
root, client root, branch and inspected HEAD; rejects relevant dirty source
overlap; loads and verifies the public coordinate surface without printing
coordinate values; reuses exactly one selected supported Android target or
starts the configured AVD with bounded availability and boot waits; forwards
the Auth0 domain to the Android manifest without writing it elsewhere; binds
one usable Flutter SDK for the complete run; cleans, regenerates, and verifies
the Flutter package configuration before analysis; validates; builds the debug
APK; and reports the artifact path, byte length, and
SHA-256, installs the package `com.gusigu.markei` with replacement while
preserving application data, prints non-secret target/package evidence, and
launches the app with the mandatory Closure and source-identity Dart
definitions. The local APK hash identifies the generated file only; by itself
it does not prove installed-package identity. If the `Closure` destination,
visible source identity, or consolidated `Diagnostics` surface is absent after
launch, this procedure has not passed and no Gate action may continue. The
Auth0 Android application must already allow the callback/logout URI derived
from package `com.gusigu.markei`; this procedure does not modify Auth0.
Launching the client does not authorize Enroll, Query, Retry, recovery, storage
clear, sign-out, or Sync.

### `GS-FLUTTER-DBA` — Prepare VS Code Android Closure debugging

Run from anywhere inside the repository before using VS Code `F5`. This
procedure combines the guarded Android target selection from
`GS-FLUTTER-AND` with the ignored-local-configuration and tracked VS Code
launch model used by `GS-FLUTTER-DBW`. It reuses one connected supported
Android target or starts the configured AVD, proves exactly one safe ADB
serial, writes only reviewed public Closure coordinates to ignored local
files, and validates one Android Debug APK without adding an install or launch
function to the procedure.

The repository root must be the VS Code workspace. Select the same Android
target in Flutter's VS Code device selector, select the tracked launch
configuration `Markei Android Closure (debug)`, and press `F5`. Dart Code's
`flutter.getSelectedDeviceId` command supplies the complete selected ID to
both the launch request and this pre-launch task. This procedure proves exact
agreement with its independently guarded ADB serial; after it returns, the
tracked Dart `launch` request runs/opens Markei automatically and owns the
debugger, breakpoints, variables, and Debug Console. The procedure preserves
application data and neither signs in nor performs Enroll, Query, Retry,
recovery, or Sync.

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

$RepositoryDirectory = Get-Item -LiteralPath $RepositoryRoot
$ClientDirectory = Get-Item -LiteralPath $ClientRoot
$RepositoryRoot = $RepositoryDirectory.FullName
$ResolvedClientRoot = $ClientDirectory.FullName
$CandidateDirectory = $ClientDirectory
$ClientInsideRepository = $false
while ($null -ne $CandidateDirectory) {
    if ([string]::Equals(
        $CandidateDirectory.FullName.TrimEnd([char[]]@('\', '/')),
        $RepositoryDirectory.FullName.TrimEnd([char[]]@('\', '/')),
        [System.StringComparison]::OrdinalIgnoreCase
    )) {
        $ClientInsideRepository = $true
        break
    }
    $CandidateDirectory = $CandidateDirectory.Parent
}
if (-not $ClientInsideRepository) {
    throw "Resolved Flutter client is outside the repository root."
}

$LaunchPath = Join-Path $RepositoryRoot ".vscode\launch.json"
$TasksPath = Join-Path $RepositoryRoot ".vscode\tasks.json"
if (-not (Test-Path -LiteralPath $LaunchPath -PathType Leaf) -or
    -not (Test-Path -LiteralPath $TasksPath -PathType Leaf)) {
    throw "Tracked VS Code Android Debug launch/task configuration is incomplete."
}

$VsCodeLaunchRequested =
    $env:MARKEI_DBA_VSCODE_LAUNCH -ceq "true"
$VsCodeSelectedDeviceId = [string]$env:MARKEI_DBA_VSCODE_DEVICE_ID
if ($VsCodeLaunchRequested -and
    ([string]::IsNullOrWhiteSpace($VsCodeSelectedDeviceId) -or
     $VsCodeSelectedDeviceId -match '[\s\x00-\x1F\x7F]')) {
    throw @"
VS Code did not supply one safe selected Flutter device ID.
Select the Android target in Flutter's VS Code device selector, keep
'Markei Android Closure (debug)' selected, and press F5 again.
"@
}

$Branch = (& git -C $RepositoryRoot branch --show-current).Trim()
if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($Branch)) {
    throw "Could not determine the active Git branch."
}
$InspectedHead = (
    & git -C $RepositoryRoot rev-parse HEAD
).Trim().ToLowerInvariant()
if ($LASTEXITCODE -ne 0 -or $InspectedHead -notmatch '^[a-f0-9]{40}$') {
    throw "Could not determine the inspected Git HEAD."
}
$BuildProvenance = $InspectedHead.Substring(0, 12)
if ($BuildProvenance -notmatch '^[a-f0-9]{7,12}$') {
    throw "Could not derive reviewed short HEAD for build provenance."
}

Write-Host "Repository root: $RepositoryRoot"
Write-Host "Flutter client root: $ResolvedClientRoot"
Write-Host "Active branch: $Branch"
Write-Host "Inspected HEAD: $InspectedHead"

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
$ExpectedBranch = Get-NsCoordinate "RepositoryBranch"
$RequiredPublishedAncestor = "ec96f93d71efd261adc2b3b75a17453130e437a0"

if ($Auth0Domain -notmatch '^[A-Za-z0-9.-]+$') {
    throw "Auth0 tenant domain is not safe for the local Gradle property file."
}
if ($Branch -ne $ExpectedBranch) {
    throw "Active branch '$Branch' does not match reviewed coordinate '$ExpectedBranch'."
}
& git -C $RepositoryRoot merge-base `
    --is-ancestor `
    $RequiredPublishedAncestor `
    $InspectedHead
if ($LASTEXITCODE -ne 0) {
    throw "Inspected HEAD does not contain the required published Android Closure baseline."
}

$DirtyOverlap = @(
    & git -C $RepositoryRoot status --porcelain -- `
        ".gitignore" `
        ".vscode/launch.json" `
        ".vscode/tasks.json" `
        "clients/markei_flutter/lib" `
        "clients/markei_flutter/android" `
        "clients/markei_flutter/pubspec.yaml" `
        "clients/markei_flutter/test" `
        "documentation/GRM.md" `
        "documentation/G_SCRIPTS.md" `
        "documentation/I_SCRIPTS.ps1" `
        "documentation/NS_COORDINATES.md"
)
if ($DirtyOverlap.Count -gt 0) {
    $DirtyOverlap | ForEach-Object { Write-Host $_ }
    throw "Dirty source overlap affects Android debugger preparation inputs."
}

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
        $ParsedFlutterDevices = $FlutterDevicesJson | ConvertFrom-Json
    }
    catch {
        throw "Flutter returned an unreadable device inventory."
    }

    $FlutterDevices = @()
    if ($null -ne $ParsedFlutterDevices) {
        if ($ParsedFlutterDevices -is [System.Array]) {
            foreach ($ParsedFlutterDevice in $ParsedFlutterDevices) {
                $FlutterDevices += ,$ParsedFlutterDevice
            }
        }
        else {
            $FlutterDevices = @($ParsedFlutterDevices)
        }
    }

    return @(
        $FlutterDevices | Where-Object {
            $TargetPlatformProperty = $_.PSObject.Properties["targetPlatform"]
            $SupportedProperty = $_.PSObject.Properties["isSupported"]
            $IdProperty = $_.PSObject.Properties["id"]
            $null -ne $TargetPlatformProperty -and
                $TargetPlatformProperty.Value -is [string] -and
                $TargetPlatformProperty.Value -match "^android" -and
                $null -ne $SupportedProperty -and
                $SupportedProperty.Value -is [bool] -and
                $SupportedProperty.Value -eq $true -and
                $null -ne $IdProperty -and
                $IdProperty.Value -is [string] -and
                -not [string]::IsNullOrWhiteSpace($IdProperty.Value) -and
                $IdProperty.Value -notmatch '[\s\x00-\x1F\x7F]'
        }
    )
}

function Assert-AdbTargetSerial {
    param(
        [Parameter(Mandatory)] [string]$AdbExecutable,
        [Parameter(Mandatory)] [object]$CandidateId
    )

    if ($CandidateId -isnot [string] -or
        [string]::IsNullOrWhiteSpace($CandidateId) -or
        $CandidateId -match '[\s\x00-\x1F\x7F]' -or
        $CandidateId -eq "windows") {
        throw "Selected Android device ID is not one safe scalar serial."
    }

    $AdbInventoryLines = @(& $AdbExecutable devices 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw "Could not inspect the Android Debug Bridge device inventory."
    }
    $MatchingSerials = @(
        $AdbInventoryLines | ForEach-Object {
            $InventoryMatch = [regex]::Match(
                [string]$_,
                '^(?<serial>[^\s]+)\s+device$'
            )
            if ($InventoryMatch.Success -and
                $InventoryMatch.Groups["serial"].Value -ceq $CandidateId) {
                $InventoryMatch.Groups["serial"].Value
            }
        }
    )
    if ($MatchingSerials.Count -ne 1) {
        throw (
            "Selected Android device ID was not exactly present as one " +
            "ready ADB serial."
        )
    }
    return [string]$MatchingSerials[0]
}

$AndroidDevices = @(Get-SupportedAndroidDevices)
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

    $AndroidSdkRoot = if (
        -not [string]::IsNullOrWhiteSpace($env:ANDROID_SDK_ROOT)
    ) {
        $env:ANDROID_SDK_ROOT
    }
    else {
        Join-Path $env:LOCALAPPDATA "Android\Sdk"
    }
    $AdbExe = Join-Path $AndroidSdkRoot "platform-tools\adb.exe"
    if (-not (Test-Path -LiteralPath $AdbExe -PathType Leaf)) {
        throw "Android Debug Bridge was not found at $AdbExe."
    }
    $BootDeviceId = Assert-AdbTargetSerial `
        -AdbExecutable $AdbExe `
        -CandidateId $AndroidDevices[0].id
    $BootDeadline = [DateTime]::UtcNow.AddMinutes(3)
    do {
        Start-Sleep -Seconds 2
        $BootProbeArguments = @(
            "-s"
            $BootDeviceId
            "shell"
            "getprop"
            "sys.boot_completed"
        )
        $BootCompleted = (
            & $AdbExe @BootProbeArguments 2>$null
        ).Trim()
    } until (
        $BootCompleted -eq "1" -or
        [DateTime]::UtcNow -ge $BootDeadline
    )
    if ($BootCompleted -ne "1") {
        throw "Configured Android AVD did not finish booting within 3 minutes."
    }
}

if ($AndroidDevices.Count -ne 1) {
    $AndroidDevices |
        Select-Object name, id, targetPlatform, sdk |
        Format-Table -AutoSize
    throw "Leave exactly one supported Android target connected and rerun."
}

$SelectedAndroidDevice = $AndroidDevices[0]
$SelectedAndroidDevice |
    Select-Object name, id, targetPlatform, sdk |
    Format-List
$AndroidSdkRoot = if (
    -not [string]::IsNullOrWhiteSpace($env:ANDROID_SDK_ROOT)
) {
    $env:ANDROID_SDK_ROOT
}
else {
    Join-Path $env:LOCALAPPDATA "Android\Sdk"
}
$AdbExe = Join-Path $AndroidSdkRoot "platform-tools\adb.exe"
if (-not (Test-Path -LiteralPath $AdbExe -PathType Leaf)) {
    throw "Android Debug Bridge was not found at $AdbExe."
}
$SelectedAndroidDeviceId = Assert-AdbTargetSerial `
    -AdbExecutable $AdbExe `
    -CandidateId $SelectedAndroidDevice.id

$VsCodeDeviceAlignment = "manual-preparation"
if ($VsCodeLaunchRequested) {
    if ($VsCodeSelectedDeviceId -cne $SelectedAndroidDeviceId) {
        throw @"
VS Code selected device '$VsCodeSelectedDeviceId', but the guarded Android
target is '$SelectedAndroidDeviceId'. Select that exact Android target in
Flutter's VS Code device selector and press F5 again.
"@
    }
    $VsCodeDeviceAlignment = "exact-selected-device"
}

$DebugDefinesPath = Join-Path `
    $ResolvedClientRoot `
    ".markei_dba_defines.json"
$DebugDefines = [ordered]@{
    MARKEI_NATIVE_CLOSURE_SURFACE = "true"
    MARKEI_BUILD_PROVENANCE = $BuildProvenance
    MARKEI_AUTH0_DOMAIN = $Auth0Domain
    MARKEI_AUTH0_AUDIENCE = $Auth0Audience
    MARKEI_AUTH0_ANDROID_CLIENT_ID = $AndroidClientId
    MARKEI_HOSTED_HTTPS_ORIGIN = $HostedOrigin
}
$DebugDefinesJson = $DebugDefines | ConvertTo-Json
[IO.File]::WriteAllText(
    $DebugDefinesPath,
    $DebugDefinesJson,
    [Text.UTF8Encoding]::new($false)
)

$DebugGradlePropertiesPath = Join-Path `
    $ResolvedClientRoot `
    ".markei_dba_gradle.properties"
$DebugGradleProperties = "MARKEI_AUTH0_DOMAIN=$Auth0Domain`n"
[IO.File]::WriteAllText(
    $DebugGradlePropertiesPath,
    $DebugGradleProperties,
    [Text.UTF8Encoding]::new($false)
)

$IgnoredDebugFiles = @(
    "clients/markei_flutter/.markei_dba_defines.json"
    "clients/markei_flutter/.markei_dba_gradle.properties"
)
foreach ($IgnoredDebugFile in $IgnoredDebugFiles) {
    & git -C $RepositoryRoot check-ignore --quiet -- $IgnoredDebugFile
    if ($LASTEXITCODE -ne 0) {
        throw "Android Debug local file is not ignored: $IgnoredDebugFile"
    }
}

Push-Location $ResolvedClientRoot
try {
    flutter pub get
    if ($LASTEXITCODE -ne 0) { throw "flutter pub get failed." }

    flutter build apk `
        --debug `
        --dart-define-from-file=".markei_dba_defines.json"
    if ($LASTEXITCODE -ne 0) {
        throw "Android Closure Debug prerequisite build failed."
    }

    $AndroidArtifact = Join-Path $PWD `
        "build\app\outputs\flutter-apk\app-debug.apk"
    if (-not (Test-Path -LiteralPath $AndroidArtifact -PathType Leaf)) {
        throw "Debug app-debug.apk was not found at $AndroidArtifact."
    }
    $AndroidArtifactItem = Get-Item -LiteralPath $AndroidArtifact
    $AndroidArtifactHash = Get-FileHash `
        -LiteralPath $AndroidArtifact `
        -Algorithm SHA256
}
finally {
    Pop-Location
}

[pscustomobject][ordered]@{
    DebugPreparation = "ready"
    AndroidDevice = $true
    AndroidDeviceId = $SelectedAndroidDeviceId
    AdbSerialGuard = "exactly-one"
    VsCodeLaunchRequested = $VsCodeLaunchRequested
    VsCodeDeviceAlignment = $VsCodeDeviceAlignment
    LocalDefinesIgnored = $true
    LocalGradlePropertiesIgnored = $true
    DebugBuild = $true
    DebugArtifactBytes = $AndroidArtifactItem.Length
    DebugArtifactSha256 = $AndroidArtifactHash.Hash
    BuildProvenance = $BuildProvenance
    DebugLaunch = if ($VsCodeLaunchRequested) {
        "ready-for-automatic-dart-launch"
    }
    else {
        "prepared-for-vscode-f5"
    }
}

Write-Host ""
if ($VsCodeLaunchRequested) {
    Write-Host "DBA preparation and exact VS Code device alignment passed."
    Write-Host "Dart Code will now run/open Markei under the debugger."
}
else {
    Write-Host "Next:"
    Write-Host "1. Open the Markei repository root in VS Code."
    Write-Host "2. Select this exact Android target in Flutter's device selector."
    Write-Host "3. Open Run and Debug."
    Write-Host "4. Select 'Markei Android Closure (debug)'."
    Write-Host "5. Set the required breakpoint and press F5."
    Write-Host "6. Keep exactly this Android target connected during launch."
    Write-Host "7. Stop normally after the bounded debug observation."
}
```

`GS-FLUTTER-DBA` does not call `flutter clean`, uninstall the package, clear
application data, or use ADB to install/launch outside the debugger. It also
does not add an independent install function. The tracked VS Code launch
resolves the complete current device ID through
`flutter.getSelectedDeviceId`; its pre-launch task requires exact agreement
with the one supported Android target and matching ready ADB serial before the
Dart launch may run/open the app.

The only local configuration artifacts it writes are
`clients/markei_flutter/.markei_dba_defines.json` and
`clients/markei_flutter/.markei_dba_gradle.properties`; both are excluded by
`.gitignore`. They contain reviewed public coordinates and build provenance,
not tokens, passwords, subjects, Account/Device identifiers, or connection
strings. Never add a raw access token to either file or to
`.vscode/launch.json`.

## 7. Historical diagnostics and mutation record

These procedures are retained for traceability and are excluded from the
active `GRM_INDEX`.

### `GS-NEON-H01` — Gate 02 preflight diagnostic

Canonical SQL block: `DB_MGMT.sql` → `DBM-AUTO-02` /
`gate02-preflight`.

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass `
  -File ".\documentation\I_SCRIPTS.ps1" `
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
  -File ".\documentation\I_SCRIPTS.ps1" `
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
- the provisioning token does not select exactly one current RS256 key, the
  hosted identity preflight is neither `membership-required` nor
  `membership-confirmed`, or the provider is not an empty/new or exact
  same-user idempotent fixture;
- Account provisioning did not commit with count-only postconditions or the
  hosted identity postflight is not `membership-confirmed`;
- `sqlite3.exe` cannot be resolved and version-verified;
- Markei, Flutter, or Dart remains active during local-database copying;
- the local Markei database candidate count is not exactly one;
- a SQLite WAL/SHM sidecar remains after Markei closes;
- the verified temporary copy already exists, differs in size/hash, fails
  `quick_check`, lacks a required table, or produces a probe error.

After an unclear migration result, use only read-only postflight and ledger
checks. Never reconstruct or partially rerun a migration by hand.
