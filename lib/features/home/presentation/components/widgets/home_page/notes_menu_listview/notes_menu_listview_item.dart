import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/notes_menu_listview/constellation_tag.dart';
import 'package:constellation_app/shared/constants/app_icons.dart';
import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:constellation_app/shared/utils/date_formatter.dart';
import 'package:constellation_app/shared/widgets/app_custom_text.dart';
import 'package:flutter/material.dart';

class NotesMenuListviewItem extends StatelessWidget {
  final NoteEntity note;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const NotesMenuListviewItem({
    super.key,
    required this.note,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  });

  IconData _setTagIcon(String? constellationId) {
    switch (constellationId) {
      case AppStrings.driftingThoughtsId:
        return AppIcons.meteor;
      case AppStrings.quietMomentsId:
        return AppIcons.moonStars;
      case AppStrings.tomorrowsOrbitId:
        return AppIcons.saturn;
      case AppStrings.deepFocusId:
        return AppIcons.rocket;
      default:
        return AppIcons.starFour;
    }
  }

  String _setTagString(String? constellationId) {
    switch (constellationId) {
      case AppStrings.driftingThoughtsId:
        return AppStrings.driftingThoughtsName;
      case AppStrings.quietMomentsId:
        return AppStrings.quietMomentsName;
      case AppStrings.tomorrowsOrbitId:
        return AppStrings.tomorrowsOrbitName;
      case AppStrings.deepFocusId:
        return AppStrings.deepFocusOrbitName;
      default:
        return AppStrings.loneStarName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final secundaryColor = context.colors.secondary;
    final onSecundaryColor = context.colors.onSecondary;
    final tertiaryColor = context.colors.tertiary;
    final outlineColor = context.colors.outline;
    final tagIcon = _setTagIcon(note.constellationId);
    final tagText = _setTagString(note.constellationId);
    final noteText = note.text.isEmpty ? AppStrings.withoutBodyNote : note.text;

    return Material(
      color: isSelected ? secundaryColor.withAlpha(100) : secundaryColor,
      borderRadius: AppBorderRadius.allMedium,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: AppBorderRadius.allMedium,
        child: Container(
          padding: AppInsets.allLarge,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: isSelected ? outlineColor.withAlpha(60) : outlineColor,
              width: 1,
            ),
            borderRadius: AppBorderRadius.allMedium,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isSelected) ...[
                Icon(
                  AppIcons.checkSquare,
                  size: AppIconSizes.large,
                  color: tertiaryColor,
                ),
                AppSpacing.hLarge,
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppEllipsisText(
                      text: note.title,
                      boxWidth: isSelected ? 205 : 250,
                      style: context.texts.bodyLarge!.copyWith(
                        color: tertiaryColor,
                        fontFamily: AppStrings.nunitoFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSpacing.vExtraSmall,
                    AppEllipsisText(
                      text: noteText,
                      boxWidth: isSelected ? 205 : 250,
                      style: context.texts.bodySmall!.copyWith(
                        color: onSecundaryColor,
                        fontFamily: AppStrings.nunitoFont,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    AppSpacing.vLarge,
                    ConstellationTag(icon: tagIcon, text: tagText),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsGeometry.only(
                  top: AppSizes.extraSmall,
                ),
                child: Text(
                  DateFormatter.format(note.date),
                  style: context.texts.labelSmall!.copyWith(
                    color: onSecundaryColor,
                    fontFamily: AppStrings.interFont,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
