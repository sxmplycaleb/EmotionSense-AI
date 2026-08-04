# Ethics and Responsible AI Bibliography

**Milestone:** 1.4 — Privacy & Ethics  
**Research snapshot:** 2026-08-04  
**Citation style:** Numbered IEEE-like references (`[E##]`)  
**Scope:** AI governance, privacy, fairness, transparency, mobile platform policy, and facial-expression recognition evidence

## Evidence notes

- Official standards/governance sources establish frameworks and legal or platform requirements; they do not validate EmotionSense AI's accuracy or compliance.
- ISO abstracts are cited only for publicly available scope information. The project has not asserted conformance or relied on inaccessible normative text.
- Vendor responsible-AI guidance reflects the vendor's published approach, not independent assurance.
- Legal sources are a research snapshot, not legal advice. Applicability depends on actual behavior, purpose, actors, markets, and effective dates.
- “Facial expression recognition” is used for visible-display classification; “emotion recognition” appears only when a source or law uses that term.

## Governance, standards, and human rights

- **[E01]** E. Tabassi, *Artificial Intelligence Risk Management Framework (AI RMF 1.0)*, NIST AI 100-1, National Institute of Standards and Technology, Jan. 2023. doi: [10.6028/NIST.AI.100-1](https://doi.org/10.6028/NIST.AI.100-1). NIST notes that AI RMF 1.0 is under revision as of the research snapshot.
- **[E02]** National Institute of Standards and Technology, *NIST Privacy Framework: A Tool for Improving Privacy through Enterprise Risk Management, Version 1.0*, Jan. 2020. [Official framework page](https://www.nist.gov/privacy-framework/privacy-framework).
- **[E03]** OECD, *Recommendation of the Council on Artificial Intelligence*, OECD/LEGAL/0449, adopted May 2019, amended May 2024. [Official legal instrument](https://legalinstruments.oecd.org/en/instruments/OECD-LEGAL-0449).
- **[E04]** OECD.AI, “Transparency and explainability (OECD AI Principle 1.3),” accessed Aug. 4, 2026. [Official principle page](https://oecd.ai/en/dashboards/ai-principles/P7).
- **[E05]** UNESCO, *Recommendation on the Ethics of Artificial Intelligence*, adopted Nov. 23, 2021. [Official recommendation](https://www.unesco.org/en/legal-affairs/recommendation-ethics-artificial-intelligence).
- **[E06]** ISO/IEC 42001:2023, *Information technology — Artificial intelligence — Management system*, Dec. 2023. [Public ISO overview](https://www.iso.org/standard/42001.html).
- **[E07]** ISO/IEC 23894:2023, *Information technology — Artificial intelligence — Guidance on risk management*, Feb. 2023. [Public ISO abstract](https://www.iso.org/standard/77304.html).
- **[E08]** ISO/IEC TR 24027:2021, *Information technology — Artificial intelligence (AI) — Bias in AI systems and AI aided decision making*, Nov. 2021. [Public ISO abstract](https://www.iso.org/standard/77607.html).

## Law, regulators, and platform privacy

- **[E09]** European Parliament and Council, Regulation (EU) 2024/1689 laying down harmonised rules on artificial intelligence (Artificial Intelligence Act), July 12, 2024, especially Arts. 3, 5, and 50. [Official EUR-Lex text](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32024R1689). The Act distinguishes mere detection of readily apparent expressions from systems used to infer emotion and prohibits specified workplace/education emotion-inference uses.
- **[E10]** Office of the Data Protection Commissioner, Kenya, “Frequently Asked Questions,” accessed Aug. 4, 2026. [Official ODPC guidance](https://www.odpc.go.ke/faqs/). See the Data Protection Act, 2019 and current ODPC instruments for operative requirements.

## Core scientific evidence

- **[E11]** S. Li and W. Deng, “A Deeper Look at Facial Expression Dataset Bias,” *IEEE Transactions on Affective Computing*, vol. 13, no. 2, pp. 881–893, 2022. doi: [10.1109/TAFFC.2020.3031838](https://doi.org/10.1109/TAFFC.2020.3031838).
- **[E12]** T. Xu, J. White, S. Kalkan, and H. Gunes, “Investigating Bias and Fairness in Facial Expression Recognition,” in *Computer Vision – ECCV 2020 Workshops*, 2020. [Author manuscript](https://arxiv.org/abs/2007.10075).
- **[E13]** L. F. Barrett, R. Adolphs, S. Marsella, A. M. Martinez, and S. D. Pollak, “Emotional Expressions Reconsidered: Challenges to Inferring Emotion From Human Facial Movements,” *Psychological Science in the Public Interest*, vol. 20, no. 1, pp. 1–68, 2019. doi: [10.1177/1529100619832930](https://doi.org/10.1177/1529100619832930).
- **[E14]** C. Guo, G. Pleiss, Y. Sun, and K. Q. Weinberger, “On Calibration of Modern Neural Networks,” in *Proceedings of ICML*, 2017, pp. 1321–1330. [PMLR](https://proceedings.mlr.press/v70/guo17a.html).
- **[E15]** Y. Ovadia et al., “Can You Trust Your Model's Uncertainty? Evaluating Predictive Uncertainty Under Dataset Shift,” in *Advances in Neural Information Processing Systems 32*, 2019. [Proceedings](https://proceedings.neurips.cc/paper/2019/hash/8558cb408c1d76621371888657d2eb1d-Abstract.html).

## Mobile platform privacy

- **[E16]** Google Play, “Provide information for Google Play's Data safety section,” accessed Aug. 4, 2026. [Official Play Console Help](https://support.google.com/googleplay/android-developer/answer/10787469). Includes the on-device-processing definition and developer responsibility for included SDKs.
- **[E17]** Apple Developer, “App Privacy Details,” accessed Aug. 4, 2026. [Official App Store guidance](https://developer.apple.com/app-store/app-privacy-details/). States that data processed only on device is not “collected” for App Privacy answers.
- **[E18]** Android Developers, “Permissions updates in Android 11,” accessed Aug. 4, 2026. [Official documentation](https://developer.android.com/about/versions/11/privacy/permissions). Documents one-time camera permission behavior.
- **[E19]** Apple Developer, “NSCameraUsageDescription,” accessed Aug. 4, 2026. [Official documentation](https://developer.apple.com/documentation/bundleresources/information-property-list/nscamerausagedescription). Requires a message explaining why camera access is requested.

## Industry responsible-AI guidance

- **[E20]** Microsoft, *Responsible AI Standard, v2 General Requirements*, June 2022. [Official standard PDF](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE5cmFl).
- **[E21]** Google, “Our AI Principles,” accessed Aug. 4, 2026. [Official principles](https://ai.google/responsibility/principles/).

These sources support lifecycle governance, human oversight, privacy/security, fairness, transparency, accountability, testing, and monitoring. EmotionSense AI's controls are project decisions and do not imply endorsement or certification by either company.

## Facial-expression culture, fairness, and documentation

- **[E22]** M. N. Dailey, C. Joyce, M. J. Lyons, M. Kamachi, H. Ishi, J. Gyoba, and G. W. Cottrell, “Evidence and a Computational Explanation of Cultural Differences in Facial Expression Recognition,” *Emotion*, vol. 10, no. 6, pp. 874–893, 2010. doi: [10.1037/a0020019](https://doi.org/10.1037/a0020019).
- **[E23]** I. Dominguez-Catena, D. Paternain, and M. Galar, “Metrics for Dataset Demographic Bias: A Case Study on Facial Expression Recognition,” *IEEE Transactions on Pattern Analysis and Machine Intelligence*, vol. 46, no. 8, pp. 5209–5226, 2024. doi: [10.1109/TPAMI.2024.3361979](https://doi.org/10.1109/TPAMI.2024.3361979).
- **[E24]** M. Mitchell et al., “Model Cards for Model Reporting,” in *Proceedings of the Conference on Fairness, Accountability, and Transparency*, 2019, pp. 220–229. doi: [10.1145/3287560.3287596](https://doi.org/10.1145/3287560.3287596).
- **[E25]** T. Gebru et al., “Datasheets for Datasets,” *Communications of the ACM*, vol. 64, no. 12, pp. 86–92, 2021. doi: [10.1145/3458723](https://doi.org/10.1145/3458723).

## Project sources

- **[P01]** EmotionSense AI, [Product Requirements](../PRODUCT_REQUIREMENTS.md), research snapshot Aug. 4, 2026.
- **[P02]** EmotionSense AI, [Architecture](../ARCHITECTURE.md), research snapshot Aug. 4, 2026.
- **[P03]** EmotionSense AI, [Dataset Governance Standard](DATASET_GOVERNANCE.md), research snapshot Aug. 4, 2026.
- **[P04]** EmotionSense AI, [Technical Limitations](TECHNICAL_LIMITATIONS.md), research snapshot Aug. 4, 2026.

## Decision record

### Facts

- The bibliography prioritizes official governance/legal/platform material and peer-reviewed or archival research.
- ISO public pages expose scope and abstract information but not the full standards used for conformance assessment.
- Official vendor pages are authoritative for their own published policies, not for EmotionSense AI's effectiveness.

### Assumptions

- URLs, regulatory summaries, and platform requirements are accurate at the research snapshot and will be rechecked before release.
- The cited literature is applicable as evidence of risk and limitation, not proof of performance for the future production model.
- Market-specific counsel will consult current operative legal texts and guidance.

### Trade-offs

- Numbered citations keep policy documents readable but require readers to consult this bibliography.
- Including public ISO abstracts acknowledges relevant standards without representing that the project has purchased, implemented, or certified against them.
- A curated bibliography is easier to audit but cannot be exhaustive in a changing field.

### Constraints

- Citations do not replace empirical target-domain evaluation, legal advice, or stakeholder participation.
- The project must not claim NIST, ISO, OECD, UNESCO, Google, or Microsoft compliance or endorsement based on citation.
- Time-sensitive legal and platform sources must be revalidated at each material release.

### Open questions

- Will the organization obtain full ISO/IEC 42001, 23894, and 24027 texts for a formal gap assessment?
- Which additional Kenyan, EU/EEA, US state, and other launch-market authorities must counsel add?
- What independent work on FER and disability/accessibility should be added after participatory scoping?
- Who owns quarterly literature, standards, and regulatory monitoring?
