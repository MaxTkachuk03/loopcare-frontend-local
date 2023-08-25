import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

enum AppPlatforms { android, ios }

class ZoomConfig {
  ZoomConfig();

  static const String defaultSessionName = 'test';
  static const String defaultSessionPwd = '123456';
  static const String defaultSessionRole = '1'; // 1 - admin 0 - user
  static const String domain = 'zoom.us';
  static const bool enableLog = true;

  static const Map<String, bool> sdkAudioOptions = {
    "connect": true,
    "mute": false,
    "autoAdjustSpeakerVolume": false
  };
  static const Map<String, bool> sdkVideoOptions = {"localVideoOn": true};

  static Map<String, List<Permission>> platformPermissions = {
    AppPlatforms.ios.name: [
      Permission.camera,
      Permission.microphone,
    ],
    AppPlatforms.android.name: [
      Permission.camera,
      Permission.microphone,
      Permission.bluetoothConnect,
      Permission.phone,
    ],
  };

  static get permissionsList => Platform.isAndroid
      ? platformPermissions[AppPlatforms.android.name]
      : platformPermissions[AppPlatforms.ios.name];
}

const Map configs = {
  'ZOOM_SDK_KEY': 'NyLXgv9CwvCMhq9oVcuIAM1Ghn3ERPh4KuCq',
  'ZOOM_SDK_SECRET': 'u2k2LYE1VXC9SEnbr2h8ausSCkbiTJTQKEY0',
};
