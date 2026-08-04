# Fairness and Limitations

**Milestone:** 1.4 — Privacy & Ethics  
**Research snapshot:** 2026-08-04  
**Scope:** Product fairness, construct validity, robustness, calibration, and evaluation  
**Related:** [Technical Limitations](TECHNICAL_LIMITATIONS.md) · [Dataset Governance](DATASET_GOVERNANCE.md) · [Ethics References](ETHICS_REFERENCES.md)

## Fairness objective

EmotionSense AI should not provide systematically worse, more misleading, or more confidently wrong visible-expression estimates for people because of demographic characteristics, culture, disability, facial difference, device affordability, or capture context. Fairness is not established by equal aggregate accuracy or by removing protected attributes from runtime input. It requires evidence about data, construct, errors, calibration, abstention, accessibility, and product impact across the intended population.

This lifecycle view is consistent with ISO/IEC TR 24027's public scope, which covers bias measurement and treatment across data collection, training, design, testing, evaluation, and use [E08].

No evaluation can prove universal fairness. The project must define a narrow launch population and operating envelope, publish uncertainty and gaps, withhold unsupported claims, and abstain when evidence does not support a result.

## Construct limitation

The central limitation precedes model accuracy: visible facial movement is not a unique, context-free measurement of internal emotion. People can display similar movements for different reasons, feel an emotion without a stereotypical display, mask or pose expressions, and interpret displays differently across contexts and cultures [E13], [E22]. Dataset labels are commonly observer judgments or categorical annotations, not verified psychological ground truth.

Therefore:

- output labels describe a model's estimate of visible appearance;
- “neutral” is a model class, not absence of feeling;
- agreement with a dataset label does not validate an internal-state claim;
- confidence cannot resolve the construct gap; and
- evaluation must include human-label ambiguity and must not report “emotion-reading accuracy.”

## Sources of unfairness

### Dataset representation and provenance

Public FER datasets differ in demographic composition, geography, culture, camera source, image quality, pose, expression intensity, staged versus spontaneous behavior, annotation process, label ontology, and licensing/consent provenance. Published audits identify demographic imbalance and dataset-specific bias in FER corpora [E11], [E12], [E23]. Missing demographic metadata is uncertainty, not evidence of balance.

Risks include:

- underrepresentation or stereotyped representation of particular populations;
- labels imposed by annotators from a different cultural context;
- class imbalance and ambiguous examples treated as certain;
- identity or near-duplicate leakage across splits;
- web-sourced images with unclear consent;
- benchmark optimization that overfits a narrow data-generation process; and
- training/evaluation rights incompatible with a distributed model.

Dataset diversity alone does not guarantee fairness. The project must follow [Dataset Governance](DATASET_GOVERNANCE.md), preserve lineage, document unknowns, and test downstream outcomes.

### Demographic and intersectional bias

Performance may vary with age, skin appearance under camera processing, gender expression, geography, facial morphology, facial hair, makeup, head coverings, and intersections of these factors. Protected-attribute categories can themselves be socially contingent, coarse, mislabeled, or harmful. The project must not infer race, ethnicity, gender identity, disability, or other protected traits from a face to fill evaluation gaps.

Where demographic auditing is necessary, use voluntary self-description, purpose-limited consent, “prefer not to say,” strict separation from runtime behavior, minimum sample-size rules, and a separate privacy/ethics review. Report counts and uncertainty; do not publish unstable league tables for small groups.

### Domain shift

A model evaluated on public still-image benchmarks can fail on front-camera video. Shift can arise from device sensor and image processing, geographic population, environment, resolution, compression, mirroring, crop pipeline, pose, occlusion, motion, lighting, app version, and model optimization. Cross-dataset evidence demonstrates that uncertainty and performance can deteriorate outside the training distribution [E11], [E15].

MobileNetV3-Small is the preferred production architecture, but architecture choice does not establish fairness. Quantization, preprocessing, detector behavior, confidence calibration, and thermal cadence can change which users receive results.

### Cultural and contextual variation

Expression production and interpretation are shaped by culture, social setting, display rules, and observer expectations. Studies report cross-cultural/in-group differences in expression interpretation [E22]. Cultural categories must not be encoded as fixed biological properties or used to route individuals through separate runtime models without strong scientific, legal, and ethical justification.

The safest baseline is to narrow claims to visible patterns, avoid psychological interpretation, validate with local stakeholders in intended launch contexts, and disclose that the model may not reflect an individual's way of expressing themselves.

### Accessibility and facial difference

People with facial paralysis, scarring, burns, craniofacial difference, missing or atypical facial movement, tics, tremor, low vision, motor disability, neurodivergence, assistive devices, masks, or religious/cultural coverings may be excluded or mischaracterized. Requiring eye contact, stereotypical expression, steady hand-held positioning, or visual interpretation can create access barriers.

The product must:

- never diagnose a condition from a failure or expression;
- provide non-visual and non-color-only controls, status, and limitations;
- permit immediate stop and non-camera navigation;
- avoid language that tells users to make their face look “normal”;
- treat repeated unavailability as a system limitation, not user failure; and
- conduct participatory accessibility research before claiming accessibility benefit.

### Device and socioeconomic fairness

Lower-cost or older devices may have poorer cameras, less compute, more thermal throttling, or different imaging pipelines. If low-resource devices receive more abstentions or confident errors, the system can create socioeconomic quality-of-service disparities. Evaluation must report by supported device tier and camera characteristics, not only flagship devices. Unsupported devices should receive an honest compatibility state rather than degraded undisclosed inference.

## Confidence and calibration

Raw softmax values are not automatically calibrated probabilities. Temperature scaling is a simple post-hoc method that can improve in-domain calibration, but dataset shift can undermine confidence quality [E14], [E15]. Calibration must occur after the final model, quantization, preprocessing, and target runtime are fixed.

Required practices:

- use a calibration set independent of training, model selection, and final test data;
- evaluate reliability diagrams, Brier score or log loss, and ECE with stated binning limitations;
- report classwise and subgroup calibration, not aggregate ECE alone;
- measure selective risk and accuracy/error versus coverage at candidate abstention thresholds;
- measure false-high-confidence errors, including by class and slice;
- combine model confidence with input-quality and operating-envelope gates;
- validate temporal behavior so repeated correlated frames do not create false certainty; and
- display uncertainty as model uncertainty about a visible label, never probability of internal emotion.

A single global threshold is simpler and avoids using protected attributes at runtime, but can create unequal coverage. Slice-specific thresholds may reduce some disparities while encoding or requiring sensitive categories, complicating consent and producing different treatment. The baseline is a global threshold with disparity testing; any alternative needs explicit ethical and legal review.

## Known limitations to disclose

- Facial appearance alone cannot verify internal emotion, intent, honesty, personality, or health.
- Labels simplify continuous, mixed, ambiguous, strategic, and culturally situated behavior.
- Performance can degrade with low/uneven light, strong pose, occlusion, masks, glasses glare, hair, headwear, motion blur, small face size, compression, and camera/image-processing differences.
- Posed expressions and dataset labels may not represent spontaneous everyday behavior.
- Dataset and annotator bias may create demographic, cultural, and intersectional disparities.
- Multiple people, partial faces, presentation attacks, recorded media, and images outside the evaluated envelope are unsupported.
- Calibration is version- and domain-specific; a high score can still be wrong.
- On-device optimization and device conditions can alter results.
- Abstention can be uneven across groups and devices and must itself be treated as a fairness outcome.
- No benchmark result supports medical, employment, education, legal, safety, or other consequential use.

## Evaluation strategy

### 1. Predeclare the target

Before opening the final test set, define intended population, adult/minor boundary, regions/languages, self-use scenario, device tiers, camera distance, pose/lighting/occlusion envelope, label ontology, misuse model, and minimum evidence. Unknown population scope blocks broad fairness claims.

### 2. Govern the evaluation data

Use a locked, consented, target-domain smartphone evaluation corpus with lawful rights and a documented dataset card [E24], [E25]. Keep train, development, calibration, and final test subjects independent. Record capture and voluntary demographic metadata only where ethically justified. Preserve ambiguous/multi-rater labels instead of forcing consensus.

### 3. Report multiple outcome families

| Family | Required measures |
|---|---|
| Utility | Macro F1, unweighted average recall, balanced accuracy, per-class precision/recall, confusion matrix |
| Uncertainty | Reliability diagrams, classwise calibration, Brier/log loss, ECE with caveats |
| Selective behavior | Coverage, selective risk, false-high-confidence rate, abstention rate/reason |
| Robustness | Factorial results for lighting, pose, visibility, face size, motion, device/camera, thermal/session duration |
| Fairness | All above by approved demographic, accessibility, capture, device, and intersectional slices |
| Statistical validity | Sample counts, confidence intervals, predefined minimum n, missingness and suppressed unstable results |

Aggregate metrics never substitute for worst-slice and classwise results. Compare disparities in error, calibration, false-high-confidence rate, and coverage; accuracy parity alone can conceal harmful differences.

### 4. Test generalization and product behavior

- Perform cross-dataset testing without pooling away source differences.
- Evaluate real end-to-end front-camera video after production preprocessing and optimization.
- Test invalid, out-of-distribution, low-quality, multiple-face, and presentation-attack inputs.
- Conduct user studies of label interpretation, overtrust, notice comprehension, and recovery from abstention.
- Evaluate whether guidance or confidence display changes behavior unevenly across literacy, language, disability, or technical familiarity.

### 5. Establish release gates

Before evaluation, governance owners must approve maximum overall and worst-slice error, maximum false-high-confidence rate, minimum calibration quality, minimum and maximum acceptable coverage/abstention, disparity tolerances, and sample-size rules. A small group average cannot offset a critical subgroup harm. If evidence is insufficient, narrow the supported population or do not release.

## Continuous improvement without production surveillance

Continuous improvement means reviewing governed evidence, not continuously collecting faces. Acceptable channels include voluntary text feedback, public issue reports stripped of personal data, scheduled consented studies, device-lab testing, independent audits, and literature/regulatory review. Do not ingest production frames or results silently.

Each new model or threshold requires full regression across the locked suite, an updated model card and fairness report, comparison with the prior version, claims review, and rollback plan. Publish material regressions as well as improvements. Periodically reassess label ontology, intended use, dataset provenance, accessibility, and whether the feature remains justified.

## Decision record

### Facts

- FER datasets exhibit dataset, annotation, and demographic bias [E11], [E12], [E23].
- Cultural context can affect human interpretation of facial expressions [E22].
- Confidence calibration can degrade under distribution shift [E15].

### Assumptions

- A governed target-domain adult smartphone evaluation corpus can be obtained before release.
- Demographic information needed for fairness auditing can be collected separately with meaningful consent and privacy safeguards.
- Abstention is acceptable as a first-class product outcome.

### Trade-offs

- Richer slice metadata enables audits but increases privacy, consent, and re-identification risk.
- Conservative thresholds may reduce confident error while creating unequal or frustrating unavailability.
- Narrow claims and device support improve evidentiary validity but reduce access and reach.
- Global thresholds are simpler; adaptive thresholds may improve some metrics while creating sensitive categorization and unequal-treatment risks.

### Constraints

- Do not infer protected attributes from faces for fairness auditing or runtime routing.
- Do not claim universal, unbiased, or emotion-reading performance.
- Final evaluation must be target-domain, end-to-end, post-optimization, and subject-independent.
- Production camera data cannot become an unconsented improvement dataset.

### Open questions

- What launch population, regions, languages, device tiers, and accessibility contexts are in scope?
- Which demographic and cultural descriptors are locally meaningful, ethically collectible, and statistically viable?
- What numerical disparity, calibration, false-high-confidence, and coverage gates are acceptable?
- How will ambiguous labels and self-reported context be incorporated into evaluation?
- Will minors be excluded, and how will the restriction be enforced without intrusive age data?
- Who will conduct or commission an independent fairness/accessibility audit?
