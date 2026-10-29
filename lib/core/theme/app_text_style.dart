import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'font_weight_helper.dart';

class AppTextStyle {
  // =========================================================================
  // TYPOGRAPHY — Kinetic Dark RTL
  // Font: Cairo (all weights)
  // Tabular nums enforced for all numeric content
  // RTL-aware: textAlign: TextAlign.right for narrative content
  // =========================================================================

  // Private helper for Cairo with tabular numerals
  static TextStyle _cairo({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? lineHeight,
    double? letterSpacing,
    TextDecoration? decoration,
    Color? decorationColor,
    List<FontFeature>? fontFeatures,
  }) {
    return GoogleFonts.cairo(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: lineHeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      decorationColor: decorationColor,
      fontFeatures: fontFeatures ?? const [FontFeature.tabularFigures()],
    );
  }

  // =========================================================================
  // DESIGN SYSTEM PRIMARY NAMES
  // =========================================================================

  /// 48px / 800 / 56px line height — Metric display, hero numbers
  static TextStyle get metricDisplay => _cairo(
        fontSize: 48,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.textPrimary,
        lineHeight: 56 / 48,
      );

  /// 36px / 800 / 48px line height — Display Large
  static TextStyle get displayLg => _cairo(
        fontSize: 36,
        fontWeight: FontWeightHelper.extraBold,
        color: AppColors.textPrimary,
        lineHeight: 48 / 36,
      );

  /// 28px / 700 / 40px line height — Headline XL
  static TextStyle get headlineXl => _cairo(
        fontSize: 28,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimary,
        lineHeight: 40 / 28,
      );

  /// 22px / 700 / 32px line height — Headline Large
  static TextStyle get headlineLg => _cairo(
        fontSize: 22,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimary,
        lineHeight: 32 / 22,
      );

  /// 18px / 600 / 28px line height — Headline Medium
  static TextStyle get headlineMd => _cairo(
        fontSize: 18,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.textPrimary,
        lineHeight: 28 / 18,
      );

  /// 16px / 500 / 26px line height — Body Large (primary reading)
  static TextStyle get bodyLg => _cairo(
        fontSize: 16,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textPrimary,
        lineHeight: 26 / 16,
      );

  /// 14px / 400 / 22px line height — Body Medium (default UI text)
  static TextStyle get bodyMd => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textSecondary,
        lineHeight: 22 / 14,
      );

  /// 12px / 400 / 18px line height — Body Small (metadata, timestamps)
  static TextStyle get bodySm => _cairo(
        fontSize: 12,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textTertiary,
        lineHeight: 18 / 12,
      );

  /// 14px / 700 / 20px line height — Label Large (Primary button text)
  static TextStyle get labelLg => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.onPrimary,
        lineHeight: 20 / 14,
      );

  /// 12px / 600 / 18px line height — Label Medium (Secondary button, chips)
  static TextStyle get labelMd => _cairo(
        fontSize: 12,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.textPrimary,
        lineHeight: 18 / 12,
      );

  /// 11px / 600 / 16px line height — Label Small (Tertiary actions, tags)
  static TextStyle get labelSm => _cairo(
        fontSize: 11,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.textSecondary,
        lineHeight: 16 / 11,
      );

  // =========================================================================
  // SEMANTIC / COMPONENT-SPECIFIC STYLES
  // =========================================================================

  // --- Button Styles ---
  static TextStyle get buttonPrimary => labelLg;

  static TextStyle get buttonSecondary => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.textPrimary,
        lineHeight: 20 / 14,
      );

  static TextStyle get buttonDestructive => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.statusExpired,
        lineHeight: 20 / 14,
      );

  // --- Input / Form Styles ---
  static TextStyle get inputLabel => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textSecondary,
        lineHeight: 22 / 14,
      );

  static TextStyle get inputHint => _cairo(
        fontSize: 16,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textTertiary,
        lineHeight: 26 / 16,
      );

  static TextStyle get inputText => _cairo(
        fontSize: 18,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textPrimary,
        lineHeight: 28 / 18,
      );

  static TextStyle get inputError => _cairo(
        fontSize: 12,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.statusExpired,
        lineHeight: 18 / 12,
      );

  // --- Status Chip Styles ---
  static TextStyle statusChip(Color statusColor) => _cairo(
        fontSize: 12,
        fontWeight: FontWeightHelper.semiBold,
        color: statusColor,
        lineHeight: 18 / 12,
      );

  // --- Member Card Styles ---
  static TextStyle get memberName => _cairo(
        fontSize: 18,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimary,
        lineHeight: 28 / 18,
      );

  static TextStyle get memberMeta => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textSecondary,
        lineHeight: 22 / 14,
      );

  static TextStyle subscriptionBadge(Color statusColor) => _cairo(
        fontSize: 12,
        fontWeight: FontWeightHelper.semiBold,
        color: statusColor,
        lineHeight: 18 / 12,
      );

  // --- Check-in Verification Card ---
  static TextStyle get verdictText => _cairo(
        fontSize: 16,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.onPrimary,
        lineHeight: 24 / 16,
      );

  static TextStyle get verificationName => headlineLg;

  static TextStyle get verificationExpiry => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textSecondary,
        lineHeight: 22 / 14,
      );

  // --- Navigation / Sidebar ---
  static TextStyle get navLabel => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.textPrimary,
        lineHeight: 22 / 14,
      );

  static TextStyle get navLabelInactive => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textTertiary,
        lineHeight: 22 / 14,
      );

  // --- Table / Data Grid ---
  static TextStyle get tableHeader => _cairo(
        fontSize: 12,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.textSecondary,
        lineHeight: 18 / 12,
        letterSpacing: 0.5,
      );

  static TextStyle get tableCell => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textPrimary,
        lineHeight: 22 / 14,
      );

  static TextStyle get tableCellNumeric => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textPrimary,
        lineHeight: 22 / 14,
      );

  // --- Caption / Overline ---
  static TextStyle get caption => _cairo(
        fontSize: 11,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textTertiary,
        lineHeight: 16 / 11,
      );

  static TextStyle get overline => _cairo(
        fontSize: 10,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textTertiary,
        lineHeight: 16 / 10,
        letterSpacing: 1.5,
      );

  // =========================================================================
  // MATERIAL 3 TEXT THEME ALIASES (Backward Compatibility)
  // These match the standard TextTheme property names
  // =========================================================================

  static TextStyle get displayLarge => displayLg;
  static TextStyle get displayMedium => headlineXl;
  static TextStyle get displaySmall => headlineLg;

  static TextStyle get headlineLarge => headlineLg;
  static TextStyle get headlineMedium => headlineMd;
  static TextStyle get headlineSmall => _cairo(
        fontSize: 16,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.textPrimary,
        lineHeight: 24 / 16,
      );

  static TextStyle get titleLarge => headlineMd;
  static TextStyle get titleMedium => _cairo(
        fontSize: 16,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textPrimary,
        lineHeight: 24 / 16,
      );
  static TextStyle get titleSmall => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textPrimary,
        lineHeight: 20 / 14,
      );

  static TextStyle get bodyLarge => bodyLg;
  static TextStyle get bodyMedium => bodyMd;
  static TextStyle get bodySmall => bodySm;

  static TextStyle get labelLarge => labelLg;
  static TextStyle get labelMedium => labelMd;
  static TextStyle get labelSmall => labelSm;

  // Button (old names)
  static TextStyle get buttonLarge => buttonPrimary;
  static TextStyle get buttonMedium => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.onPrimary,
        lineHeight: 20 / 14,
      );
  static TextStyle get buttonSmall => _cairo(
        fontSize: 12,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.onPrimary,
        lineHeight: 18 / 12,
      );

  // Semantic old names
  static TextStyle get font16PrimarySemiBold => _cairo(
        fontSize: 16,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.primary,
      );
  static TextStyle get font14PrimaryMedium => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.primaryContainer,
      );
  static TextStyle get font14TextPrimaryMedium => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.medium,
        color: AppColors.textPrimary,
      );
  static TextStyle get font14TextSecondaryRegular => _cairo(
        fontSize: 14,
        fontWeight: FontWeightHelper.regular,
        color: AppColors.textSecondary,
      );
  static TextStyle get font16TextPrimaryBold => _cairo(
        fontSize: 16,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimary,
      );
  static TextStyle get font18TextPrimaryBold => _cairo(
        fontSize: 18,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimary,
      );
  static TextStyle get font20TextPrimarySemiBold => _cairo(
        fontSize: 20,
        fontWeight: FontWeightHelper.semiBold,
        color: AppColors.textPrimary,
      );
  static TextStyle get font24TextPrimaryBold => _cairo(
        fontSize: 24,
        fontWeight: FontWeightHelper.bold,
        color: AppColors.textPrimary,
      );
  static TextStyle get font32TextPrimaryBold => headlineXl;
}