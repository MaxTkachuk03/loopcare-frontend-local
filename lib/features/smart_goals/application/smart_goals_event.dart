part of 'smart_goals_bloc.dart';

@freezed
class SmartGoalsEvent with _$SmartGoalsEvent {
  const factory SmartGoalsEvent.getGoals({required int categoryId}) = GetGoals;

  const factory SmartGoalsEvent.getWeeklyGoals() = GetWeeklyGoals;

  const factory SmartGoalsEvent.saveGoals() = SaveGoals;

  const factory SmartGoalsEvent.addReview(GoalReviewBody data) = AddReview;

  const factory SmartGoalsEvent.selectGoal({required SmartGoal goal}) = SelectGoal;

  const factory SmartGoalsEvent.unSelectGoal({required SmartGoal goal}) = UnSelectGoal;

  const factory SmartGoalsEvent.resetSelected() = ResetSelected;

  const factory SmartGoalsEvent.updateLoggerTimes({required ProgressSmartGoalLog goalProgress}) = UpdateLoggerTimes;

  const factory SmartGoalsEvent.resetLoggerTimes({required WeeklySmartGoal weeklyGoal}) = ResetLoggerTimes;

  const factory SmartGoalsEvent.postCompletions({required int reviewId}) = PostCompletions;
}
