import 'package:equatable/equatable.dart';

/// فشل أساسي
abstract class Failure extends Equatable {
  final String message;
  
  const Failure({required this.message});
  
  @override
  List<Object> get props => [message];
}

/// فشل الخادم
class ServerFailure extends Failure {
  final int? statusCode;
  
  const ServerFailure({required String message, this.statusCode}) 
      : super(message: message);
  
  @override
  List<Object> get props => [message, statusCode ?? 0];
}

/// فشل الاتصال
class ConnectionFailure extends Failure {
  const ConnectionFailure({required String message}) 
      : super(message: message);
}

/// فشل التخزين المحلي
class CacheFailure extends Failure {
  const CacheFailure({required String message}) 
      : super(message: message);
}

/// فشل المصادقة
class AuthFailure extends Failure {
  const AuthFailure({required String message}) 
      : super(message: message);
}

/// فشل المدخلات
class InputFailure extends Failure {
  const InputFailure({required String message}) 
      : super(message: message);
}
