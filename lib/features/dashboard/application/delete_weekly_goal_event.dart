part of 'delete_weekly_goal_bloc.dart';

abstract class DeleteWeeklyGoalEvent {}

class ToggleItemSelectionEvent extends DeleteWeeklyGoalEvent {
  final dynamic item;
  ToggleItemSelectionEvent(this.item);
}

class ResetSelectionsEvent extends DeleteWeeklyGoalEvent {}
