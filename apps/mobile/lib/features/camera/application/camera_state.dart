enum CameraStatus {
  permissionRequired,
  initializing,
  ready,
  permissionDenied,
  permissionRestricted,
  unavailable,
  error,
  paused,
}

final class CameraState {
  const CameraState(this.status) : message = null;

  const CameraState.withMessage(this.status, this.message);

  final CameraStatus status;
  final String? message;

  bool get isReady => status == CameraStatus.ready;
}
