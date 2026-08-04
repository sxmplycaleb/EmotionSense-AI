# Architecture

## 1. Purpose

This document defines the initial technical architecture for EmotionSense AI. It establishes boundaries and quality constraints without prescribing application features or prematurely fixing open decisions.

## 2. Architecture Drivers

- Sensitive emotion-related data should remain on the user's device by default.
- Machine-learning implementations and models will evolve independently of product rules.
- Mobile resource limits require explicit control of isolates, memory, heat, battery, and lifecycle.
- Domain rules must remain testable without Flutter plugins or platform services.
- Privacy, safety, accessibility, and explainability are product behavior, not optional integrations.
- Builds and quality checks must be reproducible through GitHub Actions.

## 3. Context and Trust Boundaries

The initial system is a local-first Flutter application. The user and mobile operating system are external actors. Device camera and microphone APIs, packaged model assets, and local storage cross explicit trust boundaries.

```text
User
  |
  v
Flutter presentation
  |
  v
Domain use cases and policies
  |
  +-----------> Capture and permission adapters ----------> Mobile OS
  |
  +-----------> ML inference adapters --------------------> TFLite / MediaPipe
  |
  +-----------> Repository adapters ----------------------> Isar / secure platform storage
```

No production backend, account system, or cloud inference service is assumed for the first release. Adding one changes the threat model and requires an ADR, privacy review, and updated product requirements.

## 4. Architectural Style

EmotionSense AI uses Clean Architecture with feature-oriented modules. Dependency direction always points inward:

```text
Presentation  --->  Domain  <---  Data
     |                ^             |
Flutter,              |         Isar, plugins,
Riverpod,         abstract ports    TFLite, MediaPipe
GoRouter
```

### Domain layer

Contains entities, value objects, repository contracts, service ports, use cases, and domain failures. It must not import Flutter, Riverpod, GoRouter, Isar, TensorFlow Lite, MediaPipe, or platform plugins.

### Data layer

Implements domain contracts. It owns persistence mappings, Isar schemas, platform adapters, ML runtime adapters, data-source coordination, and translation of external failures into domain failures.

### Presentation layer

Contains screens, reusable presentation components, route definitions, controllers/notifiers, and immutable view state. It invokes use cases rather than data sources or ML runtimes directly.

### Application composition

A thin composition root wires implementations to domain contracts through Riverpod providers. Environment-specific configuration belongs here, not in domain logic.

## 5. Proposed Source Organization

Source directories will be created when implementation begins. The intended shape is:

```text
lib/
├── app/
│   ├── bootstrap/
│   ├── routing/
│   └── theme/
├── core/
│   ├── errors/
│   ├── privacy/
│   ├── telemetry/
│   └── utilities/
├── features/
│   └── <feature>/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── use_cases/
│       ├── data/
│       │   ├── data_sources/
│       │   ├── models/
│       │   └── repositories/
│       └── presentation/
│           ├── controllers/
│           ├── screens/
│           └── widgets/
└── main.dart
```

Shared code enters `core/` only when it is genuinely cross-cutting and stable. Feature-to-feature imports should go through domain-level interfaces or intentionally extracted shared modules, never through another feature's internal data or presentation folders.

## 6. State Management and Dependency Injection

Riverpod is the single default mechanism for dependency composition and reactive presentation state.

- Providers expose use cases and interface-bound services.
- Notifiers coordinate presentation events and immutable view state.
- Domain entities do not depend on providers.
- Provider overrides supply test doubles and environment configuration.
- Long-lived global mutable state is prohibited.
- Auto-disposal is preferred for screen-scoped state; retained state requires a documented lifecycle reason.
- Side effects belong in explicit commands or use cases, not provider initialization or widget build methods.

Code generation may be adopted for Riverpod and immutable models only after toolchain and generated-file policies are recorded.

## 7. Navigation

GoRouter provides declarative navigation.

- Route names and paths are centralized in the application routing module.
- Guards read explicit session, consent, permission, or onboarding state through stable abstractions.
- Redirects must be deterministic and free of business side effects.
- Features expose navigation intents or typed parameters without importing unrelated screens.
- Deep-link inputs are validated before entering domain workflows.
- Sensitive content must consider app-switcher previews, restoration, and back-stack behavior.

The initial local-first release assumes no authenticated routes.

## 8. Machine-Learning Pipeline

### Responsibilities

MediaPipe may perform validated frame/audio preprocessing, landmark extraction, or task pipelines. TensorFlow Lite performs model inference. Neither runtime may be referenced from the domain layer.

```text
Permission check
  -> capture frame/sample
  -> quality gate
  -> MediaPipe preprocessing or landmarks
  -> normalized model input
  -> TensorFlow Lite inference
  -> calibration and confidence policy
  -> domain result or unavailable outcome
  -> discard transient source data
```

### Runtime constraints

- Perform compute-heavy work outside the UI isolate when supported by plugin and platform constraints.
- Bound input queues; do not allow stale frames or samples to accumulate.
- Close cameras, streams, interpreters, and native resources deterministically.
- Stop inference when consent is absent, permissions are revoked, or lifecycle policy disallows capture.
- Treat unsupported input, poor quality, and confidence below threshold as normal unavailable outcomes.
- Do not turn model scores directly into user-facing claims.

### Model governance

Every releasable model must have:

- A stable identifier, semantic model version, checksum, and compatible input contract.
- Provenance, license, training/evaluation summary, intended use, and excluded use.
- Accuracy, calibration, robustness, fairness, latency, memory, thermal, and package-size evidence.
- A documented preprocessing contract shared by evaluation and application code.
- Release approval, rollback instructions, and compatibility tests.

Bundled model replacement is a release change. Remote model delivery is not assumed and requires signature verification, compatibility controls, rollback, and a separate ADR.

## 9. Persistence

Isar is the default structured local database behind repository interfaces.

- Domain entities and Isar collection models remain separate.
- Schema versions and migrations are explicit, forward-tested, and covered by fixtures.
- Writes that must remain consistent use transactions.
- Queries and indexes follow product access patterns and are performance-tested with realistic volumes.
- Raw camera frames and audio are not persisted by default.
- Secrets and cryptographic key material do not belong in Isar.
- Sensitive preferences or keys use appropriate platform-secure facilities behind an abstraction.
- Deletion covers records, indexes, caches, derived artifacts, and temporary files under application control.

The exact encryption approach is open. Platform sandbox protection is not assumed to be sufficient without a documented threat-model decision.

## 10. Error Model

External exceptions are translated at architectural boundaries. Domain and presentation code operate on a small, explicit failure vocabulary, including permission denied, unsupported device, input quality insufficient, inference unavailable, persistence failure, invalid data, and unexpected failure.

- Expected failure is represented as typed outcomes rather than uncaught exceptions.
- User-facing messages must be actionable and avoid leaking implementation details.
- Unexpected failures are captured through redacted diagnostics.
- Retry is allowed only for idempotent operations or with an explicit consistency strategy.

## 11. Privacy and Security Architecture

- Collect only the input required for an active user-requested workflow.
- Keep raw media transient unless a separately reviewed requirement explicitly permits retention.
- Redact logs and telemetry at their creation point.
- Exclude sensitive content from crash reports, analytics, backups where configurable, and test artifacts.
- Validate all data crossing plugin, deep-link, import, or export boundaries.
- Pin dependency and action versions according to supply-chain policy.
- Generate a software bill of materials and conduct dependency/license scanning before production release.
- Threat-model permission misuse, local compromise, exported data, model tampering, screenshots, backups, and debug builds.

No architecture can guarantee privacy on a compromised device. User communication and supported threat boundaries must remain accurate.

## 12. Observability

Observability is designed around operational health, not user surveillance.

- Define an allowlist of structured event names and non-sensitive fields.
- Prefer coarse performance and reliability measures over content-level events.
- Use correlation identifiers that are session-scoped and not stable across reinstallations unless justified.
- Keep diagnostic logging disabled or minimized in release builds.
- Provide opt-in or opt-out behavior according to applicable law and approved product policy.

The telemetry vendor and consent model are open decisions.

## 13. Testing Strategy

| Layer | Primary tests | Dependencies |
| --- | --- | --- |
| Domain | Unit and property tests | Pure Dart; fakes only |
| Data | Repository, mapping, migration, and adapter tests | Temporary Isar and controlled runtime doubles |
| Presentation | Notifier and widget tests | Provider overrides and fake use cases |
| Integration | Critical user journeys and lifecycle behavior | Real application with controlled test assets |
| ML | Golden tensors, preprocessing parity, quality gates, and device benchmarks | Versioned approved models |
| Release | Smoke, accessibility, security, and performance checks | Physical-device matrix where required |

Tests should follow the same trust boundaries as production. Real personal media must never be committed as fixtures.

## 14. Continuous Integration and Delivery

GitHub Actions is the automation platform. Planned workflows include:

- Pull-request validation: dependency resolution, formatting verification, static analysis, unit tests, widget tests, documentation link checks, and secret scanning.
- Main-branch validation: integration tests, coverage reporting, dependency review, and reproducible artifact checks.
- Release candidate: signed builds using protected environments, model checksum verification, software bill of materials, and provenance generation.
- Scheduled maintenance: dependency audit and stale-toolchain detection.

Workflows use least-privilege permissions, pinned third-party actions, protected secrets, concurrency cancellation for superseded runs, and immutable release artifacts. Signing and store publishing require a separate release ADR and approval process.

## 15. Quality Gates

A change cannot merge when required formatting, analysis, tests, security checks, documentation checks, or review approvals fail. Coverage is interpreted as risk evidence, not a target to game. New domain behavior requires tests; architectural boundary violations should be checked automatically when practical.

## 16. Architectural Assumptions and Open Decisions

### Accepted working assumptions

- One Flutter codebase targets Android and iOS.
- The first release has no required account, backend, synchronization, or cloud inference.
- Core workflows work offline.
- Riverpod, GoRouter, TensorFlow Lite, MediaPipe, Isar, and GitHub Actions are approved baseline technologies.
- Sensitive input is user-initiated and foreground-only.
- Raw media is transient by default.

### Decisions still required

- Supported OS versions and physical-device baseline.
- Exact signal modalities and approved model families.
- Isolate/native threading design for each runtime.
- Database encryption and key management.
- Telemetry provider and consent policy.
- Model packaging and update strategy.
- Export format and secure destination handling.
- Build flavors, signing, distribution, and rollback.

Open items become ADRs before implementation depends on them.

## 17. Related Documents

- [Product Requirements](PRODUCT_REQUIREMENTS.md)
- [Roadmap](ROADMAP.md)
- [Coding Standards](CODING_STANDARDS.md)
- [Architecture Decision Records](DECISIONS/README.md)
