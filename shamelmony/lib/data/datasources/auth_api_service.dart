import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/util/constants.dart';
import '../models/login_response_model.dart';

/// واجهة خدمة API للمصادقة
abstract class AuthApiService {
  /// تسجيل الدخول
  Future<LoginResponseModel> login(Map<String, dynamic> body);
}

/// تنفيذ خدمة API للمصادقة
@Injectable(as: AuthApiService)
class AuthApiServiceImpl implements AuthApiService {
  final Dio dio;

  AuthApiServiceImpl(this.dio);

  @override
  Future<LoginResponseModel> login(Map<String, dynamic> body) async {
    final response = await dio.post(
      AppConstants.loginEndpoint,
      data: body,
    );
    return LoginResponseModel.fromJson(response.data);
  }
}
