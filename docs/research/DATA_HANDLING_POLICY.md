# Data Handling Policy

**Milestone:** 1.4 — Privacy & Ethics  
**Research snapshot:** 2026-08-04  
**Baseline:** No accounts, cloud, analytics, advertising, or production telemetry  
**Related:** [Privacy and Ethics](PRIVACY_AND_ETHICS.md) · [User Transparency](USER_TRANSPARENCY.md)

## Scope

This policy inventories data used by the production mobile experience. It does not authorize collection of research datasets; research data remains governed by [Dataset Governance](DATASET_GOVERNANCE.md). “Stored” means written beyond the transient in-memory operation. “Transmitted” includes transfer to the publisher, a vendor, another app, or any off-device destination.

## Production data inventory

| Data or asset | Processed | Stored | Transmitted | Purpose and rule |
|---|---:|---:|---:|---|
| Live camera frames | Yes, in memory | No | No | User-started face localization and expression estimation only |
| Face box/landmarks or equivalent geometry | Yes, in memory | No | No | Crop/quality processing only; not identity |
| Face crop and normalized tensor | Yes, in memory | No | No | Immediate model input only |
| Quality/pose/visibility signals | Yes, in memory | No | No | Decide whether to abstain |
| Class scores, calibrated confidence, result | Yes, in memory/UI | No | No | Current-session feedback only |
| Temporal state, if approved | Yes, bounded memory | No | No | Stabilize display; clear on stop/background/error |
| Camera permission state | Read from OS | OS-managed | No | Respect user choice |
| Minimal user preferences | As needed | Yes, locally | No | Non-sensitive presentation/settings only |
| User-authored reflection records | Yes, when the user chooses to create or view them | Yes, locally after storage protection is approved | No | Private notes only; never linked to a camera or inference session |
| Bundled model/calibration/labels | Yes | Yes, app package | App-store delivery only | Versioned application assets; contain no production user data |
| Model/version/integrity metadata | Yes | Yes, app package | App-store delivery only | Auditability and compatibility |

## What is stored

Only the following baseline categories may persist:

- application binaries and versioned model assets;
- model metadata, calibration parameters, label definitions, and integrity hashes;
- non-sensitive preferences such as completed onboarding, theme, language, or accessibility display settings; and
- user-authored reflection records, after the storage-protection decision required by ADR-0012 is implemented; and
- aggregate build-time evaluation reports in the project repository, created from governed research—not from production users.

Preferences must not encode a user's expression, session history, image-derived features, identity, or inferred characteristics. Local preferences should use platform-protected application storage and be excluded from backup if their future content becomes sensitive.

## What is never stored or reused

Under the baseline product policy, the app must never persist:

- photos, video, audio, thumbnails, face crops, screenshots, or screen recordings;
- face embeddings, identity templates, landmarks, tensors, or reconstructable image features;
- raw or calibrated per-frame scores, selected labels, machine-generated timelines, session summaries, histories, or any linkage between a user-authored reflection and an inference session;
- inferred emotion, intent, health, honesty, personality, demographics, or sensitive traits;
- advertising identifiers, persistent device fingerprints, precise location, contacts, or account identifiers;
- camera-derived data in logs, traces, metrics, crash reports, clipboard, notifications, share sheets, backups, or support bundles; or
- any production user input for training, fine-tuning, calibration, validation, or evaluation.

“Never stored” is a release requirement, not merely a UI promise. Debug and test builds must use synthetic/approved fixtures and prevent accidental sensitive capture.

## Model files

Model files are product assets, not production user data. Each shipped model must have an approved origin, dataset lineage, license disposition, model card, version, checksum/signature, expected input/output contract, calibration record, and compatibility range. A model must not embed example face images, personal metadata, or unauthorized training artifacts. Model extraction and memorization risks require pre-release review even though inference is local.

Remote model download, personalization, federated learning, and background model updates are outside the baseline. A future model update must use the trusted app/update channel, preserve offline operation, be integrity verified, and receive the same evaluation and policy review as an application release.

## Logs and diagnostics

Release logs must be minimal, local, bounded, and free of personal or camera-derived content. Allowed diagnostics are coarse state/error codes necessary for immediate local troubleshooting—for example, “model failed integrity check”—without frames, coordinates, scores, file paths containing user identifiers, timestamps precise enough to reconstruct behavior, or stable device identifiers.

Logging must be disabled or reduced in release builds. Developers must audit native and third-party components because they may log inputs independently. Users must not be asked to upload general device logs unless a separate, reviewed support flow proves that the export is sanitized and the user sees exactly what will be sent.

## Crash reports

Automatic third-party crash reporting is **off and absent by default**. It can transmit device, usage, and diagnostic data and therefore conflicts with the simplest interpretation of local-only operation.

If future evidence establishes a need, crash reporting requires a separate proposal that specifies fields, processor, jurisdiction, security, retention, deletion, consent/opt-out, SDK network behavior, and store disclosures. Camera frames, crops, tensors, results, breadcrumbs revealing expression sessions, memory dumps, and user identifiers remain prohibited. The core feature must work fully when reporting is declined or offline.

## Offline operation and network boundary

- Core capture, inference, notices, help, settings, and deletion controls must work in airplane mode.
- No network permission or connection is needed for an analysis session.
- The app must not send connectivity probes, analytics, attribution, ads, remote configuration, or feature flags tied to user behavior.
- Release verification must inspect actual network traffic from the complete binary, including third-party SDKs.
- Store-mediated app/model delivery is not a production inference data flow, but store operators may process installation data under their own terms; user notices must not claim the phone makes no network connections at all.

Google Play and Apple state that data processed only on device is not “collected” for their respective disclosure definitions [E16], [E17]. That platform terminology does not eliminate the need to explain on-device camera processing or comply with applicable law.

## Lifecycle and deletion expectations

| Event | Required data behavior |
|---|---|
| User stops analysis | Stop capture; clear frames and derived in-memory state promptly |
| App backgrounds, locks, crashes, or loses permission | Stop acquisition; invalidate session; do not restore a prior result |
| User clears history | Baseline has no history; state this clearly rather than implying hidden records exist |
| User resets app data | Delete local preferences and onboarding state |
| User uninstalls app | Platform removes app-local assets/preferences subject to OS behavior; no publisher-held inference record exists |
| User asks publisher to delete results | Explain that baseline results were never received or retained; delete any separately supplied support correspondence under its own policy |
| Model/app end of life | Remove distribution, preserve only non-personal governance evidence, and communicate security/support status |

Deletion claims must distinguish app-controlled storage from OS/app-store records, user-created screenshots, device backups, and voluntarily sent support messages. The publisher cannot delete data it never controlled.

## Change control

Any proposal to save, export, share, sync, personalize, analyze usage, collect samples, report crashes, or add an SDK that communicates off device changes this policy. Before implementation it requires an updated data-flow diagram, data-protection and ethical impact assessment, threat model, consent and transparency design, legal basis, vendor review, retention schedule, deletion mechanism, store declarations, and approval through an ADR.

## Decision record

### Facts

- App stores require developers to account for collection by third-party SDKs, and both distinguish solely on-device processing from off-device collection in their disclosures [E16], [E17].
- Local storage and diagnostics can expose sensitive data even when inference itself is on-device.
- Model artifacts have provenance, integrity, license, and potential memorization risks independent of production data flows.

### Assumptions

- The product does not need accounts, saved sessions, or personalization to meet its initial purpose.
- The OS removes ordinary app-private data on uninstall, subject to documented platform backup/restoration behavior.
- Research data and production user data remain technically and organizationally separated.

### Trade-offs

- No history or sync limits convenience and longitudinal experiences but avoids building a sensitive expression profile.
- No crash telemetry slows diagnosis of field failures but materially reduces disclosure risk.
- Bundling the model increases application size but preserves offline behavior and update governance.

### Constraints

- Camera-derived data is transient, in-memory, non-persistent, and non-transmitted.
- Production sessions are never a model-improvement data source.
- Core operation cannot depend on an account, cloud service, or network.
- Third-party components may not silently expand the data inventory.

### Open questions

- Which non-sensitive preferences are genuinely necessary at launch?
- How will release tests prove absence of sensitive logs, backups, and network transmission on both platforms?
- Are OS crash facilities capable of capturing memory relevant to camera processing, and what release controls are required?
- What exact support-data retention and deletion policy applies if a user voluntarily emails a screenshot?
- Should the application package opt out of all platform backup or only protect a narrowly defined settings store?
