# ADR-0003: Feature Flags and Progressive Feature Enablement

- Status: Accepted
- Date: 2026-08-04
- Owners: Architecture Review Board
- Decision scope: Introduction and rollout of future user-facing functionality
- Related: [Product Requirements](../PRODUCT_REQUIREMENTS.md), [Architecture](../ARCHITECTURE.md), [Roadmap](../ROADMAP.md)

## Context

EmotionSense AI will introduce sensitive, resource-intensive capabilities across multiple milestones. Camera processing, on-device inference, local history, and later platform changes may vary by device support, evidence maturity, and review status. A failed or unsupported capability must not force an all-or-nothing release or silently broaden data processing.

The foundation release contains no product features and requires no runtime flag system. The project nevertheless needs an early principle for controlled enablement before user-facing functionality is implemented.

## Decision Drivers

- Protect users while capabilities progress through privacy, security, accessibility, and responsible-AI review.
- Separate deployment from enablement when doing so reduces rollout or rollback risk.
- Support device, operating-system, model, and market constraints without divergent application architectures.
- Preserve deterministic offline behavior and avoid hidden remote dependencies.
- Keep disabled functionality out of active capture, processing, storage, and navigation paths.

## Options Considered

### Option A: Release every capability unconditionally

This is operationally simple but couples deployment to enablement and increases rollback scope when evidence or device behavior is incomplete.

### Option B: Adopt feature flags whenever practical

Capabilities with meaningful rollout, safety, compatibility, or operational risk can be introduced in a disabled state and enabled progressively after their gates pass. Simple, low-risk changes need not be flagged.

### Option C: Maintain separate application variants for each capability

Variants provide isolation but multiply build, testing, signing, support, and migration obligations. They are not justified by the current product scope.

## Decision

Adopt Option B. New user-facing functionality should be introduced behind feature flags whenever practical.

A flag must have a documented owner, default state, evaluation source, affected data paths, test matrix, rollout criteria, rollback behavior, and removal condition. Disabled features must not request permissions, start capture or inference, create storage, register sensitive telemetry, or expose unreachable routes.

Version 1 may not require feature flags for every capability. A flag is warranted when it materially improves staged validation, device compatibility, safety, privacy, or rollback. This principle does not authorize a remote configuration service; the initial implementation may use build-time or local configuration. Any remote control plane requires a separate ADR and updated threat model.

## Consequences

### Positive

- Risky capabilities can be validated and enabled progressively.
- Rollback can disable a capability without requiring an immediate binary replacement when the approved flag mechanism permits it.
- Unsupported devices and incomplete evidence can fail closed.
- Tests can explicitly cover enabled and disabled states.

### Negative

- Flags add state combinations, test cost, ownership, and cleanup work.
- Long-lived flags can obscure the product surface and create dead code.
- Remote flags, if later approved, would introduce availability, integrity, privacy, and audit concerns.

### Risks and Mitigations

- **Risk:** A disabled capability still processes data. **Mitigation:** Gate entry points before permissions, routing, adapters, and side effects; test the disabled path.
- **Risk:** Flags become permanent architecture. **Mitigation:** Require an expiry or removal criterion and review stale flags each release.
- **Risk:** Flag state changes product scope silently. **Mitigation:** Treat flags as delivery controls only; requirements and approvals still govern what may be enabled.
- **Risk:** Excess combinations reduce confidence. **Mitigation:** Use flags selectively and define supported combinations explicitly.

## Validation

Before a flagged capability is enabled, validation must demonstrate:

- Disabled-state tests prove that prohibited entry points and side effects remain inactive.
- Enabled-state tests satisfy the capability's requirements and release gates.
- Rollback behavior is tested and does not corrupt or orphan user data.
- Documentation identifies the owner, supported configurations, and removal plan.

## Rollout and Rollback

No flag framework is added by this ADR. The first milestone requiring a flag must propose the smallest mechanism compatible with offline-first operation and record any consequential infrastructure decision.

A feature is enabled only after its governing reviews pass. Rollback returns the flag to its safe state and follows documented data-compatibility rules. Flag removal occurs after rollout is stable and rollback no longer depends on it.

## Follow-Up Actions

- [ ] Define a flag inventory and ownership format before the first flagged feature.
- [ ] Select a local or build-time mechanism when a concrete capability requires it.
- [ ] Add enabled, disabled, migration, and rollback cases to the applicable test plan.
- [ ] Review and remove stale flags as part of each release checklist.
