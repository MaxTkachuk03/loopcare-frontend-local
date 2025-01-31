part of 'dashboard_weight_bloc.dart';

@freezed
class DashboardWeightEvent with _$DashboardWeightEvent {
  const factory DashboardWeightEvent.fetchWeights(String startDate, String endDate) = FetchWeights;

  const factory DashboardWeightEvent.logWeight(DateTime date, double weight) = LogWeight;

  const factory DashboardWeightEvent.setDate(DateTime startDate, DateTime endDate) = SetDate;
}
