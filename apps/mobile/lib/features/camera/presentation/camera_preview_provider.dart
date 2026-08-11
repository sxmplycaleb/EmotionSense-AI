import 'package:emotionsense_mobile/features/camera/application/camera_controller.dart';
import 'package:emotionsense_mobile/features/camera/application/camera_preview_surface.dart';
import 'package:emotionsense_mobile/features/camera/application/camera_providers.dart';
import 'package:emotionsense_mobile/features/camera/data/camera_preview_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraPreviewSurfaceProvider =
    Provider.autoDispose<CameraPreviewSurface?>((ref) {
      ref.watch(cameraControllerProvider);
      final service = ref.read(cameraServiceProvider);
      return switch (service) {
        CameraPreviewSource source => source.previewSurface,
        _ => null,
      };
    });
