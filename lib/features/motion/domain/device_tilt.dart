import 'package:equatable/equatable.dart';

/// How far the device is tilted away from the pose the user holds it in.
/// Both axes run from -1 to 1: [x] is positive when the right edge dips,
/// [y] is positive when the bottom edge dips.
class DeviceTilt extends Equatable {
  const new({
    required this.x,
    required this.y,
  });

  static const level = DeviceTilt(x: 0, y: 0);

  final double x;
  final double y;

  @override
  List<Object?> get props => [x, y];
}
