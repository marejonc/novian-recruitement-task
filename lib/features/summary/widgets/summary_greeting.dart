import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/user/domain/user.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// Greets the user by first name, with the full name and age underneath.
class SummaryGreeting extends StatelessWidget {
  const new({
    required this.user,
    required this.age,
    super.key,
  });

  final User user;
  final int age;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final typography = context.appTypography;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.summary.greeting(firstName: user.firstName),
          style: typography.headline,
        ),
        SizedBox(height: context.appSpacing.xs),
        Text(
          t.summary.identity(
            n: age,
            firstName: user.firstName,
            lastName: user.lastName,
          ),
          style: typography.caption,
        ),
      ],
    );
  }
}
