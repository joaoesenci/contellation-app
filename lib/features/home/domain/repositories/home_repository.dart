import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/core/domain/entities/constellation_line_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IHomeRepository {
  // ------------------------------------------------------------
  // ⭐ CONSTELLATIONS
  // ------------------------------------------------------------
  Future<Either<Failure, List<ConstellationEntity>>> getFixedConstellations();

  // ------------------------------------------------------------
  // 📝 NOTES
  // ------------------------------------------------------------
  Future<Either<Failure, Unit>> saveNote(NoteEntity note);
  Future<Either<Failure, List<NoteEntity>>> getAllNotes();
  Future<Either<Failure, Unit>> deleteNote(List<String> notesId);

  // ------------------------------------------------------------
  // 🧵 CONSTELLATION LINES
  // ------------------------------------------------------------
  Future<Either<Failure, Unit>> saveConstellationLines(
    List<ConstellationLineEntity> lines,
  );
  Future<Either<Failure, List<ConstellationLineEntity>>>
  getAllConstellationLines();
  Future<Either<Failure, Unit>> deleteConstellationLines(List<String> linesId);
}
