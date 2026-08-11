import 'dart:async';

import 'package:emotionsense_mobile/features/camera/data/flutter_camera_service.dart';
import 'package:emotionsense_mobile/features/camera/domain/camera_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cameraServiceProvider = Provider.autoDispose<CameraService>((ref) {
  final service = FlutterCameraService();
  ref.onDispose(() => unawaited(service.dispose()));
  return service;
});
