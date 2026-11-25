import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/app.dart';
import 'package:novian_recruitement_task/di/configure_dependencies.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:rive/rive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RiveNative.init();
  await initTranslations();
  await configureDependencies();

  runApp(const App());
}
