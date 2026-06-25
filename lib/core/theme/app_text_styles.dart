import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const _lightText = AppColors.textMainLight;
  static const _darkText = AppColors.textMainDark;

  static TextStyle displayLarge(ColorScheme colorScheme) => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: colorScheme.brightness == Brightness.dark
            ? _darkText
            : _lightText,
      );

  static TextStyle displayMedium(ColorScheme colorScheme) => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: colorScheme.brightness == Brightness.dark
            ? _darkText
            : _lightText,
      );

  static TextStyle headlineLarge(ColorScheme colorScheme) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: colorScheme.brightness == Brightness.dark
            ? _darkText
            : _lightText,
      );

  static TextStyle headlineMedium(ColorScheme colorScheme) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colorScheme.brightness == Brightness.dark
            ? _darkText
            : _lightText,
      );

  static TextStyle titleLarge(ColorScheme colorScheme) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: colorScheme.brightness == Brightness.dark
            ? _darkText
            : _lightText,
      );

  static TextStyle titleMedium(ColorScheme colorScheme) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colorScheme.brightness == Brightness.dark
            ? _darkText
            : _lightText,
      );

  static TextStyle bodyLarge(ColorScheme colorScheme) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: colorScheme.brightness == Brightness.dark
            ? _darkText
            : _lightText,
      );

  static TextStyle bodyMedium(ColorScheme colorScheme) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: colorScheme.brightness == Brightness.dark
            ? _darkText
            : _lightText,
      );

  static TextStyle bodySmall(ColorScheme colorScheme) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: colorScheme.brightness == Brightness.dark
            ? AppColors.textSecondaryDark
            : AppColors.textSecondaryLight,
      );

  static TextStyle labelLarge(ColorScheme colorScheme) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: colorScheme.brightness == Brightness.dark
            ? _darkText
            : _lightText,
      );
}
