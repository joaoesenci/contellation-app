import 'package:constellation_app/core/domain/entities/note_entity.dart';
import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

final class SaveNoteParams {
  final String title;
  final String text;
  final int starVariant;
  final String? id;
  final String? constellationId;
  final double positionX;
  final double positionY;

  const SaveNoteParams({
    required this.title,
    required this.text,
    required this.starVariant,
    required this.id,
    required this.constellationId,
    required this.positionX,
    required this.positionY,
  });
}

final class SaveNoteUsecase implements Usecase<Unit, SaveNoteParams> {
  final IHomeRepository _repository;

  SaveNoteUsecase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(SaveNoteParams params) {
    final note = NoteEntity(
      id: params.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      constellationId: params.constellationId,
      title: params.title,
      text: params.text,
      date: DateTime.now(),
      starVariant: params.starVariant,
      positionX: params.positionX,
      positionY: params.positionY,
    );

    return _repository.saveNote(note);
  }
}
