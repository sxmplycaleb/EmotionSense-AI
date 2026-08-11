# Product Requirements

## Document Control

| Field | Value |
| --- | --- |
| Product | EmotionSense AI |
| Status | First draft |
| Audience | Product, engineering, design, data science, security, and quality teams |
| Product phase | Foundation and discovery |
| Last updated | 2026-08-04 |

## 1. Product Summary

EmotionSense AI is an AI-powered emotional reflection platform with a Flutter mobile application as its first client. It helps users observe and reflect on emotional patterns using explicitly consented signals and self-reported context. The first client is privacy-first and offline-first: analysis runs on the device, limiting exposure of sensitive source media and supporting useful behavior without network connectivity.

The product must communicate uncertainty. A model result is an estimate derived from limited signals, not an objective reading of a person's internal emotional state.

## 2. Vision

Enable private, accessible, and responsible emotional self-awareness without presenting machine-learning output as diagnosis, truth, or clinical guidance.

## 3. Problem Statement

People often lack a lightweight way to recognize emotional patterns and connect them with context. Existing approaches may require consistent manual tracking, expose sensitive data to remote services, or overstate what automated emotion inference can determine. EmotionSense AI should reduce reflection friction while preserving agency, privacy, and appropriate skepticism.

## 4. Goals

- Provide an understandable reflection experience based on user-authorized inputs.
- Prefer on-device processing and local storage for sensitive data.
- Make confidence, limitations, consent state, and data controls visible.
- Remain useful when network connectivity is unavailable.
- Establish measurable quality, safety, accessibility, and performance standards.
- Build an architecture that supports independently testable features and replaceable ML components.

## 5. Non-Goals

- Diagnosing, treating, preventing, or monitoring a medical or mental health condition.
- Detecting deception, intent, personality, employability, criminality, or risk posed by a person.
- Performing covert, continuous, or background surveillance.
- Inferring emotion for people who have not provided informed consent.
- Sharing or selling personal or derived emotional data for advertising.
- Providing emergency response or crisis intervention services.
- Guaranteeing that facial, vocal, or behavioral signals reveal internal emotional state.

## 6. Target Users

### Primary user

An adult who wants a private, structured way to reflect on changes in mood and context using a personal mobile device.

### Secondary user

A research or quality participant who has separately consented to a controlled evaluation. Research workflows require their own governance and are not part of the initial consumer release.

### Excluded initial audiences

Children, clinical patients under supervised care, employers assessing workers, schools assessing students, law enforcement, and other high-impact decision makers are outside the initial product scope.

### Persona A — Amina

| Attribute | Description |
| --- | --- |
| Age | 21 |
| Occupation | University student |
| Goals | Reflect on emotional patterns during examinations and understand how academic pressure relates to her self-reported experience. |
| Frustrations | Manual journaling feels time-consuming during stressful periods, and she is wary of sending sensitive information to cloud services. |
| Why EmotionSense AI helps | It offers a brief, private reflection workflow that works offline and lets her correct or dismiss machine-generated interpretations. |

### Persona B — Daniel

| Attribute | Description |
| --- | --- |
| Age | 34 |
| Occupation | Project manager |
| Goals | Monitor emotional trends over time and reflect on patterns associated with workload and routines. |
| Frustrations | Existing tracking tools require too much manual effort or present simplistic conclusions without useful context. |
| Why EmotionSense AI helps | It combines local history with confidence-aware pattern summaries while keeping Daniel in control of interpretation and retention. |

The personas illustrate intended use and do not imply that the platform can determine either person's internal emotional state.

## 7. Stakeholders

| Stakeholder | Responsibilities |
| --- | --- |
| Product Owner | Own product outcomes, scope, requirement priority, acceptance decisions, and alignment between user value and responsible-use constraints. |
| Engineering Team | Design, implement, test, operate, and document the mobile platform while maintaining architecture, performance, reliability, and privacy boundaries. |
| Machine Learning Team | Govern data and model provenance, evaluation, calibration, fairness analysis, runtime integration, limitations, versioning, and rollback evidence. |
| UX/UI Design | Design accessible, understandable workflows that communicate uncertainty, preserve user agency, and avoid manipulative or clinical presentation. |
| Quality Assurance | Maintain risk-based test strategy, requirements traceability, device coverage, release evidence, and independent verification of critical workflows. |
| Security | Lead threat modeling, secure design review, dependency and release security, incident readiness, and verification of sensitive-data protections. |
| Privacy Review | Assess consent, data minimization, retention, deletion, export, telemetry, market obligations, and changes to data-processing purposes. |
| Future Open Source Contributors | Contribute reviewed code, tests, documentation, and evidence while following project governance, licensing, privacy, safety, and architectural standards. |

## 8. Product Principles

1. **Consent before capture:** No camera, microphone, or sensitive analysis begins before a specific user action and platform permission.
2. **Local before remote:** Raw media and derived insights remain on the device by default.
3. **Uncertainty is part of the result:** The interface must expose low confidence and unsupported conditions.
4. **User interpretation leads:** Self-reported context may complement, correct, or reject an inferred label.
5. **Minimum necessary data:** Capture, process, retain, and display only what supports a documented user outcome.
6. **No silent expansion:** New signal types, cloud processing, or data sharing require product, privacy, security, and architectural review.

## 9. Ethical AI Principles

These principles constrain product claims, research, design, model selection, implementation, analytics, and release decisions:

1. **Never present estimates as facts:** Model output reflects limited observable signals and must not be described as a person's true internal state.
2. **Never diagnose mental health conditions:** EmotionSense AI is not a diagnostic, treatment, prevention, or clinical monitoring system.
3. **Never replace qualified professionals:** The platform must not present its output as a substitute for professional medical, mental health, or emergency support.
4. **Never infer hidden traits:** The platform must not infer personality, intent, deception, criminality, employability, dangerousness, or similar hidden or high-impact characteristics.
5. **Never perform surveillance:** Capture and analysis must be explicit, foreground, time-bounded, and initiated by the consenting user.
6. **Always communicate uncertainty:** Unsupported conditions, input limitations, confidence, and model limitations are part of the result, not optional detail.
7. **Respect user autonomy:** Users control whether analysis occurs and may correct, reject, retain, export where supported, or delete their information.
8. **Privacy by default:** Data minimization, on-device processing, local storage, and transient raw media are the default design posture.
9. **Consent before analysis:** Platform permission alone is not informed consent; the product must explain the specific purpose before processing begins.
10. **Human interpretation takes precedence:** A user's reflection, context, correction, or rejection takes precedence over model output.

## 10. Functional Requirements

Priority follows MoSCoW: Must, Should, Could, and Won't for the first production release.

### 10.1 Consent and onboarding

| ID | Priority | Requirement |
| --- | --- | --- |
| FR-001 | Must | Explain the product's purpose, limitations, data use, and non-clinical status before analysis is enabled. |
| FR-002 | Must | Request camera and microphone permissions only in context and only when the associated capability is invoked. |
| FR-003 | Must | Allow consent to be withdrawn without blocking access to deletion and export controls. |
| FR-004 | Must | Store consent version, timestamp, and enabled signal categories locally. |

### 10.2 Capture and analysis

| ID | Priority | Requirement |
| --- | --- | --- |
| FR-010 | Must | Start analysis only after an explicit foreground user action. |
| FR-011 | Must | Process supported signals on device with TensorFlow Lite and MediaPipe pipelines that have passed validation. |
| FR-012 | Must | Stop capture immediately when requested or when the app leaves an allowed lifecycle state. |
| FR-013 | Must | Present an unavailable state when input quality, device capability, or model confidence is insufficient. |
| FR-014 | Must | Avoid retaining raw camera frames or audio by default. |
| FR-015 | Should | Explain common environmental factors that reduce result quality. |

### 10.3 Reflection and history

| ID | Priority | Requirement |
| --- | --- | --- |
| FR-020 | Must | Allow a user to add, edit, and delete a private, user-authored reflection associated with a user-selected timestamp. |
| FR-021 | Must | Allow the user to dismiss any live machine-generated estimate; it must not be accepted, changed, or retained as a record. |
| FR-022 | Must | Show chronological history of user-authored reflections only, without implying expression, emotion, or clinical trends. |
| FR-023 | Must | Summarize only user-authored reflection records over user-selected periods, with clear scope and no inferred-pattern claim. |
| FR-024 | Could | Allow user-defined tags for situations or activities. |

### 10.4 Data control

| ID | Priority | Requirement |
| --- | --- | --- |
| FR-030 | Must | Allow deletion of individual records and all application data. |
| FR-031 | Must | Make retention behavior and stored data categories understandable. |
| FR-032 | Should | Export user-authored records in a documented, portable format only after a separately approved export and storage-protection decision. |
| FR-033 | Must | Prevent application analytics from containing raw media, free-text reflections, or fine-grained inferred emotional labels. |

### 10.5 Reliability and support

| ID | Priority | Requirement |
| --- | --- | --- |
| FR-040 | Must | Provide useful core capture, reflection, history, and deletion behavior without a network connection. |
| FR-041 | Must | Recover safely from interrupted inference or persistence operations. |
| FR-042 | Should | Provide an in-app path to privacy, limitations, licenses, and support information. |

## 11. Non-Functional Requirements

### Performance

- Target smooth user interaction at 60 frames per second on the defined baseline devices.
- Keep expensive preprocessing and inference work off the UI isolate.
- Define model-specific latency, memory, thermal, and package-size budgets before model acceptance.
- Measure cold start, inference latency, dropped frames, battery impact, and storage growth on physical devices.

Initial performance targets are provisional until representative models and supported devices are selected. Final thresholds require an Architecture Decision Record (ADR).

### Privacy and security

- Raw capture data must remain in volatile memory unless the user explicitly chooses a future recording capability.
- Sensitive local records must use platform-supported protections and must not appear in logs, crash reports, screenshots of automated tests, or analytics payloads.
- Secrets must not be bundled in the client application.
- Permissions, model assets, dependencies, and exported files must receive security review.
- Data deletion must include primary records and derived local artifacts under application control.

### Accessibility

- Target WCAG 2.2 Level AA where applicable to mobile software.
- Support screen readers, text scaling, adequate touch targets, sufficient contrast, reduced motion, and non-color status cues.
- Do not rely on facial or vocal capture as the only path to meaningful reflection.

### Quality

- Domain behavior must be unit-testable without Flutter, storage, camera, or model runtimes.
- Critical journeys require integration coverage on supported platforms.
- ML evaluation must report performance across relevant demographic and environmental slices where lawful and ethically sourced data is available.
- A model must have provenance, versioning, limitations, and rollback information before release.

### Observability

- Use structured, redacted diagnostic events.
- Never log raw frames, audio, free text, stable biometric templates, or direct emotional-history content.
- Operational metrics must be aggregated and optional where consent or law requires it.

## 12. Technical Constraints

The following constraints define the Version 1 engineering baseline. Items marked **TBD** are intentionally undecided and require evidence before approval.

| Area | Constraint | Status or budget |
| --- | --- | --- |
| Client platform | Flutter mobile application targeting Android and iOS | Required |
| Architecture | Clean Architecture with inward dependency direction and independently testable domain behavior | Required |
| State management | Riverpod for dependency composition and reactive presentation state | Required |
| Navigation | GoRouter for declarative navigation and route guards | Required |
| ML runtime | TensorFlow Lite for approved on-device model inference | Required |
| Face detection and preprocessing | MediaPipe for validated face detection, landmarks, or preprocessing required by the approved pipeline | Required where camera inference needs it |
| Storage | Isar behind repository abstractions for structured local records and metadata | Required |
| Connectivity | The complete Version 1 user workflow must function offline; no backend or account may be required | Required |
| Android package size | Target APK size and model-asset budget | **TBD after model selection and baseline-device testing** |
| Battery | A reflection session must not create unacceptable battery drain or sustained background work | Exact session energy budget **TBD** |
| Memory | Capture, preprocessing, inference, and history must remain within a measured baseline-device memory budget | Peak memory limit **TBD** |
| Responsiveness | Target 60 frames per second for interactive UI; preprocessing and inference must not block the UI isolate | Required; dropped-frame threshold **TBD** |
| Inference performance | Model latency, throughput, queue depth, thermal limits, and timeout behavior require physical-device measurement | Exact budgets **TBD** |

Target values must be approved through an ADR after representative models, input resolution, supported operating systems, and baseline devices are selected. An APK target must account for model assets and native libraries; equivalent iOS package-size goals must be defined separately.

## 13. Success Measures

Before external release, exact targets will be approved and recorded. Candidate measures include:

- Percentage of users who understand the non-diagnostic limitation in usability testing.
- Completion rate for a consented reflection session.
- Percentage of sessions completed fully offline.
- Crash-free session rate and inference failure rate by supported device class.
- User-reported usefulness without increased certainty in unsupported model claims.
- Deletion and consent-withdrawal completion rates.
- Model quality and calibration measures across approved evaluation slices.

Success metrics must not reward more capture time, more sensitive data collection, or more confident labeling by default.

## 14. Definition of Success

Version 1 is complete only when all of the following are true:

- Every Must requirement in this PRD is implemented and verified against its acceptance evidence.
- All release acceptance criteria are satisfied without an unresolved release blocker.
- The complete user workflow—consent, camera-based on-device inference, user-authored reflection, user-authored history and summaries, data control, and deletion—functions without network connectivity.
- Required product, architecture, operational, privacy, security, accessibility, model, third-party, and user-facing documentation exists and has been reviewed by the responsible stakeholders.
- All required automated and manual tests pass on the approved platform and device matrix.
- Release quality is achieved, including approved reliability, performance, accessibility, security, privacy, model-quality, reproducibility, and rollback evidence.

Completing implementation alone does not constitute Version 1 completion.

## 15. Release Acceptance Criteria

The first production release is acceptable only when:

- All Must requirements in the approved release scope pass acceptance testing.
- Threat modeling, privacy review, accessibility review, and model-risk review are complete.
- Required tests and GitHub Actions checks pass from a reproducible build.
- Supported device and operating-system ranges are documented and tested.
- User data can be deleted, and deletion behavior has been verified.
- Model cards, third-party notices, and applicable store disclosures are complete.
- Monitoring and rollback procedures exist without collecting prohibited data.

## 16. Version Strategy

The following versions are planning targets used to separate architectural scope. They are not delivery dates or commitments. Each release remains subject to evidence, prioritization, responsible-AI review, and approved ADRs.

### Version 1 — Local-first reflection

- Offline TensorFlow Lite inference using approved models.
- Explicit, foreground camera capture with MediaPipe-based face detection or preprocessing where required.
- User-authored reflection and correction or rejection of model estimates.
- Local history and privacy-preserving, on-device pattern analytics.
- Isar local database with retention and deletion controls.

Version 1 requires no backend, authentication, cloud synchronization, or multi-device support. “Analytics” in this scope means user-facing local pattern summaries; it does not authorize sensitive product telemetry.

### Version 2 — Account and synchronization foundation

- Cloud synchronization.
- Authentication.
- Multi-device support.
- A production backend and associated operational controls.
- Export improvements beyond the Version 1 data-control baseline.

Version 2 requires new data-flow, threat-model, privacy, encryption, identity, conflict-resolution, deletion, and offline-reconciliation decisions.

### Version 3 — Extensible intelligence and research

- Multiple approved AI models.
- A governed plugin architecture.
- Personalized insights with explicit user controls and validated limitations.
- A separately consented and governed research mode.
- Advanced analytics that remain consistent with product safety and privacy principles.

Version 3 does not pre-authorize new inference claims, sensitive traits, surveillance, third-party plugins, or research data collection.

## 17. Risks and Mitigations

| Risk | Impact | Initial mitigation |
| --- | --- | --- |
| Users over-trust inferred labels | Psychological or behavioral harm | Use uncertain language, confidence thresholds, correction controls, and repeated limitations |
| Unequal model performance | Exclusion or misleading results | Validate representative slices, fail closed, document limitations, and gate model releases |
| Sensitive data exposure | Privacy and trust harm | Local-first processing, data minimization, redaction, secure storage, and threat modeling |
| Mobile thermal or battery load | Poor experience and device impact | Profile physical devices, throttle workload, and define inference budgets |
| Framework or model lock-in | Slow evolution | Clean Architecture ports, versioned adapters, and ADRs |
| Regulatory classification changes | Release or legal risk | Legal review before claims, markets, research use, or cloud processing expand |

## 18. Architectural Assumptions

These assumptions guide the first draft and are not irreversible decisions:

- The platform's first client is a single Flutter application targeting Android and iOS.
- The first release is local-first and does not require a product backend or user account.
- TensorFlow Lite executes approved models on device; MediaPipe supplies only the preprocessing or landmark capabilities required by those models.
- Isar stores structured local records and metadata; raw media is not persisted by default.
- Riverpod manages dependency composition and presentation state; GoRouter owns declarative navigation.
- The application is intended for adults and launches in a limited set of reviewed locales and markets.
- Model selection, camera estimation contract, any additional supported signals, device baseline, encryption design, export format, and telemetry provider remain open decisions.

Changes to assumptions with privacy, safety, data, or dependency consequences require an ADR. See [Architecture Decision Records](DECISIONS/README.md).

## 19. Open Questions

- Which signal categories have sufficient scientific validity and ethical justification for the first release?
- Which devices and OS versions form the performance baseline?
- Is application-level encryption required in addition to platform data-at-rest protections?
- What local retention default best balances reflection value and data minimization?
- Which export format and secure sharing flow meet portability needs?
- What evaluation datasets and governance process are acceptable for model validation?
- Which jurisdictions and languages are in the initial release?

## 20. Glossary

| Term | Definition |
| --- | --- |
| ADR | Architecture Decision Record; a durable record of a consequential decision, its context, alternatives, and consequences. |
| PRD | Product Requirements Document; the source of product scope, requirements, constraints, risks, and release acceptance conditions. |
| MVP | Minimum Viable Product; the smallest responsibly releasable product that tests a defined value proposition. It is not permission to omit safety or quality requirements. |
| FER | Facial Emotion Recognition, a common technical term for systems that classify facial expressions. EmotionSense AI uses “emotion estimation” in product language because facial signals do not establish a person's internal emotional state. |
| TensorFlow Lite | An on-device machine-learning runtime used to execute approved models within the mobile client. |
| MediaPipe | A framework used for validated media processing, face detection, landmarks, or preprocessing in the on-device pipeline. |
| Inference | Execution of a trained model on an input to produce scores or estimates. |
| Emotion Estimation | A confidence-aware model estimate derived from supported observable signals; it is not a factual determination of internal emotion. |
| Reflection | User-led interpretation and contextualization of their experience, which may accept, change, or reject a model estimate. |
| Calibration | The degree to which a model's confidence corresponds to observed performance under defined evaluation conditions. |
| Offline-first | A design requirement under which the complete core workflow functions without a network connection, while any future network capability remains additive and failure-tolerant. |

## 21. Related Documents

- [Architecture](ARCHITECTURE.md)
- [Roadmap](ROADMAP.md)
- [Coding Standards](CODING_STANDARDS.md)
- [Contributing](CONTRIBUTING.md)
