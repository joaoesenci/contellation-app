import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

final class AppTheme {
  const AppTheme._();

  static ThemeData get defaultTheme => ThemeData(
    //------------------------------------------------------------
    // ⚙️ GENERAL CONFIG
    //------------------------------------------------------------
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: AppColors.appColorScheme,
    textTheme: AppTypography.appTextTheme,
    fontFamily: AppStrings.interFont,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.tertiaryColor,
      selectionColor: Color(0x6A383A59),
      selectionHandleColor: AppColors.tertiaryColor,
    ),

    //------------------------------------------------------------
    // ⬜ SURFACES
    //------------------------------------------------------------
    cardTheme: const CardThemeData(
      color: AppColors.secundaryColor,
      margin: AppInsets.allNone,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.allSmall),
      elevation: 2.0,
    ),

    //------------------------------------------------------------
    // ⏯️ BUTTONS
    //------------------------------------------------------------
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.secundaryColor,
      foregroundColor: AppColors.onSecundaryColor,
      enableFeedback: true,
    ),

    checkboxTheme: const CheckboxThemeData(
      checkColor: WidgetStatePropertyAll(AppColors.onTertiaryColor),
      fillColor: WidgetStatePropertyAll(AppColors.tertiaryColor),
    ),

    dropdownMenuTheme: const DropdownMenuThemeData(),

    //------------------------------------------------------------
    // ➖ SEPARATORS
    //------------------------------------------------------------
    dividerTheme: const DividerThemeData(
      color: AppColors.outlineColor,
      radius: AppBorderRadius.allCircular,
      thickness: 0.5,
      space: 0.5,
    ),

    //------------------------------------------------------------
    // ↕️ SCROLLS
    //------------------------------------------------------------
    scrollbarTheme: const ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(AppColors.outlineColor),
      thickness: WidgetStatePropertyAll(1),
      crossAxisMargin: -12,
      radius: Radius.circular(AppSizes.extraLarge),
    ),
  );
}
