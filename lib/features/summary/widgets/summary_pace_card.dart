import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/session/domain/breathing_pace.dart';
import 'package:novian_recruitement_task/features/session/domain/session_choices.dart';
import 'package:novian_recruitement_task/features/session/widgets/extensions/breathing_pace_extension.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:novian_recruitement_task/theme/app_radius.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// The chosen pace with a relaxation message written for it. The card is
/// tinted with the pace accent, and the bar shows how intense the pace is
/// within the allowed range.
class SummaryPaceCard extends StatelessWidget {
  const new({
    required this.firstName,
    required this.choices,
    super.key,
  });

  final String firstName;
  final SessionChoices choices;

  static const _intensityBarHeight = 6.0;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final colors = context.appColors;
    final typography = context.appTypography;
    final spacing = context.appSpacing;
    final pace = choices.pace;
    final accent = pace.accentIn(colors);
    final muted = pace.mutedIn(colors);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: muted,
        borderRadius: BorderRadius.circular(context.appRadius.l),
      ),
      child: Padding(
        padding: EdgeInsets.all(spacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              t.summary.paceLabel.toUpperCase(),
              style: typography.label.copyWith(color: accent),
            ),
            SizedBox(height: spacing.xs),
            Text(_paceName(t, pace), style: typography.title),
            SizedBox(height: spacing.m),
            ClipRRect(
              borderRadius: BorderRadius.circular(context.appRadius.pill),
              child: LinearProgressIndicator(
                value: choices.intensity,
                minHeight: _intensityBarHeight,
                color: accent,
                backgroundColor: colors.surface,
              ),
            ),
            SizedBox(height: spacing.m),
            Text(_message(t, pace), style: typography.body),
          ],
        ),
      ),
    );
  }

  String _paceName(Translations t, BreathingPace pace) => switch (pace) {
    BreathingPace.deep => t.summary.paceName.deep,
    BreathingPace.balanced => t.summary.paceName.balanced,
    BreathingPace.energizing => t.summary.paceName.energizing,
  };

  String _message(Translations t, BreathingPace pace) => switch (pace) {
    BreathingPace.deep => t.summary.message.deep(firstName: firstName),
    BreathingPace.balanced => t.summary.message.balanced(firstName: firstName),
    BreathingPace.energizing => t.summary.message.energizing(
      firstName: firstName,
    ),
  };
}
