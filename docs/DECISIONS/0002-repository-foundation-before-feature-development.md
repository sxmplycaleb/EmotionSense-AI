# ADR-0002: Repository Foundation Before Feature Development

- Status: Accepted
- Date: 2026-08-04
- Owners: Architecture Review Board
- Decision scope: Roadmap sequencing and repository engineering foundation
- Related: [Roadmap](../ROADMAP.md), [Architecture](../ARCHITECTURE.md), [Milestone 0.1 Report](../MILESTONES/0.1-repository-governance.md)

## Context

The original roadmap placed Technical Discovery and Validation before the Flutter application and delivery foundation. That sequence protected the project from premature feature implementation, but it also deferred the repository structure, pinned toolchain, static analysis, dependency policy, and continuous validation needed to conduct later discovery work consistently.

Milestone 0.1 established documentation and governance. The Architecture Review Board subsequently approved promoting a bounded Repository Foundation milestone immediately after it. The promoted work includes the Flutter workspace, an application shell, empty Clean Architecture boundaries, development tooling, dependency declarations, and baseline GitHub Actions checks. It explicitly excludes product features, business logic, data persistence, capture, inference, models, and backend services.

## Decision Drivers

- Establish reproducible engineering controls before multiple workstreams begin.
- Detect formatting, analysis, dependency, and test failures from the first implementation commit.
- Give technical discovery a stable mobile workspace for future experiments without treating experiments as product features.
- Make repository layout and generated-code policy explicit before generated artifacts appear.
- Preserve the existing privacy, safety, responsible-AI, and architectural gates.

## Options Considered

### Option A: Retain the original sequence

Complete all technical discovery before creating the Flutter workspace or CI. This preserves the initial ordering but leaves discovery without a shared, validated repository foundation and increases later integration cost.

### Option B: Promote Repository Foundation

Create a minimal production-grade repository and Flutter shell immediately after Documentation & Governance, then continue with Technical Discovery and Validation. Strict milestone boundaries prevent feature or ML implementation.

### Option C: Combine foundation and feature delivery

Bootstrap the repository and begin product features together. This shortens the apparent schedule but weakens review boundaries and risks embedding unvalidated product or ML assumptions.

## Decision

Adopt Option B. Repository Foundation becomes the phase immediately following Documentation & Governance.

The promoted milestone may:

- Initialize the Flutter client under `apps/mobile` for Android and iOS.
- Establish Material 3, Riverpod, GoRouter, Freezed, build tooling, linting, editor settings, and baseline validation.
- Create empty feature-first Clean Architecture directories and repository-level work areas.
- Add CI that resolves dependencies, analyzes source, and runs tests.

The promoted milestone must not implement application features, domain behavior, camera or microphone access, emotion estimation, TensorFlow Lite, MediaPipe, Isar, authentication, backend services, synchronization, or analytics.

## Consequences

### Positive

- Every subsequent implementation and discovery change starts from consistent tooling and automated quality checks.
- Repository conventions and dependency boundaries become reviewable before feature pressure develops.
- Technical prototypes can be isolated from the production application and assessed against a stable baseline.
- Onboarding and local validation become reproducible earlier.

### Negative

- The team incurs repository and toolchain maintenance before model feasibility is established.
- Foundation dependencies may require upgrades before the first product feature is approved.
- A generated mobile shell may be mistaken for product progress unless milestone boundaries remain visible.

### Risks and Mitigations

- **Risk:** Foundation code grows into unreviewed product behavior. **Mitigation:** Permit only the application shell and empty architectural boundaries; review scope through CI and pull requests.
- **Risk:** Toolchain choices become accidental architecture decisions. **Mitigation:** Use only technologies already approved in project documentation and require ADRs for consequential additions or replacements.
- **Risk:** Generated files create noisy or irreproducible changes. **Mitigation:** Record generated-file policy, pin the application lockfile, and validate generation through the approved toolchain.
- **Risk:** Repository promotion is interpreted as skipping technical discovery. **Mitigation:** Keep Technical Discovery and Validation as the next phase with unchanged evidence and exit criteria.

## Validation

The decision is validated when:

- A clean checkout can resolve dependencies, pass static analysis, and pass tests.
- The default Flutter application shell builds on a supported local or CI platform.
- Repository documentation distinguishes foundation code from product features.
- No excluded application, ML, persistence, capture, analytics, authentication, or backend dependency is introduced.

## Rollout and Rollback

The roadmap and Milestone 0.1 handoff are updated before repository implementation begins. Milestone 0.2 then creates the bounded foundation.

If promotion causes material delivery or governance problems, a new ADR may supersede this decision and move remaining foundation work. Existing validated repository files may be retained when they remain useful and compliant; destructive rollback is not required by default.

## Follow-Up Actions

- [ ] Complete Milestone 0.2 and publish its validation evidence.
- [ ] Verify the Flutter/Dart toolchain and dependency versions used by CI.
- [ ] Complete Technical Discovery and Validation before feature or ML implementation.
- [ ] Create additional ADRs before implementation depends on open signal, storage, model, telemetry, or release decisions.
