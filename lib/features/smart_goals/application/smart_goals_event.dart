part of 'smart_goals_bloc.dart';

@freezed
class SmartGoalsEvent with _$SmartGoalsEvent {
  const factory SmartGoalsEvent.getGoals({required int categoryId}) = GetGoals;

  const factory SmartGoalsEvent.getWeeklyGoals() = GetWeeklyGoals;

  const factory SmartGoalsEvent.setGoal(SmartGoal goal) = SetGoals;

  const factory SmartGoalsEvent.addReview(GoalReviewBody data) = AddReview;

  const factory SmartGoalsEvent.postCompletions({required WeeklySmartGoal weeklySmartGoal}) =
      PostCompletions;

  const factory SmartGoalsEvent.resetCompletions({required int progressId}) = ResetCompletions;

  const factory SmartGoalsEvent.deleteSession({required int sessionId}) = DeleteSession;

  const factory SmartGoalsEvent.selectCancelGoalReason({required CancelGoalReason reason}) =
      SelectCancelGoalReason;

  const factory SmartGoalsEvent.resetCancelGoalReason() = ResetCancelGoalReason;

  const factory SmartGoalsEvent.selectDate({required DateTime selectedDate}) = SelectDate;
}
