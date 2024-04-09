import 'dart:io';

import 'package:customer_io/customer_io.dart';
import 'package:customer_io/customer_io_config.dart';
import 'package:customer_io/customer_io_enums.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_attributes.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_events.dart';
import 'package:loopcare_frontend/core/application/firebase/mesaging/firebase_messaging.dart';
import 'package:loopcare_frontend/core/application/permissions_service.dart';

export 'customer_io_attributes.dart';
export 'customer_io_events.dart';

class CustomerIoService {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<void> initialize() async {
    await CustomerIO.initialize(
      config: CustomerIOConfig(
        siteId: dotenv.env['CUSTOMER_IO_SITE_ID'] ?? '',
        apiKey: dotenv.env['CUSTOMER_IO_API_KEY'] ?? '',
        region: Region.eu,
        autoTrackDeviceAttributes: true,
        enableInApp: true,
      ),
    );
  }

  static Future<void> onboardingStarted({
    required String email,
    required String name,
    required bool receiveAnEmails,
  }) async {
    final isNotificationGranted = PermissionsService.instance.isNotificationGranted;
    print('devrt $isNotificationGranted');

    CustomerIO.identify(
      identifier: email,
      attributes: {
        'name': name,
        'created_at': _timestamp,
        'system_locale': Platform.localeName,
        'consent_to_email': receiveAnEmails,
        'enable_push_notifications': isNotificationGranted,
        'cio_subscription_preferences': {
          'topics': {
            'topic_1': receiveAnEmails,
            'topic_2': isNotificationGranted,
          },
        },
      },
    );

    CustomerIO.track(
      name: CIOEvents.onboardingNewUser,
      attributes: {
        CIOAttributes.consentToEmail: receiveAnEmails,
      },
    );

    await _setDevice();
  }


  static Future<void> changeUserEmail({
    required String email,
  }) async {
    CustomerIO.track(
      name: CIOEvents.onboardingEmailChanged,
      attributes: {
        CIOAttributes.updateEmail: email,
      },
    );
  }

  static Future<void> onboardingResume({
    required String email,
  }) async {
    CustomerIO.identify(identifier: email);

    await _setDevice();
  }

  static void logOut() => CustomerIO.clearIdentify();

  static Future<void> userAuthenticated({
    required String email,
    required String name,
    required int id,
  }) async {
    CustomerIO.identify(
      identifier: email,
      attributes: {
        'user_id': id,
        'name': name,
        'system_locale': Platform.localeName,
      },
    );

    await _setDevice();



    CustomerIO.track(name: CIOEvents.auth, attributes: {'last_auth': _timestamp});
  }

  static void track({
    required String event,
    Map<String, dynamic>? attributes,
  }) => CustomerIO.track(name: event, attributes: attributes ?? {});

  static Future<void> setUserVerifiedState({
    required bool verified,
  }) async {
    CustomerIO.setProfileAttributes(
      attributes: {'email_verified': verified},
    );
  }

  static Future<void> setUserId({
    required int id,
  }) async {
    CustomerIO.setProfileAttributes(
      attributes: {'user_id': id},
    );
  }

  static Future<void> changeUserAttributes({
    required Map<String, dynamic> attributes,
  }) async {
    CustomerIO.setProfileAttributes(
      attributes: attributes,
    );
  }

  static Map<String, dynamic> _androidDeviceData(AndroidDeviceInfo data) {
    return <String, dynamic>{
      'operating_system': 'Android',
      'os_version': '${data.version.release} (SDK ${data.version.sdkInt})',
      'device': data.model,
      'display_size': data.displayMetrics,
      'fingerprint': data.fingerprint,
      'hardware': data.hardware,
    };
  }

  static Map<String, dynamic> _iosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'operating_system': 'iOS',
      'os_version': data.systemVersion,
      'device': data.model,
    };
  }

  static Future<void> _setDevice() async {
    Map<String, dynamic> deviceData = {};
    if (Platform.isAndroid) {
      deviceData = _androidDeviceData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _iosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }

    final deviceToken = await FirebaseMessagingService().getToken();

    if (deviceToken != null) {
      CustomerIO.registerDeviceToken(deviceToken: deviceToken);
    }

    CustomerIO.setDeviceAttributes(
      attributes: deviceData,
    );
  }
}

int get _timestamp => (DateTime.timestamp().millisecondsSinceEpoch / 1000).round();
