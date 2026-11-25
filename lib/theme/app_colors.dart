import 'package:material_ui/material_ui.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_colors.tailor.dart';

/// Colour tokens. Widgets read them through `context.appColors`; raw colours
/// never appear outside `lib/theme/`.
@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class AppColors extends ThemeExtension<AppColors> with _$AppColorsTailorMixin {
  const new({
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.primary,
    required this.primaryMuted,
    required this.onPrimary,
    required this.accent,
    required this.accentMuted,
    required this.energy,
    required this.energyMuted,
    required this.textPrimary,
    required this.textSecondary,
    required this.outline,
    required this.error,
    required this.onError,
  });

  /// Warm paper background with a deep sage primary and a dusk-lavender
  /// accent — calm, low-contrast surfaces with strong text contrast.
  static const light = AppColors(
    background: Color(0xFFF6F2EA),
    surface: Color(0xFFFFFCF6),
    surfaceMuted: Color(0xFFECE6DA),
    primary: Color(0xFF2F5D50),
    primaryMuted: Color(0xFFD5E3DB),
    onPrimary: Color(0xFFFFFCF6),
    accent: Color(0xFF8A7BB8),
    accentMuted: Color(0xFFE5DFF3),
    energy: Color(0xFFB0672E),
    energyMuted: Color(0xFFF3E2CF),
    textPrimary: Color(0xFF1E2622),
    textSecondary: Color(0xFF5E6A64),
    outline: Color(0xFFD8D0C2),
    error: Color(0xFFB4443A),
    onError: Color(0xFFFFFCF6),
  );

  /// Deep night-blue background; the sage and lavender are lifted so they
  /// keep their contrast on dark surfaces.
  static const dark = AppColors(
    background: Color(0xFF10151C),
    surface: Color(0xFF18202A),
    surfaceMuted: Color(0xFF222C38),
    primary: Color(0xFF8FC2AE),
    primaryMuted: Color(0xFF24413A),
    onPrimary: Color(0xFF0E1A16),
    accent: Color(0xFFB7A9E6),
    accentMuted: Color(0xFF2E2944),
    energy: Color(0xFFE6AC78),
    energyMuted: Color(0xFF3B2D21),
    textPrimary: Color(0xFFEDEAE3),
    textSecondary: Color(0xFFA3ACA8),
    outline: Color(0xFF2F3A46),
    error: Color(0xFFF0958A),
    onError: Color(0xFF2A0F0C),
  );

  @override
  final Color background;
  @override
  final Color surface;
  @override
  final Color surfaceMuted;
  @override
  final Color primary;
  @override
  final Color primaryMuted;
  @override
  final Color onPrimary;
  @override
  final Color accent;
  @override
  final Color accentMuted;

  /// Warm amber for quick, energizing breathing — the third accent next to
  /// the calm sage and the deep lavender.
  @override
  final Color energy;
  @override
  final Color energyMuted;
  @override
  final Color textPrimary;
  @override
  final Color textSecondary;
  @override
  final Color outline;
  @override
  final Color error;
  @override
  final Color onError;
}
