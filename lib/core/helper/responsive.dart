import 'package:flutter/material.dart';

enum ScreenType { mobile, tablet, desktop }

class Responsive {
  Responsive._();

  static const double mobileMax = 600;
  static const double tabletMax = 1024;

  static ScreenType typeOfWidth(double w) {
    if (w < mobileMax) return ScreenType.mobile;
    if (w < tabletMax) return ScreenType.tablet;
    return ScreenType.desktop;
  }

  static ScreenType typeOf(BuildContext context) =>
      typeOfWidth(MediaQuery.sizeOf(context).width);

  static bool isMobile(BuildContext c) => typeOf(c) == ScreenType.mobile;
  static bool isTablet(BuildContext c) => typeOf(c) == ScreenType.tablet;
  static bool isDesktop(BuildContext c) => typeOf(c) == ScreenType.desktop;

  static T value<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    switch (typeOf(context)) {
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.mobile:
        return mobile;
    }
  }

  static double scaleForWidth(double w) {
    switch (typeOfWidth(w)) {
      case ScreenType.mobile:
        return (w / 390).clamp(0.9, 1.0).toDouble();
      case ScreenType.tablet:
        return (w / 768).clamp(0.95, 1.1).toDouble();
      case ScreenType.desktop:
        return (w / 1280).clamp(0.9, 1.2).toDouble();
    }
  }

  static double scale(BuildContext context) =>
      scaleForWidth(MediaQuery.sizeOf(context).width);

  /// حجم مقاس: Responsive.size(context, 16)
  static double size(BuildContext context, double v) => v * scale(context);
}

extension ResponsiveContext on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  double get scale => Responsive.scale(this);

  /// responsive size: context.rs(16)
  double rs(double v) => v * scale;
}

extension ScaledTextStyle on TextStyle {
  TextStyle scaled(BuildContext context) =>
      copyWith(fontSize: (fontSize ?? 14) * Responsive.scale(context));
}
