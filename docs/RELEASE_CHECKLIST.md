# Release Checklist

Complete this checklist for every repository or application release. Mark an item not applicable only with a recorded rationale and reviewer.

## Repository

- [ ] The intended commit is reviewed, clean, and reproducible from a fresh checkout.
- [ ] Generated, local, secret, and build artifacts are excluded.
- [ ] Repository structure and ownership match current documentation.
- [ ] No unresolved release-blocking TODO, FIXME, placeholder, or duplicate artifact remains.

## Documentation

- [ ] PRD, architecture, roadmap, ADRs, README, changelog, and milestone report agree.
- [ ] Internal links and release references resolve.
- [ ] User-facing claims communicate uncertainty and the non-clinical scope accurately.
- [ ] Release notes describe scope, limitations, validation, and rollback implications.

## CI

- [ ] Required workflows pass on the release commit.
- [ ] Actions are pinned and use least-privilege permissions.
- [ ] Branch protection and required checks are enabled in GitHub.
- [ ] CI contains no exposed secret or sensitive artifact.

## Testing

- [ ] Formatting, static analysis, unit tests, and widget tests pass.
- [ ] Applicable integration, accessibility, migration, security, and performance checks pass.
- [ ] Required device and operating-system coverage is recorded.
- [ ] Enabled, disabled, rollback, and unavailable states are tested where feature flags apply.

## Dependencies

- [ ] Direct and transitive dependencies are locked and reviewed.
- [ ] Dependency, license, vulnerability, and provenance findings are resolved or accepted by an owner.
- [ ] Flutter, Dart, packages, and GitHub Actions versions are documented consistently.
- [ ] Model and dataset provenance is complete when applicable.

## Security

- [ ] Threat model and privacy review cover changed data flows and permissions.
- [ ] Secret scanning and sensitive-data review pass.
- [ ] Security reporting and incident ownership are current.
- [ ] Signing keys and protected environments are separated from source control.

## Versioning

- [ ] Application, package, release-note, tag, and changelog versions agree.
- [ ] The version follows the approved version strategy.
- [ ] Database, model, API, and configuration compatibility is recorded when applicable.
- [ ] Upgrade and rollback paths are documented.

## GitHub Settings

- [ ] CODEOWNERS identities and required reviews are effective.
- [ ] Private vulnerability reporting is enabled.
- [ ] Community health files render correctly.
- [ ] Milestone, project board, labels, release permissions, and environments are configured.

## Tagging

- [ ] The release commit is immutable and identified.
- [ ] The annotated tag uses the approved version and release title.
- [ ] Tag signing and provenance requirements pass.
- [ ] Tag and artifact checksums are recorded when applicable.

## Release

- [ ] Approval is recorded from required product, engineering, security/privacy, accessibility, ML, and release owners.
- [ ] Release artifacts are reproducible, signed, and verified when applicable.
- [ ] Known limitations and support expectations are published.
- [ ] Rollout, monitoring, incident response, rollback, and communication owners are ready.
- [ ] Post-release verification is complete and the next milestone is linked.

## Approval Record

| Role | Approver | Status | Evidence |
| --- | --- | --- | --- |
| Product |  | Pending |  |
| Engineering |  | Pending |  |
| Security and privacy |  | Pending |  |
| Accessibility |  | Pending |  |
| ML governance, if applicable |  | Not applicable |  |
| Release owner |  | Pending |  |
