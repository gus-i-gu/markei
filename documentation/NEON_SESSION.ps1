[CmdletBinding()]
param(
    [ValidateSet("runtime", "migration")]
    [string]$Identity = "runtime"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# EDIT ONLY THIS VALUE.
# Use only the hostname beginning with ep- and ending with .neon.tech.
$NeonHost = "@ep-withered-bread-afszn7ua.c-2.us-west-2.aws.neon.tech/markei?sslmode=require&channel_binding=require"

$NeonDatabase = "markei"
$NeonPort = "5432"

if ($NeonHost -notmatch '^ep-[a-z0-9.-]+\.neon\.tech$') {
    throw @"
NeonHost is invalid.

It must look like:
ep-example.c-2.us-west-2.aws.neon.tech

Do not include:
postgresql://
username
password
@
/markei
?sslmode
"@
}

if ($Identity -eq "runtime") {
    $Role = "markei_runtime"
}
else {
    $Role = "neondb_owner"
}

$Credential = Get-Credential `
    -UserName $Role `
    -Message "Enter the current Neon password for $Role"

if ($Credential.UserName -ne $Role) {
    throw "Expected username $Role."
}

try {
    $env:PGHOST = $NeonHost
    $env:PGPORT = $NeonPort
    $env:PGDATABASE = $NeonDatabase
    $env:PGUSER = $Role
    $env:PGPASSWORD = $Credential.GetNetworkCredential().Password
    $env:PGSSLMODE = "require"
    $env:PGCHANNELBINDING = "require"

    docker run --rm `
        --env PGHOST `
        --env PGPORT `
        --env PGDATABASE `
        --env PGUSER `
        --env PGPASSWORD `
        --env PGSSSSLMODE `
        --env PGCHANNELBINDING `
        postgres:18-alpine `
        psql `
        -X `
        -v ON_ERROR_STOP=1 `
        -c "SELECT current_user, current_database();"

    if ($LASTEXITCODE -ne 0) {
        throw "Neon connection verification failed."
    }

    Write-Host ""
    Write-Host "PASS: connected as $Role to $NeonDatabase." `
        -ForegroundColor Green
}
finally {
    Remove-Item Env:PGHOST -ErrorAction SilentlyContinue
    Remove-Item Env:PGPORT -ErrorAction SilentlyContinue
    Remove-Item Env:PGDATABASE -ErrorAction SilentlyContinue
    Remove-Item Env:PGUSER -ErrorAction SilentlyContinue
    Remove-Item Env:PGPASSWORD -ErrorAction SilentlyContinue
    Remove-Item Env:PGSSLMODE -ErrorAction SilentlyContinue
    Remove-Item Env:PGCHANNELBINDING -ErrorAction SilentlyContinue

    $Credential = $null
}