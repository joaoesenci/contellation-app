import 'package:constellation_app/shared/constants/app_icons.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class ToggleViewButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isExpanded;

  const ToggleViewButton({
    super.key,
    required this.onTap,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorderRadius.allSmall,
        enableFeedback: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 80,
            vertical: AppSizes.small,
          ),
          child: Icon(
            isExpanded ? AppIcons.caretDoubleUp : AppIcons.caretDoubleDown,
            size: AppIconSizes.small,
            color: context.colors.onSecondary,
          ),
        ),
      ),
    );
  }
}
