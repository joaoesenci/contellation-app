import 'package:constellation_app/shared/themes/helpers/app_insets.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final Icon icon;
  final EdgeInsetsGeometry? padding;

  const AppIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        enableFeedback: true,
        child: Padding(padding: AppInsets.allSmall, child: icon),
      ),
    );
  }
}
