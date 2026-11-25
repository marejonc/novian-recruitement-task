import 'package:material_ui/material_ui.dart';
import 'package:novian_recruitement_task/theme/app_colors.dart';
import 'package:novian_recruitement_task/theme/app_fonts.dart';
import 'package:novian_recruitement_task/theme/app_radius.dart';
import 'package:novian_recruitement_task/theme/app_spacing.dart';
import 'package:novian_recruitement_task/theme/app_typography.dart';

/// Builds the Material [ThemeData] from the app tokens, so stock Material
/// widgets (buttons, sliders, progress) match the custom ones.
abstract final class AppTheme {
  static final ThemeData light = _build(
    brightness: Brightness.light,
    colors: AppColors.light,
    typography: AppTypography.light,
  );

  static final ThemeData dark = _build(
    brightness: Brightness.dark,
    colors: AppColors.dark,
    typography: AppTypography.dark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required AppColors colors,
    required AppTypography typography,
  }) {
    const spacing = AppSpacing.regular;
    const radius = AppRadius.regular;

    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      primaryContainer: colors.primaryMuted,
      onPrimaryContainer: colors.textPrimary,
      secondary: colors.accent,
      onSecondary: colors.onPrimary,
      secondaryContainer: colors.accentMuted,
      onSecondaryContainer: colors.textPrimary,
      error: colors.error,
      onError: colors.onError,
      surface: colors.surface,
      onSurface: colors.textPrimary,
      onSurfaceVariant: colors.textSecondary,
      surfaceContainerHighest: colors.surfaceMuted,
      outline: colors.outline,
      outlineVariant: colors.outline,
    );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius.pill),
    );
    final buttonPadding = EdgeInsets.symmetric(
      horizontal: spacing.l,
      vertical: spacing.m,
    );

    return ThemeData(
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.background,
      fontFamily: AppFonts.sans,
      textTheme: TextTheme(
        displayLarge: typography.display,
        headlineMedium: typography.headline,
        titleMedium: typography.title,
        bodyLarge: typography.body,
        bodyMedium: typography.body,
        labelLarge: typography.bodyStrong,
        labelMedium: typography.label,
        bodySmall: typography.caption,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: typography.title,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          textStyle: typography.bodyStrong,
          padding: buttonPadding,
          shape: buttonShape,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          textStyle: typography.bodyStrong,
          padding: buttonPadding,
          shape: buttonShape,
          side: BorderSide(color: colors.outline),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.primary,
          textStyle: typography.bodyStrong,
          shape: buttonShape,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          foregroundColor: colors.textSecondary,
          selectedForegroundColor: colors.primary,
          selectedBackgroundColor: colors.primaryMuted,
          side: BorderSide(color: colors.outline),
          textStyle: typography.bodyStrong,
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colors.primary,
        inactiveTrackColor: colors.primaryMuted,
        thumbColor: colors.primary,
        overlayColor: colors.primary.withValues(alpha: 0.12),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primary,
        linearTrackColor: colors.primaryMuted,
        circularTrackColor: colors.primaryMuted,
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.l),
          side: BorderSide(color: colors.outline),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.outline,
        thickness: 1,
        space: spacing.l,
      ),
      extensions: [colors, typography, spacing, radius],
    );
  }
}
