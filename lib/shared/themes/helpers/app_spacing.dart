import 'package:constellation_app/shared/themes/tokens/app_sizes.dart';
import 'package:flutter/material.dart';

final class AppSpacing {
  const AppSpacing._();

  // ---------- ↔️ HORIZONTAL ----------
  static const hExtraSmall = SizedBox(width: AppSizes.extraSmall);
  static const hSmall = SizedBox(width: AppSizes.small);
  static const hMedium = SizedBox(width: AppSizes.medium);
  static const hLarge = SizedBox(width: AppSizes.large);
  static const hExtraLarge = SizedBox(width: AppSizes.extraLarge);
  static const hHuge = SizedBox(width: AppSizes.huge);

  // ---------- ↕️ VERTICAL ----------
  static const vExtraSmall = SizedBox(height: AppSizes.extraSmall);
  static const vSmall = SizedBox(height: AppSizes.small);
  static const vMedium = SizedBox(height: AppSizes.medium);
  static const vLarge = SizedBox(height: AppSizes.large);
  static const vExtraLarge = SizedBox(height: AppSizes.extraLarge);
  static const vHuge = SizedBox(height: AppSizes.huge);
}
