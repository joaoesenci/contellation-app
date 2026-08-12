import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class BodyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintTextPrompt;

  const BodyTextfield({
    super.key,
    required this.controller,
    required this.hintTextPrompt,
  });

  @override
  Widget build(BuildContext context) {
    final bodyLargeText = context.texts.bodyLarge;
    final onSecundaryColor = context.colors.onSecondary;

    return TextField(
      controller: controller,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      keyboardAppearance: Brightness.dark,
      textInputAction: TextInputAction.newline,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: context.colors.tertiary,
      cursorWidth: AppWidgetsSizes.textCursorWidth,
      cursorRadius: const Radius.circular(2),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintTextPrompt,
        hintStyle: bodyLargeText!.copyWith(
          color: onSecundaryColor.withAlpha(180),
          fontFamily: AppStrings.nunitoFont,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w300,
        ),
      ),
      style: bodyLargeText.copyWith(
        color: onSecundaryColor,
        fontFamily: AppStrings.nunitoFont,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
