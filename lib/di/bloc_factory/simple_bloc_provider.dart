import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:novian_recruitement_task/di/bloc_factory/bloc_factory_context_extension.dart';

/// A `BlocProvider<T>` for a cubit without factory params: resolves `T` from
/// DI and closes it when removed from the tree.
class SimpleBlocProvider<T extends StateStreamableSource<Object?>>
    extends BlocProvider<T> {
  new({super.child, super.lazy, super.key})
    : super(create: (context) => context.blocFactory.get<T>());
}
