/// ثوابت التطبيق
class AppConstants {
  // API URLs
  static const String baseUrl = 'https://api.example.com';
  static const String loginEndpoint = '/auth/login';
  
  // Local Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String languageKey = 'app_language';
  
  // App Settings
  static const String appName = 'شامل مني';
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // Supported Languages
  static const String arabicCode = 'ar';
  static const String englishCode = 'en';
  
  // Error Messages
  static const String serverErrorMessage = 'حدث خطأ في الخادم، يرجى المحاولة لاحقاً';
  static const String connectionErrorMessage = 'لا يوجد اتصال بالإنترنت، يرجى التحقق من الاتصال';
  static const String unknownErrorMessage = 'حدث خطأ غير معروف، يرجى المحاولة لاحقاً';
}
