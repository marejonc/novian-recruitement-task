import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/motion/domain/device_tilt.dart';
import 'package:novian_recruitement_task/features/motion/domain/device_tilt_sensor.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// Derives tilt from the accelerometer's gravity vector.
///
/// Tilt is measured against a baseline: the first reading, which then slowly
/// follows the device. However the phone is held — upright, flat, lying on
/// the sofa — that pose reads as level, a tilt shows up straight away and
/// drifts back to level over a few seconds once the phone is held still.
@LazySingleton(as: DeviceTiltSensor)
class AccelerometerDeviceTiltSensor implements DeviceTiltSensor {
  /// Gravity change (m/s²) that maps to a full tilt of 1 — about 20°.
  static const _fullTilt = 3.4;

  /// Share of the gap the baseline closes on every reading (~50 Hz): it
  /// re-centres in roughly four seconds.
  static const _baselineFollow = 0.005;

  @override
  Stream<DeviceTilt> watchTilt() {
    double? baselineX;
    double? baselineY;

    return accelerometerEventStream(
      samplingPeriod: SensorInterval.gameInterval,
    ).map((event) {
      final fromX = baselineX ?? event.x;
      final fromY = baselineY ?? event.y;
      baselineX = fromX + (event.x - fromX) * _baselineFollow;
      baselineY = fromY + (event.y - fromY) * _baselineFollow;

      // Gravity along +x drops when the right edge dips, so x is negated;
      // along +y it drops when the top edge dips, which is a negative y.
      return DeviceTilt(
        x: (-(event.x - fromX) / _fullTilt).clamp(-1, 1),
        y: ((event.y - fromY) / _fullTilt).clamp(-1, 1),
      );
    });
  }
}
