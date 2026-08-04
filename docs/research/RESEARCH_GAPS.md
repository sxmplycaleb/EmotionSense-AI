# Research Gaps and Validation Questions

## Document control

| Field | Value |
| --- | --- |
| Milestone | 1.0 — Technical Discovery & Validation |
| Research snapshot | 2026-08-04 |
| Purpose | Convert unresolved FER questions into future evidence work |
| Scope boundary | Research planning only; no model or architecture recommendation |

See the [Literature Review](FER_LITERATURE_REVIEW.md), [Technical Limitations](TECHNICAL_LIMITATIONS.md), [Mobile FER Overview](MOBILE_FER_OVERVIEW.md), and [References](REFERENCES.md).

## Prioritization method

Gaps are ranked by potential user harm, claim validity, privacy, and ability to invalidate the Version 1 concept before implementation effort. Priority is a project assessment, not a statement of academic importance.

| Priority | Meaning |
| --- | --- |
| P0 | Must be resolved before approving a user-facing FER claim |
| P1 | Must be resolved before model/runtime architecture selection |
| P2 | Important for alpha/beta design or later capability |

## Gap register

| ID | Gap | Priority | Why existing evidence is insufficient | Minimum future evidence |
| --- | --- | --- | --- | --- |
| RG-01 | Claim and construct validity | P0 | Facial movements do not universally identify internal emotion [R07] | Approved claim taxonomy; user comprehension; stop criteria |
| RG-02 | Cross-cultural recognition | P0 | Dataset and annotator culture alter distributions and labels [R21][R23] | Target-market, multi-rater evaluation with cultural/context metadata |
| RG-03 | Fairness and intersectionality | P0 | Aggregate results hide subgroup error and abstention disparities [R22] | Predefined slices, confidence intervals, calibration and selective-risk metrics |
| RG-04 | Confidence and abstention | P0 | Softmax confidence is often miscalibrated and degrades under shift [R24][R25] | Calibrated thresholds, coverage-risk curves, false-high-confidence analysis |
| RG-05 | Target-domain generalization | P0 | Standard splits do not represent intended phones, users, or capture flow [R21] | Locked target-domain test set and cross-dataset results |
| RG-06 | Output representation / multi-label | P1 | Seven classes force mixtures and unknowns [R10][R18][R19] | Compare categorical, soft-label, multi-label, dimensional, and AU options |
| RG-07 | Temporal modeling | P1 | Video helps dynamics but adds compute/state; mobile benefit is unclear [R11]–[R13] | Same-backbone frame vs bounded-sequence ablation on devices |
| RG-08 | Personalized FER | P1 | Person-specific baselines may help but can overfit and create biometric/privacy risks | Local-only protocol, threat model, cold-start/fallback evaluation |
| RG-09 | Edge performance envelope | P1 | FER papers rarely report sustained end-to-end phone energy/thermal behavior | Physical device matrix; cold/warm/sustained latency, memory, energy, heat |
| RG-10 | Preprocessing choice | P1 | Detection, landmarks, alignment, and crop can dominate errors | Controlled detector/alignment/crop ablation and parity tests |
| RG-11 | Compression robustness | P1 | Quantization can alter minority classes, logits, and calibration | FP32/FP16/INT8 paired quality, calibration, slice, and device benchmarks |
| RG-12 | Explainability | P2 | Saliency is not causal or necessarily understandable | User-tested explanations tied to actionable input limitations |
| RG-13 | Synthetic data | P2 | Synthetic coverage may encode generator bias | Provenance, real-only test results, artifact and subgroup analysis |
| RG-14 | Multimodal fusion | P2 | Audio/text/context may help but expands consent and privacy scope [R20] | Separate product approval and modality-value/privacy study |

## RG-01 — Claim and construct validity

### Facts

Facial movements are context-sensitive and do not provide a universal, one-to-one readout of internal emotional state [R07]. Commercial AWS documentation makes the same operational distinction [R48].

### Assumptions

EmotionSense AI can still offer value as a reflection aid if it uses cautious expression language and user context takes precedence [P01].

### Trade-offs

- Narrow “facial expression estimate” claims are more defensible but may feel less marketable.
- Richer emotion language may improve immediate comprehension while increasing over-trust and harm.

### Open questions / study design

- Which exact phrases do users interpret as uncertain observation rather than mind-reading?
- Should the model output be hidden until the user first self-reports?
- What evidence would cause the team to remove FER from Version 1?

## RG-02 — Cross-cultural emotion recognition

### Facts

Dataset source and annotation culture create measurable domain differences, and observer culture affects interpretation [R21][R23]. Most standard benchmarks do not document enough deployment-relevant cultural context.

### Assumptions

East African and other intended launch populations need direct representation in validation; benchmark ethnicity labels alone are inadequate.

### Trade-offs

- Local recruitment improves relevance but increases governance, cost, and risk of small identifiable cohorts.
- A globally broad dataset improves coverage but may hide region-specific failures in aggregate.

### Open questions / study design

- Compare self-report, culturally matched raters, and diverse external raters without declaring one universal ground truth.
- Measure cross-cultural calibration and abstention, not only accuracy.
- Test whether model errors correlate with expression style, language/speech movement, lighting, or camera rather than broad demographic labels.

## RG-03 — Fairness

### Facts

FER datasets were generally not collected for balanced demographic fairness, and standard augmentation alone may not remove disparities [R22]. Fairness includes error, calibration, coverage, and user experience—not only equal sample counts.

### Assumptions

The project will define unacceptable disparity before viewing final test results, avoiding threshold selection that rationalizes observed gaps.

### Trade-offs

- Group-specific calibration may improve reliability but requires sensitive attributes and can encode different treatment.
- A single global threshold is simpler but may yield unequal false-high-confidence and unavailable rates.

### Open questions / study design

- Which fairness definitions match a low-stakes reflection tool?
- How should intersectional results be reported when samples are small?
- What minimum coverage and maximum disparity trigger model rejection?

## RG-04 — Confidence estimation and abstention

### Facts

Modern neural networks may be miscalibrated; post-hoc temperature scaling helps some in-domain settings, while uncertainty quality can deteriorate under shift [R24][R25]. Open-set FER explicitly studies expressions outside the known class set [R18].

### Assumptions

Multiple gates—capture quality, pose/visibility, model uncertainty, open-set/OOD, and temporal consistency—will be more reliable than one maximum-score threshold.

### Trade-offs

- Ensembles or Bayesian approximations can improve uncertainty evidence but multiply memory and latency.
- Simple post-hoc calibration is cheap but may not detect unknown expressions or shifted cameras.

### Open questions / study design

- Compare temperature scaling, label-distribution approaches, deep ensembles, test-time augmentation, and energy/open-set scores under an identical mobile budget.
- Report coverage–risk and false-high-confidence rates by condition and subgroup.
- Recalibrate after every model, preprocessing, or quantization change.

## RG-05 — Personalized FER

### Facts

Between-person variation in facial morphology and expression style contributes to intra-class variance [R05][R07]. A generic model can confuse identity-related cues with expression.

### Assumptions

A local neutral or personal baseline might improve within-user sensitivity, but storing a persistent face embedding is not authorized and may be unnecessary.

### Trade-offs

- Personalization could improve relevance and fairness for frequent users.
- It creates cold-start, drift, deletion, poisoning, explainability, and biometric-linkability risks.

### Open questions / study design

- Can session-only normalization improve results without persistent identity features?
- What happens when appearance changes through glasses, facial hair, illness, makeup, or aging?
- How is personalization fully deleted and audited?

## RG-06 — Multi-label and dimensional prediction

### Facts

RAF-DB contains compound expressions; AffectNet includes valence/arousal; uncertainty-aware label-distribution and open-set methods challenge forced single labels [R09][R10][R18][R19].

### Assumptions

The product might internally retain a distribution while displaying simpler, uncertainty-aware language.

### Trade-offs

- Multi-label/dimensional outputs represent ambiguity better.
- They complicate annotation, calibration, longitudinal summaries, localization, and user comprehension.

### Open questions / study design

- Compare top-1, top-k distribution, multi-label, valence–arousal, and AU descriptions in both model quality and user interpretation.
- Determine whether “mixed/unclear” is a learned output, a thresholded state, or both.

## RG-07 — Temporal modeling

### Facts

Expressions unfold over time, and datasets such as Aff-Wild2, DFEW, and FERV39k support temporal research [R11]–[R13]. Sequence models can use motion and persistence unavailable to a static frame.

### Assumptions

A short bounded window may stabilize estimates without retaining raw video.

### Trade-offs

- Temporal evidence can reject transient noise and capture dynamics.
- It adds latency, buffering, state reset, missed-frame behavior, and energy cost.

### Open questions / study design

- Compare exponential score smoothing, feature aggregation, temporal convolution, recurrent, and compact transformer approaches.
- Measure benefit per millisecond and joule, not only accuracy.
- Define how state resets after face loss, app pause, or a different face entering frame.

## RG-08 — Explainability

### Facts

Attention and saliency indicate model sensitivity, not causal proof that a facial region establishes emotion. Explanations can increase unwarranted trust.

### Assumptions

Operational explanations—“face turned away,” “image too dark,” “estimate uncertain”—may be more useful and honest than heatmaps.

### Trade-offs

- Technical explanations support debugging and audit.
- User-facing visual attribution can expose sensitive imagery and falsely legitimize the result.

### Open questions / study design

- Which explanations improve correction and reduce over-trust?
- Can the system explain abstention using measured quality factors without exposing model internals or images?

## RG-09 — Edge-device limitations

### Facts

Mobile hardware, delegates, thermal states, and cameras vary; official guidance requires device-specific measurement [R37][R38]. Published detector or model latency is not full-pipeline performance.

### Assumptions

The first supported matrix will need explicit baseline devices and may use different cadence while preserving identical output semantics.

### Trade-offs

- One small universal model simplifies validation.
- Multiple models/tiers can improve device coverage but multiply quality, packaging, and rollback evidence.

### Open questions / study design

- What are the oldest/lowest devices consistent with acceptable quality and energy?
- Which delegates are reliable for every operator and precision?
- How does performance change after 1, 5, 10, and 15 minutes and during charging?

## Proposed discovery studies

| Study | Inputs | Measures | Decision unlocked |
| --- | --- | --- | --- |
| Construct/UX study | Expression estimates, self-report, alternative wording | Comprehension, over-trust, correction, usefulness | Claim boundary and output contract |
| Dataset audit | Candidate datasets and licenses | Provenance, consent, duplicates, ontology, demographics, restrictions | Approved evaluation/training sources |
| Cross-domain benchmark | At least two public datasets plus locked target-domain set | Macro-F1/UAR, per-class and slice metrics, calibration, coverage-risk | Feasibility and stop/go |
| Pipeline ablation | Detector-only crop, landmarks/alignment, mesh/blendshape features | Quality, latency, memory, energy | Preprocessing responsibility ADR |
| Compression study | FP32/FP16/dynamic/INT8 candidates | Accuracy, calibration, slice drift, size, delegate coverage | Precision/model packaging ADR |
| Temporal study | Static, smoothing, bounded sequence methods | Stability, onset delay, quality, joules/session | Temporal scope ADR |
| Sustained mobile benchmark | Baseline/mid/high Android and iOS devices | End-to-end p50/p95, memory, battery, thermal, dropped/UI frames | Device and performance-budget ADR |

## Stop criteria

Technical discovery should recommend removing or narrowing FER if any of the following persists after reasonable mitigation:

- users interpret outputs as objective internal emotion despite tested communication;
- target-domain accepted-result quality or calibration is inadequate;
- subgroup disparities exceed predeclared limits;
- safe thresholds cause insufficient useful coverage;
- physical-device energy/thermal behavior violates approved budgets;
- acceptable data provenance, licensing, consent, or deletion controls cannot be established;
- offline operation requires unsupported or unmaintainable runtime behavior.

## Project-wide evidence summary

### Facts

- The most important gaps concern validity, generalization, fairness, and uncertainty—not only model architecture.
- Mobile feasibility must be demonstrated with an end-to-end pipeline on physical devices.

### Assumptions

- A narrowly framed, user-correctable expression estimate may be feasible, but this remains unvalidated.
- Target-domain data collection can be governed independently of product capture.

### Trade-offs

- Earlier stop criteria can save implementation effort but may narrow product scope.
- Richer evaluation improves confidence but requires sensitive data and substantial governance.

### Open questions

- Who owns each study and approves its protocol?
- Which metrics and thresholds are predeclared before experiments?
- What independent ethics, privacy, accessibility, and cultural review is required?
- Which findings trigger an ADR, a PRD change, or termination of the feature?

## Related documents

- [FER Literature Review](FER_LITERATURE_REVIEW.md)
- [Existing Solutions](EXISTING_SOLUTIONS.md)
- [Technical Limitations](TECHNICAL_LIMITATIONS.md)
- [Mobile FER Overview](MOBILE_FER_OVERVIEW.md)
- [References](REFERENCES.md)
