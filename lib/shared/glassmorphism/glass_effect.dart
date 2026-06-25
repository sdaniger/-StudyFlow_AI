import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_shadows.dart';

class GlassEffect {
  GlassEffect._();

  static BoxDecoration decoration({
    required BuildContext context,
    double blur = 20,
    double opacity = 0.15,
    double borderRadius = AppRadius.lg,
    Color? borderColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.glassDark : AppColors.glassLight;

    return BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ??
            (isDark ? AppColors.glassBorderDark : AppColors.glassBorderLight),
        width: 0.5,
      ),
      boxShadow: AppShadows.glass,
    );
  }
}
