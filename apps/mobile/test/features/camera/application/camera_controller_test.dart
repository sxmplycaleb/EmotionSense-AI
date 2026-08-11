import 'package:emotionsense_mobile/features/camera/application/camera_controller.dart';
import 'package:emotionsense_mobile/features/camera/application/camera_providers.dart';
import 'package:emotionsense_mobile/features/camera/application/camera_state.dart';
import 'package:emotionsense_mobile/features/camera/domain/camera_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CameraSessionController', () {
    test('starts in an explicit permission-required state', () {
      final fakeService = _FakeCameraService();
      final container = _containerFor(fakeService);
      addTearDown(container.dispose);

      expect(
        container.read(cameraControllerProvider).status,
        CameraStatus.permissionRequired,
      );
    });

    test('starts once and exposes the ready state', () async {
      final fakeService = _FakeCameraService();
      final container = _containerFor(fakeService);
      addTearDown(container.dispose);
      final controller = container.read(cameraControllerProvider.notifier);

      await controller.start();
      await controller.start();

      expect(
        container.read(cameraControllerProvider).status,
        CameraStatus.ready,
      );
      expect(fakeService.startCalls, 1);
    });

    test('maps a denied permission without throwing', () async {
      final fakeService = _FakeCameraService(
        result: const CameraServiceResult.failure(
          CameraFailure.permissionDenied,
        ),
      );
      final container = _containerFor(fakeService);
      addTearDown(container.dispose);

      await container.read(cameraControllerProvider.notifier).start();

      expect(
        container.read(cameraControllerProvider).status,
        CameraStatus.permissionDenied,
      );
    });

    test('maps restricted permission to a recoverable state', () async {
      final fakeService = _FakeCameraService(
        result: const CameraServiceResult.failure(
          CameraFailure.permissionRestricted,
        ),
      );
      final container = _containerFor(fakeService);
      addTearDown(container.dispose);

      await container.read(cameraControllerProvider.notifier).start();

      expect(
        container.read(cameraControllerProvider).status,
        CameraStatus.permissionRestricted,
      );
    });

    test('maps unavailable and initialization failures', () async {
      final fakeService = _FakeCameraService(
        results: const [
          CameraServiceResult.failure(CameraFailure.unavailable),
          CameraServiceResult.failure(CameraFailure.initializationFailed),
        ],
      );
      final container = _containerFor(fakeService);
      addTearDown(container.dispose);
      final controller = container.read(cameraControllerProvider.notifier);

      await controller.start();
      expect(
        container.read(cameraControllerProvider).status,
        CameraStatus.unavailable,
      );

      await controller.start();
      expect(
        container.read(cameraControllerProvider).status,
        CameraStatus.error,
      );
    });

    test(
      'stops in the background and restarts one prior session on resume',
      () async {
        final fakeService = _FakeCameraService();
        final container = _containerFor(fakeService);
        addTearDown(container.dispose);
        final controller = container.read(cameraControllerProvider.notifier);

        await controller.start();
        await controller.onLifecycleStateChanged(AppLifecycleState.paused);

        expect(
          container.read(cameraControllerProvider).status,
          CameraStatus.paused,
        );
        expect(fakeService.stopCalls, 1);

        await controller.onLifecycleStateChanged(AppLifecycleState.resumed);

        expect(
          container.read(cameraControllerProvider).status,
          CameraStatus.ready,
        );
        expect(fakeService.startCalls, 2);
      },
    );

    test('stops the service when explicitly stopped or disposed', () async {
      final fakeService = _FakeCameraService();
      final container = _containerFor(fakeService);
      final controller = container.read(cameraControllerProvider.notifier);

      await controller.start();
      await controller.stop();
      expect(
        container.read(cameraControllerProvider).status,
        CameraStatus.permissionRequired,
      );
      expect(fakeService.stopCalls, 1);

      container.dispose();
      expect(fakeService.stopCalls, 2);
    });
  });
}

ProviderContainer _containerFor(_FakeCameraService service) {
  return ProviderContainer(
    overrides: [cameraServiceProvider.overrideWithValue(service)],
  );
}

final class _FakeCameraService implements CameraService {
  _FakeCameraService({
    CameraServiceResult? result,
    List<CameraServiceResult>? results,
  }) : _results = results ?? [result ?? const CameraServiceResult.ready()];

  final List<CameraServiceResult> _results;
  int _resultIndex = 0;
  int startCalls = 0;
  int stopCalls = 0;

  @override
  Future<void> dispose() => Future<void>.value();

  @override
  Future<CameraServiceResult> start() async {
    startCalls += 1;
    final result = _results[_resultIndex.clamp(0, _results.length - 1)];
    _resultIndex += 1;
    return result;
  }

  @override
  Future<void> stop() async {
    stopCalls += 1;
  }
}
