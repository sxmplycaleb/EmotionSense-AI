# Release Gates

**Status:** Approved baseline  
**Applies to:** Every candidate release; stricter market or platform requirements also apply

## Gate Rules

Each gate requires versioned evidence for the exact application binary, model, preprocessing/calibration bundle, supported device matrix, and intended population. “Minimum” is pass/fail; aspiration is improvement work. Averages do not compensate for failure on a supported baseline device, weakest class, valid fairness slice, privacy check, or critical security finding. An exception requires an ADR, owner, expiry, and approval from every affected discipline; privacy and claim-boundary hard constraints cannot be waived by a routine exception.

## Architecture

| ID | Metric | Target | Measurement method | Pass/Fail criteria |
|---|---|---|---|---|
| A-01 | Dependency-boundary violations | 0 | Static dependency checks plus architecture review | Pass only with no domain import of Flutter/runtime/platform packages and no UI-to-runtime bypass |
| A-02 | Raw-frame boundary violations | 0 | Contract tests, code review, memory/payload inspection | Pass only when raw pixels/crops/tensors remain native and Flutter receives compact typed states |
| A-03 | Analysis backlog | Queue depth ≤1; stale output 0 | Instrument scheduler under overload and lifecycle changes | Pass only with latest-frame/single-flight behavior and all stale generations discarded |
| A-04 | Lifecycle resource leaks | 0 camera images, detector/runtime/delegate, or worker leaks | Repeated start/stop/background/rotation/permission test with profilers | Pass only when all cycles release resources and never restore a prior result |

## Performance

| ID | Metric | Target | Measurement method | Pass/Fail criteria |
|---|---|---|---|---|
| P-01 | Final model asset | ≤6 MB minimum; ≤4 MB aspiration | Exact packaged artifact byte count including metadata | Fail above 6 MB unless a new ADR resets the budget with package evidence |
| P-02 | Incremental pipeline peak RAM | ≤64 MB minimum; ≤40 MB aspiration | Physical-device peak above idle during complete pipeline | Pass on every supported device with camera and delegate buffers included |
| P-03 | Classifier latency | p50 ≤50 ms and p95 ≤80 ms | Warm batch-1 production path after declared warmup | Pass both percentiles on every baseline device |
| P-04 | End-to-end estimate latency | p50 ≤200 ms and p95 ≤350 ms | Capture timestamp to compact-result handoff | Pass both percentiles under supported conditions |
| P-05 | First estimate | p95 ≤1,000 ms | Repeated clean workflow entries, including initialization | Pass for usable or correctly abstained first result |
| P-06 | Sustained analysis/UI | ≥5 estimates/s; ≥90% UI frames within display deadline | Ten-minute session with app frame timings | Pass both measures with no inference work on UI isolate |

## Calibration and Selective Prediction

| ID | Metric | Target | Measurement method | Pass/Fail criteria |
|---|---|---|---|---|
| C-01 | Expected calibration error | ≤0.10; aspiration ≤0.05 | Locked target test set; fixed-bin method plus adaptive-bin sensitivity | Pass overall and report class/slice results with intervals |
| C-02 | Brier/NLL regression | ≤10% relative to calibrated float baseline | Same locked examples before/after optimization | Fail if either materially regresses without approved statistical explanation |
| C-03 | Eligible-frame coverage | ≥50%; aspiration ≥70% | Predeclared quality-eligible target frames | Pass overall and no unreviewed slice collapse |
| C-04 | Non-abstained quality | Accuracy ≥80%; selective macro F1 ≥0.72 | Evaluate only accepted predictions on locked test | Pass both, with 95% confidence intervals reported |
| C-05 | High-confidence error | ≤10%; aspiration ≤5% | Predeclared confidence band/threshold on locked test | Pass overall, by class, and for adequately powered approved slices |
| C-06 | Calibration leakage | 0 test leakage | Manifest audit of train/dev/calibration/threshold/final-test subjects | Pass only with identity-disjoint, role-pinned manifests |

## Model Quality and Fairness

| ID | Metric | Target | Measurement method | Pass/Fail criteria |
|---|---|---|---|---|
| F-01 | Target-domain macro F1 and UAR | Each ≥0.65; aspiration ≥0.75 | Locked, consented, identity-disjoint smartphone holdout | Pass both with 95% intervals and no holdout adaptation |
| F-02 | Per-class recall | Every class ≥0.50; aspiration ≥0.60 | Per-class evaluation with counts/intervals | Any class below minimum fails |
| F-03 | Quantized quality loss | Macro F1 loss ≤0.02; any-class recall loss ≤0.03 | Paired float/quantized inference on identical examples | Both conditions must pass; slice regressions also reviewed |
| F-04 | Worst approved slice gap | Macro-F1 gap ≤0.10 when statistically supportable | Predeclared demographic, capture, accessibility, and device slices | Fail a supported gap above 0.10; insufficient data blocks the related fairness claim |
| F-05 | Abstention disparity | No slice exceeds approved overall abstention rate by >10 percentage points without review | Coverage/reason analysis with sample-size rule and intervals | Pass only with threshold met or explicit stop-ship remediation; no runtime protected-attribute routing |
| F-06 | Domain robustness | Cross-dataset macro-F1 retention ≥70% | Source-separated, ontology-compatible, untuned evaluation | Diagnostic failure blocks broad robustness claims and triggers model review |

## Privacy

| ID | Metric | Target | Measurement method | Pass/Fail criteria |
|---|---|---|---|---|
| PR-01 | ADR-0010 checklist | 100% complete and signed | Evidence review for exact binary and dependencies | Any unchecked/failed/unapproved item blocks release |
| PR-02 | Prohibited persistence | 0 artifacts | Filesystem, database, backup, log, crash, screenshot/test-artifact inspection after all lifecycle paths | Any camera/inference-derived artifact fails |
| PR-03 | Prohibited transmission | 0 flows | Airplane-mode tests and network interception of complete binary | Any undocumented camera/inference, analytics, ad, telemetry, or config traffic fails |
| PR-04 | Transient-state clearing | 100% tested paths clear state | Stop/background/revoke/crash/error/rotation test matrix | Any stale result, buffer, or restorable session state fails |
| PR-05 | Data-flow/document parity | 100% | Compare binary behavior, inventory, notices, store disclosures, threat model | Any material mismatch fails |

## Accessibility

| ID | Metric | Target | Measurement method | Pass/Fail criteria |
|---|---|---|---|---|
| AC-01 | Applicable WCAG 2.2 AA criteria | 100% | Automated scan plus manual mobile accessibility audit | Any unresolved Level A/AA defect in a critical journey fails |
| AC-02 | Non-visual/non-color operation | 100% of capture states and controls | Screen-reader, high-contrast, color-blindness, and text-scale tests | All states, limitations, confidence, camera-active, stop, and errors must be perceivable |
| AC-03 | Text scaling/touch/focus | 200% text without loss; touch targets meet platform AA guidance; logical focus | Manual device matrix | Any blocked consent, stop, unavailable, help, or privacy flow fails |
| AC-04 | Reduced motion and time | No essential information depends on motion; notices readable without timeout | OS reduced-motion and timing tests | Any inaccessible critical information/control fails |
| AC-05 | Claim evidence | No accessibility benefit claim without participatory evidence | Claims inventory and research review | Unsupported benefit claim fails; basic accessibility conformance remains mandatory |

## Security

| ID | Metric | Target | Measurement method | Pass/Fail criteria |
|---|---|---|---|---|
| S-01 | Open vulnerabilities | 0 critical/high exploitable findings; medium findings owned | Dependency/SBOM scan, mobile static/dynamic review, threat-model test | Any unresolved exploitable critical/high finding fails |
| S-02 | Model/manifest integrity | 100% verified; corrupt/incompatible artifacts fail closed | Tamper, substitution, hash/signature, schema mismatch tests | Any unverified load or unversioned fallback fails |
| S-03 | Secrets/sensitive debug assets | 0 | Secret scan, package inspection, build-variant review | Any production secret, real face fixture, debug endpoint, or sensitive capture fails |
| S-04 | Permission and exported surface | Least privilege; 0 unreviewed exported components | Manifest/entitlement review and dynamic permission tests | Any unnecessary permission or reachable sensitive surface fails |
| S-05 | Incident/rollback readiness | Owners and exercised procedure present | Tabletop plus rollback/deactivation test | Missing owner, contact, containment, or rollback evidence fails |

## Battery and Thermal Behavior

| ID | Metric | Target | Measurement method | Pass/Fail criteria |
|---|---|---|---|---|
| B-01 | Incremental battery drain | ≤5 percentage points/15 min above matched preview control; aspiration ≤3 | Repeated paired physical-device tests at fixed brightness/network/background state | Pass on every supported tier with declared variance |
| B-02 | Background work | 0 capture/inference after disallowed lifecycle state | OS energy/camera indicators and instrumentation | Any continued analysis fails |
| T-01 | Thermal state | No critical state; aspiration no serious/critical | Ten- and fifteen-minute sessions, not charging, declared ambient | Any critical state fails |
| T-02 | Sustained latency degradation | p95 ≤35%; aspiration ≤20% | Compare minutes 8–10 with warmed minutes 1–2 | Pass on every supported device; otherwise reduce scope/cadence through reviewed policy |
| T-03 | Thermal semantic stability | 0 threshold/model-semantic changes | Output/config audit under thermal policy | Cadence may reduce or analysis may stop; silent semantic changes fail |

## Documentation

| ID | Metric | Target | Measurement method | Pass/Fail criteria |
|---|---|---|---|---|
| D-01 | Required artifact completeness | 100% | Release manifest audit | Model/dataset cards, lineage, ADRs, limitations, notices, threat/data flow, test/benchmark reports, SBOM/notices, release/rollback notes all present |
| D-02 | Traceability | 100% of release requirements and gates linked to evidence | Requirements-to-test/evidence matrix | Any untraced Must requirement or hard gate fails |
| D-03 | Claims consistency | 0 material inconsistencies | Compare UI, store, privacy, help, marketing, model card, and support content | Any overclaim or stale data-handling statement fails |
| D-04 | Reproducibility | Clean authorized environment reproduces governed artifact and reports hashes | Independent build/export rehearsal | Hash/provenance mismatch or undocumented step fails |

## Testing and Reliability

| ID | Metric | Target | Measurement method | Pass/Fail criteria |
|---|---|---|---|---|
| Q-01 | Automated tests | 100% pass; no quarantined critical tests | CI from clean checkout | Any failed/flaky critical unit, contract, golden, integration, privacy, or security test fails |
| Q-02 | Critical journeys | 100% pass on supported platform/device matrix | Consent → capture → abstain/estimate → stop plus denial/interruption/error flows | Any supported-device critical-journey failure fails |
| Q-03 | Crash/failure rate | 0 crashes; recoverable inference failure <1% | Representative repeated sessions with forced delegate/runtime failures | Any crash or threshold breach fails |
| Q-04 | CPU fallback | 100% of supported devices; one bounded recovery | Force GPU init/invocation failure | Failure to close/recreate/warm CPU or retry loop fails |
| Q-05 | Privacy regression suite | 100% pass | Automated and manual suite referenced by ADR-0010 | Any failure blocks release |

## Evidence Classification

- **Facts:** the metrics trace to Phase 1 performance, model, mobile, privacy, fairness, and ethics documents.
- **Assumptions:** numerical thresholds are Phase 1 minimums pending empirical confirmation; changing them requires recorded evidence and approval.
- **Trade-offs:** strict gates can reduce device coverage and release speed but prevent averages from hiding unsafe behavior.
- **Constraints:** production release requires every applicable hard minimum, not merely a favorable aggregate score.
- **Open Questions:** final device matrix, statistical slice-size rules, and market-specific additions are assigned in [Open Decisions](OPEN_DECISIONS.md).

