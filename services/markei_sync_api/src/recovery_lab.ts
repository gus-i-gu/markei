import pg from "pg";
import {
  buildAndPublishSnapshot,
  cleanupCoveredEvents,
} from "./application/recovery_service.js";
import { systemClock } from "./application/retention_policy.js";

const connectionString = process.env.MARKEI_SYNC_DATABASE_URL;
const accountId = process.env.MARKEI_SYNC_LAB_ACCOUNT_ID;
const deviceId = process.env.MARKEI_SYNC_LAB_DEVICE_ID;
const action = process.argv[2];

if (!connectionString || !accountId || !deviceId) {
  throw new Error("recovery lab requires database, Account and Device claims");
}

const policy = {
  policyVersion: 1002,
  minimumEventRetentionMs: Number(
    process.env.MARKEI_SYNC_LAB_MIN_RETENTION_MS ?? 1000,
  ),
  recentContactMs: Number(
    process.env.MARKEI_SYNC_LAB_RECENT_CONTACT_MS ?? 60000,
  ),
  snapshotChunkMaxBytes: Number(process.env.MARKEI_SYNC_LAB_CHUNK_BYTES ?? 512),
  cleanupBatchMaxRows: Number(
    process.env.MARKEI_SYNC_LAB_CLEANUP_BATCH_ROWS ?? 100,
  ),
  recoverySessionLifetimeMs: Number(
    process.env.MARKEI_SYNC_LAB_RECOVERY_SESSION_MS ?? 600000,
  ),
  supportedSnapshotFormats: [1],
  supportedEventPayloadVersions: [3],
  compatibleSchemaVersion: 6,
};

const pool = new pg.Pool({ connectionString, max: 1 });
const auth = { accountId, deviceId };
const recovery = { policy, clock: systemClock };
const client = await pool.connect();

try {
  await client.query("begin isolation level serializable");
  await client.query("select set_config('markei.account_id', $1, true)", [
    accountId,
  ]);
  await client.query("select set_config('markei.device_id', $1, true)", [
    deviceId,
  ]);
  if (action === "snapshot") {
    const snapshotId =
      process.env.MARKEI_SYNC_LAB_SNAPSHOT_ID ??
      "33333333-3333-4333-8333-333333333333";
    const result = await buildAndPublishSnapshot(
      client,
      auth,
      snapshotId,
      recovery,
    );
    process.stdout.write(`${JSON.stringify(result)}\n`);
  } else if (action === "cleanup") {
    const cleanupRunId =
      process.env.MARKEI_SYNC_LAB_CLEANUP_RUN_ID ??
      "44444444-4444-4444-8444-444444444444";
    const result = await cleanupCoveredEvents(
      client,
      auth,
      cleanupRunId,
      recovery,
    );
    process.stdout.write(`${JSON.stringify(result)}\n`);
  } else {
    throw new Error("expected action snapshot or cleanup");
  }
  await client.query("commit");
} catch (error) {
  await client.query("rollback").catch(() => undefined);
  throw error;
} finally {
  client.release();
  await pool.end();
}
