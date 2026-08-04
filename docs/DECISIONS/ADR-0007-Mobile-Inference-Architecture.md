# ADR-0007: Mobile Inference Architecture

- Date: 2026-08-04
- Owners: Mobile Architecture and ML Platform leads
- Decision scope: Camera, detection, inference, threading, and Flutter/native boundary

## Status

Accepted

## Context

Full camera frames are large and sensitive. Passing them through Dart or unbounded queues increases copying, staleness, lifecycle, performance, and privacy risk. Runtime and delegate behavior also varies by device.

## Decision

Adopt a native, session-scoped vision pipeline behind a platform-neutral Flutter domain port.

- Android CameraX owns camera lifecycle, preview, timestamps, and `KEEP_ONLY_LATEST` backpressure.
- MediaPipe Face Detector supplies bounding boxes and six keypoints for single-face eligibility, crop, and coarse alignment. Dense Face Landmarker is a conditional replacement only after measured benefit; it is not chained by default.
- A LiteRT runtime adapter owns the governed classifier. `CompiledModel` is the preferred spike candidate and `Interpreter` remains the CPU/reference compatibility candidate until Phase 2 measurements select the API.
- Raw frames, crops, tensors, runtimes, reusable buffers, and temporal state remain native. Flutter receives only small immutable typed states and never receives pixels.
- One serial native worker owns detector, runtime/delegate, buffers, and temporal state. The UI isolate performs no pixel or inference work. A Dart worker isolate is added only for a measured Dart bottleneck.
- Queue depth is one/single-flight; stale frames and out-of-session results are discarded.
- CPU is the mandatory default/reference and universal fallback. GPU is enabled only for allowlisted device/OS/runtime/model tuples after parity, lifecycle, sustained performance, RAM, and energy tests. NNAPI is not used for new production deployment.
- One semantic model, preprocessing contract, calibration, and thresholds apply across device tiers; only validated cadence, resolution, thread count, and delegate may vary.
- Android is implementation-first. The platform-neutral port and model contract must preserve an iOS path, but iOS support is not approved until independently validated.

## Alternatives Considered

- **Flutter camera image stream:** retained for prototypes only; production use requires proof of no harmful copy or lifecycle cost.
- **Per-frame platform-channel transfer:** rejected because of serialization and backlog risk.
- **Cloud inference:** rejected by the local-only policy.
- **GPU/NNAPI-first or delegate race:** rejected because CPU correctness and predictable fallback are mandatory.
- **Parallel interpreter pool:** rejected; fresh 5–10 Hz results matter more than maximum throughput.

## Consequences

- More native adapter work is required on each platform.
- Privacy and performance boundaries are explicit and testable.
- The UI remains decoupled from camera cadence and runtime APIs.
- Device allowlisting adds maintenance but limits field-specific delegate failures.

## Evidence Classification

- **Facts:** CameraX supports latest-only analysis; MediaPipe and LiteRT have device/runtime-specific constraints.
- **Assumptions:** Android API 24, arm64, 3 GB RAM, front camera, and 5–10 Hz are starting support hypotheses.
- **Trade-offs:** native ownership increases platform code but reduces copies and makes lifecycle ownership deterministic.
- **Constraints:** no raw frame crosses the Flutter domain boundary and no unvalidated fallback is allowed.
- **Open Questions:** final LiteRT API, exact dependency support floor, detector/alignment choice, device matrix, and iOS adapter remain validation work.

## References

- [Mobile Architecture](../research/MOBILE_ARCHITECTURE.md)
- [Inference Pipeline](../research/INFERENCE_PIPELINE.md)
- [Performance Architecture](../research/PERFORMANCE_ARCHITECTURE.md)
- [Device Compatibility](../research/DEVICE_COMPATIBILITY.md)
- [Failure Modes](../research/FAILURE_MODES.md)
