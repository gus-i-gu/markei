import { createHash } from "node:crypto";

export type AuthContext = {
  accountId: string;
  deviceId: string;
};

export type ProtocolOutcome =
  | "applied"
  | "duplicate-equivalent"
  | "not-applied"
  | "unknown";

export type ProtocolFailure = {
  code: string;
  operation: string;
  field?: string;
  eventId?: string;
  submissionId?: string;
  outcome: ProtocolOutcome;
  retryable: boolean;
  safeAction: string;
  correlationId: string;
};

export function canonicalJson(value: unknown): string {
  return JSON.stringify(canonicalize(value));
}

export function canonicalHash(value: unknown): string {
  return createHash("sha256")
    .update(canonicalJson(value), "utf8")
    .digest("hex");
}

function canonicalize(value: unknown): unknown {
  if (Array.isArray(value)) {
    return value.map(canonicalize);
  }
  if (value && typeof value === "object") {
    return Object.fromEntries(
      Object.entries(value as Record<string, unknown>)
        .sort(([a], [b]) => (a < b ? -1 : a > b ? 1 : 0))
        .map(([key, item]) => [key, canonicalize(item)]),
    );
  }
  return value;
}
