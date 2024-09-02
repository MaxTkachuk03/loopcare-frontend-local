import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/domain/analytics/apps_flyer/apps_flyer_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/mixpanel_event_service.dart';

class AppsFlyerService {
  static AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
    afDevKey: dotenv.env['APPS_FLYER_AF_DEV_KEY'] ?? '',
    appId: dotenv.env['APPS_FLYER_APP_ID'] ?? '',
    showDebug: !kIsProd,
    timeToWaitForATTUserAuthorization: 30,
    manualStart: true,
  );

  static AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

  static Future<void> start() async {
    try {
      await appsflyerSdk.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      );
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(
        'Error init appFlyer SDK ${e.toString()}',
        null,
        fatal: true,
      );
    }

    if (Platform.isIOS) {
      TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;

      final forGdpr = AppsFlyerConsent.forGDPRUser(
        hasConsentForDataUsage: true,
        hasConsentForAdsPersonalization: status == TrackingStatus.authorized ? true : false,
      );

      appsflyerSdk.setConsentData(forGdpr);
    }

    appsflyerSdk.onAppOpenAttribution((res) {
      appsflyerSdk.logEvent(AppsFlyerEvents.onAppOpenAttribution, {"res": res.toString()});
    });

    appsflyerSdk.onInstallConversionData((res) {
      appsflyerSdk.logEvent(AppsFlyerEvents.onInstallConversionData, {"res": res.toString()});
    });
    // Removed onSuccess and onError callbacks as per appsFlyer dev team recommendation 02.09.2024
    appsflyerSdk.startSDK();
  }

  static Future<String?> getAppsFlyerId() => appsflyerSdk.getAppsFlyerUID();
}
