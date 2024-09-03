import 'package:crowdin_sdk/crowdin_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocalizationService {
  static Future<void> initialize() async {
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
  }
}
