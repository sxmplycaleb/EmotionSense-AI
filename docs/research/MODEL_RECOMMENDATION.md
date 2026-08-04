# Model Selection Recommendation

**Milestone:** 1.2 Model Validation & Selection  
**Last reviewed:** 2026-08-04  
**Decision status:** Conditional research recommendation; no model or weights approved for release  
**Related:** [Model Comparison](MODEL_COMPARISON.md) · [Performance Targets](PERFORMANCE_TARGETS.md) · [Deployment Considerations](DEPLOYMENT_CONSIDERATIONS.md) · [Model References](MODEL_REFERENCES.md)

## 1. Executive decision

Use **MobileNetV3-Small 1.0 as the primary production architecture candidate** and **EfficientNet-Lite0 as the secondary fallback candidate**. MobileNetV2 remains the tooling/control baseline. This is a recommendation about architectures to validate, not permission to ship a public checkpoint or weights trained on research-only data.

Production eligibility requires all of the following:

1. training and validation lineage with documented rights for distributed on-device weights;
2. a consented, representative, identity-disjoint smartphone evaluation set;
3. an exact LiteRT artifact that passes quality, calibration, privacy, size, latency, RAM, energy, thermal, and compatibility gates;
4. user-facing abstention and non-diagnostic expression-estimate language; and
5. a versioned model card, signed manifest, and rollback path.

If neither candidate passes, the correct decision is **no production model**, not a relaxed release gate.

### Evidence classification

**Facts.** MobileNetV3-Small has first-party Keras support and was optimized for phone CPUs; EfficientNet-Lite0 has an official LiteRT quantization/export path and Pixel 4 reference measurements [M02], [M04], [M05]. No candidate has been evaluated on EmotionSense's production smartphone corpus or baseline device matrix.

**Assumptions.** A single model, CPU-compatible execution, and a seven-class head are the Version 1 working premises. Proposed weights, thresholds, resolutions, and score differences are decision aids pending experiment.

**Trade-offs.** The primary choice favors substantially lower canonical compute; the fallback favors documented quantization tooling and generic capacity. Neither advantage can compensate for inadequate target robustness, calibration, rights, or fairness.

**Open questions.** Production data rights, target population, exact input contract, device baseline, quantization format, and delegate allowlist remain unresolved and are detailed in Section 8.

## 2. Weighted decision matrix

### Weighting rationale

The matrix reflects project priorities in order: privacy/local execution is a hard gate outside the score; then mobile performance, robustness, accuracy, and maintainability. Robustness and accuracy receive the largest quality weights. Size, latency, memory, battery, quantization, and LiteRT support collectively dominate because they determine viable offline execution.

| Criterion | Weight | Interpretation |
|---|---:|---|
| Accuracy potential | 15% | Evidence that the architecture can retain useful discriminative capacity after adaptation. |
| Robustness evidence | 15% | In-the-wild, cross-domain, nuisance, and protocol quality—not peak benchmark accuracy alone. |
| Model size | 12% | Asset/download cost and weight-memory pressure. |
| Latency | 12% | Batch-1 CPU and accelerator suitability, with real-device evidence favored. |
| Memory efficiency | 8% | Weight plus activation/delegate pressure. |
| Quantization readiness | 10% | FP16/INT8 paths, QAT support, and published evidence. |
| Battery efficiency | 8% | Compute intensity and sustained embedded/mobile evidence. |
| LiteRT support | 10% | Built-in operators, conversion, delegates, and first-party workflows. |
| Community maturity | 5% | Reproducible implementations and comparative use. |
| Maintainability | 5% | Stable upstream APIs, clear architecture, and replacement cost. |

Scores are ordinal: 1 poor, 3 mixed, 5 strong. Weighted total is `sum(weight × score / 5)`. Scores represent the evidence reviewed, not measured EmotionSense performance. Differences under roughly five points should not be treated as statistically meaningful.

| Candidate | Acc. 15 | Robust. 15 | Size 12 | Lat. 12 | Mem. 8 | Quant. 10 | Battery 8 | LiteRT 10 | Maturity 5 | Maintain. 5 | /100 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| MobileNetV3-Small | 4 | 3 | 4 | 5 | 4 | 4 | 5 | 5 | 5 | 5 | **85** |
| MobileNetV2 | 3 | 3 | 4 | 4 | 4 | 5 | 4 | 5 | 5 | 5 | **80** |
| EfficientNet-Lite0 | 4 | 3 | 3 | 4 | 3 | 5 | 4 | 5 | 5 | 5 | **79** |
| ShuffleNetV2 1.0× | 3 | 3 | 5 | 4 | 5 | 3 | 4 | 2 | 4 | 3 | **71** |
| Mini-Xception | 2 | 2 | 5 | 5 | 5 | 3 | 5 | 3 | 3 | 3 | **70** |
| MobileFaceNet | 2 | 2 | 5 | 5 | 5 | 3 | 5 | 2 | 3 | 2 | **67** |
| EmotionNet Nano | 3 | 1 | 5 | 4 | 5 | 1 | 4 | 1 | 2 | 1 | **55** |

### Interpretation

MobileNetV2's slightly higher matrix total than EfficientNet-Lite0 reflects tooling simplicity, not a stronger fallback role. EfficientNet-Lite0 is chosen as the fallback because it provides a deliberately different, higher-capacity trade-off with first-party quantized mobile evidence. MobileNetV2 remains more valuable as a control: if it beats MobileNetV3-Small, the likely causes include conversion, training, or delegate issues that should be investigated.

**Hard gates override scores:** model ancestry rights, representative validation, privacy constraints, supported built-in operators, calibrated abstention, and minimum device budgets are non-compensable.

## 3. Candidate deployment strategies

### Strategy A — one production model

Package one quantized MobileNetV3-Small artifact for all supported devices, with CPU as the universal execution baseline and optional validated acceleration.

**Advantages:** smallest testing matrix; consistent behavior and calibration; simplest model card, rollout, and rollback; lowest app asset cost.

**Disadvantages:** must accommodate the slowest supported tier; a single quantization/input choice may leave flagship performance or low-tier accuracy unused.

**Decision:** recommended for Version 1.

### Strategy B — cascaded models

Run a tiny quality/uncertainty gate, then invoke a larger classifier for difficult frames.

**Advantages:** average compute can fall if easy/rejected inputs dominate; specialized quality handling may improve safety.

**Disadvantages:** two calibration problems, error propagation, more assets/RAM, more test combinations, and variable latency. A face detector already forms a pipeline stage, so an additional learned cascade increases complexity substantially.

**Decision:** defer. Reconsider only if profiling shows classifier compute is a dominant cost and a cascade improves selective risk.

### Strategy C — device-tier-specific models

Ship MobileNetV3-Small to baseline devices and EfficientNet-Lite0 or a larger input to high-tier devices.

**Advantages:** can trade compute for accuracy where hardware permits.

**Disadvantages:** doubles artifacts, fairness/calibration validation, rollout surface, support burden, and behavioral inconsistency. Device tier is not evidence that the larger model is more accurate for a given user.

**Decision:** not for Version 1.

### Strategy D — runtime model selection

Benchmark at startup and dynamically choose an artifact/delegate.

**Advantages:** adapts to real hardware and drivers.

**Disadvantages:** nondeterministic behavior, cold-start cost, harder reproduction, configuration explosion, and risk of choosing a fast but poorly calibrated path.

**Decision:** allow runtime **delegate** fallback within one model after validation; do not select among different semantic models in Version 1.

## 4. Final recommendation

### Primary: MobileNetV3-Small 1.0

Validate an ImageNet-pretrained MobileNetV3-Small with a seven-class logit head at 160×160 and 192×192 face crops, alongside the canonical 224×224 control. These resolutions are experiment candidates, not approved settings. Prefer full INT8 for CPU if target quality passes; otherwise compare QAT INT8 with FP16/FP32 delegate paths.

Why it leads:

- 66M MACs and 2.9M canonical parameters provide a strong mobile budget [M04].
- It was explicitly optimized on phone CPUs [M02].
- Keras provides a maintained implementation and adjustable input size [M04].
- Standard convolutional blocks support a CPU-first, cross-platform fallback.
- It retains materially more representational capacity and transfer-learning maturity than Mini-Xception while remaining much lighter computationally than EfficientNet-Lite0.

### Fallback: EfficientNet-Lite0

Use EfficientNet-Lite0 if MobileNetV3-Small fails the quality/calibration gate and Lite0 passes both quality and resource gates. Lite0 offers the strongest documented end-to-end edge tooling, official INT8 reference results, and direct Model Maker support [M05], [M08], [M09]. Its 407M MAdds and larger asset mean it is not the default.

### Baseline: MobileNetV2

Maintain MobileNetV2 as the transfer-learning, conversion, and regression control. It is directly supported by Model Maker and has mature quantization support. It is not the fallback because it is too similar strategically to MobileNetV3 while offering an older accuracy/latency frontier.

### Models not recommended for Version 1 production

- **Mini-Xception:** benchmark/low-tier prototype only; insufficient robustness and modern deployment evidence.
- **MobileFaceNet:** identity-verification objective and provenance/privacy concerns outweigh its compactness.
- **EmotionNet Nano:** promising research reproduction, but controlled CK+-only evidence and insufficient LiteRT reproducibility.
- **ShuffleNetV2:** useful latency benchmark, but weaker first-party TensorFlow/LiteRT maintenance path.
- **Larger EfficientNet-Lite variants:** defer until Lite0 demonstrably fails quality and larger variants remain inside all budgets.

## 5. Selection experiment and release gates

The future implementation milestone should compare identical data, ontology, augmentation, optimizer-search budget, calibration split, and evaluation splits. Report FP32 and final exported artifact separately.

The primary wins only if it:

1. meets all minimum targets in [PERFORMANCE_TARGETS.md](PERFORMANCE_TARGETS.md);
2. is within 2 macro-F1 percentage points of the best eligible candidate, or wins on macro F1;
3. has no material per-slice or worst-class regression hidden by aggregate metrics;
4. meets selective-risk and calibration targets after quantization;
5. runs with LiteRT built-in operators and a reliable CPU fallback; and
6. shows acceptable 10-minute sustained thermal and battery behavior on every baseline tier.

The 2-point rule is a project assumption intended to prefer the materially cheaper model when quality is practically tied. It must be approved in an ADR before use.

## 6. Risks and controls

| Risk | Consequence | Required control |
|---|---|---|
| Domain shift | Strong public benchmark, poor front-camera behavior | Locked identity-disjoint multi-device smartphone test; cross-dataset evaluation; quality gating. |
| Calibration error | Overconfident expression estimate | Separate calibration set; classwise reliability analysis; ECE/Brier/NLL; abstention. |
| Overfitting / model-selection leakage | Inflated release evidence | Pre-register selection metrics; isolate final test; report repeated seeds and uncertainty intervals. |
| Quantization degradation | Aggregate or minority-class quality loss | Compare float and exported INT8 per class/slice; QAT or FP16 fallback; do not average away regressions. |
| Thermal throttling | Latency/FPS degradation during sessions | Cold and sustained runs; measure p95 and degradation; adaptive sampling or fail gracefully. |
| Hardware variability | Delegate crash or inconsistent outputs | CPU baseline; allowlisted acceleration; device matrix; deterministic fallback. |
| Face pipeline coupling | Classifier metrics fail end to end | Evaluate detector failures, crop quality, pose/occlusion, no-face/multi-face behavior. |
| Unsupported inference claims | User harm despite accurate labels | Describe outputs as uncertain facial-expression estimates; never infer internal state [M24]. |
| Model ancestry restrictions | Cannot lawfully distribute weights | Dataset/model lineage gate and legal review before training production candidates. |

## 7. Assumptions and trade-offs

### Assumptions

- Version 1 processes one foreground face locally and does not persist raw frames by default.
- A single model artifact is operationally preferable for the first release.
- CPU execution is the compatibility baseline; delegates are optimizations.
- Production training data will be separately licensed or consented, not merely copied from public FER research datasets.

### Trade-offs

- MobileNetV3-Small sacrifices some generic ImageNet capacity relative to EfficientNet-Lite0 for much lower canonical compute.
- INT8 improves CPU size/latency but may harm rare-class logits and calibration.
- One-model deployment limits tier-specific optimization but substantially reduces governance and regression risk.

## 8. Open questions

1. What exact countries, age ranges, skin-tone ranges, devices, lighting, pose, eyewear, occlusion, and assistive contexts define release scope?
2. Which production dataset rights explicitly permit distributing derived on-device weights?
3. Which input resolution and color space maximize target selective accuracy within the energy budget?
4. Does QAT recover any class/slice degradation from full INT8?
5. What is the baseline device/OS matrix and minimum supported RAM?
6. Are GPU/NPU paths consistently faster after initialization and tensor-copy costs?
7. What coverage is acceptable when the classifier abstains frequently under poor capture conditions?
8. Should the ontology remain seven expressions or move toward action units, valence/arousal, or user-authored reflection?

## 9. Suggested ADRs

- **ADR: Production model architecture and evidence gates** — approve only after target-domain and device testing.
- **ADR: Model input and preprocessing contract** — face crop, alignment, resolution, color, normalization, and quality gates.
- **ADR: Quantization and delegate policy** — CPU baseline, INT8/FP16 choice, accelerator allowlist, and fallback.
- **ADR: Model packaging, signing, update, and rollback** — embedded seed model and optional updates.
- **ADR: Confidence, calibration, and abstention UX** — thresholds, coverage target, and failure language.
- **ADR: Supported device performance baseline** — devices, OS versions, session length, and measurement protocol.
