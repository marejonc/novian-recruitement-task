import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/di/configure_dependencies.config.dart';

final GetIt getIt = GetIt.instance;

/// Awaited in `main()` before `runApp`, because `SharedPreferences` is
/// registered with `@preResolve`.
@InjectableInit()
Future<void> configureDependencies() => getIt.init();
