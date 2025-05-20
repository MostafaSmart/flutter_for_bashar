import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/util/constants.dart';

/// Cubit لإدارة اللغة
@injectable
class LocaleCubit extends Cubit<Locale> {
  final SharedPreferences sharedPreferences;

  LocaleCubit({required this.sharedPreferences})
      : super(_getStoredLocale(sharedPreferences));

  /// تغيير اللغة
  void changeLocale(String languageCode) {
    sharedPreferences.setString(AppConstants.languageKey, languageCode);
    emit(Locale(languageCode));
  }

  /// الحصول على اللغة المخزنة
  static Locale _getStoredLocale(SharedPreferences sharedPreferences) {
    final languageCode = sharedPreferences.getString(AppConstants.languageKey);
    return Locale(languageCode ?? AppConstants.arabicCode);
  }
}

/// مندوب الترجمة
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['ar', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return Future.value(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

/// ترجمات التطبيق
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();

  static const _localizedValues = {
    'ar': {
      'appName': 'شامل مني',
      'login': 'تسجيل الدخول',
      'username': 'اسم المستخدم',
      'password': 'كلمة المرور',
      'deviceIMEI': 'رقم الجهاز',
      'deviceName': 'اسم الجهاز',
      'loginButton': 'تسجيل الدخول',
      'loginSuccess': 'تم تسجيل الدخول بنجاح',
      'loginError': 'فشل تسجيل الدخول',
      'logout': 'تسجيل الخروج',
      'home': 'الرئيسية',
      'welcome': 'مرحباً',
      'changeLanguage': 'تغيير اللغة',
      'arabic': 'العربية',
      'english': 'الإنجليزية',
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'retry': 'إعادة المحاولة',
      'cancel': 'إلغاء',
      'ok': 'موافق',
    },
    'en': {
      'appName': 'Shamel Money',
      'login': 'Login',
      'username': 'Username',
      'password': 'Password',
      'deviceIMEI': 'Device IMEI',
      'deviceName': 'Device Name',
      'loginButton': 'Login',
      'loginSuccess': 'Login Successful',
      'loginError': 'Login Failed',
      'logout': 'Logout',
      'home': 'Home',
      'welcome': 'Welcome',
      'changeLanguage': 'Change Language',
      'arabic': 'Arabic',
      'english': 'English',
      'loading': 'Loading...',
      'error': 'Error',
      'retry': 'Retry',
      'cancel': 'Cancel',
      'ok': 'OK',
    },
  };

  String get appName => _localizedValues[locale.languageCode]!['appName']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;
  String get username => _localizedValues[locale.languageCode]!['username']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get deviceIMEI => _localizedValues[locale.languageCode]!['deviceIMEI']!;
  String get deviceName => _localizedValues[locale.languageCode]!['deviceName']!;
  String get loginButton => _localizedValues[locale.languageCode]!['loginButton']!;
  String get loginSuccess => _localizedValues[locale.languageCode]!['loginSuccess']!;
  String get loginError => _localizedValues[locale.languageCode]!['loginError']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get welcome => _localizedValues[locale.languageCode]!['welcome']!;
  String get changeLanguage => _localizedValues[locale.languageCode]!['changeLanguage']!;
  String get arabic => _localizedValues[locale.languageCode]!['arabic']!;
  String get english => _localizedValues[locale.languageCode]!['english']!;
  String get loading => _localizedValues[locale.languageCode]!['loading']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get retry => _localizedValues[locale.languageCode]!['retry']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get ok => _localizedValues[locale.languageCode]!['ok']!;
}
