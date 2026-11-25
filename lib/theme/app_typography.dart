import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:novian_recruitement_task/theme/app_fonts.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_typography.tailor.dart';

/// Text style tokens, read through `context.appTypography`. Each style
/// already carries its colour for the current brightness; widgets may change
/// the colour with `copyWith(color: …)` but never the size or weight.
@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class AppTypography extends ThemeExtension<AppTypography>
    with _$AppTypographyTailorMixin {
  const new({
    required this.display,
    required this.headline,
    required this.title,
    required this.body,
    required this.bodyStrong,
    required this.label,
    required this.caption,
    required this.metric,
  });

  factory fromColors(AppColors colors) => AppTypography(
    display: TextStyle(
      fontFamily: AppFonts.serif,
      fontSize: 44,
      height: 1.05,
      letterSpacing: -0.5,
      color: colors.textPrimary,
    ),
    headline: TextStyle(
      fontFamily: AppFonts.serif,
      fontSize: 30,
      height: 1.15,
      letterSpacing: -0.2,
      color: colors.textPrimary,
    ),
    title: TextStyle(
      fontFamily: AppFonts.sans,
      fontSize: 19,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: colors.textPrimary,
    ),
    body: TextStyle(
      fontFamily: AppFonts.sans,
      fontSize: 16,
      height: 1.5,
      color: colors.textPrimary,
    ),
    bodyStrong: TextStyle(
      fontFamily: AppFonts.sans,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: colors.textPrimary,
    ),
    label: TextStyle(
      fontFamily: AppFonts.sans,
      fontSize: 13,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: 1.2,
      color: colors.textSecondary,
    ),
    caption: TextStyle(
      fontFamily: AppFonts.sans,
      fontSize: 13,
      height: 1.4,
      color: colors.textSecondary,
    ),
    metric: TextStyle(
      fontFamily: AppFonts.serif,
      fontSize: 64,
      height: 1,
      color: colors.textPrimary,
      fontFeatures: const [FontFeature.tabularFigures()],
    ),
  );

  static final light = AppTypography.fromColors(AppColors.light);
  static final dark = AppTypography.fromColors(AppColors.dark);

  /// Serif, the largest welcome and hero headings.
  @override
  final TextStyle display;

  /// Serif, page titles.
  @override
  final TextStyle headline;

  /// Sans, card and section titles.
  @override
  final TextStyle title;
  @override
  final TextStyle body;
  @override
  final TextStyle bodyStrong;

  /// Small tracked caps-style label above values and sections.
  @override
  final TextStyle label;
  @override
  final TextStyle caption;

  /// Large serif number, e.g. breaths per minute.
  @override
  final TextStyle metric;
}
