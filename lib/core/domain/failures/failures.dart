import 'package:constellation_app/shared/constants/app_strings.dart';

abstract interface class Failure {
  final String? message;

  const Failure({required this.message});
}

class ParseFailure extends Failure {
  const ParseFailure({super.message = AppStrings.parseFailure});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = AppStrings.cacheFailure});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = AppStrings.unknownFailure});
}
