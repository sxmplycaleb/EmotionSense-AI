# User Transparency Guidance

**Milestone:** 1.4 — Privacy & Ethics  
**Research snapshot:** 2026-08-04  
**Audience:** Product, UX, accessibility, legal, support, and release reviewers  
**Related:** [Responsible AI Policy](RESPONSIBLE_AI_POLICY.md) · [Fairness and Limitations](FAIRNESS_AND_LIMITATIONS.md)

## Communication objective

Users must understand, before camera access and while interpreting a result, that EmotionSense AI estimates a visible facial-expression category. It does not know how a person actually feels. Transparency must be timely, layered, plain-language, accessible, and consistent across onboarding, permission prompts, the live screen, help, app-store listing, privacy notice, and marketing.

The goal is calibrated trust—not reassurance through vague claims such as “AI-powered,” “private,” “accurate,” or “emotion detection.” OECD guidance calls for meaningful information about capabilities, limitations, AI interaction, and ways to challenge outcomes [E04].

## Required user truths

Every production experience must communicate that:

- the feature uses AI to estimate visible facial expressions;
- a facial expression is not proof of a person's internal emotion, intent, honesty, or health;
- estimates can be wrong or unavailable;
- confidence is model uncertainty about a label under evaluated conditions, not certainty about what the person feels;
- lighting, face angle, distance, motion, occlusion, expression intensity, camera quality, device behavior, and differences between training data and the user can affect results;
- accuracy and unavailability may differ across people and groups;
- frames are processed on the device and, under the baseline policy, are not saved, sent, or used to train the model;
- the user can stop analysis or revoke camera access; and
- results must not be used for important decisions or to judge another person.

## Terminology rules

### Use

- “visible facial expression”
- “estimate” or “model estimate”
- “confidence in this expression label” only if calibration evidence and contextual explanation support it
- “uncertain” and “estimate unavailable”
- “processed on this device”

### Avoid

- “emotion detector,” “emotion reader,” “knows how you feel,” or “true emotion”
- “accuracy” without population, metric, conditions, and version
- “objective,” “unbiased,” “universal,” “human-level,” or “private by nature”
- “neutral person” when the label only means a neutral-looking expression under the model ontology
- “90% happy” or any percentage that users can interpret as probability of inner emotion
- anthropomorphic language suggesting the app understands a person

## Proposed in-app wording

The following is draft content for future product review, not implementation authorization.

### First-use notice

> **About expression estimates**  
> EmotionSense AI uses on-device AI to estimate visible facial expressions. A face alone cannot tell the app how you truly feel, what you intend, or whether you are being truthful. Estimates can be wrong or unavailable and may work differently across people and conditions.  
>  
> Live camera frames and results stay on this device. They are not saved, sent to us, or used to train the model. Use this only for your own low-stakes reflection—not for medical, work, school, safety, legal, or other important decisions.

Suggested actions: **Continue** · **Not now** · **Learn more**. Continuing should lead to a separate just-in-time platform camera request; it must not be treated as agreement to unrelated data use.

### Camera pre-permission notice

> **Camera access is needed while you use this feature.** Frames are processed live on this device and are not saved or sent. You can stop at any time or revoke access in Settings.

Proposed platform purpose string:

> Allow camera access to estimate visible facial expressions on this device. Frames are processed live and are not saved or sent to us.

### Live-screen persistent disclosure

> AI expression estimate · On-device · Not a measure of true emotion

The screen must also visibly indicate when the camera is active and provide a one-action stop control.

### Result label

> **Visible expression estimate:** [label]  
> This may be wrong and does not determine how you feel.

If a confidence indicator is eventually approved:

> **Model confidence:** [band]  
> This reflects uncertainty about the visible-expression label under tested conditions—not certainty about your emotion.

Prefer verbal, evaluated bands such as “lower / moderate / higher model confidence” over precise percentages unless user research shows the bands do not mislead.

### Uncertain or unavailable result

> **Expression estimate unavailable**  
> The app is not confident enough to show a label. Lighting, face angle, distance, movement, or obstruction may affect the estimate. You can adjust the camera or stop—no result may simply be the most appropriate result.

If input quality passes but the classifier is uncertain, omit advice that falsely blames camera conditions:

> **Expression estimate uncertain**  
> The visible expression does not support a reliable label. The app will not guess.

### Multiple faces

> **More than one face is visible**  
> This feature is for one consenting person. Analysis is paused.

### Help-page short explanation

> EmotionSense AI compares visual patterns in a live face image with patterns learned from labeled research data. Labels describe how an expression appears to the model; they are observer-derived categories, not direct measurements of feelings. Culture, context, individual expression, disability, camera conditions, and gaps in training data can affect results. Ask people how they feel rather than relying on an estimate.

### Important-use warning

> **Do not use these estimates to make decisions about anyone.** They are not suitable for healthcare, mental health, employment, education, law enforcement, access, insurance, credit, safety, truthfulness, or monitoring.

### Privacy summary

> **What stays private**  
> Live frames, face-derived processing data, and expression results are used temporarily on your device. The app does not save them, send them to the developer, or use them for training. The baseline app has no account, advertising, analytics, or cloud sync. App stores and your device may process installation or operating-system data under their own policies.

## Layering and timing

| Moment | Minimum disclosure |
|---|---|
| Store listing | Visible-expression purpose, local processing, major limitation, unsupported important decisions |
| Before first use | Construct limitation, uncertainty, data handling, intended use, control |
| Before OS permission | Why camera is needed now and what happens to frames |
| During capture | Camera-active state, on-device state, stop control, non-emotion reminder |
| With every result | “Estimate” framing and short limitation |
| On abstention/error | Neutral reason, no fabricated label, safe recovery |
| Help/privacy | Full data inventory, fairness limits, version, deletion, contacts |
| Material update | What changed in model behavior, labels, thresholds, purpose, or data flow |

Do not bury material limitations behind a link or show them only after the first result. Repeated short cues are necessary because a one-time disclaimer cannot correct an authoritative-looking live label.

## Accessibility and comprehension

- Use plain language, short sentences, and translations reviewed by native speakers; avoid translating “expression” into a term that implies verified inner emotion.
- Do not communicate confidence or active capture by color alone; provide text and screen-reader labels.
- Support large text, sufficient contrast, logical focus order, reduced motion, and enough time to read notices.
- Do not require facial movement, eye contact, speech, or a particular expression to consent or navigate.
- Ensure capture guidance does not stigmatize facial difference, paralysis, scarring, tics, masks, assistive devices, or culturally different display.
- Test comprehension with affected and underrepresented users. Measure whether users can state the construct limitation, data flow, uncertainty, and prohibited decisions in their own words.

## Claims and evidence governance

Every numerical or comparative claim must name the model version, test population/domain, sample size, metric, capture conditions, uncertainty interval, and relevant subgroup limitations. Public benchmark accuracy must not be presented as real-world or population-wide performance. Testimonials cannot override model-card evidence.

Marketing, store metadata, screenshots, notifications, and support scripts must pass the same claims review as the app. Material changes to the model, ontology, confidence policy, or data flow require synchronized notice updates and release notes.

## Decision record

### Facts

- Scientific evidence does not support treating facial movements as a context-free readout of specific inner emotions [E13].
- Lighting, pose, occlusion, camera quality, domain shift, and demographic/cultural factors can affect FER performance [E11], [E12].
- Transparency guidance emphasizes informing affected people about capabilities, limitations, and their interaction with AI [E04], [E05].

### Assumptions

- Users may otherwise interpret emotion-like labels and percentages as objective psychological measurement.
- Layered notices can be tested for comprehension before implementation.
- The baseline data flow remains fully on-device with no saved results.

### Trade-offs

- Persistent caveats add visual weight but counter predictable overtrust.
- Verbal confidence bands are less precise than numbers but may reduce false psychological interpretation.
- Detailed store disclosures may reduce adoption while improving informed choice.

### Constraints

- User-facing language must say “visible facial expression,” not verified emotion.
- Limitations must accompany results, not exist only in legal text.
- Consent and camera-active state must be accessible and revocable.
- No claim may exceed version-specific evidence.

### Open questions

- Which expression labels are understandable without implying internal emotion?
- Should confidence be hidden entirely until calibration and comprehension studies justify its display?
- What reading level and languages are required for launch markets?
- What user-research threshold demonstrates adequate understanding of the privacy and construct limitations?
- How will material AI behavior changes be communicated to users who skip release notes?

