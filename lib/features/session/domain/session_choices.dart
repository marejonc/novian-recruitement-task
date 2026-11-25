import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:novian_recruitement_task/features/session/domain/breathing_pace.dart';
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

  /// Up to five breaths a minute is deep, up to eight is balanced, anything
  /// faster is energizing.
  BreathingPace get pace => switch (breathsPerMinute) {
    <= 5 => BreathingPace.deep,
    <= 8 => BreathingPace.balanced,
    _ => BreathingPace.energizing,
  };

  /// Where the pace sits between the slowest (0) and the fastest (1) choice.
  double get intensity =>
      (breathsPerMinute - minBreathsPerMinute) /
      (maxBreathsPerMinute - minBreathsPerMinute);

  /// Breaths taken over the whole session at the chosen pace.
  int get totalBreaths => breathsPerMinute * duration.minutes;

  @override
  List<Object?> get props => [breathsPerMinute, duration];
}
