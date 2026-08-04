# Model Deployment Considerations

**Milestone:** 1.2 Model Validation & Selection  
**Last reviewed:** 2026-08-04  
**Scope:** Design considerations only; no runtime or application implementation  
**Related:** [Model Recommendation](MODEL_RECOMMENDATION.md) · [Performance Targets](PERFORMANCE_TARGETS.md) · [Model References](MODEL_REFERENCES.md)

## 1. Deployment principles

1. All frame processing and inference remain local; the core flow requires no network.
2. The release unit is the exact exported model plus preprocessing, ontology, calibration, thresholds, metadata, provenance, and runtime compatibility—not weights alone.
3. CPU execution is the universal correctness baseline. Hardware acceleration is enabled only after device-specific validation.
4. Unsupported input or uncertain output fails to an unavailable/abstained state, never a forced expression label.
5. No raw frame, face embedding, or per-user expression history is operational telemetry.

## 2. LiteRT compatibility contract

Before an artifact is eligible:

- convert using built-in LiteRT operators only; avoid Select TF/custom operators unless an ADR demonstrates necessity and binary/security impact;
- record TensorFlow/Keras, converter, TensorFlow Model Optimization, and LiteRT runtime versions;
- record input/output tensor names, shapes, dtypes, quantization scales/zero points, color order, normalization, crop/alignment, labels, and logit/softmax semantics;
- validate numerical parity between source float model and exported artifact on a versioned golden set;
- inspect operator list and delegate partitioning rather than assuming architectural compatibility;
- test metadata and label ordering as part of the artifact contract;
- measure initialization, warm latency, steady latency, and memory using official benchmark tooling and the actual app path [M18].

The project should use the current product name **LiteRT** in new decision records while noting that existing code, package names, and sources may retain **TensorFlow Lite / TFLite** terminology.

## 3. Delegate policy

| Path | Role | Benefits | Risks / controls |
|---|---|---|---|
| CPU with optimized kernels | Required baseline on Android and iOS | Broadest compatibility, deterministic fallback, strong INT8 path | Sustained CPU energy; tune threads and sampling, test XNNPACK/runtime defaults. |
| Android GPU | Optional allowlisted optimization | Strong FP16/float throughput for compatible graphs | Initialization/copy cost, partial delegation, driver variance; check support before enabling and retain CPU fallback. |
| Android NPU / vendor acceleration | Optional future optimization | Potential latency/energy benefit | Fragmented support and rapidly changing APIs; validate via current LiteRT acceleration path per device/runtime. |
| NNAPI | Legacy compatibility only | Can reach hardware on older Android versions | NNAPI is deprecated in Android 15; do not make it the future architecture [M20]. |
| iOS Metal GPU | Optional optimization | Float/FP16 acceleration and a fallback when Core ML delegate is unavailable | Memory/initialization and operator coverage must be profiled. |
| LiteRT Core ML delegate | Experimental optional path | Can use Core ML/Neural Engine on A12+ devices | Delegate is beta and currently supports float models; unsupported ops fall back to CPU [M21]. |

Do not choose a delegate solely from model family. At runtime, failure to create or invoke an optional delegate should atomically recreate/use the validated CPU interpreter, record a redacted local diagnostic counter, and continue or abstain. Repeated delegate failures should disable that path for the current app/model version.

## 4. Quantization strategy

### Recommended sequence

1. Establish the source FP32 quality and calibration baseline.
2. Export dynamic-range INT8 weights as a quick diagnostic, not the presumed release format.
3. Export full INT8 with a representative, rights-cleared calibration set covering real camera ranges and quality conditions.
4. Compare per-class, slice, calibration, and selective-risk metrics—not accuracy alone.
5. If post-training INT8 misses gates, use QAT and repeat the full evaluation.
6. Keep an FP16/float artifact only if it is the approved iOS/GPU path or INT8 cannot meet quality; do not ship redundant assets without measured benefit.

### Facts

TensorFlow recommends FP16 for GPU acceleration and INT8 for CPU execution; full integer quantization requires representative data [M15]. QAT simulates inference quantization and often preserves accuracy better, but support is model/layer dependent [M16]. EfficientNet-Lite deliberately removes SE and uses ReLU6 to improve edge/post-training quantization behavior [M05].

### Trade-offs

- Dynamic-range quantization reduces weight size but leaves activation computation less optimized and adds runtime overhead relative to full integer quantization.
- Full INT8 can unlock CPU/accelerator efficiency but may alter low-margin logits and calibration.
- FP16 usually halves weight storage and suits GPUs, but CPU benefit is device-dependent.
- QAT increases training/reproducibility complexity and must be applied only with rights-cleared production training data.

## 5. Model package and versioning

Treat each release as an immutable package with:

- semantic package version and monotonically increasing internal revision;
- model SHA-256 digest and byte size;
- architecture/configuration and source checkpoint digest;
- training-data manifest IDs and rights/provenance approval IDs;
- converter/runtime compatibility range and operator inventory;
- preprocessing schema version;
- label ontology and label-order version;
- calibration method/parameters and confidence/quality thresholds;
- intended use, prohibited uses, known limitations, evaluation summary, and model card;
- supported device/delegate allowlist and fallback policy;
- creation/approval timestamps and accountable owners.

A change to weights, quantization, input resolution, preprocessing, labels, calibration, thresholds, or converter creates a new model package and requires regression evaluation. App and model compatibility should be explicit, for example `min_model_schema` / `max_model_schema`, rather than inferred from filenames.

## 6. Integrity and authenticity

- Verify the packaged asset's SHA-256 digest before interpreter creation [M25].
- For remotely delivered updates, verify a platform-trusted digital signature over a canonical manifest and model digest before activation; TLS alone is insufficient artifact authenticity.
- Store trusted signing keys in the application/platform trust boundary and design key rotation/revocation.
- Reject unknown schema, size mismatch, digest mismatch, signature failure, downgrade below the rollback floor, or unsupported operators.
- Avoid decrypting or copying the model into broad shared storage. Model obfuscation is not a substitute for rights, integrity, or secure update design.

## 7. Update and rollback

Version 1 should ship a validated embedded seed model so the core workflow works offline after installation. A future optional model update flow should:

1. fetch only with explicit product/legal approval and appropriate user/network policy;
2. download to a staging location;
3. verify signature, digest, size, schema, runtime compatibility, and available storage;
4. run a local smoke/golden-vector check without user frames;
5. activate atomically while retaining the last-known-good artifact;
6. roll back automatically on load/invoke/crash thresholds; and
7. never delete the embedded seed fallback.

Updates must not silently change ontology, product claims, or retention behavior. Rollback should be exercisable before release. Prevent unintended downgrade while retaining an explicit emergency rollback capability.

## 8. Device compatibility

Compatibility is a matrix, not a minimum OS number. Record and test:

- CPU architecture/ABI, OS version, RAM tier, SoC/GPU/NPU, and thermal class;
- LiteRT distribution/runtime version and native binary size;
- delegate availability, graph partition, precision, and driver behavior;
- model load from packaged and updated locations;
- camera pixel format/orientation/mirroring and crop correctness;
- lifecycle interruption, low memory, background/foreground, permissions, and low storage;
- outputs across CPU and each allowed delegate within declared numeric tolerances.

Hardware acceleration should be denylisted/allowlisted from evidence. A device that cannot meet minimum budgets on CPU or an approved stable delegate is outside the supported model matrix; it must receive a clear unavailable state rather than degraded, misleading results.

## 9. Privacy-preserving monitoring

The core product must operate with monitoring disabled and without a network. If optional telemetry is later approved, collect only coarse, consent-governed operational aggregates such as:

- model package version and broad device/OS tier;
- initialization/inference latency buckets;
- delegate chosen and coarse fallback/error code;
- peak-memory/thermal/battery buckets where platform APIs permit;
- aggregate abstention reason counts without class probabilities or timestamps precise enough to reconstruct behavior.

Never collect raw/derived frames, crops, embeddings, logits, predicted expression classes, user corrections/reflections, stable device identifiers, or session histories. Apply minimum cohort thresholds, short retention, regional/legal review, and on-device aggregation where possible. Monitoring must not become a backdoor research dataset.

## 10. Failure modes and fallback behavior

| Failure | Safe behavior |
|---|---|
| No face / multiple faces | Do not choose a person; request one centered face or abstain. |
| Blur, darkness, occlusion, extreme pose, crop error | Show a quality-specific retry cue; do not run or expose a forced class. |
| Low calibrated confidence / OOD signal | “No reliable expression estimate”; invite user-led reflection. |
| Model missing, corrupt, unsigned, incompatible | Reject artifact; load last-known-good/embedded seed; otherwise disable feature. |
| Delegate unavailable or invocation fails | Retry once on validated CPU path; suppress unstable delegate for current version. |
| Allocation / low-memory failure | Release interpreter/camera buffers, reduce sampling if approved, or disable inference; never crash-loop. |
| Timeout / thermal pressure | Drop queued frames, reduce sampling, show stale/unavailable state; never process an unbounded backlog. |
| Camera permission revoked / lifecycle interruption | Stop capture and clear transient buffers immediately. |
| Label/preprocessing mismatch | Fail closed during package validation; never guess mapping. |
| Repeated model error | Disable inference for the session, retain user-authored reflection features, expose a nonsensitive diagnostic code. |

## 11. Assumptions, trade-offs, and open questions

### Assumptions

- Raw camera frames and face crops remain ephemeral and are not persisted by default.
- One packaged model is used across device tiers in Version 1.
- Optional acceleration never changes the semantic model or threshold set unless separately validated.

### Trade-offs

- An embedded seed increases app size but guarantees offline availability and rollback.
- Strict signature/schema checks can reject otherwise runnable artifacts but prevent silent corruption and incompatibility.
- CPU fallback improves reliability at possible energy/latency cost.
- Privacy-preserving monitoring limits incident detail; strong local diagnostics and reproducible device testing become more important.

### Open questions

1. Will LiteRT be bundled or provided through an updateable platform runtime on each platform?
2. What signing authority, rotation process, and rollback floor will govern model updates?
3. Which delegates pass the final device matrix and numeric-parity tolerances?
4. How long may a last-known-good downloaded artifact be retained?
5. Is any optional operational telemetry justified for Version 1?
6. What local diagnostic export can users voluntarily share without sensitive inference content?
7. Who owns emergency model disablement and rollback approval?

