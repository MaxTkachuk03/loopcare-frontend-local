import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loopcare_frontend/build_type.dart';

class AppsFlyerService {
  static AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
    afDevKey: dotenv.env['APPS_FLYER_AF_DEV_KEY']!,
    appId: dotenv.env['APPS_FLYER_APP_ID']!,
    showDebug: !kIsProd,
    timeToWaitForATTUserAuthorization: 30,
  );

  static AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

  static init() async {
    await appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );
  }

  static logEvent({required String eventName, Map<String, String>? args}) async {
    await appsflyerSdk.logEvent(eventName, args);
  }
}
