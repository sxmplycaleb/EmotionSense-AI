# Facial Expression Dataset Comparison

**Milestone:** 1.1 Dataset Validation  
**Last reviewed:** 2026-08-04  
**Scope:** Publicly available still-image facial expression recognition (FER) datasets  
**Related:** [Dataset Recommendation](DATASET_RECOMMENDATION.md) · [Dataset Governance](DATASET_GOVERNANCE.md) · [Dataset References](DATASET_REFERENCES.md) · [FER Literature Review](FER_LITERATURE_REVIEW.md)

## 1. Interpretation and terminology

This review evaluates datasets for an offline, privacy-first mobile application. “Emotion class” below preserves each dataset’s terminology, but EmotionSense AI must present outputs as **facial-expression estimates**, not proof of an internal emotional state. Facial movements are context-dependent and cannot, by themselves, establish what a person feels [D21].

Each dataset section separates:

- **Facts:** claims supported by the cited paper, official site, or agreement.
- **Assumptions:** project-specific working premises that require validation.
- **Trade-offs:** advantages obtained at a corresponding cost or limitation.
- **Open questions:** unresolved facts or decisions that block unrestricted use.

“Commercial use unresolved” means no adequate grant was verified. It does not mean that use is prohibited in every circumstance; it means EmotionSense AI must not rely on that dataset for a releasable model until the rights are documented. Dataset access is not permission to redistribute images or derived models.

## 2. At-a-glance comparison

| Dataset | Institution / year | Scale | Setting | Annotation | Rights status for EmotionSense AI | Best-supported role |
|---|---|---:|---|---|---|---|
| FER2013 | ICML workshop challenge / 2013 | 35,887 images | Web, 48×48 grayscale | Single categorical labels; noisy | Original image license not clearly established | Legacy benchmark |
| FER+ | Microsoft / 2016 | 35,887 relabeled FER2013 images | Same as FER2013 | 10 crowd votes/image; uncertainty classes | MIT repository terms do not resolve FER2013 image rights | Auxiliary label study; benchmark |
| RAF-DB | BUPT PRIS / 2017 | 29,672 images; 15,339 basic subset | In the wild | About 40 crowd labels/image; distributions | Explicit non-commercial research restriction | Research fine-tuning and cross-dataset benchmark |
| AffectNet | University of Denver / 2017 | >1M collected; 450,000 manually annotated | In the wild | Expert categorical and valence/arousal labels | Academic agreement limits use to non-commercial research/education | Research primary training candidate |
| CK+ | University of Pittsburgh/CMU / 2010 | 593 sequences, 123 subjects; 327 validated | Controlled, posed sequence | FACS-coded peaks and validated categories | Current operative agreement must be obtained and reviewed | Controlled benchmark only |
| JAFFE | Kyushu University / 1998 | 213 images, 10 subjects | Controlled, posed | 62 observer ratings/image | Non-commercial scientific research only | Legacy controlled stress test |
| ExpW | CUHK / 2016–2018 | 91,793 faces | In the wild | Manual seven-class labels | Authoritative current license/access route not verified | Conditional auxiliary dataset; otherwise exclude |

Scale is not directly comparable: AffectNet’s collected, detected, and manually annotated totals differ; CK+ is a sequence dataset; FER+ supplies labels but not image rights.

## 3. Availability and licensing comparison

| Dataset | Current official route | License type / permitted purpose | Commercial use | Attribution | Redistribution and legal considerations |
|---|---|---|---|---|---|
| FER2013 | Official Kaggle competition page [D02] | Operative image license not verified from reviewed official materials | **Unresolved** | Cite challenge paper [D01]; any additional requirement unresolved | Do not redistribute. Web-image provenance and competition terms require legal review. |
| FER+ | Archived Microsoft repository [D04] plus separately obtained FER2013 images | MIT repository license [D05], but separate underlying image rights | **Unresolved for the combined dataset** | Retain MIT notice and cite FER+ paper [D03]; comply separately with FER2013 terms | Repository does not supply images. Annotation rights cannot cure source-image rights. |
| RAF-DB | Official BUPT PRIS request/agreement [D07] | Restricted academic/non-commercial research | **No under standard terms** | Required paper/database citation | No copying, sale, commercial use, or redistribution; internet images are not owned by the laboratory; single-site/access restrictions apply. |
| AffectNet | Official request form and academic agreement [D09], [D10] | Restricted non-commercial research and education | **No under academic agreement** | Required paper/database citation and agreement compliance | No general redistribution grant; access, storage, retention, and downstream model rights require agreement review. |
| CK+ | Signed-access route described by original paper [D11]; current operative route requires confirmation | Agreement-controlled; current exact terms unresolved | **Unresolved** | Cite CK+ paper | Do not redistribute or assume derived-model permission until the executed agreement is reviewed. |
| JAFFE | Official KASRL page / Zenodo record [D13], [D14] | Free for non-commercial scientific research | **No under stated terms** | Cite official dataset and requested paper | Do not redistribute or publish images outside the terms; Zenodo hosting does not create broader image rights. |
| ExpW | Original paper identified [D15]; durable official download/license not verified | Unknown | **Unresolved** | Cite original paper if later authorized | Mirrors are not authoritative. Exclude until provenance, agreement, image rights, and derived-model terms are verified. |

The table records the most conservative verified interpretation as of the review date. It is evidence for an engineering gate, not legal advice.

## 4. FER2013

### Facts

**Overview and purpose.** FER2013 was released for the 2013 facial expression recognition challenge associated with the ICML Representation Learning Workshop. It was intended to benchmark representation learning under a compact, difficult image format [D01], [D02]. The challenge data were assembled from web image-search results, then cropped and converted to 48×48 grayscale faces.

**Statistics and splits.** It contains 35,887 images in seven classes: angry, disgust, fear, happy, sad, surprise, and neutral. The official split contains 28,709 training, 3,589 public-test, and 3,589 private-test examples [D01], [D02]. Subject identifiers are not provided. Consequently, subject independence and identity overlap cannot be audited from official metadata.

**Annotation quality.** The release provides one categorical target per image, not annotator votes, confidence, or intensity. Published usage has repeatedly identified mislabeled, ambiguous, duplicate, non-face, and severely degraded samples. Happiness is much more frequent than disgust, creating substantial class imbalance [D01], [D18]. The collection method offers real-world nuisance variation but does not document a systematic demographic sampling plan.

**Diversity and mobile suitability.** Web imagery includes lighting, pose, occlusion, age, apparent gender, and image-quality variation. However, demographic counts, geography, capture device, camera distance, and consent provenance are undocumented. The low resolution is relevant to small-face and constrained-model experiments, but it is not representative of a modern front-facing smartphone stream: it removes color, fine detail, sensor characteristics, and temporal context.

**Availability and rights.** The official source is the Kaggle competition page [D02]. The reviewed official sources did not expose a sufficiently clear license covering the underlying images, commercial model training, attribution, or redistribution. Licenses displayed by third-party mirrors cannot establish rights to the original corpus.

### Assumptions

- EmotionSense AI will treat the official split as immutable when reporting legacy results.
- A legal review will classify FER2013 as restricted until the original image rights and competition terms are archived in the dataset register.
- A 48×48 benchmark may reveal low-resolution failure modes, but it will not predict target-device performance.

### Trade-offs

- **Strengths:** small storage footprint; fast iteration; entrenched benchmark; challenging low-resolution faces; seven classes align with the common basic-expression ontology.
- **Weaknesses:** noisy single labels, strong class imbalance, unknown identities and demographics, obsolete capture representation, unresolved rights, and no confidence information.

### Recommended usage

**Legacy benchmarking only.** Do not use it as the primary training, fine-tuning, or release-validation dataset. It may be reported for comparison with historical literature if access terms are cleared and results explicitly state its label and identity limitations.

### Open questions

- What exact terms governed the original competition download and downstream model use?
- Can duplicate and cross-split identity leakage be measured without violating usage terms?
- Does performance on the 48×48 grayscale domain correlate with the intended smartphone domain?

## 5. FER+

### Facts

**Overview and purpose.** FER+ is Microsoft’s relabeling of FER2013. Ten crowd workers labeled every image. The released CSV stores vote counts for neutral, happiness, surprise, sadness, anger, disgust, fear, contempt, unknown, and not-a-face, enabling majority, multi-label, or label-distribution training [D03], [D04]. It retains the FER2013 image order and official usage split; Microsoft does not redistribute the source images.

**Statistics and annotation quality.** FER+ covers the same 35,887 images and 48×48 grayscale domain. Ten independent votes provide materially better evidence of disagreement than FER2013’s single target. Unknown and not-a-face votes expose invalid or ambiguous cases rather than forcing every image into a basic class [D03]. The relabeling does not repair the source corpus’s undocumented subjects, demographics, provenance, low resolution, or duplicates.

**Availability and rights.** The official Microsoft repository is archived and read-only as of June 2024 [D04]. Its MIT license covers the repository’s software and associated materials [D05], but the project requires users to obtain FER2013 images separately. The MIT text must not be interpreted as a grant over those third-party images. Commercial use and redistribution therefore remain unresolved unless both the annotation asset and source-image rights are cleared.

**Diversity and mobile suitability.** These properties are inherited from FER2013: varied web conditions, but no auditable demographic or device distribution. Vote distributions are valuable for confidence experiments, while the image domain remains a weak approximation of front-camera video.

### Assumptions

- FER+ vote counts are more useful than a hard majority label for studying ambiguity and abstention.
- The archived repository can remain scientifically reproducible if the exact commit and label-file checksum are recorded.
- No model trained on FER+ is releasable solely because the repository uses MIT terms.

### Trade-offs

- **Strengths:** ten votes per image; explicit unknown/not-a-face outcomes; class distributions; high community adoption; inexpensive low-resolution experiments.
- **Weaknesses:** all FER2013 image limitations; image rights unresolved; archived upstream; crowdsourced votes are not clinical or FACS expert judgments.

### Recommended usage

**Auxiliary label-distribution research and legacy benchmarking, conditional on rights clearance.** FER+ is preferable to original FER2013 labels for ambiguity, confidence, and low-resolution experiments. It should not be the sole training or release-validation corpus.

### Open questions

- Does the MIT license apply to all released annotation files, and what separate terms apply to FER2013 imagery?
- Which label-conversion rule best preserves disagreement without making FER+ results incomparable to prior work?
- How many identities occur across official splits?

## 6. RAF-DB

### Facts

**Overview and purpose.** The Real-world Affective Faces Database (RAF-DB) was created by the Pattern Recognition and Intelligent System Laboratory at Beijing University of Posts and Telecommunications for expression recognition in unconstrained imagery [D06], [D07]. It was published in 2017.

**Statistics and splits.** RAF-DB contains 29,672 internet images. Each was independently labeled by approximately 40 crowd annotators, yielding categorical distributions. The commonly used basic-expression subset contains 15,339 images with 12,271 training and 3,068 test examples across neutral and six basic expressions. The database also provides a compound-expression subset; the project must verify whether the obtained release describes 11 or 12 compound categories because source/version descriptions differ. Aligned face crops are commonly 100×100; the package manifest, not a third-party loader, must define the authoritative dimensions and filenames [D06], [D07].

**Annotation quality.** Large per-image vote counts and the paper’s reliability-aware crowdsourcing procedure make RAF-DB one of the stronger categorical in-the-wild label sources. It includes expression distributions and useful face metadata such as landmarks and bounding boxes. Official descriptions include age range, gender, and race attributes, but these are coarse apparent-attribute labels rather than self-identified demographic data [D06], [D07].

**Diversity and mobile suitability.** Images span age, apparent gender and ethnicity, pose, lighting, occlusion, and post-processing filters. This is more realistic than laboratory datasets, but it remains internet photography rather than a sampled smartphone-front-camera population. Geography, device type, identity counts, consent, expression intensity, and balance across demographic intersections are not fully documented. Faces may be larger, more composed, or more publicly expressive than ordinary phone use.

**Availability and rights.** Access requires the official agreement and academic credentials. Official terms limit use to non-commercial research, state that the laboratory does not own the internet images, prohibit commercial use and redistribution, and require appropriate citation [D07]. This is a clear production blocker absent separate written permission.

### Assumptions

- The basic-expression subset is the relevant comparison target for the application’s initial ontology.
- Demographic attributes will be used only for aggregate fairness auditing where the agreement permits, not as ground truth identity characteristics.
- Official train/test separation will be preserved; a further validation split, if allowed, will be carved only from training data.

### Trade-offs

- **Strengths:** high vote count, label distributions, robust in-the-wild variation, useful landmarks, widely adopted benchmark, and a fixed official test split.
- **Weaknesses:** explicit non-commercial restriction; uncontrolled internet provenance; coarse demographic labels; no verified smartphone or geographic sampling; modest basic-subset scale.

### Recommended usage

**Research fine-tuning and cross-dataset validation/benchmarking only.** RAF-DB is a strong scientific complement to AffectNet because of its dense crowd labels. It cannot authorize a shipped commercial model under the standard terms.

### Open questions

- Can separate commercial/model-distribution rights be negotiated?
- Which release/version and compound-category count will be frozen?
- Are identity-disjoint splits guaranteed, and how were demographic attributes assigned?
- How well does its test set predict target smartphone performance in the intended launch population?

## 7. AffectNet

### Facts

**Overview and purpose.** AffectNet was created at the University of Denver to support categorical facial-expression and continuous valence/arousal analysis in unconstrained imagery [D08]. It was first published in 2017.

**Statistics.** More than one million web images were collected through three search engines using 1,250 emotion-related queries in six languages. Face detection produced a large candidate pool; approximately 450,000 images were manually annotated by 12 trained annotators for categorical expression and valence/arousal. Categories include neutral, happy, sad, surprise, fear, disgust, anger, contempt, plus non-expression/quality outcomes such as none, uncertain, and no-face [D08]. A commonly reported eight-class release contains 287,651 training examples and a balanced 4,000-image validation set (500 per class), but the exact counts and preprocessing artifacts must be read from the acquired version’s official manifest.

**Annotation quality.** AffectNet’s trained annotators and continuous labels are advantages. However, most images received one annotation. A 36,000-image double-annotated subset showed only 60.7% categorical agreement, demonstrating real ambiguity and annotator variability [D08]. AffectNet+ later revisited uncertainty through crowd labels, reinforcing that the original hard labels are not uniformly high-confidence [D24]. Expression intensity is indirectly represented by valence/arousal, not by a consistent categorical-intensity field.

**Diversity and mobile suitability.** The corpus is large and varied in apparent age, gender, ethnicity, lighting, pose, occlusion, face size, and image quality. Multilingual search terms improve breadth but do not create a population-representative sample. Subject count, geography, capture device, identity overlap, consent, and demographic balance are not documented at the level needed for launch fairness claims. Search-engine imagery differs from spontaneous front-camera behavior and can encode celebrity, keyword, publication, and cultural-display biases.

**Availability and rights.** Access is controlled through the official request process [D09]. The current academic agreement permits non-commercial research and educational use, imposes access and handling conditions, and does not provide a general commercial-use or redistribution grant [D10]. Any production model trained on AffectNet therefore requires separate written rights and legal approval.

### Assumptions

- AffectNet’s size and unconstrained variation make it the best required-dataset starting point for non-commercial representation training experiments.
- The seven-class common subset, with contempt reported separately, will reduce ontology mismatch in initial comparisons.
- “Uncertain,” “none,” and “no-face” records will be preserved in provenance and quality analysis rather than silently discarded.

### Trade-offs

- **Strengths:** largest required dataset; wide nuisance variation; categorical plus valence/arousal labels; established official split; strong community adoption.
- **Weaknesses:** academic-only standard terms; severe class imbalance; mainly single-annotator hard labels; documented disagreement; web-search bias; unknown identities and device/geography distribution.

### Recommended usage

**Primary training dataset for non-commercial research, conditional on access and license compliance.** Use its untouched official validation subset for in-domain evaluation, not as the sole release-validation set. A production training corpus must have commercial rights and target-domain evidence.

### Open questions

- Are commercial training and distribution terms available and compatible with an offline mobile model?
- Which official version, image subset, face alignment, and label corrections will be used?
- How much subject or near-duplicate leakage exists across splits?
- What are error and calibration gaps for the project’s intended users and phone cameras?

## 8. CK+

### Facts

**Overview and purpose.** CK+ extends the Cohn-Kanade laboratory dataset for facial action unit (AU) and expression research [D11]. Released in 2010, it contains 593 posed image sequences from 123 participants, progressing from a neutral onset to a peak expression. Sequence length ranges from 10 to 60 frames.

**Statistics and annotation quality.** A subset of 327 sequences meets validated criteria for seven peak categories: anger (45), contempt (18), disgust (59), fear (25), happiness (69), sadness (28), and surprise (83). Neutral is represented by onset frames, not an independently elicited peak category. Peak frames were FACS-coded and emotion categories were derived from AU combinations and visually validated. Approximately 15% was double-coded; the paper reports kappa of 0.82 for apex coding and 0.75 frame-by-frame [D11]. Images are approximately 640×480/490 in controlled frontal or near-frontal capture. CK+ does not define one universal train/validation/test split; the paper recommends subject-independent evaluation, including leave-one-subject-out protocols.

**Diversity.** The broader collection reported adults aged 18–50, approximately 69% female, 81% Euro-American, 13% Afro-American, and 6% other. These figures describe the recruited pool and should not be assumed to exactly describe every distributed subset. The dataset has limited age, geographic, pose, illumination, occlusion, and spontaneous-expression diversity [D11].

**Availability and rights.** The paper describes access by signed agreement. A current authoritative distribution agreement and its commercial/redistribution clauses were not conclusively verified during this review. Until the executed agreement is archived, use is restricted by project policy.

### Assumptions

- Evaluation will be subject-independent, preferably leave-one-subject-out as recommended by the paper.
- CK+ results will be reported separately from in-the-wild results because posed apex recognition is a different task.

### Trade-offs

- **Strengths:** strong AU-grounded peak labels; sequences expose onset-to-apex structure; controlled images isolate model behavior; mature benchmark.
- **Weaknesses:** tiny, posed and exaggerated; demographic imbalance; restricted pose and lighting; risk of frame/subject leakage; unclear current rights route.

### Recommended usage

**Controlled benchmark only.** Do not use as primary training, fine-tuning, or release validation. It can test whether a system recognizes prototypical facial movements under easy capture conditions, provided subject-independent protocol and rights are documented.

### Open questions

- What current agreement controls access, commercial use, derived models, and redistribution?
- Which demographic counts apply specifically to the distributed 123-subject release?
- Should onset frames be used as neutral without creating sequence leakage?

## 9. JAFFE

### Facts

**Overview and purpose.** JAFFE was created at Kyushu University and introduced in 1998 for expression representation research [D12], [D13]. It contains 213 posed 256×256, 8-bit grayscale images from 10 Japanese female volunteers. The classes are six basic expressions plus neutral.

**Annotation quality.** Sixty-two observers rated every image on five-point scales for the degree of each basic expression. These distributions are useful for studying perceived expression, but the images are deliberately posed and the small subject pool permits severe identity memorization if splits are image-random [D13], [D14]. JAFFE has no canonical train/validation/test partition; any result must publish a subject-disjoint protocol.

**Diversity and mobile suitability.** Age range is limited/insufficiently documented; gender, ethnicity, institution, geography, lighting, pose, background, and camera setup are extremely narrow. Occlusion and natural smartphone variation are largely absent. It therefore cannot support broad fairness or real-world robustness claims.

**Availability and rights.** The official page and Zenodo record provide access, but the official terms limit use to non-commercial scientific research [D13], [D14]. Citation and applicable terms are required. Redistribution or commercial model use must not be assumed.

### Assumptions

- Subject-disjoint evaluation is mandatory despite the tiny sample.
- JAFFE will not be used to estimate performance for Japanese women, East African users, or any broader population.

### Trade-offs

- **Strengths:** transparent small corpus; many perceptual ratings per image; useful historical baseline; controlled capture.
- **Weaknesses:** only 10 Japanese women; posed expressions; tiny size; no mobile realism; non-commercial restriction; high identity-leakage risk.

### Recommended usage

**Legacy controlled/cross-domain benchmark only.** Do not train, fine-tune, or validate release readiness on JAFFE.

### Open questions

- Do the current record terms permit storage of derived crops or model artifacts?
- What exact age distribution and collection-consent terms apply?
- Is any scientifically meaningful subject-disjoint estimate possible with only 10 identities?

## 10. ExpW

### Facts

**Overview and purpose.** Expression in-the-Wild (ExpW) was introduced by researchers at the Chinese University of Hong Kong as part of work extending expression recognition to interpersonal-relation prediction [D15]. The work first appeared in 2016 and its final journal publication appeared in 2018. It contains 91,793 web faces manually labeled as angry, disgust, fear, happy, sad, surprise, or neutral.

**Statistics and annotation quality.** The corpus is large and unconstrained, with variation in face size, pose, occlusion, illumination, and scene context. The paper describes manual annotation, but it does not provide FER+- or RAF-DB-like per-image vote distributions for routine use. Subject identities, demographic distributions, expression intensity, confidence, and a universally adopted official train/validation/test split are not adequately documented for this project [D15].

**Availability and rights.** The original research is authoritative, but this review did not verify a durable official download page and license that clearly grants current access, commercial training, redistribution, and derived-model rights. Community mirrors or repackaged “clean” versions are not acceptable substitutes for provenance.

**Mobile suitability.** Its unconstrained small and varied faces are potentially useful for mobile robustness. Nevertheless, web images do not establish smartphone similarity, and unknown sourcing, consent, duplicates, identities, demographics, and label confidence prevent defensible release claims.

### Assumptions

- ExpW remains unavailable to this project until an official source, version manifest, and operative terms are recovered.
- Its scale does not outweigh unresolved provenance and rights.

### Trade-offs

- **Strengths:** large seven-class corpus; broad in-the-wild nuisance variation; likely useful for small-face robustness.
- **Weaknesses:** unresolved official availability and license; limited annotation-confidence metadata; undocumented identities/demographics; no dependable standard split; maintenance risk.

### Recommended usage

**Not recommended under current evidence.** Reclassify as a conditional auxiliary training or benchmark dataset only after official provenance, license, redistribution/model-use terms, and split protocol are verified.

### Open questions

- What is the current official distribution channel and license?
- Is commercial model training permitted, and do restrictions flow to weights?
- What annotation protocol, quality-control process, identity structure, and canonical split apply to the obtained version?

## 11. Additional considerations: SFEW and AFEW

### Facts

Static Facial Expressions in the Wild (SFEW) consists of movie frames derived from the Acted Facial Expressions in the Wild (AFEW) corpus. SFEW 2.0 is commonly described as 958 training, 436 validation, and 372 test images across seven categories, with test labels retained for challenge evaluation. It uses a person-independent protocol and deliberately difficult pose, illumination, occlusion, and resolution [D16], [D17]. AFEW supplies short movie clips and temporal context.

### Assumptions

- Movie-derived data are useful as a domain-shift stress test, not as a proxy for consented smartphone capture.
- Exact release counts, challenge version, and rights will be taken from the acquired official package.

### Trade-offs

- **Advantages:** difficult real scenes; person-independent protocol; static and temporal variants; established challenge history.
- **Disadvantages:** small; acted/movie domain; copyright and redistribution constraints; hidden test labels; not representative of front-camera use.

### Recommended usage

**Optional benchmark only, subject to official access terms.** SFEW/AFEW do not replace any required dataset and should not be used for release validation.

### Open questions

- Which challenge version remains legitimately accessible, and what model-use rights apply?
- Can test evaluation still be obtained through an official mechanism?

## 12. Cross-dataset findings

### Facts

- Dataset bias is substantial: models trained on one FER dataset commonly lose performance on another because capture, subjects, expression elicitation, annotation, and class priors differ [D18], [D19].
- Apparent demographic performance disparities have been documented in FER benchmarks; incomplete demographic metadata makes many fairness claims untestable [D20].
- Basic-expression class names do not guarantee equivalent constructs. Posed apex labels, crowd perceptions, expert judgments, search-query categories, and valence/arousal annotations encode different tasks [D18], [D21].
- No required dataset is both clearly authorized for unrestricted commercial production and demonstrably representative of the intended smartphone population.

### Assumptions

- The first research ontology will use the intersection of seven common labels while preserving original source labels and votes.
- Final release validation requires a separate, consented, commercially usable, target-domain smartphone corpus.
- Dataset scores and model metrics will be reported per source; datasets will not be pooled into a single leaderboard number.

### Trade-offs

- Combining datasets increases nuisance diversity and sample count but introduces class-definition, annotation, preprocessing, and prior-shift conflicts.
- Dense vote distributions improve uncertainty analysis but do not make an internet image corpus population-representative.
- Controlled datasets improve diagnosability but inflate apparent accuracy and understate mobile failure modes.

### Open questions

- Which intended-use population, device tiers, capture conditions, and minimum fairness slices will define target-domain coverage?
- Can commercial rights be secured for AffectNet and RAF-DB, or must the project commission/license a new corpus?
- Should contempt remain a separate class, map to unknown, or be excluded from the initial ontology?
- How will multi-label and uncertain examples be evaluated without collapsing legitimate ambiguity into “label noise”?
