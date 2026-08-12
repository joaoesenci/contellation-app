import 'package:constellation_app/core/domain/entities/constellation_entity.dart';
import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:constellation_app/core/domain/usecases/usecase.dart';
import 'package:constellation_app/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

final class GetFixedConstellationsUsecase
    implements Usecase<List<ConstellationEntity>, NoParams> {
  final IHomeRepository _repository;

  GetFixedConstellationsUsecase(this._repository);

  @override
  Future<Either<Failure, List<ConstellationEntity>>> call(NoParams params) {
    return _repository.getFixedConstellations();
  }
}
