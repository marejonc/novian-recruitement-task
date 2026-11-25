import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// Placeholder until the session screen is built.
class SessionPageContent extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t.session.title)),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(context.appSpacing.l),
          child: Text(
            t.session.placeholder,
            textAlign: TextAlign.center,
            style: context.appTypography.body.copyWith(
              color: context.appColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
