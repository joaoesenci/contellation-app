import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/edit_note_page/edit_note_text_area/body_textfield.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/edit_note_page/edit_note_text_area/save_note_text_button.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/edit_note_page/edit_note_text_area/set_constellation_button.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/edit_note_page/edit_note_text_area/title_textfield.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';

class EditNoteTextArea extends StatelessWidget {
  final TextEditingController titleTextController;
  final TextEditingController bodyTextController;
  final ScrollController textScrollController;
  final String hintTextPrompt;
  final List<ConstellationEntity> constellations;
  final String? selectedConstellationId;
  final VoidCallback onTapSaveButton;
  final ValueChanged<String> onSelectConstellation;

  const EditNoteTextArea({
    super.key,
    required this.titleTextController,
    required this.bodyTextController,
    required this.textScrollController,
    required this.hintTextPrompt,
    required this.constellations,
    required this.selectedConstellationId,
    required this.onTapSaveButton,
    required this.onSelectConstellation,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: context.unFocus,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.colors.secondary,
            borderRadius: AppBorderRadius.topHuge,
            border: Border.all(
              color: context.colors.outline,
              width: AppWidgetsSizes.borderWidth,
            ),
          ),
          child: Padding(
            padding: AppInsets.allExtraLarge,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Scrollbar(
                    child: FadingEdgeScrollView.fromSingleChildScrollView(
                      gradientFractionOnStart: 0.2,
                      gradientFractionOnEnd: 0.2,
                      child: SingleChildScrollView(
                        controller: textScrollController,
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TitleTextfield(controller: titleTextController),
                            BodyTextfield(
                              controller: bodyTextController,
                              hintTextPrompt: hintTextPrompt,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                AppSpacing.vMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SetConstellationButton(
                        selectedConstellationId: selectedConstellationId,
                        constellations: constellations,
                        onSelectConstellation: onSelectConstellation,
                      ),
                    ),
                    AppSpacing.hMedium,
                    SaveNoteTextButton(onTap: onTapSaveButton),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
