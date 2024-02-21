part of 'transparency_bloc.dart';

@freezed
class TransparencyEvent with _$TransparencyEvent {
  const factory TransparencyEvent.init() = TransparencyInit;

  const factory TransparencyEvent.requestTrackingAuthorization() = RequestTrackingAuthorization;

  const factory TransparencyEvent.getAdvertisingIdentifier({required TrackingStatus status}) = GetAdvertisingIdentifier;

  const factory TransparencyEvent.requestDeviceId() = RequestDeviceId;

  const factory TransparencyEvent.saveDeviceInfo({required String advertisingId, required String deviceId}) =
      SaveDeviceInfo;
}
