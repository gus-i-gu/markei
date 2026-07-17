export const r04c04CaseIds = [
  "response-loss-query-replay",
  "process-restart-replay",
  "serialization-retry-exhaustion-fails-closed",
  "denied-no-state-advance",
] as const;

export const deniedNoStateAdvanceSourceCases = [
  "membership-disabled-before-fence",
  "membership-removed-before-fence",
  "external-identity-disabled-before-mutation",
  "actor-device-revoked-before-upload",
  "actor-device-revoked-before-download",
  "actor-device-revoked-before-acknowledgement",
  "actor-device-revoked-before-capabilities",
  "actor-device-revoked-before-rebootstrap-start",
  "actor-device-revoked-before-rebootstrap-status",
  "actor-device-revoked-before-rebootstrap-chunk",
  "actor-device-revoked-before-rebootstrap-complete",
  "actor-device-revoked-before-device-status",
  "actor-device-revoked-before-device-revoke",
  "foreign-target-denial",
  "cross-account-target-denial",
  "self-revoked-actor-denied-later",
  "serialization-retry-exhaustion-fails-closed",
] as const;
