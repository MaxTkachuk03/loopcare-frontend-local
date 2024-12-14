import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:loopcare_frontend/core/infrastructure/services/country_code_service/country_code_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/stored_account_service/stored_account_service.dart';

class FacebookEventsService {
  static final FacebookAppEvents _service = FacebookAppEvents();

  FacebookEventsService() {
    init();
  }

  void init() async {
    final account = StoredAccountService.getAccount();
    final userIdPrefix = CountryCodeService.instance.serverCountryCode;

    TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;

    _service
      ..setUserID('${account?.id}-$userIdPrefix')
      ..setUserData(
        email: account?.email,
        firstName: account?.name,
        dateOfBirth: account?.birthDate.toString(),
        gender: account?.gender.name,
      );

    if (Platform.isIOS) {
      _service.setAdvertiserTracking(enabled: status == TrackingStatus.authorized ? true : false);
    }
  }

  static void logEvent({required String eventName, Map<String, dynamic>? parameters}) {
    _service.logEvent(name: eventName, parameters: parameters);
  }

  static void subscriptionEvent({required String orderId, String? currency, double? price}) {
    _service.logSubscribe(orderId: orderId, price: price, currency: currency);
  }
}
