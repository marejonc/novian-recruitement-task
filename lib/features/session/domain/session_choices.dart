import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:novian_recruitement_task/features/session/domain/session_duration.dart';

part 'session_choices.g.dart';

/// Breathing parameters picked on the session screen and read by the
/// summary screen.
@CopyWith()
class SessionChoices extends Equatable {
  const new({
    required this.breathsPerMinute,
    required this.duration,
  });

  static const minBreathsPerMinute = 4;
  static const maxBreathsPerMinute = 12;

  /// A calm resonance pace of six breaths a minute for three minutes.
  static const initial = SessionChoices(
    breathsPerMinute: 6,
    duration: SessionDuration.threeMinutes,
  );

  final int breathsPerMinute;
  final SessionDuration duration;

  @override
  List<Object?> get props => [breathsPerMinute, duration];
}
