import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// Slot for the session Rive animation. It receives the chosen pace and
/// length as plain values, so the animation can react to them without owning
/// any app state. Until it lands, a muted circle reserves the space.
class BreathingAnimation extends StatelessWidget {
  const new({
    required this.breathsPerMinute,
    required this.durationMinutes,
    super.key,
  });

  final int breathsPerMinute;
  final int durationMinutes;

  static const _maxSize = 240.0;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final colors = context.appColors;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: _maxSize,
        maxHeight: _maxSize,
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.primaryMuted,
            shape: BoxShape.circle,
            border: Border.all(color: colors.primary),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.animation, color: colors.primary),
              SizedBox(height: context.appSpacing.xs),
              Text(
                t.session.breathingAnimationPlaceholder,
                style: context.appTypography.label.copyWith(
                  color: colors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
