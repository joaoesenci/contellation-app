import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:constellation_app/shared/widgets/app_iconed_text.dart';
import 'package:flutter/material.dart';

class SelectConstellationDialogOption extends StatelessWidget {
  final ConstellationEntity constellation;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectConstellationDialogOption({
    super.key,
    required this.constellation,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final onPrimaryColor = context.colors.onPrimary;
    final tertiaryColor = context.colors.tertiary;

    final titleColor = isSelected ? tertiaryColor : onPrimaryColor;

    return Container(
      color: isSelected ? context.colors.primary : null,
      child: SimpleDialogOption(
        onPressed: onTap,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.extraLarge,
          vertical: AppSizes.large,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppIconedText(
              icon: Icon(
                constellation.icon,
                color: titleColor,
                size: AppIconSizes.medium,
              ),
              text: constellation.name,
              textStyle: context.texts.bodyLarge!.copyWith(
                color: titleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            AppSpacing.vMedium,
            Text(
              constellation.description,
              style: context.texts.bodySmall!.copyWith(color: onPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
