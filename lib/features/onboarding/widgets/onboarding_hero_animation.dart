import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// Slot for the onboarding Rive animation. Until it lands, a muted circle
/// labelled as a Rive placeholder reserves the space.
class OnboardingHeroAnimation extends StatelessWidget {
  const new({super.key});

  static const _maxSize = 280.0;

  @override
  Widget build(BuildContext context) {
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
                t.onboarding.heroAnimationPlaceholder,
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
