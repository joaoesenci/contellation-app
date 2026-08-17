import 'dart:math';

import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/get_fixed_constellations_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/save_note_usecase.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_enum.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class EditNoteCubit extends Cubit<EditNoteState> {
  final GetFixedConstellationsUsecase _getFixedConstellationsUsecase;
  final SaveNoteUsecase _saveNoteUsecase;

  EditNoteCubit({
    required GetFixedConstellationsUsecase getFixedConstellationsUsecase,
    required SaveNoteUsecase saveNoteUsecase,
  }) : _getFixedConstellationsUsecase = getFixedConstellationsUsecase,
       _saveNoteUsecase = saveNoteUsecase,
       super(const EditNoteState());

  static const EditNoteStatus initialStatus = EditNoteStatus.initial;
  static const EditNoteStatus loadingStatus = EditNoteStatus.loading;
  static const EditNoteStatus problemStatus = EditNoteStatus.problem;
  static const EditNoteFeedbackStatus noneFeedback =
      EditNoteFeedbackStatus.none;
  static const EditNoteFeedbackStatus errorFeedback =
      EditNoteFeedbackStatus.error;

  //----------------------------------------------------------------------
  // 📱 UI FUNCTIONS
  //----------------------------------------------------------------------
  void clearFeedbackStatus() {
    emit(state.copyWith(feedbackStatus: noneFeedback));
  }

  void onSelectConstellation(String? constellationId) {
    if (constellationId == null) return;
    emit(state.copyWith(selectedConstellationId: constellationId));
  }

  void clearSelectedConstellation() {
    emit(state.copyWith(selectedConstellationId: null));
  }

  //----------------------------------------------------------------------
  // 💡 BUSINESS LOGIC FUNCTIONS
  //----------------------------------------------------------------------
  void loadData(NoteEntity? note) async {
    final result = await _getFixedConstellationsUsecase(noParams);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: problemStatus,
          feedbackStatus: errorFeedback,
          message: failure.message,
        ),
      ),
      (constellations) => emit(
        state.copyWith(
          status: initialStatus,
          existingNote: note,
          selectedConstellationId: note?.constellationId,
          constellations: constellations,
        ),
      ),
    );
  }

  Future<void> onSaveNote({
    required String title,
    required String text,
    String? id,
    String? constellationId,
  }) async {
    emit(state.copyWith(isRefreshing: true));

    final starVariant = constellationId == null ? 5 : Random().nextInt(4) + 1;

    final result = await _saveNoteUsecase(
      SaveNoteParams(
        title: title,
        text: text,
        starVariant: starVariant,
        id: id,
        constellationId: constellationId,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: problemStatus,
          feedbackStatus: errorFeedback,
          message: failure.message,
          isRefreshing: false,
        ),
      ),
      (_) => emit(state.copyWith(status: initialStatus, isRefreshing: false)),
    );
  }

  //----------------------------------------------------------------------
  // 🔒 PRIVATE FUNCTIONS
  //----------------------------------------------------------------------
}
