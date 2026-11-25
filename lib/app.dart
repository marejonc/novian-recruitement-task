import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/di/bloc_factory.dart';
import 'package:novian_recruitement_task/di/configure_dependencies.dart';
import 'package:novian_recruitement_task/features/language/bloc/language_cubit.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/routing/app_router.dart';
import 'package:novian_recruitement_task/theme/app_theme.dart';
import 'package:provider/provider.dart';

final appRouter = AppRouter();

class App extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    // The language cubit sits above the router, so onboarding and the
    // session flow share one switch. `TranslationProvider` (above `App`)
    // rebuilds this widget when the locale changes.
    return MultiProvider(
      providers: [
        BlocFactoryProvider(getIt: getIt),
        SimpleBlocProvider<LanguageCubit>(),
      ],
      child: MaterialApp.router(
        onGenerateTitle: (context) => context.t.common.appTitle,
        locale: TranslationProvider.of(context).flutterLocale,
        supportedLocales: AppLocaleUtils.supportedLocales,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
