import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:novian_recruitement_task/di/configure_dependencies.dart';
import 'package:novian_recruitement_task/features/onboarding/domain/has_completed_onboarding_use_case.dart';
import 'package:novian_recruitement_task/routing/app_router.gr.dart';

/// Sends a first-launch user to onboarding before any guarded route is
/// shown, so the session screen never flashes first. Onboarding ends with
/// `replaceAll`, so the aborted navigation is not resumed here.
class OnboardingGuard extends AutoRouteGuard {
  const new();

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final hasCompletedOnboarding =
        await getIt<HasCompletedOnboardingUseCase>()();
    if (hasCompletedOnboarding) {
      resolver.next();
      return;
    }
    unawaited(router.push(const OnboardingRoute()));
    resolver.next(false);
  }
}
