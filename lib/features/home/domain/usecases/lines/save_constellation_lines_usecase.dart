import 'package:constellation_app/core/domain/entities/constellation_line_entity.dart';
import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

final class SaveConstellationLinesParams {
  final List<ConstellationLineEntity> lines;

  const SaveConstellationLinesParams({required this.lines});
}

final class SaveConstellationLinesUsecase
    implements Usecase<Unit, SaveConstellationLinesParams> {
  final IHomeRepository _repository;

  SaveConstellationLinesUsecase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(SaveConstellationLinesParams params) {
    return _repository.saveConstellationLines(params.lines);
  }
}
