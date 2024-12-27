import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'delete_weekly_goal_event.dart';
part 'delete_weekly_goal_state.dart';

@singleton
class DeleteWeeklyGoalBloc extends Bloc<DeleteWeeklyGoalEvent, DeleteWeeklyGoalState> {
  Set<int> selectedItemIds = {};

  DeleteWeeklyGoalBloc() : super(SelectionInitialState()) {
    on<ToggleItemSelectionEvent>((event, emit) {
      if (selectedItemIds.contains(event.item.id)) {
        selectedItemIds.remove(event.item.id);
      } else {
        selectedItemIds.add(event.item.id);
      }
      emit(SelectionUpdatedState(selectedItemIds));
    });
    on<ResetSelectionsEvent>((event, emit) {
      selectedItemIds.clear();
      emit(SelectionUpdatedState(selectedItemIds));
    });
  }
}
