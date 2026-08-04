# ADR-0010: Privacy Regression Checklist

- Date: 2026-08-04
- Owners: Privacy and Release leads
- Decision scope: Every build proposed for internal, beta, or production release

## Status

Accepted — Mandatory Release Gate

## Context

Privacy commitments can regress through diagnostics, dependencies, platform defaults, refactoring, build variants, or feature expansion even when the primary inference design remains local.

## Decision

Every future release must complete this checklist. A failed, unanswered, or unevidenced item blocks release unless a superseding ADR explicitly changes the baseline after privacy, security, product, and legal approval.

### Mandatory checklist

- [ ] No new analytics, advertising, attribution, crash-reporting, remote-configuration, networking, or telemetry SDK has been added without explicit ADR and privacy/security approval.
- [ ] No camera frame, thumbnail, crop, landmark, tensor, embedding, score, label, temporal result, or reconstructable derivative is written to persistent storage.
- [ ] No image-derived or inference data appears in logs, traces, metrics, breadcrumbs, memory dumps, crash reports, test artifacts, screenshots, clipboard, notifications, support bundles, or backups.
- [ ] No camera, inference, or session data is automatically uploaded, shared, exported, synchronized, or used for training.
- [ ] Core capture, inference, notices, controls, and safe failure operate in airplane mode with no cloud fallback.
- [ ] Network inspection of the complete release binary shows no undocumented traffic attributable to the application or bundled SDKs during the core workflow.
- [ ] New and updated dependencies have documented owners and have been reviewed for permissions, network access, telemetry, data collection, native logging, supply-chain risk, and transitive behavior.
- [ ] Camera activation remains explicit, foreground-only, visible, single-face, interruptible, and impossible before consent and permission.
- [ ] Stop, background, permission revocation, interruption, crash, and error paths clear transient frames, buffers, results, and temporal state.
- [ ] Release builds exclude sensitive debug capture, fixture generation from real users, verbose logs, and development endpoints.
- [ ] Model and detector assets have approved lineage, integrity metadata, and contain no example faces or personal metadata.
- [ ] Privacy policy, store disclosures, onboarding, permission rationale, help, and release notes match the measured data flow and were updated for every material change.
- [ ] Data-flow diagram, threat model, and inventory remain accurate.
- [ ] Regression tests confirm continued compliance with [ADR-0009](ADR-0009-Local-Only-Inference.md).
- [ ] Privacy and Security owners have signed the evidence package and recorded exceptions, owners, expiry dates, and remediation.

Evidence must include automated test results where possible, manual lifecycle and network checks on Android and each supported platform, dependency diffs, and reviewer/date records. The completed checklist is stored with release evidence.

## Alternatives Considered

- **Policy-only review:** rejected because it lacks repeatable evidence.
- **Privacy review only for major releases:** rejected because dependency and build changes can regress any version.
- **Checklist without blocking authority:** rejected because it would not preserve the local-only commitment.

## Consequences

- Releases incur repeatable privacy verification work.
- Dependency and diagnostic additions require earlier scrutiny.
- Release evidence becomes auditable and privacy regressions become stop-ship events.
- Legitimate data-flow expansion remains possible only through explicit governance.

## Evidence Classification

- **Facts:** sensitive data can escape through secondary paths even when inference is local.
- **Assumptions:** release tooling can automate some but not all checks.
- **Trade-offs:** additional release effort is accepted to prevent silent data-flow expansion.
- **Constraints:** this checklist is mandatory for every future release.
- **Open Questions:** exact automated scanners and platform-specific backup/memory tests will be selected during implementation.

## References

- [ADR-0009](ADR-0009-Local-Only-Inference.md)
- [Data Handling Policy](../research/DATA_HANDLING_POLICY.md)
- [Risk Assessment](../research/RISK_ASSESSMENT.md)
- [Release Gates](../research/RELEASE_GATES.md)
