import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/core/domain/entities/constellation_line_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/features/home/presentation/cubits/home_cubits/home_enum.dart';
import 'package:equatable/equatable.dart';

final class HomeState extends Equatable {
  final HomeStatus status;
  final HomeFeedbackStatus feedbackStatus;
  final String? message;
  final String selectedConstellationId;
  final List<NoteEntity> allNotes;
  final List<NoteEntity> filteredNotes;
  final List<NoteEntity> foundNotes;
  final List<ConstellationEntity> constellations;
  final List<String> selectedNotesIds;
  final bool isListMode;
  final bool isSearching;
  final bool isRefreshing;
  final bool isDeleting;

  const HomeState({
    this.status = HomeStatus.loading,
    this.feedbackStatus = HomeFeedbackStatus.none,
    this.message,
    this.selectedConstellationId = '',
    this.allNotes = const [],
    this.filteredNotes = const [],
    this.foundNotes = const [],
    this.constellations = const [],
    this.selectedNotesIds = const [],
    this.isListMode = false,
    this.isSearching = false,
    this.isRefreshing = false,
    this.isDeleting = false,
  });

  HomeState copyWith({
    HomeStatus? status,
    HomeFeedbackStatus? feedbackStatus,
    String? message,
    String? selectedConstellationId,
    List<NoteEntity>? allNotes,
    List<NoteEntity>? filteredNotes,
    List<NoteEntity>? foundNotes,
    List<ConstellationEntity>? constellations,
    List<ConstellationLineEntity>? constellationLines,
    List<String>? selectedNotesIds,
    bool? isListMode,
    bool? isSearching,
    bool? isRefreshing,
    bool? isDeleting,
  }) {
    return HomeState(
      status: status ?? this.status,
      feedbackStatus: feedbackStatus ?? this.feedbackStatus,
      message: message ?? this.message,
      selectedConstellationId:
          selectedConstellationId ?? this.selectedConstellationId,
      allNotes: allNotes ?? this.allNotes,
      filteredNotes: filteredNotes ?? this.filteredNotes,
      foundNotes: foundNotes ?? this.foundNotes,
      constellations: constellations ?? this.constellations,
      selectedNotesIds: selectedNotesIds ?? this.selectedNotesIds,
      isListMode: isListMode ?? this.isListMode,
      isSearching: isSearching ?? this.isSearching,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }

  @override
  List<Object?> get props => [
    status,
    feedbackStatus,
    message,
    selectedConstellationId,
    allNotes,
    filteredNotes,
    foundNotes,
    selectedNotesIds,
    isListMode,
    isSearching,
    isRefreshing,
    isDeleting,
  ];
}
