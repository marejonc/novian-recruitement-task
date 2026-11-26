import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/summary/bloc/summary_cubit.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// The profile could not be fetched; offers a retry.
class SummaryErrorView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final spacing = context.appSpacing;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.summary.loadError,
              textAlign: TextAlign.center,
              style: context.appTypography.body,
            ),
            SizedBox(height: spacing.l),
            OutlinedButton(
              onPressed: () => context.read<SummaryCubit>().retry(),
              child: Text(t.summary.retry),
            ),
          ],
        ),
      ),
    );
  }
}
