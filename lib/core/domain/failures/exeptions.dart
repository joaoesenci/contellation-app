sealed class AppException implements Exception {
  final String? message;

  const AppException({this.message});
}

final class ParseException extends AppException {
  const ParseException({super.message});
}

final class CacheException extends AppException {
  const CacheException({super.message});
}

final class UnknownException extends AppException {
  const UnknownException({super.message});
}
