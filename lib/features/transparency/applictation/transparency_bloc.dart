import 'dart:async';
import 'dart:io';

import 'package:advertising_id/advertising_id.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/transparency/applictation/transparency_service.dart';
import 'package:loopcare_frontend/features/transparency/domain/device_info.dart';

part 'transparency_bloc.freezed.dart';
part 'transparency_event.dart';
part 'transparency_state.dart';

@singleton
class TransparencyBloc extends Bloc<TransparencyEvent, TransparencyState> {
  final TransparencyService apiPurchaseService;

  TransparencyBloc(this.apiPurchaseService) : super(const TransparencyState.initial(TransparencyStateData())) {
    on<TransparencyInit>(_onInitSubscription);
    on<RequestTrackingAuthorization>(_onRequestTrackingAuthorization);
    on<GetAdvertisingIdentifier>(_onGetAdvertisingIdentifier);
    on<RequestDeviceId>(_onRequestDeviceId);
    on<SaveDeviceInfo>(_onSaveDeviceInfo);
  }

  FutureOr<void> _onSaveDeviceInfo(
    SaveDeviceInfo event,
    Emitter<TransparencyState> emit,
  ) async {
    final response =
        await apiPurchaseService.saveDeviceInfo(DeviceInfo(advertiseId: event.advertisingId, deviceId: event.deviceId));
    response.fold(
      (error) {
        emit(
          TransparencyState.error(
            state.data.copyWith(
              error: error,
              isLoading: false,
            ),
          ),
        );
      },
      (r) => emit(TransparencyState.success(state.data.copyWith(isLoading: false))),
    );
  }

  FutureOr<void> _onInitSubscription(
    TransparencyInit event,
    Emitter<TransparencyState> emit,
  ) async {
    emit(const TransparencyState.initial(TransparencyStateData()));
  }

  FutureOr<void> _onRequestTrackingAuthorization(
    RequestTrackingAuthorization event,
    Emitter<TransparencyState> emit,
  ) async {
    TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
    debugPrint("devcpp IDFA status : $status");
    if (status == TrackingStatus.notDetermined) {
      status = await AppTrackingTransparency.requestTrackingAuthorization();
    }
    add(TransparencyEvent.getAdvertisingIdentifier(status: status));
    emit(TransparencyState.gotStatusTrackingAuthorization(state.data.copyWith(trackingStatus: status)));
  }

  FutureOr<void> _onGetAdvertisingIdentifier(
    GetAdvertisingIdentifier event,
    Emitter<TransparencyState> emit,
  ) async {
    String? advertisingId;
    bool isLimitAdTrackingEnabled = false;
    if (Platform.isIOS) {
      final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
      debugPrint("devcpp IDFA : $uuid");
    }
    try {
      advertisingId = await AdvertisingId.id(true);
      debugPrint('devcpp advertisingId: $advertisingId');
    } on PlatformException {
      advertisingId = 'Failed to get platform version.';
    }
    try {
      isLimitAdTrackingEnabled = await AdvertisingId.isLimitAdTrackingEnabled ?? false;
      debugPrint('devcpp isLimitAdTrackingEnabled: $isLimitAdTrackingEnabled');
    } on PlatformException {
      isLimitAdTrackingEnabled = false;
    }
    add(const TransparencyEvent.requestDeviceId());

    emit(
      TransparencyState.gotAdvertisingIdentifier(
        state.data.copyWith(
          advertisingId: advertisingId,
          isLimitAdTrackingEnabled: isLimitAdTrackingEnabled,
        ),
      ),
    );
    if ((state.data.trackingStatus == TrackingStatus.authorized || !state.data.isLimitAdTrackingEnabled) &&
        hasAdvertisingId) {
      final response = await apiPurchaseService.saveAdvertiseId(state.data.advertisingId);
      response.fold(
        (error) {
          emit(
            TransparencyState.error(
              state.data.copyWith(
                error: error,
                isLoading: false,
              ),
            ),
          );
        },
        (r) => emit(TransparencyState.successSaveAdvertisingId(state.data.copyWith(isLoading: false))),
      );
    }
  }

  FutureOr<void> _onRequestDeviceId(
    RequestDeviceId event,
    Emitter<TransparencyState> emit,
  ) async {
    String? deviceId;
    try {
      deviceId = await FlutterUdid.udid;
      debugPrint("devcpp DeviceId : $deviceId");
    } on PlatformException {
      deviceId = null;
    }

    emit(TransparencyState.gotDeviceId(state.data.copyWith(uuid: deviceId)));
    if ((state.data.trackingStatus == TrackingStatus.authorized || !state.data.isLimitAdTrackingEnabled) &&
        hasDeviceId) {
      final response = await apiPurchaseService.saveUUID(state.data.uuid);
      response.fold(
        (error) {
          emit(
            TransparencyState.error(
              state.data.copyWith(
                error: error,
                isLoading: false,
              ),
            ),
          );
        },
        (r) => emit(TransparencyState.successSaveUUID(state.data.copyWith(isLoading: false))),
      );
    }
  }

  bool get hasAdvertisingId => state.data.advertisingId != null;

  bool get hasDeviceId => state.data.uuid != null;
}
