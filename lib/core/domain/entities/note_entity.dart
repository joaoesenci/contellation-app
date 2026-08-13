class NoteEntity {
  final String id;
  final String? constellationId;
  final String title;
  final String text;
  final DateTime date;
  final int starVariant;
  final double positionX;
  final double positionY;

  const NoteEntity({
    required this.id,
    required this.constellationId,
    required this.title,
    required this.text,
    required this.date,
    required this.starVariant,
    required this.positionX,
    required this.positionY,
  });
}
