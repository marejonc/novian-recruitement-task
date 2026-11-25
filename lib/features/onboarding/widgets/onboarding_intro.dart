import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

class OnboardingIntro extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final typography = context.appTypography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.onboarding.eyebrow.toUpperCase(),
          style: typography.label.copyWith(color: colors.primary),
        ),
        SizedBox(height: spacing.xs),
        Text(t.onboarding.title, style: typography.display),
        SizedBox(height: spacing.m),
        Text(
          t.onboarding.body,
          style: typography.body.copyWith(color: colors.textSecondary),
        ),
      ],
    );
  }
}
