import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/onboarding/bloc/onboarding_step_cubit.dart';
import 'package:novian_recruitement_task/features/onboarding/domain/onboarding_step.dart';
import 'package:novian_recruitement_task/features/onboarding/widgets/onboarding_intro_step.dart';
import 'package:novian_recruitement_task/features/onboarding/widgets/onboarding_language_step.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';

class OnboardingPageContent extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;
    final step = context.watch<OnboardingStepCubit>().state;

    // Each step fills the remaining height; on short screens (landscape
    // phones) the whole column scrolls instead of overflowing.
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: spacing.maxContentWidth),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.l,
                      vertical: spacing.xl,
                    ),
                    child: switch (step) {
                      OnboardingStep.language => const OnboardingLanguageStep(),
                      OnboardingStep.intro => const OnboardingIntroStep(),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
