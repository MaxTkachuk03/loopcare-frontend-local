part of 'smart_goals_bloc.dart';

@freezed
class SmartGoalsEvent with _$SmartGoalsEvent {
  const factory SmartGoalsEvent.getGoals({required int categoryId}) = GetGoals;

  const factory SmartGoalsEvent.selectGoal({required SmartGoal goal}) = SelectGoal;

  const factory SmartGoalsEvent.unSelectGoal({required SmartGoal goal}) = UnSelectGoal;

  const factory SmartGoalsEvent.resetSelected() = ResetSelected;
}
