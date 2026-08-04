# Feature Modules

Each approved feature owns its `domain/`, `data/`, and `presentation/` boundaries. The `_template/` directory preserves the expected empty structure and contains no implementation.

- `domain/` contains framework-independent entities, repository contracts, and use cases.
- `data/` contains data sources, external models, mappings, and repository implementations.
- `presentation/` contains Riverpod controllers, screens, and widgets.

Do not import another feature's internal data or presentation code. Promote genuinely shared, stable behavior through reviewed abstractions instead.
