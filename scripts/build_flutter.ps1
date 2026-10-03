param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('android', 'windows')][string]$Target,
    [Parameter(Mandatory = $true)][string]$DefinesPath,
    [string]$FlutterCommand = 'flutter',
    [string]$AndroidSdkPath,
    [ValidateSet('apk', 'appbundle')][string]$AndroidFormat = 'apk',
    [string]$VcpkgRoot = $env:VCPKG_ROOT
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$repoRoot = Split-Path -Parent $PSScriptRoot
$clientRoot = Join-Path $repoRoot 'clients\markei_flutter'
$definesFile = (Resolve-Path -LiteralPath $DefinesPath).Path
$defines = Get-Content -LiteralPath $definesFile -Raw | ConvertFrom-Json
$clientKey = if ($Target -eq 'android') { 'MARKEI_AUTH0_ANDROID_CLIENT_ID' } else { 'MARKEI_AUTH0_WINDOWS_CLIENT_ID' }
foreach ($key in @('MARKEI_AUTH0_DOMAIN', 'MARKEI_AUTH0_AUDIENCE', 'MARKEI_HOSTED_HTTPS_ORIGIN', $clientKey)) {
    $property = $defines.PSObject.Properties[$key]
    if ($null -eq $property -or [string]::IsNullOrWhiteSpace([string]$property.Value)) {
        throw "Release configuration is missing $key."
    }
}
if ([string]$defines.MARKEI_AUTH0_DOMAIN -notmatch '^[a-z0-9][a-z0-9.-]+\.[a-z]{2,}$' -or [string]$defines.MARKEI_AUTH0_DOMAIN -match '\.invalid$') {
    throw 'Release Auth0 domain must be a real hostname without a URL scheme.'
}
foreach ($key in @('MARKEI_AUTH0_AUDIENCE', 'MARKEI_HOSTED_HTTPS_ORIGIN')) {
    $uri = $null
    if (-not [Uri]::TryCreate([string]$defines.$key, [UriKind]::Absolute, [ref]$uri) -or $uri.Scheme -ne 'https' -or $uri.UserInfo) {
        throw "$key must be an HTTPS URL without embedded credentials."
    }
}
$oldSdk = $env:ANDROID_HOME
$oldSdkRoot = $env:ANDROID_SDK_ROOT
$oldDomain = $env:ORG_GRADLE_PROJECT_MARKEI_AUTH0_DOMAIN
$oldVcpkg = $env:VCPKG_ROOT
$oldToolchain = $env:CMAKE_TOOLCHAIN_FILE
try {
    if ($AndroidSdkPath) {
        $env:ANDROID_HOME = (Resolve-Path -LiteralPath $AndroidSdkPath).Path
        $env:ANDROID_SDK_ROOT = $env:ANDROID_HOME
    }
    if ($Target -eq 'android') {
        if (-not (Test-Path -LiteralPath (Join-Path $clientRoot 'android\key.properties'))) {
            throw 'Android release signing is missing. Configure android/key.properties using RELEASE.md.'
        }
        $env:ORG_GRADLE_PROJECT_MARKEI_AUTH0_DOMAIN = [string]$defines.MARKEI_AUTH0_DOMAIN
    } elseif ($VcpkgRoot) {
        $env:VCPKG_ROOT = (Resolve-Path -LiteralPath $VcpkgRoot).Path
        $env:CMAKE_TOOLCHAIN_FILE = Join-Path $env:VCPKG_ROOT 'scripts\buildsystems\vcpkg.cmake'
        if (-not (Test-Path -LiteralPath $env:CMAKE_TOOLCHAIN_FILE)) { throw 'vcpkg toolchain not found.' }
    }
    Push-Location $clientRoot
    try {
        & $FlutterCommand pub get --enforce-lockfile
        if ($LASTEXITCODE -ne 0) { throw 'Flutter dependency resolution failed.' }
        & $FlutterCommand analyze --no-pub
        if ($LASTEXITCODE -ne 0) { throw 'Flutter analysis failed.' }
        $buildTarget = if ($Target -eq 'android') { $AndroidFormat } else { 'windows' }
        & $FlutterCommand build $buildTarget --release --no-pub "--dart-define-from-file=$definesFile" '--dart-define=MARKEI_NATIVE_CLOSURE_SURFACE=false'
        if ($LASTEXITCODE -ne 0) { throw "Flutter $Target release build failed." }
        $artifact = if ($Target -eq 'android' -and $AndroidFormat -eq 'appbundle') {
            'build\app\outputs\bundle\release\app-release.aab'
        } elseif ($Target -eq 'android') {
            'build\app\outputs\flutter-apk\app-release.apk'
        } else {
            'build\windows\x64\runner\Release\markei.exe'
        }
        if (-not (Test-Path -LiteralPath $artifact)) { throw "Expected release artifact not found: $artifact" }
        Write-Output "Flutter release: $(Join-Path $clientRoot $artifact)"
    } finally { Pop-Location }
} finally {
    $env:ANDROID_HOME = $oldSdk
    $env:ANDROID_SDK_ROOT = $oldSdkRoot
    $env:ORG_GRADLE_PROJECT_MARKEI_AUTH0_DOMAIN = $oldDomain
    $env:VCPKG_ROOT = $oldVcpkg
    $env:CMAKE_TOOLCHAIN_FILE = $oldToolchain
}
