import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

/// حالة استخدام تسجيل الدخول
@injectable
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  /// تنفيذ حالة الاستخدام
  /// 
  /// يقوم بتسجيل دخول المستخدم باستخدام المعلومات المقدمة
  /// 
  /// يعيد [Either] إما [Failure] في حالة الفشل أو [String] (token) في حالة النجاح
  Future<Either<Failure, String>> call(LoginParams params) {
    return repository.login(
      username: params.username,
      password: params.password,
      deviceIMEI: params.deviceIMEI,
      deviceName: params.deviceName,
    );
  }
}

/// معلمات تسجيل الدخول
class LoginParams extends Equatable {
  final String username;
  final String password;
  final String deviceIMEI;
  final String deviceName;

  const LoginParams({
    required this.username,
    required this.password,
    required this.deviceIMEI,
    required this.deviceName,
  });

  @override
  List<Object> get props => [username, password, deviceIMEI, deviceName];
}
