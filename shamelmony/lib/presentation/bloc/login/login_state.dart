import 'package:equatable/equatable.dart';

/// حالات تسجيل الدخول
abstract class LoginState extends Equatable {
  const LoginState();
  
  @override
  List<Object?> get props => [];
}

/// حالة البداية
class LoginInitialState extends LoginState {}

/// حالة التحميل
class LoginLoadingState extends LoginState {}

/// حالة النجاح
class LoginSuccessState extends LoginState {
  final String token;
  
  const LoginSuccessState({required this.token});
  
  @override
  List<Object> get props => [token];
}

/// حالة الخطأ
class LoginErrorState extends LoginState {
  final String message;
  
  const LoginErrorState({required this.message});
  
  @override
  List<Object> get props => [message];
}
