import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/smart_goals/application/dto/save_goals_body.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_service.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/weekly_goals_session.dart';

part 'smart_goals_event.dart';
part 'smart_goals_state.dart';
part 'smart_goals_bloc.freezed.dart';

@singleton
class SmartGoalsBloc extends Bloc<SmartGoalsEvent, SmartGoalsState> {
  final SmartGoalsService _smartGoalsService;

  SmartGoalsBloc(this._smartGoalsService) : super(const SmartGoalsState.initial(SmartGoalsStateData())) {
    on<GetGoals>(_onGetGoals);
    on<SaveGoals>(_onSaveGoals);
    on<SelectGoal>(_onSelectGoal);
    on<UnSelectGoal>(_onUnSelectGoal);
    on<ResetSelected>(_onResetSelected);
  }

  FutureOr<void> _onGetGoals(
    GetGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final response = await _smartGoalsService.getGoals(categoryId: event.categoryId);

    response.fold(
      (l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(SmartGoalsState.goalsLoaded(state.data.copyWith(goals: r.data, isLoading: false))),
    );
  }

  FutureOr<void> _onSaveGoals(
    SaveGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    final goals = state.data.selectedGoals.map((e) => SaveGoalsBody(smartGoalId: e.id)).toList();

    final response = await _smartGoalsService.saveGoals(goals: goals);

    response.fold(
      (l) {
        print(l);
        emit(SmartGoalsState.errorSaveGoals(state.data.copyWith(error: l, isLoading: false)));
      },
      (r) {
        print(r);
        emit(SmartGoalsState.weeklySessionSaved(
            state.data.copyWith(weeklyGoalsSession: r as WeeklyGoalsSession, isLoading: false)));
      },
    );
  }

  FutureOr<void> _onSelectGoal(
    SelectGoal event,
    Emitter<SmartGoalsState> emit,
  ) async {
    final goals = [...state.data.selectedGoals, event.goal];
    emit(SmartGoalsState.goalsLoaded(state.data.copyWith(selectedGoals: goals)));
  }

  FutureOr<void> _onUnSelectGoal(
    UnSelectGoal event,
    Emitter<SmartGoalsState> emit,
  ) async {
    final goals = [...state.data.selectedGoals];
    goals.remove(event.goal);

    emit(SmartGoalsState.goalsLoaded(state.data.copyWith(selectedGoals: goals)));
  }

  FutureOr<void> _onResetSelected(
    ResetSelected event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.goalsLoaded(state.data.copyWith(selectedGoals: [])));
  }
}
