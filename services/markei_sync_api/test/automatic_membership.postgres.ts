import assert from "node:assert/strict";
import { randomUUID } from "node:crypto";
import { readFileSync, readdirSync } from "node:fs";
import test, { before, after } from "node:test";
import pg from "pg";
import type { FastifyRequest } from "fastify";
import {
  HostedIdentityService,
  HostedTransactionAuthorizer,
} from "../src/application/hosted_authorization.js";
import {
  HostedAuthError,
  type EnrollmentRequest,
  type ExternalPrincipal,
} from "../src/application/hosted_contracts.js";
import { buildApp } from "../src/http/app.js";
import { Auth0JwtVerifier } from "../src/application/jwt_verifier.js";
import { createSyntheticJwks } from "../src/proof/authorization_slice_scenarios.js";

// Explicit opt-in; this probe cannot use Neon URLs or provider credentials.
const port = Number(process.env.MARKEI_ONBOARDING_TEST_PORT);
assert.equal(
  port,
  55438,
  "Start the disposable localhost fixture on port 55438",
);
const config = { host: "127.0.0.1", port, database: "postgres", max: 6 };
const admin = new pg.Pool({ ...config, user: "postgres" });
const owner = new pg.Pool({ ...config, user: "markei_migrator" });
const runtime = new pg.Pool({ ...config, user: "markei_runtime" });
const issuer = "https://onboarding.example.invalid/";
const principal = (subject: string): ExternalPrincipal => ({
  issuer,
  subject,
  audience: "marc-onboarding-proof",
  expiresAt: new Date(Date.now() + 60000),
});
const request = (headers: Record<string, string> = {}): FastifyRequest =>
  ({ id: randomUUID(), headers }) as unknown as FastifyRequest;
const enrollment = (
  installationId: string = randomUUID(),
): EnrollmentRequest => ({
  contractVersion: 1,
  installationId,
  enrollmentRequestId: randomUUID(),
  platform: "test",
  applicationId: "marc-onboarding-proof",
  applicationVersion: "test",
});
const service = (subject: string, beforeCommit?: () => Promise<void>) =>
  new HostedIdentityService(
    { pool: runtime, beforeCommit },
    { verify: async () => principal(subject) },
    { now: () => new Date() },
  );
const counts = async () =>
  (
    await owner.query(`select
  (select count(*)::int from accounts) accounts,
  (select count(*)::int from external_identities) identities,
  (select count(*)::int from account_memberships) memberships,
  (select count(*)::int from account_cursor_state) cursors,
  (select count(*)::int from devices) devices,
  (select count(*)::int from device_enrollments) enrollments`)
  ).rows[0];
const accountFor = async (subject: string) =>
  (
    await owner.query(
      "select am.account_id, am.identity_id from account_memberships am join external_identities ei using(identity_id) where ei.issuer=$1 and ei.subject=$2",
      [issuer, subject],
    )
  ).rows[0];

before(async () => {
  for (let attempt = 0; ; attempt++) {
    try {
      await admin.query("select 1");
      break;
    } catch (error) {
      if (attempt === 19) throw error;
      await new Promise((resolve) => setTimeout(resolve, 100));
    }
  }
  await admin.query(
    "create role markei_migrator login nosuperuser nobypassrls",
  );
  await admin.query("create role markei_runtime login nosuperuser nobypassrls");
  await admin.query(
    "create role markei_recovery_worker nosuperuser nobypassrls",
  );
  await admin.query("grant usage, create on schema public to markei_migrator");
  assert.equal(
    (await owner.query("select to_regclass('public.accounts') object")).rows[0]
      .object,
    null,
    "Fixture must be a fresh disposable database; existing data is never reset",
  );
  for (const file of readdirSync("migrations")
    .filter((f) => /^00[1-8]_.*\.sql$/.test(f) && !f.endsWith(".down.sql"))
    .sort()) {
    await owner.query(readFileSync(`migrations/${file}`, "utf8"));
  }
});
after(async () => {
  await runtime.end();
  await owner.end();
  await admin.end();
});

test("identity GET and token-only verification stay read-only for an unknown user", async () => {
  const before = await counts();
  assert.equal(
    (await service("read-only").identity(request())).state,
    "membership-required",
  );
  assert.equal(
    (await service("read-only").identity(request(), "token")).state,
    "token-accepted",
  );
  assert.deepEqual(await counts(), before);
});

test("first normal enrollment atomically creates owner membership, cursor and Device", async () => {
  const before = await counts();
  const result = await service("first").enroll(request(), enrollment());
  assert.ok("deviceId" in result);
  const after = await counts();
  for (const field of [
    "accounts",
    "identities",
    "memberships",
    "cursors",
    "devices",
    "enrollments",
  ]) {
    assert.equal(after[field], before[field] + 1);
  }
  const identity = await service("first").identity(request());
  assert.equal(identity.state, "membership-confirmed");
  assert.equal(identity.role, "owner");
  assert.equal(identity.accountId, result.accountId);
  assert.equal(
    (
      await owner.query(
        "select next_cursor from account_cursor_state where account_id=$1",
        [result.accountId],
      )
    ).rows[0].next_cursor,
    "1",
  );
});

test("repeated request and a new request for the same installation reuse the Device", async () => {
  const s = service("repeat");
  const body = enrollment();
  const first = await s.enroll(request(), body);
  assert.ok("deviceId" in first);
  const before = await counts();
  assert.deepEqual(await s.enroll(request(), body), first);
  const repeat = await s.enroll(request(), enrollment(body.installationId));
  assert.ok("deviceId" in repeat);
  assert.equal(repeat.status, "duplicate-equivalent");
  assert.equal(repeat.deviceId, first.deviceId);
  assert.deepEqual(await counts(), before);
});

test("concurrent first use on two installations creates one Account and two Devices", async () => {
  const before = await counts();
  const results = await Promise.all([
    service("concurrent").enroll(request(), enrollment()),
    service("concurrent").enroll(request(), enrollment()),
  ]);
  assert.ok("deviceId" in results[0] && "deviceId" in results[1]);
  assert.equal(results[0].accountId, results[1].accountId);
  assert.notEqual(results[0].deviceId, results[1].deviceId);
  const after = await counts();
  for (const field of ["accounts", "identities", "memberships", "cursors"])
    assert.equal(after[field], before[field] + 1);
  assert.equal(after.devices, before.devices + 2);
});

test("concurrent requests for one installation reuse one Device", async () => {
  const before = await counts();
  const installation = randomUUID();
  const results = await Promise.all([
    service("same-install").enroll(request(), enrollment(installation)),
    service("same-install").enroll(request(), enrollment(installation)),
  ]);
  assert.ok("deviceId" in results[0] && "deviceId" in results[1]);
  assert.equal(results[0].deviceId, results[1].deviceId);
  const after = await counts();
  assert.equal(after.accounts, before.accounts + 1);
  assert.equal(after.devices, before.devices + 1);
});

test("forced pre-commit failure rolls back membership, cursor and enrollment", async () => {
  const before = await counts();
  await assert.rejects(
    service("rollback", async () => {
      throw new Error("synthetic rollback");
    }).enroll(request(), enrollment()),
    /synthetic rollback/,
  );
  assert.deepEqual(await counts(), before);
});

test("rejected JWT verification and malformed enrollment create no records", async () => {
  const before = await counts();
  const rejected = new HostedIdentityService(
    { pool: runtime },
    {
      verify: async () => {
        throw new HostedAuthError("token-rejected");
      },
    },
    { now: () => new Date() },
  );
  await assert.rejects(
    rejected.enroll(request(), enrollment()),
    /token-rejected/,
  );
  await assert.rejects(
    service("malformed").enroll(request(), {
      ...enrollment(),
      installationId: "invalid",
    }),
    /conflict/,
  );
  assert.deepEqual(await counts(), before);
});

for (const state of ["disabled", "removed"]) {
  test(`${state} membership cannot create a replacement Account`, async () => {
    const s = service(`membership-${state}`);
    await s.enroll(request(), enrollment());
    const fixture = await accountFor(`membership-${state}`);
    await owner.query(
      "update account_memberships set status=$1 where identity_id=$2",
      [state, fixture.identity_id],
    );
    const before = await counts();
    await assert.rejects(
      s.enroll(request(), enrollment()),
      /membership-required/,
    );
    assert.deepEqual(await counts(), before);
  });
}

test("disabled identity cannot rebootstrap", async () => {
  await service("disabled-identity").enroll(request(), enrollment());
  await owner.query(
    "update external_identities set status='disabled' where issuer=$1 and subject=$2",
    [issuer, "disabled-identity"],
  );
  const before = await counts();
  await assert.rejects(
    service("disabled-identity").enroll(request(), enrollment()),
    /membership-required/,
  );
  assert.deepEqual(await counts(), before);
});

test("existing identity without any membership fails closed", async () => {
  await owner.query(
    "insert into external_identities(identity_id,issuer,subject,status) values($1,$2,$3,'active')",
    [randomUUID(), issuer, "orphan-identity"],
  );
  const before = await counts();
  await assert.rejects(
    service("orphan-identity").enroll(request(), enrollment()),
    /membership-required/,
  );
  assert.deepEqual(await counts(), before);
});

test("existing member retains role and the existing developer-style Account is reused", async () => {
  const account = randomUUID(),
    identity = randomUUID();
  await owner.query("insert into accounts(account_id) values($1)", [account]);
  await owner.query(
    "insert into external_identities(identity_id,issuer,subject,status) values($1,$2,'existing-member','active')",
    [identity, issuer],
  );
  await owner.query(
    "insert into account_memberships(account_id,identity_id,role,status) values($1,$2,'member','active')",
    [account, identity],
  );
  const result = await service("existing-member").enroll(
    request(),
    enrollment(),
  );
  assert.ok("accountId" in result);
  assert.equal(result.accountId, account);
  assert.equal(
    (await service("existing-member").identity(request())).role,
    "member",
  );
});

test("multiple active memberships require Account selection and do not add records", async () => {
  const fixture = await accountFor("first");
  const account = randomUUID();
  await owner.query("insert into accounts(account_id) values($1)", [account]);
  await owner.query(
    "insert into account_memberships(account_id,identity_id,role,status) values($1,$2,'member','active')",
    [account, fixture.identity_id],
  );
  const before = await counts();
  await assert.rejects(
    service("first").enroll(request(), enrollment()),
    /account-selection-required/,
  );
  assert.deepEqual(await counts(), before);
});

test("distinct users are isolated and cannot authorize another user's Device", async () => {
  const a = await service("isolated-a").enroll(request(), enrollment());
  const b = await service("isolated-b").enroll(request(), enrollment());
  assert.ok("deviceId" in a && "deviceId" in b);
  assert.notEqual(a.accountId, b.accountId);
  const authorizer = new HostedTransactionAuthorizer(
    { pool: runtime },
    { verify: async () => principal("isolated-a") },
  );
  await assert.rejects(
    authorizer.authorizeOperation(
      request({ "x-markei-device-id": b.deviceId }),
      "isolation-proof",
      async () => true,
    ),
  );
  const rows = await authorizer.authorizeOperation(
    request({ "x-markei-device-id": a.deviceId }),
    "isolation-proof",
    async (client) =>
      (await client.query("select account_id from devices")).rows,
  );
  assert.equal(rows.length, 1);
  assert.equal(rows[0].account_id, a.accountId);
});

test("migration preserves runtime restrictions, denies PUBLIC execution and reports readiness", async () => {
  const row = (
    await owner.query(`select
    has_table_privilege('markei_runtime','external_identities','INSERT') identity_insert,
    has_table_privilege('markei_runtime','account_memberships','INSERT') membership_insert,
    has_function_privilege('markei_runtime','markei_onboard_identity_membership(text,text)','EXECUTE') onboarding,
    public.markei_hosted_runtime_ready_v3() ready`)
  ).rows[0];
  assert.deepEqual(row, {
    identity_insert: false,
    membership_insert: false,
    onboarding: true,
    ready: true,
  });
  await admin.query("create role marc_untrusted_probe login");
  await admin.query("grant usage on schema public to marc_untrusted_probe");
  const untrusted = new pg.Pool({ ...config, user: "marc_untrusted_probe" });
  try {
    await assert.rejects(
      untrusted.query(
        "select * from public.markei_onboard_identity_membership($1::text,$2::text)",
        [issuer, "untrusted"],
      ),
      /permission denied/,
    );
  } finally {
    await untrusted.end();
  }
});

test("normal HTTP enrollment with a signed JWT provisions membership without the developer bridge", async () => {
  const jwks = await createSyntheticJwks();
  const clock = { now: () => new Date() };
  const verifier = new Auth0JwtVerifier({
    issuer: jwks.issuer,
    audience: jwks.audience,
    jwksUri: jwks.issuer + ".well-known/jwks.json",
    clock,
  });
  const database = { pool: runtime };
  const app = buildApp({
    database,
    authorization: {
      kind: "hosted",
      identityService: new HostedIdentityService(database, verifier, clock),
      transactionAuthorizer: new HostedTransactionAuthorizer(
        database,
        verifier,
      ),
    },
  });
  try {
    const headers = {
      authorization: "Bearer " + (await jwks.token("auth0|normal-http-proof")),
    };
    const before = await counts();
    assert.equal(
      (await app.inject({ method: "GET", url: "/v1/identity", headers })).json()
        .state,
      "membership-required",
    );
    assert.deepEqual(await counts(), before);
    assert.equal(
      (await app.inject({ method: "GET", url: "/health/ready" })).json().status,
      "ready",
    );
    const response = await app.inject({
      method: "POST",
      url: "/v1/devices/enroll",
      headers,
      payload: enrollment(),
    });
    assert.equal(response.statusCode, 200);
    const identity = (
      await app.inject({ method: "GET", url: "/v1/identity", headers })
    ).json();
    assert.equal(identity.state, "membership-confirmed");
    assert.equal(identity.accountId, response.json().accountId);
  } finally {
    await app.close();
    await jwks.close();
  }
});

test("invalid, expired, wrong-audience and wrong-issuer JWT routes create no database records", async () => {
  const jwks = await createSyntheticJwks();
  try {
    const token = await jwks.token("auth0|rejected-http-proof");
    for (const mode of ["malformed", "expired", "audience", "issuer"]) {
      const clock = {
        now: () => new Date(Date.now() + (mode === "expired" ? 1200000 : 0)),
      };
      const verifier = new Auth0JwtVerifier({
        issuer: mode === "issuer" ? "http://127.0.0.1/wrong/" : jwks.issuer,
        audience: mode === "audience" ? "wrong-audience" : jwks.audience,
        jwksUri: jwks.issuer + ".well-known/jwks.json",
        clock,
      });
      const database = { pool: runtime };
      const app = buildApp({
        database,
        authorization: {
          kind: "hosted",
          identityService: new HostedIdentityService(database, verifier, clock),
          transactionAuthorizer: new HostedTransactionAuthorizer(
            database,
            verifier,
          ),
        },
      });
      try {
        const before = await counts();
        const response = await app.inject({
          method: "POST",
          url: "/v1/devices/enroll",
          headers: {
            authorization:
              "Bearer " + (mode === "malformed" ? "invalid" : token),
          },
          payload: enrollment(),
        });
        assert.equal(response.statusCode, 401, mode);
        assert.deepEqual(await counts(), before);
      } finally {
        await app.close();
      }
    }
  } finally {
    await jwks.close();
  }
});

test("migration is owned by a non-superuser non-bypass migrator and invalid function input writes nothing", async () => {
  const role = (
    await admin.query(
      "select rolsuper,rolbypassrls from pg_roles where rolname='markei_migrator'",
    )
  ).rows[0];
  assert.deepEqual(role, { rolsuper: false, rolbypassrls: false });
  const before = await counts();
  assert.equal(
    (
      await runtime.query(
        "select * from public.markei_onboard_identity_membership($1,$2)",
        ["short", ""],
      )
    ).rowCount,
    0,
  );
  assert.deepEqual(await counts(), before);
});

test("migration rollback preserves all data and new hosted readiness fails closed", async () => {
  const before = await counts();
  await owner.query(
    readFileSync("migrations/008_automatic_membership.down.sql", "utf8"),
  );
  assert.deepEqual(await counts(), before);
  const app = buildApp({
    database: { pool: runtime },
    authorization: {
      kind: "hosted",
      identityService: service("repeat"),
      transactionAuthorizer: {} as never,
    },
  });
  try {
    assert.equal(
      (await app.inject({ method: "GET", url: "/health/ready" })).json().status,
      "not-ready",
    );
  } finally {
    await app.close();
  }
  assert.equal(
    (
      await runtime.query(
        "select public.markei_hosted_runtime_ready_v2() ready",
      )
    ).rows[0].ready,
    true,
  );
  await owner.query(
    readFileSync("migrations/008_automatic_membership.sql", "utf8"),
  );
  assert.deepEqual(await counts(), before);
});
