import 'package:material_ui/material_ui.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_spacing.tailor.dart';

/// Spacing scale for padding and gaps, read through `context.appSpacing`.
@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class AppSpacing extends ThemeExtension<AppSpacing>
    with _$AppSpacingTailorMixin {
  const new({
    required this.xxs,
    required this.xs,
    required this.s,
    required this.m,
    required this.l,
    required this.xl,
    required this.xxl,
    required this.xxxl,
    required this.maxContentWidth,
  });

  static const regular = AppSpacing(
    xxs: 4,
    xs: 8,
    s: 12,
    m: 16,
    l: 24,
    xl: 32,
    xxl: 48,
    xxxl: 64,
    maxContentWidth: 560,
  );

  @override
  final double xxs;
  @override
  final double xs;
  @override
  final double s;
  @override
  final double m;
  @override
  final double l;
  @override
  final double xl;
  @override
  final double xxl;
  @override
  final double xxxl;

  /// Content column width on tablets and landscape, so lines stay readable.
  @override
  final double maxContentWidth;
}
