# Lightweight Facial-Expression Model Comparison

**Milestone:** 1.2 Model Validation & Selection  
**Last reviewed:** 2026-08-04  
**Scope:** Research comparison only; no checkpoint is approved for production  
**Related:** [Model Recommendation](MODEL_RECOMMENDATION.md) · [Performance Targets](PERFORMANCE_TARGETS.md) · [Deployment Considerations](DEPLOYMENT_CONSIDERATIONS.md) · [Model References](MODEL_REFERENCES.md)

## 1. Interpretation

EmotionSense AI estimates visible facial-expression categories; it does not determine a person's internal emotional state [M24]. Architecture-level ImageNet, face-verification, CK+, and FER2013 results answer different questions and are not directly comparable. In particular:

- ImageNet top-1 measures generic object classification and mainly indicates backbone capacity.
- LFW/MegaFace metrics measure identity verification, not expression classification.
- CK+ is a small, controlled, predominantly posed sequence dataset; its high scores do not establish in-the-wild robustness.
- FER2013 is a 48×48 web-image benchmark with noisy labels.
- Mobile latency is meaningful only with the exact model, input, runtime, delegate, threads, device, thermal state, and protocol stated [M18], [M19].

Unless a value is explicitly sourced, size estimates assume approximately 4 bytes per FP32 weight, 2 per FP16 weight, and 1 per INT8 weight, plus a small FlatBuffer/metadata overhead. These estimates do not include runtime binaries, activations, face detection, camera buffers, or application memory.

## 2. At-a-glance comparison

| Candidate | Year | Intended task | Canonical scale | Published task evidence | Mobile/tooling assessment | Best-supported role |
|---|---:|---|---|---|---|---|
| Mini-Xception | 2017 | FER and gender classification | ~60K params; 48×48 grayscale | 66% FER2013 accuracy | Exceptionally small; modern LiteRT quantization/delegate evidence is absent | Tiny benchmark / low-tier prototype |
| MobileNetV3-Small 1.0 | 2019 | General mobile vision | 2.9M params; 66M MACs; 224×224 RGB | 68.1% ImageNet top-1; FER results are protocol-specific adaptations | Excellent CPU-oriented design and first-party Keras support | **Primary production architecture candidate** |
| EfficientNet-Lite0 | 2020 | Edge image classification | 4.7M params; 407M MAdds; 224×224 RGB | 75.1% FP32 / 74.4% INT8 ImageNet top-1 | Official LiteRT checkpoints, quantization path, and Model Maker support | **Fallback production architecture candidate** |
| MobileFaceNet | 2018 | Face verification / embedding | <1M params; about 4 MB FP32; 112×112 face crop | 99.55% LFW; 92.59% TAR at FAR 1e-6 on MegaFace | Fast, but task and loss are identity-specific | Research feature extractor; not primary FER classifier |
| EmotionNet Nano A/B | 2020/2021 | Embedded FER | 232K / 136K params | 97.6% / 92.7% CK+ 7-class, subject-independent 10-fold CV | Strong embedded result; insufficient public LiteRT and target-domain evidence | Research / reproduction candidate |
| MobileNetV2 1.0 | 2018 | General mobile vision | 3.5M params; ~300M MAdds; 224×224 RGB | 71.3% ImageNet top-1 in Keras table | Mature, directly supported by Model Maker; older efficiency frontier | Tooling baseline and conservative prototype |

The parameter/MAC figures above refer to canonical classification models. Replacing the head, changing input resolution, or changing width changes them.

## 3. Mini-Xception

### Overview and architecture

**Facts.** Arriaga, Valdenegro-Toro, and Plöger introduced Mini-Xception in 2017 for real-time facial-expression and gender classification [M01]. It is a fully convolutional network with four residual depthwise-separable convolution modules, batch normalization, ReLU, global average pooling, and softmax. The paper reports approximately 60,000 parameters, an 855 KB weights file, and 48×48 grayscale FER2013 input [M01]. FLOPs/MACs were not reported.

### Performance

**Facts.** The paper reports 66% accuracy on seven-class FER2013, equal to its much larger initial CNN under the authors' protocol [M01]. It also describes confusion between fear/sadness and anger/disgust, and sensitivity to glasses. The cited 0.22 ms figure covers the authors' combined OpenCV face-detection/gender/expression pipeline on an Intel i5-4210M; it is implausibly low as a transferable mobile budget and must not be treated as smartphone latency [M01]. No cross-dataset, Android/iOS, sustained-power, or quantized result was reported.

### Mobile characteristics and quantization

| Property | Assessment |
|---|---|
| FP32 / estimated INT8 weights | Extremely small; ~0.24 MB raw FP32 or ~0.06 MB raw INT8 by parameter count. The paper's serialized file is 855 KB. |
| CPU / RAM / startup | Likely favorable because of the tiny graph and 48×48 input; exact LiteRT measurements unavailable. |
| GPU / NNAPI / Core ML | Uses common convolutional operations, but delegate partitioning and speedup are unverified. NNAPI is deprecated in Android 15 [M20]. |
| FP16 / dynamic range / INT8 | Converter-level paths should be feasible for standard layers; no published conversion or accuracy evidence was found. |
| QAT | Likely possible in a supported Keras reimplementation, but the age and exact framework form of the reference implementation increase maintenance risk. |
| Battery / startup | Probably low for the classifier alone; camera and face detection may dominate. No measurements. |

### Strengths, weaknesses, and recommended usage

**Strengths:** exceptionally small, FER-specific, easy-to-understand topology, low-resolution input, and CPU-friendly depthwise separable convolutions.

**Weaknesses:** weak benchmark ceiling by current standards; old and noisy FER2013-only evidence; grayscale and 48×48 input can discard subtle or color/illumination cues; no cross-dataset, calibration, quantization, or modern phone evidence.

**Recommended usage:** benchmarking and a low-tier prototype baseline. Do not select as the default production architecture without evidence that its robustness and calibrated selective accuracy meet release gates.

## 4. MobileNetV3-Small

### Overview and architecture

**Facts.** MobileNetV3 was published in 2019 for mobile classification, detection, and segmentation [M02]. MobileNetV3-Small targets low-resource devices. It combines depthwise convolutions, inverted residual linear bottlenecks, hardware-aware neural architecture search, NetAdapt, mobile squeeze-and-excitation, ReLU and hard-swish/hard-sigmoid activations, and an efficient final stage [M02], [M03]. The canonical 1.0/224 classifier has 2.9M parameters, 66M MACs, 68.1% ImageNet top-1, and 15.8 ms Pixel 1 CPU latency in the Keras table [M04]. Keras permits alternative spatial input sizes; costs and accuracy then change.

### Performance

**Facts.** The original paper reports MobileNetV3-Small as more accurate at lower latency than a comparable MobileNetV2 on its mobile classification protocol [M02]. Later FER papers report results for modified MobileNetV3 variants, but changes in datasets, preprocessing, loss, attention blocks, and splits make those numbers evidence that the family is adaptable—not a canonical MobileNetV3 FER score [M12]. No authoritative canonical cross-dataset FER result or EmotionSense smartphone result exists.

### Mobile characteristics and quantization

| Property | Assessment |
|---|---|
| FP32 / estimated FP16 / INT8 weights | About 11.6 / 5.8 / 2.9 MB raw weights for the full ImageNet head; a seven-class head is slightly smaller. |
| CPU latency | Strong published mobile-CPU design evidence; 15.8 ms is Pixel 1/ImageNet evidence, not an EmotionSense forecast [M04]. |
| GPU / Core ML | Common ops are broadly delegate-friendly, but SE and hard-swish may partition differently across versions/devices. Core ML's LiteRT delegate supports hard-swish and float models [M21]. |
| NNAPI | Technically relevant on older Android stacks, but not a forward strategy because Android 15 deprecates NNAPI [M20]. |
| Quantization | FP16, dynamic range, full INT8, and QAT are plausible through standard TensorFlow tooling [M15], [M16]. Full INT8 accuracy and operator coverage must be verified. |
| RAM / battery / startup | Expected to be favorable relative to larger backbones, but exact activation memory, initialization, and energy are unknown until exported artifact tests. |

### Strengths, weaknesses, and recommended usage

**Strengths:** best balance of capacity and 66M-MAC canonical compute; explicitly optimized on phone CPUs; first-party Keras implementation; standard operators; adjustable width/input; mature transfer-learning ecosystem.

**Weaknesses:** not a built-in image-classification backbone in the currently documented Model Maker supported list [M08]; SE/hard-swish can complicate some accelerator paths; ImageNet and modified-FER evidence do not prove target robustness.

**Recommended usage:** primary production architecture candidate, conditional on target-domain training rights, INT8/QAT quality, calibration, and physical-device gates.

## 5. EfficientNet-Lite

### Overview and architecture

**Facts.** EfficientNet-Lite was released in 2020 as an edge-oriented adaptation of EfficientNet's compound-scaled MBConv family [M05], [M06]. It removes squeeze-and-excitation, replaces swish with ReLU6, and fixes stem/head scaling to improve accelerator and post-training quantization behavior [M05]. Lite0 uses 224×224 RGB input, 4.7M parameters, and 407M MAdds.

### Performance

**Facts.** Google's Pixel 4 measurements with batch 1 and four CPU threads report Lite0 at 75.1% FP32 and 74.4% INT8 ImageNet top-1; FP32 CPU 12 ms, FP32 GPU 9 ms, FP16 GPU 6 ms, INT8 CPU 6.5 ms, and INT8 Edge TPU 3.8 ms [M05]. These figures are unusually strong platform-specific reference results and cannot be transferred to FER, other delegates, or lower-tier phones. No canonical cross-dataset FER number exists.

### Mobile characteristics and quantization

| Property | Assessment |
|---|---|
| FP32 / estimated FP16 / INT8 weights | About 18.8 / 9.4 / 4.7 MB raw weights. |
| CPU / GPU | Official Pixel 4 evidence exists for FP32, FP16, and INT8 [M05]; 407M MAdds is substantially more compute than MobileNetV3-Small. |
| Delegate suitability | ReLU6 and removal of SE intentionally improve edge compatibility. Core ML supports the main float ops; exact partitions still require inspection [M21]. |
| Quantization | Strongest candidate evidence: official INT8 export path and published FP32/INT8 comparison [M05]. Dynamic range, FP16, full INT8, and QAT are supported at the tooling level [M15], [M16]. |
| Model Maker | Lite0 is the documented default; current supported models include Lite0, Lite2, Lite4, and MobileNetV2 [M08], [M09]. |
| RAM / battery / startup | Higher activation compute and weights than MobileNetV3-Small; exact values unavailable. |

### Strengths, weaknesses, and recommended usage

**Strengths:** first-party mobile checkpoints; deliberate quantization-friendly changes; mature Model Maker path; good generic capacity; unusually clear reference latency/accuracy table.

**Weaknesses:** roughly 6× MobileNetV3-Small's canonical MACs; larger asset and activation footprint; generic 224×224 model may be excessive for a cropped face; no target FER evidence.

**Recommended usage:** production fallback and accuracy/tooling baseline. Prefer Lite0; larger Lite variants are not justified until Lite0 fails an accuracy gate and still fits device budgets.

## 6. MobileFaceNet

### Overview and architecture

**Facts.** MobileFaceNet was published in 2018 for face verification, not expression classification [M10]. It uses MobileNetV2-like inverted residual bottlenecks with smaller expansion factors, PReLU, a linear global depthwise convolution, and an embedding head. The paper reports less than 1M parameters, a 4.0 MB model, 112×112 aligned face input, and about 439.8M operations/221M MACs depending on counting convention [M10].

### Performance

**Facts.** The model reports 99.55% LFW verification accuracy, 92.59% TAR at FAR 1e-6 on MegaFace, and 18 ms for its fastest variant on a mobile phone [M10]. None of these measure expression classification. Later FER systems sometimes use MobileFaceNet for identity/landmark or feature branches, but that does not establish it as a standalone FER backbone under a comparable protocol.

### Mobile characteristics and quantization

The compact parameters and mobile latency are attractive. However, the global depthwise convolution depends on input spatial dimensions, PReLU/operator support and conversion path must be checked, and no official TensorFlow Lite/Model Maker or quantized FER artifact was identified. FP16, dynamic range, INT8, and QAT are therefore **possible but unverified for the exact architecture**. Identity-pretraining can also preserve identity-sensitive features that are unnecessary and potentially undesirable for a privacy-first expression classifier.

### Strengths, weaknesses, and recommended usage

**Strengths:** compact; face-crop-specific inductive bias; strong face-verification efficiency; potentially useful for transfer learning.

**Weaknesses:** wrong primary objective; reported accuracy is incompatible with FER; possible biometric-representation and dataset-lineage concerns; weaker first-party TensorFlow deployment story.

**Recommended usage:** research-only feature-extractor experiment. Not recommended as the primary production classifier without a controlled comparison showing clear target-domain benefit and acceptable privacy/provenance.

## 7. EmotionNet Nano

### Overview and architecture

**Facts.** EmotionNet Nano was published online in 2020 and in journal issue form in 2021 specifically for real-time embedded facial-expression classification [M11]. Human-guided residual principles and machine-driven generative synthesis produced heterogeneous convolution shapes/channels and selective long-range connections, including dense 1×1 channel-mixing paths. It ends in average pooling and a fully connected softmax layer. Nano-A has 232K parameters; Nano-B has 136K. The paper does not provide a portable FLOP/MAC count or a clearly standardized deployed input tensor specification.

### Performance

**Facts.** On 981 images produced from the last three frames of CK+ sequences, subject-independent 10-fold cross-validation yielded 97.6% for Nano-A and 92.7% for Nano-B over seven classes including contempt but excluding neutral [M11]. On an ARM v8.2 64-bit embedded processor, Nano-A/Nano-B achieved 25.8/32.8 FPS at a 15 W setting and 70.1/72.9 FPS at 30 W [M11]. This is valuable embedded evidence but is not a phone, is not the project's seven-class ontology, and does not address in-the-wild domain shift.

### Mobile characteristics and quantization

Raw FP32 weights are roughly 0.93 MB (A) and 0.54 MB (B); estimated INT8 weights are roughly 0.23 MB and 0.14 MB. Low parameter count suggests fast startup and low weight memory, but heterogeneous topology can be less kernel-friendly than parameter count implies. No official LiteRT conversion, delegate partition, FP16/INT8, QAT, Android/iOS, or Model Maker evidence was found. Exact quantization readiness is therefore unknown, not negative.

### Strengths, weaknesses, and recommended usage

**Strengths:** FER-specific; extremely compact; subject-independent protocol; published embedded speed and energy-efficiency results.

**Weaknesses:** evidence is confined to controlled CK+; class ontology differs; no cross-dataset/calibration evidence; limited reproducibility and deployment-tool maturity; heterogeneous graph may hinder delegates.

**Recommended usage:** reproduction research and a compact benchmark. Not recommended for production selection until an exact implementation is reproducible, convertible with built-in LiteRT ops, and competitive on target-domain data.

## 8. TensorFlow Model Maker-compatible options

### MobileNetV2 baseline

**Facts.** MobileNetV2 (2018) uses inverted residuals, linear bottlenecks, depthwise separable convolutions, and ReLU6 [M07]. The common 1.0/224 classifier has about 3.5M parameters, roughly 300M MAdds, and 71.3% ImageNet top-1 in the Keras applications table [M04]. It is directly supported by current Model Maker documentation alongside EfficientNet-Lite, while Lite0 is the default [M08], [M09].

Its principal advantages are stable implementations, broad built-in-op compatibility, extensive quantization precedent, and maintainability. Its disadvantage is that it offers a less favorable canonical capacity/latency frontier than newer MobileNetV3 and lacks a canonical FER result. Use it as a conversion, tooling, and transfer-learning baseline—not as the default selection unless the newer candidate has an operator or accuracy regression.

### Scope note

Model Maker compatibility is a workflow convenience, not a production-quality criterion. It does not resolve dataset rights, class ontology, calibration, cross-dataset robustness, or device performance. ResNet50 is also documented as supported, but its ~25.6M parameters and much larger compute make it inappropriate for the initial lightweight shortlist [M04], [M09].

## 9. Additional candidate: ShuffleNetV2

ShuffleNetV2 (2018) is relevant because it was designed from direct speed measurements rather than FLOPs alone and introduced practical efficiency guidelines: balanced channels, limited group operations, low fragmentation, and reduced element-wise cost [M13]. The 1.0× model reports approximately 2.3M parameters and 146M FLOPs at 224×224 in the paper. It is a credible benchmarking candidate.

It is not promoted into the production pair because TensorFlow/Keras/Model Maker and official LiteRT artifact support are less direct than for MobileNet/EfficientNet, and canonical results are generic ImageNet rather than target FER. If implemented for research, conversion must use built-in ops and be compared under the same artifact/device protocol.

## 10. Cross-candidate mobile implications

### Facts

- Smaller weights reduce storage and usually initialization pressure, but activation tensors and delegate copies can dominate peak RAM [M17], [M18].
- FP16 is generally appropriate for GPU paths; full INT8 is generally preferred for CPU and integer accelerators. Full integer quantization needs representative calibration data [M15].
- QAT often preserves accuracy better than post-training quantization, but TensorFlow Model Optimization supports only specified layer/model patterns and must be tested on the exact graph [M16].
- Android NNAPI was deprecated in Android 15; the production strategy should prefer LiteRT CPU/XNNPACK and supported GPU/NPU paths, treating NNAPI as legacy compatibility [M20].
- The LiteRT Core ML delegate is beta, uses float models, defaults to Neural Engine-capable A12+ devices, and falls back for unsupported operations [M21].

### Assumptions

- Inference uses an aligned single-face crop, batch size 1, in the foreground only.
- A 160×160 or smaller MobileNetV3 input may offer a better FER trade-off than canonical 224×224, but this is an experiment—not an established fact.
- Classifier sampling need not equal camera FPS; temporal throttling can save energy without harming the reflection flow.

### Trade-offs

- Tiny FER-specific networks minimize resource use but offer weak in-the-wild and tooling evidence.
- Generic pretrained backbones improve transfer-learning and maintenance options but add compute and may learn irrelevant features.
- GPU/NPU acceleration can reduce steady-state latency while increasing initialization, memory copies, binary size, or device variance.

### Open questions

1. Which input resolution preserves small-expression cues after the approved face crop?
2. Does MobileNetV3-Small remain fully delegated after conversion and QAT?
3. Which architecture produces the best macro F1, calibration, and selective risk on the locked smartphone corpus?
4. Does grayscale reduce domain sensitivity enough to offset information loss?
5. What portion of end-to-end time and energy belongs to face detection, crop/resize, and camera rather than classification?
6. Can EmotionNet Nano be reproduced and converted without custom ops?
7. Do identity-pretrained features create measurable privacy, fairness, or robustness disadvantages?

