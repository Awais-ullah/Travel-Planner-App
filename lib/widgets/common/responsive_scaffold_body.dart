import 'package:flutter/material.dart';
import '../../theme/responsive_utils.dart';

/// Wraps screen content in a horizontally-centered, width-capped
/// container. On phones this is a no-op (full width); on tablet/web
/// it keeps content readable instead of stretching edge to edge.
class ResponsiveScaffoldBody extends StatelessWidget {
  const ResponsiveScaffoldBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final maxWidth = ResponsiveUtils.maxContentWidth(context);

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}