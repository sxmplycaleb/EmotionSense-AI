# ADR-0009: Local-Only Inference

- Date: 2026-08-04
- Owners: Privacy, Security, Product, and Architecture leads
- Decision scope: Production camera and inference data flow

## Status

Accepted

## Context

Facial imagery and image-derived data are sensitive. “On-device inference” is insufficient if frames, results, diagnostics, dependencies, or update mechanisms create an off-device or persistent path.

## Decision

Version 1 core analysis is local-only and fully functional offline.

- No cloud inference, cloud fallback, image upload, remote model execution, account, or network dependency is permitted.
- Camera frames, face crops, landmarks, tensors, scores, labels, and temporal state are transient memory only; they are never persisted or transmitted.
- No face embeddings, biometric templates, identity records, expression history, or inferred-trait profiles are created.
- No production camera or inference data is reused for training, calibration, evaluation, analytics, diagnostics, crash reporting, advertising, or support.
- Core model and detector assets are bundled and integrity checked. Store delivery is not an inference data flow.
- The baseline includes no analytics, advertising, remote configuration, or third-party crash SDK.
- Capture is explicit, foreground-only, single-person, time-bounded, visibly active, and stopped on user action, backgrounding, permission loss, interruption, or failure.
- Release testing must verify airplane-mode operation, absence of prohibited network traffic, sensitive logs, backups, files, and lifecycle residue.

Any proposal to save, export, share, sync, personalize, collect samples, report diagnostics, add communicating SDKs, or perform remote updates changes the data flow and requires a new ADR, privacy/security review, notices, consent design, retention/deletion rules, and store-disclosure review.

## Alternatives Considered

- **Cloud inference or fallback:** rejected because it violates offline and minimization goals.
- **Optional uploads for improvement:** rejected from the baseline; it would create a separate research/data product.
- **Local history of inferred results:** rejected from the inference baseline because it creates a sensitive profile.
- **Automatic crash/analytics SDK:** rejected because it expands transmission and disclosure risk.

## Consequences

- Privacy exposure and infrastructure dependence are reduced.
- Field diagnostics and model-improvement signals are limited; use controlled studies, device labs, synthetic fixtures, and voluntary text reports.
- Bundling runtimes and assets increases application size.
- The product cannot offer cloud sync, cross-device history, or remote inference without renewed approval.

## Evidence Classification

- **Facts:** local processing reduces transfer risk but does not itself prevent logs, persistence, coercion, or dependency telemetry.
- **Assumptions:** Version 1 user value does not require accounts, saved inference history, or production telemetry.
- **Trade-offs:** operational visibility and convenience are reduced to preserve the simplest defensible data boundary.
- **Constraints:** camera-derived data is transient, non-persistent, and non-transmitted.
- **Open Questions:** final platform backup controls and handling of voluntarily supplied support data require implementation review.

## References

- [Data Handling Policy](../research/DATA_HANDLING_POLICY.md)
- [Privacy and Ethics](../research/PRIVACY_AND_ETHICS.md)
- [Risk Assessment](../research/RISK_ASSESSMENT.md)
- [User Transparency](../research/USER_TRANSPARENCY.md)
