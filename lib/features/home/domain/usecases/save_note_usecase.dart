import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

final class SaveNoteParams {
  final String title;
  final String text;
  final String starIconPath;
  final int? id;
  final String? constellationId;

  const SaveNoteParams({
    required this.title,
    required this.text,
    required this.starIconPath,
    required this.id,
    required this.constellationId,
  });
}

final class SaveNoteUsecase implements Usecase<Unit, SaveNoteParams> {
  final IHomeRepository _repository;

  SaveNoteUsecase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(SaveNoteParams params) {
    final note = NoteEntity(
      id: params.id,
      constellationId: params.constellationId ?? '',
      title: params.title,
      text: params.text,
      date: DateTime.now(),
      starIconPath: params.starIconPath,
      positionX: 0,
      positionY: 0,
    );

    return _repository.saveNote(note);
  }
}
