import 'package:constellation_app/features/home/presentation/components/widgets/edit_note_page/edit_note_return_button.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/edit_note_page/edit_note_text_area/edit_note_text_area.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_cubit.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_state.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EditNoteInitialSection extends StatelessWidget {
  final EditNoteState state;
  final EditNoteCubit cubit;
  final TextEditingController titleTextController;
  final TextEditingController bodyTextController;
  final ScrollController textScrollController;
  final String hintTextPrompt;

  const EditNoteInitialSection({
    super.key,
    required this.state,
    required this.cubit,
    required this.titleTextController,
    required this.bodyTextController,
    required this.textScrollController,
    required this.hintTextPrompt,
  });

  void _onSaveNote() {
    if (titleTextController.text.isEmpty && bodyTextController.text.isEmpty) {
      return;
    }

    final title = titleTextController.text.isEmpty
        ? 'Title'
        : titleTextController.text;

    final body = bodyTextController.text.isEmpty
        ? ''
        : titleTextController.text;

    cubit.onSaveNote(
      title: title,
      text: body,
      id: state.existingNote?.id,
      constellationId: state.selectedConstellationId,
    );

    Modular.to.pop();
    cubit.clearSelectedConstellation();
  }

  void _onTapReturnButton() {
    if (titleTextController.text.isEmpty && bodyTextController.text.isEmpty) {
      Modular.to.pop();
      cubit.clearSelectedConstellation();
      return;
    }

    _onSaveNote();
  }

  void _onSelectConstellation(String constellationId) {
    cubit.onSelectConstellation(constellationId);
    Modular.to.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: AppWidgetsSizes.appBarHeight,
            left: AppSizes.extraSmall,
            right: AppSizes.extraSmall,
          ),
          height: 120,
          width: double.infinity,
          child: Align(
            alignment: Alignment.topLeft,
            child: EditNoteReturnButton(onTap: _onTapReturnButton),
          ),
        ),
        EditNoteTextArea(
          titleTextController: titleTextController,
          bodyTextController: bodyTextController,
          textScrollController: textScrollController,
          hintTextPrompt: hintTextPrompt,
          constellations: state.constellations,
          selectedConstellationId: state.selectedConstellationId,
          onSelectConstellation: _onSelectConstellation,
          onTapSaveButton: _onSaveNote,
        ),
      ],
    );
  }
}
