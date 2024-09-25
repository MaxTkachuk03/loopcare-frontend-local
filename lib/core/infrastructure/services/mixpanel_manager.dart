import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loopcare_frontend/build_type.dart';
import 'package:loopcare_frontend/core/infrastructure/services/country_code_service/country_code_service.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
import 'package:loopcare_frontend/core/infrastructure/services/stored_account_service/stored_account_service.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

String _kToken = '';

class MixpanelManager {
  late Mixpanel _mixpanel;
  late PackageInfo packageInfo;

  String get _userServer => CountryCodeService.instance.serverCountryCode;

  int get _userId => StoredAccountService.getAccount()?.id ?? -1;

  Map<String, dynamic> _deviceData = <String, dynamic>{};
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  String get _email => StoredAccountService.getAccount()?.email ?? '';

  Future<void> init() async {
    if (!kIsProd) {
      return;
    }
    _kToken = kIsAnalyticTestingEnv
        ? dotenv.env['MIXPANEL_TOKEN'] ?? ''
        : dotenv.env['PROD_MIXPANEL_TOKEN'] ?? '';

    _initMobile();
  }

  Future<void> _initMobile() async {
    _mixpanel = await Mixpanel.init(_kToken, trackAutomaticEvents: false);
    packageInfo = await PackageInfo.fromPlatform();
  }

  void reset() {
    try {
      _mixpanel.reset();
    } catch (e) {
      log.e(e.toString(), error: 'ERROR reset MIXPANEL');
    }
  }

  void identify({int? id}) {
    try {
      _mixpanel.identify('${id ?? _userId}-$_userServer');
      _mixpanel.getPeople().set('\$email', _email);
    } catch (e) {
      log.e(e.toString(), error: 'ERROR identify MIXPANEL');
    }
  }

  void alias(int id) {
    try {
      _mixpanel.alias('$id-$_userServer', '$id-$_userServer');
    } catch (e) {
      log.e(e.toString(), error: 'ERROR alias MIXPANEL');
    }
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
      'distinct_id': '$_userId-$_userServer',
      '\$email': _email,
      '\$os': Platform.isAndroid ? 'Android' : 'iOs',
      '\$build_type': EnvironmentType.currentType.name,
      '\$app_build_number': packageInfo.buildNumber,
      '\$app_version_string': packageInfo.version,
    });

    if (Platform.isAndroid) {
      _deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      _deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }

    data.addAll(_deviceData);

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
