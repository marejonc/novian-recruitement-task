import 'package:auto_route/auto_route.dart';
import 'package:novian_recruitement_task/routing/app_router.gr.dart';
import 'package:novian_recruitement_task/routing/onboarding_guard.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: OnboardingRoute.page, path: '/onboarding'),
    AutoRoute(
      page: SessionRoute.page,
      path: '/session',
      initial: true,
      guards: const [OnboardingGuard()],
    ),
    AutoRoute(
      page: SummaryRoute.page,
      path: '/summary',
      guards: const [OnboardingGuard()],
    ),
  ];
}
