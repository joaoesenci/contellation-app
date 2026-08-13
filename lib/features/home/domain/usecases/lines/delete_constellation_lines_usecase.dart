import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

final class DeleteConstellationLinesParams {
  final List<String> linesId;

  const DeleteConstellationLinesParams({required this.linesId});
}

final class DeleteConstellationLinesUsecase
    implements Usecase<Unit, DeleteConstellationLinesParams> {
  final IHomeRepository _repository;

  DeleteConstellationLinesUsecase(this._repository);

  @override
  Future<Either<Failure, Unit>> call(DeleteConstellationLinesParams params) {
    return _repository.deleteConstellationLines(params.linesId);
  }
}
