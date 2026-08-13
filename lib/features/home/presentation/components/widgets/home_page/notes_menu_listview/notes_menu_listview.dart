import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/notes_menu_listview/notes_menu_listview_item.dart';
import 'package:constellation_app/shared/constants/app_durations.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';

class NotesMenuListview extends StatelessWidget {
  final List<NoteEntity> notes;
  final List<String> selectedNotes;
  final ScrollController scrollController;
  final bool isListMode;
  final ValueChanged<String> onTapNote;
  final ValueChanged<String> onLongPressNote;

  const NotesMenuListview({
    super.key,
    required this.notes,
    required this.selectedNotes,
    required this.scrollController,
    required this.isListMode,
    required this.onTapNote,
    required this.onLongPressNote,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedSwitcher(
        duration: AppDurations.toggleViewModeAnimation,
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(0.0, 0.30),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));
          return SlideTransition(position: offsetAnimation, child: child);
        },
        child: isListMode
            ? FadingEdgeScrollView.fromScrollView(
                gradientFractionOnStart: 0.02,
                gradientFractionOnEnd: 0.02,
                child: ListView.separated(
                  key: const ValueKey('notes_list_view'),
                  itemCount: notes.length,
                  controller: scrollController,
                  padding: const EdgeInsets.only(
                    top: AppSizes.small,
                    bottom: AppSizes.huge,
                  ),
                  separatorBuilder: (context, index) {
                    return AppSpacing.vLarge;
                  },
                  itemBuilder: (context, index) {
                    final note = notes[index];

                    return NotesMenuListviewItem(
                      note: note,
                      isSelected: selectedNotes.contains(note.id),
                      onTap: () => onTapNote(note.id),
                      onLongPress: () => onLongPressNote(note.id),
                    );
                  },
                ),
              )
            : const SizedBox.shrink(key: ValueKey('empty_state')),
      ),
    );
  }
}
