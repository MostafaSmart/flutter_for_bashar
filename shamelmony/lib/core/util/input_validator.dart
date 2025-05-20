import 'package:injectable/injectable.dart';

/// مدقق المدخلات
@injectable
class InputValidator {
  /// التحقق من صحة اسم المستخدم
  /// 
  /// يجب أن يكون اسم المستخدم غير فارغ وأكثر من 3 أحرف
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'يرجى إدخال اسم المستخدم';
    }
    
    if (username.length < 3) {
      return 'يجب أن يكون اسم المستخدم أكثر من 3 أحرف';
    }
    
    return null;
  }
  
  /// التحقق من صحة كلمة المرور
  /// 
  /// يجب أن تكون كلمة المرور غير فارغة وأكثر من 6 أحرف
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    
    if (password.length < 6) {
      return 'يجب أن تكون كلمة المرور أكثر من 6 أحرف';
    }
    
    return null;
  }
  
  /// التحقق من صحة رقم الجهاز
  /// 
  /// يجب أن يكون رقم الجهاز غير فارغ
  String? validateDeviceIMEI(String? imei) {
    if (imei == null || imei.isEmpty) {
      return 'يرجى إدخال رقم الجهاز';
    }
    
    return null;
  }
  
  /// التحقق من صحة اسم الجهاز
  /// 
  /// يجب أن يكون اسم الجهاز غير فارغ
  String? validateDeviceName(String? deviceName) {
    if (deviceName == null || deviceName.isEmpty) {
      return 'يرجى إدخال اسم الجهاز';
    }
    
    return null;
  }
}
