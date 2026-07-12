param(
    [switch]$NoClean,
    [string]$PythonCommand = "python"
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
Set-Location $repoRoot

if (-not (Test-Path "Markei.spec")) {
    throw "Markei.spec was not found in the repository root."
}

try {
    & $PythonCommand -c "import sys; print(sys.executable)" | Out-Host
}
catch {
    throw "Python command '$PythonCommand' is not available."
}

try {
    & $PythonCommand -m PyInstaller --version | Out-Host
}
catch {
    throw "PyInstaller is not available for '$PythonCommand'. Install requirements-build.txt."
}

if (-not $NoClean) {
    Remove-Item -Recurse -Force "build\Markei", "dist" -ErrorAction SilentlyContinue
}

$arguments = @(
    "-m", "PyInstaller",
    "--noconfirm",
    "Markei.spec"
)

if (-not $NoClean) {
    $arguments = @("-m", "PyInstaller", "--clean", "--noconfirm", "Markei.spec")
}

& $PythonCommand @arguments

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

$distPath = Join-Path $repoRoot "dist\Markei"
$exePath = Join-Path $distPath "Markei.exe"

if (-not (Test-Path $exePath)) {
    throw "Build completed without expected executable: $exePath"
}

Write-Host "Markei distribution: $distPath"
