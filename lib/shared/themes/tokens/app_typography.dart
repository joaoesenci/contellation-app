import 'package:constellation_app/shared/themes/tokens/app_colors.dart';
import 'package:flutter/material.dart';

final class AppTypography {
  const AppTypography._();

  static const Color color = AppColors.onPrimaryColor;

  static const appTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.normal,
      height: 64 / 57,
      letterSpacing: -0.25,
      color: color,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.normal,
      height: 52 / 45,
      letterSpacing: 0,
      color: color,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.normal,
      height: 44 / 36,
      letterSpacing: 0,
      color: color,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.normal,
      height: 40 / 32,
      letterSpacing: 0,
      color: color,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.normal,
      height: 36 / 28,
      letterSpacing: 0,
      color: color,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.normal,
      height: 32 / 24,
      letterSpacing: 0,
      color: color,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.normal,
      height: 28 / 22,
      letterSpacing: 0,
      color: color,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 24 / 16,
      letterSpacing: 0.15,
      color: color,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: color,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      height: 24 / 16,
      letterSpacing: 0.5,
      color: color,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      height: 20 / 14,
      letterSpacing: 0.25,
      color: color,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: color,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: color,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 16 / 12,
      letterSpacing: 0.5,
      color: color,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      height: 16 / 11,
      letterSpacing: 0.5,
      color: color,
    ),
  );
}
