import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/application/apps_flyer/apps_flyer_events.dart';
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

  static start() async {
    TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;

    await appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    if (Platform.isIOS) {
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

    appsflyerSdk.startSDK(
      onSuccess: () {},
      onError: (int errorCode, String errorMessage) {
        MixpanelEventService.instance.track(
          AppMixpanelEvents.appflyerSdkStartError,
          {'error': "code $errorCode - $errorMessage"},
        );
      },
    );
  }

  static logEvent({required String eventName, Map<String, String>? args}) async {
    await appsflyerSdk.logEvent(eventName, args);
  }
}
