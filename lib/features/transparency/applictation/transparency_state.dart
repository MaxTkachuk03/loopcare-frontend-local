part of 'transparency_bloc.dart';

@freezed
class TransparencyState with _$TransparencyState {
  const factory TransparencyState.initial(TransparencyStateData data) = InitialTransparencyState;

  const factory TransparencyState.successPermissionApprove(TransparencyStateData data) = SuccessPermissionApprove;

  const factory TransparencyState.error(TransparencyStateData data) = ErrorTransparencyState;

  const factory TransparencyState.gotStatusTrackingAuthorization(TransparencyStateData data) =
      GotStatusTrackingAuthorization;

  const factory TransparencyState.gotAdvertisingIdentifier(TransparencyStateData data) = GotAdvertisingIdentifier;

  const factory TransparencyState.gotDeviceId(TransparencyStateData data) = GotDeviceId;

  const factory TransparencyState.success(TransparencyStateData data) = SucceessSaveDeviceInfo;
}

@freezed
class TransparencyStateData with _$TransparencyStateData {
  const TransparencyStateData._();

  const factory TransparencyStateData({
    RequestError? error,
    @Default(false) bool isLoading,
    @Default(false) bool isLimitAdTrackingEnabled,
    @Default(TrackingStatus.notDetermined) TrackingStatus trackingStatus,
    String? advertisingId,
    String? deviceId,
  }) = _TransparencyStateData;

  String? get errorMessage => error?.maybeMap(conflict: (s) => s.error.error, orElse: () => null);
}
