import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // =========================================================================
  // Brand (Neon Lime)
  // =========================================================================
  static const Color _neonLime = Color(0xFFC6F432);
  static const Color _neonLimeDim = Color(0xFFAAD600);
  static const Color _neonLimeDark = Color(0xFF556D00);

  // =========================================================================
  // Material 3 ColorScheme mapping
  // =========================================================================
  static const Color primary = _neonLime;
  static const Color onPrimary = Color(0xFF000000); // text on lime = black
  static const Color primaryContainer = _neonLimeDim;
  static const Color onPrimaryContainer = _neonLimeDark;

  static const Color secondary = Color(0xFFADC6FF);
  static const Color onSecondary = Color(0xFF002E6A);
  static const Color secondaryContainer = Color(0xFF0566D9);
  static const Color onSecondaryContainer = Color(0xFFE6ECFF);

  static const Color tertiary = Color(0xFF6BFF8F);
  static const Color onTertiary = Color(0xFF003915);
  static const Color tertiaryContainer = Color(0xFF4AE176);
  static const Color onTertiaryContainer = Color(0xFF007432);

  // Error: design-system red (used by inputs, chips, destructive buttons)
  static const Color error = Color(0xFFEF4444);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFF93000A);
  static const Color onErrorContainer = Color(0xFFFFDAD6);
  static const Color errorLight = Color(0xFFFFB4AB); // Material tonal red

  // Surfaces
  static const Color background = Color(0xFF0F1115); // canvas
  static const Color onBackground = Color(0xFFE2E2E8);
  static const Color surface = Color(0xFF181B21); // Level 1
  static const Color onSurface = Color(0xFFE2E2E8);
  static const Color surfaceDim = Color(0xFF111317);
  static const Color surfaceBright = Color(0xFF37393E);
  static const Color surfaceContainerLowest = Color(0xFF0C0E12);
  static const Color surfaceContainerLow = Color(0xFF1A1C20);
  static const Color surfaceContainer = Color(0xFF20242C); // Level 2
  static const Color surfaceContainerHigh = Color(0xFF282A2E);
  static const Color surfaceContainerHighest = Color(0xFF333539);
  static const Color surfaceVariant = Color(0xFF333539);

  // Outline
  static const Color outline = Color(0xFF8E937A);
  static const Color outlineVariant = Color(0xFF444934);

  // Shadow / overlay
  static const Color shadow = Color(0x40000000);
  static const Color scrim = Color(0x80000000);

  // Inverse
  static const Color inverseSurface = Color(0xFFE2E2E8);
  static const Color inverseOnSurface = Color(0xFF2F3035);
  static const Color inversePrimary = Color(0xFF506600);
  static const Color surfaceTint = _neonLimeDim;

  // =========================================================================
  // Design-system semantic names (use these in app code)
  // =========================================================================
  static const Color canvas = background;
  static const Color surfaceLevel1 = surface;
  static const Color surfaceLevel2 = surfaceContainer;
  static const Color strokeDefault = Color(0xFF262A33);
  static const Color strokeStrong = Color(0xFF2E333F);

  static const Color neonLime = _neonLime;
  static const Color neonLimeDim = _neonLimeDim;
  static const Color onNeonLime = onPrimary;
  static const Color neonLimeBg = Color(0x1FC6F432); // 12%

  // Status
  static const Color statusActive = Color(0xFF22C55E);
  static const Color statusActiveBg = Color(0x1F22C55E);
  static const Color statusActiveBorder = Color(0x4D22C55E);
  static const Color onStatusActive = Color(0xFF000000);

  static const Color statusExpired = Color(0xFFEF4444);
  static const Color statusExpiredBg = Color(0x1FEF4444);
  static const Color statusExpiredBorder = Color(0x4DEF4444);
  static const Color onStatusExpired = Color(0xFFFFFFFF);

  static const Color statusExpiring = Color(0xFFF59E0B);
  static const Color statusExpiringBg = Color(0x1FF59E0B);
  static const Color statusExpiringBorder = Color(0x4DF59E0B);
  static const Color onStatusExpiring = Color(0xFF000000);

  static const Color statusFrozen = Color(0xFF3B82F6);
  static const Color statusFrozenBg = Color(0x1F3B82F6);
  static const Color statusFrozenBorder = Color(0x4D3B82F6);
  static const Color onStatusFrozen = Color(0xFFFFFFFF);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9EACB9);
  static const Color textTertiary = Color(0xFF5A6472);
  static const Color textOnSurfaceVariant = Color(0xFFC4C9AE);

  // =========================================================================
  // Aliases (backward compatibility)
  // =========================================================================
  static const Color primaryLight = _neonLimeDim;
  static const Color primaryDark = _neonLimeDark;
  static const Color primaryGradientStart = _neonLime;
  static const Color primaryGradientEnd = _neonLimeDim;

  static const Color secondaryLight = Color(0xFFD8E2FF);
  static const Color secondaryDark = Color(0xFF004395);
  static const Color tertiaryLight = Color(0xFF6BFF8F);
  static const Color tertiaryDark = Color(0xFF005321);

  static const Color surfaceVariantLegacy = surfaceVariant;
  static const Color backgroundSecondary = surfaceLevel1;

  static const Color textOnPrimary = onPrimary;
  static const Color textOnSecondary = onSecondary;
  static const Color textOnSurface = onSurface;
  static const Color textOnBackground = onBackground;

  static const Color success = statusActive;
  static const Color successContainer = statusActiveBg;
  static const Color warning = statusExpiring;
  static const Color warningContainer = statusExpiringBg;
  static const Color info = statusFrozen;
  static const Color infoContainer = statusFrozenBg;

  static const Color divider = strokeDefault;
  static const Color shadowStrong = Color(0x60000000);
  static const Color overlay = scrim;
  static const Color overlayLight = Color(0x40000000);

  // =========================================================================
  // Gradients
  // =========================================================================
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [_neonLime, _neonLimeDim],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient surfaceGradient = LinearGradient(
    colors: [surfaceContainer, surfaceLevel1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient elevatedGradient = LinearGradient(
    colors: [surfaceContainerHigh, surfaceContainer],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, surfaceDim, surfaceLevel1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [surfaceLevel1, surfaceContainerLow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // =========================================================================
  // Glow effects (BoxShadow)
  // =========================================================================
  static const Color glowActive = Color(0x40C6F432); // 25% lime
  static const Color glowCritical = Color(0x4DEF4444); // 30% red
}
