# Technical Debt Register

**Status:** Accepted at Phase 1 exit  
**Review cadence:** At every implementation milestone and release review

| ID | Description | Reason accepted | Impact | Priority | Planned resolution milestone |
|---|---|---|---|---|---|
| TD-01 | Android support floor (API 24, arm64, 3 GB) is provisional | Dependency/runtime artifacts and devices were intentionally not added in documentation-only Phase 1 | May narrow reach or force dependency/support changes | High | Phase 2.1 dependency and device feasibility spike |
| TD-02 | iOS architecture is preserved but unvalidated | Android-first reduces initial platform uncertainty | iOS cannot be promised or released; adapter assumptions may diverge | High | Phase 2.4 iOS feasibility, before any iOS scope commitment |
| TD-03 | Exact LiteRT API (`CompiledModel` vs `Interpreter`) is unresolved | Selection requires actual artifact and lifecycle benchmarks | Adapter rework or runtime compatibility risk | High | Phase 2.1 runtime spike |
| TD-04 | Face Detector six-keypoint crop versus Face Landmarker is unmeasured | Dense geometry may add cost without target-quality gain | Alignment robustness or unnecessary compute/privacy surface | Medium | Phase 2.2 preprocessing ablation |
| TD-05 | Production corpus and commercially distributable lineage do not exist | Acquisition was outside research review and requires separate governance | Blocks production weights and release | Critical | Phase 2.2 data acquisition approval, before production training |
| TD-06 | Model input size, quantization, calibration, and thresholds are provisional | They depend on governed data and exact device/runtime behavior | Quality, fairness, size, and latency may change | Critical | Phase 2.3 model candidate selection |
| TD-07 | GPU allowlist is empty | Allowlisting without an exact model/device benchmark would be speculative | CPU-only performance until validated; acceleration reach unknown | Medium | Phase 2.3 device benchmark |
| TD-08 | Temporal smoothing/cadence parameters are not fitted | User-perceived stability and lag need live-pipeline evidence | Flicker, lag, stale confidence, or excess energy | Medium | Phase 2.3 end-to-end tuning |
| TD-09 | Statistical minimums for subgroup/intersectional gates are undefined | Depend on launch population and available consented samples | Some fairness claims/gaps cannot be resolved | High | Phase 2.2 evaluation protocol lock |
| TD-10 | Participatory accessibility and claims comprehension studies are outstanding | They require a usable prototype and affected participants | Accessibility barriers or misleading wording may remain | High | Pre-alpha usability/accessibility review |
| TD-11 | Backup, OS crash-memory, and sanitized support-data controls need platform verification | Documentation established policy but no binaries exist | Secondary privacy leakage risk | High | Phase 2.2 privacy/security implementation review |
| TD-12 | No production telemetry creates an operational evidence gap | Accepted to preserve local-only privacy | Field failures and subgroup harm are harder to observe | Medium | Pre-beta privacy-preserving operations plan; no telemetry implied |
| TD-13 | Launch jurisdictions, languages, and minors boundary are not fixed | Product/market decisions were outside engineering evidence | Legal, localization, consent, and test scope remain variable | High | Pre-alpha product/legal scope lock |
| TD-14 | Repository roadmap terminology predates Milestones 1.0–1.5 | Existing governance was not replaced during this consolidation | Phase naming can confuse traceability | Low | Next documentation governance revision |

## Acceptance Rules

- Critical debt blocks the dependent production activity or release; it is not permission to lower a gate.
- High debt has an owner and must be resolved before the named scope ships.
- Medium/low debt may be carried only with documented impact and review.
- Closing an item requires linked evidence or a superseding ADR, not a status assertion.

## Resolved Debt

| ID | Resolution | Evidence |
| --- | --- | --- |
| TD-15 | Milestone 2.0 reconciled history requirements: only user-authored reflections may be retained, with no machine-derived fields or session links. | [ADR-0012](../DECISIONS/ADR-0012-User-Authored-Reflection-Records.md), [Milestone 2.0 Report](../MILESTONES/2.0-requirements-reconciliation.md) |

## Evidence Classification

- **Facts:** these gaps are explicitly identified by previous milestone documents.
- **Assumptions:** the named resolution milestones reflect the expected dependency order, not calendar commitments.
- **Trade-offs:** accepting bounded debt enables implementation while keeping production-critical gaps visible.
- **Constraints:** debt cannot override claim, privacy, provenance, or hard release gates.
- **Open Questions:** ownership roles and decisions are tracked in [Open Decisions](OPEN_DECISIONS.md).
