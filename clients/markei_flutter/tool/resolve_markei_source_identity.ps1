param(
    [Parameter(Mandatory)] [string]$RepositoryRoot,
    [switch]$Json,
    [switch]$SelfCheck
)

$ErrorActionPreference = "Stop"

function Resolve-MarkeiSourceIdentity {
    param([Parameter(Mandatory)] [string]$RepositoryRoot)

    $ResolvedRepositoryRoot = (Get-Item -LiteralPath $RepositoryRoot).FullName
    $Head = (
        & git -C $ResolvedRepositoryRoot rev-parse HEAD
    ).Trim().ToLowerInvariant()
    if ($LASTEXITCODE -ne 0 -or $Head -notmatch '^[a-f0-9]{40}$') {
        throw "Could not resolve a valid 40-character source revision."
    }

    $Tree = (
        & git -C $ResolvedRepositoryRoot rev-parse "$Head^{tree}"
    ).Trim().ToLowerInvariant()
    if ($LASTEXITCODE -ne 0 -or $Tree -notmatch '^[a-f0-9]{40}$') {
        throw "Could not resolve a valid Git tree object for HEAD."
    }

    $Dirty = @(
        & git -C $ResolvedRepositoryRoot status --porcelain -- `
            "clients/markei_flutter/lib" `
            "clients/markei_flutter/android" `
            "clients/markei_flutter/windows" `
            "clients/markei_flutter/pubspec.yaml" `
            "clients/markei_flutter/test" `
            "clients/markei_flutter/tool" `
            "documentation/G_SCRIPTS.md" `
            "documentation/I_SCRIPTS.ps1" `
            "documentation/NS_COORDINATES.md"
    )
    if ($LASTEXITCODE -ne 0) {
        throw "Could not inspect relevant source cleanliness."
    }
    if ($Dirty.Count -gt 0) {
        throw "Relevant source identity inputs are dirty; commit or revert them before deriving build identity."
    }

    $Material = "markei-source-tree-v1`n$Tree`n"
    $Bytes = [Text.Encoding]::UTF8.GetBytes($Material)
    $Sha = [Security.Cryptography.SHA256]::Create()
    try {
        $DigestBytes = $Sha.ComputeHash($Bytes)
    }
    finally {
        $Sha.Dispose()
    }
    $SourceTreeSha256 = (
        [BitConverter]::ToString($DigestBytes) -replace "-", ""
    ).ToLowerInvariant()
    if ($SourceTreeSha256 -notmatch '^[a-f0-9]{64}$') {
        throw "Could not derive a valid source-tree SHA-256."
    }

    [pscustomobject][ordered]@{
        SourceRevision = $Head
        DisplayRevision = $Head.Substring(0, 12)
        GitTreeObjectId = $Tree
        SourceTreeSha256 = $SourceTreeSha256
    }
}

$Identity = Resolve-MarkeiSourceIdentity -RepositoryRoot $RepositoryRoot

if ($SelfCheck) {
    $SecondIdentity = Resolve-MarkeiSourceIdentity -RepositoryRoot $RepositoryRoot
    if ($Identity.SourceRevision -cne $SecondIdentity.SourceRevision -or
        $Identity.SourceTreeSha256 -cne $SecondIdentity.SourceTreeSha256) {
        throw "Source identity self-check was not deterministic."
    }
}

if ($Json) {
    $Identity | ConvertTo-Json -Compress
}
else {
    $Identity
}
