import 'package:constellation_app/core/domain/entities/constellation_line_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/shared/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final class ConstellationPainter extends CustomPainter {
  final List<NoteEntity> notes;
  final List<ConstellationLineEntity> lines;
  final Color lineColor;
  final Map<int, PictureInfo>? starPictures;
  final PictureInfo? loneStarPicture;

  ConstellationPainter({
    required this.notes,
    required this.lines,
    required this.lineColor,
    this.starPictures,
    this.loneStarPicture,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (notes.isEmpty) return;

    final notesById = <String, NoteEntity>{
      for (final note in notes) note.id: note,
    };

    _paintLines(canvas: canvas, notesById: notesById);

    _paintStars(canvas);
  }

  // ----------------------------------------------------------------------
  // 🧵 LINES
  // ----------------------------------------------------------------------

  void _paintLines({
    required Canvas canvas,
    required Map<String, NoteEntity> notesById,
  }) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppWidgetsSizes.constellationWidth
      ..strokeCap = StrokeCap.round
      ..color = lineColor;

    for (final line in lines) {
      final fromNote = notesById[line.fromNoteId];
      final toNote = notesById[line.toNoteId];

      if (fromNote == null || toNote == null) {
        continue;
      }

      canvas.drawLine(
        Offset(fromNote.positionX, fromNote.positionY),
        Offset(toNote.positionX, toNote.positionY),
        paint,
      );
    }
  }

  // ----------------------------------------------------------------------
  // ⭐ STARS
  // ----------------------------------------------------------------------

  void _paintStars(Canvas canvas) {
    final pictures = starPictures;
    final loneStar = loneStarPicture;

    if (pictures == null || loneStar == null) {
      return;
    }

    final starSize = AppWidgetsSizes.starRadius * 2;

    for (final note in notes) {
      final picture = note.starVariant == 5
          ? loneStar
          : pictures[note.starVariant];

      if (picture == null) {
        continue;
      }

      final destination = Rect.fromCenter(
        center: Offset(note.positionX, note.positionY),
        width: starSize,
        height: starSize,
      );

      final source = Rect.fromLTWH(
        0,
        0,
        picture.size.width,
        picture.size.height,
      );

      final scaleX = destination.width / source.width;
      final scaleY = destination.height / source.height;

      canvas.save();

      canvas.translate(destination.left, destination.top);

      canvas.scale(scaleX, scaleY);

      canvas.drawPicture(picture.picture);

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ConstellationPainter oldDelegate) {
    return oldDelegate.notes != notes ||
        oldDelegate.lines != lines ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.starPictures != starPictures ||
        oldDelegate.loneStarPicture != loneStarPicture;
  }
}
