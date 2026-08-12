import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class AppIconedText extends StatelessWidget {
  final Widget icon;
  final String text;
  final TextStyle textStyle;
  final SizedBox spacing;

  const AppIconedText({
    super.key,
    required this.icon,
    required this.text,
    required this.textStyle,
    this.spacing = AppSpacing.hSmall,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon,
        spacing,
        Text(text, style: textStyle),
      ],
    );
  }
}
