import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static const color = Color(0x1A000000);

  static List<BoxShadow> get sm => [
        BoxShadow(
          color: color,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get md => [
        BoxShadow(
          color: color,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get lg => [
        BoxShadow(
          color: color,
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get xl => [
        BoxShadow(
          color: color,
          blurRadius: 24,
          offset: const Offset(0, 12),
        ),
      ];

  static List<BoxShadow> get glass => [
        BoxShadow(
          color: color,
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];
}
