# Markei Shared Beta Fixtures v1

These JSON fixtures define language-neutral expectations for the first shared
Flutter/Dart client foundation. They are semantic contract data, not UI copy.

Scope:

- catalogue identity normalization;
- purchase aggregate shape and rollback expectations;
- `purchase.registered` synchronization event envelope.

Non-goals:

- authentication;
- cloud synchronization;
- legacy Cycle 06 database migration;
- localized presentation strings.
