import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class ConstellatiosFilterItem extends StatelessWidget {
  final ConstellationEntity constellation;
  final bool isSelected;
  final VoidCallback onTap;

  const ConstellatiosFilterItem({
    super.key,
    required this.constellation,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tertiaryColor = context.colors.tertiary;
    final onSecundaryColor = context.colors.onSecondary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        enableFeedback: true,
        borderRadius: AppBorderRadius.allMedium,
        child: Container(
          width: 140,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: AppBorderRadius.allMedium,
            border: Border.all(
              color: isSelected ? tertiaryColor : context.colors.outline,
              width: AppWidgetsSizes.borderWidth,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  constellation.icon,
                  size: AppIconSizes.medium,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? tertiaryColor : onSecundaryColor,
                ),
                AppSpacing.vSmall,
                Text(
                  constellation.name,
                  style: context.texts.bodySmall!.copyWith(
                    color: isSelected ? tertiaryColor : onSecundaryColor,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
