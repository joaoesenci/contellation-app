import 'dart:math';

import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/features/home/presentation/components/sections/edit_note_sections/edit_note_initial_section.dart';
import 'package:constellation_app/features/home/presentation/components/sections/edit_note_sections/edit_note_loading_section.dart';
import 'package:constellation_app/features/home/presentation/components/sections/edit_note_sections/edit_note_problem_section.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_cubit.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_enum.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_state.dart';
import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditNotePage extends StatefulWidget {
  final EditNoteCubit cubit;
  final NoteEntity? existingNote;

  const EditNotePage({super.key, required this.cubit, this.existingNote});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  EditNoteCubit get _cubit => widget.cubit;
  NoteEntity? get _existingNote => widget.existingNote;

  late final TextEditingController _titleTextController;
  late final TextEditingController _bodyTextController;
  late final ScrollController _textScrollController;

  static const _hintTextPrompts = AppStrings.editNotePrompts;

  late final String _randomPrompt;

  @override
  void initState() {
    super.initState();

    _randomPrompt = _hintTextPrompts[Random().nextInt(_hintTextPrompts.length)];
    _titleTextController = TextEditingController(text: _existingNote?.title);
    _bodyTextController = TextEditingController(text: _existingNote?.text);
    _textScrollController = ScrollController();

    _cubit.loadData(_existingNote);
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _bodyTextController.dispose();
    _textScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditNoteCubit, EditNoteState>(
      bloc: _cubit,

      listenWhen: (previous, current) =>
          previous.feedbackStatus != current.feedbackStatus,

      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.selectedConstellationId != current.selectedConstellationId,

      listener: (context, state) {},

      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.colors.primary,
          body: switch (state.status) {
            EditNoteStatus.initial => EditNoteInitialSection(
              state: state,
              cubit: _cubit,
              titleTextController: _titleTextController,
              bodyTextController: _bodyTextController,
              textScrollController: _textScrollController,
              hintTextPrompt: _randomPrompt,
            ),
            EditNoteStatus.loading => const EditNoteLoadingSection(),
            EditNoteStatus.problem => const EditNoteProblemSection(),
          },
        );
      },
    );
  }
}
