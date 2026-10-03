param(
    [Parameter(Mandatory = $true)][string]$ISCCPath,
    [string]$ReleaseDirectory,
    [string]$OutputDirectory,
    [string]$VCRuntimeDirectory
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$repoRoot = Split-Path -Parent $PSScriptRoot
$clientRoot = Join-Path $repoRoot 'clients\markei_flutter'
if (-not $ReleaseDirectory) { $ReleaseDirectory = Join-Path $clientRoot 'build\windows\x64\runner\Release' }
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $repoRoot 'dist\flutter-installer' }
$ReleaseDirectory = (Resolve-Path -LiteralPath $ReleaseDirectory).Path
foreach ($file in @('markei.exe', 'flutter_windows.dll', 'data\icudtl.dat', 'data\app.so', 'data\flutter_assets')) {
    if (-not (Test-Path -LiteralPath (Join-Path $ReleaseDirectory $file))) { throw "Flutter release bundle is incomplete: $file" }
}
$versionLine = Get-Content -LiteralPath (Join-Path $clientRoot 'pubspec.yaml') | Where-Object { $_ -match '^version:\s*' } | Select-Object -First 1
if ($versionLine -notmatch '^version:\s*(\d+\.\d+\.\d+)\+(\d+)\s*$') { throw 'pubspec.yaml must declare a numeric version and build number.' }
$version = $Matches[1]
$buildNumber = $Matches[2]
$exeInfo = (Get-Item -LiteralPath (Join-Path $ReleaseDirectory 'markei.exe')).VersionInfo
$exeVersion = '{0}.{1}.{2}.{3}' -f $exeInfo.FileMajorPart, $exeInfo.FileMinorPart, $exeInfo.FileBuildPart, $exeInfo.FilePrivatePart
if ($exeVersion -ne "$version.$buildNumber") { throw "Executable version $exeVersion does not match pubspec $version+$buildNumber. Rebuild Flutter first." }
if (-not $VCRuntimeDirectory) {
    $vcRedistRoot = Join-Path ${env:ProgramFiles} 'Microsoft Visual Studio\2022\Community\VC\Redist\MSVC'
    $VCRuntimeDirectory = Get-ChildItem -LiteralPath $vcRedistRoot -Directory -ErrorAction SilentlyContinue |
        Sort-Object Name -Descending | ForEach-Object { Join-Path $_.FullName 'x64\Microsoft.VC143.CRT' } |
        Where-Object { Test-Path -LiteralPath (Join-Path $_ 'msvcp140.dll') } | Select-Object -First 1
}
if (-not $VCRuntimeDirectory) { throw 'Provide -VCRuntimeDirectory pointing to the Visual C++ x64 redistributable CRT folder.' }
$VCRuntimeDirectory = (Resolve-Path -LiteralPath $VCRuntimeDirectory).Path
foreach ($dll in @('msvcp140.dll', 'vcruntime140.dll', 'vcruntime140_1.dll')) {
    if (-not (Test-Path -LiteralPath (Join-Path $VCRuntimeDirectory $dll))) { throw "Missing Visual C++ runtime: $dll" }
}
New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
$OutputDirectory = (Resolve-Path -LiteralPath $OutputDirectory).Path
& $ISCCPath "/DReleaseDir=$ReleaseDirectory" "/DOutputPath=$OutputDirectory" "/DAppVersion=$version" "/DBuildNumber=$buildNumber" "/DVCRuntimeDir=$VCRuntimeDirectory" (Join-Path $repoRoot 'installer\MarkeiFlutter.iss')
if ($LASTEXITCODE -ne 0) { throw 'Flutter installer compilation failed.' }
$artifact = Join-Path $OutputDirectory "Markei-Flutter-Setup-$version-$buildNumber-x64.exe"
if (-not (Test-Path -LiteralPath $artifact)) { throw "Installer was not produced: $artifact" }
$hash = (Get-FileHash -LiteralPath $artifact -Algorithm SHA256).Hash.ToLowerInvariant()
"$hash  $([IO.Path]::GetFileName($artifact))" | Set-Content -LiteralPath "$artifact.sha256" -Encoding ascii
Write-Output "Flutter installer: $artifact"
