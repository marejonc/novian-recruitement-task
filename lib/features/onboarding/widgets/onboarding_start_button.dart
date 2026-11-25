import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/onboarding/bloc/complete_onboarding_cubit.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// Finishes onboarding; disabled while the flag is being saved and shows the
/// save error underneath when it fails.
class OnboardingStartButton extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CompleteOnboardingCubit>().state;
    final isBusy =
        state is CompleteOnboardingInProgress ||
        state is CompleteOnboardingSuccess;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton(
          onPressed: isBusy
              ? null
              : () => context.read<CompleteOnboardingCubit>().complete(),
          child: Text(t.onboarding.start),
        ),
        if (state is CompleteOnboardingError) ...[
          SizedBox(height: context.appSpacing.s),
          Text(
            t.onboarding.saveError,
            textAlign: TextAlign.center,
            style: context.appTypography.caption.copyWith(
              color: context.appColors.error,
            ),
          ),
        ],
      ],
    );
  }
}
