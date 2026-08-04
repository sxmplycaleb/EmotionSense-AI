# Phase 1 Completion Summary

**Date:** 2026-08-04  
**Status:** Complete and approved for Phase 2 implementation

## Executive Summary

Phase 1 examined facial-expression construct validity, public datasets and rights, mobile model candidates, performance budgets, Flutter/native architecture, device compatibility, confidence/calibration, privacy, fairness, ethics, transparency, accessibility, and operational risk.

The approved direction is an Android-first Flutter application with a native, session-scoped CameraX pipeline. MediaPipe Face Detector locates one consenting face; a versioned native preprocessing path feeds a LiteRT-hosted MobileNetV3-Small candidate; calibrated thresholds and quality gates return either a visible-expression estimate or an explicit unavailable state. CPU is mandatory, GPU is allowlisted only after evidence, and raw frames never cross into Flutter domain state.

The model strategy is MobileNetV3-Small primary, EfficientNet-Lite0 fallback, and MobileNetV2 baseline. This is an ordered architecture decision, not approval of weights. Production requires a lawful, consented, representative smartphone corpus and an exact artifact that passes quality, calibration, fairness, performance, battery, thermal, privacy, security, accessibility, and compatibility gates.

The privacy policy is fixed: no cloud inference, uploads, biometric storage, inference history, production camera telemetry, analytics, advertising, or automatic crash reporting. Capture is explicit, foreground-only, single-person, transient, and fully offline. Every future release must pass the privacy regression checklist.

## What Was Approved

- A narrow visible-facial-expression claim and explicit prohibited-use boundary.
- License-gated dataset governance and production-data requirements.
- Ordered model candidates and hard artifact acceptance criteria.
- Native CameraX/MediaPipe/LiteRT architecture behind Flutter domain ports.
- Latest-frame scheduling, serial ownership, CPU baseline, and allowlisted GPU policy.
- Calibrated confidence, conservative abstention, and neutral unavailable messaging.
- Local-only data handling and mandatory privacy regression review.
- Measurable implementation and release gates.

## What Remains Unknown

- Which commercially cleared smartphone corpus will supply production lineage.
- Which trained, optimized artifact will pass all gates.
- The final Android device allowlist, support floor, and acceleration tuples.
- iOS feasibility, adapter design, and supported-device evidence.
- Final launch population, markets, languages, accessibility evidence, and user-comprehension thresholds.
- Future personalization, multi-face behavior, advanced models, and off-device features, all of which remain out of scope.

## Why Implementation Can Begin

The unknowns affect evidence, release eligibility, or later scope; they do not change the initial trust boundary or component contracts. Engineering can implement the platform boundary, lifecycle, safe states, test doubles, manifests, benchmark harnesses, privacy controls, and Android-first candidate pipeline while production data and artifacts are governed separately.

## Key Engineering Principles

1. Describe visible expression, never a person's inner state.
2. Keep sensitive processing local, transient, foreground, and minimal.
3. Fail closed and prefer unavailable to an unsupported label.
4. Separate camera/detection, classification, confidence, domain, and presentation responsibilities.
5. Version data, model, preprocessing, calibration, thresholds, and claims together.
6. Measure the complete sustained pipeline on representative hardware.
7. Treat weakest-class, subgroup, accessibility, privacy, and security evidence as release requirements.
8. Change sensitive scope only through explicit ADR and review.

## Evidence Classification

- **Facts:** Phase 1 produced the referenced research and accepted ADRs; no implementation artifact or production measurement was created.
- **Assumptions:** the provisional Android support profile and minimum budgets are feasible starting targets.
- **Trade-offs:** the baseline sacrifices broad claims, cloud convenience, multi-face coverage, and automatic acceleration for privacy, clarity, and maintainability.
- **Constraints:** implementation must remain within ADR-0011 and release must satisfy all gates.
- **Open Questions:** [Open Decisions](OPEN_DECISIONS.md) is the authoritative assignment register.

## Approval

Phase 1 is complete. Phase 2 implementation may begin under [ADR-0011](../DECISIONS/ADR-0011-Implementation-Baseline.md). This approval does not authorize production release.

