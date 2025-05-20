import 'package:equatable/equatable.dart';

/// أحداث المصادقة
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// حدث التحقق من حالة المصادقة
class CheckAuthStatusEvent extends AuthEvent {}

/// حدث تسجيل الخروج
class LogoutEvent extends AuthEvent {}
