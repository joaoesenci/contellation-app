import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

final class GetAllNotesUsecase implements Usecase<List<NoteEntity>, NoParams> {
  final IHomeRepository _repository;

  GetAllNotesUsecase(this._repository);

  @override
  Future<Either<Failure, List<NoteEntity>>> call(NoParams params) {
    return _repository.getAllNotes();
  }
}
