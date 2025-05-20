import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

/// حالات المصادقة
abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

/// حالة التحميل
class AuthLoadingState extends AuthState {}

/// حالة عدم المصادقة
class AuthUnauthenticatedState extends AuthState {}

/// حالة المصادقة
class AuthAuthenticatedState extends AuthState {
  final User? user;
  
  const AuthAuthenticatedState({this.user});
  
  @override
  List<Object?> get props => [user];
}

/// حالة الخطأ
class AuthErrorState extends AuthState {
  final String message;
  
  const AuthErrorState({required this.message});
  
  @override
  List<Object> get props => [message];
}
