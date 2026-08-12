import 'package:constellation_app/shared/constants/app_icons.dart';
import 'package:constellation_app/shared/themes/tokens/app_icon_sizes.dart';
import 'package:flutter/material.dart';

class AddNoteFloatingButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddNoteFloatingButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      child: Icon(AppIcons.add, size: AppIconSizes.medium),
    );
  }
}
