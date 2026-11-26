import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/motion/domain/device_tilt.dart';
import 'package:novian_recruitement_task/features/motion/domain/device_tilt_sensor.dart';

@injectable
class WatchDeviceTiltUseCase {
  const new(this._sensor);

  final DeviceTiltSensor _sensor;

  Stream<DeviceTilt> call() => _sensor.watchTilt();
}
