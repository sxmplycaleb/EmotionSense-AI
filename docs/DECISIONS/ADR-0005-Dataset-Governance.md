# ADR-0005: Dataset Governance

- Date: 2026-08-04
- Owners: ML, Data Governance, Privacy, and Legal leads
- Decision scope: Research and production dataset eligibility

## Status

Accepted

## Context

No reviewed public FER dataset simultaneously provides clear production-model rights, representative smartphone coverage, strong annotation evidence, and adequate fairness provenance. Scientific usefulness does not grant legal permission to distribute learned weights.

## Decision

Adopt a license-gated, source-aware dataset strategy:

- AffectNet is approved for primary non-commercial research training only after its agreement and access controls are recorded.
- RAF-DB is approved for non-commercial research fine-tuning and separate evaluation only after its agreement is recorded.
- FER+ may be used for ambiguity and low-resolution research only after the underlying FER2013 image rights are cleared.
- FER2013, CK+, JAFFE, and SFEW/AFEW are documentation or protocol-limited benchmarks unless their exact versions and rights are approved.
- ExpW is excluded until an official source, exact version, and operative license are verified.
- A production model requires a new or procured consented, commercially usable, representative smartphone corpus with explicit rights to train, derive, embed, distribute, update, and, where applicable, sublicense on-device model weights.

Every dataset and derivative must have provenance, immutable version identifiers, checksums, license records, ontology mappings, identity-disjoint split manifests where lawful, retention/deletion rules, a dataset card, and a lineage link to every dependent model. Restricted images must never enter Git or consumer sync storage. Reproducible experiments must pin data, split, preprocessing, seed, environment, and model identifiers.

## Alternatives Considered

- **Single public dataset:** rejected because it concentrates bias and does not solve production rights or target-domain validity.
- **Naive concatenation:** rejected because labels, sources, rights, and leakage risks differ.
- **Treat public availability as permission:** rejected; papers and mirrors are not license grants.
- **Source-aware research followed by a governed production corpus:** accepted.

## Consequences

- Phase 2 research may proceed with cleared research datasets, but those assets do not authorize a production release.
- Production data acquisition is a release dependency and a named open decision.
- Governance increases legal, storage, review, and reproducibility work.
- A provenance defect can freeze a dataset, model, or release and may require retraining.

## Evidence Classification

- **Facts:** reviewed public datasets have material licensing, consent, demographic, or mobile-domain limitations.
- **Assumptions:** production distribution may be commercial, so the stricter rights standard applies.
- **Trade-offs:** source separation adds experiment cost but makes domain and license failures visible.
- **Constraints:** unresolved or non-commercial ancestry cannot enter distributed production weights without written clearance.
- **Open Questions:** production corpus acquisition, launch population, storage custodian, and legal treatment of derived weights remain unresolved.

## References

- [Dataset Comparison](../research/DATASET_COMPARISON.md)
- [Dataset Recommendation](../research/DATASET_RECOMMENDATION.md)
- [Dataset Governance](../research/DATASET_GOVERNANCE.md)
- [Dataset References](../research/DATASET_REFERENCES.md)
