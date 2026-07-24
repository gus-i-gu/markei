[CmdletBinding()]
param(
    [ValidateSet("runtime", "migrator", "dbowner")]
    [string]$Role,

    [ValidateSet(
        "connection",
        "gate02-preflight",
        "gate02-postflight",
        "verify-device",
        "list-devices-sanitized",
        "migration-ledger",
        "runtime-privileges",
        "schema-inventory",
        "apply-migration",
        "shell"
    )]
    [string]$Action,

    [string]$MigrationPath,
    [string]$ConfigPath,
    [string]$ActionPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ScriptDirectory = $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($ScriptDirectory)) {
    $ScriptFile = $MyInvocation.MyCommand.Path
    if ([string]::IsNullOrWhiteSpace($ScriptFile)) {
        throw @"
Unable to determine the NEON_CHECK.ps1 directory.
Run this helper as a script with -File or .\documentation\NEON_CHECK.ps1.
"@
    }
    $ScriptDirectory = Split-Path -Parent $ScriptFile
}

if ([string]::IsNullOrWhiteSpace($ConfigPath)) {
    $ConfigPath = Join-Path $ScriptDirectory "NS_COORDINATES.md"
}
if ([string]::IsNullOrWhiteSpace($ActionPath)) {
    $ActionPath = Join-Path $ScriptDirectory "NEON_ACTION.sql"
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
    "list-devices-sanitized",
    "migration-ledger",
    "runtime-privileges",
    "schema-inventory",
    "apply-migration",
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

$MigratorOnly = @("gate02-preflight", "gate02-postflight", "apply-migration")
if ($Action -in $MigratorOnly -and $Role -ne "migrator") {
    throw "Action '$Action' requires -Role migrator."
}
if ($Action -eq "verify-device" -and $Role -eq "runtime") {
    throw "verify-device requires migrator or dbowner inspection access."
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
if ($Action -eq "verify-device") {
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

    $DockerEnvironment = @(
        "--env", "PGHOST", "--env", "PGPORT", "--env", "PGDATABASE",
        "--env", "PGUSER", "--env", "PGPASSWORD",
        "--env", "PGSSLMODE", "--env", "PGCHANNELBINDING"
    )
    $DockerNonInteractive = @("run", "--rm", "-i") + $DockerEnvironment
    $DockerInteractive = @("run", "--rm", "-it") + $DockerEnvironment
    $PsqlBase = @("psql", "-X", "-v", "ON_ERROR_STOP=1")

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
        $ActionContent = Get-Content -LiteralPath $ActionPath -Raw
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
        "PGSSLMODE", "PGCHANNELBINDING"
    ) | ForEach-Object {
        Remove-Item "Env:$_" -ErrorAction SilentlyContinue
    }
    $PlainPassword = $null
    $SecurePassword = $null
    $ProbeOutput = $null
}
