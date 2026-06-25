import 'package:flutter/material.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../glassmorphism/glass_effect.dart';

class GlassContainer extends StatelessWidget {
  final Widget? child;
  final double borderRadius;
  final double blur;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final Color? borderColor;

  const GlassContainer({
    super.key,
    this.child,
    this.borderRadius = AppRadius.lg,
    this.blur = 20,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.margin,
    this.width,
    this.height,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: GlassEffect.decoration(
        context: context,
        blur: blur,
        borderRadius: borderRadius,
        borderColor: borderColor,
      ),
      child: child,
    );
  }
}
