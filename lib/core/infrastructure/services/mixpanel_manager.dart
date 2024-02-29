import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mixpanel_analytics/mixpanel_analytics.dart' as analytic;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:uuid/uuid.dart';

String _kToken = '';

class MixpanelManager {
  late analytic.MixpanelAnalytics _mixpanel;
  late PackageInfo packageInfo;

  String distinctId = const Uuid().v4();
  Map<String, dynamic> deviceData = <String, dynamic>{};
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<void> init() async {
    _kToken = dotenv.env['MIXPANEL_TOKEN'] ?? "";

    if (!kIsWeb) {
      _initMobile();
    }
  }

  Future<analytic.MixpanelAnalytics> _initMobile() async {
    // ignore: join_return_with_assignment
    _mixpanel = analytic.MixpanelAnalytics(
      token: _kToken,
      useIp: true,
    );
    packageInfo = await PackageInfo.fromPlatform();

    return _mixpanel;
  }

  void track(String eventName, Map<String, dynamic>? data) => _trackForMobile(eventName, data);

  Future<bool> _trackForMobile(
    String eventName,
    Map<String, dynamic>? data,
  ) async {
    await _initMobile();

    // ignore: parameter_assignments
    data ??= {};
    data.addAll({
      'distinct_id': distinctId,
      '\$os': Platform.isAndroid ? 'Android' : 'iOs',
      '\$build_type': const String.fromEnvironment('FLAVOR', defaultValue: 'dev'),
      '\$app_build_number': packageInfo.buildNumber,
      '\$app_version_string': packageInfo.version,
    });

    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }

    data.addAll(deviceData);

    // ignore: unnecessary_await_in_return
    return await _mixpanel.track(event: eventName, properties: data);
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'system.SecurityPatch': build.version.securityPatch,
      'system.SdkInt': build.version.sdkInt,
      'system.Release': build.version.release,
      'system.Incremental': build.version.incremental,
      'system.Brand': build.brand,
      'system.Device': build.device,
      'system.Id': build.id,
      'system.Model': build.model,
      'system.SupportedAbis': build.supportedAbis,
      'isPhysicalDevice': build.isPhysicalDevice,
      'system.DisplayWidth': build.displayMetrics.widthPx,
      'system.DisplayHeight': build.displayMetrics.heightPx,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'system.Name': data.systemName,
      'system.Version': data.systemVersion,
      'system.Model': data.model,
      'system.LocalizedModel': data.localizedModel,
      'system.Vendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'system.sysname': data.utsname.sysname,
      'system.Machine': data.utsname.machine,
      'system.release': data.utsname.release,
    };
  }
}
