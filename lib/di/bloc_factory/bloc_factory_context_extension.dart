import 'package:flutter/widgets.dart';
import 'package:novian_recruitement_task/di/bloc_factory/bloc_factory.dart';
import 'package:provider/provider.dart';

extension BlocFactoryContextExtension on BuildContext {
  BlocFactory get blocFactory => read<BlocFactory>();
}
