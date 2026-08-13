import 'package:constellation_app/core/domain/entities/constellation_line_entity.dart';

final class ConstellationLineModel extends ConstellationLineEntity {
  const ConstellationLineModel({
    required super.id,
    required super.fromNoteId,
    required super.toNoteId,
  });

  factory ConstellationLineModel.fromEntity(ConstellationLineEntity entity) {
    return ConstellationLineModel(
      id: entity.id,
      fromNoteId: entity.fromNoteId,
      toNoteId: entity.toNoteId,
    );
  }

  factory ConstellationLineModel.fromMap(Map<String, dynamic> map) {
    return ConstellationLineModel(
      id: map['id'] as String,
      fromNoteId: map['fromNoteId'] as String,
      toNoteId: map['toNoteId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'fromNoteId': fromNoteId, 'toNoteId': toNoteId};
  }
}
