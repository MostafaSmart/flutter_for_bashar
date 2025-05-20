import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// حالة استخدام الحصول على المستخدم الحالي
@injectable
class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  /// تنفيذ حالة الاستخدام
  /// 
  /// يحصل على معلومات المستخدم الحالي
  /// 
  /// يعيد [Either] إما [Failure] في حالة الفشل أو [User] في حالة النجاح
  Future<Either<Failure, User>> call() {
    return repository.getCurrentUser();
  }
}
