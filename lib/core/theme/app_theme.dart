import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import 'text_styles.dart';

class AppTheme {
  AppTheme._();

  // ── Dark Theme ────────────────────────────────────────────────────────────
  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.primaryBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.appleBlue,
        secondary: AppColors.applePurple,
        tertiary: AppColors.appleGreen,
        surface: AppColors.secondaryBg,
        onPrimary: AppColors.primaryText,
        onSecondary: AppColors.primaryText,
        onSurface: AppColors.primaryText,
      ),
      textTheme: _buildTextTheme(isDark: true),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primaryBg.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: AppTextStyles.navBrand,
      ),
      cardTheme: CardThemeData(
        color: AppColors.glassCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.glassBorder, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.appleBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: AppTextStyles.buttonLabel,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryText,
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          textStyle: AppTextStyles.buttonLabel,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.glassCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.appleBlue, width: 1.5),
        ),
        labelStyle: const TextStyle(color: AppColors.secondaryText),
        hintStyle: const TextStyle(color: AppColors.mutedText),
      ),
      dividerColor: AppColors.border,
      iconTheme: const IconThemeData(color: AppColors.secondaryText),
      extensions: const [],
    );
  }

  // ── Light Theme ───────────────────────────────────────────────────────────
  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.lightPrimaryBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.appleBlue,
        secondary: AppColors.applePurple,
        tertiary: AppColors.appleGreen,
        surface: AppColors.lightSecondaryBg,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.lightPrimaryText,
      ),
      textTheme: _buildTextTheme(isDark: false),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightPrimaryBg.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: AppColors.lightPrimaryText,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightSecondaryBg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.appleBlue, width: 1.5),
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme({required bool isDark}) {
    final color = isDark ? AppColors.primaryText : AppColors.lightPrimaryText;
    return GoogleFonts.interTextTheme(ThemeData(brightness: isDark ? Brightness.dark : Brightness.light).textTheme)
        .apply(bodyColor: color, displayColor: color);
  }
}
