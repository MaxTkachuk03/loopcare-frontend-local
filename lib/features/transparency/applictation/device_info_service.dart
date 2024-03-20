import 'dart:async';
import 'dart:io';

import 'package:advertising_id/advertising_id.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/transparency/applictation/transparency_service.dart';
import 'package:loopcare_frontend/features/transparency/domain/device_info.dart';

@singleton
class DeviceInfoService {
  final TransparencyService apiTransparencyService;
  String? advertisingId;
  String? deviceId;
  bool isLimitAdTrackingEnabled = false;
  TrackingStatus trackingStatus = TrackingStatus.notDetermined;

  DeviceInfoService(this.apiTransparencyService);

  FutureOr<void> onRequestTrackingAuthorization() async {
    TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
    debugPrint("devcpp IDFA status : $status");
    if (status == TrackingStatus.notDetermined) {
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    }
    _getAdvertisingIdentifier();
    trackingStatus = status;
  }

  FutureOr<void> _getAdvertisingIdentifier() async {
    if (Platform.isIOS) {
      advertisingId = await AppTrackingTransparency.getAdvertisingIdentifier();
      debugPrint("devcpp IDFA : $advertisingId");
    } else {
      try {
        advertisingId = await AdvertisingId.id(true);
        debugPrint('devcpp AAID: $advertisingId');
      } on PlatformException {
        //handle if needed
      }
    }
    try {
      isLimitAdTrackingEnabled = await AdvertisingId.isLimitAdTrackingEnabled ?? false;
      debugPrint('devcpp isLimitAdTrackingEnabled: $isLimitAdTrackingEnabled');
    } on PlatformException {
      isLimitAdTrackingEnabled = true;
    }

    if (approvedTrackingAdvertising) {
      _onRequestDeviceId();
    }
  }

  FutureOr<void> _onRequestDeviceId() async {
    try {
      deviceId = await FlutterUdid.udid;
      debugPrint("devcpp  FlutterUdid DeviceId : $deviceId");
    } on PlatformException {
      deviceId = null;
    }
    if (approvedTrackingDeviceId) {
      final response =
          await apiTransparencyService.saveDeviceInfo(DeviceInfo(advertisingId: advertisingId!, deviceId: deviceId!));
      response.fold(
        (error) {
          //handle if needed
        },
        (r) {
          //handle if needed
        },
      );
    }
  }

  bool get hasAdvertisingId => advertisingId != null;

  bool get hasDeviceId => deviceId != null;

  bool get approvedTrackingAdvertising => Platform.isIOS
      ? trackingStatus == TrackingStatus.authorized && !isLimitAdTrackingEnabled && hasAdvertisingId
      : !isLimitAdTrackingEnabled && hasAdvertisingId;

  bool get approvedTrackingDeviceId => Platform.isIOS
      ? trackingStatus == TrackingStatus.authorized && !isLimitAdTrackingEnabled && hasDeviceId
      : !isLimitAdTrackingEnabled && hasDeviceId;
}
