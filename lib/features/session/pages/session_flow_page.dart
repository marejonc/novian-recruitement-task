import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/di/bloc_factory.dart';
import 'package:novian_recruitement_task/features/session/bloc/session_choices_cubit.dart';
import 'package:novian_recruitement_task/features/summary/bloc/summary_cubit.dart';
import 'package:novian_recruitement_task/features/user/bloc/users_cubit.dart';
import 'package:provider/provider.dart';

/// Shell route around the session → summary flow. It provides the session
/// choices above both child routes, so the summary reads the same live
/// cubit instead of a copy passed as route arguments.
///
/// The users cubit lives here too and starts eagerly: the users are fetched
/// for the picker on the session screen, and the summary follows whichever
/// user and parameters are picked.
@RoutePage()
class SessionFlowPage extends StatelessWidget implements AutoRouteWrapper {
  const new({super.key});

  @override
  Widget wrappedRoute(BuildContext context) => MultiProvider(
    providers: [
      SimpleBlocProvider<SessionChoicesCubit>(),
      BlocProvider<UsersCubit>(
        lazy: false,
        create: (ctx) => ctx.blocFactory.get()..load(),
      ),
      BlocProvider<SummaryCubit>(
        create: (ctx) =>
            ctx.blocFactory.get(SummaryCubitDeps(ctx.read(), ctx.read())),
      ),
    ],
    child: this,
  );

  @override
  Widget build(BuildContext context) => const AutoRouter();
}
