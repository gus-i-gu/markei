# Shared beta v3 sync contracts

This directory defines the disposable C10-S01 protocol for one event type:
`purchase.registered` payload version 3.

Canonical JSON is UTF-8 encoded JSON after recursively sorting object keys.
String values are used for decimal quantities and money uses integer minor units.
The content hash is lowercase SHA-256 hex over canonical event content excluding
the `contentHash` field itself.

These contracts are local proof assets only. They are not production auth,
backup, export or Neon configuration.
