import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/language/widgets/language_switch_action.dart';
import 'package:novian_recruitement_task/features/session/bloc/session_choices_cubit.dart';
import 'package:novian_recruitement_task/features/session/widgets/breathing_animation.dart';
import 'package:novian_recruitement_task/features/session/widgets/breaths_per_minute_picker.dart';
import 'package:novian_recruitement_task/features/session/widgets/session_continue_button.dart';
import 'package:novian_recruitement_task/features/session/widgets/session_duration_picker.dart';
import 'package:novian_recruitement_task/features/session/widgets/session_user_picker.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';

class SessionPageContent extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final spacing = context.appSpacing;
    final choices = context.watch<SessionChoicesCubit>().state;

    // The animation takes whatever height is left, so the page fits the
    // screen without scrolling.
    return Scaffold(
      appBar: AppBar(
        title: Text(t.session.title),
        actions: const [LanguageSwitchAction()],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: spacing.maxContentWidth),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                spacing.l,
                spacing.xs,
                spacing.l,
                spacing.l,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SessionUserPicker(),
                  SizedBox(height: spacing.m),
                  Expanded(
                    child: Center(
                      child: BreathingAnimation(choices: choices),
                    ),
                  ),
                  SizedBox(height: spacing.l),
                  BreathsPerMinutePicker(
                    breathsPerMinute: choices.breathsPerMinute,
                  ),
                  SizedBox(height: spacing.l),
                  SessionDurationPicker(duration: choices.duration),
                  SizedBox(height: spacing.xl),
                  const SessionContinueButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
