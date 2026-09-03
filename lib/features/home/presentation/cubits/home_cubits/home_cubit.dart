import 'dart:async';

import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/core/domain/entities/constellation_region_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/core/services/constellation_layout/constellation_layout_service.dart';
import 'package:constellation_app/features/home/domain/usecases/delete_note_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/get_all_notes_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/get_fixed_constellations_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/save_note_usecase.dart';
import 'package:constellation_app/features/home/presentation/cubits/home_cubits/home_enum.dart';
import 'package:constellation_app/features/home/presentation/cubits/home_cubits/home_state.dart';
import 'package:constellation_app/shared/constants/app_durations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetFixedConstellationsUsecase _getFixedConstellationsUsecase;
  final GetAllNotesUsecase _getAllNotesUsecase;
  final DeleteNoteUsecase _deleteNoteUsecase;
  final IConstellationLayoutService _layoutService;

  Timer? _throttleTimer;
  Timer? _debounce;

  HomeCubit({
    required GetFixedConstellationsUsecase getFixedConstellationsUsecase,
    required SaveNoteUsecase saveNoteUsecase,
    required GetAllNotesUsecase getAllNotesUsecase,
    required DeleteNoteUsecase deleteNoteUsecase,
    required IConstellationLayoutService layoutService,
  }) : _getFixedConstellationsUsecase = getFixedConstellationsUsecase,
       _getAllNotesUsecase = getAllNotesUsecase,
       _deleteNoteUsecase = deleteNoteUsecase,
       _layoutService = layoutService,
       super(const HomeState());

  static const HomeStatus initialStatus = HomeStatus.initial;
  static const HomeStatus loadingStatus = HomeStatus.loading;
  static const HomeStatus problemStatus = HomeStatus.problem;

  static const HomeFeedbackStatus noneFeedback = HomeFeedbackStatus.none;

  static const HomeFeedbackStatus errorFeedback = HomeFeedbackStatus.error;

  //----------------------------------------------------------------------
  // 📱 UI FUNCTIONS
  //----------------------------------------------------------------------
  void clearFeedbackStatus() {
    emit(state.copyWith(feedbackStatus: noneFeedback));
  }

  void onToggleViewMode() {
    if (_throttleTimer?.isActive ?? false) {
      return;
    }

    emit(state.copyWith(isListMode: !state.isListMode));

    _throttleTimer = Timer(AppDurations.toggleViewModeAnimation, () {});
  }

  void onSelectConstellation(String constellationId) {
    final newSelectedId = state.selectedConstellationId == constellationId
        ? ''
        : constellationId;

    emit(
      state.copyWith(
        selectedConstellationId: newSelectedId,
        filteredNotes: _filterNotesForConstellation(newSelectedId),
      ),
    );
  }

  void onSearchNotes(String query) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }

    _debounce = Timer(AppDurations.onSearchNotesDebounce, () {
      final lowQuery = query.toLowerCase();

      final foundNotes = state.allNotes.where((note) {
        final title = note.title.toLowerCase();
        final text = note.text.toLowerCase();

        return title.contains(lowQuery) || text.contains(lowQuery);
      }).toList();

      emit(
        state.copyWith(foundNotes: lowQuery.isEmpty ? const [] : foundNotes),
      );
    });
  }

  void onOpenSearch() {
    emit(state.copyWith(isSearching: true));
  }

  void onClearSearch() {
    emit(
      state.copyWith(
        foundNotes: const [],
        isSearching: false,
        selectedConstellationId: '',
      ),
    );
  }

  void onOpenDeleting() {
    emit(state.copyWith(isDeleting: true));
  }

  void onClearDeleting() {
    emit(state.copyWith(selectedNotesIds: const [], isDeleting: false));
  }

  void onToggleNoteDeleting(String noteId) {
    final selectedNotes = state.selectedNotesIds;
    final isSelectedNote = selectedNotes.contains(noteId);

    if (selectedNotes.length == 1 && noteId == selectedNotes[0]) {
      onClearDeleting();
    }

    emit(
      state.copyWith(
        selectedNotesIds: isSelectedNote
            ? selectedNotes.where((id) => id != noteId).toList()
            : [...selectedNotes, noteId],
      ),
    );
  }

  //----------------------------------------------------------------------
  // 💡 BUSINESS LOGIC FUNCTIONS
  //----------------------------------------------------------------------
  Future<void> onDeleteNotes(List<String> notesId) async {
    emit(state.copyWith(isRefreshing: true));

    final result = await _deleteNoteUsecase(DeleteNoteParams(notesId: notesId));

    result.fold(
      (failure) => emit(
        state.copyWith(
          feedbackStatus: errorFeedback,
          message: failure.message,
          isRefreshing: false,
        ),
      ),
      (_) => _refreshAllNotes(),
    );
  }

  Future<void> loadData() async {
    final (constellationsResult, allNotesResult) = await (
      _getFixedConstellationsUsecase(noParams),
      _getAllNotesUsecase(noParams),
    ).wait;

    String? errorMessage;

    List<ConstellationEntity>? allConstellations;
    List<NoteEntity>? allNotes;

    constellationsResult.fold(
      (failure) => errorMessage = failure.message,
      (constellations) => allConstellations = constellations,
    );

    allNotesResult.fold(
      (failure) => errorMessage = failure.message,
      (notes) => allNotes = notes,
    );

    if (errorMessage != null) {
      emit(
        state.copyWith(
          status: problemStatus,
          feedbackStatus: errorFeedback,
          message: errorMessage,
        ),
      );

      return;
    }

    final notes = allNotes!;

    final regions = _calculateConstellationRegions(notes);

    final loneStars = notes
        .where((note) => note.constellationId == null)
        .toList();

    final universeBounds = _layoutService.calculateUniverseBoundingBox(
      regions: regions,
      loneStars: loneStars,
    );

    emit(
      state.copyWith(
        status: initialStatus,
        constellations: allConstellations,
        allNotes: notes,
        constellationRegions: regions,
        universeBounds: universeBounds,
      ),
    );
  }

  void onRefreshNotes() {
    emit(
      state.copyWith(
        allNotes: const [],
        status: loadingStatus,
        isRefreshing: true,
      ),
    );

    _refreshAllNotes();
  }

  //----------------------------------------------------------------------
  // 🔒 PRIVATE FUNCTIONS
  //----------------------------------------------------------------------
  Future<void> _refreshAllNotes() async {
    final result = await _getAllNotesUsecase(noParams);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: problemStatus,
          feedbackStatus: errorFeedback,
          message: failure.message,
          isRefreshing: false,
        ),
      ),
      (allNotes) {
        final newList = List<NoteEntity>.from(allNotes);

        final regions = _calculateConstellationRegions(newList);

        final loneStars = newList
            .where((note) => note.constellationId == null)
            .toList();

        final universeBounds = _layoutService.calculateUniverseBoundingBox(
          regions: regions,
          loneStars: loneStars,
        );

        emit(
          state.copyWith(
            status: initialStatus,
            allNotes: newList,
            constellationRegions: regions,
            universeBounds: universeBounds,
            isRefreshing: false,
            filteredNotes: state.selectedConstellationId.isEmpty
                ? const []
                : newList
                      .where(
                        (note) =>
                            note.constellationId ==
                            state.selectedConstellationId,
                      )
                      .toList(),
            foundNotes: const [],
            isSearching: false,
          ),
        );
      },
    );
  }

  List<ConstellationRegionEntity> _calculateConstellationRegions(
    List<NoteEntity> notes,
  ) {
    final constellationIds = notes
        .map((note) => note.constellationId)
        .whereType<String>()
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

  List<NoteEntity> _filterNotesForConstellation(String constellationId) {
    if (constellationId.isEmpty) {
      return [];
    }

    final List<NoteEntity> filteredNotes = state.allNotes
        .where((note) => note.constellationId == constellationId)
        .toList();

    return filteredNotes;
  }

  @override
  Future<void> close() {
    _throttleTimer?.cancel();
    _debounce?.cancel();

    return super.close();
  }
}
