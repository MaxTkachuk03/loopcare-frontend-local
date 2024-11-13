import 'dart:io';

import 'package:customer_io/customer_io.dart';
import 'package:customer_io/customer_io_config.dart';
import 'package:customer_io/customer_io_enums.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_attributes.dart';
import 'package:loopcare_frontend/core/application/customer_io_service/customer_io_events.dart';
import 'package:loopcare_frontend/core/application/firebase/mesaging/firebase_messaging.dart';
import 'package:loopcare_frontend/core/infrastructure/services/country_code_service/country_code_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

export 'customer_io_attributes.dart';
export 'customer_io_events.dart';

class CustomerIoService {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<void> initialize() async {
    await CustomerIO.initialize(
      config: CustomerIOConfig(
        siteId: kIsAnalyticTestingEnv
            ? dotenv.env['CUSTOMER_IO_SITE_ID'] ?? ''
            : dotenv.env['PROD_CUSTOMER_IO_SITE_ID'] ?? '',
        apiKey: kIsAnalyticTestingEnv
            ? dotenv.env['CUSTOMER_IO_API_KEY'] ?? ''
            : dotenv.env['PROD_CUSTOMER_IO_API_KEY'] ?? '',
        region: Region.eu,
        autoTrackDeviceAttributes: true,
        enableInApp: true,
      ),
    );
  }

  static Future<void> onboardingStarted({
    required String id,
    required String email,
    required String name,
    required bool receiveEmails,
    required bool receiveNotification,
  }) async {
    final timezone = await FlutterTimezone.getLocalTimezone();

    CustomerIO.identify(
      identifier: id,
      attributes: {
        'name': name,
        'email': email,
        'timezone': timezone,
        'created_at': _timestamp,
        'system_locale': Platform.localeName,
        'consent_to_email': receiveEmails,
        'enable_push_notifications': receiveNotification,
        'cio_subscription_preferences': {
          'topics': {
            'topic_1': receiveEmails,
            'topic_2': receiveNotification,
          },
        },
      },
    );

    CustomerIO.track(
      name: CIOEvents.onboardingNewUser,
      attributes: {
        CIOAttributes.consentToEmail: receiveEmails,
      },
    );

    await _setDevice();
  }

  static Future<void> onboardingResume({
    required String customerIoId,
  }) async {
    CustomerIO.identify(identifier: customerIoId);

    await _setDevice();
  }

  static Future<void> userAuthenticated({
    required String customerIoId,
    required String email,
    required String name,
    required int id,
  }) async {
    final info = await PackageInfo.fromPlatform();
    final appVersion = '${info.version} (${info.buildNumber})';
    final userIdPrefix = CountryCodeService.instance.serverCountryCode;
    final timezone = await FlutterTimezone.getLocalTimezone();

    CustomerIO.identify(
      identifier: customerIoId,
      attributes: {
        'user_id': '$id-$userIdPrefix',
        'email': email,
        'name': name,
        'timezone': timezone,
        'system_locale': Platform.localeName,
      },
    );

    await _setDevice();

    CustomerIO.track(
      name: CIOEvents.auth,
      attributes: {
        'last_auth': _timestamp,
        'app_version': appVersion,
      },
    );
  }

  static Future<void> onboardingResumeWithEmail({
    required String customerIoId,
    required String email,
  }) async {
    CustomerIO.identify(
      identifier: email,
      attributes: {
        'id': customerIoId,
      },
    );

    logOut();

    onboardingResume(customerIoId: customerIoId);
  }

  static void logOut() => CustomerIO.clearIdentify();

  static void track({
    required String event,
    Map<String, dynamic>? attributes,
  }) =>
      CustomerIO.track(name: event, attributes: attributes ?? {});

  static Future<void> changeUserEmail({
    required String email,
  }) async {
    CustomerIO.setProfileAttributes(
      attributes: {
        CIOAttributes.updateEmail: email,
      },
    );
  }

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
    final userIdPrefix = CountryCodeService.instance.serverCountryCode;

    CustomerIO.setProfileAttributes(
      attributes: {'user_id': '$id-$userIdPrefix'},
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
