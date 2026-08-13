import 'dart:math' as math;

import 'package:constellation_app/core/domain/entities/constellation_line_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/features/home/presentation/components/widgets/home_page/constellation_canvas/constellation_painter.dart';
import 'package:constellation_app/shared/constants/app_images.dart';
import 'package:constellation_app/shared/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

final class ConstellationCanvas extends StatefulWidget {
  final List<NoteEntity> notes;
  final List<ConstellationLineEntity> lines;

  const ConstellationCanvas({
    super.key,
    required this.notes,
    required this.lines,
  });

  @override
  State<ConstellationCanvas> createState() => _ConstellationCanvasState();
}

final class _ConstellationCanvasState extends State<ConstellationCanvas> {
  static const double _canvasPadding = 240.0;
  static const double _minimumWorldSize = 1000.0;

  late final TransformationController _transformationController;

  Map<int, PictureInfo>? _starPictures;
  PictureInfo? _loneStarPicture;

  @override
  void initState() {
    super.initState();

    _transformationController = TransformationController();

    _loadStarAssets();
  }

  @override
  void dispose() {
    _transformationController.dispose();

    _disposeStarPictures();

    super.dispose();
  }

  Future<void> _loadStarAssets() async {
    final pictures = <int, PictureInfo>{};

    for (var variant = 1; variant <= 4; variant++) {
      final picture = await vg.loadPicture(
        SvgAssetLoader(_getStarAsset(variant)),
        null,
      );

      pictures[variant] = picture;
    }

    final loneStarPicture = await vg.loadPicture(
      const SvgAssetLoader(AppImages.loneStar),
      null,
    );

    if (!mounted) {
      for (final picture in pictures.values) {
        picture.picture.dispose();
      }

      loneStarPicture.picture.dispose();

      return;
    }

    setState(() {
      _starPictures = pictures;
      _loneStarPicture = loneStarPicture;
    });
  }

  String _getStarAsset(int variant) {
    return switch (variant) {
      1 => AppImages.star1,
      2 => AppImages.star2,
      3 => AppImages.star3,
      4 => AppImages.star4,
      _ => AppImages.loneStar,
    };
  }

  void _disposeStarPictures() {
    final pictures = _starPictures;

    if (pictures != null) {
      for (final picture in pictures.values) {
        picture.picture.dispose();
      }
    }

    _loneStarPicture?.picture.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bounds = _calculateBounds(widget.notes);

    return Positioned.fill(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final viewportSize = Size(
            constraints.maxWidth,
            constraints.maxHeight,
          );

          final worldSize = _calculateWorldSize(
            bounds: bounds,
            viewportSize: viewportSize,
          );

          return InteractiveViewer(
            transformationController: _transformationController,
            minScale: 0.35,
            maxScale: 2.5,
            constrained: false,
            boundaryMargin: const EdgeInsets.all(_canvasPadding),
            child: SizedBox(
              width: worldSize.width,
              height: worldSize.height,
              child: CustomPaint(
                painter: ConstellationPainter(
                  notes: widget.notes,
                  lines: widget.lines,
                  lineColor: context.colors.tertiary,
                  starPictures: _starPictures,
                  loneStarPicture: _loneStarPicture,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _ConstellationBounds _calculateBounds(List<NoteEntity> notes) {
    if (notes.isEmpty) {
      return const _ConstellationBounds.empty();
    }

    var minX = notes.first.positionX;
    var maxX = notes.first.positionX;
    var minY = notes.first.positionY;
    var maxY = notes.first.positionY;

    for (final note in notes.skip(1)) {
      minX = math.min(minX, note.positionX);
      maxX = math.max(maxX, note.positionX);
      minY = math.min(minY, note.positionY);
      maxY = math.max(maxY, note.positionY);
    }

    return _ConstellationBounds(minX: minX, maxX: maxX, minY: minY, maxY: maxY);
  }

  Size _calculateWorldSize({
    required _ConstellationBounds bounds,
    required Size viewportSize,
  }) {
    final contentWidth = bounds.width + (_canvasPadding * 2);
    final contentHeight = bounds.height + (_canvasPadding * 2);

    return Size(
      math.max(contentWidth, math.max(viewportSize.width, _minimumWorldSize)),
      math.max(contentHeight, math.max(viewportSize.height, _minimumWorldSize)),
    );
  }
}

final class _ConstellationBounds {
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;

  const _ConstellationBounds({
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
  });

  const _ConstellationBounds.empty() : minX = 0, maxX = 0, minY = 0, maxY = 0;

  double get width => maxX - minX;

  double get height => maxY - minY;
}
