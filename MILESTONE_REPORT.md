# Milestone Report: 2.1 - Camera/Capture Foundation

**Status:** Complete, with device verification limitation
**Date:** 2026-08-11
**Scope:** Front-facing, local-only camera preview foundation only

## Outcome

Milestone 2.1 adds the approved camera/capture foundation for the mobile app. The implementation provides an explicit-start front-camera preview behind a Riverpod-injected service boundary, with lifecycle cleanup and user-facing permission/error states.

This milestone does not add face detection, emotion recognition, image streaming, model inference, photo/video capture, persistence, telemetry, analytics, networking, or any camera-derived record.

## Implemented

- Added Flutter `camera` package dependency to the mobile app.
- Added Android camera permission.
- Added iOS camera usage description.
- Added a `CameraService` abstraction and Flutter camera adapter.
- Added camera session state management with Riverpod.
- Added lifecycle handling for pause/background/disposal release.
- Added a camera preview route reachable from the foundation screen.
- Added unit tests for camera state transitions, permission failures, lifecycle restart, explicit stop, duplicate-start protection, and provider disposal.
- Added ADR-0013 and Milestone 2.1 documentation.

## Acceptance Evidence

| Criterion | Status | Evidence |
| --- | --- | --- |
| Camera preview dependency is integrated | Pass | `apps/mobile/pubspec.yaml`, lockfile |
| Front-facing camera is selected | Pass | `FlutterCameraService` selects `CameraLensDirection.front` |
| User starts camera explicitly | Pass | Camera opens only from the `Start camera` action |
| Permission denied/restricted/unavailable states are surfaced | Pass | `CameraState`, `CameraSessionController`, `CameraScreen` |
| Camera resources are released on stop/background/disposal | Pass | Controller tests and service lifecycle implementation |
| UI is not directly coupled to camera plugin controller | Pass | Presentation consumes app preview surface abstraction |
| No face detection, ML, inference, capture persistence, or transmission | Pass | Static review of camera feature source |
| Automated quality checks pass | Pass | Format, analyze, tests |
| Manual physical-device preview verification | Not run | No device/emulator camera available in this environment |

## Verification Commands

From `apps/mobile`:

```powershell
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze --no-pub
flutter test --no-pub
```

Additional static privacy/scope review was performed over the mobile camera feature source to confirm the implementation does not call capture, image stream, video recording, persistence, networking, logging, analytics, MediaPipe, TensorFlow, or TFLite APIs.

Android debug APK compilation was attempted. The Gradle process exceeded this environment's command time limit, but an APK artifact was produced at `apps/mobile/build/app/outputs/flutter-apk/app-debug.apk`. This is not a substitute for physical camera verification.

## Remaining Follow-Up

- Run the preview on a physical Android device or emulator with a camera to capture manual evidence for permission, live preview, orientation, background/resume, and stop behavior.
- Add a screenshot after explicit consent and device verification if project documentation needs visual proof.
