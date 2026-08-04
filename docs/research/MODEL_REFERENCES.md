# Model Validation References

**Milestone:** 1.2 Model Validation & Selection  
**Last reviewed:** 2026-08-04  
**Citation style:** IEEE-style numbered references

This bibliography consolidates sources used by [MODEL_COMPARISON.md](MODEL_COMPARISON.md), [MODEL_RECOMMENDATION.md](MODEL_RECOMMENDATION.md), [PERFORMANCE_TARGETS.md](PERFORMANCE_TARGETS.md), and [DEPLOYMENT_CONSIDERATIONS.md](DEPLOYMENT_CONSIDERATIONS.md). Original papers and current official documentation are preferred. Hardware figures are retained only with their stated device/protocol and must not be generalized to EmotionSense.

## Model architectures and official implementations

[M01] O. Arriaga, M. Valdenegro-Toro, and P. Plöger, “Real-time Convolutional Neural Networks for Emotion and Gender Classification,” 2017. [arXiv:1710.07557](https://arxiv.org/abs/1710.07557).

[M02] A. Howard et al., “Searching for MobileNetV3,” in *Proc. IEEE/CVF International Conference on Computer Vision (ICCV)*, 2019, pp. 1314–1324. [CVF Open Access](https://openaccess.thecvf.com/content_ICCV_2019/html/Howard_Searching_for_MobileNetV3_ICCV_2019_paper.html).

[M03] Google Research, “Introducing the Next Generation of On-Device Vision Models: MobileNetV3 and MobileNetEdgeTPU,” 2019. [Official publication](https://research.google/blog/introducing-the-next-generation-of-on-device-vision-models-mobilenetv3-and-mobilenetedgetpu/). Accessed 2026-08-04.

[M04] Keras, “MobileNet, MobileNetV2, and MobileNetV3,” official Keras Applications documentation. [Online](https://keras.io/api/applications/mobilenet/). Accessed 2026-08-04.

[M05] TensorFlow, “EfficientNet-Lite,” official TensorFlow TPU models documentation, including Pixel 4 FP32/FP16/INT8 benchmarks. [Online](https://github.com/tensorflow/tpu/tree/master/models/official/efficientnet/lite). Accessed 2026-08-04.

[M06] M. Tan and Q. V. Le, “EfficientNet: Rethinking Model Scaling for Convolutional Neural Networks,” in *Proc. International Conference on Machine Learning (ICML)*, 2019, pp. 6105–6114. [PMLR](https://proceedings.mlr.press/v97/tan19a.html).

[M07] M. Sandler et al., “MobileNetV2: Inverted Residuals and Linear Bottlenecks,” in *Proc. IEEE/CVF Conference on Computer Vision and Pattern Recognition (CVPR)*, 2018, pp. 4510–4520. [CVF Open Access](https://openaccess.thecvf.com/content_cvpr_2018/html/Sandler_MobileNetV2_Inverted_Residuals_CVPR_2018_paper.html).

[M08] Google AI Edge, “MediaPipe Model Maker Image Classifier SupportedModels,” official API documentation. [Online](https://developers.google.com/edge/api/mediapipe/python/mediapipe_model_maker/image_classifier/SupportedModels). Accessed 2026-08-04.

[M09] Google AI Edge, “Image Classification with TensorFlow Lite Model Maker,” official documentation. [Online](https://www.tensorflow.org/lite/models/modify/model_maker/image_classification). Accessed 2026-08-04.

[M10] S. Chen, Y. Liu, X. Gao, and Z. Han, “MobileFaceNets: Efficient CNNs for Accurate Real-Time Face Verification on Mobile Devices,” in *Proc. Chinese Conference on Biometric Recognition (CCBR)*, 2018, pp. 428–438. [arXiv:1804.07573](https://arxiv.org/abs/1804.07573); [doi:10.1007/978-3-319-97909-0_46](https://doi.org/10.1007/978-3-319-97909-0_46).

[M11] J. R. Lee, L. Wang, and A. Wong, “EmotionNet Nano: An Efficient Deep Convolutional Neural Network Design for Real-Time Facial Expression Recognition,” *Frontiers in Artificial Intelligence*, vol. 3, art. 609673, 2021. [doi:10.3389/frai.2020.609673](https://doi.org/10.3389/frai.2020.609673).

[M12] C. Liang et al., “A Lightweight Method for Face Expression Recognition Based on Improved MobileNetV3,” *IET Image Processing*, vol. 17, no. 8, pp. 2457–2471, 2023. [doi:10.1049/ipr2.12798](https://doi.org/10.1049/ipr2.12798).

[M13] N. Ma et al., “ShuffleNet V2: Practical Guidelines for Efficient CNN Architecture Design,” in *Proc. European Conference on Computer Vision (ECCV)*, 2018, pp. 116–131. [ECCV Open Access](https://openaccess.thecvf.com/content_ECCV_2018/html/Ningning_Light-weight_CNN_Architecture_ECCV_2018_paper.html).

[M14] F. Chollet, “Xception: Deep Learning with Depthwise Separable Convolutions,” in *Proc. IEEE Conference on Computer Vision and Pattern Recognition (CVPR)*, 2017, pp. 1251–1258. [CVF Open Access](https://openaccess.thecvf.com/content_cvpr_2017/html/Chollet_Xception_Deep_Learning_CVPR_2017_paper.html).

## Quantization, LiteRT, and mobile execution

[M15] TensorFlow Model Optimization, “Post-Training Quantization,” official guide. [Online](https://www.tensorflow.org/model_optimization/guide/quantization/post_training). Accessed 2026-08-04.

[M16] TensorFlow Model Optimization, “Quantization Aware Training,” official guide. [Online](https://www.tensorflow.org/model_optimization/guide/quantization/training). Accessed 2026-08-04.

[M17] Google AI Edge, “LiteRT Model Optimization,” official guide. [Online](https://ai.google.dev/edge/litert/models/model_optimization). Accessed 2026-08-04.

[M18] TensorFlow Lite, “Performance Measurement,” official benchmark-tool documentation. [Online](https://android.googlesource.com/platform/external/tensorflow/+/refs/heads/master/tensorflow/lite/g3doc/performance/measurement.md). Accessed 2026-08-04.

[M19] V. J. Reddi et al., “MLPerf Mobile Inference Benchmark: An Industry-Standard Open-Source Machine Learning Benchmark for On-Device AI,” *Proceedings of Machine Learning and Systems*, vol. 4, pp. 352–369, 2022. [MLSys](https://proceedings.mlsys.org/paper_files/paper/2022/hash/a2b2702ea7e682c5ea2c20e8f71efb0c-Abstract.html).

[M20] Android Developers, “NNAPI Migration Guide,” official Android NDK documentation. NNAPI was deprecated in Android 15. [Online](https://developer.android.com/ndk/guides/neuralnetworks/migration-guide). Accessed 2026-08-04.

[M21] Google AI Edge, “LiteRT Core ML Delegate,” official documentation. [Online](https://ai.google.dev/edge/litert/ios/coreml). Accessed 2026-08-04.

## Evaluation, calibration, and responsible interpretation

[M22] C. Guo, G. Pleiss, Y. Sun, and K. Q. Weinberger, “On Calibration of Modern Neural Networks,” in *Proc. International Conference on Machine Learning (ICML)*, 2017, pp. 1321–1330. [PMLR](https://proceedings.mlr.press/v70/guo17a.html).

[M23] S. Geifman and R. El-Yaniv, “Selective Classification for Deep Neural Networks,” in *Advances in Neural Information Processing Systems*, vol. 30, 2017. [NeurIPS](https://papers.nips.cc/paper_files/paper/2017/hash/4a8423d5e91fda00bb7e46540e2b0cf1-Abstract.html).

[M24] L. F. Barrett, R. Adolphs, S. Marsella, A. M. Martinez, and S. D. Pollak, “Emotional Expressions Reconsidered: Challenges to Inferring Emotion From Human Facial Movements,” *Psychological Science in the Public Interest*, vol. 20, no. 1, pp. 1–68, 2019. [doi:10.1177/1529100619832930](https://doi.org/10.1177/1529100619832930).

[M25] National Institute of Standards and Technology, “Secure Hash Standard (SHS),” FIPS PUB 180-4, 2015. [Official publication](https://csrc.nist.gov/pubs/fips/180-4/upd1/final).

[M26] M. Mitchell et al., “Model Cards for Model Reporting,” in *Proc. Conference on Fairness, Accountability, and Transparency (FAT*)*, 2019, pp. 220–229. [doi:10.1145/3287560.3287596](https://doi.org/10.1145/3287560.3287596).

[M27] S. Li and W. Deng, “Deep Facial Expression Recognition: A Survey,” *IEEE Transactions on Affective Computing*, vol. 13, no. 3, pp. 1195–1215, 2022. [doi:10.1109/TAFFC.2020.2981446](https://doi.org/10.1109/TAFFC.2020.2981446).

[M28] S. Li and W. Deng, “A Deeper Look at Facial Expression Dataset Bias,” *IEEE Transactions on Affective Computing*, vol. 13, no. 2, pp. 881–893, 2022. [arXiv:1904.11150](https://arxiv.org/abs/1904.11150).

[M29] T. Xu et al., “Investigating Bias and Fairness in Facial Expression Recognition,” in *Computer Vision—ECCV 2020 Workshops*, 2020. [arXiv:2007.10075](https://arxiv.org/abs/2007.10075).

## Evidence notes

### Facts

- Publication-specific figures are cited to the original paper or official implementation documentation.
- Current runtime and delegate claims are cited to first-party Google/Android documentation.
- FER accuracy, ImageNet accuracy, face-verification accuracy, and mobile latency are intentionally not pooled into a common empirical ranking.

### Assumptions

- Official web documentation reflects the public state on the review date and may evolve before implementation.
- Architecture licenses, checkpoint licenses, training-data rights, and rights to distribute derived weights are separate checks.

### Trade-offs

- First-party sources provide reliable implementation facts but rarely evaluate EmotionSense's target domain.
- Peer-reviewed FER papers provide task evidence but frequently use incompatible datasets, splits, preprocessing, and modified architectures.

### Open questions

- Which exact versioned runtime documentation and artifacts will govern the implementation milestone?
- Should durable archived copies of mutable official deployment pages be recorded in the model evidence register?
- Which production dataset and checkpoint licenses will apply to the final lineage?

