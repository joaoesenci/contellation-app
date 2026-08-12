import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/failures/failure_mapper.dart';
import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:constellation_app/core/infra/models/note_model.dart';
import 'package:constellation_app/features/home/domain/repositories/home_repository.dart';
import 'package:constellation_app/features/home/infra/datasources/home_datasource.dart';
import 'package:fpdart/fpdart.dart';

final class HomeRepositoryImpl implements IHomeRepository {
  final IHomeDatasource _datasource;

  HomeRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, List<ConstellationEntity>>>
  getFixedConstellations() async {
    try {
      final List<ConstellationEntity> constellations =
          await _datasource.getFixedConstellations();

      return right(constellations);
    } catch (e) {
      return left(mapExceptionFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveNote(NoteEntity note) async {
    try {
      await _datasource.saveNote(NoteModel.fromEntity(note));

      return right(unit);
    } catch (e) {
      return left(mapExceptionFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getAllNotes() async {
    try {
      final List<NoteEntity> notes = await _datasource.getAllNotes();

      return right(notes);
    } catch (e) {
      return left(mapExceptionFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(List<int> notesId) async {
    try {
      await _datasource.deleteNote(notesId);

      return right(unit);
    } catch (e) {
      return left(mapExceptionFailure(e));
    }
  }
}
