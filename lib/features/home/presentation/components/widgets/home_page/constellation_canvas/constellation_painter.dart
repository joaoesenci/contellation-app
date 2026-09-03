import 'package:constellation_app/core/domain/entities/constellation_region_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:flutter/material.dart';

final class ConstellationPainter extends CustomPainter {
  final List<NoteEntity> notes;
  final List<ConstellationRegionEntity> regions;
  final Rect universeBounds;

  const ConstellationPainter({
    required this.notes,
    required this.regions,
    required this.universeBounds,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (universeBounds == Rect.zero) {
      return;
    }

    canvas.save();

    canvas.translate(-universeBounds.left, -universeBounds.top);

    _paintConstellationRegions(canvas);

    canvas.restore();
  }

  void _paintConstellationRegions(Canvas canvas) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (final region in regions) {
      canvas.drawRect(region.bounds, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ConstellationPainter oldDelegate) {
    return oldDelegate.notes != notes ||
        oldDelegate.regions != regions ||
        oldDelegate.universeBounds != universeBounds;
  }
}
