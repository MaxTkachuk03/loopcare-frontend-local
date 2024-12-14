import 'package:crowdin_sdk/crowdin_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loopcare_frontend/core/infrastructure/services/app_config.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/injection.dart';

class CrowdinLocalizationService {
  Future<void> initialize() async {
    await Crowdin.init(
      distributionHash: dotenv.env['CROWDIN_BUNDLE_HASH'] ?? '',
      connectionType: InternetConnectionType.any,
      withRealTimeUpdates: true,
      authConfigurations: CrowdinAuthConfig(
        clientId: dotenv.env['CROWDIN_CLIENT_ID'] ?? '',
        clientSecret: dotenv.env['CROWDIN_CLIENT_SECRET'] ?? '',
        redirectUri: dotenv.env['CROWDIN_REDIRECT_URL'] ?? '',
      ),
      updatesInterval: const Duration(minutes: 15),
    );
    final currentLocale = Locale(getIt<AppConfig>().language);
    await Crowdin.loadTranslations(currentLocale);
    log.i('Current locale: ${currentLocale.languageCode}', error: 'CROWDIN');
  }
}
