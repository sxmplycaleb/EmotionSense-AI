# Implementation Readiness

**Assessment date:** 2026-08-04  
**Outcome:** Phase 2 implementation may proceed

## Approved

The following decisions are fixed unless changed by a new ADR:

| Area | Approved baseline |
|---|---|
| Claim | Visible facial-expression estimate only; never internal emotion, intent, personality, deception, medical status, identity, or protected traits |
| Intended use | Adult, self-use, one consenting foreground face, low-stakes reflection |
| Primary model | MobileNetV3-Small 1.0 architecture candidate |
| Model fallback/control | EfficientNet-Lite0 fallback; MobileNetV2 tooling/control baseline |
| Dataset strategy | License-gated, source-aware public research; commercially usable consented smartphone data required for production lineage |
| App architecture | Flutter Clean Architecture with runtime-independent domain ports and native vision adapters |
| Android pipeline | CameraX → MediaPipe Face Detector → versioned crop/quality → LiteRT adapter → calibration/abstention → compact Flutter state |
| Threading/backpressure | Single serial native worker, queue depth one/latest-frame-only, no pixel/inference work on UI isolate |
| Runtime/delegates | CPU mandatory and reference; allowlisted GPU optional; no new NNAPI production path |
| Data policy | Local-only, offline, foreground, transient; no uploads, cloud fallback, biometric storage, inference history, analytics, ads, or automatic crash reporting |
| Confidence | Calibrate after final artifact; empirical threshold(s); typed unavailable state; no forced label |
| Performance minima | Quantized model ≤6 MB; pipeline RAM ≤64 MB; p95 classifier ≤80 ms; p95 end-to-end ≤350 ms; ≥5 estimates/s; first estimate p95 ≤1 s |
| Sustained behavior | Battery overhead ≤5 percentage points/15 min above preview control; no critical thermal state; p95 degradation ≤35% |
| Quality minima | Macro F1/UAR ≥0.65; each-class recall ≥0.50; ECE ≤0.10; coverage ≥50%; non-abstained accuracy ≥80%; high-confidence error ≤10% |
| Platform direction | Android-first; provisional API 24/arm64/3 GB/front-camera baseline; preserve platform-neutral iOS boundary |
| Release process | All gates plus the mandatory privacy regression checklist; fail closed and stop release rather than relax a hard gate |

## Deferred

- Final production corpus acquisition and its collection/procurement design.
- Training, quantization, calibration, and selection of exact release weights.
- Final Android device/OS allowlist and GPU tuples.
- iOS adapter, minimum OS/device policy, and CPU/GPU/Core ML validation.
- Multi-face support, background capture, recorded-media import, personalization, model updates outside app releases, remote diagnostics, accounts, sync, and cloud inference.
- Public numerical confidence display, temporal-model upgrades, transformer/hybrid candidates, and accessibility benefit claims.
- Launch markets, languages, minors policy, and final production ontology beyond the seven-class working contract.

Deferred items are out of the initial implementation or release scope unless their assigned milestone explicitly brings them in.

## Blockers

### Before coding

**None.** Implementation may begin under [ADR-0011](../DECISIONS/ADR-0011-Implementation-Baseline.md). Mocks, synthetic/approved fixtures, research-only artifacts, benchmark harnesses, lifecycle controls, and interfaces can be developed without a releasable model.

### Before production model training/distribution

- Written dataset rights, consent/provenance, storage, retention, deletion, and model-distribution clearance.
- An approved target population and locked identity-disjoint train/development/calibration/test design.

### Before release

- Exact model/preprocessing/calibration bundle passing every release gate.
- Supported-device and sustained physical-device evidence.
- Privacy, security, accessibility, legal/market, responsible-AI, documentation, and testing approvals.
- iOS gate completion if iOS is included in the release; otherwise iOS must be explicitly excluded from the supported release.

## Evidence Classification

- **Facts:** implementation boundaries and candidate order are resolved; empirical artifact evidence does not yet exist.
- **Assumptions:** provisional support/performance values are attainable and will be tested without weakening minima silently.
- **Trade-offs:** readiness separates coding authorization from production release authorization.
- **Constraints:** no cloud path, sensitive persistence, forced classification, or unsupported claim may be added.
- **Open Questions:** tracked in [Open Decisions](OPEN_DECISIONS.md), with owners and target milestones.

