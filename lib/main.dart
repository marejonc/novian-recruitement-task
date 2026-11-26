import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/app.dart';
import 'package:novian_recruitement_task/di/configure_dependencies.dart';
import 'package:novian_recruitement_task/features/language/domain/get_saved_language_code_use_case.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:rive/rive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // The layouts are designed for a phone held upright only.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await RiveNative.init();
  await configureDependencies();
  await initTranslations(
    languageCode: await getIt<GetSavedLanguageCodeUseCase>()(),
  );

  runApp(TranslationProvider(child: const App()));
}
