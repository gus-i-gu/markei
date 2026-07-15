import { Buffer } from "node:buffer";
import { createHash } from "node:crypto";
import type { PoolClient } from "pg";
import {
  canonicalHash,
  canonicalJson,
  type AuthContext,
  type ProtocolFailure,
} from "../domain/protocol.js";
import { decodeCursor, encodeCursor } from "../domain/cursor.js";
import {
  classifyDevice,
  type Clock,
  type DeviceRetentionClass,
  type RetentionPolicy,
} from "./retention_policy.js";

export type RecoveryComposition = {
  policy: RetentionPolicy;
  clock: Clock;
};

export type RecoveryManifest = {
  accountId: string;
  snapshotId: string;
  formatVersion: 1;
  coveredThroughCursor: string;
  compatibleEventTypes: Array<{
    eventType: "purchase.registered";
    payloadVersion: 3;
  }>;
  compatibleSchemaVersion: 6;
  chunks: Array<{ index: number; length: number; hash: string }>;
  totalBytes: number;
  totalHash: string;
  factCounts: {
    accounts: number;
    stores: number;
    products: number;
    people: number;
    paymentMethods: number;
    purchases: number;
    purchaseItems: number;
  };
};

export type CapabilitiesResult = {
  status: "incremental-available" | "full-rebootstrap-required";
  recoveryFormatVersion: 1;
  eventPayloadVersion: 3;
  cursorToken: "c10b";
  highWaterCursor: string;
  earliestIncrementalCursor: string;
  snapshotId: string | null;
  retentionPolicyVersion: number;
  deviceClass: DeviceRetentionClass;
};

export type RebootstrapStartRequest = {
  recoverySessionId: string;
  requestHash: string;
  supportedSnapshotFormats: number[];
};

export type RebootstrapStartResult = {
  status: "full-rebootstrap-required";
  phase: "preparing" | "downloading";
  recoverySessionId: string;
  snapshotId: string;
  manifest: RecoveryManifest;
};

export type RebootstrapStatusResult = {
  phase:
    | "preparing"
    | "downloading"
    | "downloaded"
    | "applying"
    | "catching-up"
    | "recovery-completed"
    | "recovery-interrupted";
  recoverySessionId: string;
  snapshotId: string;
  manifest: RecoveryManifest;
  expiresAt: string;
};

export type RecoveryChunkResult = {
  recoverySessionId: string;
  snapshotId: string;
  index: number;
  length: number;
  hash: string;
  bytesBase64: string;
};

export async function verifyActiveDevice(
  client: PoolClient,
  auth: AuthContext,
  composition: RecoveryComposition,
): Promise<DeviceRetentionClass | ProtocolFailure> {
  const row = await client.query(
    `select status, last_seen_at, lease_expires_at
       from devices
      where account_id=$1 and device_id=$2`,
    [auth.accountId, auth.deviceId],
  );
  if (!row.rowCount) {
    return failure("device-revoked", "verify-device", false, "sync-api");
  }
  const device = row.rows[0];
  const deviceClass = classifyDevice(
    String(device.status),
    device.last_seen_at ? new Date(device.last_seen_at) : null,
    device.lease_expires_at ? new Date(device.lease_expires_at) : null,
    composition.policy,
    composition.clock,
  );
  if (deviceClass === "revoked") {
    return failure("device-revoked", "verify-device", false, "sync-api");
  }
  await client.query(
    "update devices set last_seen_at=$3 where account_id=$1 and device_id=$2",
    [auth.accountId, auth.deviceId, composition.clock.now()],
  );
  return deviceClass;
}

export async function getCapabilities(
  client: PoolClient,
  auth: AuthContext,
  composition: RecoveryComposition,
): Promise<CapabilitiesResult | ProtocolFailure> {
  const deviceClass = await verifyActiveDevice(client, auth, composition);
  if (typeof deviceClass !== "string") {
    return deviceClass;
  }
  const highWater = await currentHighWater(client, auth.accountId);
  const retention = await ensureRetentionState(client, auth, composition);
  const snapshot = await availableSnapshot(client, auth.accountId);
  return {
    status:
      snapshot && retention.earliestIncrementalCursor > 1
        ? "full-rebootstrap-required"
        : "incremental-available",
    recoveryFormatVersion: 1,
    eventPayloadVersion: 3,
    cursorToken: "c10b",
    highWaterCursor: encodeCursor(highWater),
    earliestIncrementalCursor: encodeCursor(
      retention.earliestIncrementalCursor,
    ),
    snapshotId: snapshot?.snapshotId ?? null,
    retentionPolicyVersion: composition.policy.policyVersion,
    deviceClass,
  };
}

export async function startRebootstrap(
  client: PoolClient,
  auth: AuthContext,
  request: RebootstrapStartRequest,
  composition: RecoveryComposition,
): Promise<RebootstrapStartResult | ProtocolFailure> {
  const deviceClass = await verifyActiveDevice(client, auth, composition);
  if (typeof deviceClass !== "string") {
    return deviceClass;
  }
  if (!request.supportedSnapshotFormats.includes(1)) {
    return failure("protocol-upgrade-required", "start-rebootstrap", false);
  }
  const snapshot = await availableSnapshot(client, auth.accountId);
  if (!snapshot) {
    return failure("recovery-unavailable", "start-rebootstrap", true);
  }
  const existing = await client.query(
    `select request_hash, stored_result
       from rebootstrap_sessions
      where account_id=$1 and device_id=$2 and recovery_session_id=$3`,
    [auth.accountId, auth.deviceId, request.recoverySessionId],
  );
  if (existing.rowCount) {
    const row = existing.rows[0];
    if (row.request_hash !== request.requestHash) {
      return failure("conflict", "start-rebootstrap", false);
    }
    return row.stored_result as RebootstrapStartResult;
  }
  const result: RebootstrapStartResult = {
    status: "full-rebootstrap-required",
    phase: "downloading",
    recoverySessionId: request.recoverySessionId,
    snapshotId: snapshot.snapshotId,
    manifest: snapshot.manifest,
  };
  await client.query(
    `insert into rebootstrap_sessions(
       account_id, device_id, recovery_session_id, snapshot_id, request_hash,
       state, expires_at, stored_result
     ) values($1,$2,$3,$4,$5,'downloading',$6,$7)`,
    [
      auth.accountId,
      auth.deviceId,
      request.recoverySessionId,
      snapshot.snapshotId,
      request.requestHash,
      new Date(
        composition.clock.now().getTime() +
          composition.policy.recoverySessionLifetimeMs,
      ),
      result,
    ],
  );
  return result;
}

export async function getRebootstrapStatus(
  client: PoolClient,
  auth: AuthContext,
  recoverySessionId: string,
  composition: RecoveryComposition,
): Promise<RebootstrapStatusResult | ProtocolFailure> {
  const deviceClass = await verifyActiveDevice(client, auth, composition);
  if (typeof deviceClass !== "string") {
    return deviceClass;
  }
  const row = await sessionWithSnapshot(client, auth, recoverySessionId);
  if (!row) {
    return failure("recovery-unavailable", "query-rebootstrap", true);
  }
  return {
    phase: row.state,
    recoverySessionId,
    snapshotId: row.snapshotId,
    manifest: row.manifest,
    expiresAt: new Date(row.expiresAt).toISOString(),
  };
}

export async function getRebootstrapChunk(
  client: PoolClient,
  auth: AuthContext,
  recoverySessionId: string,
  index: number,
  composition: RecoveryComposition,
): Promise<RecoveryChunkResult | ProtocolFailure> {
  const status = await getRebootstrapStatus(
    client,
    auth,
    recoverySessionId,
    composition,
  );
  if ("code" in status) {
    return status;
  }
  const descriptor = status.manifest.chunks[index];
  if (!descriptor || descriptor.index !== index) {
    return failure("conflict", "download-rebootstrap-chunk", false);
  }
  const row = await client.query(
    `select byte_length, content_hash, chunk_bytes
       from recovery_snapshot_chunks
      where account_id=$1 and snapshot_id=$2 and chunk_index=$3`,
    [auth.accountId, status.snapshotId, index],
  );
  if (!row.rowCount) {
    return failure("recovery-unavailable", "download-rebootstrap-chunk", true);
  }
  const chunk = row.rows[0];
  return {
    recoverySessionId,
    snapshotId: status.snapshotId,
    index,
    length: Number(chunk.byte_length),
    hash: String(chunk.content_hash),
    bytesBase64: Buffer.from(chunk.chunk_bytes as Buffer).toString("base64"),
  };
}

export async function completeRebootstrap(
  client: PoolClient,
  auth: AuthContext,
  body: {
    recoverySessionId: string;
    snapshotId: string;
    manifestHash: string;
    committedCatchUpCursor: string;
  },
  composition: RecoveryComposition,
): Promise<{ status: "recovery-completed" } | ProtocolFailure> {
  const deviceClass = await verifyActiveDevice(client, auth, composition);
  if (typeof deviceClass !== "string") {
    return deviceClass;
  }
  const session = await sessionWithSnapshot(
    client,
    auth,
    body.recoverySessionId,
  );
  if (!session || session.snapshotId !== body.snapshotId) {
    return failure("wrong-account", "complete-rebootstrap", false);
  }
  if (canonicalHash(session.manifest) !== body.manifestHash) {
    return failure("conflict", "complete-rebootstrap", false);
  }
  const committed = decodeCursor(body.committedCatchUpCursor);
  if (committed < decodeCursor(session.manifest.coveredThroughCursor)) {
    return failure("cursor-expired", "complete-rebootstrap", false);
  }
  await client.query(
    `update rebootstrap_sessions
        set state='recovery-completed',
            completed_cursor=$4,
            updated_at=$5
      where account_id=$1 and device_id=$2 and recovery_session_id=$3`,
    [
      auth.accountId,
      auth.deviceId,
      body.recoverySessionId,
      committed,
      composition.clock.now(),
    ],
  );
  return { status: "recovery-completed" };
}

export async function buildAndPublishSnapshot(
  client: PoolClient,
  auth: AuthContext,
  snapshotId: string,
  composition: RecoveryComposition,
): Promise<RecoveryManifest | ProtocolFailure> {
  await ensureRetentionState(client, auth, composition);
  const highWater = await currentHighWater(client, auth.accountId);
  if (highWater < 1) {
    return failure("recovery-unavailable", "build-snapshot", true);
  }
  const events = await client.query(
    `select server_cursor, payload
       from sync_events
      where account_id=$1 and server_cursor <= $2
      order by server_cursor asc`,
    [auth.accountId, highWater],
  );
  const facts = foldPurchaseFacts(auth.accountId, events.rows);
  const bytes = Buffer.from(canonicalJson(facts), "utf8");
  const chunks = chunkBytes(bytes, composition.policy.snapshotChunkMaxBytes);
  const manifest: RecoveryManifest = {
    accountId: auth.accountId,
    snapshotId,
    formatVersion: 1,
    coveredThroughCursor: encodeCursor(highWater),
    compatibleEventTypes: [
      { eventType: "purchase.registered", payloadVersion: 3 },
    ],
    compatibleSchemaVersion: 6,
    chunks: chunks.map((chunk, index) => ({
      index,
      length: chunk.byteLength,
      hash: hashBytes(chunk),
    })),
    totalBytes: bytes.byteLength,
    totalHash: hashBytes(bytes),
    factCounts: {
      accounts: 1,
      stores: facts.stores.length,
      products: facts.products.length,
      people: facts.people.length,
      paymentMethods: facts.paymentMethods.length,
      purchases: facts.purchases.length,
      purchaseItems: facts.purchaseItems.length,
    },
  };
  await client.query(
    `insert into recovery_snapshots(
       account_id, snapshot_id, state, covered_through_cursor,
       captured_high_water_cursor, recovery_format_version,
       compatible_event_version, compatible_schema_version, chunk_count,
       total_bytes, manifest_hash, total_hash, fact_counts, built_at,
       validated_at, published_at
     ) values($1,$2,'available',$3,$3,1,3,6,$4,$5,$6,$7,$8,$9,$9,$9)
     on conflict(account_id, snapshot_id) do nothing`,
    [
      auth.accountId,
      snapshotId,
      highWater,
      manifest.chunks.length,
      manifest.totalBytes,
      canonicalHash(manifest),
      manifest.totalHash,
      manifest.factCounts,
      composition.clock.now(),
    ],
  );
  for (const [index, chunk] of chunks.entries()) {
    await client.query(
      `insert into recovery_snapshot_chunks(
         account_id, snapshot_id, chunk_index, byte_length, content_hash, chunk_bytes
       ) values($1,$2,$3,$4,$5,$6)
       on conflict(account_id, snapshot_id, chunk_index) do nothing`,
      [
        auth.accountId,
        snapshotId,
        index,
        chunk.byteLength,
        hashBytes(chunk),
        chunk,
      ],
    );
  }
  await client.query(
    `update account_retention_state
        set current_snapshot_id=$2, updated_at=$3
      where account_id=$1`,
    [auth.accountId, snapshotId, composition.clock.now()],
  );
  return manifest;
}

export async function cleanupCoveredEvents(
  client: PoolClient,
  auth: AuthContext,
  cleanupRunId: string,
  composition: RecoveryComposition,
): Promise<{
  status: "committed";
  deletedCount: number;
  throughCursor: string;
}> {
  const retention = await ensureRetentionState(client, auth, composition);
  const snapshot = await availableSnapshot(client, auth.accountId);
  const snapshotFloor = snapshot
    ? decodeCursor(snapshot.manifest.coveredThroughCursor)
    : 0;
  const ageRows = await client.query(
    `select coalesce(max(server_cursor), 0) as floor
       from sync_events
      where account_id=$1 and received_at < $2`,
    [
      auth.accountId,
      new Date(
        composition.clock.now().getTime() -
          composition.policy.minimumEventRetentionMs,
      ),
    ],
  );
  const ackRows = await client.query(
    `select d.device_id, d.status, d.last_seen_at, d.lease_expires_at,
            coalesce(a.greatest_contiguous_cursor, 0) as ack_cursor
       from devices d
       left join device_acknowledgements a
         on a.account_id=d.account_id and a.device_id=d.device_id
      where d.account_id=$1`,
    [auth.accountId],
  );
  const eligible = ackRows.rows.filter((row) => {
    const deviceClass = classifyDevice(
      String(row.status),
      row.last_seen_at ? new Date(row.last_seen_at) : null,
      row.lease_expires_at ? new Date(row.lease_expires_at) : null,
      composition.policy,
      composition.clock,
    );
    return (
      deviceClass === "eligible-active" || deviceClass === "eligible-dormant"
    );
  });
  const ackFloor =
    eligible.length === 0
      ? Number.MAX_SAFE_INTEGER
      : Math.min(...eligible.map((row) => Number(row.ack_cursor)));
  const floor = Math.min(
    Number(ageRows.rows[0].floor),
    ackFloor,
    snapshotFloor,
  );
  const through = Math.max(retention.earliestIncrementalCursor - 1, floor);
  if (through < retention.earliestIncrementalCursor) {
    return {
      status: "committed",
      deletedCount: 0,
      throughCursor: encodeCursor(retention.earliestIncrementalCursor),
    };
  }
  const deleted = await client.query(
    `delete from sync_events
      where account_id=$1
        and server_cursor >= $2
        and server_cursor <= $3
        and server_cursor in (
          select server_cursor from sync_events
           where account_id=$1
             and server_cursor >= $2
             and server_cursor <= $3
           order by server_cursor asc
           limit $4
        )`,
    [
      auth.accountId,
      retention.earliestIncrementalCursor,
      through,
      composition.policy.cleanupBatchMaxRows,
    ],
  );
  const nextEarliest = through + 1;
  await client.query(
    `update account_retention_state
        set earliest_incremental_cursor=$2, updated_at=$3
      where account_id=$1`,
    [auth.accountId, nextEarliest, composition.clock.now()],
  );
  await client.query(
    `insert into cleanup_runs(
       account_id, cleanup_run_id, policy_version, snapshot_id,
       proposed_through_cursor, committed_through_cursor, state, attempts,
       deleted_count, finished_at
     ) values($1,$2,$3,$4,$5,$5,'committed',1,$6,$7)
     on conflict(account_id, cleanup_run_id) do nothing`,
    [
      auth.accountId,
      cleanupRunId,
      composition.policy.policyVersion,
      snapshot?.snapshotId ?? null,
      through,
      deleted.rowCount ?? 0,
      composition.clock.now(),
    ],
  );
  return {
    status: "committed",
    deletedCount: deleted.rowCount ?? 0,
    throughCursor: encodeCursor(through),
  };
}

async function ensureRetentionState(
  client: PoolClient,
  auth: AuthContext,
  composition: RecoveryComposition,
): Promise<{ earliestIncrementalCursor: number }> {
  const existing = await client.query(
    "select earliest_incremental_cursor from account_retention_state where account_id=$1 for update",
    [auth.accountId],
  );
  if (existing.rowCount) {
    return {
      earliestIncrementalCursor: Number(
        existing.rows[0].earliest_incremental_cursor,
      ),
    };
  }
  await client.query(
    `insert into account_retention_state(
       account_id, earliest_incremental_cursor, policy_version,
       recovery_format_version, updated_at
     ) values($1,1,$2,1,$3)`,
    [auth.accountId, composition.policy.policyVersion, composition.clock.now()],
  );
  return { earliestIncrementalCursor: 1 };
}

async function currentHighWater(
  client: PoolClient,
  accountId: string,
): Promise<number> {
  const row = await client.query(
    "select coalesce(next_cursor - 1, 0) as high_water from account_cursor_state where account_id=$1",
    [accountId],
  );
  return row.rowCount ? Number(row.rows[0].high_water) : 0;
}

async function availableSnapshot(client: PoolClient, accountId: string) {
  const row = await client.query(
    `select s.snapshot_id, s.covered_through_cursor, s.compatible_schema_version,
            s.chunk_count, s.total_bytes, s.total_hash, s.fact_counts,
            s.manifest_hash
       from recovery_snapshots s
      where s.account_id=$1 and s.state='available'
      order by s.covered_through_cursor desc
      limit 1`,
    [accountId],
  );
  if (!row.rowCount) {
    return null;
  }
  const snapshot = row.rows[0];
  const chunks = await client.query(
    `select chunk_index, byte_length, content_hash
       from recovery_snapshot_chunks
      where account_id=$1 and snapshot_id=$2
      order by chunk_index asc`,
    [accountId, snapshot.snapshot_id],
  );
  const manifest: RecoveryManifest = {
    accountId,
    snapshotId: String(snapshot.snapshot_id),
    formatVersion: 1,
    coveredThroughCursor: encodeCursor(Number(snapshot.covered_through_cursor)),
    compatibleEventTypes: [
      { eventType: "purchase.registered", payloadVersion: 3 },
    ],
    compatibleSchemaVersion: 6,
    chunks: chunks.rows.map((chunk) => ({
      index: Number(chunk.chunk_index),
      length: Number(chunk.byte_length),
      hash: String(chunk.content_hash),
    })),
    totalBytes: Number(snapshot.total_bytes),
    totalHash: String(snapshot.total_hash),
    factCounts: snapshot.fact_counts as RecoveryManifest["factCounts"],
  };
  return { snapshotId: String(snapshot.snapshot_id), manifest };
}

async function sessionWithSnapshot(
  client: PoolClient,
  auth: AuthContext,
  recoverySessionId: string,
) {
  const row = await client.query(
    `select r.state, r.snapshot_id, r.expires_at
       from rebootstrap_sessions r
      where r.account_id=$1 and r.device_id=$2 and r.recovery_session_id=$3`,
    [auth.accountId, auth.deviceId, recoverySessionId],
  );
  if (!row.rowCount) {
    return null;
  }
  const snapshot = await availableSnapshot(client, auth.accountId);
  if (!snapshot || snapshot.snapshotId !== String(row.rows[0].snapshot_id)) {
    return null;
  }
  return {
    state: row.rows[0].state as RebootstrapStatusResult["phase"],
    snapshotId: String(row.rows[0].snapshot_id),
    expiresAt: row.rows[0].expires_at as Date,
    manifest: snapshot.manifest,
  };
}

function foldPurchaseFacts(
  accountId: string,
  rows: Array<Record<string, unknown>>,
) {
  const products = new Map<string, Record<string, unknown>>();
  const stores = new Map<string, Record<string, unknown>>();
  const purchases = new Map<string, Record<string, unknown>>();
  const purchaseItems = new Map<string, Record<string, unknown>>();
  for (const row of rows) {
    const payload = row.payload as {
      purchase?: Record<string, unknown>;
      productSnapshots?: Array<Record<string, unknown>>;
    };
    const purchase = payload.purchase;
    if (!purchase) continue;
    const store = purchase.store as Record<string, unknown> | undefined;
    if (store?.id) stores.set(String(store.id), store);
    for (const product of payload.productSnapshots ?? []) {
      if (product.id) products.set(String(product.id), product);
    }
    purchases.set(String(purchase.id), purchase);
    for (const item of (purchase.items as
      | Array<Record<string, unknown>>
      | undefined) ?? []) {
      purchaseItems.set(String(item.id), item);
    }
  }
  return {
    account: { id: accountId, defaultCurrencyCode: "BRL" },
    stores: [...stores.values()].sort(byId),
    products: [...products.values()].sort(byId),
    people: [] as Record<string, unknown>[],
    paymentMethods: [] as Record<string, unknown>[],
    purchases: [...purchases.values()].sort(byId),
    purchaseItems: [...purchaseItems.values()].sort(byId),
  };
}

function byId(a: Record<string, unknown>, b: Record<string, unknown>) {
  return String(a.id).localeCompare(String(b.id));
}

function chunkBytes(bytes: Buffer, maxBytes: number): Buffer[] {
  const chunks: Buffer[] = [];
  for (let offset = 0; offset < bytes.byteLength; offset += maxBytes) {
    chunks.push(bytes.subarray(offset, offset + maxBytes));
  }
  return chunks.length ? chunks : [Buffer.from("{}", "utf8")];
}

function hashBytes(bytes: Buffer): string {
  return createHash("sha256").update(bytes).digest("hex");
}

function failure(
  code: string,
  operation: string,
  retryable: boolean,
  correlationId = "sync-api",
): ProtocolFailure {
  return {
    code,
    operation,
    outcome: "not-applied",
    retryable,
    safeAction: retryable
      ? "retry the same identity"
      : "stop and preserve evidence",
    correlationId,
  };
}
