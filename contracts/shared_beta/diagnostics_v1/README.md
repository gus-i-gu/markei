# Sync Diagnostics Registry v1

This directory owns the machine-readable diagnostic registry for shared beta Sync diagnostics. Edit `diagnostics.registry.json`, then run `node scripts/generate_sync_diagnostics.mjs` from the repository root to update Dart, TypeScript and Markdown projections.

The registry distinguishes detector component from proved cause domain. Boundary-adjacent services such as Auth0, Render, Neon and PostgreSQL must not be named as causes unless evidence proves the cause. Sensitive fields listed in each entry are forbidden in public UI and logs.
