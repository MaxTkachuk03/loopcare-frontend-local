import 'dart:async';
import 'dart:io';

import 'package:advertising_id/advertising_id.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';
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
    log.i('IDFA status : $status', error: runtimeType);

    if (status == TrackingStatus.notDetermined) {
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    }
    _getAdvertisingIdentifier();
    trackingStatus = status;
  }

  FutureOr<void> _getAdvertisingIdentifier() async {
    if (Platform.isIOS) {
      advertisingId = await AppTrackingTransparency.getAdvertisingIdentifier();
      log.i('IDFA : $advertisingId', error: runtimeType);
    } else {
      try {
        advertisingId = await AdvertisingId.id(true);
        log.i('AAID : $advertisingId', error: runtimeType);
      } on PlatformException catch (e) {
        //handle if needed
        log.e(e.toString(), error: e.runtimeType);
      }
    }
    try {
      isLimitAdTrackingEnabled = await AdvertisingId.isLimitAdTrackingEnabled ?? false;
      log.i('isLimitAdTrackingEnabled : $isLimitAdTrackingEnabled', error: runtimeType);
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
      log.i('FlutterUdid DeviceId : $deviceId', error: runtimeType);
    } on PlatformException {
      deviceId = null;
    }
    if (approvedTrackingDeviceId) {
      final response = await apiTransparencyService.saveDeviceInfo(
        DeviceInfo(advertisingId: advertisingId!, deviceId: deviceId!),
      );

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
