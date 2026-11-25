import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/di/bloc_factory.dart';
import 'package:novian_recruitement_task/di/configure_dependencies.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/routing/app_router.dart';

final appRouter = AppRouter();

class App extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocFactoryProvider(
      getIt: getIt,
      child: MaterialApp.router(
        title: t.common.appTitle,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
