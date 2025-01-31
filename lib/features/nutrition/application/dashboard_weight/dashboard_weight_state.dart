part of 'dashboard_weight_bloc.dart';

@freezed
class DashboardWeightState with _$DashboardWeightState {
  const DashboardWeightState._();

  const factory DashboardWeightState.initial(DashBoardWeightData data) =
      DashboardWeightStateInitial;

  const factory DashboardWeightState.loading(DashBoardWeightData data) =
      DashboardWeightStateLoading;

  const factory DashboardWeightState.error(DashBoardWeightData data) = DashboardWeightStateError;

  const factory DashboardWeightState.updated(DashBoardWeightData data) =
      DashboardWeightStateUpdated;

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
}

@freezed
class DashBoardWeightData with _$DashBoardWeightData {
  const DashBoardWeightData._();

  const factory DashBoardWeightData({
    @Default({}) Map<String, DashboardWeightItem> weights,
    @Default(0.0) double weightDifference,
    @Default(false) bool showChart,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _DashBoardWeightData;

  double? getSelectedDayWeight(String date) => weights[date]?.weight;

  bool hasLogOnSelectedDate(DateTime date) => weights.containsKey(date.isoStringWithoutTime);

  DateTime get firstLoggedWeightDate => weights.values.first.date;

  DateTime get lastLoggedWeightDate => weights.values.last.date;

  List<Map<String, double>> getSpotsForChart() {
    final spots = <Map<String, double>>[];
    final startDate = firstLoggedWeightDate;

    for (final w in weights.values) {
      final adjustedX = w.date.difference(startDate).inDays.toDouble();
      final adjustedY = w.weight;

      spots.add({'x': adjustedX, 'y': adjustedY});
    }

    return spots;
  }

  double? get weightLogTimeLineMax {
    if (weights.isEmpty) return null;
    return weights.values
        .map((w) => w.date.difference(firstLoggedWeightDate).inDays.toDouble())
        .reduce((a, b) => a > b ? a : b);
  }

  double get loggedWeightYMax =>
      weights.values.map((w) => w.weight).reduce((a, b) => a > b ? a : b);
}
