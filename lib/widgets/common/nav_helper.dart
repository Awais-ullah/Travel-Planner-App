import 'package:flutter/material.dart';

/// Small navigation helper to keep pop/push logic consistent and
/// out of individual screens. Since Home is always the base route
/// (Splash uses pushReplacement so it's removed from the stack),
/// popping until the first route always lands back on Home.
class NavHelper {
  NavHelper._();

  /// Clears the navigation stack back to the Home Screen —
  /// used by "Plan a new trip" / "Plan Another Trip" actions so users
  /// don't have to tap back through Result and Details manually.
  static void backToHome(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}