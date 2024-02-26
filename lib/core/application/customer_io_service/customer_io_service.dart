import 'dart:io';

import 'package:customer_io/customer_io.dart';
import 'package:customer_io/customer_io_config.dart';
import 'package:customer_io/customer_io_enums.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loopcare_frontend/core/application/firebase/mesaging/firebase_messaging.dart';
import 'package:loopcare_frontend/injection.dart';

class CustomerIoService {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  static Future<void> initialize() async {
    await CustomerIO.initialize(
      config: CustomerIOConfig(
        siteId: dotenv.env['CUSTOMER_IO_SITE_ID'] ?? '',
        apiKey: dotenv.env['CUSTOMER_IO_API_KEY'] ?? '',
        region: Region.us,
        autoTrackDeviceAttributes: true,
        enableInApp: true,
      ),
    );
  }

  static Future<void> userRegistered({
    required String email,
    required String name,
    required int id,
  }) async {
    CustomerIO.identify(
      identifier: email,
      attributes: {
        'name': name,
        'id': id,
        'created_at': _timestamp,
      },
    );

    await _setDevice();

    CustomerIO.track(name: 'new_user');
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
        'id': id,
        'name': name,
        'last_auth': _timestamp,
      },
    );

    await _setDevice();

    CustomerIO.track(name: 'authentication');
  }

  static void track({
    required String event,
    Map<String, dynamic>? attributes,
  }) => CustomerIO.track(name: event, attributes: attributes ?? {});

  static Map<String, dynamic> _androidDeviceData(AndroidDeviceInfo data) {
    return <String, dynamic>{
      'operating_system': 'Android',
      'os_version': '${data.version.release} (SDK ${data.version.sdkInt})',
      'device': data.model,
      'system_locale': Platform.localeName,
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
      'system_locale': Platform.localeName,
    };
  }

  static Future<void> _setDevice() async {
    Map<String, dynamic> deviceData = {};
    if (Platform.isAndroid) {
      deviceData = _androidDeviceData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _iosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }

    final deviceToken = await getIt<FirebaseMessagingService>().getToken();

    if (deviceToken != null) {
      CustomerIO.registerDeviceToken(deviceToken: deviceToken);
    }

    CustomerIO.setDeviceAttributes(
      attributes: deviceData,
    );
  }
}

int get _timestamp => (DateTime.timestamp().millisecondsSinceEpoch / 1000).round();
