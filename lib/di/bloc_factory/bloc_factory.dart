import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

/// Resolves Blocs and Cubits from the DI container, so widgets never touch
/// `getIt` directly. Reached through `context.blocFactory`.
class BlocFactory {
  const new(this._injector);

  final GetIt _injector;

  /// `T` is usually inferred from the surrounding `BlocProvider<T>`, so the
  /// type is written once. [param] is the cubit's single `XCubitDeps`.
  T get<T extends StateStreamableSource<Object?>>([Object? param]) =>
      _injector.get<T>(param1: param);
}
