# Mobile Architecture Decision Summary

**Milestone:** 1.3 Mobile Architecture Validation  
**Status:** Recommendations suitable for conversion into ADRs  
**Last reviewed:** 2026-08-04  
**References:** [Mobile References](MOBILE_REFERENCES.md)

These records are concise decision proposals. “Accept” means accept for subsequent design/validation, not permission to implement or ship.

## MAD-01 — Keep the production frame pipeline native

**Decision.** Place camera analysis, MediaPipe, preprocessing, and LiteRT behind a platform-neutral Flutter `VisionSessionPort`; exchange only control messages and compact results.

**Context.** Raw camera frames are large, frequent, sensitive, and costly to serialize. Platform channels provide host access but do not remove marshaling or threading concerns [FL02].

**Alternatives considered.** Flutter camera image stream plus Dart processing; per-frame platform-channel calls; all-native UI.

**Trade-offs.** Better buffer ownership, privacy boundary, and latency versus maintaining Android and future iOS adapters.

**Recommendation and rationale.** **Accept.** It best matches privacy, mobile performance, reliability, and future platform isolation. Use the official Flutter camera stream only as a benchmark/prototype challenger.

## MAD-02 — Use MediaPipe Face Detector for Version 1 alignment input

**Decision.** Use Face Detector bounding boxes and six keypoints for eligibility, padded crop, and coarse roll alignment. Keep detection independent of emotion classification.

**Context.** Face Detector supports live streams, returns six keypoints, and drops new frames while busy [MP01]. Face Landmarker returns dense landmarks but adds compute and remains a preview solution [MP02].

**Alternatives considered.** Face Landmarker alone; Face Detector followed by Face Landmarker every frame; classifier on a fixed center crop; custom detector.

**Trade-offs.** Lower compute and simpler governance versus weaker pose/occlusion geometry.

**Recommendation and rationale.** **Conditionally accept.** Validate box-only, six-point, and landmarker alignment. If Landmarker produces a material target-quality gain within all budgets, replace the detector/alignment component; do not chain redundant full pipelines by default.

## MAD-03 — Use LiteRT behind a replaceable runtime adapter

**Decision.** Run the governed MobileNetV3-Small `.tflite` artifact with a LiteRT runtime adapter; prefer the current `CompiledModel` API for the implementation spike and retain `Interpreter` as the CPU/reference compatibility candidate. Keep EfficientNet-Lite0 as a separately validated fallback model candidate.

**Context.** EmotionSense owns nonstandard alignment, quality gating, calibration, abstention, and a versioned preprocessing contract.

**Alternatives considered.** Direct `CompiledModel`; direct `Interpreter`; Task Library ImageClassifier; MediaPipe Image Classifier; custom runtime; cloud inference.

**Trade-offs.** `CompiledModel` is the current modern standard, while `Interpreter` has broader legacy maturity and explicit delegate tooling; either lower-level path requires adapter and metadata validation [LR01]. Task Library provides useful preprocessing/labels/threshold features but requires compatible metadata [LR04].

**Recommendation and rationale.** **Accept.** The adapter prevents a new API from leaking into domain/presentation code. Select between the two lower-level APIs with physical-device, compatibility, correctness, and lifecycle evidence. Re-evaluate Task Library only after golden-tensor parity and confirmation that safety policies remain explicit.

## MAD-04 — Package the runtime and model for offline use

**Decision.** Bundle the detector/model assets and standalone on-device runtime required for core analysis; do not require Google Play Services, a network, or runtime model delivery.

**Context.** Privacy and offline reliability are higher priorities than package-size savings or remotely updated runtimes.

**Alternatives considered.** LiteRT in Google Play Services; remote model download; cloud inference.

**Trade-offs.** Larger app and app-release-driven runtime updates versus deterministic versions, non-GMS support, and offline startup.

**Recommendation and rationale.** **Accept for Version 1.** A future runtime-service option requires compatibility, privacy, supply-chain, and fallback review.

## MAD-05 — Make CPU the default and universal fallback

**Decision.** Validate CPU first on every supported device; optional acceleration may never be required for minimum support.

**Context.** Delegates vary by model/device and can change precision [LR02].

**Alternatives considered.** GPU-first everywhere; NNAPI-first; startup race among delegates.

**Trade-offs.** Predictability and reach versus leaving accelerator performance unused on some devices.

**Recommendation and rationale.** **Accept.** It minimizes compatibility risk and establishes a correctness reference.

## MAD-06 — Allowlist GPU; do not adopt NNAPI for new production use

**Decision.** Promote GPU only for validated device/OS/runtime/model tuples. Exclude NNAPI from the production selection policy.

**Context.** GPU support, partitioning, memory, thread affinity, and sustained benefit vary [LR02][LR03]. NNAPI is deprecated in Android 15 [AN01].

**Alternatives considered.** Capability-query auto-enable; broad denylist; NNAPI for API 27–34.

**Trade-offs.** Allowlisting increases lab/maintenance work and limits acceleration reach but reduces field surprises.

**Recommendation and rationale.** **Accept.** Require output/calibration parity, lifecycle tests, and sustained energy benefit before promotion.

## MAD-07 — Use a serial native worker; no mandatory Dart worker isolate

**Decision.** Own detector, LiteRT execution/acceleration context, buffers, and temporal state on one session-scoped native worker. Keep Flutter UI work small; introduce a long-lived Dart isolate only for a measured Dart bottleneck.

**Context.** Flutter isolates use separate memory/message passing; repeated mutable payloads are generally copied [FL01]. GPU delegate creation/invocation has same-thread requirements [LR03].

**Alternatives considered.** UI-isolate inference; per-frame short isolates; parallel interpreter pool.

**Trade-offs.** Serial processing is deterministic and memory-bounded but does not maximize raw throughput.

**Recommendation and rationale.** **Accept.** The target is 5–10 Hz fresh inference, not maximum camera FPS.

## MAD-08 — Drop frames; never build an analysis backlog

**Decision.** Use CameraX keep-only-latest plus a single-flight cadence gate.

**Context.** A queued frame becomes stale, consumes memory, and can block preview. CameraX explicitly supports latest-only analysis [AX01].

**Alternatives considered.** Process every frame; fixed FIFO; block producer.

**Trade-offs.** Temporal samples are irregular and some brief expressions may be missed, but displayed results remain fresher and the UI remains responsive.

**Recommendation and rationale.** **Accept.** Include source timestamps and measure result age/drop rate.

## MAD-09 — Own preprocessing as a versioned model contract

**Decision.** Version crop geometry, mirroring/rotation, color conversion, resize method, numeric normalization/quantization, labels, calibration, and thresholds with the model.

**Context.** Small preprocessing drift can invalidate evaluation and calibration.

**Alternatives considered.** Runtime defaults; duplicated Dart/native transforms; model-only versioning.

**Trade-offs.** More governance and golden fixtures versus reproducibility and safe replacement.

**Recommendation and rationale.** **Accept.** Reject incompatible artifacts atomically rather than guessing.

## MAD-10 — Use layered confidence and explicit abstention

**Decision.** Combine input quality, face eligibility, calibrated classifier scores, class-specific thresholds, temporal consistency, and freshness. Return typed unavailability instead of a forced label.

**Context.** Softmax outputs are not inherently calibrated; temperature scaling is an established baseline [ML01].

**Alternatives considered.** Maximum softmax label; universal 0.5 threshold; detector confidence as a joint score.

**Trade-offs.** Lower coverage and more validation work versus lower false-high-confidence risk.

**Recommendation and rationale.** **Accept.** Measure coverage/selective risk overall and by approved slices.

## MAD-11 — Single-face, foreground-only, offline-only Version 1

**Decision.** Analyze exactly one consenting foreground user; raw media is transient and no cloud fallback exists.

**Context.** Multiple-face selection creates attribution and bystander privacy risks; background capture changes the threat and lifecycle model.

**Alternatives considered.** Largest-face selection; multi-face results; background analysis; cloud fallback.

**Trade-offs.** Narrower use and lower coverage versus clearer consent, lower compute, and reliable attribution.

**Recommendation and rationale.** **Accept.** Any expansion requires a new ADR and privacy/ethics review.

## MAD-12 — Tier cadence and delegates, not semantic models

**Decision.** Use one model/preprocessing/confidence contract across supported Android tiers; vary only validated resolution, cadence, thread count, and delegate.

**Context.** Per-tier semantic models multiply fairness, calibration, rollout, and support matrices.

**Alternatives considered.** Larger flagship model; startup model selection; cascade.

**Trade-offs.** Leaves high-end accuracy capacity unused but makes behavior more consistent and maintainable.

**Recommendation and rationale.** **Accept for Version 1.** Revisit only if target evidence demonstrates a non-compensable quality need.

## Cross-cutting assumptions, trade-offs, and open questions

### Facts

The facts supporting each proposal are cited inline and consolidated in [Mobile References](MOBILE_REFERENCES.md).

### Assumptions

- Six-keypoint alignment, 5–10 Hz inference, API 24/arm64/3 GB support, and the native boundary all remain unvalidated project choices.
- The final model can use built-in LiteRT operators and pass CPU budgets.

### Trade-offs

The design intentionally prioritizes privacy, sustained reliability, and maintainability over maximum instantaneous FPS and broad automatic accelerator use.

### Open questions

1. Which proposals pass physical-device and target-domain validation unchanged?
2. Should MAD-01, MAD-02, MAD-04, MAD-06, MAD-09, MAD-10, and MAD-11 become formal ADRs before Milestone 2 implementation?
3. Which dependency versions and support floor are supportable at implementation time?
