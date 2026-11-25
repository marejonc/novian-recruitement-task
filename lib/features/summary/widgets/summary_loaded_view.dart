import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/session/domain/session_choices.dart';
import 'package:novian_recruitement_task/features/summary/widgets/summary_greeting.dart';
import 'package:novian_recruitement_task/features/summary/widgets/summary_pace_card.dart';
import 'package:novian_recruitement_task/features/summary/widgets/summary_session_card.dart';
import 'package:novian_recruitement_task/features/user/domain/user.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';

/// The personalized summary: who the user is, how the chosen pace will feel
/// and what the session adds up to.
class SummaryLoadedView extends StatelessWidget {
  const new({
    required this.user,
    required this.age,
    required this.choices,
    super.key,
  });

  final User user;
  final int age;
  final SessionChoices choices;

  @override
  Widget build(BuildContext context) {
    final spacing = context.appSpacing;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: spacing.maxContentWidth),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.l,
            vertical: spacing.l,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SummaryGreeting(user: user, age: age),
              SizedBox(height: spacing.xl),
              SummaryPaceCard(firstName: user.firstName, choices: choices),
              SizedBox(height: spacing.m),
              SummarySessionCard(choices: choices),
            ],
          ),
        ),
      ),
    );
  }
}
