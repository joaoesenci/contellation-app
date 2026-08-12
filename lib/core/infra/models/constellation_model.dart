import 'package:constellation_app/core/domain/entities/constellation_entity.dart';

final class ConstellationModel extends ConstellationEntity {
  const ConstellationModel({
    required super.id,
    required super.name,
    required super.description,
    required super.firstExample,
    required super.secondExample,
    required super.icon,
  });
}
