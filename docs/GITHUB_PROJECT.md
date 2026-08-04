# GitHub Project Plan

## Purpose

The initial GitHub Project provides a single, reviewable flow for product, engineering, ML, privacy, security, accessibility, and release work. The board tracks outcomes; source-of-truth requirements and decisions remain in the PRD, architecture, roadmap, and ADRs.

## Board Columns

| Column | Entry criteria | Exit criteria |
| --- | --- | --- |
| Backlog | A problem or opportunity is captured. | Scope, owner, dependencies, and priority are clear. |
| Ready | Acceptance criteria and required reviews are identified. | Work begins within an approved milestone. |
| In Progress | An owner is actively working on the issue. | A reviewable pull request or evidence package exists. |
| Review | Implementation or documentation is ready for peer review. | Required reviewers approve and requested changes are resolved. |
| Testing | Review is complete and validation is in progress. | Required automated and manual evidence passes. |
| Done | Acceptance and release evidence are complete. | Item remains closed unless new evidence requires follow-up. |

Limit work in progress and move blocked items back to `Ready` with the blocker documented. Security reports remain private and must not be represented by public issues containing sensitive details.

## Recommended Fields

- Status
- Owner
- Priority
- Workstream
- Target milestone
- Risk level
- Required review
- Related requirement or ADR

## Recommended Milestones

| Milestone | Planning outcome |
| --- | --- |
| v0.1.0 Foundation | Public repository, governance, Flutter foundation, and release-readiness evidence. |
| v0.2 Dataset Research | Ethical sourcing, licensing, representativeness, evaluation design, and dataset governance evidence. |
| v0.3 Model Training | Reproducible training, evaluation, calibration, fairness, provenance, and model-card evidence. |
| v0.4 On-device AI | Validated TensorFlow Lite/MediaPipe integration contracts and physical-device performance evidence. |
| v0.5 Camera Pipeline | Explicit foreground capture, permissions, lifecycle, quality gates, and transient-media controls. |
| v1.0 Production Release | PRD acceptance, privacy, security, accessibility, model, device, operational, and release gates complete. |

These are planning milestones, not delivery dates or pre-approval of product functionality. Work begins only when its roadmap phase and governing decisions permit it.

## Operating Rules

- Every item links to a requirement, risk, decision, or measurable engineering outcome.
- Explicit non-goals prevent silent scope expansion.
- High-risk work identifies privacy, security, accessibility, responsible-AI, and rollback reviewers before entering `Ready`.
- Pull requests update linked issues and attach validation evidence.
- Feature flags are delivery controls, not substitutes for approvals or requirements.
- `Done` requires documentation and changelog updates where applicable.
