part of 'subscription_v2_bloc.dart';

@freezed
class SubscriptionV2State with _$SubscriptionV2State {
  const factory SubscriptionV2State.initial(SubscriptionV2StateData data) =
      SubscriptionV2StateInitial;

  const factory SubscriptionV2State.loading(SubscriptionV2StateData data) =
      SubscriptionV2StateLoading;

  const factory SubscriptionV2State.error(SubscriptionV2StateData data) =
      SubscriptionV2StateError;

  const factory SubscriptionV2State.loaded(SubscriptionV2StateData data) =
      SubscriptionV2StateLoaded;
}

@freezed
class SubscriptionV2StateData with _$SubscriptionV2StateData {
  const SubscriptionV2StateData._();

  factory SubscriptionV2StateData({
    RequestError? error,
    @Default(false) bool isLoading,
    @Default(0) int id,
    @Default('') String type,
    @Default('') String title,
    @Default('') String label,
    @Default('') String subText,
    @Default([]) List<SubscriptionPlanV2> plans,
  }) = _SubscriptionV2StateData;
}
