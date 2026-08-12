import 'package:constellation_app/core/domain/entities/note_entity.dart';

final class NoteModel extends NoteEntity {
  const NoteModel({
    required super.id,
    required super.constellationId,
    required super.title,
    required super.text,
    required super.date,
    required super.starIconPath,
    required super.positionX,
    required super.positionY,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] as int,
      constellationId: map['constellationId'] as String,
      title: map['title'] as String,
      text: map['text'] as String,
      date: DateTime.parse(map['date'] as String),
      starIconPath: map['starIconPath'],
      positionX: map['positionX'] as double,
      positionY: map['positionY'] as double,
    );
  }

  factory NoteModel.fromEntity(NoteEntity entity) {
    return NoteModel(
      id: entity.id ?? DateTime.now().millisecondsSinceEpoch,
      constellationId: entity.constellationId,
      title: entity.title,
      text: entity.text,
      date: entity.date,
      starIconPath: entity.starIconPath,
      positionX: entity.positionX,
      positionY: entity.positionY,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'constellationId': constellationId,
      'title': title,
      'text': text,
      'date': date.toIso8601String(),
      'starIconPath': starIconPath,
      'positionX': positionX,
      'positionY': positionY,
    };
  }
}
