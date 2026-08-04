# Mobile Architecture References

**Milestone:** 1.3 Mobile Architecture Validation  
**Style:** Identifier, organization/authors, title, venue, year or last-reviewed date, URL  
**Last reviewed:** 2026-08-04

## 1. Source-use policy

Official platform/runtime documentation is authoritative for current API behavior and support status. Peer-reviewed papers support model/calibration concepts, not device-specific performance claims. Product thresholds and architecture allocations remain assumptions until EmotionSense measures them on the approved data and device matrix.

## 2. Android camera, lifecycle, performance, and thermal

- **[AX01]** Android Developers. “Image analysis (CameraX).” Updated 2025-03-04. https://developer.android.com/media/camera/camerax/analyze
- **[AX02]** Android Developers. “CameraX architecture.” Android Developers. https://developer.android.com/media/camera/camerax/architecture
- **[AN01]** Android Developers. “Neural Networks API” and “NNAPI Migration Guide.” Updated 2026. https://developer.android.com/ndk/guides/neuralnetworks and https://developer.android.com/ndk/guides/neuralnetworks/migration-guide
- **[AN02]** Android Developers. “PowerManager.OnThermalStatusChangedListener.” API reference. https://developer.android.com/reference/android/os/PowerManager.OnThermalStatusChangedListener
- **[AN03]** Android Developers. “App startup time.” Android Vitals. https://developer.android.com/topic/performance/vitals/launch-time
- **[AN04]** Android Developers. “Better performance through threading.” Updated 2026. https://developer.android.com/topic/performance/threads
- **[AN05]** Android Developers. “Slow rendering.” Android Vitals. https://developer.android.com/topic/performance/vitals/render

## 3. MediaPipe

- **[MP01]** Google AI Edge. “Face detection guide for Android.” Updated 2026-05-28. https://developers.google.com/edge/mediapipe/solutions/vision/face_detector/android
- **[MP02]** Google AI Edge. “Face landmark detection guide for Android.” Updated 2026-05-28. https://developers.google.com/edge/mediapipe/solutions/vision/face_landmarker/android
- **[MP03]** Google AI Edge. “Face detection task guide.” Overview and model information. https://developers.google.com/edge/mediapipe/solutions/vision/face_detector
- **[MP04]** Google AI Edge. “Face landmark detection task guide.” Overview and model information. https://developers.google.com/edge/mediapipe/solutions/vision/face_landmarker

The reviewed MediaPipe Android pages label Solutions Preview as an early release. That status is an architectural risk and requires dependency/API revalidation before implementation.

## 4. LiteRT / TensorFlow Lite

- **[LR01]** Google AI Edge. “LiteRT for Android.” Platform overview and API/version support table. Updated 2026-07-17. https://developers.google.com/edge/litert/android
- **[LR02]** Google AI Edge. “LiteRT Delegates.” Updated 2026-05-28. https://developers.google.com/edge/litert/performance/delegates
- **[LR03]** Google AI Edge. “GPU acceleration delegate with Interpreter API.” Updated 2026-05-28. https://developers.google.com/edge/litert/android/gpu
- **[LR04]** Google AI Edge. “Integrate image classifiers (Task Library).” Updated 2026. https://developers.google.com/edge/litert/libraries/task_library/image_classifier
- **[LR05]** Google AI Edge. “LiteRT Core ML delegate.” https://developers.google.com/edge/litert/ios/coreml
- **[LR06]** Google AI Edge. “Measure model performance.” Benchmark tooling. https://developers.google.com/edge/litert/performance/measurement
- **[LR07]** Google AI Edge. “Post-training integer quantization.” https://developers.google.com/edge/litert/models/post_training_integer_quant
- **[LR08]** Google AI Edge. “LiteRT in Google Play services.” https://developers.google.com/edge/litert/android/play_services

Google's current documentation uses the **LiteRT** name while some artifacts and APIs retain TensorFlow Lite / TFLite names. These documents use “LiteRT” for the runtime family and `.tflite` for the model format.

## 5. Flutter and Dart

- **[FL01]** Flutter. “Concurrency and isolates.” Updated 2026-05-11. https://docs.flutter.dev/perf/isolates
- **[FL02]** Flutter. “Writing custom platform-specific code.” https://docs.flutter.dev/platform-integration/platform-channels
- **[FL03]** Flutter team. “camera” package, version reviewed 0.12.0+2; package README, lifecycle, permission, endorsed CameraX implementation, and platform support. https://pub.dev/packages/camera
- **[FL04]** Dart. “Concurrency in Dart.” https://dart.dev/language/concurrency

Package versions and minimum OS declarations are temporally unstable. Re-check the resolved version, changelog, native implementation, and transitive minimum SDK immediately before dependency approval.

## 6. Peer-reviewed and established research

- **[ML01]** Guo, C., Pleiss, G., Sun, Y., and Weinberger, K. Q. “On Calibration of Modern Neural Networks.” *Proceedings of the 34th International Conference on Machine Learning*, PMLR 70, pp. 1321–1330, 2017. https://proceedings.mlr.press/v70/guo17a.html
- **[ML02]** Howard, A. et al. “Searching for MobileNetV3.” *Proceedings of the IEEE/CVF International Conference on Computer Vision*, 2019. https://openaccess.thecvf.com/content_ICCV_2019/html/Howard_Searching_for_MobileNetV3_ICCV_2019_paper.html
- **[ML03]** Lane, N. D. et al. “DeepX: A Software Accelerator for Low-Power Deep Learning Inference on Mobile Devices.” *15th ACM/IEEE International Conference on Information Processing in Sensor Networks*, 2016. https://doi.org/10.1109/IPSN.2016.7460664
- **[ML04]** Hu, M. et al. “Deep Learning for Mobile Systems.” *ACM Computing Surveys*, 53(3), 2020. https://doi.org/10.1145/3398206

Earlier milestone model and FER evidence remains in [Model References](MODEL_REFERENCES.md) and [References](REFERENCES.md); it is not duplicated here.

## 7. Evidence map

| Claim area | Primary references |
|---|---|
| Latest-only frame backpressure and image closure | [AX01] |
| Detector outputs, async behavior, busy-frame drop | [MP01] |
| Dense landmarks, tracking, live-stream behavior | [MP02] |
| Delegate variability and correctness benchmarking | [LR02], [LR06] |
| GPU availability, fallback example, thread affinity | [LR03] |
| Task Library preprocessing and metadata constraints | [LR04] |
| NNAPI deprecation | [AN01] |
| Future Core ML delegate | [LR05] |
| Flutter isolate copying/plugin constraints | [FL01] |
| Platform-channel boundary | [FL02] |
| Flutter camera lifecycle and Android support floor | [FL03] |
| Calibration/temperature scaling | [ML01] |

## 8. Facts, assumptions, trade-offs, and open questions

### Facts

- The listed official pages and papers support the claims mapped above as of the review date.
- Documentation and plugin/API status can change; URLs do not freeze behavior.

### Assumptions

- Official Android, Flutter, MediaPipe, and LiteRT documentation will remain the primary implementation authority.
- The final dependency set will expose behavior compatible with the architecture described in this milestone.

### Trade-offs

- Restricting technical claims to primary/official sources improves traceability but leaves some device-vendor behavior undocumented; physical measurement must fill that gap.
- A consolidated bibliography avoids duplication but requires readers to follow citation identifiers across documents.

### Open questions

1. Which exact MediaPipe, LiteRT, CameraX, Flutter, and camera-plugin versions will be approved?
2. Will any preview-status APIs graduate or materially change before implementation?
3. Which additional peer-reviewed alignment and temporal-calibration studies are relevant after the target pipeline experiments are specified?
