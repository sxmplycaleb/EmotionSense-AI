# EmotionSense AI

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
![Flutter 3.44.8](https://img.shields.io/badge/Flutter-3.44.8-02569B?logo=flutter)
![Dart 3.12.2](https://img.shields.io/badge/Dart-3.12.2-0175C2?logo=dart)
[![Flutter validation](https://github.com/sxmplycaleb/EmotionSense-AI/actions/workflows/flutter_validation.yml/badge.svg?branch=main)](https://github.com/sxmplycaleb/EmotionSense-AI/actions/workflows/flutter_validation.yml)
[![CodeQL](https://github.com/sxmplycaleb/EmotionSense-AI/actions/workflows/codeql.yml/badge.svg?branch=main)](https://github.com/sxmplycaleb/EmotionSense-AI/actions/workflows/codeql.yml)
[![GitHub release](https://img.shields.io/github/v/release/sxmplycaleb/EmotionSense-AI?display_name=tag)](https://github.com/sxmplycaleb/EmotionSense-AI/releases/latest)

EmotionSense AI is an AI-powered emotional reflection platform with a privacy-conscious Flutter mobile application as its first client. The project is designed around on-device machine learning, transparent user control, and a maintainable architecture suitable for production delivery.

> **Project status:** Milestone 0.5 GitHub production hardening. The repository foundation is public; no application features have been implemented.

## Vision

Make emotional self-awareness more accessible by turning consented, device-captured signals into understandable, non-diagnostic insights while keeping sensitive data under the user's control.

EmotionSense AI is intended as a wellness and reflection tool. It is not a medical device, does not diagnose mental health conditions, and must not represent model output as clinical advice.

## Planned Features

- Consent-led onboarding and clear explanations of data use.
- On-device analysis of supported visual and audio-derived signals.
- Personal reflection entries and contextual annotations.
- Private, local-first history and trend summaries.
- User controls for capture, retention, export, and deletion.
- Confidence-aware insights with limitations stated in plain language.
- Accessibility, localization, and resilient offline behavior.

The planned scope and acceptance criteria are maintained in [Product Requirements](docs/PRODUCT_REQUIREMENTS.md).

## Technology Stack

| Area | Technology | Version or status | Purpose |
| --- | --- | --- | --- |
| Application | Flutter / Dart | 3.44.8 stable / 3.12.2 | Cross-platform Android and iOS foundation |
| Architecture | Clean Architecture | Approved principle | Separation of presentation, domain, and data concerns |
| State management | Riverpod | 3.4.2 | Dependency composition and reactive presentation state |
| Navigation | GoRouter | 17.3.0 | Declarative routing and navigation guards |
| Immutable models | Freezed annotation / generator | 3.1.0 / 3.2.5 | Approved generation foundation; no models exist yet |
| Code generation | build_runner | 2.15.1 | Reproducible execution of approved generators |
| Analysis | flutter_lints | 6.0.0 | Flutter lint baseline extended by project rules |
| ML inference | TensorFlow Lite | Planned; not installed | Future approved on-device model execution |
| Signal processing | MediaPipe | Planned; not installed | Future validated detection and preprocessing |
| Local persistence | Isar | Planned; not installed | Future structured local storage behind repositories |
| Automation | GitHub Actions | Workflow actions pinned by commit SHA | Formatting, analysis, tests, and CodeQL workflow scanning |

Technology choices are constraints, not permission to couple business rules to frameworks. See [Architecture](docs/ARCHITECTURE.md) for boundaries and assumptions.

## Repository Structure

The repository foundation is organized as:

```text
.
├── README.md
├── CHANGELOG.md
├── CITATION.cff
├── LICENSE
├── SECURITY.md
├── CODE_OF_CONDUCT.md
├── CODEOWNERS
├── MILESTONE_REPORT.md
├── .github/
│   ├── ISSUE_TEMPLATE/      # Structured, privacy-safe issue intake
│   ├── SUPPORT.md
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── dependabot.yml
│   └── workflows/           # Flutter validation and CodeQL
├── .vscode/                 # Shared editor settings and recommendations
├── apps/
│   └── mobile/              # Flutter client for Android and iOS
├── docs/
│   ├── PRODUCT_REQUIREMENTS.md
│   ├── ARCHITECTURE.md
│   ├── ROADMAP.md
│   ├── CODING_STANDARDS.md
│   ├── CONTRIBUTING.md
│   ├── MILESTONE_TEMPLATE.md
│   ├── DECISIONS/           # Architecture Decision Records
│   └── MILESTONES/          # Historical milestone reports
├── ml/                      # Future governed ML research workspace
├── packages/                # Future shared Dart or Flutter packages
├── scripts/                 # Future repository automation
└── docker/                  # Future container tooling; no backend is present
```

The mobile directory contains only a Material 3 application shell, Riverpod composition root, GoRouter foundation, empty Clean Architecture boundaries, and a smoke test. It contains no product, capture, inference, persistence, authentication, backend, or analytics behavior.

## Development Setup

Use Flutter 3.44.8 stable with Dart 3.12.2. From `apps/mobile`:

```text
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
flutter run
```

The Flutter version is declared in the mobile `pubspec.yaml`, and dependency resolution is pinned by `pubspec.lock`. Platform builds additionally require the applicable Android or iOS toolchain.

## Development Workflow

1. Read the [Product Requirements](docs/PRODUCT_REQUIREMENTS.md) and [Architecture](docs/ARCHITECTURE.md).
2. Create or reference an issue with a clear outcome and acceptance criteria.
3. Record a proposed architectural decision when a change is significant, difficult to reverse, or crosses established boundaries.
4. Create a short-lived branch from the default branch.
5. Implement the smallest coherent change with tests and documentation.
6. Run formatting, static analysis, and the applicable test suites locally.
7. Open a pull request using Conventional Commits and request review.
8. Merge only after required GitHub Actions checks and approvals pass.
9. Update `CHANGELOG.md` for user-visible or operationally significant changes.

Detailed contributor expectations are in [Contributing](docs/CONTRIBUTING.md), and source conventions are in [Coding Standards](docs/CODING_STANDARDS.md).

## Screenshots

Product screenshots do not exist because Home, Camera, History, and Analytics have not been implemented. Placeholders are retained here to make the future release documentation structure explicit without implying current functionality.

| View | Status |
| --- | --- |
| Home | Screenshot will be added after the approved Home experience is implemented. |
| Camera | Screenshot will be added after consent, permissions, and camera implementation are approved and complete. |
| History | Screenshot will be added after approved local persistence and history implementation. |
| Analytics | Screenshot will be added after approved privacy-preserving local pattern summaries are implemented. |

## Documentation Index

- [Product Requirements](docs/PRODUCT_REQUIREMENTS.md)
- [Architecture](docs/ARCHITECTURE.md)
- [Roadmap](docs/ROADMAP.md)
- [Coding Standards](docs/CODING_STANDARDS.md)
- [Contributing](docs/CONTRIBUTING.md)
- [Architecture Decision Records](docs/DECISIONS/README.md)
- [Milestone Report Template](docs/MILESTONE_TEMPLATE.md)
- [Milestone History](docs/MILESTONES/README.md)
- [Current Milestone Report](MILESTONE_REPORT.md)
- [GitHub Project Plan](docs/GITHUB_PROJECT.md)
- [GitHub Production Hardening](docs/GITHUB_HARDENING.md)
- [Release Checklist](docs/RELEASE_CHECKLIST.md)
- [v0.1.0 Foundation Release Notes](docs/releases/v0.1.0-foundation.md)
- [Changelog](CHANGELOG.md)

## Repository Governance

- Follow the [Contributing Guide](docs/CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md).
- Report vulnerabilities privately according to the [Security Policy](SECURITY.md).
- Use the GitHub issue and pull-request templates to provide reviewable, privacy-safe evidence.
- Ownership and review routing are defined in [CODEOWNERS](CODEOWNERS).
- Project support routes and limitations are defined in the [Support Guide](.github/SUPPORT.md).

## Security and Privacy

Emotion-related data may be highly sensitive. Do not commit personal data, recordings, derived biometric data, secrets, proprietary datasets, or production model artifacts without explicit authorization and appropriate controls. Security concerns should be disclosed privately to the maintainers rather than through a public issue.

## Repository Status

Status badges target the configured `origin` repository at `sxmplycaleb/EmotionSense-AI`. A workflow badge is authoritative only after that workflow completes on GitHub. Repository-owner security settings and required checks are tracked in the [hardening runbook](docs/GITHUB_HARDENING.md).

## Citation

Citation metadata is available in [CITATION.cff](CITATION.cff). The citation describes the engineering foundation and must not be interpreted as evidence that the product requirements or AI functionality are implemented.

## License

This project is licensed under the [MIT License](LICENSE).
