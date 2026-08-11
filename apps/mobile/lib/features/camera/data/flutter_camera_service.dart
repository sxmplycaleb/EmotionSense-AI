import 'dart:async';

import 'package:camera/camera.dart';
import 'package:emotionsense_mobile/features/camera/application/camera_preview_surface.dart';
import 'package:emotionsense_mobile/features/camera/data/camera_preview_source.dart';
import 'package:emotionsense_mobile/features/camera/domain/camera_service.dart';
import 'package:flutter/widgets.dart';

final class FlutterCameraService implements CameraService, CameraPreviewSource {
  FlutterCameraService({
    Future<List<CameraDescription>> Function()? cameras,
    CameraController Function(CameraDescription)? controllerFactory,
  }) : _cameras = cameras ?? availableCameras,
       _controllerFactory = controllerFactory ?? _defaultController;

  final Future<List<CameraDescription>> Function() _cameras;
  final CameraController Function(CameraDescription) _controllerFactory;

  CameraController? _controller;
  Future<CameraServiceResult>? _initialization;
  bool _isDisposed = false;

  static CameraController _defaultController(CameraDescription description) {
    return CameraController(
      description,
      ResolutionPreset.medium,
      enableAudio: false,
    );
  }

  @override
  CameraPreviewSurface? get previewSurface {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) {
      return null;
    }
    return _FlutterCameraPreviewSurface(controller);
  }

  @override
  Future<CameraServiceResult> start() {
    if (_isDisposed) {
      return Future<CameraServiceResult>.value(
        const CameraServiceResult.failure(CameraFailure.disposed),
      );
    }

    final existingController = _controller;
    if (existingController != null && existingController.value.isInitialized) {
      return Future<CameraServiceResult>.value(
        const CameraServiceResult.ready(),
      );
    }

    final pendingInitialization = _initialization;
    if (pendingInitialization != null) {
      return pendingInitialization;
    }

    final initialization = _initialize();
    _initialization = initialization;
    unawaited(
      initialization.whenComplete(() {
        if (identical(_initialization, initialization)) {
          _initialization = null;
        }
      }),
    );
    return initialization;
  }

  @override
  Future<void> stop() async {
    final initialization = _initialization;
    if (initialization != null) {
      await initialization;
    }
    await _releaseController();
  }

  @override
  Future<void> dispose() async {
    if (_isDisposed) {
      return;
    }
    _isDisposed = true;
    await stop();
  }

  Future<CameraServiceResult> _initialize() async {
    try {
      final descriptions = await _cameras();
      final frontCamera = _frontCamera(descriptions);
      if (frontCamera == null) {
        return const CameraServiceResult.failure(CameraFailure.unavailable);
      }

      final controller = _controllerFactory(frontCamera);
      try {
        await controller.initialize();
      } on CameraException catch (error) {
        await controller.dispose();
        return CameraServiceResult.failure(_mapFailure(error));
      } catch (_) {
        await controller.dispose();
        return const CameraServiceResult.failure(
          CameraFailure.initializationFailed,
        );
      }

      if (_isDisposed) {
        await controller.dispose();
        return const CameraServiceResult.failure(CameraFailure.disposed);
      }

      _controller = controller;
      return const CameraServiceResult.ready();
    } on CameraException catch (error) {
      return CameraServiceResult.failure(_mapFailure(error));
    } catch (_) {
      return const CameraServiceResult.failure(CameraFailure.unavailable);
    }
  }

  CameraDescription? _frontCamera(List<CameraDescription> descriptions) {
    for (final description in descriptions) {
      if (description.lensDirection == CameraLensDirection.front) {
        return description;
      }
    }
    return null;
  }

  CameraFailure _mapFailure(CameraException error) {
    return switch (error.code) {
      'CameraAccessDenied' => CameraFailure.permissionDenied,
      'CameraAccessDeniedWithoutPrompt' ||
      'CameraAccessRestricted' => CameraFailure.permissionRestricted,
      _ => CameraFailure.initializationFailed,
    };
  }

  Future<void> _releaseController() async {
    final controller = _controller;
    _controller = null;
    if (controller != null) {
      await controller.dispose();
    }
  }
}

final class _FlutterCameraPreviewSurface implements CameraPreviewSurface {
  const _FlutterCameraPreviewSurface(this._controller);

  final CameraController _controller;

  @override
  double get aspectRatio => _controller.value.aspectRatio;

  @override
  Widget buildPreview() => CameraPreview(_controller);
}
