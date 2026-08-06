import 'dart:ui';

/// Apple-inspired color palette for Datt Patel's portfolio
class AppColors {
  AppColors._();

  // ── Backgrounds ──────────────────────────────────────────────────────────
  static const Color primaryBg = Color(0xFF09090B);
  static const Color secondaryBg = Color(0xFF111827);
  static const Color sectionBg = Color(0xFF161B22);

  // ── Glass ─────────────────────────────────────────────────────────────────
  static const Color glassCard = Color(0x0FFFFFFF); // rgba(255,255,255,0.06)
  static const Color glassBorder = Color(0x14FFFFFF); // rgba(255,255,255,0.08)

  // ── Apple Accent Colors ───────────────────────────────────────────────────
  static const Color appleBlue = Color(0xFF007AFF);
  static const Color appleGreen = Color(0xFF34C759);
  static const Color applePurple = Color(0xFFAF52DE);
  static const Color appleOrange = Color(0xFFFF9F0A);
  static const Color appleRed = Color(0xFFFF453A);
  static const Color appleCyan = Color(0xFF32D74B);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB8C1CC);
  static const Color mutedText = Color(0xFF7D8590);

  // ── Border ────────────────────────────────────────────────────────────────
  static const Color border = Color(0x14FFFFFF);
  static const Color borderLight = Color(0x26FFFFFF);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const List<Color> heroGradient = [
    Color(0xFF09090B),
    Color(0xFF0D1117),
    Color(0xFF09090B),
  ];

  static const List<Color> blueGlow = [
    Color(0x33007AFF),
    Color(0x00007AFF),
  ];

  static const List<Color> purpleGlow = [
    Color(0x33AF52DE),
    Color(0x00AF52DE),
  ];

  static const List<Color> cardGradient = [
    Color(0x1AFFFFFF),
    Color(0x05FFFFFF),
  ];

  static const List<Color> buttonGradient = [
    Color(0xFF007AFF),
    Color(0xFF0056B3),
  ];

  static const List<Color> skillCardGradient = [
    Color(0xFF161B22),
    Color(0xFF0D1117),
  ];

  // ── Light Theme ───────────────────────────────────────────────────────────
  static const Color lightPrimaryBg = Color(0xFFF5F5F7);
  static const Color lightSecondaryBg = Color(0xFFFFFFFF);
  static const Color lightPrimaryText = Color(0xFF1D1D1F);
  static const Color lightSecondaryText = Color(0xFF6E6E73);
  static const Color lightMutedText = Color(0xFFAEAEB2);
  static const Color lightBorder = Color(0xFFD2D2D7);
  static const Color lightCard = Color(0xFFFFFFFF);
}
