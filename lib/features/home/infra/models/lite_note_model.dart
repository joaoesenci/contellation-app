import 'package:constellation_app/features/home/domain/entities/lite_note_entity.dart';

final class LiteNoteModel extends LiteNoteEntity {
  const LiteNoteModel({
    required super.id,
    required super.constellationId,
    required super.title,
    required super.positionX,
    required super.positionY,
  });
}
