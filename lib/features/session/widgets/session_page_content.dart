import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/language/widgets/language_switch_action.dart';
import 'package:novian_recruitement_task/features/session/bloc/session_choices_cubit.dart';
import 'package:novian_recruitement_task/features/session/widgets/breathing_animation.dart';
import 'package:novian_recruitement_task/features/session/widgets/breaths_per_minute_picker.dart';
import 'package:novian_recruitement_task/features/session/widgets/session_continue_button.dart';
import 'package:novian_recruitement_task/features/session/widgets/session_duration_picker.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';

class SessionPageContent extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final spacing = context.appSpacing;
    final choices = context.watch<SessionChoicesCubit>().state;

    // The animation takes whatever height is left; on short screens
    // (landscape phones) the whole column scrolls instead of overflowing.
    return Scaffold(
      appBar: AppBar(
        title: Text(t.session.title),
        actions: const [LanguageSwitchAction()],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: spacing.maxContentWidth),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: spacing.l,
                      vertical: spacing.l,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Center(
                            child: BreathingAnimation(choices: choices),
                          ),
                        ),
                        SizedBox(height: spacing.xl),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
