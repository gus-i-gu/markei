export type Clock = {
  now(): Date;
};

export type RetentionPolicy = {
  policyVersion: number;
  minimumEventRetentionMs: number;
  recentContactMs: number;
  snapshotChunkMaxBytes: number;
  cleanupBatchMaxRows: number;
  recoverySessionLifetimeMs: number;
  supportedSnapshotFormats: readonly number[];
  supportedEventPayloadVersions: readonly number[];
  compatibleSchemaVersion: number;
};

export type DeviceRetentionClass =
  | "eligible-active"
  | "eligible-dormant"
  | "expired"
  | "revoked";

export function classifyDevice(
  status: string,
  lastSeenAt: Date | null,
  leaseExpiresAt: Date | null,
  policy: RetentionPolicy,
  clock: Clock,
): DeviceRetentionClass {
  if (status === "revoked") {
    return "revoked";
  }
  const now = clock.now().getTime();
  if (!leaseExpiresAt || now >= leaseExpiresAt.getTime()) {
    return "expired";
  }
  if (!lastSeenAt) {
    return "eligible-dormant";
  }
  return now - lastSeenAt.getTime() < policy.recentContactMs
    ? "eligible-active"
    : "eligible-dormant";
}

export const systemClock: Clock = {
  now: () => new Date(),
};
