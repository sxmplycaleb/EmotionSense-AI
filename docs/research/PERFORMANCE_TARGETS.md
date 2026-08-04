# Production Model Performance Targets

**Milestone:** 1.2 Model Validation & Selection  
**Last reviewed:** 2026-08-04  
**Status:** Proposed budgets for future physical-device validation; not measured results  
**Related:** [Model Recommendation](MODEL_RECOMMENDATION.md) · [Deployment Considerations](DEPLOYMENT_CONSIDERATIONS.md) · [Model References](MODEL_REFERENCES.md)

## 1. Purpose and measurement boundary

These budgets turn the model recommendation into falsifiable engineering gates. Values are **project assumptions**, informed by lightweight-model references and mobile benchmarking practice [M05], [M18], [M19], not results from this repository.

Measure two boundaries separately:

- **Classifier-only:** aligned face tensor in to logits out.
- **End-to-end foreground pipeline:** camera frame acquisition, face detection/quality gate, crop/resize/normalize, classifier, calibration, and result handoff.

All latency results use batch size 1 and report median, p90, p95, and p99 after declared warmup. Report cold initialization separately. Tests must identify device, OS, runtime version, model hash, delegate, threads, power mode, ambient conditions, starting battery/temperature, and whether the device was charging. The LiteRT benchmark app is preferred over a shell binary where possible because scheduling can differ [M18].

## 2. Proposed budgets

| Measure | Aspirational target | Minimum acceptable threshold | Scope / method |
|---|---:|---:|---|
| FP32 model asset | ≤12 MB | ≤20 MB | Exact `.tflite` bytes, excluding runtime; seven-class head. |
| Final quantized asset | ≤4 MB | ≤6 MB | Exact release artifact including metadata. |
| Incremental peak RAM | ≤40 MB | ≤64 MB | End-to-end pipeline above idle app baseline; include delegate buffers and camera pipeline. |
| Classifier cold initialization | ≤150 ms | ≤300 ms | File open/map, interpreter/delegate creation, tensor allocation; p95 across clean launches. |
| End-to-end first estimate | ≤500 ms | ≤1,000 ms | Foreground camera ready to first usable or abstained result; p95. |
| Classifier steady latency | p50 ≤25 ms; p95 ≤40 ms | p50 ≤50 ms; p95 ≤80 ms | Warm batch-1 run on every baseline device using production execution path. |
| End-to-end estimate latency | p50 ≤100 ms; p95 ≤180 ms | p50 ≤200 ms; p95 ≤350 ms | Includes detector and preprocessing. |
| Sustained classifier throughput | ≥10 FPS | ≥5 FPS | 10-minute foreground session; measured estimates, not camera preview FPS. |
| UI responsiveness | No inference work on UI isolate; ≥95% frames within display deadline | ≥90% frames within display deadline | App-level frame timing during session; exact 60/120 Hz deadline follows device. |
| Battery impact | ≤3 percentage points per 15 min above matched camera-preview control | ≤5 points per 15 min above control | Repeated paired runs; screen brightness/network/background state fixed. |
| Thermal behavior | No OS serious/critical thermal state; p95 latency degradation ≤20% | No critical state; degradation ≤35% | Compare minutes 8–10 with warmed minutes 1–2; device not charging. |
| Crash / delegate failure | 0 crashes; <0.1% recoverable inference failures | 0 crashes; <1% recoverable failures | Representative device/session test set; CPU fallback exercised. |

### Why sustained FPS is not 30

EmotionSense does not need to classify every preview frame. Decoupling a smooth camera preview from 5–10 expression estimates per second reduces energy and thermal load. Temporal smoothing must not manufacture certainty; the UI should show stale/unavailable state when no recent high-quality result exists.

## 3. Quality targets

Quality gates apply to the locked, consented, identity-disjoint smartphone test set and are reported with 95% confidence intervals. Public benchmark results remain separate.

| Measure | Aspirational target | Minimum acceptable threshold | Notes |
|---|---:|---:|---|
| Seven-class macro F1 | ≥0.75 | ≥0.65 | Primary selection metric; exact gate should be revisited after pilot label agreement is known. |
| Unweighted average recall | ≥0.75 | ≥0.65 | Prevents majority classes dominating. |
| Overall accuracy | ≥0.78 | ≥0.68 | Secondary only; never reported alone. |
| Per-class recall | ≥0.60 every class | ≥0.50 every class | Report sample counts and uncertainty; do not silently drop rare classes. |
| Cross-dataset macro-F1 retention | ≥80% of in-domain score | ≥70% | Diagnostic, not a substitute for target testing; ontology/protocol must match. |
| Quantized-vs-float macro-F1 loss | ≤0.01 absolute | ≤0.02 | Also require no per-class recall loss >0.03 and no material slice regression. |
| Expected calibration error | ≤0.05 | ≤0.10 | Fixed binning plus adaptive-bin sensitivity; report method. |
| Brier score / NLL | No material regression from calibrated float baseline | ≤10% relative regression | Report both where label form permits. |
| Worst approved slice gap | ≤0.05 macro F1 | ≤0.10 | Requires adequate sample size; not valid when intervals are too wide. |

These numerical quality values are starting hypotheses. Human label disagreement places a task-dependent ceiling on apparent performance; pilot data and annotator distributions must inform the final ADR.

## 4. Confidence, calibration, and abstention

### Proposed behavior

- Calibrate logits on a dedicated identity-disjoint calibration split using a documented method such as temperature scaling [M22].
- Choose class-specific thresholds where class reliability differs; do not use an arbitrary universal softmax value.
- Abstain on no face, multiple ambiguous faces, low crop quality, severe pose/occlusion/blur, out-of-distribution input, stale frame, runtime failure, or insufficient calibrated confidence.
- Present abstention as “No reliable expression estimate” rather than forcing a class.
- Never convert confidence into certainty about internal emotion.

### Selective-prediction targets

| Measure | Aspirational target | Minimum acceptable threshold |
|---|---:|---:|
| Coverage on eligible, quality-passing target frames | ≥70% | ≥50% |
| Accuracy among non-abstained estimates | ≥85% | ≥80% |
| Selective macro F1 | ≥0.80 | ≥0.72 |
| High-confidence error rate | ≤5% | ≤10% |

Coverage must be reported overall, by class, and by approved demographic/environmental slices. A model that reaches accuracy by abstaining disproportionately for a group fails fairness review even if aggregate selective accuracy is high.

## 5. Device tiers and test protocol

The exact device matrix is open. At minimum, future testing should include:

1. the oldest/lowest-performance supported Android device;
2. a mid-tier Android device;
3. a recent Android device with supported acceleration;
4. the oldest supported iPhone; and
5. a recent iPhone with Neural Engine.

For each artifact and device:

- run CPU baseline first;
- inspect delegate partitioning and fallbacks;
- run at least 50 warm iterations for microbenchmarks, plus repeated cold launches;
- run a 10-minute end-to-end foreground session;
- repeat battery tests against a matched camera-preview-only control;
- test low battery, thermal pressure, lifecycle interruption, and delegate initialization failure;
- store only nonsensitive aggregate measurements with model/device identifiers; never retain test frames unless separately consented and governed.

## 6. Decision rules

- **Aspirational pass:** all aspirational resource, quality, calibration, and selective-prediction targets pass on all baseline tiers.
- **Conditional pass:** every minimum threshold passes; misses against aspiration have owners, rationale, and an approved ADR.
- **Fail:** any hard minimum, privacy/provenance gate, worst-class gate, critical thermal condition, or crash gate fails.
- A faster delegate is rejected if it changes outputs enough to break quality/calibration limits or fails reliably on the supported matrix.
- Average performance never compensates for failure on the baseline device.

## 7. Facts, assumptions, and trade-offs

### Facts

- Model optimization can reduce size and latency but can change accuracy [M17].
- Full INT8 requires representative data and enables integer-only execution paths [M15].
- Mobile performance varies across hardware and software stacks, so standardized, transparent protocols are necessary [M19].

### Assumptions

- A reflection session is foreground-only and typically no longer than 15 minutes.
- Five reliable estimates per second are sufficient for Version 1 interaction.
- Incremental battery cost above camera preview is more actionable than total drain, because the screen/camera baseline is substantial.

### Trade-offs

- Strict abstention improves selective accuracy but lowers availability.
- Lower resolution and INT8 improve performance but may disproportionately harm subtle/rare expressions.
- A conservative device baseline expands access but can constrain model capacity.

## 8. Open questions

1. What device/OS versions and session duration define Version 1 support?
2. What label agreement and class prevalence are achievable in the consented smartphone corpus?
3. Are the proposed quality thresholds statistically resolvable for every class and slice?
4. What battery instrumentation is reproducible across Android and iOS?
5. Should thermal degradation compare against the first warm minute or a controlled external temperature baseline?
6. What maximum abstention disparity across user/environment slices is acceptable?
7. Does temporal smoothing improve reliability without delaying or overstating changes?

