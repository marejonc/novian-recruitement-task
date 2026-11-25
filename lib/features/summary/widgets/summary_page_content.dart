import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/language/widgets/language_switch_action.dart';
import 'package:novian_recruitement_task/features/summary/bloc/summary_cubit.dart';
import 'package:novian_recruitement_task/features/summary/widgets/summary_error_view.dart';
import 'package:novian_recruitement_task/features/summary/widgets/summary_loaded_view.dart';
import 'package:novian_recruitement_task/features/summary/widgets/summary_loading_view.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';

class SummaryPageContent extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final state = context.watch<SummaryCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.summary.title),
        actions: const [LanguageSwitchAction()],
      ),
      body: SafeArea(
        child: switch (state) {
          SummaryLoading() => const SummaryLoadingView(),
          SummaryError() => const SummaryErrorView(),
          SummaryLoaded(:final user, :final age, :final choices) =>
            SummaryLoadedView(user: user, age: age, choices: choices),
        },
      ),
    );
  }
}
