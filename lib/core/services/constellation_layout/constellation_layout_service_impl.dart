import 'dart:math' as math;
import 'dart:ui';

import 'package:constellation_app/core/domain/entities/constellation_region_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/services/constellation_layout/constellation_layout_config.dart';
import 'package:constellation_app/core/services/constellation_layout/constellation_layout_service.dart';
import 'package:constellation_app/shared/constants/app_strings.dart';

final class ConstellationLayoutServiceImpl
    implements IConstellationLayoutService {
  const ConstellationLayoutServiceImpl();

  static const double _starSize = ConstellationLayoutConfig.starSize;

  // ---------------------------------------------------------------------------
  // PUBLIC
  // ---------------------------------------------------------------------------

  @override
  Offset calculateInitialStarPosition({required String constellationId}) {
    return _getInitialConstellationPosition(constellationId: constellationId);
  }

  @override
  Offset calculateNewStarPosition({
    required List<NoteEntity> notes,
    required List<ConstellationRegionEntity> otherRegions,
  }) {
    if (notes.isEmpty) {
      throw ArgumentError(
        'Cannot calculate a new star position without existing notes.',
      );
    }

    return _findFreePosition(notes: notes, otherRegions: otherRegions);
  }

  @override
  Offset calculateLoneStarPosition({
    required List<ConstellationRegionEntity> regions,
    required List<NoteEntity> loneStars,
  }) {
    return _findFreeLoneStarPosition(regions: regions, loneStars: loneStars);
  }

  @override
  ConstellationRegionEntity calculateConstellationRegion({
    required String constellationId,
    required List<NoteEntity> notes,
  }) {
    return ConstellationRegionEntity(
      constellationId: constellationId,
      bounds: calculateConstellationBoundingBox(notes: notes),
    );
  }

  @override
  Rect calculateConstellationBoundingBox({required List<NoteEntity> notes}) {
    if (notes.isEmpty) {
      return Rect.zero;
    }

    final contentBounds = _calculateConstellationContentBounds(notes);

    return contentBounds.inflate(
      ConstellationLayoutConfig.constellationPadding,
    );
  }

  @override
  Rect calculateUniverseBoundingBox({
    required List<ConstellationRegionEntity> regions,
    required List<NoteEntity> loneStars,
  }) {
    Rect? universeBounds;

    for (final region in regions) {
      universeBounds = universeBounds == null
          ? region.bounds
          : universeBounds.expandToInclude(region.bounds);
    }

    for (final loneStar in loneStars) {
      final starBounds = _getStarBounds(loneStar);

      universeBounds = universeBounds == null
          ? starBounds
          : universeBounds.expandToInclude(starBounds);
    }

    if (universeBounds == null) {
      return Rect.zero;
    }

    return universeBounds.inflate(ConstellationLayoutConfig.universePadding);
  }

  // ---------------------------------------------------------------------------
  // PRIVATE
  // ---------------------------------------------------------------------------
  Offset _findFreePosition({
    required List<NoteEntity> notes,
    required List<ConstellationRegionEntity> otherRegions,
  }) {
    final bounds = _calculateConstellationContentBounds(notes);

    final constellationCenter = bounds.center;

    final growthDirection = _getGrowthDirection(
      constellationCenter: constellationCenter,
    );

    final perpendicular = Offset(-growthDirection.dy, growthDirection.dx);

    final candidates = <_PositionCandidate>[];

    for (var ring = 1; ring <= 12; ring++) {
      final baseDistance = ConstellationLayoutConfig.starSpacing * ring;

      final distanceVariation =
          ConstellationLayoutConfig.starSpacing * math.min(ring * 0.35, 2.5);

      for (var i = 0; i < 16; i++) {
        final normalized = i / 16.0;

        final baseAngle = math.atan2(growthDirection.dy, growthDirection.dx);

        final angleVariation = (normalized - 0.5) * math.pi * 0.85;

        final angle = baseAngle + angleVariation;

        final distanceOffset =
            math.sin(i * 2.7 + ring * 1.37) * distanceVariation;

        final distance = math.max(
          ConstellationLayoutConfig.starSpacing * 0.75,
          baseDistance + distanceOffset,
        );

        final organicOffset =
            math.sin(i * 3.17 + ring * 0.91) *
            ConstellationLayoutConfig.starSpacing *
            0.55;

        final candidate =
            Offset(
              constellationCenter.dx + math.cos(angle) * distance,
              constellationCenter.dy + math.sin(angle) * distance,
            ) +
            perpendicular * organicOffset;

        if (!_isPositionAvailable(
          candidate: candidate,
          notes: notes,
          otherRegions: otherRegions,
        )) {
          continue;
        }

        final score = _scoreCandidate(
          candidate: candidate,
          notes: notes,
          constellationCenter: constellationCenter,
          growthDirection: growthDirection,
        );

        candidates.add(_PositionCandidate(position: candidate, score: score));
      }

      if (candidates.length >= 12) {
        break;
      }
    }

    if (candidates.isEmpty) {
      throw StateError('Unable to find a free position for the new star.');
    }

    candidates.sort((a, b) => b.score.compareTo(a.score));

    final selectionCount = math.min(3, candidates.length);

    final selectedIndex = notes.length % selectionCount;

    return candidates[selectedIndex].position;
  }

  double _scoreCandidate({
    required Offset candidate,
    required List<NoteEntity> notes,
    required Offset constellationCenter,
    required Offset growthDirection,
  }) {
    double nearestDistance = double.infinity;

    for (final note in notes) {
      final starCenter = _getStarBounds(note).center;

      final distance = (candidate - starCenter).distance;

      if (distance < nearestDistance) {
        nearestDistance = distance;
      }
    }

    final idealDistance = ConstellationLayoutConfig.starSpacing * 1.8;

    final distanceDifference = (nearestDistance - idealDistance).abs();

    final distanceScore = 1.0 / (1.0 + distanceDifference);

    final candidateDirection = candidate - constellationCenter;

    double directionScore = 0;

    if (candidateDirection.distance > 0) {
      final normalizedCandidate =
          candidateDirection / candidateDirection.distance;

      final dot =
          normalizedCandidate.dx * growthDirection.dx +
          normalizedCandidate.dy * growthDirection.dy;

      directionScore = (dot + 1) / 2;
    }

    final distanceFromCenter = (candidate - constellationCenter).distance;

    final compactnessScore = 1.0 / (1.0 + distanceFromCenter * 0.003);

    return distanceScore * 5.0 + directionScore * 1.5 + compactnessScore * 2.0;
  }

  Offset _findFreeLoneStarPosition({
    required List<ConstellationRegionEntity> regions,
    required List<NoteEntity> loneStars,
  }) {
    final origin = ConstellationLayoutConfig.universeCenter;

    const candidatesPerRing = 16;

    for (var ring = 1; ring <= 30; ring++) {
      final radius = ring * ConstellationLayoutConfig.loneStarSpacing;

      for (var i = 0; i < candidatesPerRing; i++) {
        final angle = (2 * math.pi / candidatesPerRing) * i;

        final candidate = Offset(
          origin.dx + math.cos(angle) * radius,
          origin.dy + math.sin(angle) * radius,
        );

        if (_isLoneStarPositionAvailable(
          candidate: candidate,
          regions: regions,
          loneStars: loneStars,
        )) {
          return candidate;
        }
      }
    }

    throw StateError('Unable to find a free position for the Lone Star.');
  }

  bool _isPositionAvailable({
    required Offset candidate,
    required List<NoteEntity> notes,
    required List<ConstellationRegionEntity> otherRegions,
  }) {
    final candidateBounds = Rect.fromLTWH(
      candidate.dx,
      candidate.dy,
      _starSize,
      _starSize,
    );

    final protectedCandidateBounds = candidateBounds.inflate(
      ConstellationLayoutConfig.starSpacing / 2,
    );

    for (final note in notes) {
      final noteBounds = _getStarBounds(note);

      if (protectedCandidateBounds.overlaps(noteBounds)) {
        return false;
      }
    }

    for (final region in otherRegions) {
      if (protectedCandidateBounds.overlaps(region.bounds)) {
        return false;
      }
    }

    return true;
  }

  bool _isLoneStarPositionAvailable({
    required Offset candidate,
    required List<ConstellationRegionEntity> regions,
    required List<NoteEntity> loneStars,
  }) {
    final candidateBounds = Rect.fromLTWH(
      candidate.dx,
      candidate.dy,
      _starSize,
      _starSize,
    );

    final protectedCandidateBounds = candidateBounds.inflate(
      ConstellationLayoutConfig.loneStarSpacing / 2,
    );

    for (final region in regions) {
      if (protectedCandidateBounds.overlaps(region.bounds)) {
        return false;
      }
    }

    for (final loneStar in loneStars) {
      final loneStarBounds = _getStarBounds(loneStar);

      if (protectedCandidateBounds.overlaps(loneStarBounds)) {
        return false;
      }
    }

    return true;
  }

  Offset _getGrowthDirection({required Offset constellationCenter}) {
    final direction =
        ConstellationLayoutConfig.universeCenter - constellationCenter;

    if (direction == Offset.zero) {
      return const Offset(1, 0);
    }

    return direction / direction.distance;
  }

  Offset _getInitialConstellationPosition({required String constellationId}) {
    switch (constellationId) {
      case AppStrings.driftingThoughtsId:
        return ConstellationLayoutConfig.driftingThoughtsPosition;

      case AppStrings.quietMomentsId:
        return ConstellationLayoutConfig.quietMomentsPosition;

      case AppStrings.tomorrowsOrbitId:
        return ConstellationLayoutConfig.tomorrowsOrbitPosition;

      case AppStrings.deepFocusId:
        return ConstellationLayoutConfig.deepFocusPosition;

      default:
        throw ArgumentError('Constellation ID not supported: $constellationId');
    }
  }

  Rect _calculateConstellationContentBounds(List<NoteEntity> notes) {
    Rect contentBounds = _getStarBounds(notes.first);

    for (final note in notes.skip(1)) {
      contentBounds = contentBounds.expandToInclude(_getStarBounds(note));
    }

    return contentBounds;
  }

  Rect _getStarBounds(NoteEntity note) {
    return Rect.fromLTWH(note.positionX, note.positionY, _starSize, _starSize);
  }
}

final class _PositionCandidate {
  final Offset position;
  final double score;

  const _PositionCandidate({required this.position, required this.score});
}
