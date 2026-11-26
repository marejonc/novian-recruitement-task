import 'package:novian_recruitement_task/features/onboarding/widgets/extensions/view_model_instance_extension.dart';
import 'package:novian_recruitement_task/features/session/domain/session_choices.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:rive/rive.dart';

/// Typed access to the `Pacer` view model of `assets/rive/session_pacer.riv`.
/// The property names must match `rive/session_pacer/scene.rml`; Rive
/// silently ignores an unknown name.
///
/// It only writes values; the instance itself belongs to the
/// `RiveWidgetBuilder` that created it.
class SessionPacerViewModel {
  const new(this._instance);

  static const _breathsPerMinute = 'breathsPerMinute';
  static const _durationMinutes = 'durationMinutes';
  static const _petalColor = 'petalColor';
  static const _haloColor = 'haloColor';
  static const _coreColor = 'coreColor';

  final ViewModelInstance _instance;

  /// Pace sets the petal count, breath speed and exhale length; duration
  /// the number of petal rings.
  void setChoices(SessionChoices choices) {
    _instance
      ..setNumber(_breathsPerMinute, choices.breathsPerMinute.toDouble())
      ..setNumber(_durationMinutes, choices.duration.minutes.toDouble());
  }

  /// The palette of the app icon and the onboarding bloom: one hue for the
  /// petals, which get their depth from the file's per-ring transparency.
  void setPalette(AppColors colors) {
    _instance
      ..setColor(_petalColor, colors.primary)
      ..setColor(_haloColor, colors.primaryMuted)
      ..setColor(_coreColor, colors.bloomCenter);
  }
}
