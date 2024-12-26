part of 'delete_weekly_goal_bloc.dart';

abstract class DeleteWeeklyGoalState {}

class SelectionInitialState extends DeleteWeeklyGoalState {}

class SelectionUpdatedState extends DeleteWeeklyGoalState {
  final Set<int> selectedItemIds;
  SelectionUpdatedState(this.selectedItemIds);
}
