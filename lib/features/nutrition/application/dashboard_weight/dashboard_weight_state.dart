part of 'dashboard_weight_bloc.dart';

@freezed
class DashboardWeightState with _$DashboardWeightState {
  const DashboardWeightState._();

  const factory DashboardWeightState.initial() = _Initial;

  const factory DashboardWeightState.loading() = _Loading;

//TODO: old state style
  const factory DashboardWeightState.error(RequestError error) = _Error;

  const factory DashboardWeightState.weights({
    required Map<String, DashboardWeightItem> weights,
  }) = _Weights;

  double? getSelectedDayWeight(String date) {
    return mapOrNull(weights: (s) => s.weights[date]?.weight);
  }

  bool hasLogOnSelectedDate(DateTime date) {
    return mapOrNull(weights: (s) => s.weights.containsKey(date.isoStringWithoutTime)) ?? false;
  }

  isToday(DateTime date) {
    final todayMidnight = DateTime.now().midnightTime;
    final selectedDateMidnight = date.midnightTime;
    return selectedDateMidnight == todayMidnight;
  }

  isEditable(DateTime date) {
    final todayMidnight = DateTime.now().midnightTime;

    final isPastDate = date.isBefore(todayMidnight);
    final isLessThanSevenDaysPastDate =
        todayMidnight.difference(date.midnightTime) <= const Duration(days: 7);

    return isToday(date) || (isPastDate && isLessThanSevenDaysPastDate);
  }

  bool get isMetricSystem {
    return getMeasurementSystem() == MeasurementSystemType.metric;
  }

  String get userWeightUnits {
    return isMetricSystem ? WeightUnits.kg.name : WeightUnits.lbs.name;
  }

  Map<String, DashboardWeightItem> get weights {
    return mapOrNull(weights: (s) => s.weights) ?? {};
  }
}
