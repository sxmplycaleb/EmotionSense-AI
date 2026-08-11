# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project intends to follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html) once versioned releases begin.

## [Unreleased]

### Added

- Front-facing, local-only camera preview foundation with lifecycle-safe Riverpod state and camera-service tests.
- ADR-0013 and Milestone 2.1 camera/capture evidence.
- ADR-0012 and Milestone 2.0 requirements-reconciliation evidence.
- Pinned CodeQL analysis for GitHub Actions workflows.
- Citation metadata, support guidance, issue-template configuration, and a GitHub hardening runbook.
- Milestone 0.5 production-hardening audit and manual GitHub configuration checklist.

### Changed

- Reconciled reflection/history requirements: only user-authored records may be retained; inference-derived data remains transient and prohibited from persistence.
- Connected README status badges to the configured GitHub repository.
- Added Conventional Commit prefixes to weekly Dependabot updates.
- Updated security, contribution, release, and milestone documentation to reflect the tagged public foundation.

### Security

- Documented branch, tag, Actions, code-scanning, secret-scanning, vulnerability-reporting, and release controls requiring repository-owner configuration.

## [0.1.0] - 2026-08-04

### Added

- Initial engineering documentation foundation.
- Product requirements, architecture, roadmap, coding standards, contribution guide, and ADR process.
- Project README, changelog, and MIT license.
- Repository governance, community health templates, ownership, editor standards, and Dependabot configuration.
- Flutter 3.44.8 mobile foundation under `apps/mobile` with Material 3, Riverpod, GoRouter, strict analysis, and a smoke test.
- Empty feature-first Clean Architecture boundaries and reserved repository workspaces.
- Pinned GitHub Actions validation for dependency resolution, formatting, analysis, and tests.
- Release notes, mandatory release checklist, GitHub Project plan, recommended labels, and ADR-0003.

### Changed

- Promoted Repository Foundation to immediately follow Documentation & Governance under ADR-0002.
- Aligned the mobile application version with the `v0.1.0-foundation` repository release.
- Audited repository documentation, links, ignore rules, versions, governance, and release metadata.

Repository compare links are intentionally omitted until the real GitHub repository URL is available.
