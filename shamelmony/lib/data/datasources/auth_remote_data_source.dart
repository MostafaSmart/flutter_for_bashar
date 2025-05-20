import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/exceptions.dart';
import '../../core/util/constants.dart';
import '../models/login_response_model.dart';
import 'auth_api_service.dart';

/// واجهة مصدر البيانات البعيد للمصادقة
abstract class AuthRemoteDataSource {
  /// تسجيل الدخول
  Future<LoginResponseModel> login({
    required String username,
    required String password,
    required String deviceIMEI,
    required String deviceName,
  });
}

/// تنفيذ مصدر البيانات البعيد للمصادقة
@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<LoginResponseModel> login({
    required String username,
    required String password,
    required String deviceIMEI,
    required String deviceName,
  }) async {
    try {
      final response = await apiService.login({
        'username': username,
        'password': password,
        'deviceIMEI': deviceIMEI,
        'deviceName': deviceName,
      });
      
      return response;
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final errorMessage = e.response?.data['message'] ?? AppConstants.serverErrorMessage;
      
      throw ServerException(
        message: errorMessage,
        statusCode: statusCode,
      );
    } catch (e) {
      throw ServerException(
        message: AppConstants.unknownErrorMessage,
      );
    }
  }
}
