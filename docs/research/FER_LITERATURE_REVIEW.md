# Facial Expression Recognition Literature Review

## Document control

| Field | Value |
| --- | --- |
| Milestone | 1.0 — Technical Discovery & Validation |
| Status | Research baseline; no architecture selection |
| Research snapshot | 2026-08-04 |
| Project alignment | Privacy-first, mobile-first, offline, non-diagnostic [P01][P02] |

See the [consolidated bibliography](REFERENCES.md), [mobile overview](MOBILE_FER_OVERVIEW.md), [limitations](TECHNICAL_LIMITATIONS.md), and [research gaps](RESEARCH_GAPS.md).

## Scope and terminology

Facial expression recognition (FER) maps visible facial appearance or movement to a representation such as discrete expression categories, facial action units (AUs), or continuous valence/arousal. It is narrower than affect recognition, which may combine face, voice, text, posture, physiology, and context [R01][R05].

For EmotionSense AI, **emotion estimate** means a confidence-aware estimate from observable facial signals. It is not a measurement of a person’s private internal emotional state. The literature does not support a universal one-to-one mapping from a facial configuration to a specific felt emotion across all people and contexts [R07].

| Evidence label | Meaning in this review |
| --- | --- |
| **Fact** | Supported by cited academic or official evidence |
| **Assumption** | Project-specific proposition awaiting validation |
| **Trade-off** | Competing engineering or scientific consequences |
| **Open question** | Material uncertainty for later experiments or governance |

## Overview of FER formulations

| Formulation | Output | Typical supervision | Main value | Central limitation |
| --- | --- | --- | --- | --- |
| Basic categorical | One of neutral/happy/sad/angry/fear/disgust/surprise, sometimes contempt | Image-level labels | Simple UI and benchmark compatibility | Forces ambiguous or compound expressions into one class |
| Compound or multi-label | Multiple co-occurring expression labels | Multi-rater labels | Better represents mixtures | Scarce, inconsistent labels; harder calibration |
| Valence–arousal | Continuous pleasantness and activation | Continuous ratings | Avoids some rigid class boundaries | Rater disagreement and temporal/context dependence |
| Action units | Presence/intensity of atomic facial movements | FACS coding | Describes observable motion without immediately claiming emotion | Expensive expert annotation; AU-to-emotion mapping remains contextual |
| Temporal affect | Per-frame or sequence-level class/dimensions/AUs | Video annotation | Uses onset, apex, offset, and persistence | More compute, state, annotation cost, and latency |

**Fact.** FER datasets and systems use all of these formulations; AffectNet supports categorical labels and valence/arousal, RAF-DB includes basic and compound expressions, and Aff-Wild2 supports expressions, AUs, and dimensional affect [R09][R10][R11].

**Assumption.** EmotionSense AI’s first research prototype will likely need a bounded output vocabulary plus an explicit “unavailable/uncertain” result, because the PRD requires uncertainty and permits user correction [P01]. This is not a model decision.

**Trade-off.** Categorical outputs are easy to explain and test but can overstate certainty. AUs or dimensions preserve more nuance but increase interpretation, calibration, and UX burden.

**Open question.** Should Version 1 expose expression categories, valence/arousal, selected AUs, or a user-facing abstraction derived from one of these?

## Timeline of major developments

| Period | Development | Significance | Evidence |
| --- | --- | --- | --- |
| 1970s | Facial Action Coding System (FACS) formalizes observable facial muscle actions as AUs | Establishes a descriptive alternative to direct emotion labels | [R02] |
| 1990s | Affective computing becomes a defined interdisciplinary field | Connects sensing, modeling, and human–computer interaction | [R01] |
| 1990s–2000s | Geometric landmarks and appearance descriptors (Gabor, LBP, optical flow) feed SVM, k-NN, HMM, and related classifiers | Works with smaller datasets and interpretable features, but depends heavily on controlled capture and hand engineering | [R03][R04][R06] |
| 2012–2015 | Deep CNN success and FER2013 accelerate learned visual representations | Feature learning replaces many handcrafted pipelines; in-the-wild noise becomes prominent | [R08][R14] |
| 2017–2020 | AffectNet, RAF-DB, Aff-Wild2, and DFEW expand in-the-wild, dimensional, compound, and video evaluation | Increases scale and realism while revealing label, culture, and domain-shift problems | [R09]–[R12] |
| 2017–2021 | MobileNet, ShuffleNet, EfficientNet, BlazeFace, and mobile runtimes mature | Makes multi-stage on-device facial analysis practical on many phones | [R27]–[R33] |
| 2021–2024 | Transformer, cross-attention, landmark-fusion, uncertainty, and open-set FER grow | Improves long-range/local relation modeling and directly studies ambiguity/unknown expressions | [R15][R16][R18][R19] |
| 2022–2026 | Larger dynamic datasets, multimodal models, vision-language pretraining, synthetic data, and unified facial-analysis models expand | Research moves beyond seven-class static FER, but deployment and validity evidence lag benchmark gains | [R13][R17][R20] |

## Traditional approaches versus deep learning

### Traditional pipeline

```mermaid
flowchart LR
  A["Image or video"] --> B["Face detection"]
  B --> C["Landmarks and alignment"]
  C --> D["Handcrafted geometry / LBP / Gabor / optical flow"]
  D --> E["SVM / k-NN / HMM / boosting"]
  E --> F["Expression, AU, or dimension"]
```

Traditional systems separate registration, feature design, feature selection, and classification. Geometry captures landmark displacement; appearance descriptors capture texture changes; temporal methods use optical flow or state models [R03][R04][R06].

### Deep pipeline

Deep systems learn spatial representations end to end from aligned faces or larger crops. CNNs dominate historical deep FER; recurrent units, temporal convolutions, attention, and transformers add sequence or relational modeling [R05][R15][R20]. Transfer learning from large image or face datasets is common when FER labels are limited.

| Dimension | Traditional features | Deep learning |
| --- | --- | --- |
| Data need | Lower, but feature assumptions are strong | Usually higher; pretraining can reduce labeled FER need |
| Robustness | Often brittle outside controlled capture | Better in-distribution capacity, still vulnerable to shift |
| Explainability | Feature construction may be interpretable | Attention or saliency is not automatically causal explanation |
| Mobile cost | Small classical classifiers can be cheap | Backbone and runtime dominate; efficient CNNs can still be practical |
| Maintenance | Many hand-tuned stages | Fewer manual features, but model/data governance is heavier |
| Extensibility | New conditions often require redesign | Fine-tuning and multi-task learning are flexible but can forget or bias |

**Fact.** Deep CNN approaches substantially displaced handcrafted pipelines on modern in-the-wild benchmarks [R05].

**Trade-off.** End-to-end learning can improve task accuracy, but it also entangles dataset biases and makes failure causes harder to isolate.

## CNN-based FER

CNN FER commonly uses a face crop, a backbone such as a residual network, and a classification or regression head. Improvements include local-region branches, attention, multi-scale features, landmark fusion, class-balanced losses, label-distribution learning, and identity disentanglement [R05][R14][R19].

### Why CNNs remain important

- Convolutions encode locality and translation tolerance that fit facial texture and shape.
- Mature mobile families—MobileNet, ShuffleNet, EfficientNet-Lite-style variants, and hardware-searched networks—offer known size/latency controls [R27]–[R31].
- Mobile runtimes and accelerators have broad optimized convolution support [R37][R39].
- CNN feature pyramids and local branches can focus on eyes, brows, nose, and mouth without full global self-attention.

### Limits of CNN FER

- Static frames omit expression dynamics and context.
- Local texture shortcuts can encode identity, age, camera, makeup, or dataset artifacts instead of expression.
- Accuracy on one curated split does not establish cross-dataset, cross-cultural, or mobile-camera validity [R21][R22].
- Larger backbones may fit benchmarks but exceed sustained mobile thermal or memory budgets.

**Fact.** Lightweight CNN families are explicitly designed around mobile latency, parameter, and memory constraints [R27]–[R31].

**Assumption.** At least one small CNN should be included as a benchmark control in the next milestone; this is an evaluation baseline, not a recommendation.

**Open question.** Does a face-pretrained backbone improve cross-dataset FER enough to justify licensing, provenance, and representation-bias risks?

## Transformer-based FER

Vision transformers divide images into tokens and model interactions through attention. FER-specific designs often add convolutional stems, multi-scale windows, local-patch selection, landmark tokens, or cross-attention because small facial regions carry discriminative movements [R15][R16]. Unified models such as FaceXFormer explore sharing a backbone across landmarks, pose, expression, and other facial tasks [R17].

### Evidence and interpretation

- TransFER targets diverse local facial patches and their relations [R15].
- POSTER fuses landmark and image features at multiple scales and reports strong results on RAF-DB, FERPlus, and AffectNet [R16].
- FaceXFormer demonstrates that a transformer can unify multiple face-analysis tasks and reports real-time throughput in its stated evaluation environment [R17].

These are **benchmark facts**, not proof of mobile suitability or of internal-emotion validity. Hardware, preprocessing, dataset splits, parameter counts, and metrics differ, so paper-level percentages should not be compared as if they came from one controlled experiment.

| Benefit | Cost or risk |
| --- | --- |
| Models long-range relations between facial regions | Attention can increase memory traffic and latency |
| Flexible fusion of landmarks, image, audio, or text | More modalities expand consent and privacy scope |
| Benefits from large-scale pretraining | Pretraining provenance and domain bias may be unclear |
| Can share representations across tasks | Negative transfer and unwanted sensitive-attribute learning are possible |

**Trade-off.** Transformers and hybrids may improve benchmark accuracy and robustness, while lightweight CNNs usually offer a simpler path to predictable edge deployment.

**Open question.** Can a compact or hybrid transformer survive conversion, quantization, operator support, and sustained-device tests without losing calibration or subgroup quality?

## Mobile FER research

Mobile FER is typically a cascade rather than one monolithic model: camera acquisition, orientation/color conversion, face detection or tracking, quality gating, alignment/crop, expression inference, temporal smoothing, and uncertainty handling. BlazeFace and MediaPipe exemplify mobile-optimized detection and landmark stages [R32][R35][R36].

Research and official guidance converge on several techniques:

- use a mobile-efficient backbone and small input crop;
- detect intermittently and track between detections where validated;
- keep only the newest frame to avoid queue-driven latency;
- reduce inference cadence independently from preview frame rate;
- quantize only after measuring quality and operator compatibility;
- benchmark warm-up, steady-state latency, memory, and accelerators on physical devices [R37]–[R40].

The [Mobile FER Overview](MOBILE_FER_OVERVIEW.md) expands this pipeline without selecting a model.

**Fact.** Google reports its current short-range MediaPipe Face Detector pipeline at 2.94 ms CPU and 7.41 ms GPU on Pixel 6, while the original BlazeFace paper reported much higher detector-only throughput on then-flagship mobile GPUs [R32][R35]. These numbers are detector-specific and not end-to-end FER performance.

**Assumption.** A useful reflection experience probably needs responsive feedback rather than classification of every camera frame.

**Trade-off.** Lower inference frequency saves energy and heat but can miss brief expressions and increases temporal aliasing.

## Current state of the field

1. **Static in-the-wild classification is mature as a benchmark task, not as solved human-state inference.** Strong models perform well on standard splits, yet labels and constructs remain ambiguous [R07][R09][R10].
2. **CNNs are the deployment workhorse; transformers and hybrids are research leaders.** The boundary is shifting as compact attention and better mobile runtimes emerge [R15]–[R17][R27]–[R31].
3. **The field is moving beyond seven closed classes.** Compound/multi-label, valence–arousal, AUs, open-set rejection, and label distributions address real ambiguity [R09][R10][R18][R19].
4. **Temporal and multimodal methods are growing.** Video datasets and ABAW-style tasks reward dynamics and contextual signals [R11]–[R13][R20].
5. **Generalization remains a core weakness.** Cross-dataset shifts in capture, demographics, culture, labels, and context can dominate architecture gains [R21]–[R23].
6. **Confidence is not automatically trustworthy.** Neural softmax scores can be miscalibrated, especially under shift; calibration and out-of-distribution evaluation must be separate release evidence [R24]–[R26].

## Key research trends

| Trend | Motivation | Relevance to EmotionSense AI | Caution |
| --- | --- | --- | --- |
| Label distributions / soft labels | Preserve annotator disagreement | Supports uncertainty-aware UX | More complex targets and metrics |
| Open-set and abstention | Reject unknown/compound/poor-quality inputs | Required by PRD “unavailable” state | Thresholds can vary by subgroup and condition |
| Temporal modeling | Use onset, motion, persistence | May stabilize frame noise | Adds compute, buffering, lifecycle state |
| Multi-task face analysis | Share pose, landmarks, AUs, quality | Could reuse representations | May learn or expose unnecessary attributes |
| Self-supervised/foundation pretraining | Reduce FER label dependence | Potential generalization gains | Size, provenance, bias, and mobile conversion |
| Synthetic augmentation | Cover rare poses/occlusions/classes | May improve coverage without new real faces | Simulation bias; cannot substitute for real validation |
| Fairness-aware training | Reduce subgroup disparities | Directly tied to safety gates | Demographic labels are sensitive and socially constructed |
| Compression-aware training | Preserve accuracy under INT8/sparsity | Enables edge operation | Must re-check calibration and slices after optimization |

## Open challenges

- **Construct validity:** facial movement alone is insufficient to determine a person’s internal emotional state [R07].
- **Annotation ambiguity:** raters disagree, and forced single labels discard mixtures and uncertainty [R09][R10][R19].
- **Domain shift:** benchmark, camera, geography, culture, and user context differ from deployment [R21][R23][R25].
- **Fairness:** aggregate accuracy can hide unequal error, abstention, or calibration rates [R22].
- **Open-world inputs:** real expressions include unknown, compound, subtle, and intentionally posed behavior [R18].
- **Temporal ground truth:** frame labels may not align with expression onset/apex/offset or self-reported experience.
- **Edge constraints:** sustained heat, energy, memory copies, camera conversion, and delegate fragmentation are underreported in FER papers.
- **Evaluation leakage:** identity overlap, duplicate web images, and preprocessing differences can inflate results.
- **Explainability:** saliency may show correlated pixels but does not justify an emotion claim.

## Future directions

- Treat abstention and calibrated uncertainty as primary outputs, not post-processing.
- Evaluate cross-dataset and deployment-domain transfer before optimizing in-domain accuracy.
- Compare categorical, multi-label, dimensional, and AU representations with user comprehension.
- Study personalized baselines that remain local and do not encode identity templates unnecessarily.
- Use temporal evidence with bounded buffers and adaptive sampling.
- Co-design model, camera pipeline, and mobile scheduler against energy and thermal budgets.
- Publish model cards with data provenance, slice metrics, calibration, failure conditions, and rollback criteria.
- Prefer language such as “facial expression estimate” and pair it with user correction or rejection.

## Project-specific synthesis

### Facts

- No cited model establishes reliable access to a person’s true internal emotion from a face alone [R07].
- Standard benchmark gains do not remove dataset bias, culture, calibration, or domain-shift concerns [R21]–[R25].
- On-device pipelines are technically feasible, but full FER performance must be measured as a cascade on target devices [R32][R35]–[R40].

### Assumptions

- Version 1 will analyze one consenting adult using the front camera in a foreground, time-bounded flow [P01].
- Raw frames will remain transient and no network will be required [P01][P02].
- TensorFlow Lite/LiteRT executes the approved classifier and MediaPipe supplies only validated detection, landmarks, or preprocessing [P01][P02].

### Trade-offs

- Expression categories improve usability but risk false concreteness.
- AUs improve descriptive validity but require an additional, governed interpretation layer.
- Temporal models improve stability but increase power, state, and privacy surface.
- Larger hybrid/transformer models may improve benchmark quality but threaten device coverage and maintainability.

### Open questions

- What is the narrowest scientifically defensible Version 1 claim?
- Which datasets, licenses, demographic annotations, and consent histories are acceptable?
- Which evaluation protocol best represents intended users, devices, lighting, cultures, and camera distances?
- What calibration and abstention metrics gate release?
- Does temporal modeling deliver enough benefit per joule and per millisecond?
- What evidence is required before any output is shown rather than “unavailable”?

## Related project documents

- [Existing Solutions](EXISTING_SOLUTIONS.md)
- [Technical Limitations](TECHNICAL_LIMITATIONS.md)
- [Research Gaps](RESEARCH_GAPS.md)
- [Mobile FER Overview](MOBILE_FER_OVERVIEW.md)
- [References](REFERENCES.md)
