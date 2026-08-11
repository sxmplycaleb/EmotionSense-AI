enum CameraFailure {
  permissionDenied,
  permissionRestricted,
  unavailable,
  initializationFailed,
  disposed,
}

final class CameraServiceResult {
  const CameraServiceResult.ready() : failure = null;

  const CameraServiceResult.failure(this.failure)
    : assert(failure != null, 'A failed camera result requires a failure.');

  final CameraFailure? failure;

  bool get isReady => failure == null;
}

abstract interface class CameraService {
  Future<CameraServiceResult> start();

  Future<void> stop();

  Future<void> dispose();
}
