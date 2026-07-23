# Markei General Scripts

> User-facing command index. Short commands dispatch to reviewed scripts.
> Repository: `gus-i-gu/markei`; branch: `intermid-cycle-recovery`.

## 0. Execution model

```text
User
→ minimal command copied from this file
→ verbose implementation in NEON_CHECK.ps1 / NEON_ACTION.sql
→ masked credential or local coordinate request only when required
→ sanitized result
```

Keep these files together:

```text
GENERAL_SCRIPTS.md
GRIMOIRE.md
NEON_CHECK.ps1
NEON_ACTION.sql
NEON_CRED.md
```

Run commands from the directory containing `NEON_CHECK.ps1`, unless a command
explicitly says repository root.

## Pre-5 — Neon terminal and checks

Requirements: Windows PowerShell, Docker Desktop running, and PostgreSQL
`postgres:18-alpine` image access. Local `psql` is not required.

### Interactive terminal

```powershell
.\NEON_CHECK.ps1 -Role migrator -Action shell
```

```powershell
.\NEON_CHECK.ps1 -Role runtime -Action shell
```

The script reads the selected username from `NEON_CRED.md` and asks for its
password in a masked prompt. Exit psql with `\q`.

### Sanitized connection proof

```powershell
.\NEON_CHECK.ps1 -Role migrator -Action connection
```

### Gate 02 preflight

```powershell
.\NEON_CHECK.ps1 -Role migrator -Action gate02-preflight
```

Expected before migration 007:

- migration 006 exists with checksum
  `c10-s03a-r3-hosted-authorization-v1`;
- migration 007 is absent;
- readiness-v2 and provisioning objects are absent;
- the missing cursor-state count is recorded.

### Apply exact migration 007 once

Run from the repository root, adjusting only the helper path if these files are
stored elsewhere:

```powershell
.\documentation\NEON_CHECK.ps1 `
  -Role migrator `
  -Action apply-migration `
  -MigrationPath .\services\markei_sync_api\migrations\007_account_cursor_provisioning.sql
```

The helper refuses an untracked or locally modified migration, prints its
SHA-256, and requires the literal confirmation `APPLY-ONCE`.

### Gate 02 postflight

```powershell
.\NEON_CHECK.ps1 -Role migrator -Action gate02-postflight
```

Required:

- one migration-007 ledger row with checksum
  `c10-mcg02-account-cursor-provisioning-v1`;
- readiness-v2 is true;
- provisioning function exists and trigger count is `1`;
- missing and orphan cursor-state counts are `0`;
- runtime `SELECT=true`, `INSERT=false`, `DELETE=false`;
- runtime can update only `next_cursor`;
- runtime can execute readiness-v2 but not provisioning.

### Runtime readiness proof

```powershell
.\NEON_CHECK.ps1 -Role runtime -Action shell
```

Then:

```sql
SELECT current_user, current_database(),
       public.markei_hosted_runtime_ready_v2() AS ready;
```

## 1. Other Neon actions

```powershell
.\NEON_CHECK.ps1 -Role migrator -Action migration-ledger
.\NEON_CHECK.ps1 -Role migrator -Action schema-inventory
.\NEON_CHECK.ps1 -Role migrator -Action runtime-privileges
.\NEON_CHECK.ps1 -Role migrator -Action list-devices-sanitized
.\NEON_CHECK.ps1 -Role migrator -Action verify-device
```

Running without arguments opens role and action menus:

```powershell
.\NEON_CHECK.ps1
```

## 2. Git alignment

```powershell
git fetch --prune origin
git status --short --branch
git rev-parse HEAD
git rev-parse origin/intermid-cycle-recovery
git rev-list --left-right --count origin/intermid-cycle-recovery...HEAD
```

`0 0` means local and remote agree. Record full SHAs. Stop on divergence or a
dirty overlap.

## 3. Render deployment checks

Before deployment:

- migration postflight passed;
- GitHub branch head is the authorized full SHA;
- Render watches the correct repository and branch;
- no deployment is active;
- auto-deploy state is known.

With auto-deploy off, trigger exactly one **Deploy latest commit** only after
confirming “latest” equals the authorized SHA.

Health check:

```powershell
$Origin = Read-Host "Render public origin"
$Origin = $Origin.TrimEnd("/")
$Live = Invoke-WebRequest -Uri "$Origin/health/live" -Method Get `
  -MaximumRedirection 0 -SkipHttpErrorCheck
$Ready = Invoke-WebRequest -Uri "$Origin/health/ready" -Method Get `
  -MaximumRedirection 0 -SkipHttpErrorCheck
[pscustomobject]@{
  LiveStatus = [int]$Live.StatusCode
  ReadyStatus = [int]$Ready.StatusCode
  LiveClass = $Live.Content
  ReadyClass = $Ready.Content
}
```

## 4. Auth0 public checks

```powershell
$Issuer = (Read-Host "Auth0 issuer").TrimEnd("/")
$Discovery = Invoke-RestMethod "$Issuer/.well-known/openid-configuration"
$Jwks = Invoke-RestMethod "$Issuer/.well-known/jwks.json"
[pscustomobject]@{
  IssuerMatches = ($Discovery.issuer.TrimEnd("/") -eq $Issuer)
  JwksKeys = @($Jwks.keys).Count
  HasRs256Key = @($Jwks.keys | Where-Object {
    $_.kty -eq "RSA" -and $_.use -eq "sig" -and $_.alg -eq "RS256"
  }).Count -gt 0
}
```

This checks public metadata only. Never print access tokens or client secrets.

## 5. Build checks

Sync API:

```powershell
Push-Location services\markei_sync_api
npm ci --include=dev
npm run format:check
npm run lint
npm run typecheck
npm test
npm run build
Pop-Location
```

Flutter:

```powershell
flutter pub get
flutter analyze
flutter test
flutter build windows --release
flutter build apk --debug
```

## 6. Stop conditions

Stop before mutation if the target branch may be production, the role is not
`markei_migrator`, prerequisites/checksums disagree, migration 007 already
exists unexpectedly, the migration file is dirty, GitHub advanced, another
deployment is active, or any command would disclose a secret.

After an unclear migration result, run read-only postflight/ledger checks.
Never reconstruct or partially rerun the migration by hand.
