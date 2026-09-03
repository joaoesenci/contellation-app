import 'package:constellation_app/core/domain/entities/constellation_region_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/constellation_canvas/constellation_painter.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/constellation_canvas/constellation_star.dart';
import 'package:flutter/material.dart';

final class ConstellationCanvas extends StatefulWidget {
  final List<NoteEntity> notes;
  final List<ConstellationRegionEntity> regions;
  final Rect universeBounds;

  const ConstellationCanvas({
    super.key,
    required this.notes,
    required this.regions,
    required this.universeBounds,
  });

  @override
  State<ConstellationCanvas> createState() => _ConstellationCanvasState();
}

final class _ConstellationCanvasState extends State<ConstellationCanvas> {
  static const double _minScale = 0.55;
  static const double _maxScale = 2.5;
  static const double _boundaryMargin = 200;

  late final TransformationController _transformationController;

  @override
  void initState() {
    super.initState();

    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final universe = widget.universeBounds;

    if (universe == Rect.zero) {
      return const SizedBox.expand();
    }

    return SizedBox.expand(
      child: InteractiveViewer(
        transformationController: _transformationController,
        minScale: _minScale,
        maxScale: _maxScale,
        boundaryMargin: const EdgeInsets.all(_boundaryMargin),
        constrained: false,
        child: SizedBox(
          width: universe.width,
          height: universe.height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CustomPaint(
                size: Size(universe.width, universe.height),
                painter: ConstellationPainter(
                  notes: widget.notes,
                  regions: widget.regions,
                  universeBounds: universe,
                ),
              ),

              ...widget.notes.map((note) {
                final left = note.positionX - universe.left;

                final top = note.positionY - universe.top;

                return Positioned(
                  left: left,
                  top: top,
                  width: 40,
                  height: 40,
                  child: ConstellationStar(note: note),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
