import 'package:flutter/material.dart';

extension AppThemeExtension on BuildContext {
  // ---------- 🎨 THEME EXTENSION ----------
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => theme.colorScheme;
  TextTheme get texts => theme.textTheme;

  // ---------- 📐 SCREEN SIZES ----------
  Size get sizeOf => MediaQuery.sizeOf(this);
  double get screenHeight => sizeOf.height;
  double get screenWidth => sizeOf.width;

  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  // ---------- 🔭 FOCUS NODE  ----------
  FocusScopeNode get _focusScope => FocusScope.of(this);
  VoidCallback get nextFocus => _focusScope.nextFocus;
  VoidCallback get unFocus => _focusScope.unfocus;
}
