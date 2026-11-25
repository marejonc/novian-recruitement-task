import 'package:injectable/injectable.dart';
import 'package:novian_recruitement_task/features/session/domain/session_choices.dart';
import 'package:novian_recruitement_task/features/session/domain/session_duration.dart';
import 'package:single_value_cubit/single_value_cubit.dart';

/// The single source of truth for the session parameters. Provided by
/// `SessionFlowPage` above both the session and the summary route.
@injectable
class SessionChoicesCubit extends SingleValueCubit<SessionChoices> {
  new() : super(SessionChoices.initial);

  void setBreathsPerMinute(int breathsPerMinute) => set(
    state.copyWith(
      breathsPerMinute: breathsPerMinute.clamp(
        SessionChoices.minBreathsPerMinute,
        SessionChoices.maxBreathsPerMinute,
      ),
    ),
  );

  void setDuration(SessionDuration duration) =>
      set(state.copyWith(duration: duration));
}
