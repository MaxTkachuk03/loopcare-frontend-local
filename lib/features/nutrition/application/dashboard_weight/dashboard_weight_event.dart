part of 'dashboard_weight_bloc.dart';

@freezed
class DashboardWeightEvent with _$DashboardWeightEvent {
  const factory DashboardWeightEvent.fetchWeights() = FetchWeights;

  const factory DashboardWeightEvent.updateWeight() = UpdateWeight;

  const factory DashboardWeightEvent.setWeight() = SetWeight;
}
