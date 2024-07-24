import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

enum AppPlatforms { android, ios }

class PermissionsService {
  PermissionsService._();

  static final PermissionsService _instance = PermissionsService._();

  static PermissionsService get instance => _instance;

  PermissionsService();

  bool _isNotificationGranted = false;

  bool get isNotificationGranted => _isNotificationGranted;

  final Map<String, List<Permission>> _zoomCallsPermissions = {
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

  get _platformDependentZoomCallsPermissionsList => Platform.isAndroid
      ? _zoomCallsPermissions[AppPlatforms.android.name]
      : _zoomCallsPermissions[AppPlatforms.ios.name];

  Future<bool> _requestFilePermissions(List<Permission> neededPermissions) async {
    if (!Platform.isAndroid && !Platform.isIOS) return false;

    bool blocked = false;
    List<Permission> notGranted = [];

    Map<Permission, PermissionStatus>? statuses = await neededPermissions.request();

    statuses.forEach((key, status) {
      if (status.isDenied || status.isPermanentlyDenied) {
        blocked = true;
      } else if (!status.isGranted) {
        notGranted.add(key);
      }
    });

    if (notGranted.isNotEmpty) {
      notGranted.request();
    }

    if (blocked) {
      return await openAppSettings();
    }

    return true;
  }

  Future<bool> getZoomCallPermissions() =>
      _requestFilePermissions(_platformDependentZoomCallsPermissionsList);

  Future<bool> requestNotificationPermissions() async {
    final settings = await FirebaseMessaging.instance.requestPermission(announcement: true);

    return _isNotificationGranted = settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
