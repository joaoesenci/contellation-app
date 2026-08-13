import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/header_box/constellations_filter.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/header_box/header_actions.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/header_box/header_title.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/header_box/searching_text_field.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/header_box/selected_notes_counter.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/header_box/toggle_view_button.dart';
import 'package:constellation_app/shared/constants/app_durations.dart';
import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';

class HeaderBox extends StatefulWidget {
  final List<ConstellationEntity> constellations;
  final String? selectedConstellationId;
  final bool isListMode;
  final bool isSearching;
  final bool isDeleting;
  final bool isEmptyNotes;
  final int selectedNotesLenght;
  final TextEditingController textController;
  final ScrollController scrollController;
  final VoidCallback onTapToggleButton;
  final VoidCallback onTapClearButton;
  final VoidCallback onTapSearchButton;
  final VoidCallback onTapDeleteButton;
  final VoidCallback onCancelDeleting;
  final ValueChanged<String> onSearch;
  final ValueChanged<String> onTapConstellationFilter;

  const HeaderBox({
    super.key,
    required this.constellations,
    required this.selectedConstellationId,
    required this.isListMode,
    required this.isSearching,
    required this.isDeleting,
    required this.isEmptyNotes,
    required this.selectedNotesLenght,
    required this.textController,
    required this.scrollController,
    required this.onTapSearchButton,
    required this.onTapToggleButton,
    required this.onTapClearButton,
    required this.onTapDeleteButton,
    required this.onCancelDeleting,
    required this.onSearch,
    required this.onTapConstellationFilter,
  });

  @override
  State<HeaderBox> createState() => _HeaderBoxState();
}

class _HeaderBoxState extends State<HeaderBox> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggleView() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final outlineColor = context.colors.outline;

    return AnimatedSize(
      duration: AppDurations.headerSizeAnimation,
      curve: Curves.decelerate,
      child: Container(
        padding: const EdgeInsets.only(
          top: AppSizes.medium,
          left: AppSizes.small,
          right: AppSizes.small,
          bottom: AppSizes.extraSmall,
        ),
        decoration: BoxDecoration(
          color: context.colors.secondary,
          borderRadius: AppBorderRadius.allLarge,
          border: Border.all(
            color: outlineColor,
            width: AppWidgetsSizes.borderWidth,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isExpanded) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isSearching
                      ? SearchingTextField(
                          onSearch: widget.onSearch,
                          controller: widget.textController,
                        )
                      : widget.isDeleting
                      ? SelectedNotesCounter(
                          notesLenght: widget.selectedNotesLenght,
                          onTapIcon: widget.onCancelDeleting,
                        )
                      : const HeaderTitle(),
                  HeaderActions(
                    isSearching: widget.isSearching,
                    isListMode: widget.isListMode,
                    isDeleting: widget.isDeleting,
                    isEmptyNotes: widget.isEmptyNotes,
                    onTapSearchButton: widget.onTapSearchButton,
                    onTapToggleButton: widget.onTapToggleButton,
                    onTapClearButton: widget.onTapClearButton,
                    onTapDeleteButton: widget.onTapDeleteButton,
                  ),
                ],
              ),
              if (!widget.isSearching) ...[
                AppSpacing.vLarge,
                ConstellationsFilter(
                  constellations: widget.constellations,
                  scrollController: widget.scrollController,
                  selectedConstellationId: widget.selectedConstellationId,
                  onSelect: widget.onTapConstellationFilter,
                ),
              ],
            ] else
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppSpacing.hSmall,
                  Text(
                    AppStrings.closedHeader,
                    style: context.texts.bodyMedium!.copyWith(
                      color: context.colors.onSecondary,
                      fontWeight: FontWeight.w300,
                      fontFamily: AppStrings.nunitoFont,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppSizes.large,
                bottom: AppSizes.extraSmall,
              ),
              child: Divider(
                indent: 100,
                endIndent: 100,
                color: outlineColor.withAlpha(80),
              ),
            ),
            ToggleViewButton(onTap: _toggleView, isExpanded: _isExpanded),
          ],
        ),
      ),
    );
  }
}
