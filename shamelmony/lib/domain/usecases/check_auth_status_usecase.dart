import 'package:injectable/injectable.dart';

import '../repositories/auth_repository.dart';

/// حالة استخدام التحقق من حالة المصادقة
@injectable
class CheckAuthStatusUseCase {
  final AuthRepository repository;

  CheckAuthStatusUseCase(this.repository);

  /// تنفيذ حالة الاستخدام
  /// 
  /// يتحقق مما إذا كان المستخدم مسجل الدخول أم لا
  /// 
  /// يعيد [bool] يشير إلى حالة تسجيل الدخول
  Future<bool> call() {
    return repository.isLoggedIn();
  }
}
