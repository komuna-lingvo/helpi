import 'package:flutter/widgets.dart';
import 'package:helpi/translations/en/en.dart';
import 'package:helpi/translations/es/es.dart';

class AppTranslations {
  static var locale = Locale('en');
  static var fallbackLocale = Locale('en');

  static Map<String, Map<String, String>> translationKeys = {
    'es': es,
    'en': en
  };
}
