part of 'analytics_bloc.dart';

@freezed
class AnalyticsEvent with _$AnalyticsEvent {
  const factory AnalyticsEvent.sendAnalytics(String name, Map<String, String> data) = SendAnalytics;
}
