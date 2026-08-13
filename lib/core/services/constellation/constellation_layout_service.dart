import 'dart:math';

import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/shared/constants/app_strings.dart';
import 'package:constellation_app/shared/themes/themes.dart';

final class ConstellationLayoutService {
  static const List<double> _directions = [
    0,
    pi / 4,
    pi / 2,
    3 * pi / 4,
    pi,
    5 * pi / 4,
    3 * pi / 2,
    7 * pi / 4,
  ];

  ({double x, double y}) findPosition({
    required String? constellationId,
    required List<NoteEntity> existingNotes,
  }) {
    final constellationNotes = existingNotes
        .where(
          (existingNote) => existingNote.constellationId == constellationId,
        )
        .toList(growable: false);

    if (constellationNotes.isEmpty) {
      return _getAnchorPosition(constellationId);
    }

    return _findPositionAroundCluster(constellationNotes);
  }

  ({double x, double y}) _getAnchorPosition(String? constellationId) {
    switch (constellationId) {
      case AppStrings.driftingThoughtsId:
        return (x: -300, y: -200);

      case AppStrings.quietMomentsId:
        return (x: 300, y: -200);

      case AppStrings.tomorrowsOrbitId:
        return (x: -300, y: 200);

      case AppStrings.deepFocusId:
        return (x: 300, y: 200);

      default:
        return (x: 0, y: 0);
    }
  }

  ({double x, double y}) _findPositionAroundCluster(
    List<NoteEntity> constellationNotes,
  ) {
    final center = _calculateClusterCenter(constellationNotes);

    for (
      var radius = _idealDistance;
      radius <= _maxSearchDistance;
      radius += AppWidgetsSizes.searchStep
    ) {
      for (final direction in _directions) {
        final candidate = (
          x: center.x + cos(direction) * radius,
          y: center.y + sin(direction) * radius,
        );

        if (_isValidPosition(
          candidate: candidate,
          existingNotes: constellationNotes,
        )) {
          return candidate;
        }
      }
    }

    return _getFallbackPosition(
      center: center,
      existingNotes: constellationNotes,
    );
  }

  ({double x, double y}) _calculateClusterCenter(
    List<NoteEntity> constellationNotes,
  ) {
    var totalX = 0.0;
    var totalY = 0.0;

    for (final note in constellationNotes) {
      totalX += note.positionX;
      totalY += note.positionY;
    }

    return (
      x: totalX / constellationNotes.length,
      y: totalY / constellationNotes.length,
    );
  }

  bool _isValidPosition({
    required ({double x, double y}) candidate,
    required List<NoteEntity> existingNotes,
  }) {
    for (final note in existingNotes) {
      final dx = candidate.x - note.positionX;
      final dy = candidate.y - note.positionY;

      final distanceSquared = dx * dx + dy * dy;

      if (distanceSquared < _minimumDistanceSquared) {
        return false;
      }
    }

    return true;
  }

  ({double x, double y}) _getFallbackPosition({
    required ({double x, double y}) center,
    required List<NoteEntity> existingNotes,
  }) {
    var radius = _maxSearchDistance;

    while (true) {
      for (final direction in _directions) {
        final candidate = (
          x: center.x + cos(direction) * radius,
          y: center.y + sin(direction) * radius,
        );

        if (_isValidPosition(
          candidate: candidate,
          existingNotes: existingNotes,
        )) {
          return candidate;
        }
      }

      radius += AppWidgetsSizes.searchStep;
    }
  }

  double get _minimumDistance =>
      AppWidgetsSizes.starRadius * 2 + AppWidgetsSizes.minimumGap;

  double get _minimumDistanceSquared => _minimumDistance * _minimumDistance;

  double get _idealDistance =>
      AppWidgetsSizes.starRadius * 2 + AppWidgetsSizes.idealGap;

  double get _maxSearchDistance =>
      _idealDistance + AppWidgetsSizes.searchStep * 10;
}
