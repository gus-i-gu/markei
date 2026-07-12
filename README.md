# Markei

Markei is an offline-first household memory and microeconomic observation system.

Its present foundation records products and purchases locally, helps a household understand what it owns and may need next, and preserves price history over time. Its longer direction is to turn ordinary household records into useful personal analytics: replenishment expectations, expenditure projections, product-level inflation and deflation, store comparison, and privacy-respecting optional participation in broader distribution research.

## Current state

Markei is under active development. The existing desktop beta established a local SQLite-backed workflow and Windows packaging. Cycle 07 is preparing the transition toward a mobile-capable Flutter implementation while preserving the project's documented methodology and offline-first boundaries.

The repository contains both application code and the Sketch Notebook: a permanent, role-separated development memory used to record operational evidence, design decisions, learning state, and cycle handoffs.

## Product direction

Markei begins with the household:

- reusable identities for products and stores;
- timestamped purchases and purchase items;
- historical prices and quantities;
- household inventory and replenishment projections;
- personalized views of price variation;
- local ownership of sensitive household data;
- optional, user-initiated contribution to aggregated research or partner services.

The project does not treat cloud participation or agency access as a prerequisite for ordinary use.

## Development status

The project is experimental and not yet a production service. Interfaces, storage models, synchronization rules, and packaging may change as the mobile architecture is validated.

For the canonical project state and development method, begin with:

- `AGENTS.md`
- `documentation/sketch_notebook/INDEX.md`
- `documentation/sketch_notebook/00_PROJECT_STATE.md`
- `documentation/sketch_notebook/06_SESSION_SCHEME.md`

## Contributing

Markei is currently guided through a documented cycle-and-sprint methodology. Contributions are welcome, but should remain bounded, evidence-backed, and consistent with the active branch and current cycle authority.

Read [`CONTRIBUTING.md`](CONTRIBUTING.md) before opening an issue or pull request.

## Support the project

Financial support, when available, helps cover development tools, testing infrastructure, distribution costs, and time dedicated to the project. See [`.github/FUNDING.yml`](.github/FUNDING.yml) and [`SUPPORT.md`](SUPPORT.md).

Sponsorship never grants access to private household data, influence over individual user records, or exemption from the project's privacy boundaries.

## Security and privacy

Please do not disclose security vulnerabilities through public issues. Follow [`SECURITY.md`](SECURITY.md).

Markei's intended privacy position is local-first: household records should remain under household control, and any external contribution should be explicit and minimized.

## License

No open-source license has been selected yet. Until a license is added, copyright remains with the repository owner and ordinary public-repository visibility does not grant reuse rights.
