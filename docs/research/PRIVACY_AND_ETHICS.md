# Privacy and Ethics Framework

**Milestone:** 1.4 — Privacy & Ethics  
**Research snapshot:** 2026-08-04  
**Status:** Normative research guidance; not legal advice  
**Related:** [Responsible AI Policy](RESPONSIBLE_AI_POLICY.md) · [Data Handling Policy](DATA_HANDLING_POLICY.md) · [Ethics References](ETHICS_REFERENCES.md)

## Purpose and policy boundary

EmotionSense AI is a voluntary, offline, personal-use mobile tool that estimates **visible facial-expression categories**. It must not claim to read, detect, diagnose, or verify a person's internal emotion, intent, honesty, character, health, or risk. This boundary reflects scientific evidence that facial movements do not map reliably and universally to specific internal emotions [E13] and the project's privacy-first architecture.

The framework applies to product design, model development, evaluation, release, maintenance, documentation, and any future telemetry proposal. A feature that conflicts with this framework requires a new ethical impact assessment and an approved architecture decision; convenience or user demand alone is insufficient.

## Privacy principles

1. **Local by default and by design.** Camera frames, face crops, tensors, quality signals, and expression estimates remain on the user's device during inference.
2. **Data minimization.** Process only the minimum pixels, derived values, duration, and frequency required for the user-requested session.
3. **Purpose limitation.** Use camera input only to provide the visible-expression feature the user deliberately started. Do not reuse it for identity, profiling, advertising, analytics, model training, or unrelated personalization.
4. **Ephemeral processing.** Keep live inputs and intermediate artifacts in volatile memory only, for no longer than the current inference operation requires.
5. **Meaningful choice.** Camera access and analysis require an informed, affirmative action. Refusal or revocation must be respected without dark patterns.
6. **User control.** The user can start, pause, and stop analysis; see whether analysis is active; revoke permission; and clear any allowed local settings.
7. **No hidden subjects.** Do not analyze bystanders, crowds, surveillance feeds, or a second person's face without that person's informed, freely given participation.
8. **Privacy-preserving defaults.** No account, advertising identifier, cloud service, analytics SDK, network connection, recording, or inference history is required.
9. **Accountability and review.** Document data flows, model lineage, limitations, incidents, and changes. Reassess privacy and ethical risks throughout the lifecycle, consistent with NIST's AI and Privacy Frameworks [E01], [E02].

## Local-only inference

The production architecture must perform camera capture, face localization, preprocessing, classification, calibration, and display on the device. “Offline” means the core experience remains fully usable with network access unavailable. “On-device” is not permission to retain data: local storage, backups, screenshots, clipboard content, inter-app sharing, debug dumps, and OS logs remain disclosure paths.

Any future off-device transfer—including opt-in diagnostics, crash reporting, backup, synchronization, model-improvement samples, or support attachments—is a material policy change. It requires a documented purpose, data inventory, lawful basis, consent analysis, retention/deletion rules, security review, store-disclosure update, and separate opt-in where applicable. It must not be bundled into camera consent.

## Data minimization and retention

- Process one deliberately positioned face at a time within the supported capture envelope.
- Do not create face embeddings, identity templates, voice recordings, contact graphs, location histories, or demographic predictions.
- Do not persist raw frames, video, face crops, landmarks, tensors, per-frame scores, expression histories, or session summaries.
- Do not use user sessions for training, evaluation, threshold tuning, or product analytics.
- Keep only non-personal application assets and minimal local preferences described in [Data Handling Policy](DATA_HANDLING_POLICY.md).
- Treat developer screenshots, screen recordings, memory dumps, test artifacts, and support bundles as potential face data; use synthetic or explicitly consented assets under approved research governance.

The retention period for live camera-derived data is therefore **the shortest technically necessary in-memory lifetime**, ending when the operation completes, the session stops, the app backgrounds, permission is lost, or an error occurs.

## Consent and user control

Consent is a product interaction, not merely an operating-system permission dialog. Before the first analysis, the app must clearly state:

- what it does: estimates visible facial expressions;
- what it does not do: determine true emotions, intent, honesty, or health;
- what it processes: live camera frames on the device;
- what it retains or transmits: no frames or results, and no off-device transfer under the baseline policy;
- material limitations and unsupported uses; and
- how to stop and revoke access.

The camera permission request must be just-in-time, preceded by a plain-language explanation, and issued only after the user selects the expression-analysis feature. Denial must lead to an informative non-camera state, not repeated pressure. Revocation, one-time permission, app backgrounding, and OS privacy indicators must be honored. Android supports one-time camera permission, while Apple requires a camera purpose string explaining the request [E18], [E19].

Consent from the device owner does not establish consent from another person in view. The baseline experience is self-use by a capable adult. Analysis of minors, dependent persons, employees, students, patients, detainees, or others in a power-imbalanced setting is unsupported because consent may not be freely given.

## Camera permission expectations

- Request camera access only while the user is entering or using the feature.
- Show an unambiguous active-analysis indicator in the app in addition to platform indicators.
- Stop camera acquisition promptly when analysis stops, the app leaves the foreground, or permission is revoked.
- Do not request microphone, photo-library, location, contacts, advertising, or background-camera access for expression estimation.
- Explain how to revoke permission in platform settings.
- Keep the permission purpose string specific; do not imply diagnosis or emotion reading.

Proposed purpose wording: **“Allow camera access to estimate visible facial expressions on this device. Frames are processed live and are not saved or sent to us.”** Final platform wording requires legal, UX, and store-policy review.

## Security considerations

- Reduce attack surface by omitting network-dependent SDKs, analytics, advertising, and unnecessary permissions.
- Verify the integrity and provenance of bundled model and calibration assets; prevent silent or unauthorized replacement.
- Exclude image data and inference outputs from logs, crash dumps, traces, backups, notifications, widgets, and support exports.
- Clear or overwrite reusable buffers where practical; never rely on garbage collection as a privacy guarantee.
- Prevent analysis when capture state, lifecycle state, or model integrity is uncertain.
- Maintain a vulnerability-reporting and incident-response path. A privacy incident includes unexpected persistence, transmission, display, or third-party access even if no server exists.
- Test release builds for network traffic and sensitive logging. Review every third-party SDK because app stores treat SDK behavior as the developer's responsibility [E16], [E17].

## Biometric considerations

Facial images and measurements are sensitive even when not used to identify a person. Legal definitions differ by jurisdiction and purpose. Under Kenya's data-protection guidance, photos, video, and biometric information can be personal data, and biometric data is sensitive personal data [E10]. Under the EU AI Act, an “emotion recognition system” infers emotion or intent from biometric data, while mere detection of readily apparent expressions is excluded unless used to infer emotion [E09].

Accordingly:

- Do not market the feature as biometric identification or emotion recognition.
- Do not compare a face against a reference database or retain a reusable template.
- Do not infer protected or sensitive characteristics.
- Treat all camera frames and face-derived artifacts as highly sensitive during processing regardless of whether a narrow statutory definition applies.
- Obtain qualified, market-specific legal review before release; naming the output “expression” is not a compliance shortcut if product behavior or messaging implies internal emotion.

## Compliance considerations

This framework is not a determination of legal status. Before distribution, counsel must map the actual product, publisher, users, age rating, markets, datasets, and data flows against applicable privacy, consumer-protection, biometric, accessibility, child-safety, medical-device, employment, education, and AI laws.

Particular review is required for:

- Kenya's Data Protection Act and ODPC requirements, including sensitive data and possible impact-assessment duties [E10];
- GDPR/ePrivacy and national biometric rules where EU/EEA users are in scope;
- the EU AI Act, which prohibits certain emotion inference in workplaces and education and imposes transparency duties for in-scope systems [E09];
- app-store privacy disclosures: Google Play and Apple state that data processed solely on device is not “collected” for their disclosure definitions, but developers must still provide accurate disclosures and account for SDK behavior [E16], [E17]; and
- jurisdiction-specific rules for children, health claims, biometric information, and automated decisions.

Product policy is intentionally stricter than a minimum-law approach: unsupported high-risk uses remain prohibited even where a jurisdiction might permit them.

## Decision record

### Facts

- NIST frames AI and privacy risks as lifecycle and organizational risks, not accuracy-only issues [E01], [E02].
- Scientific review finds that facial movements alone do not reliably reveal a unique internal emotion across people and contexts [E13].
- Local-only processing reduces off-device exposure but does not remove risks from permissions, local persistence, misuse, bias, or misleading claims.
- Platform privacy declarations depend on the complete behavior of the app and included SDKs [E16], [E17].

### Assumptions

- The initial intended user is a capable adult analyzing their own face for low-stakes personal reflection or demonstration.
- No account, cloud sync, telemetry, advertising, or user-generated dataset is necessary.
- The product will retain the visible-expression terminology and one-face foreground capture envelope established by earlier milestones.

### Trade-offs

- No telemetry limits real-world observability but avoids creating a new data pipeline and preserves the core privacy promise.
- No saved history reduces longitudinal features but prevents accumulation of sensitive behavioral profiles.
- Strict single-user consent narrows use but reduces bystander and power-imbalance harms.
- Conservative abstention reduces result availability but is safer than plausible-looking unsupported output.

### Constraints

- Core inference must remain local-only and work without a network connection.
- Camera-derived data and inference results must not be persisted or transmitted under the baseline design.
- The system must not identify people or infer internal emotion, intent, sensitive traits, or health.
- No feature may silently expand the data flow or intended purpose.

### Open questions

- Which legal entity will be controller/publisher and which launch jurisdictions are approved?
- Will the initial release exclude minors by age rating and policy, and how will that be communicated without collecting birth dates?
- What independent ethics, privacy, accessibility, and legal review is required before beta and store submission?
- Are opt-in crash reports necessary, or can all diagnostics remain user-visible and local?
- What exact UI state proves that capture buffers are released after stop, backgrounding, or error?

