import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:loopcare_frontend/localization/src/app_localizations.dart';

class LocalizationConstants {
  LocalizationConstants._();

  static String localeLanguageCode() {
    final deviceLanguage = WidgetsBinding.instance.platformDispatcher.locale.languageCode;

    return AppLocalizations.supportedLocales
            .firstWhereOrNull((l) => l.languageCode.toLowerCase() == deviceLanguage.toLowerCase())
            ?.languageCode ??
        'en';
  }
}
