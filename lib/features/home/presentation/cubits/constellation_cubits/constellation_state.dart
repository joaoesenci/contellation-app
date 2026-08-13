import 'package:constellation_app/core/domain/entities/constellation_line_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/features/home/presentation/cubits/constellation_cubits/constellation_enum.dart';
import 'package:equatable/equatable.dart';

final class ConstellationState extends Equatable {
  final ConstellationStatus status;
  final ConstellationFeedbackStatus feedbackStatus;
  final String? message;
  final String selectedConstellationId;
  final List<NoteEntity> notes;
  final List<ConstellationLineEntity> lines;
  final bool isRefreshing;

  const ConstellationState({
    this.status = ConstellationStatus.loading,
    this.feedbackStatus = ConstellationFeedbackStatus.none,
    this.message,
    this.selectedConstellationId = '',
    this.notes = const [],
    this.lines = const [],
    this.isRefreshing = false,
  });

  ConstellationState copyWith({
    ConstellationStatus? status,
    ConstellationFeedbackStatus? feedbackStatus,
    String? message,
    String? selectedConstellationId,
    List<NoteEntity>? notes,
    List<ConstellationLineEntity>? lines,
    bool? isRefreshing,
  }) {
    return ConstellationState(
      status: status ?? this.status,
      feedbackStatus: feedbackStatus ?? this.feedbackStatus,
      message: message ?? this.message,
      selectedConstellationId:
          selectedConstellationId ?? this.selectedConstellationId,
      notes: notes ?? this.notes,
      lines: lines ?? this.lines,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
    status,
    feedbackStatus,
    message,
    selectedConstellationId,
    notes,
    lines,
    isRefreshing,
  ];
}
