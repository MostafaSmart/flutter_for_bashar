import 'package:flutter/material.dart';

import 'app_localizations.dart';

/// إعداد الترجمات
class AppLocalizationsSetup {
  /// إعداد الترجمات
  static AppLocalizations setup(BuildContext context, Locale locale) {
    return AppLocalizations(locale);
  }
}
