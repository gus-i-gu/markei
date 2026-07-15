# Markei Shared Beta Recovery Format 1

Recovery format 1 is independent of the `purchase.registered` event payload
version. C10-S02 keeps event payload version 3 and cursor tokens in the existing
`c10b:<integer>` form.

The recovery manifest is canonical recursively sorted UTF-8 JSON. Hashes are
SHA-256 over the exact canonical bytes. Snapshot chunks contain canonical fact
bytes and never contain credentials, Device rows, queues, acknowledgements,
recovery sessions, UI state or provider backup material.
