import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:novian_recruitement_task/di/bloc_factory/bloc_factory.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Puts a [BlocFactory] over [getIt] into the tree. Placed once, above every
/// page, in `app.dart`.
class BlocFactoryProvider extends SingleChildStatelessWidget {
  const new({
    required this.getIt,
    super.child,
    super.key,
  });

  final GetIt getIt;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return Provider<BlocFactory>.value(
      value: BlocFactory(getIt),
      child: child,
    );
  }
}
