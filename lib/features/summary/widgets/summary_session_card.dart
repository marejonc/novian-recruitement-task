import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/session/domain/session_choices.dart';
import 'package:novian_recruitement_task/features/session/widgets/extensions/breathing_pace_extension.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// How many breaths the whole session adds up to, with the pace and length
/// it was computed from.
class SummarySessionCard extends StatelessWidget {
  const new({
    required this.choices,
    super.key,
  });

  final SessionChoices choices;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final typography = context.appTypography;
    final spacing = context.appSpacing;
    final accent = choices.pace.accentIn(context.appColors);
    final totalBreaths = choices.totalBreaths;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(spacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.summary.sessionLabel.toUpperCase(),
              style: typography.label,
            ),
            SizedBox(height: spacing.s),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  totalBreaths.toString(),
                  style: typography.metric.copyWith(color: accent),
                ),
                SizedBox(width: spacing.s),
                Flexible(
                  child: Text(
                    t.summary.totalBreathsUnit(n: totalBreaths),
                    style: typography.bodyStrong,
                  ),
                ),
              ],
            ),
            SizedBox(height: spacing.xs),
            Text(
              t.summary.sessionDetails(
                breathsPerMinute: choices.breathsPerMinute,
                minutes: choices.duration.minutes,
              ),
              style: typography.caption,
            ),
          ],
        ),
      ),
    );
  }
}
