import 'package:constellation_app/shared/themes/tokens/app_sizes.dart';
import 'package:flutter/material.dart';

final class AppBorderRadius {
  const AppBorderRadius._();

  // ---------- ↔️↕️ ALL RADII ----------
  static const allCircular = BorderRadius.all(Radius.circular(999.0));
  static const allSmall = BorderRadius.all(Radius.circular(AppSizes.small));
  static const allMedium = BorderRadius.all(Radius.circular(AppSizes.medium));
  static const allLarge = BorderRadius.all(Radius.circular(AppSizes.large));
  static const allExtraLarge = BorderRadius.all(
    Radius.circular(AppSizes.extraLarge),
  );
  static const allHuge = BorderRadius.all(Radius.circular(AppSizes.huge));

  // ---------- ⬆️ TOP RADII ----------
  static const topSmall = BorderRadius.vertical(
    top: Radius.circular(AppSizes.small),
  );
  static const topMedium = BorderRadius.vertical(
    top: Radius.circular(AppSizes.medium),
  );
  static const topLarge = BorderRadius.vertical(
    top: Radius.circular(AppSizes.large),
  );
  static const topExtraLarge = BorderRadius.vertical(
    top: Radius.circular(AppSizes.extraLarge),
  );
  static const topHuge = BorderRadius.vertical(
    top: Radius.circular(AppSizes.huge),
  );

  // ---------- ⬇️ BOT RADII ----------
  static const bottomSmall = BorderRadius.vertical(
    bottom: Radius.circular(AppSizes.small),
  );
  static const bottomMedium = BorderRadius.vertical(
    bottom: Radius.circular(AppSizes.medium),
  );
  static const bottomLarge = BorderRadius.vertical(
    bottom: Radius.circular(AppSizes.large),
  );
  static const bottomExtraLarge = BorderRadius.vertical(
    bottom: Radius.circular(AppSizes.extraLarge),
  );
  static const bottomHuge = BorderRadius.vertical(
    bottom: Radius.circular(AppSizes.huge),
  );
}
