import 'package:novian_recruitement_task/features/motion/domain/device_tilt.dart';

/// A live source of [DeviceTilt] readings. A sensor pushes values on its own
/// schedule, so unlike the repositories it exposes a stream.
abstract interface class DeviceTiltSensor {
  Stream<DeviceTilt> watchTilt();
}
