part of 'dashboard_weight_bloc.dart';

@freezed
class DashboardWeightState with _$DashboardWeightState {
  const DashboardWeightState._();

  const factory DashboardWeightState.initial() = _Initial;

  const factory DashboardWeightState.loading() = _Loading;

  const factory DashboardWeightState.error(RequestError fetchError) = _Error;

  const factory DashboardWeightState.weights({
    required IList<DashboardWeightItem> weights,
  }) = _Weights;
}
