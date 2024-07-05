import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class LocalizationConstants {
  static const String translationsPath = 'assets/translations';

  static const Locale localeEnglish = Locale('en');

  static const Locale localeGermany = Locale('de');

  static const Locale localeDutch = Locale('nl');

  // TODO comment other languages before get translations
  static const List<Locale> supportedLocales = [
    localeEnglish,
    // localeGermany,
    // localeDutch,
  ];

  // TODO remove after get translations
  static const List<Locale> _supportedLocales = [
    localeEnglish,
    localeGermany,
    localeDutch,
  ];


  static String localeLanguageCode() {
    final deviceLanguage = WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    return _supportedLocales
        .firstWhereOrNull((l) => l.languageCode.toLowerCase() == deviceLanguage.toLowerCase())
        ?.languageCode ?? 'en';
  }

  LocalizationConstants._();
}
