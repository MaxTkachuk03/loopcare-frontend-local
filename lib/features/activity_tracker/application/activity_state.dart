part of 'activity_bloc.dart';

@freezed
class ActivityState with _$ActivityState {
  const factory ActivityState.initial(ActivityData data) = Initial;

  const factory ActivityState.loading(ActivityData data) = Loading;

  const factory ActivityState.contentIsLoading(ActivityData data) = ActivityIsLoading;

  const factory ActivityState.contentIsLoaded(ActivityData data) = ActivityIsLoaded;

  const factory ActivityState.errorGettingContent(ActivityData data) = ErrorGettingActivity;

  const factory ActivityState.getActivity(ActivityData data) = GetActivityData;

  const factory ActivityState.saveActivity(ActivityData data) = SaveActivityData;
}

@freezed
class ActivityData with _$ActivityData {
  const ActivityData._();

  const factory ActivityData({
    @Default([]) List<GetActivityResponse>? data,
    @Default('') String loggingDate,
    @Default(0) int steps,
    @Default(0) int heartRate,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _ActivitynData;
}
