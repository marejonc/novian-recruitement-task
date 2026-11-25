import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/onboarding/widgets/onboarding_hero_animation.dart';
import 'package:novian_recruitement_task/features/onboarding/widgets/onboarding_intro.dart';
import 'package:novian_recruitement_task/features/onboarding/widgets/onboarding_start_button.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';

class OnboardingPageContent extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    // The hero takes whatever height is left; on short screens (landscape
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
                    child: Column(
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
                    ),
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
