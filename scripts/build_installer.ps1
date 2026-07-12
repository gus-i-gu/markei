param(
    [string]$ISCCPath = $env:ISCC_PATH
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

$distExe = Join-Path $repoRoot "dist\Markei\Markei.exe"
$installerSource = Join-Path $repoRoot "installer\Markei.iss"

if (-not (Test-Path $distExe)) {
    throw "Frozen distribution is absent. Run scripts\build_windows.ps1 first."
}

if (-not (Test-Path $installerSource)) {
    throw "Installer source is absent: $installerSource"
}

$candidates = @()

if ($ISCCPath) {
    $candidates += $ISCCPath
}

$candidates += @(
    "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe",
    "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe",
    "$env:ProgramFiles\Inno Setup 6\ISCC.exe"
)

$iscc = $candidates | Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1

if (-not $iscc) {
    throw "ISCC.exe was not found. Install Inno Setup 6 or pass -ISCCPath / set ISCC_PATH."
}

& $iscc $installerSource

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

$artifact = Join-Path $repoRoot "dist\installer\Markei-Setup-0.1.0-x64.exe"

if (-not (Test-Path $artifact)) {
    throw "Installer compile completed without expected artifact: $artifact"
}

Write-Host "Markei installer: $artifact"
