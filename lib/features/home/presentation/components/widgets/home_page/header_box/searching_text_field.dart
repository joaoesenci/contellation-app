import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class SearchingTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;

  const SearchingTextField({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final onSecundaryColor = context.colors.onSecondary;
    final bodyMediumText = context.texts.bodyMedium;

    return Expanded(
      child: Padding(
        padding: const EdgeInsetsGeometry.only(
          top: AppSizes.extraSmall,
          left: AppSizes.small,
          right: AppSizes.small,
        ),
        child: Container(
          padding: AppInsets.hMedium,
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colors.outline,
              width: AppWidgetsSizes.borderWidth,
            ),
            borderRadius: AppBorderRadius.allMedium,
          ),
          child: TextField(
            controller: controller,
            autofocus: true,
            onChanged: onSearch,
            cursorColor: context.colors.tertiary,
            cursorWidth: AppWidgetsSizes.textCursorWidth,
            cursorRadius: const Radius.circular(2),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: AppStrings.searchStar,
              hintStyle: bodyMediumText!.copyWith(
                color: onSecundaryColor.withAlpha(180),
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w300,
              ),
            ),
            style: bodyMediumText.copyWith(color: onSecundaryColor),
          ),
        ),
      ),
    );
  }
}
