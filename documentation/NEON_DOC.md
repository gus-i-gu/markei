# Markei Neon Setup — Local Operational Record

## Public configuration

```text
Branch: development
Database: markei
Direct hostname: postgresql://neondb_owner:npg_gjhv4kctHV1z@ep-withered-bread-afszn7ua.c-2.us-west-2.aws.neon.tech/neondb?sslmode=require&channel_binding=require
Migration role: neondb_owner
Runtime role: markei_runtime
Pooling for migrations: disabled
PostgreSQL client: Docker postgres:18-alpine
```

## Secret-storage rule

Passwords and complete `postgresql://` URLs must not appear in:

- this file;
- Git;
- Sketch Notebook staging;
- screenshots;
- terminal commands;
- chat.

`NEON_SESSION.ps1` requests the selected password through a masked credential
window and constructs the temporary URL in memory.

## Environment-variable names

```text
MARKEI_MIGRATION_DATABASE_URL
MARKEI_RUNTIME_DATABASE_URL
MARKEI_SYNC_DATABASE_URL
```

Meanings:

- `MARKEI_MIGRATION_DATABASE_URL`:  `neondb_owner`
- `MARKEI_RUNTIME_DATABASE_URL`: `markei_runtime`
- `MARKEI_SYNC_DATABASE_URL`: 'postgresql://neondb_owner:npg_gjhv4kctHV1z@ep-withered-bread-afszn7ua.c-2.us-west-2.aws.neon.tech/neondb?sslmode=require&channel_binding=require'

## Migration evidence

```text
001_init.sql
SHA-256:
F48A9E5D097BE5BD758FF76FF83D8CE8F81F364050F7DF4E3B463D26C18BD0CD

002_coordination_hardening.sql
SHA-256:
32A0215E553585F48C8F9A8D50A622E34296A3F0D94FCDAF60A9DED278BED923

002 ledger timestamp:
2026-07-15 02:28:10.793779+00
```

## Current completion state

```text
Step 3.1 — Administrative migration identity: complete
Step 3.2 — Runtime identity created through SQL: complete
Step 3.3 — No neon_superuser membership: complete
Step 3.4 — Least-privilege grants: complete
Step 3.5 — Live runtime DDL denial: pending
Step 3.6 — RLS fail-closed verification: pending

Step 4.1 — Direct migration connection: complete
Step 4.2 — Migrations 001 and 002: complete
Step 4.3 — Hashes and ledger timestamp: complete
Step 4.4 — Constraints/indexes/policies/RLS inventory: complete
Step 4.5 — Runtime and cross-Account denial: pending
Step 4.6 — No real user data: complete
```

## Verified runtime grants

```text
accounts                SELECT
devices                 SELECT
account_cursor_state    INSERT, SELECT, UPDATE
submissions             INSERT, SELECT, UPDATE
sync_events             INSERT, SELECT, UPDATE
device_acknowledgements INSERT, SELECT, UPDATE

Schema public USAGE: true
Schema public CREATE: false
```

## Next checkpoint

Run:

```powershell
& .\documentation\NEON_SESSION.ps1 -Identity runtime
```

Expected identity:

```text
current_user     markei_runtime
current_database markei
```


### NEON_DOC 2.0

MCG-01 SANITIZED EVIDENCE
Date: 2026-07-15

Environment
- Plan: free    
- Region: us-w-2
- PostgreSQL version: 18.4
- Development branch available: yes
- Branch alias: markei-cycle10-development
- Parent branch: production
- Branch expiration: 16/02/2026
- Disposable database: markei_sync_dev
- Production branch used for probes: no

Role separation
- markei_migrator login: pass
- markei_runtime login: pass
- migrator neon_superuser member: false
- runtime neon_superuser member: false
- migrator schema CREATE: allowed
- runtime schema CREATE: denied
- runtime role administration: denied by role attributes

Connectivity
- Direct endpoint connection: pass
- TLS connection: pass — TLS 1.3
- Channel binding required connection: pass
- Connection URI parsing problems: none
- Credentials stored outside Git: yes
- Credentials disclosed in evidence: no

Migration probe
- Transactional CREATE TABLE: pass
- Transactional INSERT: pass
- ROLLBACK: pass
- Object absent after rollback: pass

Runtime privilege probe
- Explicit SELECT: pass
- Explicit INSERT: pass
- Explicit UPDATE: pass
- Explicit DELETE: pass
- Unprivileged CREATE TABLE: denied as expected
- Unauthorized object created: no

Cleanup
- Transaction probe absent: pass
- Privilege probe absent: pass
- Unauthorized probe absent: pass
- Disposable objects remaining: none

MCG-01 result
- Isolated Neon development environment: PASS
- Separate migration/runtime identities: PASS
- Sanitized connectivity evidence: PASS
- Transaction/migration capability evidence: PASS
- Least-privilege boundary evidence: PASS
- Production deployment authorized: NO
- MCG-02 authentication/hosting configured: NO
