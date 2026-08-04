# GitHub Production Hardening

## Purpose

This runbook separates controls committed in the repository from settings that only a repository owner can enable on GitHub. It applies to the public engineering repository and does not imply that the EmotionSense AI application is production-ready.

## Committed Controls

| Control | Evidence | Scope |
| --- | --- | --- |
| Flutter validation | `.github/workflows/flutter_validation.yml` | Dependency resolution, formatting, analysis, and tests |
| CodeQL advanced setup | `.github/workflows/codeql.yml` | GitHub Actions workflow analysis using `security-extended` queries |
| Dependency updates | `.github/dependabot.yml` | Weekly pub, GitHub Actions, and future Docker checks |
| Ownership | `CODEOWNERS` | Default and sensitive-path review routing |
| Private reporting policy | `SECURITY.md` | Vulnerability intake and safe harbor |
| Community health | Issue/PR templates, support guide, and Code of Conduct | Structured and privacy-safe collaboration |
| Release governance | `docs/RELEASE_CHECKLIST.md` | Mandatory release evidence and approvals |

CodeQL does not support Dart. The committed workflow therefore scans GitHub Actions, the repository's current supported security-sensitive language surface. Kotlin and Swift analysis is deferred until Android and iOS build strategies are validated in hosted CI; generated platform wrappers must not be represented as complete application coverage.

## Manual GitHub Configuration

The repository owner must verify each item in GitHub. Keep evidence in an issue, ruleset export, screenshot with no secrets, or release approval record.

### Repository and access

- [ ] Confirm `main` is the default branch and `@sxmplycaleb` has the expected maintainer role.
- [ ] Confirm the repository description, website, topics, MIT license detection, and public/private visibility.
- [ ] Restrict repository administration and workflow modification to trusted maintainers with two-factor authentication.
- [ ] Review installed GitHub Apps, deploy keys, webhooks, OAuth access, and stale collaborators.

### Branch and tag rulesets

- [ ] Protect `main` from deletion and force pushes.
- [ ] Require pull requests, at least one approval, CODEOWNERS review, conversation resolution, and dismissal of stale approvals.
- [ ] Require the `Flutter validation / Analyze and test` and `CodeQL / Analyze GitHub Actions` checks after their first successful hosted runs.
- [ ] Require branches to be current before merge and restrict bypass permissions to an auditable emergency group.
- [ ] Prefer linear history and signed commits or vigilant mode when contributor tooling supports them.
- [ ] Protect `v*` tags from deletion or unauthorized creation; require signed annotated release tags where policy permits.

### Actions and workflow security

- [ ] Set the default `GITHUB_TOKEN` permission to read-only and require approval for pull requests from untrusted forks.
- [ ] Allow only GitHub-owned and explicitly approved third-party actions.
- [ ] Confirm workflow actions remain pinned to full commit SHAs and Dependabot is allowed to update them.
- [ ] Do not expose environment secrets to fork pull requests or use `pull_request_target` for untrusted checkout and execution.
- [ ] Create protected release environments only after release automation is approved.

### Code security

- [ ] Enable the dependency graph, Dependabot alerts, and Dependabot security updates.
- [ ] Enable secret scanning and push protection, including contributor and delegated bypass review where available.
- [ ] Enable private vulnerability reporting and verify the intake flow with a non-sensitive test draft.
- [ ] Use the committed CodeQL advanced setup; do not enable conflicting CodeQL default setup simultaneously.
- [ ] Triage code-scanning and dependency alerts with documented severity, owner, remediation, and risk acceptance.

Public repositories can use CodeQL code scanning on GitHub.com. Private repositories require the applicable GitHub Code Security entitlement.

### Community and planning

- [ ] Create the labels defined in `.github/labels.md` and the project described in `docs/GITHUB_PROJECT.md`.
- [ ] Decide whether to enable Discussions; publish moderation ownership before enabling it.
- [ ] Publish dedicated, independent security and Code of Conduct reporting contacts.
- [ ] Verify issue templates, pull-request template, support file, citation prompt, and community profile rendering.

### Releases

- [ ] Confirm the `v0.1.0` tag and foundation release notes match the tagged commit.
- [ ] Configure release permissions so only approved maintainers or a protected workflow can publish.
- [ ] Define artifact retention, checksums, SBOM, attestations, signing, provenance, and rollback before application binaries are released.
- [ ] Complete `docs/RELEASE_CHECKLIST.md` for every release.

## Release Automation Decision

Automated GitHub release publication is not enabled in Milestone 0.5. The architecture and ADR process require a separate decision for signing and release strategy. A release workflow may be added only after:

- An accepted ADR defines trigger, permissions, approval environment, artifact scope, signing, provenance, rollback, and failure recovery.
- Required status checks and protected tag/environment rules are active.
- The workflow is tested without production credentials and reviewed for untrusted-input paths.
- Repository-only releases are distinguished from future signed mobile application releases.

Until then, releases remain a reviewed manual maintainer operation using the mandatory checklist.

## Verification Cadence

- Review rulesets, access, installed integrations, security settings, and support contacts quarterly.
- Review workflow permissions and action pins on every workflow change.
- Review Dependabot and code-scanning alerts weekly.
- Exercise vulnerability intake and release rollback procedures before a production application release.
