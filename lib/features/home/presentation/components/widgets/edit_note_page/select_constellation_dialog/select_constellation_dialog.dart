import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/edit_note_page/select_constellation_dialog/select_constellation_dialog_option.dart';
import 'package:flutter/material.dart';

class SelectConstellationDialog extends StatelessWidget {
  final String? selectedConstellationId;
  final List<ConstellationEntity> constellations;
  final ValueChanged<String> onSelectConstellation;

  const SelectConstellationDialog({
    super.key,
    required this.selectedConstellationId,
    required this.constellations,
    required this.onSelectConstellation,
  });

  static Future<void> show({
    required BuildContext context,
    required String? selectedConstellationId,
    required List<ConstellationEntity> constellations,
    required ValueChanged<String> onSelectConstellation,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return SelectConstellationDialog(
          selectedConstellationId: selectedConstellationId,
          constellations: constellations,
          onSelectConstellation: onSelectConstellation,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SelectConstellationDialogOption(
            constellation: constellations[0],
            isSelected: constellations[0].id == selectedConstellationId,
            onTap: () => onSelectConstellation(constellations[0].id),
          ),
          SelectConstellationDialogOption(
            constellation: constellations[1],
            isSelected: constellations[1].id == selectedConstellationId,
            onTap: () => onSelectConstellation(constellations[1].id),
          ),
          SelectConstellationDialogOption(
            constellation: constellations[2],
            isSelected: constellations[2].id == selectedConstellationId,
            onTap: () => onSelectConstellation(constellations[2].id),
          ),
          SelectConstellationDialogOption(
            constellation: constellations[3],
            isSelected: constellations[3].id == selectedConstellationId,
            onTap: () => onSelectConstellation(constellations[3].id),
          ),
        ],
      ),
    );
  }
}
