import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:constellation_app/shared/themes/tokens/app_widgets_sizes.dart';
import 'package:flutter/material.dart';

class TitleTextfield extends StatelessWidget {
  final TextEditingController controller;

  const TitleTextfield({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final titleLargeText = context.texts.titleLarge;
    final onSecundaryColor = context.colors.onSecondary;
    final tertiaryColor = context.colors.tertiary;

    return TextField(
      controller: controller,
      maxLines: null,
      maxLength: 100,
      keyboardType: TextInputType.text,
      keyboardAppearance: Brightness.dark,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.sentences,
      cursorColor: tertiaryColor,
      cursorWidth: AppWidgetsSizes.textCursorWidth,
      cursorRadius: const Radius.circular(2),
      decoration: InputDecoration(
        border: InputBorder.none,
        counterText: '',
        hintText: 'Title',
        hintStyle: titleLargeText!.copyWith(
          color: onSecundaryColor.withAlpha(180),
          fontFamily: AppStrings.nunitoFont,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w300,
        ),
      ),
      style: titleLargeText.copyWith(
        color: tertiaryColor,
        fontFamily: AppStrings.nunitoFont,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
