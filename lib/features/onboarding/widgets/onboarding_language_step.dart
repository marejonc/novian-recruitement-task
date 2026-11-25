import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/language/widgets/language_switch.dart';
import 'package:novian_recruitement_task/features/onboarding/bloc/onboarding_step_cubit.dart';
import 'package:novian_recruitement_task/features/onboarding/domain/onboarding_step.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// First onboarding step: pick the app language, then move on to the intro.
class OnboardingLanguageStep extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final colors = context.appColors;
    final spacing = context.appSpacing;
    final typography = context.appTypography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(),
        Text(
          t.onboarding.eyebrow.toUpperCase(),
          style: typography.label.copyWith(color: colors.primary),
        ),
        SizedBox(height: spacing.xs),
        Text(t.onboarding.languageTitle, style: typography.display),
        SizedBox(height: spacing.m),
        Text(
          t.onboarding.languageBody,
          style: typography.body.copyWith(color: colors.textSecondary),
        ),
        SizedBox(height: spacing.xl),
        const LanguageSwitch(),
        const Spacer(),
        SizedBox(height: spacing.xl),
        FilledButton(
          onPressed: () =>
              context.read<OnboardingStepCubit>().set(OnboardingStep.intro),
          child: Text(t.onboarding.languageContinue),
        ),
      ],
    );
  }
}
