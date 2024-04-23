import 'dart:io';

import 'package:flutter/material.dart';

class LocalizationConstants {
  static const String translationsPath = 'assets/translations';

  static const Locale localeEnglish = Locale('en');

  static const Locale localeGermany = Locale('de');

  static const Locale localeDutch = Locale('nl');

  static const List<String> _usCodes = [
    'US',
    'CA',
    'CU',
    'MX',
    'GT',
    'NI',
    'CR',
    'PA',
    'CO',
    'VE',
    'EC',
    'GY',
    'SR',
    'GF',
    'PE',
    'BR',
    'BO',
    'PY',
    'CL',
    'AR',
    'UY',
  ];

  static get useUsServer => _usCodes.contains(Platform.localeName.substring(3));

  static String get serverCountryCode => useUsServer ? 'US' : 'EU';

  // TODO comment other languages before get translations
  static const List<Locale> supportedLocales = [
    localeEnglish,
    // localeGermany,
    // localeDutch,
  ];

  LocalizationConstants._();
}
