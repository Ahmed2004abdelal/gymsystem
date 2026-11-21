// import 'package:flutter/material.dart';

// class AppColors {
//   AppColors._();

//   // =========================================================================
//   // Brand — Fiery Red / Orange
//   // =========================================================================
//   static const Color primary = Color(0xFFFF3B30); // --primary
//   static const Color primaryHover = Color(0xFFD92B21); // --primary-hover
//   static const Color primaryContainer = Color(0xFFD92B21);
//   static const Color primaryLight = Color(0xFFD92B21);
//   static const Color primaryDark = Color(0xFFB41D16);
//   static const Color primaryGradientStart = primary;
//   static const Color primaryGradientEnd = primaryHover;

//   static const Color onPrimary = Color(0xFFFFFFFF); // white text on red
//   static const Color onPrimaryContainer = Color(0xFFFFFFFF);

//   static const Color secondary = Color(0xFFFF6B00); // --secondary
//   static const Color secondaryHover = Color(0xFFE65A00); // --secondary-hover
//   static const Color secondaryContainer = Color(0xFFE65A00);
//   static const Color secondaryLight = Color(0xFFE65A00);
//   static const Color secondaryDark = Color(0xFFB34A00);
//   static const Color onSecondary = Color(0xFFFFFFFF);
//   static const Color onSecondaryContainer = Color(0xFFFFFFFF);

//   static const Color tertiary = Color(0xFFFF6B00); // legacy — mirrors secondary
//   static const Color tertiaryLight = Color(0xFFE65A00);
//   static const Color tertiaryDark = Color(0xFFB34A00);
//   static const Color tertiaryContainer = Color(0xFFE65A00);
//   static const Color onTertiary = Color(0xFFFFFFFF);
//   static const Color onTertiaryContainer = Color(0xFFFFFFFF);

//   // Legacy "Neon Lime" family — now red/orange accent.
//   static const Color neonLime = primary;
//   static const Color neonLimeDim = primaryHover;
//   static const Color neonLimeBg = Color(0x1FFF3B30); // translucent primary
//   static const Color onNeonLime = Color(0xFFFFFFFF);

//   // =========================================================================
//   // Error / Danger — palette: --danger == --primary red
//   // =========================================================================
//   static const Color error = Color(0xFFFF3B30); // --danger
//   static const Color danger = error;
//   static const Color dangerContainer = Color(0x20FF3B30);
//   static const Color onError = Color(0xFFFFFFFF);
//   static const Color onErrorContainer = Color(0xFFFFFFFF);
//   static const Color errorContainer = dangerContainer;
//   static const Color errorLight = Color(0x40FF3B30);

//   // =========================================================================
//   // Surfaces — dark theme: --bg, --card, --border
//   // =========================================================================
//   static const Color background = Color(0xFF0F0F12); // --bg
//   static const Color onBackground = Color(0xFFFFFFFF);
//   static const Color surface = Color(0xFF1C1C22); // --card
//   static const Color onSurface = Color(0xFFFFFFFF);
//   static const Color surfaceDim = Color(0xFF16181D); // slightly darker than --card
//   static const Color surfaceBright = Color(0xFF26292F); // slightly lighter
//   static const Color surfaceHover = surfaceBright; // subtle row-hover tint
//   static const Color surfaceContainerLowest = surface;
//   static const Color surfaceContainerLow = surface;
//   static const Color surfaceContainer = surface;
//   static const Color surfaceContainerHigh = surfaceBright;
//   static const Color surfaceContainerHighest = surfaceBright;
//   static const Color surfaceVariant = surface;
//   static const Color surfaceTint = secondary;

//   // =========================================================================
//   // Outline / Border — --border
//   // =========================================================================
//   static const Color outline = Color(0xFF2A2A32); // --border
//   static const Color outlineVariant = Color(0xFF31343C);
//   static const Color strokeDefault = Color(0xFF2A2A32); // --border
//   static const Color strokeStrong = Color(0xFF31343C);
//   static const Color divider = strokeDefault;

//   // Shadow / overlay
//   static const Color shadow = Color(0x40000000);
//   static const Color scrim = Color(0x80000000);
//   static const Color shadowStrong = Color(0x60000000);
//   static const Color overlay = scrim;
//   static const Color overlayLight = Color(0x40000000);

//   // Inverse
//   static const Color inverseSurface = Color(0xFFFFFFFF);
//   static const Color inverseOnSurface = Color(0xFF121317);
//   static const Color inversePrimary = Color(0xFFFF6B00);

//   // =========================================================================
//   // Status — semantic: Active=success, Expiring=warning, Expired=danger, Frozen=info
//   // =========================================================================
//   static const Color statusActive = Color(0xFF22C55E); // --success
//   static const Color statusActiveBg = Color(0x1F22C55E);
//   static const Color statusActiveBorder = Color(0x4D22C55E);
//   static const Color onStatusActive = Color(0xFFFFFFFF); // white on green

//   static const Color statusExpiring = Color(0xFFFFC107); // --warning
//   static const Color statusExpiringBg = Color(0x1FFFC107);
//   static const Color statusExpiringBorder = Color(0x4DFFC107);
//   static const Color onStatusExpiring = Color(0xFF101518); // dark text on yellow

//   static const Color statusExpired = Color(0xFFFF3B30); // --danger
//   static const Color statusExpiredBg = Color(0x1FFF3B30);
//   static const Color statusExpiredBorder = Color(0x4DFF3B30);
//   static const Color onStatusExpired = Color(0xFFFFFFFF); // white on red

//   static const Color statusFrozen = Color(0xFF38BDF8); // --info
//   static const Color statusFrozenBg = Color(0x1F38BDF8);
//   static const Color statusFrozenBorder = Color(0x4D38BDF8);
//   static const Color onStatusFrozen = Color(0xFF0F1720); // dark text on light blue

//   // =========================================================================
//   // Semantic aliases (backward compat)
//   // =========================================================================
//   static const Color success = statusActive;
//   static const Color successContainer = statusActiveBg;
//   static const Color warning = statusExpiring;
//   static const Color warningContainer = statusExpiringBg;
//   static const Color canvas = background;
//   static const Color surfaceLevel1 = surface;
//   static const Color surfaceLevel2 = surfaceContainer;
//   static const Color backgroundSecondary = surfaceLevel1;
//   static const Color textOnPrimary = onPrimary;
//   static const Color textOnSecondary = onSecondary;
//   static const Color textOnSurface = onSurface;
//   static const Color textOnBackground = onBackground;

//   static const Color textPrimary = Color(0xFFFFFFFF); // --text
//   static const Color textSecondary = Color(0xFFA0A0AB); // --text-muted
//   static const Color textTertiary = Color(0xFF7A7A8C);
//   static const Color textOnSurfaceVariant = textSecondary;

//   // =========================================================================
//   // Gradients
//   // =========================================================================
//   static const LinearGradient primaryGradient = LinearGradient(
//     colors: [primary, primaryHover],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

//   static const LinearGradient surfaceGradient = LinearGradient(
//     colors: [surfaceContainer, surfaceLevel1],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

//   static const LinearGradient elevatedGradient = LinearGradient(
//     colors: [surfaceContainerHigh, surfaceContainer],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

//   static const LinearGradient backgroundGradient = LinearGradient(
//     colors: [background, surfaceDim, surfaceLevel1],
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,
//   );

//   static const LinearGradient cardGradient = LinearGradient(
//     colors: [surfaceLevel1, surfaceContainerLow],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );

//   // =========================================================================
//   // Glow effects
//   // =========================================================================
//   static const Color glowActive = Color(0x40FF3B30); // 25% primary red
//   static const Color glowCritical = Color(0x4DFF3B30); // 30% red
// }

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // =========================================================================
  // Brand — Crimson red + slate blue (navy / gray-blue / ice)
  // =========================================================================
  static const Color primary = Color(0xFFCF233B); // --primary
  static const Color primaryHover = Color(0xFFBB0428); // --primary-hover
  static const Color primaryContainer = Color(0xFFBB0428);
  static const Color primaryLight = Color(0xFFBB0428);
  static const Color primaryDark = Color(0xFF8F0320);
  static const Color primaryGradientStart = primary;
  static const Color primaryGradientEnd = primaryHover;

  static const Color onPrimary = Color(0xFFFFFFFF); // white text on red
  static const Color onPrimaryContainer = Color(0xFFFFFFFF);

  static const Color secondary = Color(0xFF9199AD); // --secondary
  static const Color secondaryHover = Color(0xFF7C859B); // --secondary-hover
  static const Color secondaryContainer = Color(0xFF7C859B);
  static const Color secondaryLight = Color(0xFF7C859B);
  static const Color secondaryDark = Color(0xFF5F6779);
  static const Color onSecondary = Color(0xFF1B1C2B);
  static const Color onSecondaryContainer = Color(0xFFEEF2F4);

  static const Color tertiary = Color(
    0xFF9199AD,
  ); // legacy — mirrors secondary (gray-blue)
  static const Color tertiaryLight = Color(0xFF7C859B);
  static const Color tertiaryDark = Color(0xFF5F6779);
  static const Color tertiaryContainer = Color(0xFF7C859B);
  static const Color onTertiary = Color(0xFF1B1C2B);
  static const Color onTertiaryContainer = Color(0xFFEEF2F4);

  // Legacy "Neon Lime" family — now the crimson accent.
  static const Color neonLime = primary;
  static const Color neonLimeDim = primaryHover;
  static const Color neonLimeBg = Color(0x1FCF233B); // translucent primary
  static const Color onNeonLime = Color(0xFFFFFFFF);

  // =========================================================================
  // Error / Danger — lighter crimson so it stays readable on navy
  // =========================================================================
  static const Color error = Color(0xFFF0475C); // --danger
  static const Color danger = error;
  static const Color dangerContainer = Color(0x20F0475C);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color onErrorContainer = Color(0xFFFFFFFF);
  static const Color errorContainer = dangerContainer;
  static const Color errorLight = Color(0x40F0475C);

  // =========================================================================
  // Surfaces — dark theme: --bg, --card, --border
  // =========================================================================
  static const Color background = Color(0xFF1B1C2B); // --bg
  static const Color onBackground = Color(0xFFEEF2F4);
  static const Color surface = Color(0xFF2C2D41); // --card
  static const Color onSurface = Color(0xFFEEF2F4);
  static const Color surfaceDim = Color(
    0xFF222335,
  ); // slightly darker than --card
  static const Color surfaceBright = Color(0xFF3A3C55); // slightly lighter
  static const Color surfaceHover = surfaceBright; // subtle row-hover tint
  static const Color surfaceContainerLowest = surface;
  static const Color surfaceContainerLow = surface;
  static const Color surfaceContainer = surface;
  static const Color surfaceContainerHigh = surfaceBright;
  static const Color surfaceContainerHighest = surfaceBright;
  static const Color surfaceVariant = surface;
  static const Color surfaceTint = secondary;

  // =========================================================================
  // Outline / Border — --border
  // =========================================================================
  static const Color outline = Color(0xFF3D3F58); // --border
  static const Color outlineVariant = Color(0xFF4F526C);
  static const Color strokeDefault = Color(0xFF3D3F58); // --border
  static const Color strokeStrong = Color(0xFF4F526C);
  static const Color divider = strokeDefault;

  // Shadow / overlay
  static const Color shadow = Color(0x40000000);
  static const Color scrim = Color(0x80000000);
  static const Color shadowStrong = Color(0x60000000);
  static const Color overlay = scrim;
  static const Color overlayLight = Color(0x40000000);

  // Inverse
  static const Color inverseSurface = Color(0xFFEEF2F4);
  static const Color inverseOnSurface = Color(0xFF1B1C2B);
  static const Color inversePrimary = Color(0xFFCF233B);

  // =========================================================================
  // Status — semantic: Active=success, Expiring=warning, Expired=danger, Frozen=info
  // =========================================================================
  static const Color statusActive = Color(0xFF22C55E); // --success
  static const Color statusActiveBg = Color(0x1F22C55E);
  static const Color statusActiveBorder = Color(0x4D22C55E);
  static const Color onStatusActive = Color(0xFFFFFFFF); // white on green

  static const Color statusExpiring = Color(0xFFFFC107); // --warning
  static const Color statusExpiringBg = Color(0x1FFFC107);
  static const Color statusExpiringBorder = Color(0x4DFFC107);
  static const Color onStatusExpiring = Color(
    0xFF101518,
  ); // dark text on yellow

  static const Color statusExpired = Color(0xFFF0475C); // --danger
  static const Color statusExpiredBg = Color(0x1FF0475C);
  static const Color statusExpiredBorder = Color(0x4DF0475C);
  static const Color onStatusExpired = Color(0xFFFFFFFF); // white on red

  static const Color statusFrozen = Color(0xFF38BDF8); // --info
  static const Color statusFrozenBg = Color(0x1F38BDF8);
  static const Color statusFrozenBorder = Color(0x4D38BDF8);
  static const Color onStatusFrozen = Color(
    0xFF0F1720,
  ); // dark text on light blue

  // =========================================================================
  // Semantic aliases (backward compat)
  // =========================================================================
  static const Color success = statusActive;
  static const Color successContainer = statusActiveBg;
  static const Color warning = statusExpiring;
  static const Color warningContainer = statusExpiringBg;
  static const Color canvas = background;
  static const Color surfaceLevel1 = surface;
  static const Color surfaceLevel2 = surfaceContainer;
  static const Color backgroundSecondary = surfaceLevel1;
  static const Color textOnPrimary = onPrimary;
  static const Color textOnSecondary = onSecondary;
  static const Color textOnSurface = onSurface;
  static const Color textOnBackground = onBackground;

  static const Color textPrimary = Color(0xFFEEF2F4); // --text
  static const Color textSecondary = Color(0xFF9199AD); // --text-muted
  static const Color textTertiary = Color(0xFF7A8399);
  static const Color textOnSurfaceVariant = textSecondary;

  // =========================================================================
  // Gradients
  // =========================================================================
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryHover],
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
  // Glow effects
  // =========================================================================
  static const Color glowActive = Color(0x40CF233B); // 25% primary crimson
  static const Color glowCritical = Color(0x4DF0475C); // 30% danger red
}
