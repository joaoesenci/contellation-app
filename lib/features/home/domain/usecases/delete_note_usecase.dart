import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

final class DeleteNoteParams {
  final List<String> notesId;

  const DeleteNoteParams({required this.notesId});
}

final class DeleteNoteUsecase implements Usecase<Unit, DeleteNoteParams> {
  final IHomeRepository _repository;

  DeleteNoteUsecase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteNoteParams params) {
    return _repository.deleteNote(params.notesId);
  }
}
