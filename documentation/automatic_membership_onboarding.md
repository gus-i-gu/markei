# Marc automatic membership — LP-C00-S01-IS01

Local implementation and validation, 4 October 2026. Production/provider acceptance is a separate Step.

## Behavior and boundary

An ordinary user signs in with Auth0 and selects **Connect this Device**. The existing authenticated `POST /v1/devices/enroll` verifies the JWT and atomically creates a first-use Account, external identity, active owner membership, cursor and Device. No developer token copying, migrator access or AUTH-03 is needed in the user flow. No Flutter rebuild is required for this backend change; automatic Connect immediately on sign-in is not added.

Identity is keyed by verified issuer + subject, never email or a client-supplied Account/role. Repeated and concurrent enrollment reuses membership and installation bindings. Existing valid members keep their role. Disabled identities, missing/removed/disabled memberships on an existing identity, and multiple active memberships fail closed instead of creating a replacement owner Account. Invitations remain separately planned.

`GET /v1/identity` and token-only verification remain read-only. Protected Sync/management routes still require existing membership and active Device authorization.

Migration **008_automatic_membership**, ledger checksum `lp-c00-automatic-membership-v1`, adds a fixed-search-path SECURITY DEFINER function callable only by runtime/owner and a v3 readiness function. It grants no direct identity/membership INSERT rights. The trusted API must validate a JWT before calling the function; SQL does not independently validate tokens. Existing Account/Device/Purchase data is not rewritten.

## Local proof

Run from `services/markei_sync_api`. The PostgreSQL proof is opt-in and accepts only localhost port 55438. It refuses an already initialized fixture instead of clearing it. The disposable container uses trust authentication solely on a loopback-published port; never use this configuration for Neon or a shared service.

```powershell
docker run --detach --name marc-onboarding-lp-c00 --publish 127.0.0.1:55438:5432 --env POSTGRES_HOST_AUTH_METHOD=trust postgres:18-alpine
$env:MARKEI_ONBOARDING_TEST_PORT = '55438'
npm run test:onboarding
```

The probe creates non-superuser/non-BYPASSRLS migrator/runtime roles and runs migrations 001–008 on an otherwise empty disposable PostgreSQL 18 database. It validates first use, both concurrency patterns, repeat enrollment, rollback, signed-JWT HTTP onboarding, invalid/expired/wrong-audience/wrong-issuer token rejection with no writes, disabled/removed/conflicting membership, existing member roles, cross-Account/Device denial, ACLs, readiness and data-preserving migration rollback/reapply.

Only remove the named container and its anonymous volume after confirming it is this disposable test fixture:

```powershell
docker rm --force --volumes marc-onboarding-lp-c00
```

Recorded results: **19 onboarding PostgreSQL tests passed**, **61 existing API tests passed**, and the existing hosted-local authorization-race harness returned **28/28 cases true, 0 pending**. Its wider `R3_LOCAL_SECURITY_PROVED` flag remains false; this does not claim all project security proofs are complete. Typecheck, lint, format and build passed. Unchanged Windows CRLF files were normalized only after content equality against Git was established; no unrelated semantic changes were introduced.

## Provider apply sequence — not executed

1. Review the exact source commit and migration SHA-256 registry entries. Confirm the private configured Neon endpoint/branch/database and migrator/runtime roles. Preserve existing installations and app data.
2. Apply **only migration 008** through the existing guarded launcher, from the repository root, after the file is committed and reviewed:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\documentation\I_SCRIPTS.ps1" -Role migrator -Action apply-migration -MigrationPath ".\services\markei_sync_api\migrations\008_automatic_membership.sql"
```

3. Run the read-only postflight below. Existing GS-NEON-04/05/07/10 checks retain their original purpose; migration 007 is not reapplied.
4. Deploy the exact validated server commit to Render. New hosted readiness requires `markei_hosted_runtime_ready_v3()`; absent migration/function/permission fails closed as not-ready. The prior server continues to use v2 during the migration-first transition.
5. Run GS-HOST-01 and GS-AUTH-01. Use a distinct normal test Auth0 identity through the physical app: sign in, Connect, restart as requested, and repeat Connect. Verify one Account/owner/cursor and installation reuse without AUTH-03. Then enroll its other Device and run scoped Sync/isolation acceptance. Do not change the existing developer Account to simulate a new user.

### Read-only onboarding postflight

Run as the configured migrator in the already verified target. Expected: correct ledger/checksum; ready=true; runtime onboarding execution=true; direct identity/membership INSERT=false; PUBLIC function execution=false; no missing/orphan cursors. These aggregate checks do not establish JWT behavior or two-Device Sync by themselves.

```sql
BEGIN TRANSACTION READ ONLY;
SELECT migration_id, checksum
FROM public.migration_ledger
WHERE migration_id = '008_automatic_membership';
SELECT public.markei_hosted_runtime_ready_v3() AS ready;
SELECT
  has_function_privilege('markei_runtime', 'public.markei_onboard_identity_membership(text,text)', 'EXECUTE') AS runtime_onboarding,
  has_table_privilege('markei_runtime', 'public.external_identities', 'INSERT') AS identity_insert,
  has_table_privilege('markei_runtime', 'public.account_memberships', 'INSERT') AS membership_insert;
SELECT EXISTS (
  SELECT 1 FROM pg_proc p,
    LATERAL aclexplode(coalesce(p.proacl, acldefault('f', p.proowner))) acl
  WHERE p.oid = 'public.markei_onboard_identity_membership(text,text)'::regprocedure
    AND acl.grantee = 0 AND acl.privilege_type = 'EXECUTE'
) AS public_onboarding_execution;
SELECT
  (SELECT count(*) FROM public.accounts a LEFT JOIN public.account_cursor_state c USING(account_id) WHERE c.account_id IS NULL) AS missing_cursors,
  (SELECT count(*) FROM public.account_cursor_state c LEFT JOIN public.accounts a USING(account_id) WHERE a.account_id IS NULL) AS orphan_cursors;
ROLLBACK;
```

## Rollback and stop

Stop on target/role mismatch, checksum mismatch, inconsistent ledger, failed readiness, unexpected ownership, partial writes, isolation failure or ambiguous execution. Do not retry provider writes blindly or clear Account/Device data.

Roll the server back to the prior validated release **before** applying the paired `008_automatic_membership.down.sql` through the reviewed migration-to-007 route. The down migration drops only the two new functions and its matching ledger row, retaining Accounts, identities, memberships, cursors, Devices and Sync data. Remaining 007 readiness is preserved. Never use rollback as a reset of user data.

## Remaining acceptance

No Neon migration, Render deployment or real new-user onboarding has been executed by this local implementation. Existing human evidence confirms developer-account two-way Purchase Sync and repeat Sync without duplicates. Live normal-user provisioning, declared provider isolation, Android History refresh and count/kg form validation remain separate gates.
