# ADR-0013: Camera Capture Foundation

- Date: 2026-08-09
- Owners: Mobile Engineering, Privacy, and Security
- Decision scope: Camera preview integration, lifecycle ownership, and privacy boundary
- Related: ADR-0007, ADR-0009, ADR-0010, ADR-0012

## Status

Accepted

## Context

Milestone 2.1 needs a front-facing camera preview that future native vision work can consume without coupling presentation code directly to a plugin or creating a persistence/transmission path.

## Decision

Use Flutter's maintained `camera` package with its endorsed CameraX implementation on Android. A Riverpod-injected `CameraService` owns one front-camera controller at a time. The feature controller exposes immutable permission, initialization, ready, unavailable, error, paused, and stopped states; the presentation layer consumes a plugin-independent preview surface.

Camera initialization occurs only after the user chooses **Start camera**. The service selects a front-facing camera, enables no audio, creates no image stream, and exposes a preview only. It does not capture photos, record video, save files, cache frames, create database records, send network requests, or log camera-derived information. Backgrounding, navigating away, stopping, and provider disposal release the controller. A previously user-started session may restart after foregrounding; denied or restricted permission is never retried automatically.

## Consequences

- Android and iOS now declare a camera permission with a privacy-preserving purpose string.
- The camera package's normal platform resources are bounded to an active preview session; the application creates no persistent camera artifact.
- Physical device coverage remains required to prove hardware-specific behavior and orientation support before release.
- Face detection, image streaming, ML inference, and all camera-derived persistence remain out of scope.

## Validation

- Unit tests override the `CameraService` and cover permission failures, initialization failures, unavailable hardware, duplicate starts, lifecycle changes, explicit stop, and disposal.
- Static review verifies no camera capture, image-stream, filesystem, database, analytics, or network APIs are used by the feature.
- Flutter formatting, analysis, tests, and Android debug compilation validate the source and platform integration; device-camera behavior requires separate hardware evidence.
