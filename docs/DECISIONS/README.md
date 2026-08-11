# Architecture Decision Records

## Purpose

Architecture Decision Records (ADRs) preserve the context, alternatives, and consequences of consequential technical and product-engineering decisions. They help future contributors understand why a choice was made without relying on commit history or institutional memory.

## Decision Index

| ADR | Status | Decision |
| --- | --- | --- |
| [ADR-0002](0002-repository-foundation-before-feature-development.md) | Accepted | Repository Foundation Before Feature Development |
| [ADR-0003](0003-feature-flags-and-progressive-feature-enablement.md) | Accepted | Feature Flags and Progressive Feature Enablement |
| [ADR-0004](ADR-0004-FER-Claim-Boundary.md) | Accepted | FER Claim Boundary |
| [ADR-0005](ADR-0005-Dataset-Governance.md) | Accepted | Dataset Governance |
| [ADR-0006](ADR-0006-Production-Model-Selection.md) | Accepted | Production Model Selection |
| [ADR-0007](ADR-0007-Mobile-Inference-Architecture.md) | Accepted | Mobile Inference Architecture |
| [ADR-0008](ADR-0008-Confidence-Abstention.md) | Accepted | Confidence and Abstention |
| [ADR-0009](ADR-0009-Local-Only-Inference.md) | Accepted | Local-Only Inference |
| [ADR-0010](ADR-0010-Privacy-Regression-Checklist.md) | Accepted | Privacy Regression Checklist |
| [ADR-0011](ADR-0011-Implementation-Baseline.md) | Accepted | Implementation Baseline |
| [ADR-0012](ADR-0012-User-Authored-Reflection-Records.md) | Accepted | User-Authored Reflection Records |
| [ADR-0013](ADR-0013-Camera-Capture-Foundation.md) | Accepted | Camera Capture Foundation |

## When an ADR Is Required

Write an ADR when a decision:

- Is difficult or costly to reverse.
- Changes Clean Architecture boundaries or dependency direction.
- Adds or replaces a foundational framework, platform, database, ML runtime, or service.
- Changes sensitive data collection, processing, retention, export, synchronization, or deletion.
- Changes model inputs, claims, thresholds, packaging, delivery, or governance.
- Establishes encryption, key management, authentication, telemetry, signing, or release strategy.
- Introduces a cross-feature convention or meaningful operational obligation.

An ADR is not required for routine implementation within already accepted boundaries.

## File Naming

Use a four-digit sequence and short kebab-case title:

```text
0001-use-clean-architecture.md
0002-select-supported-device-baseline.md
```

Numbers are never reused. If a pull request reserves a number but does not merge, the number may remain unused.

## Status Lifecycle

- **Proposed:** Open for review; implementation must not depend on it yet.
- **Accepted:** Approved and governing implementation.
- **Rejected:** Considered but not selected.
- **Superseded:** Replaced by a later ADR that links back to it.
- **Deprecated:** Previously accepted but no longer recommended; migration may still be underway.

Accepted ADR text is immutable except for typographical corrections and link repairs. Changes in direction require a new ADR that supersedes the old one.

## Review Process

1. Confirm that the decision is needed and assign the next sequence number.
2. Draft the ADR as `Proposed` before implementation.
3. Link the motivating issue, evidence, prototypes, threat model, or benchmarks.
4. Request reviewers appropriate to the impact: engineering, product, ML, privacy, security, accessibility, operations, or legal.
5. Resolve material objections or record unresolved tradeoffs accurately.
6. Change status to `Accepted` or `Rejected` in the approving pull request.
7. Link implementation pull requests and update affected documentation.

## ADR Template

```markdown
# ADR-NNNN: Decision title

- Status: Proposed
- Date: YYYY-MM-DD
- Owners: Team or role
- Decision scope: Short scope
- Related: Issue, requirement, or earlier ADR links

## Context

Describe the problem, constraints, evidence, and forces that make a decision necessary.

## Decision Drivers

- Driver one
- Driver two

## Options Considered

### Option A: Name

Describe the option, benefits, costs, and risks.

### Option B: Name

Describe the option, benefits, costs, and risks.

## Decision

State the selected option and its boundaries precisely.

## Consequences

### Positive

- Consequence

### Negative

- Consequence

### Risks and Mitigations

- Risk and mitigation

## Validation

Describe tests, benchmarks, reviews, metrics, or expiry criteria that verify the decision.

## Rollout and Rollback

Describe adoption, migration, compatibility, and reversal steps.

## Follow-Up Actions

- [ ] Action with owner or issue
```

## Initial ADR Backlog

The following first-draft assumptions should be confirmed before their implementation phase:

1. Adopt Flutter with Clean Architecture and feature-oriented modules.
2. Use Riverpod for state management and dependency composition.
3. Use GoRouter for declarative navigation.
4. Define supported signal modalities and model-claim boundaries.
5. Define TensorFlow Lite and MediaPipe runtime responsibilities and threading.
6. Use Isar and select local encryption and key-management strategy.
7. Define model packaging, integrity, versioning, and update strategy.
8. Select supported devices and OS versions with performance budgets.
9. Define telemetry, consent, and redaction policy.
10. Define mobile signing, distribution, provenance, and rollback.

The technology assumptions above are documented in [Architecture](../ARCHITECTURE.md). An ADR may affirm, narrow, or supersede an assumption after evidence-based review.
