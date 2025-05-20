import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../core/util/constants.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

/// تنفيذ مستودع المصادقة
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> login({
    required String username,
    required String password,
    required String deviceIMEI,
    required String deviceName,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.login(
          username: username,
          password: password,
          deviceIMEI: deviceIMEI,
          deviceName: deviceName,
        );
        
        await localDataSource.cacheToken(response.token);
        await localDataSource.cacheUser(response.user);
        
        return Right(response.token);
      } on ServerException catch (e) {
        return Left(ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ));
      } catch (e) {
        return const Left(ServerFailure(
          message: AppConstants.unknownErrorMessage,
        ));
      }
    } else {
      return const Left(ConnectionFailure(
        message: AppConstants.connectionErrorMessage,
      ));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return const Left(CacheFailure(
        message: 'فشل في الحصول على بيانات المستخدم',
      ));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.hasToken();
  }

  @override
  Future<void> logout() async {
    await localDataSource.clearAuthData();
  }
}
