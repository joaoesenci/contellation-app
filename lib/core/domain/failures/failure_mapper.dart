import 'package:constellation_app/core/domain/failures/exeptions.dart';
import 'package:constellation_app/core/domain/failures/failures.dart';

Failure mapExceptionFailure(Object exception) {
  switch (exception) {
    case ParseException():
      return const ParseFailure();

    case CacheException():
      return const CacheFailure();

    default:
      return const UnknownFailure();
  }
}
