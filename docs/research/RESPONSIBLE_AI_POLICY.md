# Responsible AI Policy

**Milestone:** 1.4 — Privacy & Ethics  
**Research snapshot:** 2026-08-04  
**Policy owner:** To be assigned before implementation  
**Related:** [Privacy and Ethics](PRIVACY_AND_ETHICS.md) · [Fairness and Limitations](FAIRNESS_AND_LIMITATIONS.md) · [Risk Assessment](RISK_ASSESSMENT.md)

## Policy statement

EmotionSense AI may provide a low-stakes estimate of a consenting user's **visible facial expression**. It must not present an inference as the person's true emotion, mental state, intent, honesty, personality, diagnosis, or future behavior. Human dignity, autonomy, privacy, and the ability to decline take priority over coverage, engagement, or persuasive product claims.

This policy adopts the lifecycle risk-management direction of the NIST AI RMF, OECD AI Principles, and UNESCO Recommendation on the Ethics of AI [E01], [E03], [E05].

It is also consistent with the publicly stated industry themes of fairness, reliability/safety, privacy/security, inclusiveness, transparency, accountability, human oversight, and rigorous testing [E20], [E21]. These references are guidance, not a claim of vendor endorsement or conformance.

## Intended purpose and users

### Intended purpose

- voluntary personal reflection about visible facial display;
- an educational demonstration of on-device machine-learning uncertainty; and
- accessibility-support exploration only after research with affected users demonstrates benefit and does not encourage stereotyping or replace direct communication.

### Intended users and environment

- capable adults using their own front-facing camera;
- one actively participating person in a foreground, user-started session;
- low-stakes, private contexts where an incorrect or unavailable result causes no consequential loss; and
- supported devices and capture conditions documented in the model/release card.

The product is not designed for passive observation or evaluation of another person.

## Appropriate use

Appropriate use requires all of the following:

1. the subject understands the system is active and voluntarily participates;
2. the result is interpreted only as a fallible label for visible facial appearance;
3. an unavailable or uncertain result is acceptable;
4. no right, opportunity, service, punishment, diagnosis, or safety intervention depends on the output;
5. the result is not retained, shared, or used to profile the person; and
6. direct human communication remains the preferred way to understand how someone feels.

Examples include privately exploring how camera conditions affect a demo or using the feature as a conversation prompt about the limitations of AI.

## Inappropriate and unsupported use

The following are prohibited product uses and must not be enabled, marketed, optimized, or contractually authorized:

- employment, worker monitoring, productivity, hiring, discipline, or workplace wellbeing inference;
- education admissions, assessment, attention monitoring, discipline, proctoring, or student profiling;
- medical, mental-health, disability, pain, suicide-risk, neurodivergence, or therapeutic diagnosis, screening, triage, or treatment;
- law enforcement, policing, criminal-risk assessment, border control, immigration, detention, military targeting, or interrogation;
- truthfulness, deception, intent, threat, aggression, trustworthiness, guilt, consent, or personality inference;
- credit, insurance, housing, benefits, pricing, eligibility, identity/access control, or other consequential decisions;
- surveillance, public-space monitoring, crowd analytics, covert analysis, or analysis of recorded media without specific consent;
- advertising, political persuasion, manipulation, engagement optimization, or price discrimination based on inferred expression;
- biometric identification, face recognition, tracking, sensitive-trait inference, or creation of face templates;
- child, student, patient, employee, detainee, intimate-partner, or dependent-person monitoring;
- use as evidence about what a person felt or intended; and
- safety-critical control of vehicles, machinery, alarms, or emergency response.

The EU AI Act prohibits certain emotion inference in workplaces and education institutions; its treatment also distinguishes mere visible-expression detection from use to infer emotions [E09]. EmotionSense AI's prohibition is broader: it applies regardless of jurisdiction and cannot be bypassed by adding a human reviewer.

## Human oversight

Human oversight means that a person understands the system's limited purpose, can stop it, can disregard the output, and remains accountable for their own actions. It does **not** validate the inference or make a prohibited application safe.

- The app must never trigger an adverse or consequential action.
- Users must be able to challenge, dismiss, or ignore every result.
- The interface must encourage asking the person directly rather than treating the model as an authority.
- Product and model owners must review incidents, disparity evidence, complaints, and changes.
- A named accountable owner must have authority to delay, disable, or withdraw a release.

## Confidence-based abstention

The system must support **abstention** as a normal outcome. A result is shown only when all release-approved gates pass:

1. a valid, single face is present in the supported capture region;
2. minimum input-quality, pose, scale, visibility, and stability criteria pass;
3. the model and preprocessing contract are valid;
4. calibrated confidence/selective-risk criteria pass; and
5. no lifecycle, permission, thermal, or integrity condition makes processing unreliable.

Otherwise the output is **“Expression estimate unavailable”** with actionable, non-blaming guidance where appropriate. The app must not force the highest-scoring class, relabel a raw softmax score as probability that the person feels an emotion, or use color/animation that implies certainty unsupported by calibration. Confidence thresholds must be set on a separate calibration set after mobile optimization and tested by class, demographic/capture slice, and domain [E14], [E15].

The release gate must evaluate risk-versus-coverage and false-high-confidence errors. A high confidence score does not overcome construct ambiguity or prove an internal emotional state.

## Safe failure behavior

| Condition | Required behavior | Prohibited behavior |
|---|---|---|
| No face or multiple faces | Pause; ask for one consenting face | Choose a face silently |
| Low light, pose, occlusion, blur, or small face | Abstain; offer capture guidance | Guess or lower thresholds invisibly |
| Low/ambiguous confidence | Show unavailable/uncertain | Display top class as fact |
| Unsupported device or preprocessing mismatch | Disable inference safely | Continue with unvalidated behavior |
| Model/integrity error | Stop analysis; show neutral error | Fall back to an unversioned model |
| Permission revoked or app backgrounded | Stop capture and clear transient buffers | Continue background capture |
| Thermal/resource pressure | Reduce cadence or stop with disclosure | Quietly change score semantics |
| Unexpected persistence/transmission | Stop affected capability and invoke incident response | Continue while investigating |

Errors must never reveal an image, face crop, tensor, or prior result. Failure messages must not blame a user's appearance, disability, skin tone, culture, or device.

## AI behavior versioning and governance

Every releasable AI behavior is a versioned bundle containing:

- model identifier and cryptographic hash;
- complete training/fine-tuning data lineage and approvals;
- label ontology and user-facing term mapping;
- preprocessing, face-selection, input-quality, temporal, and abstention specifications;
- calibration method, calibration-data version, and thresholds;
- supported device/capture envelope;
- model card, fairness/robustness report, known limitations, and release decision; and
- privacy/transparency notice version.

A change to any item above is an AI behavior change. Material changes require regression, calibration, fairness, privacy, and misuse review; updated documentation; semantic versioning; and user-facing release notes. Thresholds and labels must not be silently tuned after release. Rollback or deactivation must be possible when safety, privacy, fairness, legal, or integrity evidence deteriorates.

## Release and maintenance gates

A release requires documented approval that:

- the intended use and unsupported-use language are consistent across UI, store listing, privacy notice, and marketing;
- target-domain evidence supports the claimed operating envelope;
- predeclared accuracy, calibration, selective-risk, coverage, robustness, and disparity criteria pass;
- security, privacy, accessibility, and legal reviews have no unresolved release-blocking findings;
- model/dataset cards and lineage are complete;
- incident, rollback, user-feedback, and end-of-life owners exist; and
- no third-party component changes the local-only data flow.

Post-release review must be based on privacy-preserving channels such as voluntary textual issue reports and controlled, consented evaluation—not silent collection of production camera data.

## Decision record

### Facts

- OECD principles call for transparency, lifecycle risk management, traceability, robustness, and accountability [E03], [E04].
- Calibration can improve in-domain confidence estimates, while uncertainty can degrade under dataset shift [E14], [E15].
- Workplace and education emotion inference are specifically restricted under the EU AI Act [E09].

### Assumptions

- The first release is a low-stakes, self-use experience for adults.
- The model can expose a stable score suitable for post-optimization calibration and selective evaluation.
- No business requirement depends on maximizing the number of classified frames.

### Trade-offs

- Abstention reduces feature availability but limits confident errors.
- Narrow intended use reduces market breadth but makes claims more scientifically and ethically defensible.
- Versioned thresholds add release work but make behavior auditable and rollback feasible.

### Constraints

- An output is never evidence of internal emotion or intent.
- Unsupported high-risk uses remain prohibited even with consent or human review.
- Core behavior must remain local-only, interruptible, and non-persistent.
- A release cannot proceed without an accountable owner and documented evidence.

### Open questions

- What exact launch ontology and user-facing terms minimize anthropomorphic interpretation?
- What maximum selective risk, false-high-confidence rate, subgroup disparity, and minimum coverage will govern release?
- Which role can stop shipment and approve rollback?
- What misuse-reporting and remediation channel can operate without creating unnecessary personal data?
- Should the product include any accessibility claim before participatory research is complete?
