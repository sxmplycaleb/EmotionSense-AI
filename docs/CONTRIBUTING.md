# Contributing

Thank you for helping build EmotionSense AI. Contributions must protect user agency and sensitive data as rigorously as they protect code quality.

## 1. Before Contributing

Read:

- [Product Requirements](PRODUCT_REQUIREMENTS.md)
- [Architecture](ARCHITECTURE.md)
- [Coding Standards](CODING_STANDARDS.md)
- [Architecture Decision Records](DECISIONS/README.md)

For substantial work, begin with an issue so the problem, boundaries, risks, and acceptance criteria can be agreed before implementation.

## 2. Ways to Contribute

- Clarify product or engineering documentation.
- Report a reproducible defect without including personal or sensitive data.
- Improve tests, accessibility, privacy, security, performance, or developer tooling.
- Propose a scoped product change supported by evidence and safety considerations.
- Review model limitations, evaluation methodology, and device behavior.

Feature implementation should not begin until the corresponding roadmap phase and foundational decisions are approved.

## 3. Development Setup

The mobile client uses Flutter 3.44.8 stable and Dart 3.12.2. Install that Flutter version, then run the following from `apps/mobile`:

```text
flutter pub get
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Use the committed `pubspec.lock`; dependency changes require maintenance, license, compatibility, and security review. Follow the generated-file policy in the [mobile README](../apps/mobile/README.md). Android and iOS builds also require their platform toolchains.

Never use production data, personal recordings, real emotional histories, or unapproved proprietary models for local development.

## 4. Issue Workflow

A useful issue includes:

- The user or engineering problem.
- Proposed outcome and explicit non-goals.
- Acceptance criteria that can be verified.
- Privacy, safety, accessibility, ML, migration, and performance considerations.
- Dependencies on open decisions or other issues.

Security vulnerabilities and privacy incidents must not be filed publicly. Contact the maintainers through the repository's private security reporting channel once configured.

## 5. Branches and Commits

Create a short-lived branch from the current default branch. Suggested names include `docs/adr-process`, `fix/inference-lifecycle`, and `chore/ci-analysis`.

Use Conventional Commits:

```text
<type>(optional-scope): <imperative summary>
```

Common types are:

- `feat`: user-visible capability.
- `fix`: defect correction.
- `docs`: documentation only.
- `test`: test-only change.
- `refactor`: behavior-preserving restructuring.
- `perf`: measured performance improvement.
- `build`: build system or dependency change.
- `ci`: GitHub Actions or automation change.
- `chore`: maintenance not covered above.

Use `!` and a `BREAKING CHANGE:` footer for incompatible interfaces or data behavior. Reference issues in the commit or pull-request body.

## 6. Pull Requests

Keep pull requests small enough to review as one coherent change. The description should include:

- What changed and why.
- Linked issue and acceptance criteria.
- Test evidence and relevant commands.
- Screenshots only when safe and relevant; use synthetic data.
- Privacy, security, accessibility, ML, persistence, and performance impact.
- Migration and rollback notes.
- Documentation and changelog impact.
- ADR link or a reason no ADR is required.

Draft pull requests are encouraged for early architectural feedback. A pull request is ready for merge only when required checks pass, review conversations are resolved, documentation is current, and the author has completed a self-review.

## 7. Review Expectations

At least one qualified reviewer must approve each change; protected or high-risk areas may require additional owners. Reviewers assess correctness, architecture, tests, maintainability, privacy, security, accessibility, and operational impact.

Authors should respond to the substance of feedback and avoid resolving another reviewer's thread without agreement. Significant scope discovered during review should become a follow-up issue or a newly scoped pull request.

## 8. Architecture Decisions

Create an ADR before implementing a decision that is hard to reverse, affects multiple features, changes trust or data boundaries, adds a foundational dependency, changes model behavior or claims, or creates a new operational obligation.

Follow the process and template in [DECISIONS/README.md](DECISIONS/README.md). Small implementation choices that remain inside an accepted decision do not need an ADR.

## 9. Quality Gates

GitHub Actions will enforce the applicable subset of:

- Formatting and static analysis.
- Unit, widget, integration, migration, and model contract tests.
- Documentation links and repository policy.
- Secret, dependency, license, and supply-chain checks.
- Build reproducibility and artifact integrity.

Do not bypass a failing check by weakening the check, deleting a meaningful test, or suppressing a warning without explaining and reviewing the underlying reason.

## 10. Changelog and Releases

Add user-visible, security-relevant, migration-relevant, or operationally significant changes beneath `Unreleased` in [CHANGELOG.md](../CHANGELOG.md). Use the Keep a Changelog categories. Purely internal changes may be omitted when they have no release impact.

Release maintainers move entries into a dated version section, compare links, and create signed artifacts according to the approved release process.

## 11. Sensitive Data and Responsible ML

- Never commit raw or derived personal data, biometric templates, recordings, credentials, signing material, or private datasets.
- Use synthetic or explicitly approved, licensed, and consented test assets.
- Do not broaden model use, labels, data collection, or retention through an implementation detail.
- Report quality across approved slices and include unavailable outcomes; do not hide weak results behind aggregate accuracy.
- Reject uses involving covert monitoring, diagnosis, deception detection, or high-impact decisions unless project governance explicitly changes—and such a change would require extensive independent review.

## 12. Conduct

Contributors are expected to communicate respectfully, welcome evidence-based disagreement, protect participant and user dignity, and avoid overstating what emotion-related models can know. A formal code of conduct should be adopted before opening the repository to broad public contribution.

## 13. Licensing

By contributing, you agree that your contributions are licensed under the repository's [MIT License](../LICENSE). Contributors are responsible for ensuring they have the right to submit code, models, documentation, and other assets.
