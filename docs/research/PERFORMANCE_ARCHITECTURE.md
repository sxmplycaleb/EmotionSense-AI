# Mobile Performance Architecture

**Milestone:** 1.3 Mobile Architecture Validation  
**Status:** Evidence-based strategy with unmeasured project assumptions  
**Last reviewed:** 2026-08-04  
**Normative budgets:** [Performance Targets](PERFORMANCE_TARGETS.md)  
**References:** [Mobile References](MOBILE_REFERENCES.md)

## 1. Performance objective

Preserve a smooth preview and responsive Flutter UI while producing 5–10 fresh estimates per second. The architecture must meet classifier p95 ≤40 ms and end-to-end p95 ≤180 ms aspirational targets (≤80 ms and ≤350 ms minimum), incremental peak RAM ≤64 MB, and the existing battery/thermal gates. These are proposed gates, not measured results.

Optimization order follows project priorities: privacy and correct abstention first, sustained reliability second, then latency. No delegate “win” is valid if output quality, calibration, crash behavior, or sustained thermal performance regresses.

## 2. Scheduling and backpressure

Use a **single-flight, latest-frame** design:

- preview runs independently at the camera/display cadence;
- analysis admission begins at 10 Hz recommended / 5 Hz minimum;
- at most one frame is in analysis and no FIFO of stale frames is allowed;
- a busy worker causes immediate frame release;
- result age is measured from camera timestamp, not callback time.

CameraX documents that `STRATEGY_KEEP_ONLY_LATEST` overwrites the pending image while analysis is active, whereas blocking mode can block all bound camera use cases, including preview [AX01]. MediaPipe also ignores live-stream input when busy [MP01]. EmotionSense should still keep one explicit scheduler to make cadence, telemetry, and thermal decisions deterministic.

### Dynamic cadence policy

Evaluate once per rolling window, with hysteresis to prevent oscillation:

| Signal | Action |
|---|---|
| p95 end-to-end near budget, repeated busy drops | Reduce 10→8→5 Hz |
| Thermal status moderate or sustained latency degradation >20% | Reduce cadence and analysis resolution one step |
| Thermal status severe | Pause classification; keep preview only if platform/user safety permits |
| Battery saver/low battery | Default to 5 Hz; avoid GPU promotion |
| Stable cool window with latency headroom | Increase one step, never beyond validated tier ceiling |

Thresholds and dwell times are assumptions requiring device tests. Cadence changes must not alter calibration semantics.

## 3. Resolution strategy

Decouple preview resolution from analysis resolution. Begin physical-device experiments with a 640×480-class analysis target while preserving the camera's actual aspect ratio. Admit a frame only if the detected face meets the validated pixel-size gate; do not upscale a tiny face and claim improved evidence. Test 480p and 720p against detector recall, FER quality, conversion latency, RAM, and battery.

CameraX may select a resolution different from the request based on hardware capability [AX01]. Therefore, derive crop transforms from the delivered resolution and re-query after rebind or rotation.

## 4. Initialization and warm-up

- **Lazy initialize** only when the user enters an analysis workflow with consent and permission; Android warns against heavy startup initialization [AN03].
- Validate asset hashes and metadata before runtime creation.
- Construct detector, LiteRT execution context/accelerator, and fixed buffers on their owner worker.
- Perform several discarded warm-up runs with synthetic/non-personal input before admitting frames.
- Report cold creation, tensor allocation/delegate compilation, warm-up, and first usable estimate separately.
- Keep initialized resources only for the active foreground session; deterministic release has priority over speculative caching.

Lazy initialization reduces app launch work but shifts cost into camera startup. The UI must show an honest initializing state and remain cancellable.

## 5. Memory and buffer management

The intended hot path is bounded:

1. one CameraX analysis image;
2. one reusable selected-ROI/conversion surface;
3. one fixed input tensor buffer;
4. one output/logit buffer; and
5. runtime/delegate working memory.

Rules:

- avoid full-frame `Bitmap` creation and rotation;
- crop/convert the ROI where APIs permit;
- preallocate direct/native buffers at session initialization;
- reuse arrays and result objects where ownership is safe;
- send scalars/small typed records—not pixel buffers—to Flutter;
- close every camera image in a `finally`-equivalent path;
- bound result history to the temporal window;
- measure delegate memory because acceleration can allocate additional buffers.

Do not assume “zero copy” until profiler traces prove it on each platform adapter. The architecture's requirement is **no avoidable cross-boundary full-frame copy**.

## 6. Delegate and CPU performance

CPU is the compatibility baseline. LiteRT provides CPU execution and its delegate documentation describes optimized CPU kernels [LR01][LR02]. Benchmark a small thread-count matrix (for example 1, 2, and 4) where the chosen API exposes it, because more threads can contend with camera and UI work and can worsen sustained energy. Pinning a universal count without device evidence is prohibited.

GPU is an optional allowlisted optimization. Delegates support only subsets of operations and vary by model/device; official guidance requires benchmarking latency and correctness [LR02]. GPU initialization and invocation must share a thread [LR03]. A quantized model may execute through float paths on GPU, so compare output/calibration and memory—not just wall time.

NNAPI is not a forward default: it was deprecated in Android 15 (API 35), and Android recommends migration toward alternatives such as LiteRT GPU [AN01]. Existing NNAPI-capable devices may be profiled as a research arm, but no new production dependency or broad auto-selection should be based on it.

## 7. Sustained performance, thermal, and battery

Short microbenchmarks are insufficient. For every baseline configuration:

- run the existing 10-minute foreground sustained session and 15-minute paired battery test;
- record per-stage p50/p90/p95/p99, admitted/dropped frames, result age, UI frame timing, RAM peak, thermal status, battery delta, and delegate/fallback events;
- compare minutes 8–10 against warm minutes 1–2;
- test not charging and document ambient conditions, case, brightness, camera, and power mode;
- repeat after foreground/background and rotation cycles.

Android exposes thermal status callbacks, but availability begins at API 29 and device behavior varies [AN02]. On lower supported APIs, rely on measured latency/busy-rate degradation and conservative cadence rather than an unavailable thermal signal.

Battery mitigation hierarchy:

1. reduce analysis cadence;
2. reduce analysis resolution if the face remains above quality threshold;
3. disable optional dense landmarking;
4. move from an inefficient/unreliable delegate to the validated CPU path;
5. pause analysis with an explanatory state under severe pressure.

Never lower confidence/quality thresholds to maintain throughput.

## 8. Measurement gates

| Question | Required evidence |
|---|---|
| Is an optimization faster? | Physical-device distributions after warm-up and sustained run, not mean alone |
| Is a delegate safe? | Operator partition report, initialization/failure tests, output diff, FER quality/calibration parity |
| Is memory bounded? | Peak incremental RAM under startup, steady state, rotation, background/resume, and fallback |
| Is UI isolated? | Flutter frame timings while camera/inference active; ≥95% frames within deadline aspirational |
| Is energy acceptable? | Paired camera-preview-only control under matched conditions |
| Is the pipeline fresh? | Capture-to-result age and stale-result rate, not inference time alone |

## 9. Facts, assumptions, trade-offs, and open questions

### Evidence-backed facts

- Latest-only CameraX backpressure is intended for analyzers that cannot process every frame [AX01].
- Long work on the main/UI thread causes missed display deadlines; Android and Flutter recommend worker execution [AN04][FL01].
- Delegate support and performance depend on both model operations and device, so benchmarking is required [LR02].
- NNAPI is deprecated as of Android 15 [AN01].

### Project assumptions

- Initial cadence steps of 5, 8, and 10 Hz are adequate.
- 480p is a useful starting analysis resolution.
- A warm-up of a few runs will stabilize the selected runtimes; exact count is measured, not fixed here.

### Trade-offs

- Keeping resources warm improves resume time but retains sensitive-capability resources and memory.
- GPU can reduce latency/power for some models but increases compatibility, memory, and lifecycle complexity.
- Lower cadence preserves thermals but reduces temporal responsiveness.

### Open questions

1. Which stage dominates end-to-end latency on each tier?
2. What CPU thread count minimizes sustained latency per joule without UI contention?
3. Does INT8 MobileNetV3-Small benefit from GPU on enough supported devices to justify shipping it?
4. Which thermal-status and latency thresholds provide stable, non-oscillating adaptation?
5. Can ROI-only YUV conversion be implemented consistently without introducing preprocessing drift?
