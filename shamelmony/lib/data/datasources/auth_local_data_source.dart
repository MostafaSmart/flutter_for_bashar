import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/exceptions.dart';
import '../../core/util/constants.dart';
import '../models/user_model.dart';

/// واجهة مصدر البيانات المحلي للمصادقة
abstract class AuthLocalDataSource {
  /// حفظ رمز المصادقة
  Future<void> cacheToken(String token);
  
  /// الحصول على رمز المصادقة
  Future<String> getToken();
  
  /// حفظ بيانات المستخدم
  Future<void> cacheUser(UserModel user);
  
  /// الحصول على بيانات المستخدم
  Future<UserModel> getUser();
  
  /// التحقق من وجود رمز المصادقة
  Future<bool> hasToken();
  
  /// حذف بيانات المصادقة
  Future<void> clearAuthData();
}

/// تنفيذ مصدر البيانات المحلي للمصادقة
@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage secureStorage;
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({
    required this.secureStorage,
    required this.sharedPreferences,
  });

  @override
  Future<void> cacheToken(String token) async {
    try {
      await secureStorage.write(key: AppConstants.tokenKey, value: token);
    } catch (e) {
      throw CacheException(message: 'فشل في حفظ رمز المصادقة');
    }
  }

  @override
  Future<String> getToken() async {
    try {
      final token = await secureStorage.read(key: AppConstants.tokenKey);
      if (token == null) {
        throw CacheException(message: 'لا يوجد رمز مصادقة');
      }
      return token;
    } catch (e) {
      throw CacheException(message: 'فشل في الحصول على رمز المصادقة');
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      await sharedPreferences.setString(
        AppConstants.userKey,
        json.encode(user.toJson()),
      );
    } catch (e) {
      throw CacheException(message: 'فشل في حفظ بيانات المستخدم');
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final jsonString = sharedPreferences.getString(AppConstants.userKey);
      if (jsonString == null) {
        throw CacheException(message: 'لا توجد بيانات للمستخدم');
      }
      return UserModel.fromJson(json.decode(jsonString));
    } catch (e) {
      throw CacheException(message: 'فشل في الحصول على بيانات المستخدم');
    }
  }

  @override
  Future<bool> hasToken() async {
    try {
      final token = await secureStorage.read(key: AppConstants.tokenKey);
      return token != null;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearAuthData() async {
    try {
      await secureStorage.delete(key: AppConstants.tokenKey);
      await sharedPreferences.remove(AppConstants.userKey);
    } catch (e) {
      throw CacheException(message: 'فشل في حذف بيانات المصادقة');
    }
  }
}
