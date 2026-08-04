# ADR-0006: Production Model Selection

- Date: 2026-08-04
- Owners: ML and Mobile Engineering leads
- Decision scope: Production architecture candidate order and acceptance rules

## Status

Accepted

## Context

Phase 1 compared mobile-efficient model families without training or benchmarking a releasable artifact. MobileNetV3-Small offers the preferred compute/maintainability balance; EfficientNet-Lite0 provides a documented mobile fallback; MobileNetV2 is useful as a mature control.

## Decision

Approve this ordered model strategy:

1. **Primary:** MobileNetV3-Small 1.0.
2. **Fallback:** EfficientNet-Lite0, used only if the primary cannot satisfy quality within the approved operating envelope and the fallback passes every gate.
3. **Baseline/control:** MobileNetV2 for tooling, conversion, correctness, and performance comparison; it is not the preferred production model.

This selects architecture candidates, not weights. The release artifact must use a seven-class visible-expression contract unless a later ADR changes the ontology. It must use built-in LiteRT-compatible operators, a versioned preprocessing/calibration manifest, and a single semantic model across supported device tiers.

Production acceptance requires lawful data lineage; locked target-domain evaluation; minimum quality, calibration, abstention, fairness, size, RAM, latency, battery, thermal, compatibility, privacy, and security gates; a model card; artifact integrity metadata; reproducible build/export evidence; and rollback capability. If no candidate passes, no model ships.

## Alternatives Considered

- **MobileNetV2 as primary:** mature and useful, but less favorable than MobileNetV3-Small for the intended resource envelope.
- **EfficientNet-Lite0 as primary:** credible but higher compute is not justified without measured quality benefit.
- **Transformer or hybrid:** deferred pending compelling target-device evidence and operator support.
- **Per-tier semantic models:** rejected for Version 1 because they multiply calibration, fairness, and support risk.

## Consequences

- Phase 2 begins with MobileNetV3-Small integration contracts and uses the other architectures for controlled fallback/baseline work.
- Quantization and delegate choice remain measured artifact properties, not assumptions.
- Architecture novelty cannot override governance or quality minima.
- Candidate failure may narrow device support or block release rather than relax gates.

## Evidence Classification

- **Facts:** the candidate families have established mobile implementations, but no EmotionSense production artifact has been measured.
- **Assumptions:** one seven-class model and at least five fresh estimates per second are sufficient for Version 1.
- **Trade-offs:** the primary favors efficiency; the fallback favors capacity and documented LiteRT tooling.
- **Constraints:** CPU compatibility and all minimum release gates are mandatory.
- **Open Questions:** final input size, precision, trained weights, calibration, and measurable candidate ranking remain Phase 2 work.

## References

- [Model Comparison](../research/MODEL_COMPARISON.md)
- [Model Recommendation](../research/MODEL_RECOMMENDATION.md)
- [Performance Targets](../research/PERFORMANCE_TARGETS.md)
- [Deployment Considerations](../research/DEPLOYMENT_CONSIDERATIONS.md)
