# ADR-0011: Implementation Baseline

- Date: 2026-08-04
- Owners: Engineering Review Board
- Decision scope: Baseline for implementation after Phase 1

## Status

Accepted — Phase 2 Authorized

## Context

Milestones 1.0–1.4 established the claim, dataset, model, mobile architecture, privacy, ethics, and quality boundaries. Implementation needs a stable starting point without misrepresenting unmeasured production readiness.

## Decision

Authorize Phase 2 implementation under this baseline:

- **Product:** adult, self-use, single consenting foreground face; visible-expression estimates only; explicit uncertainty and safe abstention.
- **Application architecture:** Flutter presentation/domain boundary using Clean Architecture; native session-scoped vision adapters; small typed control/result messages; no raw frames in Flutter domain state.
- **Android pipeline:** CameraX preview/analysis ownership, latest-frame-only scheduling, MediaPipe Face Detector, versioned crop/alignment/quality contract, LiteRT adapter, calibration/abstention, bounded temporal smoothing, compact Flutter state.
- **Model strategy:** MobileNetV3-Small primary, EfficientNet-Lite0 fallback, MobileNetV2 control; one semantic model across tiers; CPU required; allowlisted GPU optional; no new NNAPI production path.
- **Privacy:** local-only, offline, foreground, non-persistent, no cloud inference, no camera/inference telemetry, no biometric storage, bundled verified assets.
- **Performance minimums:** final quantized asset ≤6 MB; incremental pipeline RAM ≤64 MB; p95 classifier ≤80 ms; p95 end-to-end estimate ≤350 ms; p95 first estimate ≤1,000 ms; ≥5 fresh estimates/s; no UI-isolate inference; battery overhead ≤5 percentage points per 15 minutes above matched preview control; no critical thermal state and ≤35% p95 degradation.
- **Quality minimums:** target-domain macro F1 and UAR ≥0.65; every-class recall ≥0.50; ECE ≤0.10; eligible-frame coverage ≥50%; non-abstained accuracy ≥80%; selective macro F1 ≥0.72; high-confidence error ≤10%; worst approved slice macro-F1 gap ≤0.10 when statistically supportable.
- **Support:** Android-first; proposed implementation baseline API 24, arm64, 3 GB RAM, front camera, standalone runtime. These support-floor values remain conditional until dependency and physical-device validation. iOS architecture compatibility is required, but iOS release support is deferred.
- **Engineering principles:** fail closed; separate detection from classification; version model plus preprocessing/calibration; use immutable typed states; bound work and memory; keep domain logic runtime-independent; make privacy, accessibility, and claims testable.
- **Documentation/testing:** maintain ADRs, traceability, dataset/model cards, manifests, benchmark protocols, threat/data-flow documents, limitations, release notes, unit/contract/golden/integration/device/accessibility/security/privacy tests, and reproducible evidence.

Implementation may begin. This authorization does not approve a trained model or public release. Release still requires production-data rights, target-domain artifacts, calibration, device evidence, platform approval, and all gates in `RELEASE_GATES.md`.

## Alternatives Considered

- **Delay all coding until production data exists:** rejected because architecture, mocks, pipeline contracts, lifecycle, privacy controls, and benchmark harnesses can be implemented safely now.
- **Begin without fixed boundaries:** rejected because it invites rework and privacy/claim drift.
- **Approve release with provisional evidence:** rejected; implementation and release have different gates.

## Consequences

- Engineering can start within a stable, reviewable scope.
- Production dataset acquisition and empirical validation proceed in parallel but remain release dependencies.
- A baseline change affecting claims, data flow, model semantics, platform boundary, or minima requires an ADR.
- Failing a gate narrows scope, changes a candidate through review, or stops release; it does not justify silent threshold relaxation.

## Evidence Classification

- **Facts:** Phase 1 documents define coherent candidate technology and measurable gates; no production artifact has yet been built or measured.
- **Assumptions:** the provisional Android support profile and five-estimate cadence are feasible starting points.
- **Trade-offs:** Android-first and CPU-first reduce initial breadth to improve determinism and evidence quality.
- **Constraints:** documentation-only Phase 1 created no runtime, dependency, platform, or model artifacts.
- **Open Questions:** production corpus, trained artifact, exact support matrix, iOS validation, final thresholds, accessibility validation, and launch markets remain.

## References

- [Engineering Review](../research/ENGINEERING_REVIEW.md)
- [Implementation Readiness](../research/IMPLEMENTATION_READINESS.md)
- [Release Gates](../research/RELEASE_GATES.md)
- [Phase 1 Summary](../research/PHASE1_SUMMARY.md)
