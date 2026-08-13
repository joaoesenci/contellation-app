import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/core/services/constellation/constellation_connection_service.dart';
import 'package:constellation_app/features/home/domain/usecases/lines/delete_constellation_lines_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/lines/get_all_constellation_lines_usecase.dart';
import 'package:constellation_app/features/home/domain/usecases/lines/save_constellation_lines_usecase.dart';
import 'package:constellation_app/features/home/presentation/cubits/constellation_cubits/constellation_enum.dart';
import 'package:constellation_app/features/home/presentation/cubits/constellation_cubits/constellation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class ConstellationCubit extends Cubit<ConstellationState> {
  final ConstellationConnectionService _connectionService;
  final GetAllConstellationLinesUsecase _getAllConstellationLinesUsecase;
  final SaveConstellationLinesUsecase _saveConstellationLinesUsecase;
  final DeleteConstellationLinesUsecase _deleteConstellationLinesUsecase;

  ConstellationCubit({
    required ConstellationConnectionService connectionService,
    required GetAllConstellationLinesUsecase getAllConstellationLinesUsecase,
    required SaveConstellationLinesUsecase saveConstellationLinesUsecase,
    required DeleteConstellationLinesUsecase deleteConstellationLinesUsecase,
  }) : _connectionService = connectionService,
       _getAllConstellationLinesUsecase = getAllConstellationLinesUsecase,
       _saveConstellationLinesUsecase = saveConstellationLinesUsecase,
       _deleteConstellationLinesUsecase = deleteConstellationLinesUsecase,
       super(const ConstellationState());

  static const ConstellationStatus initialStatus = ConstellationStatus.initial;
  static const ConstellationStatus loadingStatus = ConstellationStatus.loading;
  static const ConstellationStatus problemStatus = ConstellationStatus.problem;

  static const ConstellationFeedbackStatus noneFeedback =
      ConstellationFeedbackStatus.none;
  static const ConstellationFeedbackStatus errorFeedback =
      ConstellationFeedbackStatus.error;

  //----------------------------------------------------------------------
  // 📱 UI FUNCTIONS
  //----------------------------------------------------------------------
  void clearFeedbackStatus() {
    emit(state.copyWith(feedbackStatus: noneFeedback));
  }

  void clearConstellation() {
    emit(
      state.copyWith(
        selectedConstellationId: '',
        notes: const [],
        lines: const [],
        isRefreshing: false,
      ),
    );
  }

  //----------------------------------------------------------------------
  // 💡 BUSINESS LOGIC FUNCTIONS
  //----------------------------------------------------------------------
  Future<void> loadConstellation({
    required String constellationId,
    required List<NoteEntity> notes,
  }) async {
    emit(
      state.copyWith(
        status: loadingStatus,
        isRefreshing: true,
        selectedConstellationId: constellationId,
        message: null,
        feedbackStatus: noneFeedback,
      ),
    );

    final constellationNotes = notes
        .where((note) => note.constellationId == constellationId)
        .toList(growable: false);

    final result = await _getAllConstellationLinesUsecase(noParams);

    if (result.isLeft()) {
      result.fold(
        (failure) => emit(
          state.copyWith(
            status: problemStatus,
            feedbackStatus: errorFeedback,
            message: failure.message,
            notes: constellationNotes,
            isRefreshing: false,
          ),
        ),
        (_) {},
      );

      return;
    }

    final allLines = result.getOrElse((_) => const []);

    final noteIds = constellationNotes.map((note) => note.id).toSet();

    final storedLines = allLines
        .where(
          (line) =>
              noteIds.contains(line.fromNoteId) &&
              noteIds.contains(line.toNoteId),
        )
        .toList(growable: false);

    final expectedLines = _connectionService.generateInitialConnections(
      constellationNotes,
    );

    final storedLineIds = storedLines.map((line) => line.id).toSet();
    final expectedLineIds = expectedLines.map((line) => line.id).toSet();

    final isUpToDate =
        storedLineIds.length == expectedLineIds.length &&
        storedLineIds.containsAll(expectedLineIds);

    if (isUpToDate) {
      emit(
        state.copyWith(
          status: initialStatus,
          notes: constellationNotes,
          lines: storedLines,
          isRefreshing: false,
        ),
      );

      return;
    }

    final linesToSave = expectedLines
        .where((line) => !storedLineIds.contains(line.id))
        .toList(growable: false);

    final linesToDelete = storedLines
        .where((line) => !expectedLineIds.contains(line.id))
        .map((line) => line.id)
        .toList(growable: false);

    if (linesToSave.isNotEmpty) {
      final saveResult = await _saveConstellationLinesUsecase(
        SaveConstellationLinesParams(lines: linesToSave),
      );

      if (saveResult.isLeft()) {
        saveResult.fold(
          (failure) => emit(
            state.copyWith(
              status: problemStatus,
              feedbackStatus: errorFeedback,
              message: failure.message,
              notes: constellationNotes,
              lines: storedLines,
              isRefreshing: false,
            ),
          ),
          (_) {},
        );

        return;
      }
    }

    if (linesToDelete.isNotEmpty) {
      final deleteResult = await _deleteConstellationLinesUsecase(
        DeleteConstellationLinesParams(linesId: linesToDelete),
      );

      if (deleteResult.isLeft()) {
        deleteResult.fold(
          (failure) => emit(
            state.copyWith(
              status: problemStatus,
              feedbackStatus: errorFeedback,
              message: failure.message,
              notes: constellationNotes,
              lines: expectedLines,
              isRefreshing: false,
            ),
          ),
          (_) {},
        );

        return;
      }
    }

    emit(
      state.copyWith(
        status: initialStatus,
        notes: constellationNotes,
        lines: expectedLines,
        isRefreshing: false,
      ),
    );
  }

  //----------------------------------------------------------------------
  // 🔒 PRIVATE FUNCTIONS
  //----------------------------------------------------------------------
}
