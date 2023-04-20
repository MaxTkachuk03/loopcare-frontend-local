part of 'dashboard_weight_bloc.dart';

@freezed
class DashboardWeightEvent with _$DashboardWeightEvent {
  const factory DashboardWeightEvent.fetchWeights(DateTime startDate) =
      FetchWeights;

  const factory DashboardWeightEvent.updateWeight() = UpdateWeight;

  const factory DashboardWeightEvent.setDate(DateTime date) = SetDate;
}
