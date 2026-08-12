import 'package:collection/collection.dart';
import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/edit_note_page/select_constellation_dialog/select_constellation_dialog.dart';
import 'package:constellation_app/shared/constants/app_icons.dart';
import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:constellation_app/shared/widgets/app_iconed_text.dart';
import 'package:flutter/material.dart';

class SetConstellationButton extends StatelessWidget {
  final String? selectedConstellationId;
  final List<ConstellationEntity> constellations;
  final ValueChanged<String> onSelectConstellation;

  const SetConstellationButton({
    super.key,
    required this.selectedConstellationId,
    required this.constellations,
    required this.onSelectConstellation,
  });

  void _showSelectConstellationDialog(BuildContext context) {
    SelectConstellationDialog.show(
      context: context,
      selectedConstellationId: selectedConstellationId,
      constellations: constellations,
      onSelectConstellation: onSelectConstellation,
    );
  }

  @override
  Widget build(BuildContext context) {
    final onSecundaryColor = context.colors.onSecondary;
    final bodyMediumText = context.texts.bodyMedium!;

    final constellation = constellations.firstWhereOrNull(
      (i) => i.id == selectedConstellationId,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showSelectConstellationDialog(context),
        borderRadius: AppBorderRadius.allLarge,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.large,
            vertical: AppSizes.medium,
          ),
          decoration: BoxDecoration(
            borderRadius: AppBorderRadius.allLarge,
            border: Border.all(
              color: context.colors.outline,
              width: AppWidgetsSizes.borderWidth,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectedConstellationId == null
                  ? Text(
                      AppStrings.setConstellation,
                      style: bodyMediumText.copyWith(color: onSecundaryColor),
                    )
                  : AppIconedText(
                      icon: Icon(
                        constellation?.icon,
                        color: onSecundaryColor,
                        size: AppIconSizes.small,
                      ),
                      text: constellation?.name ?? '',
                      textStyle: bodyMediumText.copyWith(
                        color: onSecundaryColor,
                      ),
                    ),
              Icon(
                AppIcons.caretDown,
                color: onSecundaryColor,
                size: AppIconSizes.small,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
