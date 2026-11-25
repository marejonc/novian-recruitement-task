import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/session/bloc/session_choices_cubit.dart';
import 'package:novian_recruitement_task/features/session/domain/session_choices.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// Breathing pace: the current value in large figures over a slider with
/// one stop per breath.
class BreathsPerMinutePicker extends StatelessWidget {
  const new({
    required this.breathsPerMinute,
    super.key,
  });

  final int breathsPerMinute;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final spacing = context.appSpacing;
    final typography = context.appTypography;
    final paceUnit = t.session.paceUnit(n: breathsPerMinute);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(t.session.paceLabel.toUpperCase(), style: typography.label),
        SizedBox(height: spacing.xs),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(breathsPerMinute.toString(), style: typography.metric),
            SizedBox(width: spacing.s),
            Flexible(child: Text(paceUnit, style: typography.body)),
          ],
        ),
        Slider(
          value: breathsPerMinute.toDouble(),
          min: SessionChoices.minBreathsPerMinute.toDouble(),
          max: SessionChoices.maxBreathsPerMinute.toDouble(),
          divisions:
              SessionChoices.maxBreathsPerMinute -
              SessionChoices.minBreathsPerMinute,
          semanticFormatterCallback: (value) =>
              t.session.paceSemantics(n: value.round()),
          onChanged: (value) => context
              .read<SessionChoicesCubit>()
              .setBreathsPerMinute(value.round()),
        ),
      ],
    );
  }
}
