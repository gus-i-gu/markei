# Markei non-secret operational coordinates

> Coordinate schema: 2
>
> This file is a repository-safe allowlist of public or non-secret operational
> coordinates. It is not a credential store. A value appearing here may still
> deserve limited distribution even when it cannot authenticate anyone.

## 1. Safety contract

Allowed here:

- public origins, route paths, branch names, regions, and runtime versions;
- database, schema, migration, and role names without passwords;
- direct or pooled hostnames without usernames, passwords, paths, or query
  strings;
- Auth0 public tenant metadata, audience, algorithm, and public client IDs;
- provider resource IDs only when an operational procedure genuinely needs
  them.

Never store here:

- passwords, access tokens, refresh tokens, ID tokens, or management tokens;
- client secrets, API keys, private keys, recovery codes, or session cookies;
- complete PostgreSQL URLs or any secret-bearing URL;
- `Authorization`, `Cookie`, or copied environment-variable values;
- real user subjects, account UUIDs, device UUIDs, event payloads, or
  submission identifiers;
- provider screenshots or shell transcripts that may contain excluded values.

Secrets remain outside Git and are entered only through a masked, session-only
terminal prompt when a reviewed procedure requires them.

## 2. Machine-readable coordinate interface

Each key is unique and uses the stable `Name: value` interface consumed by the
PowerShell procedures. Keep placeholders until the corresponding public value
has been independently verified. Do not invent missing values.

### 2.1 Repository and source

```text
CoordinateSchemaVersion: 2
RepositorySlug: gus-i-gu/markei
RepositoryBranch: cycle10-intermid-grimoire
ApiRootDirectory: services/markei_sync_api
MigrationDirectory: services/markei_sync_api/migrations
```

### 2.2 Render development service

```text
RenderEnvironment: development
RenderServiceName: markei-sync-api-dev
RenderServiceId: srv-d9darq6rnols73f55450
RenderPublicOrigin: https://markei-sync-api-dev.onrender.com
RenderRegion: Oregon (US West)
RenderDeployBranch: cycle10-intermid-grimoire
RenderLivePath: /health/live
RenderReadyPath: /health/ready
RenderIdentityPath: /v1/identity
RenderSyncSubmissionsPath: /v1/sync/submissions
RenderNodeMajor: 24
RenderBuildCommand: npm ci --include=dev && npm run build
RenderStartCommand: npm start
```

`RenderServiceId` is optional and should remain a placeholder until a reviewed
Render API/CLI procedure actually consumes it.

### 2.3 Auth0 development configuration

```text
Auth0Environment: development
Auth0TenantDomain: dev-3konqrvsitqugd48.us.auth0.com
Auth0Issuer: https://dev-3konqrvsitqugd48.us.auth0.com/
Auth0Audience: https://api.markei.invalid/development-r2
Auth0ApiName: Markei Development API R2
Auth0Algorithm: RS256
Auth0DiscoveryPath: /.well-known/openid-configuration
Auth0JwksPath: /.well-known/jwks.json
Auth0AndroidApplicationName: Markei Android Development R2
Auth0AndroidClientId: VuW4Y9Vbi8Lpyctjgc1A743YKsYyyRO3
Auth0WindowsApplicationName: Markei Windows Development R2
Auth0WindowsClientId: o1Xh2pce1AFg0kPQNUQFRm4Gk39MgCgh
```

The discovery and JWKS URLs are derived from `Auth0Issuer` plus their stored
paths. They are not duplicated as independent values.

### 2.4 Neon development target

The keys retained from the original `NEON_CRED.md` keep their original names so
the proven launcher remains compatible.

```text
Environment: development
ProjectAlias: Markei
ProjectId: long-wind-52737031
BranchAlias: markei-cycle10-development
BranchId: br-curly-dream-afzqmmuj
ParentBranchAlias: production
BranchExpiration: 2026-07-27
Region: aws-us-west-2
PostgreSQLVersion: 18
EndpointId: ep-raspy-brook-afhm7zmw
Host: ep-raspy-brook-afhm7zmw.c-2.us-west-2.aws.neon.tech
PooledHost: ep-raspy-brook-afhm7zmw-pooler.c-2.us-west-2.aws.neon.tech
Port: 5432
Database: markei_sync_dev
DatabaseSchema: public
RuntimeUser: markei_runtime
MigratorUser: markei_migrator
DbOwnerUser: neondb_owner
SslMode: require
ChannelBindingMode: require
```

`ProjectId`, `BranchId`, and `PooledHost` are optional until a reviewed
procedure consumes them. Administrative checks and migrations use `Host`, the
direct endpoint. The complete pooled runtime URL remains only in the hosted
secret store.

### 2.5 Markei hosted contract

```text
ApiContractVersion: 1
AuthenticationScheme: Bearer
DeviceHeaderName: x-markei-device-id
SupportedEventType: purchase.registered
SupportedPayloadVersion: 3
```

Route paths are owned by the Render section because they are joined to
`RenderPublicOrigin` by the hosted procedures.

### 2.6 Provider migration state

```text
MigrationLedgerTable: public.migration_ledger
CurrentMigrationId: 007_account_cursor_provisioning
CurrentMigrationFile: services/markei_sync_api/migrations/007_account_cursor_provisioning.sql
CurrentMigrationFileSha256: 89AB11302F8B860C52AA1C74FBFEDF6A4DB3A0EE62FE7CB715B20B74AEF99AC6
CurrentMigrationLedgerChecksum: c10-mcg02-account-cursor-provisioning-v1
```

Migration 007 was applied once and postflight-validated on 2026-07-23. These
identifiers support read-only verification; they do not authorize reapplication.

## 3. Original `NEON_CRED.md` migration coverage

Every coordinate from the original file is retained without semantic loss:

| Original key | Current key | Disposition |
| --- | --- | --- |
| `Environment` | `Environment` | Retained |
| `ProjectAlias` | `ProjectAlias` | Retained; verified |
| `BranchAlias` | `BranchAlias` | Retained |
| `Region` | `Region` | Retained |
| `PostgreSQLVersion` | `PostgreSQLVersion` | Retained |
| `Host` | `Host` | Retained |
| `Port` | `Port` | Retained |
| `Database` | `Database` | Retained |
| `RuntimeUser` | `RuntimeUser` | Retained |
| `MigratorUser` | `MigratorUser` | Retained |
| `DbOwnerUser` | `DbOwnerUser` | Retained |

No credential existed in the original file, and none was migrated into this
one.

## 4. Where to verify values

| Coordinate group | Verification source |
| --- | --- |
| Repository slug and branch | GitHub repository page; `git remote -v`; `git branch --show-current` |
| Render service name, ID, origin, region, and branch | Render service header and **Settings → Build & Deploy** |
| Render build/start commands and Node major | Render settings/build log plus `services/markei_sync_api/package.json` |
| Auth0 domain and public client IDs | Auth0 **Applications → Applications → application → Settings** |
| Auth0 API name, audience, and algorithm | Auth0 **Applications → APIs → Markei API → Settings** |
| Neon project alias/ID and region | Neon project overview/settings |
| Neon branch alias/ID, parent, and expiration | Neon **Branches → intended development branch** |
| Neon direct/pooled hostnames, database, and roles | Neon **Connect** dialog with password hidden |
| API routes and contract values | Committed Markei hosted API and Flutter transport source |
| Migration identity and checksums | Committed migration plus read-only migration ledger |

## 5. Lifecycle and exposure classification

| Coordinate | Lifecycle | Exposure note |
| --- | --- | --- |
| Repository slug and source paths | Stable | Public repository coordinates |
| Branch names and deployed revision | Mutable | Reverify before deployment |
| Render origin, service ID, and region | Mutable on service recreation | Non-secret; service ID is unnecessary until automated management exists |
| Auth0 domain, issuer, audience, and client IDs | Mutable/rotatable on tenant or application recreation | Public configuration; never pair with a client secret |
| Auth0 JWKS contents | Automatically rotating | Store only issuer/path, never copied live keys |
| Neon project/branch/endpoint IDs and hostnames | Mutable on resource recreation | Non-secret but operationally revealing |
| Database and role names | Mutable | Non-secret but useful for reconnaissance when combined with the host |
| Role passwords and provider tokens | Rotatable secrets | Never enter this file |
| API routes and contract versions | Versioned | Reconcile with source changes |
| Migration IDs and checksums | Append-only/immutable per migration | Safe and useful verification evidence |

The original direct Neon hostname, database name, and role names are the only
existing fields that merit an exposure warning. They cannot authenticate
without a password, but together reveal the development topology. They remain
here under the user-approved mitigated-risk policy; avoid reposting the file
outside the repository.

## 6. Target guard

Before any provider mutation, independently confirm:

```text
Environment = development
BranchAlias = markei-cycle10-development
Database = markei_sync_dev
RenderDeployBranch = cycle10-intermid-grimoire
```

The database name or hostname alone cannot prove the human-readable Neon
branch. A source branch alone cannot prove the revision currently deployed by
Render.
