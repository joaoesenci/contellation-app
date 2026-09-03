import 'package:collection/collection.dart';
import 'package:constellation_app/app/app_routes.dart';
import 'package:constellation_app/features/home/home_routes.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/constellation_canvas/constellation_canvas.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/empty_list_container.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/header_box/header_box.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/notes_menu_listview/notes_menu_listview.dart';
import 'package:constellation_app/features/home/presentation/cubits/home_cubits/home_cubit.dart';
import 'package:constellation_app/features/home/presentation/cubits/home_cubits/home_state.dart';
import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeInitialSection extends StatelessWidget {
  final HomeState state;
  final HomeCubit cubit;
  final TextEditingController textController;
  final ScrollController headerScrollController;
  final ScrollController listScrollController;

  const HomeInitialSection({
    super.key,
    required this.state,
    required this.cubit,
    required this.textController,
    required this.headerScrollController,
    required this.listScrollController,
  });

  void _onTapClearButton() {
    cubit.onClearSearch();
    textController.clear();
  }

  void _onDeleteNotes() {
    cubit.onDeleteNotes(state.selectedNotesIds);
    cubit.onClearDeleting();
  }

  void _onTapCancelDeleting() async {
    await HapticFeedback.lightImpact();
    cubit.onClearDeleting();
  }

  void _onTapNote(BuildContext context, String id) async {
    await HapticFeedback.selectionClick();

    if (state.isDeleting) {
      cubit.onToggleNoteDeleting(id);
      return;
    }

    final note = state.allNotes.firstWhereOrNull((note) => note.id == id);

    if (note != null) {
      final isNoteSaved = await Modular.to.pushNamed<bool>(
        '${AppRoutes.home}${HomeRoutes.editNote}',
        arguments: note,
      );
      if (isNoteSaved == true && context.mounted) {
        cubit.onRefreshNotes();
      }
    }
  }

  void _onLongPressNote(String id) {
    if (state.isDeleting) return;

    cubit.onOpenDeleting();
    cubit.onToggleNoteDeleting(id);
  }

  @override
  Widget build(BuildContext context) {
    final hasSelectedFilter = state.selectedConstellationId.isNotEmpty;
    final currentNotes = hasSelectedFilter
        ? state.filteredNotes
        : state.allNotes;
    final isNotesListEmpty = currentNotes.isEmpty;
    final isSearchNotesEmpty = state.isSearching && state.foundNotes.isEmpty;

    final listEmptyText = isSearchNotesEmpty
        ? AppStrings.emptySearchingNotes
        : hasSelectedFilter
        ? AppStrings.emptyConstellation
        : AppStrings.emptyNotes;

    return Stack(
      children: [
        ConstellationCanvas(
          notes: state.allNotes,
          regions: state.constellationRegions,
          universeBounds: state.universeBounds,
        ),
        Positioned(
          top: AppWidgetsSizes.appBarHeight,
          left: AppSizes.large,
          right: AppSizes.large,
          bottom: 0,
          child: Column(
            children: [
              HeaderBox(
                constellations: state.constellations,
                selectedConstellationId: state.selectedConstellationId,
                isListMode: state.isListMode,
                isSearching: state.isSearching,
                isDeleting: state.isDeleting,
                isEmptyNotes: state.allNotes.isEmpty,
                selectedNotesLenght: state.selectedNotesIds.length,
                textController: textController,
                scrollController: headerScrollController,
                onTapToggleButton: cubit.onToggleViewMode,
                onTapSearchButton: cubit.onOpenSearch,
                onTapClearButton: _onTapClearButton,
                onTapDeleteButton: _onDeleteNotes,
                onCancelDeleting: _onTapCancelDeleting,
                onSearch: cubit.onSearchNotes,
                onTapConstellationFilter: cubit.onSelectConstellation,
              ),
              AppSpacing.vLarge,
              isNotesListEmpty || isSearchNotesEmpty
                  ? EmptyListContainer(text: listEmptyText)
                  : NotesMenuListview(
                      notes: state.isSearching
                          ? state.foundNotes
                          : currentNotes,
                      selectedNotes: state.selectedNotesIds,
                      scrollController: listScrollController,
                      isListMode: state.isListMode,
                      onTapNote: (id) => _onTapNote(context, id),
                      onLongPressNote: _onLongPressNote,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
