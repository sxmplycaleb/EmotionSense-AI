# Phase 1 Engineering Review

**Milestone:** 1.5 — Engineering Decision Review and Phase 1 Approval  
**Date:** 2026-08-04  
**Decision:** Approved to begin implementation; not approved for production release

## Review Method

This review consolidates Milestones 1.0–1.4 and the Phase 1 ADRs. It does not replace their evidence, conduct new research, or claim measured implementation results.

## Milestone 1.0 — Technical Discovery

### Objectives

Define FER terminology, survey viable on-device pipelines, identify failure modes and performance variables, and establish the difference between observed expression and internal emotion.

### Major Findings

- Mobile FER is a multi-stage camera pipeline; detection, conversion, alignment, scheduling, and lifecycle can dominate a small classifier.
- Lightweight CNNs have the strongest mature mobile deployment evidence; full/hybrid transformers remain comparative candidates.
- Raw frames should be transient, work must be bounded, and results require calibration and abstention.
- Facial appearance does not establish internal emotion, intent, deception, personality, or health.

### Decisions Made

- Limit claims to visible facial-expression estimates.
- Prefer lightweight, on-device CNN candidates and measure end-to-end behavior on physical devices.
- Treat offline operation, uncertainty, latest-frame processing, and safe unavailable states as first-class requirements.

### Risks Identified

Construct overclaim, dataset bias, domain shift, preprocessing drift, false confidence, device fragmentation, thermal/battery load, and sensitive camera leakage.

### Remaining Uncertainties

Exact crop/input contract, production artifact, final cadence, baseline device performance, and post-optimization calibration.

### Approval Status

**Approved.** The technical problem and claim boundary are sufficiently defined for implementation experiments. See [ADR-0004](../DECISIONS/ADR-0004-FER-Claim-Boundary.md).

## Milestone 1.1 — Dataset Validation

### Objectives

Compare required FER datasets, assess licenses/provenance, define research and production roles, and establish reproducible governance.

### Major Findings

- No reviewed public dataset meets production rights, smartphone realism, annotation, representation, and fairness needs simultaneously.
- AffectNet and RAF-DB are useful non-commercial research sources; FER+ adds ambiguity evidence but inherits unresolved source-image rights.
- Public benchmark performance cannot substitute for a locked, consented target-domain smartphone holdout.

### Decisions Made

- Adopt source-aware, license-gated research using cleared AffectNet and RAF-DB roles.
- Exclude unverified sources from model lineage.
- Require a consented/commercially usable smartphone corpus for production training and release validation.
- Require immutable versions, checksums, split manifests, cards, lineage, retention, deletion, and license records.

### Risks Identified

Unclear rights, consent/provenance defects, identity leakage, ontology mismatch, source shortcuts, inadequate demographic evidence, and irreproducibility.

### Remaining Uncertainties

Production corpus acquisition, launch population, storage/custodian roles, distribution rights for derived weights, and minimum slice sizes.

### Approval Status

**Approved for governed research and implementation; production data unresolved.** This is a release dependency, not a blocker to writing the platform and evaluation harness. See [ADR-0005](../DECISIONS/ADR-0005-Dataset-Governance.md).

## Milestone 1.2 — Model Validation

### Objectives

Compare mobile architectures, select candidate order, and define quality, calibration, resource, battery, thermal, and compatibility budgets.

### Major Findings

- MobileNetV3-Small is the best primary architecture candidate for the intended efficiency envelope.
- EfficientNet-Lite0 is a credible fallback; MobileNetV2 is a useful control.
- No trained weights or exact LiteRT artifact have yet passed EmotionSense target-domain and device gates.
- Quantization and delegates can change quality and must be tested as part of the exact artifact.

### Decisions Made

- Approve MobileNetV3-Small primary, EfficientNet-Lite0 fallback, and MobileNetV2 baseline.
- Require CPU compatibility, one semantic model across tiers, versioned preprocessing/calibration, a model card, lawful lineage, and measurable minimum gates.
- Choose no model if no candidate passes.

### Risks Identified

Candidate underperformance, calibration loss, quantization regression, unsupported operators, delegate divergence, weakest-class failure, and asset provenance.

### Remaining Uncertainties

Exact input resolution, precision, trained weights, fitted thresholds, artifact API, and measured performance.

### Approval Status

**Conditionally approved architecture strategy.** Candidate integration may begin; production selection completes only when an exact artifact passes. See [ADR-0006](../DECISIONS/ADR-0006-Production-Model-Selection.md).

## Milestone 1.3 — Mobile Architecture

### Objectives

Define camera ownership, detector/classifier separation, runtime abstraction, Flutter/native boundary, threading, backpressure, delegates, lifecycle, and support strategy.

### Major Findings

- Keeping frames native avoids repeated copies and narrows the sensitive-data boundary.
- CameraX latest-only analysis plus one serial native worker prevents stale backlog.
- MediaPipe Face Detector supplies sufficient Version 1 candidate geometry; dense landmarks require measured justification.
- CPU is the reliable reference/fallback; acceleration must be tuple-allowlisted.

### Decisions Made

- Native session-scoped pipeline behind a typed Flutter domain port.
- Android-first CameraX + MediaPipe Face Detector + LiteRT adapter architecture.
- Queue depth one, 5–10 Hz target, no pixel work on the UI isolate, and no raw pixels crossing into Flutter domain state.
- CPU mandatory, GPU optional by allowlist, NNAPI excluded from new production use.
- Proposed Android baseline: API 24, arm64, 3 GB RAM, front camera; confirm during implementation. iOS remains architecture-compatible but release-deferred.

### Risks Identified

Platform adapter complexity, dependency support-floor mismatch, camera lifecycle errors, buffer leaks, delegate/thread-affinity defects, device fragmentation, and iOS divergence.

### Remaining Uncertainties

Final LiteRT API, detector versus landmarker value, physical device matrix, validated allowlist, exact support floor, and iOS adapter.

### Approval Status

**Approved for Android-first implementation.** See [ADR-0007](../DECISIONS/ADR-0007-Mobile-Inference-Architecture.md).

## Milestone 1.4 — Privacy and Ethics

### Objectives

Define data handling, consent, claims, prohibited uses, fairness, transparency, accessibility, confidence, incident behavior, and privacy regression controls.

### Major Findings

- Local inference reduces transfer risk but secondary paths—logs, SDKs, backups, crash reports, and lifecycle residue—still require controls.
- Abstention, unequal coverage, user comprehension, and accessibility are quality/safety outcomes.
- High-stakes, coercive, surveillance, deception, medical, or hidden-trait use is unacceptable regardless of accuracy claims.

### Decisions Made

- Local-only, offline, foreground, single-face, transient processing with no accounts, analytics, advertising, production telemetry, cloud fallback, biometric storage, or inference history.
- Explicit consent, camera-active state, one-action stop, user-facing limitations, and typed unavailable states.
- Mandatory privacy regression checklist for every release.

### Risks Identified

Overtrust, coercive/bystander use, subgroup harm, accessibility exclusion, dependency exfiltration, camera persistence/transmission, misleading claims, and weak incident ownership.

### Remaining Uncertainties

Launch population/markets, participatory accessibility evidence, final notice comprehension, support-data policy, platform backup behavior, and named stop-ship owners.

### Approval Status

**Approved as a binding baseline.** See [ADR-0008](../DECISIONS/ADR-0008-Confidence-Abstention.md), [ADR-0009](../DECISIONS/ADR-0009-Local-Only-Inference.md), and [ADR-0010](../DECISIONS/ADR-0010-Privacy-Regression-Checklist.md).

## Overall Engineering Assessment

The decisions are coherent and implementation-ready. The architecture isolates sensitive native processing, keeps product semantics independent of runtimes, fixes a defensible claim boundary, provides an ordered model strategy, and converts quality/privacy obligations into measurable gates.

Implementation can begin because no unresolved item changes the initial interface or trust boundary. Production release cannot proceed until lawful production data, an exact trained/calibrated artifact, target-domain fairness evidence, physical-device results, accessibility/security/privacy reviews, and the supported platform matrix pass the gates.

## Evidence Classification

- **Facts:** previous milestone evidence supports the selected candidates and identifies material scientific, rights, mobile, and privacy constraints.
- **Assumptions:** the proposed Android floor and performance minima are feasible but not yet measured.
- **Trade-offs:** Android-first, CPU-first, one-face, and abstention-first reduce breadth/coverage to improve reliability and governance.
- **Constraints:** Phase 1 produced documentation only; it did not authorize production weights or release.
- **Open Questions:** all unresolved items are assigned in [Open Decisions](OPEN_DECISIONS.md).

