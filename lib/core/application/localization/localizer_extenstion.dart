import 'dart:convert';

import 'package:crowdin_sdk/crowdin_sdk.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/services/shared_storage/shared_storage_service.dart';
import 'package:loopcare_frontend/injection.dart';

extension LocalizationExtension on String {
  String tr([Map<String, dynamic> params = const {}]) {
    String locale = getIt<AppConfig>().language;
    final string = Crowdin.getText(locale, this, params) ?? getLocalizedString(this, params: params);
    return string;
  }

  String getLocalizedString(String key, {Map<String, dynamic>? params}) {
    final jsonString = getIt<SharedStorageService>().localTranslations;
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

  String getPlural({
    required Map<String, Object> args,
    String countPlaceholderName = 'count',
  }) {
    final currentLocale = Locale(Intl.shortLocale(Intl.systemLocale));
    final locale = currentLocale.toString();
    const pluralIds = ['=0', '=1', '=2', 'few', 'many', 'other'];

    // Extract count value from args
    final count = args[countPlaceholderName] as int;
    // Get the pluralized string
    String message = getLocalizedString(this, params: args);
    if (message == this) {
      return this;
    }

    // Replace placeholders with temporary markers
    var messageValue = message;
    final placeholders = args.keys.where((key) => key != countPlaceholderName);

    for (final placeholder in placeholders) {
      messageValue = messageValue.replaceAll('{$placeholder}', '#$placeholder#');
    }

    // Extract pluralized versions from the message
    final extractedPlurals = pluralIds.map((pluralId) {
      final pluralMessage = _findPlural(messageValue, pluralId);
      final formattedPlural = placeholders.fold<String?>(
        pluralMessage,
        (result, placeholder) => result?.replaceAll('#$placeholder#', '{$placeholder}'),
      );
      return formattedPlural;
    }).toList();

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
  getIt<SharedStorageService>().localTranslations = jsonString;
  return true;
}
