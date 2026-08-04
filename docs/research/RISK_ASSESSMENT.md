# Privacy, Ethics, and Responsible AI Risk Assessment

**Milestone:** 1.4 — Privacy & Ethics  
**Research snapshot:** 2026-08-04  
**Method:** Qualitative pre-implementation risk register informed by NIST AI RMF and ISO/IEC 23894 [E01], [E07]  
**Status:** Initial assessment; owners and acceptance criteria required before implementation

## Method and rating scale

This register evaluates foreseeable harm to individuals, groups, the project, and society. Ratings are project judgments, not measured probabilities or legal conclusions.

ISO/IEC 42001 provides a public management-system framing for establishing, maintaining, and continually improving organizational AI governance [E06]. EmotionSense AI does not claim conformance; the reference supports assigning owners and repeatable review gates.

| Rating | Likelihood meaning | Impact meaning |
|---|---|---|
| Low | Uncommon under intended conditions | Limited, reversible inconvenience |
| Medium | Plausible during product lifetime | Meaningful harm requiring remediation |
| High | Expected without strong controls | Serious harm to rights, dignity, access, safety, or trust |
| Critical impact | — | Severe, potentially irreversible or systemic harm |

Residual risk assumes every listed mitigation is implemented and verified. “Prohibited use” is a preventive control; it does not mean the project can control every independent misuse after distribution.

## Risk register

| ID | Category | Risk description | Likelihood | Impact | Primary mitigation | Residual risk |
|---|---|---|---|---|---|---|
| R01 | Ethical/technical | Users treat a visible-expression label as verified inner emotion | High | Critical | Expression-only claims; persistent notices; no emotion percentages; comprehension testing; unsupported high-stakes uses | Medium—labels can still invite anthropomorphic interpretation |
| R02 | Fairness | Dataset imbalance produces demographic or intersectional disparities | High | High | Governed lineage; target-domain slice evaluation; predeclared disparity gates; narrow release scope; abstention | Medium—small groups and unobserved attributes remain uncertain |
| R03 | Fairness | Cultural/context variation causes systematic misinterpretation | High | High | Avoid internal-state claims; local participatory research; cultural review; disclose limits; multi-rater/context evaluation | Medium—culture is dynamic and cannot be exhaustively represented |
| R04 | Technical | Domain shift from datasets to mobile cameras creates confident errors | High | High | Locked smartphone holdout; end-to-end post-optimization tests; quality/OOD gates; selective-risk thresholds | Medium—novel devices/environments remain |
| R05 | Technical | Softmax confidence is miscalibrated or degrades after quantization/update | High | High | Independent post-optimization calibration; class/slice reliability testing; versioned thresholds; regression gates | Medium—shift can defeat calibration |
| R06 | Product | Forced prediction when input is invalid or ambiguous | Medium | High | First-class unavailable state; layered input-quality and confidence gates; no top-class fallback | Low–medium—threshold defects remain possible |
| R07 | Privacy | Frames/crops/results leak through logs, crash dumps, backups, screenshots, or memory | Medium | Critical | No persistence; sensitive-log tests; no crash SDK by default; backup controls; lifecycle buffer clearing; incident plan | Low–medium—OS and user-created captures are not fully controlled |
| R08 | Privacy/security | Third-party SDK transmits sensitive or identifying data | Medium | Critical | Minimize/omit SDKs; dependency/data-flow review; binary network tests; deny release on undisclosed traffic | Low—supply-chain changes require continuing review |
| R09 | Privacy | Camera is activated unexpectedly or continues in background | Medium | Critical | Just-in-time permission; active indicator; foreground-only lifecycle; one-action stop; revoke/background tests | Low—platform/lifecycle defects remain possible |
| R10 | Consent | Device owner analyzes a bystander or non-consenting person | High | High | Self-use policy; one-face gate; pause on multiple faces; persistent consent notice; no gallery/remote feeds | Medium—one non-consenting face may still be presented |
| R11 | Rights | Coercive use on employees, students, children, patients, detainees, or dependents | Medium | Critical | Explicit prohibition; no enterprise monitoring features/export/API/history; misuse review and enforcement | Medium—downstream misuse cannot be fully prevented |
| R12 | Misuse/legal | Use for hiring, education, policing, immigration, insurance, credit, health, or safety decisions | Medium | Critical | Unsupported-use policy; no integrations/export; clear licensing/marketing; reports and response process | Medium—screenshots/manual misuse remain possible |
| R13 | Misuse | Expression output used to infer deception, threat, consent, intent, or personality | High | Critical | Never produce these traits; construct notice; ban consequential use; claims and support training | Medium—users may overinterpret simple labels |
| R14 | Privacy/ethics | Feature expands to identification, tracking, sensitive-trait inference, or profiling | Low–medium | Critical | Architectural prohibition; no embeddings/reference database; ADR and ethical/legal review for scope changes | Low under baseline; critical if boundary changes |
| R15 | Legal | Product is misclassified or violates biometric, privacy, AI, consumer, child, or sector rules | Medium | Critical | Market-specific counsel; DPIA/impact assessment; accurate product behavior/claims; launch-jurisdiction register | Medium—laws and interpretations evolve |
| R16 | Legal | Workplace/education emotion inference conflicts with EU AI Act prohibitions | Medium | Critical | Global product prohibition; do not sell/market integrations; monitor guidance; qualified EU review [E09] | Low for intended use; medium for downstream misuse |
| R17 | Data governance | Training data lacks consent, license, provenance, or distributable-model rights | Medium | Critical | Default-deny dataset gates; lineage register; legal/ethics approval; retrain/withdraw on defects | Medium—legacy dataset provenance can remain unclear |
| R18 | Security | Model or calibration assets are tampered with or substituted | Medium | High | Trusted delivery, hashes/signatures, pinned contracts, safe stop on integrity failure, rollback | Low–medium—device compromise remains out of full control |
| R19 | Technical/operational | Device, camera, preprocessing, or thermal differences create inconsistent behavior | High | High | Device tiers; sustained testing; preprocessing golden tests; supported envelope; safe cadence reduction/stop | Medium—mobile ecosystem remains heterogeneous |
| R20 | Accessibility | Facial difference, disability, coverings, or interaction design causes exclusion or stigmatizing feedback | Medium–high | High | Participatory review; accessible controls/notices; neutral failures; no diagnostic interpretation; publish gaps | Medium—evidence may be sparse |
| R21 | Socioeconomic | Lower-cost devices receive worse coverage or more errors | Medium–high | High | Per-tier reporting; minimum compatibility gate; no degraded silent mode; optimize within fairness constraints | Medium—hardware inequality persists |
| R22 | Transparency | Store, onboarding, UI, and marketing claims become inconsistent after updates | Medium | High | Single claims inventory; versioned notices; cross-functional release gate; material-change communication | Low–medium—distribution metadata can lag |
| R23 | Operational | No named owner responds to complaints, vulnerabilities, or harmful regressions | Medium | High | Assign policy/model/privacy/security owners; escalation SLA; stop-ship and rollback authority | Low after governance is staffed |
| R24 | Operational | No production telemetry hides field failures and subgroup harms | High | Medium–high | Consent-based studies; local diagnostics; voluntary text reports; device lab; independent audits; literature review | Medium—privacy-preserving evidence remains incomplete |
| R25 | Privacy | Opt-in diagnostics or support later creates a shadow data pipeline | Medium | High | Treat as material policy change; data inventory, consent, minimization, retention, deletion, vendor review | Low if baseline remains; medium after introduction |
| R26 | Model | Model memorizes or leaks training examples through extraction/reverse engineering | Low–medium | High | Dataset rights/provenance; memorization/privacy testing; minimize model access surfaces; response/retraining plan | Medium—complete proof of non-memorization is difficult |
| R27 | Ethics | Expression labels reinforce stereotypes or prompt self-surveillance/distress | Medium | High | Neutral language; no normative “good/bad” scores; user research; easy stop; avoid engagement loops/history | Medium—individual psychological response varies |
| R28 | Security/privacy | Malicious input, replay, or presentation attack produces misleading output | High | Medium–high | Declare unsupported; liveness claims prohibited; quality/anomaly tests; never use for access or safety | Medium—low-stakes demo can still be fooled |

## Highest-priority risk treatments

1. **Construct overclaim (R01/R13):** make visible-expression terminology and non-emotion limitations non-negotiable across model ontology, UX, documentation, and marketing.
2. **Coercive and consequential use (R11/R12/R16):** prohibit these uses rather than attempting to mitigate them through accuracy or human review.
3. **Sensitive camera disclosure (R07–R10):** retain local-only, transient, foreground-only processing; omit production telemetry and unnecessary SDKs.
4. **Fairness and shift (R02–R05/R19–R21):** require target-domain, post-optimization, slice-aware calibration and selective-risk evidence before release.
5. **Dataset lineage (R17/R26):** block a production model until every ancestor has documented rights, consent/provenance review, and distribution clearance.

## Risk acceptance and escalation

- Critical-impact risks require a named owner, documented prevention controls, independent review where appropriate, and executive/product acceptance before release.
- A legal prohibition, unresolved model/data right, undisclosed data transfer, absence of consent, or failure of a predefined fairness/safety gate is **not acceptable residual risk**; it blocks release.
- Any incident involving unexpected capture, storage, transmission, identification, high-stakes use, or systematic subgroup harm triggers containment, preservation of non-sensitive evidence, impact assessment, notification review, remediation, and possible withdrawal.
- The register must be reviewed when intended use, data flow, model, dataset, ontology, threshold, device scope, market, regulation, or third-party component changes, and at least once per release cycle.

## Decision record

### Facts

- Governance sources treat AI risk as context-dependent and lifecycle-wide, spanning validity, privacy, fairness, transparency, security, and accountability [E01], [E03], [E05], [E07].
- FER has documented construct, dataset-bias, cultural, calibration, and domain-shift limitations [E11]–[E15], [E22], [E23].
- Local-only processing reduces server exposure but does not prevent coercion, misleading inference, on-device leakage, or downstream misuse.

### Assumptions

- The baseline remains a self-use, adult, one-face, low-stakes mobile experience.
- No export, API, account, saved history, telemetry, or enterprise administration exists.
- Proposed mitigations will be translated into testable requirements during Milestone 1.5 and implementation planning.

### Trade-offs

- Strong misuse boundaries reduce potential integrations and revenue but avoid foreseeable severe harm.
- No production telemetry protects privacy while leaving operational blind spots.
- Narrow device/population support can improve evidence quality while excluding some users.
- Conservative abstention reduces confident errors but can distribute unavailability unevenly.

### Constraints

- This assessment is research guidance, not legal advice or a completed DPIA.
- Likelihood and residual-risk ratings lack production evidence and must be revisited.
- Prohibited use cannot be treated as mitigated solely by a disclaimer.
- Unresolved critical risks block release.

### Open questions

- Who owns each risk and who has stop-ship/rollback authority?
- What quantitative risk appetite and release gates apply to R02–R06 and R19–R21?
- Which launch jurisdictions and age groups determine the legal assessment?
- What independent legal, ethics, fairness, accessibility, privacy, and security reviews are budgeted?
- How will reports of downstream misuse be received, investigated, and acted upon without collecting excess personal data?
