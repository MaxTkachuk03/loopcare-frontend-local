part of 'analytics_bloc.dart';

@freezed
class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState.initial(AnalyticsData data) = AnalyticsStateInitial;

  const factory AnalyticsState.loading(AnalyticsData data) = AnalyticsStateLoading;

  const factory AnalyticsState.error(AnalyticsData data) = AnalyticsStateError;

  const factory AnalyticsState.success(AnalyticsData data) = AnalyticsStateSuccess;
}

@freezed
class AnalyticsData with _$AnalyticsData {
  const AnalyticsData._();

  const factory AnalyticsData({
    @Default(null) SendAnalyticsEventResponse? lastEvent,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _AnalyticsData;
}
