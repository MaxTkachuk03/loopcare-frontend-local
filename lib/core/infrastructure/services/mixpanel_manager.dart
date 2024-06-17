import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

String _kToken = '';

class MixpanelManager {
  late Mixpanel _mixpanel;
  late PackageInfo packageInfo;

  String distinctId = const Uuid().v4();
  Map<String, dynamic> deviceData = <String, dynamic>{};
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Future<void> init() async {
    _kToken = dotenv.env['MIXPANEL_TOKEN'] ?? '';
    if (!kIsWeb) {
      _initMobile();
    }
  }

  Future<void> _initMobile() async {
    _mixpanel = await Mixpanel.init(_kToken, trackAutomaticEvents: false);
    packageInfo = await PackageInfo.fromPlatform();
  }

  void track(String eventName, Map<String, dynamic>? data) => _trackForMobile(eventName, data);

  void _trackForMobile(
    String eventName,
    Map<String, dynamic>? data,
  ) async {
    await _initMobile();

    // ignore: parameter_assignments
    data ??= {};
    data.addAll({
      'distinct_id': distinctId,
      '\$os': Platform.isAndroid ? 'Android' : 'iOs',
      '\$build_type': EnvironmentType.currentType.name,
      '\$app_build_number': packageInfo.buildNumber,
      '\$app_version_string': packageInfo.version,
    });

    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }

    data.addAll(deviceData);

    _mixpanel.track(eventName, properties: data);
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
