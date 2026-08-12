import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class SaveNoteTextButton extends StatelessWidget {
  final VoidCallback onTap;

  const SaveNoteTextButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorderRadius.allCircular,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.large,
            vertical: AppSizes.medium,
          ),
          child: Text(
            AppStrings.saveNote,
            style: context.texts.bodyMedium!.copyWith(
              color: context.colors.tertiary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
