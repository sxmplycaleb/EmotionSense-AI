# ADR-0008: Confidence and Abstention

- Date: 2026-08-04
- Owners: ML, Responsible AI, and UX leads
- Decision scope: Confidence policy, abstention, calibration, and messaging

## Status

Accepted

## Context

Raw softmax scores are not calibrated probabilities, and camera quality, domain shift, model optimization, and temporal correlation can produce confident errors. Forcing a top class conflicts with the product's claim boundary.

## Decision

Abstention is a first-class successful outcome. A label may be displayed only when all of these gates pass: one eligible face, approved input quality and operating envelope, valid model/preprocessing contract, fresh result, calibrated classifier threshold, and temporal-consistency policy.

Threshold policy is fixed as follows:

- fit calibration only after model, quantization, preprocessing, and target runtime are fixed;
- use an identity-disjoint calibration split that is separate from training, model selection, threshold selection leakage, and final test data;
- derive global or class-specific thresholds from predeclared selective-risk objectives rather than an arbitrary softmax cutoff;
- do not select runtime thresholds using protected attributes; any exception requires a new ethical and legal review;
- require minimum eligible-frame coverage of 50%, non-abstained accuracy of 80%, selective macro F1 of 0.72, and high-confidence error rate no greater than 10% for release, with slice and uncertainty reporting; and
- reset confidence/temporal state on face loss, multiple faces, stale input, lifecycle change, permission loss, rotation, model change, or runtime failure.

Unavailable states must be typed: no/multiple faces, input quality, uncertain classification, stale result, unsupported device, thermal/resource limit, permission, or runtime/integrity failure. The user sees neutral guidance such as “Expression estimate unavailable” or “The app is not confident enough to show a label.” Confidence, if shown after usability approval, describes confidence in the visible-expression label—not probability of an internal emotion.

## Alternatives Considered

- **Always show the maximum score:** rejected because it fabricates certainty.
- **Universal 0.5 cutoff:** rejected because it lacks empirical and class-specific justification.
- **Detector confidence as expression confidence:** rejected because detection and classification answer different questions.
- **No confidence display but internal abstention:** viable default for Version 1; numerical display remains deferred pending comprehension evidence.

## Consequences

- Coverage is intentionally lower, and fairness evaluation must treat uneven abstention as an outcome.
- Calibration and thresholds become versioned parts of the AI behavior bundle.
- Threshold changes require regression testing and updated evidence; they cannot be tuned silently in production.
- Failure messaging and tests require more states than a forced-label design.

## Evidence Classification

- **Facts:** calibration can improve in-domain confidence but can degrade under shift; softmax alone is insufficient.
- **Assumptions:** target data can support class and slice estimates with meaningful confidence intervals.
- **Trade-offs:** lower coverage is accepted to reduce false-high-confidence results.
- **Constraints:** no forced prediction and no confidence claim about internal emotion.
- **Open Questions:** final fitted thresholds, temporal window, confidence-display design, and disparity limit require Phase 2 evidence.

## References

- [Performance Targets](../research/PERFORMANCE_TARGETS.md)
- [Fairness and Limitations](../research/FAIRNESS_AND_LIMITATIONS.md)
- [Failure Modes](../research/FAILURE_MODES.md)
- [User Transparency](../research/USER_TRANSPARENCY.md)
