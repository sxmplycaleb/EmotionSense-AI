import 'dart:async';

import 'package:emotionsense_mobile/features/camera/application/camera_providers.dart';
import 'package:emotionsense_mobile/features/camera/application/camera_state.dart';
import 'package:emotionsense_mobile/features/camera/domain/camera_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraControllerProvider =
    NotifierProvider.autoDispose<CameraSessionController, CameraState>(
      CameraSessionController.new,
    );

final class CameraSessionController extends Notifier<CameraState> {
  late final CameraService _service;
  bool _isDisposed = false;
  bool _restartWhenResumed = false;

  @override
  CameraState build() {
    _service = ref.watch(cameraServiceProvider);
    ref.onDispose(() {
      _isDisposed = true;
      unawaited(_service.stop());
    });
    return const CameraState(CameraStatus.permissionRequired);
  }

  Future<void> start() async {
    if (_isDisposed ||
        state.status == CameraStatus.initializing ||
        state.status == CameraStatus.ready) {
      return;
    }

    state = const CameraState(CameraStatus.initializing);
    final result = await _service.start();
    if (_isDisposed) {
      return;
    }

    if (result.isReady) {
      _restartWhenResumed = true;
      state = const CameraState(CameraStatus.ready);
      return;
    }

    _restartWhenResumed = false;
    state = _stateForFailure(result.failure!);
  }

  Future<void> stop() async {
    _restartWhenResumed = false;
    await _service.stop();
    if (!_isDisposed) {
      state = const CameraState(CameraStatus.permissionRequired);
    }
  }

  Future<void> onLifecycleStateChanged(AppLifecycleState lifecycleState) async {
    switch (lifecycleState) {
      case AppLifecycleState.resumed:
        if (_restartWhenResumed) {
          await start();
        }
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        final shouldRestart =
            state.isReady || state.status == CameraStatus.initializing;
        _restartWhenResumed = _restartWhenResumed || shouldRestart;
        await _service.stop();
        if (!_isDisposed) {
          state = const CameraState(CameraStatus.paused);
        }
    }
  }

  CameraState _stateForFailure(CameraFailure failure) {
    return switch (failure) {
      CameraFailure.permissionDenied => const CameraState.withMessage(
        CameraStatus.permissionDenied,
        'Camera permission was denied.',
      ),
      CameraFailure.permissionRestricted => const CameraState.withMessage(
        CameraStatus.permissionRestricted,
        'Camera access is restricted by the device settings.',
      ),
      CameraFailure.unavailable => const CameraState.withMessage(
        CameraStatus.unavailable,
        'A front-facing camera is not available on this device.',
      ),
      CameraFailure.initializationFailed => const CameraState.withMessage(
        CameraStatus.error,
        'The camera could not be prepared.',
      ),
      CameraFailure.disposed => const CameraState.withMessage(
        CameraStatus.error,
        'The camera session is no longer available.',
      ),
    };
  }
}
