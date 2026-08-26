import 'package:flutter/material.dart';

/// Breakpoints and helpers for adapting layouts across phone,
/// tablet, and web/desktop widths. Kept intentionally simple —
/// no external responsive package needed.
class ResponsiveUtils {
  ResponsiveUtils._();

  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1000;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= tabletBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= desktopBreakpoint;

  /// Max content width so text/cards don't stretch uncomfortably wide
  /// on tablets or web. Phones get full width.
  static double maxContentWidth(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= desktopBreakpoint) return 720;
    if (width >= tabletBreakpoint) return 600;
    return width;
  }

  /// Number of grid columns for card lists (places/food), based on width.
  static int gridColumns(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= desktopBreakpoint) return 3;
    if (width >= tabletBreakpoint) return 2;
    return 1;
  }
}