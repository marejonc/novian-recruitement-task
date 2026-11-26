import 'package:novian_recruitement_task/features/motion/domain/device_tilt.dart';
import 'package:novian_recruitement_task/features/onboarding/widgets/extensions/view_model_instance_extension.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:rive/rive.dart';

/// Typed access to the `Bloom` view model of
/// `assets/rive/onboarding_bloom.riv`. The property names must match
/// `rive/onboarding_bloom/scene.rml`; Rive silently ignores an unknown name.
///
/// It only writes values; the instance itself belongs to the
/// `RiveWidgetBuilder` that created it.
class OnboardingBloomViewModel {
  const new(this._instance);

  static const _tiltX = 'tiltX';
  static const _tiltY = 'tiltY';
  static const _haloColor = 'haloColor';
  static const _outerPetalColor = 'outerPetalColor';
  static const _middlePetalColor = 'middlePetalColor';
  static const _innerPetalColor = 'innerPetalColor';
  static const _coreColor = 'coreColor';

  final ViewModelInstance _instance;

  void setTilt(DeviceTilt tilt) {
    _instance
      ..setNumber(_tiltX, tilt.x)
      ..setNumber(_tiltY, tilt.y);
  }

  /// One hue throughout: the rings get their depth from the file's per-ring
  /// transparency, not from different colours.
  void setPalette(AppColors colors) {
    _instance
      ..setColor(_haloColor, colors.primaryMuted)
      ..setColor(_outerPetalColor, colors.primary)
      ..setColor(_middlePetalColor, colors.primary)
      ..setColor(_innerPetalColor, colors.primary)
      ..setColor(_coreColor, colors.primary);
  }
}
