import 'package:flutter/material.dart';

class LocalizationConstants {
  static const String translationsPath = 'assets/translations';

  static const Locale localeEnglish = Locale('en');

  static const Locale localeGermany = Locale('de');

  static const Locale localeDutch = Locale('nl');

  static const List<Locale> supportedLocales = [
    localeEnglish,
    localeGermany,
    localeDutch,
  ];

  LocalizationConstants._();
}
