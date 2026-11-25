import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/onboarding/widgets/onboarding_hero_animation.dart';
import 'package:novian_recruitement_task/features/onboarding/widgets/onboarding_intro.dart';
import 'package:novian_recruitement_task/features/onboarding/widgets/onboarding_start_button.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';

/// Second onboarding step: the app introduction with the hero animation.
class OnboardingIntroStep extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Expanded(
          child: Center(child: OnboardingHeroAnimation()),
        ),
        SizedBox(height: spacing.xl),
        const OnboardingIntro(),
        SizedBox(height: spacing.xl),
        const OnboardingStartButton(),
      ],
    );
  }
}
