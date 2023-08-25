import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

enum AppPlatforms { android, ios }

const String defaultSessionName = 'test';
const String defaultSessionPwd = '123456';
const String defaultSessionRole = '1';

const Map configs = {
  'ZOOM_SDK_KEY': 'NyLXgv9CwvCMhq9oVcuIAM1Ghn3ERPh4KuCq',
  'ZOOM_SDK_SECRET': 'u2k2LYE1VXC9SEnbr2h8ausSCkbiTJTQKEY0',
};

const Map<String, bool> sdkAudioOptions = {"connect": true, "mute": false, "autoAdjustSpeakerVolume": false};
const Map<String, bool> sdkVideoOptions = {"localVideoOn": true};

Map<String, List<Permission>> platformPermissions = {
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

get permissionsList => Platform.isAndroid
    ? platformPermissions[AppPlatforms.android.name]
    : platformPermissions[AppPlatforms.ios.name];
