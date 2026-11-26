import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/motion/domain/device_tilt.dart';
import 'package:novian_recruitement_task/features/motion/domain/watch_device_tilt_use_case.dart';
import 'package:rxdart/rxdart.dart';
import 'package:single_value_cubit/single_value_cubit.dart';

/// The current device tilt. Stays [DeviceTilt.level] on devices without an
/// accelerometer (simulators) — the sensor error is reported, not shown.
@injectable
class DeviceTiltCubit extends SingleValueCubit<DeviceTilt> {
  new(this._watchDeviceTilt) : super(DeviceTilt.level);

  final WatchDeviceTiltUseCase _watchDeviceTilt;
  StreamSubscription<DeviceTilt>? _sub;

  void watch() {
    unawaited(_sub?.cancel());
    _sub = _watchDeviceTilt()
        .onErrorReturnWith((error, stackTrace) {
          addError(error, stackTrace);
          return DeviceTilt.level;
        })
        .listen(set);
  }

  @override
  Future<void> close() {
    unawaited(_sub?.cancel());
    return super.close();
  }
}
