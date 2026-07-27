[CmdletBinding()]
param(
    [ValidatePattern("^GS-[A-Z0-9-]+$")]
    [string]$Procedure,

    [ValidateSet("runtime", "migrator", "dbowner")]
    [string]$Role,

    [ValidateSet(
        "connection",
        "gate02-preflight",
        "gate02-postflight",
        "verify-device",
        "provider-baseline",
        "account-membership-provision",
        "runtime-readiness",
        "list-devices-sanitized",
        "migration-ledger",
        "runtime-privileges",
        "schema-inventory",
        "apply-migration",
        "migrate-to",
        "shell"
    )]
    [string]$Action,

    [string]$MigrationPath,
    [string]$TargetVersion,
    [string]$ConfigPath,
    [string]$ActionPath,
    [string]$IdentitySubject
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDirectory = $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($ScriptDirectory)) {
    $ScriptFile = $MyInvocation.MyCommand.Path
    if ([string]::IsNullOrWhiteSpace($ScriptFile)) {
        throw @"
Unable to determine the I_SCRIPTS.ps1 directory.
Run this helper as a script with -File or .\documentation\I_SCRIPTS.ps1.
"@
    }
    $ScriptDirectory = Split-Path -Parent $ScriptFile
}

if (-not [string]::IsNullOrWhiteSpace($Procedure)) {
    if (-not [string]::IsNullOrWhiteSpace($Role) -or
        -not [string]::IsNullOrWhiteSpace($Action) -or
        -not [string]::IsNullOrWhiteSpace($MigrationPath) -or
        -not [string]::IsNullOrWhiteSpace($TargetVersion) -or
        -not [string]::IsNullOrWhiteSpace($ConfigPath) -or
        -not [string]::IsNullOrWhiteSpace($ActionPath) -or
        -not [string]::IsNullOrWhiteSpace($IdentitySubject)) {
        throw "-Procedure cannot be combined with Neon launcher parameters."
    }

    $RepositoryRoot = (
        & git -C $ScriptDirectory rev-parse --show-toplevel 2>$null
    ).Trim()
    if ($LASTEXITCODE -ne 0 -or
        [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
        throw "I_SCRIPTS.ps1 must be inside the Markei Git repository."
    }

    $CataloguePath = Join-Path `
        $RepositoryRoot `
        "documentation\G_SCRIPTS.md"
    if (-not (Test-Path -LiteralPath $CataloguePath -PathType Leaf)) {
        throw "Canonical procedure catalogue not found: $CataloguePath"
    }

    $Catalogue = Get-Content -LiteralPath $CataloguePath -Raw
    $HeadingPattern = '(?ms)^### `' +
        [regex]::Escape($Procedure) +
        '`[^\r\n]*\r?\n(?<Section>.*?)(?=^### `GS-|\z)'
    $SectionMatch = [regex]::Match($Catalogue, $HeadingPattern)
    if (-not $SectionMatch.Success) {
        throw "Canonical procedure '$Procedure' was not found."
    }

    $FencePattern =
        '(?ms)^```powershell[ \t]*\r?\n(?<Code>.*?)^```[ \t]*\r?$'
    $FenceMatch = [regex]::Match(
        $SectionMatch.Groups["Section"].Value,
        $FencePattern
    )
    if (-not $FenceMatch.Success) {
        throw "Canonical procedure '$Procedure' has no PowerShell body."
    }

    try {
        Set-Location -LiteralPath $RepositoryRoot
        & ([scriptblock]::Create($FenceMatch.Groups["Code"].Value))
    }
    finally {
        Set-Location -LiteralPath $RepositoryRoot
    }
    return
}

if ([string]::IsNullOrWhiteSpace($ConfigPath)) {
    $ConfigPath = Join-Path $ScriptDirectory "NS_COORDINATES.md"
}
if ([string]::IsNullOrWhiteSpace($ActionPath)) {
    $ActionPath = Join-Path $ScriptDirectory "DB_MGMT.sql"
}

function Select-Value {
    param(
        [Parameter(Mandatory)] [string]$Prompt,
        [Parameter(Mandatory)] [string[]]$Values
    )
    for ($Index = 0; $Index -lt $Values.Count; $Index++) {
        Write-Host ("[{0}] {1}" -f ($Index + 1), $Values[$Index])
    }
    $Selection = Read-Host $Prompt
    $Number = 0
    if (-not [int]::TryParse($Selection, [ref]$Number) -or
        $Number -lt 1 -or $Number -gt $Values.Count) {
        throw "Invalid selection."
    }
    return $Values[$Number - 1]
}

function Read-ConfigValue {
    param(
        [Parameter(Mandatory)] [string]$Content,
        [Parameter(Mandatory)] [string]$Name
    )
    $Match = [regex]::Match(
        $Content,
        "(?m)^$([regex]::Escape($Name)):\s*(.+?)\s*$"
    )
    if (-not $Match.Success) {
        throw "Missing '$Name' in $ConfigPath."
    }
    $Value = $Match.Groups[1].Value.Trim()
    if ($Value.StartsWith("<") -or $Value.EndsWith(">")) {
        throw "Replace the placeholder for '$Name' in $ConfigPath."
    }
    return $Value
}

function Get-ActionSql {
    param(
        [Parameter(Mandatory)] [string]$Content,
        [Parameter(Mandatory)] [string]$Name
    )
    $Pattern = "(?ms)^-- ACTION: $([regex]::Escape($Name))\s*\r?\n" +
        "(.*?)^-- END ACTION\s*$"
    $Match = [regex]::Match($Content, $Pattern)
    if (-not $Match.Success) {
        throw "Action '$Name' is missing from $ActionPath."
    }
    return $Match.Groups[1].Value.Trim()
}

function Get-RepositoryFile {
    param(
        [Parameter(Mandatory)] [string]$RepositoryRoot,
        [Parameter(Mandatory)] [string]$RelativePath,
        [Parameter(Mandatory)] [string]$ExpectedHash
    )

    if ($RelativePath -notmatch '^[A-Za-z0-9_./-]+$' -or
        $RelativePath.StartsWith("/") -or
        $RelativePath.Contains("..")) {
        throw "Migration registry path is unsafe: $RelativePath"
    }
    if ($ExpectedHash -notmatch '^[A-Fa-f0-9]{64}$') {
        throw "Migration registry SHA-256 is invalid for $RelativePath."
    }

    $RepositoryDirectory = Get-Item -LiteralPath $RepositoryRoot
    $ResolvedFile = Get-Item -LiteralPath (
        Join-Path $RepositoryDirectory.FullName $RelativePath
    )
    if ($ResolvedFile.PSIsContainer -or
        [IO.Path]::GetExtension($ResolvedFile.FullName) -ne ".sql") {
        throw "Migration registry path must identify a .sql file."
    }

    $CandidateDirectory = $ResolvedFile.Directory
    $IsInsideRepository = $false
    while ($null -ne $CandidateDirectory) {
        if ([string]::Equals(
            $CandidateDirectory.FullName.TrimEnd([char[]]@('\', '/')),
            $RepositoryDirectory.FullName.TrimEnd([char[]]@('\', '/')),
            [StringComparison]::OrdinalIgnoreCase
        )) {
            $IsInsideRepository = $true
            break
        }
        $CandidateDirectory = $CandidateDirectory.Parent
    }
    if (-not $IsInsideRepository) {
        throw "Migration registry path leaves the current repository."
    }

    $Tracked = & git -C $RepositoryRoot ls-files `
        --error-unmatch -- $RelativePath 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "Migration file is not tracked by Git: $RelativePath"
    }
    $Dirty = & git -C $RepositoryRoot status --porcelain -- $RelativePath
    if (-not [string]::IsNullOrWhiteSpace(($Dirty -join ""))) {
        throw "Migration file has uncommitted changes: $RelativePath"
    }

    $ActualSha256 = (
        Get-FileHash $ResolvedFile.FullName -Algorithm SHA256
    ).Hash.ToUpperInvariant()
    if ($ActualSha256 -cne $ExpectedHash.ToUpperInvariant()) {
        throw @"
Migration SHA-256 mismatch:
  path     = $RelativePath
  expected = $($ExpectedHash.ToUpperInvariant())
  actual   = $ActualSha256
"@
    }
    return $ResolvedFile
}

function Get-MigrationRegistry {
    param(
        [Parameter(Mandatory)] [string]$Content,
        [Parameter(Mandatory)] [string]$RepositoryRoot
    )

    $Pattern = '(?m)^-- DBM-MIGRATION\|' +
        '(?<Version>\d{3,})\|' +
        '(?<Id>[A-Za-z0-9_-]+)\|' +
        '(?<Ledger>[A-Za-z0-9_-]+|NONE)\|' +
        '(?<UpPath>[A-Za-z0-9_./-]+)\|' +
        '(?<UpSha>[A-Fa-f0-9]{64})\|' +
        '(?<DownPath>[A-Za-z0-9_./-]+|NONE)\|' +
        '(?<DownSha>[A-Fa-f0-9]{64}|NONE)\s*$'
    $DeclaredRegistryLines = [regex]::Matches(
        $Content,
        '(?m)^-- DBM-MIGRATION\|.*$'
    )
    $RegistryMatches = [regex]::Matches($Content, $Pattern)
    if ($RegistryMatches.Count -eq 0) {
        throw "DB_MGMT.sql contains no DBM-MIGRATION registry entries."
    }
    if ($DeclaredRegistryLines.Count -ne $RegistryMatches.Count) {
        throw "DB_MGMT.sql contains a malformed DBM-MIGRATION registry entry."
    }

    $Entries = @()
    for ($Index = 0; $Index -lt $RegistryMatches.Count; $Index++) {
        $RegistryMatch = $RegistryMatches[$Index]
        $VersionText = $RegistryMatch.Groups["Version"].Value
        $VersionNumber = 0
        if (-not [int]::TryParse($VersionText, [ref]$VersionNumber) -or
            $VersionNumber -ne ($Index + 1)) {
            throw @"
Migration registry must begin at 001 and remain physically contiguous.
Expected version $($Index + 1); found $VersionText.
"@
        }

        $MigrationId = $RegistryMatch.Groups["Id"].Value
        if (-not $MigrationId.StartsWith("$VersionText`_")) {
            throw "Migration ID '$MigrationId' does not match version $VersionText."
        }

        $LedgerChecksum = $RegistryMatch.Groups["Ledger"].Value
        if (($VersionNumber -eq 1 -and $LedgerChecksum -ne "NONE") -or
            ($VersionNumber -gt 1 -and $LedgerChecksum -eq "NONE")) {
            throw "Only migration 001 may omit a ledger checksum."
        }

        $UpPath = $RegistryMatch.Groups["UpPath"].Value
        $UpSha = $RegistryMatch.Groups["UpSha"].Value
        $UpFile = Get-RepositoryFile -RepositoryRoot $RepositoryRoot -RelativePath $UpPath -ExpectedHash $UpSha
        if ([IO.Path]::GetFileNameWithoutExtension($UpFile.Name) -cne
            $MigrationId) {
            throw "Up migration filename does not match '$MigrationId'."
        }

        $DownPath = $RegistryMatch.Groups["DownPath"].Value
        $DownSha = $RegistryMatch.Groups["DownSha"].Value
        $DownFile = $null
        if ($DownPath -eq "NONE") {
            if ($DownSha -ne "NONE") {
                throw "Down SHA must be NONE when DownPath is NONE."
            }
        }
        else {
            if ($DownSha -eq "NONE") {
                throw "Down SHA is required when DownPath is registered."
            }
            $DownFile = Get-RepositoryFile -RepositoryRoot $RepositoryRoot -RelativePath $DownPath -ExpectedHash $DownSha
            if ([IO.Path]::GetFileNameWithoutExtension($DownFile.Name) -cne
                "$MigrationId.down") {
                throw "Down migration filename must be '$MigrationId.down.sql'."
            }
        }

        $Entries += [PSCustomObject]@{
            Version = $VersionText
            VersionNumber = $VersionNumber
            MigrationId = $MigrationId
            LedgerChecksum = $LedgerChecksum
            UpPath = $UpPath
            UpFile = $UpFile.FullName
            UpSha256 = $UpSha.ToUpperInvariant()
            DownPath = $DownPath
            DownFile = if ($null -eq $DownFile) {
                $null
            } else {
                $DownFile.FullName
            }
            DownSha256 = if ($DownSha -eq "NONE") {
                "NONE"
            } else {
                $DownSha.ToUpperInvariant()
            }
        }
    }
    return @($Entries)
}

function Get-TransactionBody {
    param([Parameter(Mandatory)] [string]$Path)

    $Lines = [IO.File]::ReadAllLines($Path)
    $Significant = @()
    for ($Index = 0; $Index -lt $Lines.Count; $Index++) {
        $Trimmed = $Lines[$Index].Trim()
        if ($Trimmed.Length -gt 0 -and -not $Trimmed.StartsWith("--")) {
            $Significant += $Index
        }
    }
    if ($Significant.Count -eq 0) {
        throw "Migration file is empty: $Path"
    }
    if ($Lines | Where-Object { $_.TrimStart().StartsWith("\") }) {
        throw "Migration files may not contain psql meta-commands: $Path"
    }

    $BoundaryPattern = '^(?i:begin(?:\s+transaction)?|commit|rollback)\s*;$'
    $BoundaryIndexes = @(
        0..($Lines.Count - 1) | Where-Object {
            $Lines[$_].Trim() -match $BoundaryPattern
        }
    )
    $FirstIndex = $Significant[0]
    $LastIndex = $Significant[-1]
    $First = $Lines[$FirstIndex].Trim()
    $Last = $Lines[$LastIndex].Trim()

    if ($First -match '^(?i:begin(?:\s+transaction)?)\s*;$') {
        if ($Last -notmatch '^(?i:commit)\s*;$' -or
            $BoundaryIndexes.Count -ne 2 -or
            $BoundaryIndexes[0] -ne $FirstIndex -or
            $BoundaryIndexes[1] -ne $LastIndex) {
            throw @"
Migration transaction boundary is not runner-safe: $Path
Use one optional outer BEGIN as the first SQL statement and one matching
terminal COMMIT. Do not place COMMIT or ROLLBACK inside the migration body.
"@
        }
        $Lines[$FirstIndex] = "-- outer BEGIN owned by GRM migration walker"
        $Lines[$LastIndex] = "-- outer COMMIT owned by GRM migration walker"
    }
    elseif ($BoundaryIndexes.Count -ne 0) {
        throw "Migration contains an unsafe transaction boundary: $Path"
    }

    return [string]::Join([Environment]::NewLine, $Lines)
}

function Get-MigrationAssertionSql {
    param(
        [Parameter(Mandatory)] $Entry,
        [Parameter(Mandatory)]
        [ValidateSet("UP", "DOWN")]
        [string]$Direction,
        $PreviousEntry
    )

    if ($Direction -eq "UP" -and $Entry.VersionNumber -eq 1) {
        return @"
DO `$grm_assert`$
BEGIN
  IF to_regclass('public.accounts') IS NULL
     OR to_regclass('public.devices') IS NULL
     OR to_regclass('public.account_cursor_state') IS NULL
     OR to_regclass('public.submissions') IS NULL
     OR to_regclass('public.sync_events') IS NULL
     OR to_regclass('public.device_acknowledgements') IS NULL
     OR to_regclass('public.migration_ledger') IS NOT NULL THEN
    RAISE EXCEPTION 'GRM postcondition failed for migration 001';
  END IF;
END
`$grm_assert`$;
"@
    }

    if ($Direction -eq "DOWN" -and $Entry.VersionNumber -eq 1) {
        return @"
DO `$grm_assert`$
BEGIN
  IF to_regclass('public.accounts') IS NOT NULL
     OR to_regclass('public.devices') IS NOT NULL
     OR to_regclass('public.account_cursor_state') IS NOT NULL
     OR to_regclass('public.submissions') IS NOT NULL
     OR to_regclass('public.sync_events') IS NOT NULL
     OR to_regclass('public.device_acknowledgements') IS NOT NULL
     OR to_regclass('public.migration_ledger') IS NOT NULL THEN
    RAISE EXCEPTION 'GRM postcondition failed for migration 001 down';
  END IF;
END
`$grm_assert`$;
"@
    }

    if ($Direction -eq "UP") {
        return @"
DO `$grm_assert`$
BEGIN
  IF NOT EXISTS (
    SELECT 1
      FROM public.migration_ledger
     WHERE migration_id = '$($Entry.MigrationId)'
       AND checksum = '$($Entry.LedgerChecksum)'
  ) THEN
    RAISE EXCEPTION 'GRM ledger postcondition failed for $($Entry.MigrationId)';
  END IF;
END
`$grm_assert`$;
"@
    }

    if ($Entry.VersionNumber -eq 2) {
        return @"
DO `$grm_assert`$
DECLARE
  ledger_has_rows boolean;
BEGIN
  IF to_regclass('public.migration_ledger') IS NOT NULL THEN
    EXECUTE
      'SELECT EXISTS (SELECT 1 FROM public.migration_ledger)'
      INTO ledger_has_rows;
    IF ledger_has_rows THEN
      RAISE EXCEPTION 'GRM expected an empty or absent ledger after 002 down';
    END IF;
  END IF;
END
`$grm_assert`$;
"@
    }

    return @"
DO `$grm_assert`$
BEGIN
  IF EXISTS (
    SELECT 1
      FROM public.migration_ledger
     WHERE migration_id = '$($Entry.MigrationId)'
  ) THEN
    RAISE EXCEPTION 'GRM down migration retained $($Entry.MigrationId)';
  END IF;
  IF NOT EXISTS (
    SELECT 1
      FROM public.migration_ledger
     WHERE migration_id = '$($PreviousEntry.MigrationId)'
       AND checksum = '$($PreviousEntry.LedgerChecksum)'
  ) THEN
    RAISE EXCEPTION 'GRM previous-ledger postcondition failed';
  END IF;
END
`$grm_assert`$;
"@
}

if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    throw "Docker CLI was not found. Install or start Docker Desktop."
}
& docker info *> $null
if ($LASTEXITCODE -ne 0) {
    throw "Docker Desktop is unavailable or its engine is not running."
}
if (-not (Test-Path -LiteralPath $ConfigPath -PathType Leaf)) {
    throw "Configuration file not found: $ConfigPath"
}
if (-not (Test-Path -LiteralPath $ActionPath -PathType Leaf)) {
    throw "Action catalogue not found: $ActionPath"
}

if ([string]::IsNullOrWhiteSpace($Role)) {
    Write-Host "Select Neon role:"
    $Role = Select-Value -Prompt "Role number" -Values @(
        "runtime", "migrator", "dbowner"
    )
}

$Actions = @(
    "connection",
    "gate02-preflight",
    "gate02-postflight",
    "verify-device",
    "provider-baseline",
    "runtime-readiness",
    "list-devices-sanitized",
    "migration-ledger",
    "runtime-privileges",
    "schema-inventory",
    "apply-migration",
    "migrate-to",
    "shell"
)
if ([string]::IsNullOrWhiteSpace($Action)) {
    Write-Host "Select action:"
    $Action = Select-Value -Prompt "Action number" -Values $Actions
}

$ConfigContent = Get-Content -LiteralPath $ConfigPath -Raw
$ExpectedEnvironment = Read-ConfigValue $ConfigContent "Environment"
$NeonBranchAlias = Read-ConfigValue $ConfigContent "BranchAlias"
$NeonHost = Read-ConfigValue $ConfigContent "Host"
$NeonPort = Read-ConfigValue $ConfigContent "Port"
$NeonDatabase = Read-ConfigValue $ConfigContent "Database"
$PostgreSQLVersion = Read-ConfigValue $ConfigContent "PostgreSQLVersion"
$SslMode = Read-ConfigValue $ConfigContent "SslMode"
$ChannelBindingMode = Read-ConfigValue $ConfigContent "ChannelBindingMode"
$RuntimeUser = Read-ConfigValue $ConfigContent "RuntimeUser"
$MigratorUser = Read-ConfigValue $ConfigContent "MigratorUser"
$DbOwnerUser = Read-ConfigValue $ConfigContent "DbOwnerUser"
$CurrentMigrationId = Read-ConfigValue $ConfigContent "CurrentMigrationId"
$CurrentMigrationLedgerChecksum = Read-ConfigValue `
    $ConfigContent `
    "CurrentMigrationLedgerChecksum"
$DatabaseUser = switch ($Role) {
    "runtime" { $RuntimeUser }
    "migrator" { $MigratorUser }
    "dbowner" { $DbOwnerUser }
}

if ($ExpectedEnvironment -ne "development") {
    throw "This helper is locked to Environment: development."
}
if ($NeonHost -notmatch '^ep-[a-z0-9.-]+\.neon\.tech$') {
    throw "Host must be only the direct ep-*.neon.tech hostname."
}
if ($NeonPort -notmatch '^\d{1,5}$') {
    throw "Port must be numeric."
}
if ($PostgreSQLVersion -ne "18") {
    throw "This proven helper is pinned to PostgreSQLVersion: 18."
}
if ($SslMode -ne "require" -or $ChannelBindingMode -ne "require") {
    throw "SslMode and ChannelBindingMode must both be 'require'."
}
if ($NeonDatabase -notmatch '^[A-Za-z_][A-Za-z0-9_-]*$' -or
    $RuntimeUser -notmatch '^[A-Za-z_][A-Za-z0-9_-]*$' -or
    $MigratorUser -notmatch '^[A-Za-z_][A-Za-z0-9_-]*$' -or
    $DbOwnerUser -notmatch '^[A-Za-z_][A-Za-z0-9_-]*$') {
    throw "Database or role name contains unexpected characters."
}
if ($CurrentMigrationId -notmatch '^[A-Za-z0-9_-]+$' -or
    $CurrentMigrationLedgerChecksum -notmatch '^[A-Za-z0-9_-]+$') {
    throw "Migration ID or ledger checksum contains unexpected characters."
}
$Auth0Issuer = $null
if ($Action -eq "account-membership-provision") {
    $Auth0Issuer = Read-ConfigValue $ConfigContent "Auth0Issuer"
    if ($Auth0Issuer.Length -lt 12 -or
        $Auth0Issuer.Length -gt 512 -or
        $Auth0Issuer -notmatch '^https://[^/?#]+/$') {
        throw "Auth0Issuer is not a canonical HTTPS issuer coordinate."
    }
    if ([string]::IsNullOrWhiteSpace($IdentitySubject) -or
        $IdentitySubject.Length -gt 256 -or
        $IdentitySubject -match '[\x00-\x1f\x7f]') {
        throw "account-membership-provision requires a valid session-only identity subject."
    }
}
elseif (-not [string]::IsNullOrWhiteSpace($IdentitySubject)) {
    throw "IdentitySubject is accepted only for account-membership-provision."
}
$PostgresImage = "postgres:${PostgreSQLVersion}-alpine"

Write-Host @"
Selected non-secret target:
  environment = $ExpectedEnvironment
  branch      = $NeonBranchAlias
  database    = $NeonDatabase
  role        = $DatabaseUser
"@
Write-Host `
    "The launcher cannot independently prove the Neon branch alias." `
    -ForegroundColor Yellow

$MigratorOnly = @(
    "gate02-preflight",
    "gate02-postflight",
    "account-membership-provision",
    "apply-migration",
    "migrate-to"
)
if ($Action -in $MigratorOnly -and $Role -ne "migrator") {
    throw "Action '$Action' requires -Role migrator."
}
if ($Action -in @("verify-device", "provider-baseline") -and
    $Role -eq "runtime") {
    throw "$Action requires migrator or dbowner inspection access."
}
if ($Action -eq "account-membership-provision") {
    Write-Host @"
Confirm independently in Neon before authorizing:
  environment = $ExpectedEnvironment
  branch      = $NeonBranchAlias
  database    = $NeonDatabase
  role        = $DatabaseUser
"@
    $ExpectedProvisioningConfirmation = (
        "PROVISION {0} {1}" -f $NeonBranchAlias, $NeonDatabase
    )
    $ProvisioningConfirmation = (
        Read-Host "Type '$ExpectedProvisioningConfirmation' or STOP"
    ).Trim()
    if ($ProvisioningConfirmation -ceq "STOP") {
        throw "Guarded provisioning stopped before database authentication."
    }
    if ($ProvisioningConfirmation -cne $ExpectedProvisioningConfirmation) {
        throw "Guarded provisioning cancelled: confirmation did not match."
    }
}

$ActionContent = Get-Content -LiteralPath $ActionPath -Raw
$MigrationRegistry = @()
$TargetVersionNumber = $null
$RepositoryRoot = $null

if ($Action -eq "migrate-to") {
    $RepositoryRoot = (& git rev-parse --show-toplevel 2>$null).Trim()
    if ($LASTEXITCODE -ne 0 -or
        [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
        throw "Run migrate-to from inside the Markei Git repository."
    }
    $MigrationRegistry = @(
        Get-MigrationRegistry `
            -Content $ActionContent `
            -RepositoryRoot $RepositoryRoot
    )
    $LatestEntry = $MigrationRegistry[-1]

    if ([string]::IsNullOrWhiteSpace($TargetVersion)) {
        $TargetVersion = (
            Read-Host "Target version (latest, 000, or registered number)"
        ).Trim()
    }
    if ($TargetVersion -ieq "latest") {
        $TargetVersionNumber = $LatestEntry.VersionNumber
    }
    else {
        $ParsedTarget = 0
        if ($TargetVersion -notmatch '^\d+$' -or
            -not [int]::TryParse($TargetVersion, [ref]$ParsedTarget) -or
            $ParsedTarget -lt 0 -or
            $ParsedTarget -gt $LatestEntry.VersionNumber) {
            throw @"
TargetVersion must be 'latest', 000, or a version registered in DB_MGMT.sql.
Registry range: 001..$($LatestEntry.Version)
"@
        }
        $TargetVersionNumber = $ParsedTarget
    }
}

$ResolvedMigration = $null
if ($Action -eq "apply-migration") {
    if ([string]::IsNullOrWhiteSpace($MigrationPath)) {
        throw "apply-migration requires -MigrationPath."
    }
    $ResolvedMigration = (Resolve-Path -LiteralPath $MigrationPath).Path
    if ([IO.Path]::GetExtension($ResolvedMigration) -ne ".sql") {
        throw "MigrationPath must identify a .sql file."
    }
    $RepositoryRoot = (& git rev-parse --show-toplevel 2>$null).Trim()
    if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrWhiteSpace($RepositoryRoot)) {
        throw "Run apply-migration from inside the Markei Git repository."
    }
    # Resolve both objects through PowerShell's filesystem provider. Confirm
    # containment by walking the migration's parent directories rather than by
    # comparing path prefixes; this is reliable in Windows PowerShell 5.1 and
    # is unaffected by Git's forward slashes or drive-letter casing.
    $RepositoryDirectory = Get-Item -LiteralPath $RepositoryRoot
    $MigrationFile = Get-Item -LiteralPath $ResolvedMigration
    $CandidateDirectory = $MigrationFile.Directory
    $MigrationIsInsideRepository = $false
    while ($null -ne $CandidateDirectory) {
        if ([string]::Equals(
            $CandidateDirectory.FullName.TrimEnd([char[]]@('\', '/')),
            $RepositoryDirectory.FullName.TrimEnd([char[]]@('\', '/')),
            [StringComparison]::OrdinalIgnoreCase
        )) {
            $MigrationIsInsideRepository = $true
            break
        }
        $CandidateDirectory = $CandidateDirectory.Parent
    }
    if (-not $MigrationIsInsideRepository) {
        throw "MigrationPath must be inside the current Git repository."
    }

    # The parent walk proved that this substring is within the repository.
    $RepositoryRootWithSeparator = $RepositoryDirectory.FullName.TrimEnd(
        [char[]]@('\', '/')
    ) + [IO.Path]::DirectorySeparatorChar
    $RelativeMigration = $MigrationFile.FullName.Substring(
        $RepositoryRootWithSeparator.Length
    ).Replace("\", "/")
    $Tracked = & git -C $RepositoryRoot ls-files `
        --error-unmatch -- $RelativeMigration 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "Migration file must be tracked by Git."
    }
    $Dirty = & git -C $RepositoryRoot status --porcelain -- $RelativeMigration
    if (-not [string]::IsNullOrWhiteSpace(($Dirty -join ""))) {
        throw "Migration file has uncommitted changes."
    }
}

$PsqlVariables = @(
    "-v", "runtime_user=$RuntimeUser",
    "-v", "current_migration_id=$CurrentMigrationId",
    "-v", "current_migration_checksum=$CurrentMigrationLedgerChecksum"
)
$CandidateAccountId = $null
$CandidateIdentityId = $null
if ($Action -eq "account-membership-provision") {
    $CandidateAccountId = [guid]::NewGuid().ToString()
    $CandidateIdentityId = [guid]::NewGuid().ToString()
    $PsqlVariables += @(
        "-v", "migrator_user=$MigratorUser",
        "-v", "identity_issuer=$Auth0Issuer",
        "-v", "candidate_account_id=$CandidateAccountId",
        "-v", "candidate_identity_id=$CandidateIdentityId"
    )
}
if ($Action -in @("verify-device", "provider-baseline")) {
    $DeviceInput = (Read-Host "Device UUID (kept local)").Trim()
    $ParsedDeviceId = [guid]::Empty
    if (-not [guid]::TryParse($DeviceInput, [ref]$ParsedDeviceId)) {
        throw "Device UUID is invalid."
    }
    $PsqlVariables += @("-v", "device_id=$($ParsedDeviceId.ToString())")
}

$SecurePassword = Read-Host `
    "Password for Neon role $DatabaseUser" -AsSecureString
$PasswordPointer = [IntPtr]::Zero
$PlainPassword = $null

try {
    $PasswordPointer =
        [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecurePassword)
    $PlainPassword =
        [Runtime.InteropServices.Marshal]::PtrToStringBSTR($PasswordPointer)
    if ([string]::IsNullOrEmpty($PlainPassword)) {
        throw "A password is required."
    }

    $env:PGHOST = $NeonHost
    $env:PGPORT = $NeonPort
    $env:PGDATABASE = $NeonDatabase
    $env:PGUSER = $DatabaseUser
    $env:PGPASSWORD = $PlainPassword
    $env:PGSSLMODE = $SslMode
    $env:PGCHANNELBINDING = $ChannelBindingMode

    $ProvisioningEnvironment = @()
    if ($Action -eq "account-membership-provision") {
        # Keep the Auth0 subject out of the child-process command line. psql
        # imports it into a session variable from this short-lived environment
        # entry through DBM-AUTO-12's \getenv command.
        $env:MARKEI_GRM_IDENTITY_SUBJECT = $IdentitySubject
        $ProvisioningEnvironment = @(
            "--env", "MARKEI_GRM_IDENTITY_SUBJECT"
        )
    }
    $DockerEnvironment = @(
        "--env", "PGHOST", "--env", "PGPORT", "--env", "PGDATABASE",
        "--env", "PGUSER", "--env", "PGPASSWORD",
        "--env", "PGSSLMODE", "--env", "PGCHANNELBINDING"
    ) + $ProvisioningEnvironment
    $DockerNonInteractive = @("run", "--rm", "-i") + $DockerEnvironment
    $DockerInteractive = @("run", "--rm", "-it") + $DockerEnvironment
    $PsqlBase = @("psql", "-X", "-v", "ON_ERROR_STOP=1")

    function Invoke-PsqlText {
        param(
            [Parameter(Mandatory)] [string]$Sql,
            [switch]$MachineReadable,
            [switch]$SingleTransaction
        )

        $PsqlArguments = @($PsqlBase)
        if ($SingleTransaction) {
            $PsqlArguments += @("--single-transaction", "--file=-")
        }
        if ($MachineReadable) {
            $PsqlArguments += @("-Atq", "-F", "|")
        }

        $Output = $Sql | & docker @DockerNonInteractive `
            $PostgresImage @PsqlArguments
        if ($LASTEXITCODE -ne 0) {
            throw "psql execution failed."
        }
        return @($Output)
    }

    function Get-ProviderMigrationState {
        $BaselineSql = Get-ActionSql $ActionContent "migration-state"
        $BaselineOutput = @(
            Invoke-PsqlText -Sql $BaselineSql -MachineReadable
        )
        $BaselineLines = @(
            $BaselineOutput | Where-Object {
                -not [string]::IsNullOrWhiteSpace([string]$_)
            }
        )
        if ($BaselineLines.Count -ne 1) {
            throw "Migration baseline returned an unexpected row count."
        }
        $BaselineFields = ([string]$BaselineLines[0]).Trim() -split "\|", 2
        if ($BaselineFields.Count -ne 2 -or
            $BaselineFields[0] -notmatch '^[01]$' -or
            $BaselineFields[1] -notmatch '^\d+$') {
            throw "Migration baseline returned an unexpected shape."
        }

        $LedgerPresent = $BaselineFields[0] -eq "1"
        $BaselineObjectCount = [int]$BaselineFields[1]
        if ($BaselineObjectCount -notin @(0, 6)) {
            throw @"
Provider has a partial migration-001 baseline ($BaselineObjectCount of 6).
Stop; do not infer or repair migration state.
"@
        }
        if ($LedgerPresent -and $BaselineObjectCount -ne 6) {
            throw "Provider ledger exists without the complete migration-001 baseline."
        }
        if (-not $LedgerPresent) {
            return [PSCustomObject]@{
                VersionNumber = if ($BaselineObjectCount -eq 6) { 1 } else { 0 }
                LedgerRows = 0
            }
        }

        $LedgerSql = Get-ActionSql $ActionContent "migration-ledger"
        $LedgerOutput = @(
            Invoke-PsqlText -Sql $LedgerSql -MachineReadable
        )
        $LedgerLines = @(
            $LedgerOutput | Where-Object {
                -not [string]::IsNullOrWhiteSpace([string]$_)
            }
        )

        $ExpectedVersion = 2
        foreach ($LedgerLine in $LedgerLines) {
            $LedgerFields = ([string]$LedgerLine).Trim() -split "\|", 3
            if ($LedgerFields.Count -lt 2) {
                throw "Migration ledger returned an unexpected row shape."
            }
            if ($ExpectedVersion -gt $MigrationRegistry.Count) {
                throw "Provider ledger is ahead of the DB_MGMT.sql registry."
            }
            $ExpectedEntry = $MigrationRegistry[$ExpectedVersion - 1]
            if ($LedgerFields[0] -cne $ExpectedEntry.MigrationId -or
                $LedgerFields[1] -cne $ExpectedEntry.LedgerChecksum) {
                throw @"
Provider migration ledger disagrees with DB_MGMT.sql.
Expected: $($ExpectedEntry.MigrationId) | $($ExpectedEntry.LedgerChecksum)
Received: $($LedgerFields[0]) | $($LedgerFields[1])
"@
            }
            $ExpectedVersion++
        }

        return [PSCustomObject]@{
            VersionNumber = $ExpectedVersion - 1
            LedgerRows = $LedgerLines.Count
        }
    }

    # Identity is verified by SQL. Client-side TLS and channel binding are
    # enforced by the values loaded from NS_COORDINATES.md. The launcher
    # accepts only `require` for both. If either requirement cannot be
    # satisfied, psql exits unsuccessfully before this probe can return.
    $ProbeSql = "SELECT current_user, current_database();"
    $ProbeOutput = $ProbeSql | & docker @DockerNonInteractive `
        $PostgresImage @PsqlBase "-Atq"
    if ($LASTEXITCODE -ne 0) {
        throw "Connection preflight failed."
    }

    $ProbeFields = (($ProbeOutput | Select-Object -Last 1).Trim()) `
        -split "\|", 2
    if ($ProbeFields.Count -ne 2 -or
        $ProbeFields[0] -ne $DatabaseUser -or
        $ProbeFields[1] -ne $NeonDatabase) {
        $ReceivedRole = if ($ProbeFields.Count -ge 1) {
            $ProbeFields[0]
        } else {
            "<missing>"
        }
        $ReceivedDatabase = if ($ProbeFields.Count -ge 2) {
            $ProbeFields[1]
        } else {
            "<missing>"
        }
        throw @"
Identity preflight did not match.

Expected:
  role     = $DatabaseUser
  database = $NeonDatabase

Received:
  role     = $ReceivedRole
  database = $ReceivedDatabase
"@
    }

    Write-Host `
        "PASS: role=$DatabaseUser database=$NeonDatabase TLS=active" `
        -ForegroundColor Green

    if ($Action -eq "shell") {
        Write-Host "Opening psql. Use \q to exit."
        & docker @DockerInteractive $PostgresImage @PsqlBase
    }
    elseif ($Action -eq "migrate-to") {
        $InitialState = Get-ProviderMigrationState
        $InitialVersion = $InitialState.VersionNumber
        if ($InitialVersion -gt $MigrationRegistry[-1].VersionNumber) {
            throw "Provider migration state is ahead of the registry."
        }

        $Plan = @()
        if ($TargetVersionNumber -gt $InitialVersion) {
            for ($Version = $InitialVersion + 1; $Version -le $TargetVersionNumber; $Version++) {
                $Plan += [PSCustomObject]@{
                    Direction = "UP"
                    Entry = $MigrationRegistry[$Version - 1]
                }
            }
        }
        elseif ($TargetVersionNumber -lt $InitialVersion) {
            for ($Version = $InitialVersion; $Version -gt $TargetVersionNumber; $Version--) {
                $Entry = $MigrationRegistry[$Version - 1]
                if ($null -eq $Entry.DownFile) {
                    throw @"
DOWN plan is unavailable before any mutation.
Migration $($Entry.Version) has no reviewed down file in DB_MGMT.sql.
Use a reviewed replacement-branch/restore procedure or register its paired
$($Entry.MigrationId).down.sql before requesting this target.
"@
                }
                $Plan += [PSCustomObject]@{
                    Direction = "DOWN"
                    Entry = $Entry
                }
            }
        }

        Write-Host @"
Migration registry:
  current = $("{0:D3}" -f $InitialVersion)
  target  = $("{0:D3}" -f $TargetVersionNumber)
  latest  = $($MigrationRegistry[-1].Version)
"@
        if ($Plan.Count -eq 0) {
            Write-Host "No migration step is required." -ForegroundColor Green
        }
        else {
            Write-Host "Planned steps:"
            foreach ($Step in $Plan) {
                Write-Host (
                    "  {0} {1} {2}" -f
                    $Step.Direction,
                    $Step.Entry.Version,
                    $Step.Entry.MigrationId
                )
            }
        }

        $MigrationStopped = $false
        foreach ($Step in $Plan) {
            $Entry = $Step.Entry
            $Direction = $Step.Direction
            $SelectedPath = if ($Direction -eq "UP") {
                $Entry.UpPath
            } else {
                $Entry.DownPath
            }
            $SelectedFile = if ($Direction -eq "UP") {
                $Entry.UpFile
            } else {
                $Entry.DownFile
            }
            $SelectedSha = if ($Direction -eq "UP") {
                $Entry.UpSha256
            } else {
                $Entry.DownSha256
            }

            Write-Host @"
Next migration:
  direction = $Direction
  version   = $($Entry.Version)
  id        = $($Entry.MigrationId)
  path      = $SelectedPath
  SHA256    = $SelectedSha
"@
            Write-Host @"
Confirm in Neon before authorizing:
  environment = $ExpectedEnvironment
  branch      = $NeonBranchAlias
  database    = $NeonDatabase
"@
            $ExpectedConfirmation = "OK $($Entry.Version)"
            $Confirmation = (
                Read-Host "Type '$ExpectedConfirmation' or STOP"
            ).Trim()
            if ($Confirmation -ceq "STOP") {
                $MigrationStopped = $true
                Write-Host (
                    "STOP: provider remains at the last committed version."
                ) -ForegroundColor Yellow
                break
            }
            if ($Confirmation -cne $ExpectedConfirmation) {
                throw "Migration cancelled: confirmation did not match."
            }

            $PreviousEntry = if ($Entry.VersionNumber -gt 1) {
                $MigrationRegistry[$Entry.VersionNumber - 2]
            } else {
                $null
            }
            $MigrationSql = Get-TransactionBody -Path $SelectedFile
            $AssertionSql = Get-MigrationAssertionSql `
                -Entry $Entry `
                -Direction $Direction `
                -PreviousEntry $PreviousEntry
            $TransactionalSql = $MigrationSql +
                [Environment]::NewLine +
                $AssertionSql

            try {
                Invoke-PsqlText `
                    -Sql $TransactionalSql `
                    -SingleTransaction
            }
            catch {
                throw @"
Migration $Direction $($Entry.Version) failed or has an unclear transport
outcome. SQL and assertion failures are rolled back by psql's single
transaction. Stop and inspect the read-only migration ledger before any retry.
Cause: $($_.Exception.Message)
"@
            }

            $ExpectedState = if ($Direction -eq "UP") {
                $Entry.VersionNumber
            } else {
                $Entry.VersionNumber - 1
            }
            $CommittedState = Get-ProviderMigrationState
            if ($CommittedState.VersionNumber -ne $ExpectedState) {
                throw @"
Committed migration state did not match the requested step.
Expected: $("{0:D3}" -f $ExpectedState)
Observed: $("{0:D3}" -f $CommittedState.VersionNumber)
Stop; do not continue or retry.
"@
            }
            Write-Host (
                "COMMITTED: {0} {1}; provider version is now {2:D3}." -f
                $Direction,
                $Entry.Version,
                $CommittedState.VersionNumber
            ) -ForegroundColor Green
        }

        $FinalState = Get-ProviderMigrationState
        Write-Host @"
Migration result:
  start   = $("{0:D3}" -f $InitialVersion)
  current = $("{0:D3}" -f $FinalState.VersionNumber)
  target  = $("{0:D3}" -f $TargetVersionNumber)
  stopped = $MigrationStopped
"@
        if (-not $MigrationStopped -and
            $FinalState.VersionNumber -ne $TargetVersionNumber) {
            throw "Migration walker ended before the requested target."
        }
    }
    elseif ($Action -eq "apply-migration") {
        Write-Host "Migration: $ResolvedMigration"
        Write-Host `
            "SHA256: $((Get-FileHash $ResolvedMigration -Algorithm SHA256).Hash)"
        Write-Host @"
Confirm in Neon before authorizing:
  environment = $ExpectedEnvironment
  branch      = $NeonBranchAlias
  database    = $NeonDatabase
"@
        $Confirmation = Read-Host "Type APPLY-ONCE after dashboard confirmation"
        if ($Confirmation -cne "APPLY-ONCE") {
            throw "Migration cancelled."
        }
        Get-Content -LiteralPath $ResolvedMigration -Raw |
            & docker @DockerNonInteractive `
                $PostgresImage @PsqlBase
    }
    else {
        $Sql = Get-ActionSql $ActionContent $Action
        $Sql | & docker @DockerNonInteractive `
            $PostgresImage @PsqlBase @PsqlVariables
        if ($Action -eq "connection") {
            Write-Host `
                "Client TLS/channel binding: active (enforced by libpq)"
        }
    }
    if ($LASTEXITCODE -ne 0) {
        throw "Neon action '$Action' failed. Do not retry a migration blindly."
    }
    Write-Host "PASS: '$Action' completed." -ForegroundColor Green
}
finally {
    if ($PasswordPointer -ne [IntPtr]::Zero) {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($PasswordPointer)
    }
    @(
        "PGHOST", "PGPORT", "PGDATABASE", "PGUSER", "PGPASSWORD",
        "PGSSLMODE", "PGCHANNELBINDING",
        "MARKEI_GRM_IDENTITY_SUBJECT"
    ) | ForEach-Object {
        Remove-Item "Env:$_" -ErrorAction SilentlyContinue
    }
    $PlainPassword = $null
    $SecurePassword = $null
    $ProbeOutput = $null
    $PsqlVariables = $null
    $ProvisioningEnvironment = $null
    $CandidateAccountId = $null
    $CandidateIdentityId = $null
    $IdentitySubject = $null
}
