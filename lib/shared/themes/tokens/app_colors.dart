import 'package:flutter/material.dart';

final class AppColors {
  const AppColors._();

  static const Color primaryColor = Color(0xFF0B0F19);
  static const Color onPrimaryColor = Color(0xFFD8E0ED);
  static const Color secundaryColor = Color(0xFF1F203B);
  static const Color onSecundaryColor = Color(0xFFD0D2E8);
  static const Color tertiaryColor = Color(0xFFFFE89E);
  static const Color onTertiaryColor = Color(0xFF3A2D00);
  static const Color errorColor = Color(0xFFD46F7A);
  static const Color onErrorColor = Color(0xFF421A20);
  static const Color surfaceColor = Color(0xFF121626);
  static const Color onSurfaceColor = Color(0xFFE2E8F0);
  static const Color outlineColor = Color(0xFF383A59);
  static const Color shadowColor = Color(0xFF000000);

  static final appColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    secondary: secundaryColor,
    onSecondary: onSecundaryColor,
    tertiary: tertiaryColor,
    onTertiary: onTertiaryColor,
    error: errorColor,
    onError: onErrorColor,
    surface: surfaceColor,
    onSurface: onSurfaceColor,
    outline: outlineColor,
    shadow: shadowColor,
  );
}
