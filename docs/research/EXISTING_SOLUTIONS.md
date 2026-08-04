# Existing Facial Analysis and Emotion-Estimation Solutions

## Document control

| Field | Value |
| --- | --- |
| Milestone | 1.0 — Technical Discovery & Validation |
| Research snapshot | 2026-08-04 |
| Purpose | Market and platform capability review; not procurement advice |
| Project constraint | Version 1 must work offline and process sensitive signals on device [P01][P02] |

Service names, policies, and availability change. Revalidate every entry before an ADR or implementation decision. See [References](REFERENCES.md), [Literature Review](FER_LITERATURE_REVIEW.md), and [Mobile FER Overview](MOBILE_FER_OVERVIEW.md).

## Comparison summary

| System | Expression/emotion output | Deployment model | Default privacy implication | Fit with Version 1 |
| --- | --- | --- | --- | --- |
| Affectiva / Smart Eye | Commercial facial coding, expression/emotion, valence/engagement/attention offerings | Cloud media analytics; SDK options; Android on-device SDK announced in 2026 | Depends on product and customer configuration; cloud workflows transfer video/derived data, on-device SDK can avoid transfer | Potential reference or benchmark; licensing and exact offline behavior require validation |
| Microsoft Azure Face | **Emotion retired**; detection, landmarks, pose, blur/exposure/occlusion remain | Azure cloud API | Images leave device for service processing | Historical lesson only for FER; incompatible with offline requirement |
| Face⁺⁺ | Seven expression scores plus face attributes and landmarks | Cloud APIs; vendor advertises device SDK licensing | Cloud API receives face images/tokens; regional contract and retention terms require review | Comparator only; cloud path conflicts with Version 1 |
| Amazon Rekognition | Nine expression types with confidence; face quality, pose, landmarks, occlusion | AWS cloud APIs for images/video | Customer sends image/video to AWS; account, region, storage, and logging choices matter | Comparator only; not offline |
| Apple Vision | Face rectangles, landmarks, pose, tracking/quality; no documented general emotion classifier | On-device Apple platform framework | Local framework execution; application still owns capture/storage policy | Useful capability baseline, but project architecture currently assumes MediaPipe for validated preprocessing |
| Google ML Kit Face Detection | Face, pose, landmarks/contours, tracking, smile/eye-open probabilities; no general emotion classifier | On-device mobile SDK | Frames can remain local | Relevant detector comparator, not an FER solution |
| MediaPipe Face Detector / Landmarker | Face/keypoints; 478-landmark mesh and 52 blendshape coefficients in Face Landmarker; no validated basic-emotion truth claim | On-device Tasks on supported platforms | Frames can remain local | Strong preprocessing candidate already assumed by project; blendshapes require separate validation and interpretation |

“Fit” is an engineering assessment against [Product Requirements](../PRODUCT_REQUIREMENTS.md), not a claim about vendor quality.

## Affectiva / Smart Eye

### Current status and capabilities

Affectiva became part of Smart Eye in 2021 and remains active in media analytics, behavioral research, and automotive interior sensing. Official materials describe facial coding, real-time Emotion SDK integration, valence/engagement/attention metrics, and cloud media-analysis workflows [R42]. In May 2026, iMotions announced an Affectiva Emotion SDK for Android with fully local on-device processing [R44].

### Strengths

- Long commercial history in consented media research and automotive contexts.
- Real-time SDK and cloud analysis options across different cameras and environments.
- Large proprietary dataset claims spanning countries and media-response studies [R42].
- Product materials explicitly discuss opt-in capture and an on-device Android deployment [R43][R44].

### Weaknesses and uncertainties

- Models, training data composition, calibration, subgroup metrics, and failure thresholds are proprietary.
- Marketing metrics are not a substitute for independent cross-cultural or construct-validity evidence.
- Exact iOS/offline parity, package size, supported devices, licensing, and redistributability are not established by the public sources reviewed.
- Some offerings infer engagement or internal-sounding constructs beyond directly observable facial movements.

### Privacy model

Affectiva’s privacy policy describes collection and processing of video/audio and derived expression data in some workflows, customer-specific agreements, and consent for its direct opt-in collections [R43]. The 2026 Android SDK announcement describes local on-device processing [R44]. Therefore, there is no single privacy model: it is product- and contract-dependent.

### Deployment model

- Cloud media analytics / qualitative-research processing.
- Commercial SDK integration.
- Announced Android on-device SDK through iMotions.

### Lessons for EmotionSense AI

- Separate deployment claims by product edition; “SDK available” does not prove fully offline operation on both target platforms.
- Treat consent, capture purpose, and derived-data use as part of the product contract.
- Require independent calibration, subgroup, and target-device validation even for a mature commercial model.
- Avoid adopting vendor language that implies direct knowledge of internal state.

### Evidence labels

- **Fact:** Affectiva remains an active Smart Eye product family and has cloud and SDK offerings [R42][R44].
- **Assumption:** A proprietary SDK could accelerate discovery, but it may conflict with open-source distribution, replaceability, or transparency.
- **Trade-off:** Commercial maturity and support versus vendor lock-in, limited auditability, and licensing cost.
- **Open question:** Can a licensed model meet offline iOS and Android, data-minimization, reproducibility, and model-card requirements?

## Microsoft Azure Face

### Current status and capabilities

Microsoft retired facial analysis capabilities that purport to infer emotion and gender. Face detection and quality-related attributes such as blur, exposure, glasses, head pose, landmarks, noise, occlusion, and bounding boxes remain available. Identity recognition features are limited access [R45][R46]. Any older documentation or samples listing `emotion` must be treated as historical or stale unless Microsoft explicitly states otherwise.

### Strengths

- Clear responsible-AI change log and explicit retirement notice.
- Remaining quality attributes demonstrate a useful separation between input-quality gating and sensitive inference.
- Managed cloud operations and documentation for supported detection scenarios.

### Weaknesses

- No current Azure emotion capability for EmotionSense AI to consume.
- Cloud dependency violates complete offline Version 1 workflow.
- Service gating and policy changes create availability risk.

### Privacy and deployment model

Azure Face is a cloud service. Input images are sent to Microsoft’s service under the selected Azure region, account, and contractual controls. Exact retention and diagnostic behavior must be verified from current data-privacy terms before any use.

### Lessons for EmotionSense AI

- Product capability can be retired for scientific and responsible-use reasons; architecture must isolate replaceable ML adapters.
- Quality gates are safer and more defensible than forcing an emotion output from every frame.
- Historical API presence is not evidence that a capability remains acceptable or supported.

### Evidence labels

- **Fact:** Microsoft documents emotion as retired [R45][R46].
- **Assumption:** Azure’s retirement is a strong governance signal, but it does not by itself decide EmotionSense AI’s scope.
- **Trade-off:** Managed cloud quality and maintenance versus offline/privacy requirements and external policy risk.
- **Open question:** Which Microsoft quality-gating ideas should be reproduced vendor-neutrally in the evaluation protocol?

## Face⁺⁺

### Capabilities

Face⁺⁺ advertises face detection, face tokens, landmarks, pose/quality attributes, and confidence scores for seven expressions: anger, disgust, fear, happiness, neutral, sadness, and surprise. Its Detect API can return attributes for the largest faces, while Face Analyze operates on face tokens [R49].

### Strengths

- Broad, integrated facial-analysis API surface.
- Explicit pose, blur, occlusion, and quality signals can support input gating.
- Straightforward cloud API model and commercial device-SDK licensing path.

### Weaknesses

- Public product documentation does not provide sufficient model cards, cross-cultural calibration, or independent target-domain evidence.
- Face tokens and multiple sensitive attributes expand governance scope.
- Attribute bundles may tempt collection of age, gender, beauty, or other data outside project purpose.

### Privacy and deployment model

The public international offering is primarily a cloud API: face images or image URLs are transmitted for processing and results include reusable request-level tokens. Face⁺⁺ also advertises device SDK licensing, but supported offline platforms and data flows require contractual confirmation [R49].

### Lessons for EmotionSense AI

- Request only the minimum necessary output; a broad API must not silently expand signal scope.
- Keep face detection identifiers ephemeral and avoid identity-linked storage.
- Test all claimed quality and expression scores independently; vendor confidence is not calibrated probability by default.

### Evidence labels

- **Fact:** Face⁺⁺ currently advertises expression scores and device SDK licensing [R49].
- **Assumption:** Its cloud results could serve as one non-ground-truth comparator on approved synthetic/consented data.
- **Trade-off:** Fast breadth of capabilities versus privacy, lock-in, and opaque evidence.
- **Open question:** What data residency, retention, model-update, and deletion terms apply in intended markets?

## Amazon Rekognition

### Capabilities

Amazon Rekognition DetectFaces returns face bounds, landmarks, pose, quality, occlusion, and—when requested—expression predictions with confidence. The current expression types are `HAPPY`, `SAD`, `ANGRY`, `CONFUSED`, `DISGUSTED`, `SURPRISED`, `CALM`, `UNKNOWN`, and `FEAR` [R47][R48].

AWS explicitly states that these predictions are based on facial appearance and are not determinations of internal emotional state; its example notes that a person posing a sad face may not be sad [R48].

### Strengths

- Clear API contract and confidence fields.
- Explicit intended-use warning aligns with the project’s non-diagnostic, uncertainty-aware posture.
- Integrated quality, pose, occlusion, image, and video operations.

### Weaknesses

- Cloud-only path for these APIs; network, cost, region, credentials, and service availability become dependencies.
- Confidence values need independent calibration; they are not guaranteed probabilities.
- Fixed expression vocabulary remains a closed-set simplification.

### Privacy and deployment model

Applications send images or reference S3 objects for AWS processing. Privacy depends on region, IAM, storage, logging, retention, encryption, and the applicable AWS terms. This cannot meet EmotionSense AI’s complete offline Version 1 requirement.

### Lessons for EmotionSense AI

- Put the “facial appearance, not internal state” limitation in both technical and user-facing contracts.
- Include `unknown/unavailable` as a first-class result rather than always selecting the maximum score.
- Separate face quality and pose signals from expression confidence.

### Evidence labels

- **Fact:** Rekognition currently exposes expression types and an explicit internal-state warning [R47][R48].
- **Assumption:** Its explicit semantics are a useful benchmark for EmotionSense AI documentation.
- **Trade-off:** Mature cloud API versus privacy, offline, latency, and operational dependencies.
- **Open question:** Are expression confidence values calibrated across capture conditions and demographic groups? Public documentation reviewed does not establish this.

## Apple Vision framework

### Capabilities

Apple Vision provides on-device face rectangles, 2D landmarks, face orientation, tracking-related observations, and face-capture quality. Apple describes capture quality as a 0–1 score reflecting properties such as lighting, sharpness, and centering [R50]–[R52]. Vision also supports application-supplied Core ML models, but no general built-in basic-emotion classifier is documented in the reviewed APIs.

### Strengths

- Platform-native, on-device processing.
- Useful quality, landmark, and pose primitives.
- Hardware/OS integration and no required third-party cloud for these operations.

### Weaknesses

- Apple-only; using a different preprocessing implementation on Android can create parity drift.
- OS revisions can change behavior and supported request revisions.
- Capture-quality scores are holistic ranking signals, not FER validity or calibrated expression confidence.

### Privacy and deployment model

Vision executes within the application/device environment. The application remains responsible for camera consent, lifecycle, storage, screenshots, logs, backups, and any later network transmission.

### Lessons for EmotionSense AI

- A platform quality score can inform capture guidance but must be validated for FER and not treated as ground truth.
- Cross-platform preprocessing parity needs golden-image and golden-tensor testing.
- Platform-native speed must be balanced against the project’s replaceable, consistent ML pipeline.

### Evidence labels

- **Fact:** Vision documents face/landmark/pose/quality capabilities, not general FER [R50]–[R52].
- **Assumption:** Vision could be a detector/quality comparator during discovery without changing the approved MediaPipe assumption.
- **Trade-off:** Native integration and performance versus cross-platform consistency and extra adapter maintenance.
- **Open question:** Does Vision quality gating correlate with FER failure on the intended device/user dataset?

## Google ML Kit Face Detection

### Capabilities

ML Kit Face Detection runs on device and provides face location, orientation, landmarks, contours, tracking IDs, and optional probabilities for smiling and eye openness. Google explicitly distinguishes face tracking from face recognition. Its classification surface is limited to smiling and eyes-open—not general emotion categories [R41].

### Strengths

- Mobile-focused, on-device, cross-platform detector.
- Fast/accurate mode and feature configuration expose performance trade-offs.
- Tracking can reduce repeat detection work without identifying a person.

### Weaknesses

- Not an FER classifier.
- Enabling contours, landmarks, and classification changes cost and sometimes available outputs.
- Cross-version/model updates may affect repeatability.

### Privacy and deployment model

Face detection executes on device; the host application controls capture and persistence. Dependency distribution/update behavior must be verified for guaranteed offline first-run operation.

### Lessons for EmotionSense AI

- Use precise language: smile probability is not happiness probability.
- Treat tracking IDs as ephemeral session state, never stable identity.
- Benchmark each feature configuration; “on-device” does not imply zero battery or thermal cost.

### Evidence labels

- **Fact:** ML Kit supports only smile and eye-open face classifications in this area [R41].
- **Assumption:** It is a credible detector comparator, not a replacement for expression evaluation.
- **Trade-off:** Simple mobile SDK versus less control over model internals and update behavior.
- **Open question:** Can its detector satisfy offline packaging and cross-platform parity requirements better than MediaPipe?

## MediaPipe Face Detector and Face Landmarker

### Capabilities

MediaPipe Face Detector uses BlazeFace variants and returns face locations plus six key points. Face Landmarker bundles face detection, a 478-point 3D face mesh, 52 optional blendshape coefficients, and transformation matrices. It supports image, video, and live-stream modes [R35][R36].

Blendshapes describe facial surface configurations. They are not automatically validated emotion labels; mapping them to an emotion vocabulary would create a separate model/heuristic requiring evidence.

### Strengths

- Designed for real-time on-device use and already assumed in project architecture [P01][P02].
- Detector, landmarks, blendshapes, thresholds, and stream modes can support modular experiments.
- Official mobile benchmarks and model details provide a starting point [R35][R36].

### Weaknesses

- Face Landmarker is documented as a Solutions Preview as of the snapshot [R36].
- The full landmark/blendshape bundle may cost more than simple detection and may exceed the project’s minimum necessary processing.
- Blendshape coefficients can be unstable under occlusion, pose, and camera variation and require target-domain testing.

### Privacy and deployment model

Tasks run locally on supported devices when models are bundled or otherwise available locally. Application capture, storage, telemetry, and model distribution remain project responsibilities.

### Lessons for EmotionSense AI

- Choose the smallest validated task graph; do not run a 478-point mesh merely because it is available.
- Separate detector confidence, presence/tracking confidence, blendshape confidence, and FER confidence.
- Validate model version, checksum, input contract, and exact platform behavior.

### Evidence labels

- **Fact:** Face Landmarker outputs 478 landmarks and 52 blendshape coefficients; Face Detector uses mobile-optimized BlazeFace [R35][R36].
- **Assumption:** MediaPipe can satisfy the preprocessing role stated in architecture, subject to prototype evidence.
- **Trade-off:** Rich, reusable features versus compute, package size, preview-status risk, and unnecessary sensitive processing.
- **Open question:** Does detector-only plus crop outperform landmark/mesh-assisted classification on quality per joule?

## Cross-system engineering lessons

1. **Separate detection, quality, and expression.** They have different failure modes and confidence semantics.
2. **Never equate a score with internal emotion.** AWS states this explicitly; project documentation should be at least as clear [R48].
3. **Capabilities can disappear.** Azure’s emotion retirement supports adapter isolation, version pinning, and rollback [R45].
4. **On-device is a data-flow property, not a privacy guarantee.** Logs, persisted frames, backups, screenshots, and exported results can still leak data.
5. **Broad attribute APIs encourage scope creep.** Age, gender, identity, beauty, and attention are not authorized by the PRD.
6. **Vendor confidence is not calibration evidence.** Thresholds require deployment-domain reliability diagrams, expected calibration error, selective-risk, and slice analysis.
7. **Cross-platform parity must be tested.** Different detectors/crops can shift the classifier input more than a model change.
8. **Fail closed.** Low quality, no face, multiple faces, unsupported pose, and low confidence should yield unavailable—not a forced label.

## Project-wide evidence summary

### Facts

- Cloud FER offerings exist, but Microsoft retired its emotion attribute and Apple/ML Kit do not provide a general emotion classifier in the reviewed APIs [R41][R45][R50].
- MediaPipe provides facial geometry/blendshape primitives, not proof of a user’s emotion [R36].
- Mature vendors still warn or demonstrate that facial appearance differs from internal state [R48].

### Assumptions

- Commercial services may be useful as non-ground-truth comparators using approved data.
- Version 1 should not depend on any cloud FER service because offline operation and local processing are requirements [P01].

### Trade-offs

- Build/evaluate an owned model for control and transparency versus license a mature model for speed and support.
- Use one cross-platform preprocessing stack for parity versus platform-native stacks for potential performance.
- Rich landmarks/blendshapes for robustness versus minimal detection/crop for privacy and efficiency.

### Open questions

- Which offerings permit independent benchmarking and publication of results?
- Which SDK licenses permit open-source distribution and offline use?
- What model-update guarantees and rollback controls exist?
- Which vendor outputs, if any, are sufficiently documented to serve as comparison baselines?

## Related documents

- [FER Literature Review](FER_LITERATURE_REVIEW.md)
- [Technical Limitations](TECHNICAL_LIMITATIONS.md)
- [Research Gaps](RESEARCH_GAPS.md)
- [Mobile FER Overview](MOBILE_FER_OVERVIEW.md)
- [References](REFERENCES.md)
