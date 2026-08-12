class NoteEntity {
  final int? id;
  final String? constellationId;
  final String title;
  final String text;
  final DateTime date;
  final String starIconPath;
  final double positionX;
  final double positionY;

  const NoteEntity({
    required this.id,
    this.constellationId,
    required this.title,
    required this.text,
    required this.date,
    required this.starIconPath,
    required this.positionX,
    required this.positionY,
  });
}
