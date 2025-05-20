/// استثناء الخادم
class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});
}

/// استثناء عدم وجود اتصال بالإنترنت
class NoInternetException implements Exception {
  final String message;

  NoInternetException({required this.message});
}

/// استثناء عدم وجود بيانات محلية
class CacheException implements Exception {
  final String message;

  CacheException({required this.message});
}

/// استثناء المصادقة
class AuthException implements Exception {
  final String message;

  AuthException({required this.message});
}

/// استثناء المدخلات غير الصالحة
class InvalidInputException implements Exception {
  final String message;

  InvalidInputException({required this.message});
}
