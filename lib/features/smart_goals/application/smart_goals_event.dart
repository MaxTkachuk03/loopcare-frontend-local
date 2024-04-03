part of 'smart_goals_bloc.dart';

@freezed
class SmartGoalsEvent with _$SmartGoalsEvent {
  const factory SmartGoalsEvent.getGoals({required int categoryId}) = GetGoals;
}
