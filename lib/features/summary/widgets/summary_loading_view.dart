import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// Shown while the user profile is fetched from the backend.
class SummaryLoadingView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          SizedBox(height: context.appSpacing.m),
          Text(t.summary.loading, style: context.appTypography.caption),
        ],
      ),
    );
  }
}
