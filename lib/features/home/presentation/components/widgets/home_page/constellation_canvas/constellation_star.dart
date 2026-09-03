import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/services/constellation_layout/constellation_layout_config.dart';
import 'package:constellation_app/shared/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final class ConstellationStar extends StatelessWidget {
  final NoteEntity note;
  final VoidCallback? onTap;

  const ConstellationStar({super.key, required this.note, this.onTap});

  String _getStarAsset() {
    switch (note.starVariant) {
      case 1:
        return AppImages.star1;

      case 2:
        return AppImages.star2;

      case 3:
        return AppImages.star3;

      case 4:
        return AppImages.star4;

      case 5:
        return AppImages.loneStar;

      default:
        throw ArgumentError('Invalid star variant: ${note.starVariant}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        _getStarAsset(),
        width: ConstellationLayoutConfig.starSize,
        height: ConstellationLayoutConfig.starSize,
      ),
    );
  }
}
