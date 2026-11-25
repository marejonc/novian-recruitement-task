import 'package:material_ui/material_ui.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_radius.tailor.dart';

/// Corner radii, read through `context.appRadius`.
@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class AppRadius extends ThemeExtension<AppRadius> with _$AppRadiusTailorMixin {
  const new({
    required this.s,
    required this.m,
    required this.l,
    required this.xl,
    required this.pill,
  });

  static const regular = AppRadius(s: 8, m: 16, l: 24, xl: 32, pill: 999);

  @override
  final double s;
  @override
  final double m;
  @override
  final double l;
  @override
  final double xl;

  /// Fully rounded ends for buttons and chips.
  @override
  final double pill;
}
