# Open Decisions Register

**Status:** Active after Phase 1 approval  
**Rule:** An open decision is not implicit authorization. Decisions that change claims, sensitive data flow, model semantics, platform boundaries, or hard gates require an ADR.

| ID | Open decision | Priority | Owner role | Target milestone | Blocking scope |
|---|---|---|---|---|---|
| OD-01 | Acquire or collect a consented, commercially usable, representative smartphone production corpus and approve its protocol/rights | Critical | Data Governance Lead with Legal/Privacy | Phase 2.2, before production training | Production model and release |
| OD-02 | Define intended launch population, adult/minor boundary, demographic/capture slices, and minimum sample sizes | Critical | Product and Responsible AI Leads | Phase 2.2 evaluation protocol lock | Fairness claims and release |
| OD-03 | Select exact MobileNetV3-Small artifact, input contract, precision, calibration, thresholds, and rollback bundle | Critical | ML Lead | Phase 2.3 model selection | Production inference and release |
| OD-04 | Confirm Android minimum OS/ABI/RAM/camera profile and supported physical device matrix | High | Mobile Engineering Lead | Phase 2.1–2.3 device validation | Supported Android release |
| OD-05 | Select production LiteRT API and supported standalone runtime versions | High | ML Platform Lead | Phase 2.1 runtime spike | Pipeline implementation baseline |
| OD-06 | Decide Face Detector crop versus Face Landmarker replacement after ablation | Medium | Computer Vision Lead | Phase 2.2 preprocessing validation | Final preprocessing contract |
| OD-07 | Approve GPU device/OS/runtime/model tuples; otherwise remain CPU-only | Medium | Mobile Performance Lead | Phase 2.3 sustained benchmarks | Optional acceleration only |
| OD-08 | Validate and approve iOS adapter, minimum OS/devices, artifact format, and delegate policy | High | iOS Engineering Lead | Phase 2.4, before iOS implementation/release commitment | iOS scope only |
| OD-09 | Set final temporal smoothing, freshness, debounce, and adaptive cadence parameters | Medium | ML/UX Performance Leads | Phase 2.3 end-to-end tuning | Live-result behavior |
| OD-10 | Define launch markets, languages, reading level, and legal/store requirements | High | Product and Legal Leads | Pre-alpha scope lock | External release |
| OD-11 | Complete participatory accessibility evaluation and decide any accessibility benefit claims | High | Accessibility Lead | Pre-alpha | Claims and external release |
| OD-12 | Decide whether model confidence is hidden, banded, or numerical after calibration and comprehension testing | Medium | UX and Responsible AI Leads | Pre-alpha usability review | Confidence presentation only |
| OD-13 | Define platform backup exclusions, OS crash-memory controls, and voluntary support-data retention/deletion | High | Privacy and Security Leads | Phase 2.2 security/privacy review | Privacy gate and release |
| OD-14 | Assign named stop-ship, rollback, incident, dataset, model, privacy, and security authorities | High | Executive/Product Sponsor | Before private alpha | Governance and release |
| OD-16 | Future personalization, on-device adaptation, or federated learning | Low | Product and ML Governance Leads | Post-Version 1; new ADR | Out of initial scope |
| OD-17 | Multi-face or bystander analysis | Low | Product, Privacy, and Responsible AI Leads | Post-Version 1; new ADR | Explicitly unsupported |
| OD-18 | Future transformer/hybrid or larger model upgrades | Low | ML Lead | Responsible iteration after Version 1 | No effect on initial implementation |
| OD-19 | Remote model delivery, cloud inference, accounts, sync, or diagnostics | Low | Architecture, Privacy, Security, and Product Leads | Post-Version 1; separate approval | Prohibited by current baseline |
| OD-20 | Enhanced localization, non-camera alternatives, and broader accessibility improvements | Medium | Accessibility and UX Leads | Alpha/beta iteration | Release scope depends on accepted requirements |

## Phase 2 Entry Interpretation

OD-01 through OD-20 do not block coding as a whole. They limit the dependent activity shown in the final column. Phase 2 should begin with interfaces, privacy/lifecycle controls, synthetic or governed fixtures, benchmark infrastructure, Android runtime feasibility, and requirements reconciliation. No unresolved item may be silently chosen by implementation convenience.

## Resolved Decisions

| ID | Resolution | Evidence |
| --- | --- | --- |
| OD-15 | Resolved in Milestone 2.0: only user-authored reflection records may be retained; all machine-derived data and record-to-session links remain prohibited. | [ADR-0012](../DECISIONS/ADR-0012-User-Authored-Reflection-Records.md) |

## Evidence Classification

- **Facts:** each item comes from a named uncertainty in Milestones 1.0–1.4 or the Phase 1 consolidation.
- **Assumptions:** target milestones express sequencing and may be renamed without changing the required dependency.
- **Trade-offs:** deferring future-scope choices prevents speculative architecture while preserving extensibility through ports and versioned contracts.
- **Constraints:** owners are roles, not people; release-blocking scope remains blocked until evidence and approval exist.
- **Open Questions:** this table is the authoritative list and must be updated when a decision is accepted, superseded, or rejected.
