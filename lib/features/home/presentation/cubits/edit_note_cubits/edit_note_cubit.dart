import 'dart:math';
import 'dart:ui';

import 'package:constellation_app/core/domain/entities/constellation_region_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/core/services/constellation_layout/constellation_layout_service.dart';
import 'package:constellation_app/features/home/domain/usecases/get_all_notes_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/get_fixed_constellations_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/save_note_usecase.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_enum.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

final class EditNoteCubit extends Cubit<EditNoteState> {
  final GetFixedConstellationsUsecase _getFixedConstellationsUsecase;
  final GetAllNotesUsecase _getAllNotesUsecase;
  final SaveNoteUsecase _saveNoteUsecase;
  final IConstellationLayoutService _layoutService;

  EditNoteCubit({
    required GetFixedConstellationsUsecase getFixedConstellationsUsecase,
    required GetAllNotesUsecase getAllNotesUsecase,
    required SaveNoteUsecase saveNoteUsecase,
    required IConstellationLayoutService layoutService,
  }) : _getFixedConstellationsUsecase = getFixedConstellationsUsecase,
       _getAllNotesUsecase = getAllNotesUsecase,
       _saveNoteUsecase = saveNoteUsecase,
       _layoutService = layoutService,
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
    if (constellationId == null) {
      return;
    }

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

    final positionResult = await _calculateNotePosition(
      id: id,
      constellationId: constellationId,
    );

    final result = await positionResult.fold<Future<Either<Failure, Unit>>>(
      (failure) async {
        return Left(failure);
      },
      (position) {
        return _saveNoteUsecase(
          SaveNoteParams(
            title: title,
            text: text,
            starVariant: starVariant,
            id: id,
            constellationId: constellationId,
            positionX: position.dx,
            positionY: position.dy,
          ),
        );
      },
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
  Future<Either<Failure, Offset>> _calculateNotePosition({
    required String? id,
    required String? constellationId,
  }) async {
    final existingNote = state.existingNote;

    final isEditing = id != null && existingNote != null;

    if (isEditing) {
      final constellationChanged =
          existingNote.constellationId != constellationId;

      if (!constellationChanged) {
        return Right(Offset(existingNote.positionX, existingNote.positionY));
      }
    }

    final notesResult = await _getAllNotesUsecase(noParams);

    return notesResult.map(
      (notes) => _calculateNewNotePosition(
        constellationId: constellationId,
        notes: notes,
        editingNoteId: id,
      ),
    );
  }

  Offset _calculateNewNotePosition({
    required String? constellationId,
    required List<NoteEntity> notes,
    required String? editingNoteId,
  }) {
    final availableNotes = notes
        .where((note) => note.id != editingNoteId)
        .toList();

    if (constellationId == null) {
      final loneStars = availableNotes
          .where((note) => note.constellationId == null)
          .toList();

      final regions = _calculateConstellationRegions(notes: availableNotes);

      return _layoutService.calculateLoneStarPosition(
        regions: regions,
        loneStars: loneStars,
      );
    }

    final constellationNotes = availableNotes
        .where((note) => note.constellationId == constellationId)
        .toList();

    if (constellationNotes.isEmpty) {
      return _layoutService.calculateInitialStarPosition(
        constellationId: constellationId,
      );
    }

    final otherRegions = _calculateConstellationRegions(
      notes: availableNotes,
      excludedConstellationId: constellationId,
    );

    return _layoutService.calculateNewStarPosition(
      notes: constellationNotes,
      otherRegions: otherRegions,
    );
  }

  List<ConstellationRegionEntity> _calculateConstellationRegions({
    required List<NoteEntity> notes,
    String? excludedConstellationId,
  }) {
    final constellationIds = notes
        .map((note) => note.constellationId)
        .whereType<String>()
        .where((id) => id != excludedConstellationId)
        .toSet();

    final regions = <ConstellationRegionEntity>[];

    for (final constellationId in constellationIds) {
      final constellationNotes = notes
          .where((note) => note.constellationId == constellationId)
          .toList();

      if (constellationNotes.isEmpty) {
        continue;
      }

      regions.add(
        _layoutService.calculateConstellationRegion(
          constellationId: constellationId,
          notes: constellationNotes,
        ),
      );
    }

    return regions;
  }
}
