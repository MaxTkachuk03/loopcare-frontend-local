import 'dart:convert';

import 'package:crowdin_sdk/crowdin_sdk.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/services/local_localization_service/local_localization_service.dart';
import 'package:loopcare_frontend/injection.dart';

const List<String> _pluralIds = ['=0', '=1', '=2', 'few', 'many', 'other'];
const String _kCount = 'count';

extension LocalizationExtension on String {
  String tr([Map<String, dynamic> params = const {}]) {
    String locale = getIt<AppConfig>().language;
    final string = Crowdin.getText(locale, this, params) ?? _getLocalizedString(this, params: params);
    return string;
  }

  String _getLocalizedString(String key, {Map<String, dynamic>? params}) {
    final jsonString = getIt<LocalLocalizationService>().translations;
    if (jsonString == null || jsonString.isEmpty) {
      return key;
    }
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    final strings = jsonMap.map((key, value) => MapEntry(key, value.toString()));

    if (strings.isEmpty) {
      return key;
    }

    String? localizedString = strings[key];

    if (localizedString == null) {
      return key;
    }

    // Replace placeholders with actual values
    if (params != null) {
      params.forEach((key, value) {
        localizedString = localizedString?.replaceAll('{$key}', value.toString());
      });
    }

    return localizedString ?? key;
  }

  /// Returns the pluralized message based on the provided count and locale.
  ///
  /// This function takes in three parameters:
  ///   - `count`: The number to determine the plural form. (Required)
  ///   - `params`: A map of parameters for named arguments. (Optional, default is an empty map)
  ///   - `countPlaceholderName`: The name of the placeholder for the count value. (Optional, default is "count")
  String plural({
    required int count,
    Map<String, dynamic>? params,
    String? countPlaceholderName,
  }) {
    final countPlaceholder = countPlaceholderName ?? _kCount;
    final localisationParams = { if (params != null)...params, countPlaceholder: count };

    final currentLocale = Locale(Intl.shortLocale(Intl.systemLocale));
    final locale = currentLocale.toString();

    // Get the translated string with named arguments
    final message = _getLocalizedString(this, params: localisationParams);
    if (message == this) return this;

    // Extract pluralized versions from the message
    final extractedPlurals = _pluralIds
        .map((pluralId) => _findPlural(message, pluralId))
        .toList();

    // Return the correct pluralized message
    return Intl.pluralLogic(
          count,
          locale: locale,
          zero: extractedPlurals[0],
          one: extractedPlurals[1],
          two: extractedPlurals[2],
          few: extractedPlurals[3],
          many: extractedPlurals[4],
          other: extractedPlurals[5],
        ) ??
        this;
  }

  String? _findPlural(String messageValue, String pluralKey) {
    final startIndex = messageValue.indexOf(pluralKey);

    /// Returns -1 if no match is found
    if (startIndex == -1) {
      return null;
    }
    final openingBraceIndex = messageValue.indexOf('{', startIndex);
    if (openingBraceIndex == -1) {
      return null;
    }
    final closingBraceIndex = messageValue.indexOf('}', openingBraceIndex);
    if (closingBraceIndex == -1) {
      return null;
    }
    return messageValue.substring(openingBraceIndex + 1, closingBraceIndex);
  }
}

// Simulated method to retrieve strings from a JSON or ARB file.
Future<bool> loadLocalLocalizations() async {
  String locale = getIt<AppConfig>().language;
  final jsonString = await rootBundle.loadString('lib/l10n/app_$locale.arb');
  getIt<LocalLocalizationService>().translations = jsonString;
  return true;
}
