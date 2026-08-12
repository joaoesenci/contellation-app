import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/features/home/presentation/cubits/edit_note_cubits/edit_note_enum.dart';
import 'package:equatable/equatable.dart';

final class EditNoteState extends Equatable {
  final EditNoteStatus status;
  final EditNoteFeedbackStatus feedbackStatus;
  final String? message;
  final NoteEntity? existingNote;
  final List<ConstellationEntity> constellations;
  final String? selectedConstellationId;
  final bool isRefreshing;

  const EditNoteState({
    this.status = EditNoteStatus.loading,
    this.feedbackStatus = EditNoteFeedbackStatus.none,
    this.message,
    this.existingNote,
    this.constellations = const [],
    this.selectedConstellationId,
    this.isRefreshing = false,
  });

  EditNoteState copyWith({
    EditNoteStatus? status,
    EditNoteFeedbackStatus? feedbackStatus,
    String? message,
    NoteEntity? existingNote,
    List<ConstellationEntity>? constellations,
    String? selectedConstellationId,
    bool? isRefreshing,
  }) {
    return EditNoteState(
      status: status ?? this.status,
      feedbackStatus: feedbackStatus ?? this.feedbackStatus,
      message: message ?? this.message,
      existingNote: existingNote ?? this.existingNote,
      constellations: constellations ?? this.constellations,
      selectedConstellationId:
          selectedConstellationId ?? this.selectedConstellationId,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
    status,
    feedbackStatus,
    selectedConstellationId,
    isRefreshing,
  ];
}
