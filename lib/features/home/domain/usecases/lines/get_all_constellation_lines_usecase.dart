import 'package:constellation_app/core/domain/entities/constellation_line_entity.dart';
import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

final class GetAllConstellationLinesUsecase
    implements Usecase<List<ConstellationLineEntity>, NoParams> {
  final IHomeRepository _repository;

  GetAllConstellationLinesUsecase(this._repository);

  @override
  Future<Either<Failure, List<ConstellationLineEntity>>> call(NoParams params) {
    return _repository.getAllConstellationLines();
  }
}
