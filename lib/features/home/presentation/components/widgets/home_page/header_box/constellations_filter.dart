import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/header_box/constellatios_filter_item.dart';
import 'package:constellation_app/shared/constants/app_icons.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConstellationsFilter extends StatelessWidget {
  final List<ConstellationEntity> constellations;
  final String? selectedConstellationId;
  final ScrollController scrollController;
  final ValueChanged<String> onSelect;

  const ConstellationsFilter({
    super.key,
    required this.constellations,
    required this.selectedConstellationId,
    required this.scrollController,
    required this.onSelect,
  });

  void _onSelect(String id) async {
    await HapticFeedback.selectionClick();
    onSelect(id);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(AppIcons.caretLeft, size: AppIconSizes.small),
        AppSpacing.hSmall,
        Expanded(
          child: FadingEdgeScrollView.fromSingleChildScrollView(
            gradientFractionOnStart: 0.2,
            gradientFractionOnEnd: 0.2,
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ConstellatiosFilterItem(
                    constellation: constellations[0],
                    isSelected: selectedConstellationId == constellations[0].id,
                    onTap: () => _onSelect(constellations[0].id),
                  ),
                  AppSpacing.hMedium,
                  ConstellatiosFilterItem(
                    constellation: constellations[1],
                    isSelected: selectedConstellationId == constellations[1].id,
                    onTap: () => _onSelect(constellations[1].id),
                  ),
                  AppSpacing.hMedium,
                  ConstellatiosFilterItem(
                    constellation: constellations[2],
                    isSelected: selectedConstellationId == constellations[2].id,
                    onTap: () => _onSelect(constellations[2].id),
                  ),
                  AppSpacing.hMedium,
                  ConstellatiosFilterItem(
                    constellation: constellations[3],
                    isSelected: selectedConstellationId == constellations[3].id,
                    onTap: () => _onSelect(constellations[3].id),
                  ),
                ],
              ),
            ),
          ),
        ),
        AppSpacing.hSmall,
        Icon(AppIcons.caretRight, size: AppIconSizes.small),
      ],
    );
  }
}
