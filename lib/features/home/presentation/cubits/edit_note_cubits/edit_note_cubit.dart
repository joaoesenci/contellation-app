import 'dart:math';

import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/core/services/constellation/constellation_layout_service.dart';
import 'package:constellation_app/features/home/domain/usecases/get_fixed_constellations_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/notes/save_note_usecase.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_enum.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class EditNoteCubit extends Cubit<EditNoteState> {
  final ConstellationLayoutService _layoutService;
  final GetFixedConstellationsUsecase _getFixedConstellationsUsecase;
  final SaveNoteUsecase _saveNoteUsecase;

  EditNoteCubit({
    required ConstellationLayoutService layoutService,
    required GetFixedConstellationsUsecase getFixedConstellationsUsecase,
    required SaveNoteUsecase saveNoteUsecase,
  }) : _layoutService = layoutService,
       _getFixedConstellationsUsecase = getFixedConstellationsUsecase,
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
  void loadData(NoteEntity? note, List<NoteEntity> allNotes) async {
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
          allNotes: allNotes,
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

    final existingNote = state.existingNote;

    final isEditing = existingNote != null && id != null;

    final constellationChanged =
        isEditing && existingNote.constellationId != constellationId;

    late final int starVariant;

    if (!isEditing) {
      starVariant = constellationId == null ? 5 : Random().nextInt(4) + 1;
    } else if (constellationId == null) {
      starVariant = 5;
    } else if (existingNote.starVariant == 5) {
      starVariant = Random().nextInt(4) + 1;
    } else {
      starVariant = existingNote.starVariant;
    }

    late final double positionX;
    late final double positionY;

    if (!isEditing || constellationChanged) {
      final position = _layoutService.findPosition(
        constellationId: constellationId,
        existingNotes: state.allNotes,
      );

      positionX = position.x;
      positionY = position.y;
    } else {
      positionX = existingNote.positionX;
      positionY = existingNote.positionY;
    }

    final result = await _saveNoteUsecase(
      SaveNoteParams(
        title: title,
        text: text,
        starVariant: starVariant,
        id: id,
        constellationId: constellationId,
        positionX: positionX,
        positionY: positionY,
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
