import 'dart:async';

import 'package:emotionsense_mobile/features/camera/application/camera_controller.dart';
import 'package:emotionsense_mobile/features/camera/application/camera_state.dart';
import 'package:emotionsense_mobile/features/camera/presentation/camera_preview_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(ref.read(cameraControllerProvider.notifier).stop());
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    unawaited(
      ref
          .read(cameraControllerProvider.notifier)
          .onLifecycleStateChanged(state),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cameraState = ref.watch(cameraControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Camera preview')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _CameraBody(state: cameraState),
        ),
      ),
    );
  }
}

class _CameraBody extends ConsumerWidget {
  const _CameraBody({required this.state});

  final CameraState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(cameraControllerProvider.notifier);

    return switch (state.status) {
      CameraStatus.ready => _ReadyCameraView(onStop: controller.stop),
      CameraStatus.initializing => const _CameraMessage(
        title: 'Preparing camera',
        message: 'Preparing a live, on-device camera preview.',
        showProgress: true,
      ),
      CameraStatus.permissionRequired => _CameraMessage(
        title: 'Camera access',
        message:
            'Camera access is needed to show a live, on-device preview. Frames are not saved or sent.',
        actionLabel: 'Start camera',
        onAction: controller.start,
      ),
      CameraStatus.permissionDenied => _CameraMessage(
        title: 'Camera permission denied',
        message:
            'Allow camera access when prompted, then try again. No camera data has been saved.',
        actionLabel: 'Try again',
        onAction: controller.start,
      ),
      CameraStatus.permissionRestricted => _CameraMessage(
        title: 'Camera access restricted',
        message:
            'Camera access is restricted. Enable it in device settings if available, then return and try again.',
        actionLabel: 'Try again',
        onAction: controller.start,
      ),
      CameraStatus.unavailable => _CameraMessage(
        title: 'Front camera unavailable',
        message: state.message ?? 'A front-facing camera is not available.',
        actionLabel: 'Try again',
        onAction: controller.start,
      ),
      CameraStatus.error => _CameraMessage(
        title: 'Camera unavailable',
        message: state.message ?? 'The camera could not be prepared.',
        actionLabel: 'Try again',
        onAction: controller.start,
      ),
      CameraStatus.paused => _CameraMessage(
        title: 'Camera paused',
        message: 'The camera was stopped while the app was not active.',
        actionLabel: 'Resume camera',
        onAction: controller.start,
      ),
    };
  }
}

class _ReadyCameraView extends ConsumerWidget {
  const _ReadyCameraView({required this.onStop});

  final Future<void> Function() onStop;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final surface = ref.watch(cameraPreviewSurfaceProvider);
    if (surface == null) {
      return const _CameraMessage(
        title: 'Camera unavailable',
        message:
            'The preview is no longer available. Try starting the camera again.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          label: 'Live front-facing camera preview',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: surface.aspectRatio,
              child: surface.buildPreview(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Camera active. Frames stay on this device and are not saved.',
        ),
        const Spacer(),
        FilledButton(onPressed: onStop, child: const Text('Stop camera')),
      ],
    );
  }
}

class _CameraMessage extends StatelessWidget {
  const _CameraMessage({
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.showProgress = false,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final Future<void> Function()? onAction;
  final bool showProgress;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Semantics(
        liveRegion: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showProgress) const CircularProgressIndicator(),
            if (showProgress) const SizedBox(height: 24),
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
