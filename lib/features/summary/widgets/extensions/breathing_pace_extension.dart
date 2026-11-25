import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/session/domain/breathing_pace.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';

/// The summary tints itself by pace: lavender for deep, sage for balanced
/// and amber for energizing breathing.
extension BreathingPaceExtension on BreathingPace {
  Color accentIn(AppColors colors) => switch (this) {
    BreathingPace.deep => colors.accent,
    BreathingPace.balanced => colors.primary,
    BreathingPace.energizing => colors.energy,
  };

  Color mutedIn(AppColors colors) => switch (this) {
    BreathingPace.deep => colors.accentMuted,
    BreathingPace.balanced => colors.primaryMuted,
    BreathingPace.energizing => colors.energyMuted,
  };
}
