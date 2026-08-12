import 'package:constellation_app/shared/constants/app_icons.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:constellation_app/shared/widgets/app_icon_button.dart';
import 'package:flutter/cupertino.dart';

class SelectedNotesCounter extends StatelessWidget {
  final int notesLenght;
  final VoidCallback onTapIcon;

  const SelectedNotesCounter({
    super.key,
    required this.notesLenght,
    required this.onTapIcon,
  });

  @override
  Widget build(BuildContext context) {
    final onSecundaryColor = context.colors.onSecondary;
    final text = notesLenght == 1
        ? '1 note selected'
        : '$notesLenght notes selected';

    return Row(
      children: [
        AppIconButton(
          onTap: onTapIcon,
          icon: Icon(
            AppIcons.arrowLeft,
            size: AppIconSizes.medium,
            color: onSecundaryColor,
          ),
        ),
        AppSpacing.hExtraSmall,
        Text(
          text,
          style: context.texts.titleLarge!.copyWith(
            color: onSecundaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
