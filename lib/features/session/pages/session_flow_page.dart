import 'package:auto_route/auto_route.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/di/bloc_factory.dart';
import 'package:novian_recruitement_task/features/session/bloc/session_choices_cubit.dart';

/// Shell route around the session → summary flow. It provides the session
/// choices above both child routes, so the summary reads the same live
/// cubit instead of a copy passed as route arguments.
@RoutePage()
class SessionFlowPage extends StatelessWidget implements AutoRouteWrapper {
  const new({super.key});

  @override
  Widget wrappedRoute(BuildContext context) =>
      SimpleBlocProvider<SessionChoicesCubit>(child: this);

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
