import 'dart:ui';

final class ConstellationRegionEntity {
  final String constellationId;
  final Rect bounds;

  const ConstellationRegionEntity({
    required this.constellationId,
    required this.bounds,
  });
}
