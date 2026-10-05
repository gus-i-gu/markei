import assert from "node:assert/strict";
import test from "node:test";
import { validListNoteEvent } from "../src/application/sync_service.js";
import {
  foldPurchaseFacts,
  getCapabilities,
  startRebootstrap,
  type RecoveryComposition,
} from "../src/application/recovery_service.js";
import type { PoolClient } from "pg";

function event() {
  return {
    eventId: "note-1",
    payloadVersion: 1,
    payload: {
      listNote: {
        id: "note-1",
        productId: "product-1",
        note: "Café",
        tags: ["@Alex", "#Card"],
        replaces: [],
      },
      productSnapshots: [{ id: "product-1", accountId: "account-1" }],
    },
  };
}
test("list note validation rejects mismatched identities, wrong Account and unsafe sizes", () => {
  assert.equal(validListNoteEvent(event(), "account-1"), true);
  assert.equal(validListNoteEvent(event(), "another-account"), false);
  const bad = event();
  bad.payload.listNote.tags = ["x".repeat(65)];
  assert.equal(validListNoteEvent(bad, "account-1"), false);
  const self = event();
  self.payload.listNote.replaces = ["note-1"] as never[];
  assert.equal(validListNoteEvent(self, "account-1"), false);
  assert.equal(
    validListNoteEvent({ ...event(), eventId: "different" }, "account-1"),
    false,
  );
});
test("recovery preserves note revisions and product snapshots even without purchases", () => {
  const first = event();
  const second = event();
  second.payload.listNote.id = "note-2";
  second.payload.listNote.replaces = ["note-1"] as never[];
  const facts = foldPurchaseFacts("account-1", [
    { payload: first.payload },
    { payload: second.payload },
  ]);
  assert.equal(facts.products.length, 1);
  assert.equal(facts.purchases.length, 0);
  assert.equal(facts.listNotes.length, 2);
  assert.deepEqual(facts.listNotes[1].replaces, ["note-1"]);
});

test("note-bearing recovery reports format 2 and refuses an older client safely", async () => {
  const now = new Date("2026-10-05T12:00:00Z");
  const composition: RecoveryComposition = {
    clock: { now: () => now },
    policy: {
      policyVersion: 1,
      minimumEventRetentionMs: 1,
      recentContactMs: 60000,
      snapshotChunkMaxBytes: 1024,
      cleanupBatchMaxRows: 50,
      recoverySessionLifetimeMs: 60000,
      supportedSnapshotFormats: [1, 2],
      supportedEventPayloadVersions: [1, 3],
      compatibleSchemaVersion: 13,
    },
  };
  const auth = { accountId: "account-1", deviceId: "device-1" };
  const client = {
    query: async (sql: string) => {
      if (sql.includes("select status, last_seen_at"))
        return {
          rowCount: 1,
          rows: [
            {
              status: "active",
              last_seen_at: now,
              lease_expires_at: new Date(now.getTime() + 60000),
            },
          ],
        };
      if (sql.includes("as high_water"))
        return { rowCount: 1, rows: [{ high_water: 2 }] };
      if (sql.includes("select earliest_incremental_cursor"))
        return { rowCount: 1, rows: [{ earliest_incremental_cursor: 2 }] };
      if (sql.includes("from recovery_snapshots s"))
        return {
          rowCount: 1,
          rows: [
            {
              snapshot_id: "snapshot-1",
              covered_through_cursor: 2,
              compatible_schema_version: 13,
              recovery_format_version: 2,
              total_bytes: 10,
              total_hash: "a".repeat(64),
              fact_counts: { listNotes: 2 },
            },
          ],
        };
      if (sql.includes("from recovery_snapshot_chunks"))
        return {
          rowCount: 1,
          rows: [
            { chunk_index: 0, byte_length: 10, content_hash: "a".repeat(64) },
          ],
        };
      return { rowCount: 0, rows: [] };
    },
  } as unknown as PoolClient;
  const capabilities = await getCapabilities(client, auth, composition);
  assert.ok("recoveryFormatVersion" in capabilities);
  assert.equal(capabilities.recoveryFormatVersion, 2);
  const old = await startRebootstrap(
    client,
    auth,
    {
      recoverySessionId: "session-1",
      requestHash: "b".repeat(64),
      supportedSnapshotFormats: [1],
    },
    composition,
  );
  assert.ok("code" in old);
  assert.equal(old.code, "protocol-upgrade-required");
  const current = await startRebootstrap(
    client,
    auth,
    {
      recoverySessionId: "session-2",
      requestHash: "c".repeat(64),
      supportedSnapshotFormats: [1, 2],
    },
    composition,
  );
  assert.ok("manifest" in current);
  assert.equal(current.manifest.compatibleSchemaVersion, 13);
  assert.ok(
    current.manifest.compatibleEventTypes.some(
      (t) => t.eventType === "product.list-note.recorded",
    ),
  );
});
