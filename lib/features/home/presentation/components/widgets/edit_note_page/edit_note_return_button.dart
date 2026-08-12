import 'package:constellation_app/shared/constants/app_icons.dart';
import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class EditNoteReturnButton extends StatelessWidget {
  final VoidCallback onTap;

  const EditNoteReturnButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final onPrimaryColor = context.colors.onPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorderRadius.allCircular,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.small,
            vertical: AppSizes.extraSmall,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                AppIcons.arrowLeft,
                size: AppIconSizes.small,
                color: onPrimaryColor,
              ),
              AppSpacing.hSmall,
              Text(
                AppStrings.returnText,
                style: context.texts.bodyLarge!.copyWith(
                  fontFamily: AppStrings.nunitoFont,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
