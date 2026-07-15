import pg from "pg";
import { makeProducerResult } from "./producer.js";

const migratorUrl = process.env.LAB_MIGRATOR_URL;
const runtimeUrl = process.env.LAB_RUNTIME_URL;

if (!migratorUrl || !runtimeUrl) {
  throw new Error("LAB_MIGRATOR_URL and LAB_RUNTIME_URL are required");
}

const migrator = new pg.Pool({ connectionString: migratorUrl, max: 1 });
const runtime = new pg.Pool({ connectionString: runtimeUrl, max: 1 });

try {
  const results: Record<string, boolean> = {};
  results["exact-ledger-identity-checksum"] = await exactLedger();
  results["no-argument-function-shape"] = await functionShape();
  results["owner-security-definer-stable-search-path"] =
    await functionSecurity();
  results["qualified-ledger-no-dynamic-sql"] = await functionBody();
  results["public-execute-denied"] = await publicExecuteDenied();
  results["runtime-execute-ready-only"] = await runtimeReadyOnly();
  results["runtime-old-probe-denied"] = await denied(
    runtime,
    "select public.markei_required_migration_present('006_hosted_authorization_r3')",
  );
  results["runtime-direct-ledger-denied"] = await denied(
    runtime,
    "select count(*) from public.migration_ledger",
  );
  results["runtime-ddl-role-admin-denied"] =
    (await denied(runtime, "create table runtime_probe_denied(id int)")) &&
    (await denied(runtime, "create role runtime_probe_denied"));
  const producer = makeProducerResult("migration-006-lifecycle-acl", results);
  process.stdout.write(
    `PROOF_PRODUCER migration-006-lifecycle-acl ${JSON.stringify(producer)}\n`,
  );
  process.stdout.write(
    `MIGRATION_006_LIFECYCLE_ACL=${producer.passed ? "true" : "partial"}\n`,
  );
  if (!producer.passed) process.exitCode = 1;
} finally {
  await runtime.end().catch(() => undefined);
  await migrator.end().catch(() => undefined);
}

async function exactLedger(): Promise<boolean> {
  const result = await migrator.query(
    `select checksum
       from public.migration_ledger
      where migration_id='006_hosted_authorization_r3'`,
  );
  return (
    result.rowCount === 1 &&
    result.rows[0].checksum === "c10-s03a-r3-hosted-authorization-v1"
  );
}

async function functionShape(): Promise<boolean> {
  const result = await migrator.query(
    `select p.pronargs
       from pg_proc p
       join pg_namespace n on n.oid=p.pronamespace
      where n.nspname='public'
        and p.proname='markei_hosted_runtime_ready'`,
  );
  return result.rowCount === 1 && Number(result.rows[0].pronargs) === 0;
}

async function functionSecurity(): Promise<boolean> {
  const result = await migrator.query(
    `select p.prosecdef, p.provolatile, p.proconfig
       from pg_proc p
       join pg_namespace n on n.oid=p.pronamespace
      where n.nspname='public'
        and p.proname='markei_hosted_runtime_ready'`,
  );
  if (result.rowCount !== 1) return false;
  const row = result.rows[0];
  return (
    row.prosecdef === true &&
    row.provolatile === "s" &&
    Array.isArray(row.proconfig) &&
    row.proconfig.includes("search_path=pg_catalog, public")
  );
}

async function functionBody(): Promise<boolean> {
  const result = await migrator.query(
    `select pg_get_functiondef(p.oid) as definition
       from pg_proc p
       join pg_namespace n on n.oid=p.pronamespace
      where n.nspname='public'
        and p.proname='markei_hosted_runtime_ready'`,
  );
  if (result.rowCount !== 1) return false;
  const definition = String(result.rows[0].definition);
  return (
    definition.includes("public.migration_ledger") &&
    !definition.toLowerCase().includes("execute ")
  );
}

async function publicExecuteDenied(): Promise<boolean> {
  const result = await migrator.query(
    `select has_function_privilege(
       'public',
       'public.markei_hosted_runtime_ready()',
       'execute'
     ) as allowed`,
  );
  return result.rowCount === 1 && result.rows[0].allowed === false;
}

async function runtimeReadyOnly(): Promise<boolean> {
  const ready = await runtime.query(
    "select public.markei_hosted_runtime_ready() as ready",
  );
  return ready.rowCount === 1 && ready.rows[0].ready === true;
}

async function denied(pool: pg.Pool, sql: string): Promise<boolean> {
  try {
    await pool.query(sql);
    return false;
  } catch {
    return true;
  }
}
