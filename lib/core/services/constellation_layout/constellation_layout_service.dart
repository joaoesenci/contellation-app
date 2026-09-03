import 'dart:ui';

import 'package:constellation_app/core/domain/entities/constellation_region_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';

abstract interface class IConstellationLayoutService {
  Offset calculateInitialStarPosition({required String constellationId});
  Offset calculateNewStarPosition({
    required List<NoteEntity> notes,
    required List<ConstellationRegionEntity> otherRegions,
  });
  Offset calculateLoneStarPosition({
    required List<ConstellationRegionEntity> regions,
    required List<NoteEntity> loneStars,
  });

  Rect calculateConstellationBoundingBox({required List<NoteEntity> notes});
  ConstellationRegionEntity calculateConstellationRegion({
    required String constellationId,
    required List<NoteEntity> notes,
  });

  Rect calculateUniverseBoundingBox({
    required List<ConstellationRegionEntity> regions,
    required List<NoteEntity> loneStars,
  });
}
