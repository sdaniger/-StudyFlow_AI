import 'package:flutter/material.dart';
import 'responsive_breakpoints.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        if (ResponsiveBreakpoints.isMobile(width)) {
          return mobile;
        }
        if (ResponsiveBreakpoints.isTablet(width)) {
          return tablet ?? desktop;
        }
        return desktop;
      },
    );
  }
}
