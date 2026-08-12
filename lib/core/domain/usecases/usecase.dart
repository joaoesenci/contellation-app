import 'package:constellation_app/core/domain/failures/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}

final class NoParams {
  const NoParams();
}

const noParams = NoParams();
