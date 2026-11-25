import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/di/bloc_factory.dart';
import 'package:novian_recruitement_task/features/onboarding/bloc/complete_onboarding_cubit.dart';
import 'package:novian_recruitement_task/features/onboarding/bloc/onboarding_step_cubit.dart';
import 'package:novian_recruitement_task/features/onboarding/widgets/onboarding_page_content.dart';
import 'package:novian_recruitement_task/routing/app_router.gr.dart';
import 'package:provider/provider.dart';

@RoutePage()
class OnboardingPage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        SimpleBlocProvider<OnboardingStepCubit>(),
        SimpleBlocProvider<CompleteOnboardingCubit>(),
        BlocListener<CompleteOnboardingCubit, CompleteOnboardingState>(
          listener: (context, state) {
            if (state is CompleteOnboardingSuccess) {
              unawaited(context.router.replaceAll([const SessionFlowRoute()]));
            }
          },
        ),
      ],
      child: const OnboardingPageContent(),
    );
  }
}
