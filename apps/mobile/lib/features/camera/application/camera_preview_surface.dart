import 'package:flutter/widgets.dart';

abstract interface class CameraPreviewSurface {
  double get aspectRatio;

  Widget buildPreview();
}
