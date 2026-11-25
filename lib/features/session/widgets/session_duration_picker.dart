import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/features/session/bloc/session_choices_cubit.dart';
import 'package:novian_recruitement_task/features/session/domain/session_duration.dart';
import 'package:novian_recruitement_task/i18n/i18n.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// Session length as a full-width segmented choice.
class SessionDurationPicker extends StatelessWidget {
  const new({
    required this.duration,
    super.key,
  });

  final SessionDuration duration;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          t.session.durationLabel.toUpperCase(),
          style: context.appTypography.label,
        ),
        SizedBox(height: context.appSpacing.s),
        SegmentedButton<SessionDuration>(
          segments: [
            for (final option in SessionDuration.values)
              ButtonSegment(
                value: option,
                label: Text(
                  t.session.durationOption(minutes: option.minutes),
                ),
              ),
          ],
          selected: {duration},
          showSelectedIcon: false,
          expandedInsets: EdgeInsets.zero,
          onSelectionChanged: (selection) =>
              context.read<SessionChoicesCubit>().setDuration(selection.first),
        ),
      ],
    );
  }
}
