import 'package:constellation_app/shared/themes/tokens/app_sizes.dart';
import 'package:flutter/widgets.dart';

final class AppInsets {
  const AppInsets._();

  // ---------- ↔️↕️ ALL ----------
  static const allNone = EdgeInsets.all(AppSizes.none);
  static const allExtraSmall = EdgeInsets.all(AppSizes.extraSmall);
  static const allSmall = EdgeInsets.all(AppSizes.small);
  static const allMedium = EdgeInsets.all(AppSizes.medium);
  static const allLarge = EdgeInsets.all(AppSizes.large);
  static const allExtraLarge = EdgeInsets.all(AppSizes.extraLarge);

  // ---------- ↔️ HORIZONTAL ----------
  static const hExtraSmall = EdgeInsets.symmetric(horizontal: AppSizes.extraSmall);
  static const hSmall = EdgeInsets.symmetric(horizontal: AppSizes.small);
  static const hMedium = EdgeInsets.symmetric(horizontal: AppSizes.medium);
  static const hLarge = EdgeInsets.symmetric(horizontal: AppSizes.large);
  static const hExtraLarge = EdgeInsets.symmetric(horizontal: AppSizes.extraLarge);

  // ---------- ↕️ VERTICAL ----------
  static const vExtraSmall = EdgeInsets.symmetric(vertical: AppSizes.extraSmall);
  static const vSmall = EdgeInsets.symmetric(vertical: AppSizes.small);
  static const vMedium = EdgeInsets.symmetric(vertical: AppSizes.medium);
  static const vLarge = EdgeInsets.symmetric(vertical: AppSizes.large);
  static const vExtraLarge = EdgeInsets.symmetric(vertical: AppSizes.extraLarge,);
}
