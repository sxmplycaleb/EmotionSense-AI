# Coding Standards

## 1. Scope

These standards apply when Flutter implementation begins. They cover Dart source, tests, generated assets, database schemas, model integration, automation, and supporting documentation.

## 2. Guiding Rules

- Optimize for clarity, correctness, privacy, and testability before brevity.
- Keep dependencies pointing toward the domain.
- Make invalid and uncertain states explicit.
- Prefer small, cohesive changes with evidence proportional to risk.
- Do not place sensitive data in source control, logs, analytics, fixtures, screenshots, or crash reports.

## 3. Dart and Flutter Style

- Follow Effective Dart and the repository's committed analyzer configuration.
- Format all Dart code with the pinned Dart SDK formatter; do not hand-align formatting.
- Use sound null safety and avoid force-unwrapping unless an invariant is locally proven.
- Prefer immutable values, `final` fields, and `const` constructors where meaningful.
- Use explicit types at public boundaries; local inference is acceptable when obvious.
- Keep methods focused. Extract behavior when a method mixes policy, I/O, and presentation.
- Avoid dynamic invocation, unchecked casts, global mutable state, and catch-all exception swallowing.
- Public APIs and non-obvious policy require concise documentation comments explaining why and constraints.
- TODO comments must include an issue reference and must not conceal release-critical work.

## 4. Naming

| Element | Convention | Example |
| --- | --- | --- |
| Files and directories | `lower_snake_case` | `emotion_record_repository.dart` |
| Types and extensions | `UpperCamelCase` | `EmotionRecord` |
| Variables, functions, providers | `lowerCamelCase` | `loadHistory` |
| Constants | `lowerCamelCase` | `maximumRetryCount` |
| Private members | Leading underscore | `_mapFailure` |
| Tests | Behavior-focused sentence | `returns unavailable when input quality is low` |

Names should describe domain meaning. Avoid framework suffixes in domain types and vague containers such as `Manager`, `Helper`, `Utils`, or `Common` unless the responsibility is genuinely precise.

## 5. Architecture Boundaries

- Domain code imports only Dart libraries and approved domain packages.
- Presentation code invokes use cases and reads immutable view state; it does not open Isar, cameras, interpreters, or MediaPipe graphs.
- Data adapters map external models and exceptions at the boundary.
- Isar collection types must not escape the data layer.
- TensorFlow Lite tensors and MediaPipe result types must not escape ML adapters.
- Feature internals are private to the feature unless promoted through a reviewed shared abstraction.
- Business rules do not live in widgets, route redirects, provider constructors, or database models.

Dependency exceptions require an ADR or an explicitly documented architecture review.

## 6. Riverpod Standards

- Use Riverpod for dependency injection and reactive presentation state.
- Expose domain interfaces rather than concrete adapters whenever replacement or testing is relevant.
- Keep provider declarations close to the composition boundary or owning feature.
- Model asynchronous UI state explicitly, including loading, empty, success, unavailable, and failure states.
- Use provider overrides for tests; do not add test-only branches to production implementations.
- Avoid side effects during provider construction, widget builds, and derived-provider evaluation.
- Document intentionally retained providers and dispose native resources deterministically.

## 7. GoRouter Standards

- Centralize route names and paths.
- Use typed or validated route parameters; reject malformed external input.
- Keep redirects deterministic and side-effect free.
- Do not pass sensitive records in URLs, query parameters, or route names.
- Test consent, permission, restoration, deep-link, and back-stack behavior.
- Avoid navigation calls from domain and data layers.

## 8. Persistence Standards

- Separate domain entities, transfer models, and Isar collection schemas.
- Define stable collection identifiers and indexes intentionally.
- Treat schema changes as migrations, never as incidental model edits.
- Test migration from every supported persisted version with sanitized fixtures.
- Use transactions for multi-record invariants.
- Bound queries and paginate growing collections.
- Repository methods must define ordering, absence, conflict, and failure behavior.
- Verify complete deletion of derived data and caches.

## 9. ML and Media Standards

- Version model files, preprocessing contracts, labels, thresholds, and checksums together.
- Keep preprocessing identical between evaluation and application pipelines.
- Validate tensor shape, type, normalization, and output mapping before inference results enter domain logic.
- Use bounded queues and discard stale capture samples.
- Never reuse a result across users, sessions, or incompatible model versions.
- Represent insufficient quality or confidence as an unavailable outcome, not a guessed label.
- Benchmark on physical baseline devices and test resource cleanup across app lifecycle changes.
- Do not commit models or datasets unless licensing, provenance, size strategy, and security review are complete.

## 10. Error Handling and Logging

- Translate plugin, database, and runtime exceptions into typed application failures.
- Catch only when adding context, translating, recovering, or releasing resources.
- Preserve useful diagnostic cause information without exposing sensitive content.
- Use structured logging with an explicit field allowlist.
- Never log source media, free-text reflections, inferred histories, access tokens, keys, exact file paths containing user identifiers, or stable device identifiers.
- Avoid printing directly to standard output in committed application code.

## 11. Testing Standards

- Follow Arrange–Act–Assert or Given–When–Then consistently within a test file.
- Test behavior at the lowest meaningful layer.
- Use fakes for domain contracts and controlled adapters; mock interaction details only when they are the behavior under test.
- Keep tests deterministic: control clocks, randomness, concurrency, platform state, and model inputs.
- Every defect fix includes a regression test when technically feasible.
- Golden tests must state their accessibility and platform limitations and be reviewed intentionally.
- Integration tests cover consent, permission revocation, lifecycle interruption, data deletion, and ML-unavailable paths.
- Test fixtures must be synthetic, licensed, consented, and stripped of sensitive metadata.

Coverage reports guide review but do not replace assertions about important behavior.

## 12. Concurrency and Performance

- Keep blocking I/O and heavy computation off the UI isolate.
- Make ownership and disposal of streams, subscriptions, isolates, controllers, interpreters, and native handles explicit.
- Use cancellation or latest-result semantics for superseded work.
- Avoid unbounded streams, buffers, retries, and parallel inference.
- Measure before optimizing, then record relevant benchmarks in the pull request.

## 13. Dependencies and Generated Code

- Add a dependency only with a documented need, maintenance and license review, platform compatibility, and security assessment.
- Pin toolchains and commit lockfiles according to Flutter application conventions.
- Prefer maintained packages with clear ownership and minimal transitive risk.
- Generated files must be reproducible. The repository will explicitly define which generated outputs are committed.
- Never manually edit generated code.
- Dependency upgrades require passing the full applicable validation suite.

## 14. Git and Documentation

- Use Conventional Commits as defined in [Contributing](CONTRIBUTING.md).
- Keep commits focused and buildable where practical.
- Update documentation when behavior, interfaces, assumptions, or operational procedures change.
- Create an ADR for consequential or hard-to-reverse decisions.
- Add user-visible changes to the Unreleased section of the changelog.

## 15. Required Local Checks

Once the Flutter toolchain exists, the baseline checks are expected to include:

```text
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Additional integration, model, migration, security, documentation, and performance checks apply according to the changed risk surface. Exact commands will be committed with the project bootstrap and mirrored in GitHub Actions.

## 16. Review Checklist

Reviewers verify that a change:

- Meets stated acceptance criteria and does not silently expand scope.
- Respects layer and feature boundaries.
- Handles consent, lifecycle, unavailable states, and deletion where relevant.
- Does not expose sensitive information.
- Includes appropriate automated tests and documentation.
- Uses accessible presentation semantics when UI is involved.
- Accounts for performance and native-resource cleanup when capture or ML is involved.
- Records architectural consequences in an ADR when necessary.
