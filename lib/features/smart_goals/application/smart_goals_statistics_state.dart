part of 'smart_goals_statistics_bloc.dart';

@freezed
class SmartGoalsStatisticsState with _$SmartGoalsStatisticsState {
  const factory SmartGoalsStatisticsState.initial(SmartGoalsStatisticsStateData data) =
      SmartGoalsStatisticsStateInitial;

  const factory SmartGoalsStatisticsState.loadind(SmartGoalsStatisticsStateData data) =
      SmartGoalsStatisticsStateLoading;

  const factory SmartGoalsStatisticsState.statisticsLoaded(SmartGoalsStatisticsStateData data) =
      SmartGoalsStatisticsStateStatisticsLoaded;

  const factory SmartGoalsStatisticsState.error(SmartGoalsStatisticsStateData data) =
      SmartGoalsStatisticsStateError;
}

@freezed
class SmartGoalsStatisticsStateData with _$SmartGoalsStatisticsStateData {
  const SmartGoalsStatisticsStateData._();

  const factory SmartGoalsStatisticsStateData({
    @Default(false) bool isLoading,
    RequestError? error,
    @Default([]) List<SmartGoalStatistics> stats,
  }) = _SmartGoalsStatisticsStateData;

  List<SmartGoalStatistics> get categoriesWithAccomplishedGoals =>
      stats.where((c) => c.completed > 0).toList();

  bool get hasAccomplishedCategories => categoriesWithAccomplishedGoals.isNotEmpty;

  int get totalAccomplishedGoalsAmount {
    int total = 0;

    for (var item in stats) {
      total += item.completed;
    }

    return total;
  }
}
