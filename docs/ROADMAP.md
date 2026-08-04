# Roadmap

## 1. Purpose

This roadmap sequences the work needed to move EmotionSense AI from documentation foundation to a responsible production release. It is outcome-based; dates are assigned only after discovery reduces uncertainty and staffing is known.

## 2. Planning Principles

- Privacy, safety, accessibility, and model validity are release requirements.
- A phase exits only when its evidence and decision gates are complete.
- Product features do not begin until the engineering foundation and governing decisions are approved.
- Milestones may be narrowed, paused, or stopped if model evidence does not support responsible claims.
- The roadmap is updated when scope changes; historical releases are recorded in the changelog.

## 3. Phases

### Phase 0 — Documentation & Governance

**Outcome:** The team has an agreed product, architecture, contribution model, and decision process.

Deliverables:

- Product requirements, architecture, roadmap, coding standards, and contribution guide.
- ADR process and initial architectural assumptions.
- Repository governance, ownership, branch protection, and security reporting path.
- Initial risk register and definition of release evidence.

Exit criteria:

- Documentation is reviewed by product, engineering, ML, privacy, security, and accessibility owners.
- Open high-impact assumptions have named owners and decision deadlines.
- No application feature code is required for this phase.

### Phase 1 — Repository Foundation

**Outcome:** Contributors have a reproducible Flutter workspace and automated engineering baseline before feature or technical-discovery implementation begins.

Deliverables:

- Repository workspaces for the mobile client, shared packages, ML research, scripts, and future container tooling.
- Flutter application shell under `apps/mobile` targeting Android and iOS with Material 3 enabled.
- Approved foundation dependencies for Riverpod, GoRouter, Freezed, code generation, and linting.
- Feature-first Clean Architecture directories without product behavior or business logic.
- Pinned application dependencies, generated-file policy, static analysis, and VS Code settings.
- GitHub Actions checks for dependency resolution, static analysis, and tests.

Exit criteria:

- A clean checkout can resolve Flutter dependencies and pass analysis and tests.
- The default application shell builds for a supported local or CI target.
- No product feature, capture, inference, persistence, backend, authentication, or analytics implementation is present.
- Repository and milestone documentation reflects the implemented foundation and validation evidence.

This ordering is governed by [ADR-0002](DECISIONS/0002-repository-foundation-before-feature-development.md).

### Phase 2 — Technical discovery and validation

**Outcome:** Feasibility and risk are understood on representative mobile hardware.

Deliverables:

- Supported platform and device baseline proposal.
- Evaluation of candidate TensorFlow Lite models and MediaPipe pipelines.
- Benchmarks for latency, memory, thermal behavior, battery use, and application size.
- Data-flow diagram, privacy impact assessment, and threat model.
- Model evaluation plan, dataset governance, fairness slices, and model-card template.
- ADRs for signal scope, threading, persistence protection, model packaging, and telemetry.

Exit criteria:

- A product claim is supported by documented model evidence or removed from scope.
- Performance is viable on baseline devices.
- Privacy and security reviewers accept the intended data flows.
- Safety stop criteria and fallback behavior are agreed.

### Phase 3 — Application platform foundation

**Outcome:** A minimal, testable Flutter shell and delivery pipeline support feature work.

Deliverables:

- Flutter project bootstrap and environment configuration.
- Clean Architecture module boundaries and automated boundary checks where practical.
- Riverpod composition root and GoRouter navigation foundation.
- Isar initialization and migration harness.
- ML adapter contracts and controlled runtime test doubles.
- GitHub Actions for formatting, analysis, tests, security, and build verification.
- Logging redaction, accessibility baseline, and lifecycle policies.

Exit criteria:

- CI passes from a clean checkout.
- Reference tests demonstrate dependency direction and adapter replacement.
- No production secrets or personal data are present in source or artifacts.
- Foundation changes are covered by approved ADRs.

### Phase 4 — Private alpha

**Outcome:** Internal participants can complete the smallest end-to-end, consented reflection journey.

Scope candidates:

- Consent and permission lifecycle.
- Foreground capture with quality gating.
- On-device inference and uncertainty handling.
- Reflection confirmation or correction.
- Local persistence, history, and complete deletion.

Exit criteria:

- Critical journeys pass integration testing on the device matrix.
- Accessibility and localization smoke reviews pass.
- Model limitations are visible and understood in usability testing.
- Security, privacy, and ML risk findings have no unresolved release blockers.

### Phase 5 — Limited beta

**Outcome:** A controlled external cohort validates usefulness, reliability, and safety.

Deliverables:

- Consent-governed operational metrics with prohibited data excluded.
- Export capability if approved for release scope.
- Expanded device coverage, performance profiling, and migration testing.
- Support, incident response, model rollback, and data-deletion runbooks.
- Store disclosures, third-party notices, and beta feedback process.

Exit criteria:

- Reliability and performance targets are met.
- Beta evidence shows acceptable comprehension and no unsupported reliance on output.
- Required legal, privacy, security, accessibility, and model-governance approvals are complete.

### Phase 6 — Production readiness and launch

**Outcome:** EmotionSense AI can be released and operated responsibly.

Deliverables:

- Signed, reproducible mobile artifacts and release provenance.
- Store submission material and supported-market documentation.
- Monitored staged rollout with rollback thresholds.
- On-call ownership, incident classification, and communication plans.
- Final model cards, threat model, privacy documentation, and release checklist.

Exit criteria:

- All release acceptance criteria in the product requirements pass.
- Rollback and deletion procedures have been exercised.
- Production ownership is explicit for application, model, privacy, and security incidents.

### Phase 7 — Responsible iteration

**Outcome:** The product improves using evidence without silently expanding sensitive use.

Candidate work:

- Improve accessibility, localization, calibration, and supported-device coverage.
- Evaluate optional model or signal changes under new ADRs and governance review.
- Reduce battery, thermal, latency, and storage costs.
- Reassess data retention and user controls based on research.

Cloud synchronization, accounts, social features, remote inference, background capture, and high-impact use cases are not assumed roadmap items. Each requires separate product justification and architectural, privacy, security, and legal review.

## 4. Cross-Cutting Workstreams

| Workstream | Evidence maintained throughout |
| --- | --- |
| Product and safety | Requirements traceability, user research, limitations, and stop criteria |
| Mobile engineering | Architecture conformance, tests, performance, and release reproducibility |
| ML engineering | Model cards, provenance, evaluation, calibration, and rollback |
| Privacy and security | Data inventory, threat model, reviews, dependency risk, and incident readiness |
| Quality and accessibility | Device matrix, automated suites, manual audits, and defect thresholds |
| Delivery | GitHub Actions, protected environments, signed artifacts, and changelog |

## 5. Prioritization

Work is prioritized by user harm reduction, regulatory or security necessity, dependency unblocking, product value, and effort—in that order when risks are material. A user-visible enhancement must not displace unresolved safety or privacy work required for the same release.

## 6. Change Control

Roadmap changes are proposed through an issue or product review. Changes affecting system boundaries, sensitive data, model claims, platforms, or baseline technologies require an ADR. Completed release changes are recorded in [CHANGELOG.md](../CHANGELOG.md).
