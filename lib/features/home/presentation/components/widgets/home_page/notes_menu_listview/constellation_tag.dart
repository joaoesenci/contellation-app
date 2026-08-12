import 'package:constellation_app/shared/constants/app_icons.dart';
import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class ConstellationTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const ConstellationTag({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final onSecundaryColor = context.colors.onSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppSizes.extraSmall,
        horizontal: AppSizes.medium,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colors.outline.withAlpha(120),
          width: 1,
        ),
        borderRadius: AppBorderRadius.allSmall,
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withAlpha(180),
            blurStyle: BlurStyle.outer,
            blurRadius: 1,
            offset: Offset(-1, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: icon == AppIcons.starFour ? 14.0 : AppIconSizes.small,
            color: onSecundaryColor,
          ),
          AppSpacing.hSmall,
          Text(
            text,
            style: context.texts.labelSmall!.copyWith(
              color: onSecundaryColor,
              fontFamily: AppStrings.nunitoFont,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
