import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ── Display ───────────────────────────────────────────────────────────────
  static TextStyle get displayXl => GoogleFonts.inter(
        fontSize: 80,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
        letterSpacing: -3.0,
        height: 1.0,
      );

  static TextStyle get displayLg => GoogleFonts.inter(
        fontSize: 64,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryText,
        letterSpacing: -2.5,
        height: 1.1,
      );

  static TextStyle get displayMd => GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryText,
        letterSpacing: -1.5,
        height: 1.15,
      );

  static TextStyle get displaySm => GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryText,
        letterSpacing: -1.0,
        height: 1.2,
      );

  // ── Heading ───────────────────────────────────────────────────────────────
  static TextStyle get h1 => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryText,
        letterSpacing: -0.5,
      );

  static TextStyle get h2 => GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
        letterSpacing: -0.3,
      );

  static TextStyle get h3 => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
      );

  // ── Body ──────────────────────────────────────────────────────────────────
  static TextStyle get bodyLg => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryText,
        height: 1.7,
      );

  static TextStyle get bodyMd => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryText,
        height: 1.6,
      );

  static TextStyle get bodySm => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryText,
        height: 1.5,
      );

  // ── Labels & Tags ─────────────────────────────────────────────────────────
  static TextStyle get labelLg => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryText,
        letterSpacing: 0.2,
      );

  static TextStyle get labelMd => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryText,
        letterSpacing: 0.4,
      );

  static TextStyle get labelSm => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.mutedText,
        letterSpacing: 0.6,
      );

  static TextStyle get overline => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.appleBlue,
        letterSpacing: 2.0,
      );

  // ── Navigation ────────────────────────────────────────────────────────────
  static TextStyle get navBrand => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryText,
        letterSpacing: -0.5,
      );

  static TextStyle get navItem => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryText,
      );

  static TextStyle get navItemActive => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryText,
      );

  // ── Button ────────────────────────────────────────────────────────────────
  static TextStyle get buttonLabel => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      );

  // ── Code ──────────────────────────────────────────────────────────────────
  static TextStyle get code => GoogleFonts.firaCode(
        fontSize: 14,
        color: AppColors.appleGreen,
      );

  // ── Hero Specific ─────────────────────────────────────────────────────────
  static TextStyle get heroGreeting => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: AppColors.secondaryText,
        letterSpacing: 0.5,
      );

  static TextStyle get heroName => GoogleFonts.inter(
        fontSize: 72,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
        letterSpacing: -3.0,
        height: 1.0,
      );

  static TextStyle get heroNameMobile => GoogleFonts.inter(
        fontSize: 44,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
        letterSpacing: -2.0,
        height: 1.1,
      );

  static TextStyle get heroRole => GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: AppColors.appleBlue,
        letterSpacing: -0.5,
      );

  static TextStyle get heroRoleMobile => GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.appleBlue,
        letterSpacing: -0.3,
      );

  // ── Stat Counter ──────────────────────────────────────────────────────────
  static TextStyle get statValue => GoogleFonts.inter(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        color: AppColors.primaryText,
        letterSpacing: -2.0,
      );

  static TextStyle get statLabel => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: AppColors.mutedText,
        letterSpacing: 0.3,
      );
}
