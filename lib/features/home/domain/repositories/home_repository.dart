import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class IHomeRepository {
  Future<Either<Failure, List<ConstellationEntity>>> getFixedConstellations();
  Future<Either<Failure, Unit>> saveNote(NoteEntity note);
  Future<Either<Failure, List<NoteEntity>>> getAllNotes();
  Future<Either<Failure, Unit>> deleteNote(List<int> notesId);
}
