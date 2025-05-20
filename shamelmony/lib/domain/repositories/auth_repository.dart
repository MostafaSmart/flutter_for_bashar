import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/user.dart';

/// واجهة مستودع المصادقة
abstract class AuthRepository {
  /// تسجيل الدخول
  /// 
  /// يقوم بتسجيل دخول المستخدم باستخدام اسم المستخدم وكلمة المرور ومعلومات الجهاز
  /// 
  /// يعيد [Either] إما [Failure] في حالة الفشل أو [String] (token) في حالة النجاح
  Future<Either<Failure, String>> login({
    required String username,
    required String password,
    required String deviceIMEI,
    required String deviceName,
  });
  
  /// الحصول على المستخدم الحالي
  /// 
  /// يعيد [Either] إما [Failure] في حالة الفشل أو [User] في حالة النجاح
  Future<Either<Failure, User>> getCurrentUser();
  
  /// التحقق من حالة المصادقة
  /// 
  /// يعيد [bool] يشير إلى ما إذا كان المستخدم مسجل الدخول أم لا
  Future<bool> isLoggedIn();
  
  /// تسجيل الخروج
  /// 
  /// يقوم بتسجيل خروج المستخدم وحذف بيانات المصادقة المحلية
  Future<void> logout();
}
