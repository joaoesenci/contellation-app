import 'package:constellation_app/shared/constants/app_icons.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:constellation_app/shared/widgets/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HeaderActions extends StatelessWidget {
  final bool isListMode;
  final bool isSearching;
  final bool isDeleting;
  final bool isEmptyNotes;
  final VoidCallback onTapSearchButton;
  final VoidCallback onTapToggleButton;
  final VoidCallback onTapClearButton;
  final VoidCallback onTapDeleteButton;

  const HeaderActions({
    super.key,
    required this.onTapSearchButton,
    required this.onTapToggleButton,
    required this.onTapClearButton,
    required this.onTapDeleteButton,
    required this.isListMode,
    required this.isSearching,
    required this.isDeleting,
    required this.isEmptyNotes,
  });

  void _onTapToggleButton() async {
    await HapticFeedback.lightImpact();
    onTapToggleButton();
  }

  @override
  Widget build(BuildContext context) {
    final onSecundaryColor = context.colors.onSecondary;

    return Row(
      children: [
        isDeleting
            ? AppIconButton(
                onTap: onTapDeleteButton,
                icon: Icon(
                  AppIcons.trash,
                  size: AppIconSizes.medium,
                  color: context.colors.error,
                ),
              )
            : isEmptyNotes
            ? const SizedBox.shrink()
            : AppIconButton(
                onTap: _onTapToggleButton,
                icon: Icon(
                  isListMode ? AppIcons.sparkle : AppIcons.list,
                  size: AppIconSizes.medium,
                  color: onSecundaryColor,
                ),
              ),
        AppSpacing.hExtraSmall,
        AppIconButton(
          onTap: isSearching ? onTapClearButton : onTapSearchButton,
          icon: Icon(
            isSearching ? AppIcons.x : AppIcons.magnifyingGlass,
            size: AppIconSizes.medium,
            color: onSecundaryColor,
          ),
        ),
      ],
    );
  }
}
