# ADR-0004: FER Claim Boundary

- Date: 2026-08-04
- Owners: Product, Responsible AI, and ML leads
- Decision scope: Product claims and permitted interpretation of model output

## Status

Accepted

## Context

Phase 1 research found that facial movement is observable, but it is not a unique or context-free measurement of an internal emotional state. Dataset labels are observer judgments of visible displays. Confidence and accuracy against those labels cannot close this construct gap.

## Decision

EmotionSense AI will claim only that it produces a fallible **estimate of a visible facial-expression category** for one consenting foreground adult under evaluated conditions.

The application will not claim to detect, know, diagnose, or infer:

- a person's true emotion or mood;
- intent, consent, aggression, dangerousness, or future behavior;
- personality, character, trustworthiness, or suitability;
- truthfulness, deception, guilt, or criminality;
- medical, mental-health, disability, pain, or diagnostic status; or
- identity, protected traits, or other biometric characteristics.

Outputs are low-stakes reflection aids only. They are never evidence and must not drive employment, education, healthcare, policing, insurance, credit, access, safety, or other consequential decisions. User-facing language must use “visible facial expression,” “estimate,” “uncertain,” and “unavailable”; it must not use “emotion reader,” “knows how you feel,” or equivalent claims.

## Alternatives Considered

- **Emotion recognition claim:** rejected because facial appearance does not establish internal state.
- **Broader affect, intent, or personality inference:** rejected for scientific-validity and harm reasons.
- **Medical or deception positioning with disclaimers:** rejected; a disclaimer does not make an unsupported use valid.
- **No expression output:** safer but unnecessary if the narrow, transparent, abstaining claim is maintained.

## Consequences

- Product copy, labels, marketing, model cards, tests, and support material require claims review.
- Accuracy metrics describe agreement with governed expression labels, not emotion-reading accuracy.
- The product must expose uncertainty and permit users to dismiss every result.
- The narrower claim limits integrations and market scope while improving scientific and ethical defensibility.

## Evidence Classification

- **Facts:** construct-validity, cultural, dataset-bias, and domain-shift limitations are documented in Phase 1 research.
- **Assumptions:** Version 1 is adult, self-use, single-face, foreground, and low-stakes.
- **Trade-offs:** narrower claims reduce apparent product breadth but reduce predictable overtrust and harm.
- **Constraints:** no high-stakes or hidden-trait inference is permitted, even with consent or human review.
- **Open Questions:** final launch labels, languages, and comprehension thresholds require user research.

## References

- [FER Literature Review](../research/FER_LITERATURE_REVIEW.md)
- [Fairness and Limitations](../research/FAIRNESS_AND_LIMITATIONS.md)
- [Responsible AI Policy](../research/RESPONSIBLE_AI_POLICY.md)
- [User Transparency](../research/USER_TRANSPARENCY.md)
