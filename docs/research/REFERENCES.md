# Consolidated Research Bibliography

## Document control

| Field | Value |
| --- | --- |
| Milestone | 1.0 — Technical Discovery & Validation |
| Research snapshot | 2026-08-04 |
| Citation style | Numbered references (`[R##]`), used consistently across `docs/research/` |
| Scope | Facial expression recognition (FER), mobile inference, responsible use, and relevant commercial/platform capabilities |

## How to use this bibliography

- A citation such as `[R10]` points to the matching entry below.
- Access dates are included for web documentation whose capabilities or status can change.
- Vendor claims describe documented product capabilities, not independent validation.
- Preprints are identified as such and should carry less evidentiary weight than peer-reviewed work.
- “Facial expression recognition” is preferred to “emotion detection” when the evidence concerns visible facial movements rather than internal emotional state.

## Foundational and survey literature

- **[R01]** Picard, R. W. (1997). *Affective Computing*. MIT Press. [Publisher page](https://mitpress.mit.edu/9780262661157/affective-computing/).
- **[R02]** Ekman, P., & Friesen, W. V. (1978). *Facial Action Coding System: A Technique for the Measurement of Facial Movement*. Consulting Psychologists Press. [WorldCat record](https://search.worldcat.org/title/Facial-action-coding-system-a-technique-for-the-measurement-of-facial-movement/oclc/3773141).
- **[R03]** Pantic, M., & Rothkrantz, L. J. M. (2000). Automatic analysis of facial expressions: The state of the art. *IEEE Transactions on Pattern Analysis and Machine Intelligence, 22*(12), 1424–1445. [DOI](https://doi.org/10.1109/34.895976).
- **[R04]** Ko, B. C. (2018). A brief review of facial emotion recognition based on visual information. *Sensors, 18*(2), 401. [DOI](https://doi.org/10.3390/s18020401).
- **[R05]** Li, S., & Deng, W. (2022). Deep facial expression recognition: A survey. *IEEE Transactions on Affective Computing, 13*(3), 1195–1215. [DOI](https://doi.org/10.1109/TAFFC.2020.2981446).
- **[R06]** Sariyanidi, E., Gunes, H., & Cavallaro, A. (2015). Automatic analysis of facial affect: A survey of registration, representation, and recognition. *IEEE Transactions on Pattern Analysis and Machine Intelligence, 37*(6), 1113–1133. [DOI](https://doi.org/10.1109/TPAMI.2014.2366127).
- **[R07]** Barrett, L. F., Adolphs, R., Marsella, S., Martinez, A. M., & Pollak, S. D. (2019). Emotional expressions reconsidered: Challenges to inferring emotion from human facial movements. *Psychological Science in the Public Interest, 20*(1), 1–68. [DOI](https://doi.org/10.1177/1529100619832930).

## Datasets and benchmark evolution

- **[R08]** Goodfellow, I. J., et al. (2013). Challenges in representation learning: A report on three machine learning contests. ICML Workshop. [arXiv](https://arxiv.org/abs/1307.0414). Introduces the FER2013 challenge dataset.
- **[R09]** Mollahosseini, A., Hasani, B., & Mahoor, M. H. (2017). AffectNet: A database for facial expression, valence, and arousal computing in the wild. *IEEE Transactions on Affective Computing, 10*(1), 18–31. [DOI](https://doi.org/10.1109/TAFFC.2017.2740923).
- **[R10]** Li, S., Deng, W., & Du, J. (2017). Reliable crowdsourcing and deep locality-preserving learning for expression recognition in the wild. *CVPR 2017*, 2852–2861. [CVF paper](https://openaccess.thecvf.com/content_cvpr_2017/html/Li_Reliable_Crowdsourcing_and_CVPR_2017_paper.html). Introduces RAF-DB.
- **[R11]** Kollias, D., & Zafeiriou, S. (2019). Expression, affect, action unit recognition: Aff-Wild2, multi-task learning and ArcFace. [arXiv](https://arxiv.org/abs/1910.04855).
- **[R12]** Jiang, X., et al. (2020). DFEW: A large-scale database for recognizing dynamic facial expressions in the wild. *ACM Multimedia 2020*. [Author manuscript](https://jiangxingxun.github.io/papers/DFEW/jiang_DFEW.pdf).
- **[R13]** Wang, Y., et al. (2022). FERV39k: A large-scale multi-scene dataset for facial expression recognition in videos. *CVPR 2022*, 20922–20931. [CVF paper](https://openaccess.thecvf.com/content/CVPR2022/html/Wang_FERV39k_A_Large-Scale_Multi-Scene_Dataset_for_Facial_Expression_Recognition_in_Videos_CVPR_2022_paper.html).

## Deep, transformer, temporal, and uncertainty-aware FER

- **[R14]** He, K., Zhang, X., Ren, S., & Sun, J. (2016). Deep residual learning for image recognition. *CVPR 2016*, 770–778. [CVF paper](https://openaccess.thecvf.com/content_cvpr_2016/html/He_Deep_Residual_Learning_CVPR_2016_paper.html).
- **[R15]** Xue, F., Wang, Q., & Guo, G. (2021). TransFER: Learning relation-aware facial expression representations with transformers. *ICCV 2021*, 3601–3610. [CVF paper](https://openaccess.thecvf.com/content/ICCV2021/html/Xue_TransFER_Learning_Relation-Aware_Facial_Expression_Representations_With_Transformers_ICCV_2021_paper.html).
- **[R16]** Zheng, C., Mendieta, M., & Chen, C. (2023). POSTER: A pyramid cross-fusion transformer network for facial expression recognition. *ICCV Workshops 2023*, 3146–3155. [CVF paper](https://openaccess.thecvf.com/content/ICCV2023W/AMFG/html/Zheng_POSTER_A_Pyramid_Cross-Fusion_Transformer_Network_for_Facial_Expression_Recognition_ICCVW_2023_paper.html).
- **[R17]** Narayan, K., VS, V., Chellappa, R., & Patel, V. M. (2025). FaceXFormer: A unified transformer for facial analysis. *ICCV 2025*, 11369–11382. [CVF paper](https://openaccess.thecvf.com/content/ICCV2025/html/Narayan_FaceXFormer_A_Unified_Transformer_for_Facial_Analysis_ICCV_2025_paper.html).
- **[R18]** Zhang, Y., et al. (2024). Open-set facial expression recognition. *AAAI 2024, 38*(1), 646–654. [DOI](https://doi.org/10.1609/aaai.v38i1.27821).
- **[R19]** Le, N., et al. (2023). Uncertainty-aware label distribution learning for facial expression recognition. *WACV 2023*. [CVF paper](https://openaccess.thecvf.com/content/WACV2023/html/Le_Uncertainty-Aware_Label_Distribution_Learning_for_Facial_Expression_Recognition_WACV_2023_paper.html).
- **[R20]** Zhang, W., et al. (2022). Transformer-based multimodal information fusion for facial expression analysis. *CVPR Workshops 2022*, 2428–2437. [CVF paper](https://openaccess.thecvf.com/content/CVPR2022W/ABAW/html/Zhang_Transformer-Based_Multimodal_Information_Fusion_for_Facial_Expression_Analysis_CVPRW_2022_paper.html).

## Bias, culture, validity, and calibration

- **[R21]** Li, S., & Deng, W. (2020). A deeper look at facial expression dataset bias. *IEEE Transactions on Affective Computing*. [arXiv](https://arxiv.org/abs/1904.11150).
- **[R22]** Xu, T., White, J., Kalkan, S., & Gunes, H. (2020). Investigating bias and fairness in facial expression recognition. *ECCV Workshops 2020*. [arXiv](https://arxiv.org/abs/2007.10075).
- **[R23]** Matsumoto, D., et al. (2024). Effect of observer’s cultural background and masking condition of target face on facial expression recognition for a machine-learning dataset. *PLOS ONE, 19*. [DOI](https://doi.org/10.1371/journal.pone.0313029).
- **[R24]** Guo, C., Pleiss, G., Sun, Y., & Weinberger, K. Q. (2017). On calibration of modern neural networks. *ICML 2017*, 1321–1330. [PMLR](https://proceedings.mlr.press/v70/guo17a.html).
- **[R25]** Ovadia, Y., et al. (2019). Can you trust your model’s uncertainty? Evaluating predictive uncertainty under dataset shift. *NeurIPS 2019*. [Proceedings](https://proceedings.neurips.cc/paper/2019/hash/8558cb408c1d76621371888657d2eb1d-Abstract.html).
- **[R26]** Hendrycks, D., & Gimpel, K. (2017). A baseline for detecting misclassified and out-of-distribution examples in neural networks. *ICLR 2017*. [OpenReview](https://openreview.net/forum?id=Hkg4TI9xl).

## Mobile and edge architectures

- **[R27]** Howard, A. G., et al. (2017). MobileNets: Efficient convolutional neural networks for mobile vision applications. [arXiv](https://arxiv.org/abs/1704.04861).
- **[R28]** Sandler, M., et al. (2018). MobileNetV2: Inverted residuals and linear bottlenecks. *CVPR 2018*, 4510–4520. [CVF paper](https://openaccess.thecvf.com/content_cvpr_2018/html/Sandler_MobileNetV2_Inverted_Residuals_CVPR_2018_paper.html).
- **[R29]** Ma, N., et al. (2018). ShuffleNet V2: Practical guidelines for efficient CNN architecture design. *ECCV 2018*, 116–131. [ECCV paper](https://openaccess.thecvf.com/content_ECCV_2018/html/Ningning_Light-weight_CNN_Architecture_ECCV_2018_paper.html).
- **[R30]** Tan, M., & Le, Q. V. (2019). EfficientNet: Rethinking model scaling for convolutional neural networks. *ICML 2019*, 6105–6114. [PMLR](https://proceedings.mlr.press/v97/tan19a.html).
- **[R31]** Tan, M., et al. (2019). MnasNet: Platform-aware neural architecture search for mobile. *CVPR 2019*, 2820–2828. [Google Research](https://research.google/pubs/mnasnet-platform-aware-neural-architecture-search-for-mobile/).
- **[R32]** Bazarevsky, V., et al. (2019). BlazeFace: Sub-millisecond neural face detection on mobile GPUs. *CVPR Workshop 2019*. [Google Research](https://research.google/pubs/blazeface-sub-millisecond-neural-face-detection-on-mobile-gpus/).
- **[R33]** Lee, J., et al. (2019). On-device neural net inference with mobile GPUs. *CVPR Workshop 2019*. [Google Research](https://research.google/pubs/on-device-neural-net-inference-with-mobile-gpus/).
- **[R34]** Yang, J., Qian, T., Zhang, F., & Khan, S. U. (2021). Real-time facial expression recognition based on edge computing. *IEEE Access, 9*, 76178–76190. [DOI](https://doi.org/10.1109/ACCESS.2021.3082641).

## Official mobile ML documentation

- **[R35]** Google AI Edge. *MediaPipe Face Detector*. Accessed 2026-08-04. [Official documentation](https://developers.google.com/edge/mediapipe/solutions/vision/face_detector).
- **[R36]** Google AI Edge. *MediaPipe Face Landmarker*. Accessed 2026-08-04. [Official documentation](https://developers.google.com/edge/mediapipe/solutions/vision/face_landmarker).
- **[R37]** Google AI Edge. *LiteRT performance best practices*. Accessed 2026-08-04. [Official documentation](https://ai.google.dev/edge/litert/performance/best_practices).
- **[R38]** Google AI Edge. *LiteRT performance measurement*. Accessed 2026-08-04. [Official documentation](https://ai.google.dev/edge/litert/models/measurement).
- **[R39]** TensorFlow. *TensorFlow Model Optimization Toolkit*. Accessed 2026-08-04. [Official documentation](https://www.tensorflow.org/model_optimization).
- **[R40]** TensorFlow. *Quantization-aware training comprehensive guide*. Accessed 2026-08-04. [Official documentation](https://www.tensorflow.org/model_optimization/guide/quantization/training_comprehensive_guide).
- **[R41]** Google ML Kit. *Face detection concepts*. Accessed 2026-08-04. [Official documentation](https://developers.google.com/ml-kit/vision/face-detection/face-detection-concepts).

## Commercial and platform systems

- **[R42]** Smart Eye / Affectiva. *Affectiva Media Analytics and Emotion SDK product information*. Accessed 2026-08-04. [Affectiva](https://www.affectiva.com/) and [Smart Eye products](https://smarteye.se/solutions/products/).
- **[R43]** Affectiva. *Privacy Policy*. Accessed 2026-08-04. [Official policy](https://www.affectiva.com/privacy-policy/).
- **[R44]** iMotions. (2026). *Affectiva Emotion SDK for Android: on-device deployment announcement*. [Official announcement](https://imotions.com/about-us/news/imotions-unveils-affectiva-emotion-sdk-for-android/).
- **[R45]** Microsoft. *What’s new in Azure Face — retirement of sensitive attributes*. Accessed 2026-08-04. [Microsoft Learn](https://learn.microsoft.com/en-us/azure/ai-services/face/whats-new-face).
- **[R46]** Microsoft. *Azure Face service overview and limited-access status*. Accessed 2026-08-04. [Microsoft Learn](https://learn.microsoft.com/en-us/azure/ai-services/face/overview-identity).
- **[R47]** Amazon Web Services. *Detecting and analyzing faces with Amazon Rekognition*. Accessed 2026-08-04. [AWS documentation](https://docs.aws.amazon.com/rekognition/latest/dg/faces.html).
- **[R48]** Amazon Web Services. *Rekognition Emotion API data type and intended-use warning*. Accessed 2026-08-04. [AWS API reference](https://docs.aws.amazon.com/rekognition/latest/APIReference/API_Emotion.html).
- **[R49]** Megvii Face⁺⁺. *Facial Attribute Analysis*. Accessed 2026-08-04. [Official product page](https://www.faceplusplus.com/attributes/).
- **[R50]** Apple. *Vision framework*. Accessed 2026-08-04. [Apple Developer Documentation](https://developer.apple.com/documentation/vision).
- **[R51]** Apple. *VNFaceLandmarks2D*. Accessed 2026-08-04. [Apple Developer Documentation](https://developer.apple.com/documentation/vision/vnfacelandmarks2d).
- **[R52]** Apple. *VNDetectFaceCaptureQualityRequest*. Accessed 2026-08-04. [Apple Developer Documentation](https://developer.apple.com/documentation/vision/vndetectfacecapturequalityrequest).

## Project sources

- **[P01]** EmotionSense AI. [Product Requirements](../PRODUCT_REQUIREMENTS.md).
- **[P02]** EmotionSense AI. [Architecture](../ARCHITECTURE.md).
- **[P03]** EmotionSense AI. [Roadmap](../ROADMAP.md).
- **[P04]** EmotionSense AI. [Architecture Decision Records](../DECISIONS/README.md).

## Evidence-quality notes

### Facts

- Peer-reviewed papers and official documentation are the default evidence sources.
- Official vendor documentation is authoritative for stated availability and API behavior, but not for comparative accuracy.

### Assumptions

- Links and service status are accurate as of the research snapshot date and require revalidation before implementation or procurement.
- Publication venue and peer-review status were assessed from publisher or proceedings records where available.

### Trade-offs

- A consolidated numbered bibliography makes cross-document references compact, but readers must follow links to inspect methods and limitations.
- Including preprints improves coverage of emerging work but reduces evidentiary certainty; they are explicitly labeled.

### Open questions

- Which sources permit dataset or model use under terms compatible with an open-source, potentially distributed mobile application?
- Which vendor and platform capabilities will still be supported when implementation begins?
