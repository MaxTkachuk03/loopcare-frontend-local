import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_service.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal.dart';

part 'smart_goals_event.dart';
part 'smart_goals_state.dart';
part 'smart_goals_bloc.freezed.dart';

@singleton
class SmartGoalsBloc extends Bloc<SmartGoalsEvent, SmartGoalsState> {
  final SmartGoalsService _smartGoalsService;

  SmartGoalsBloc(this._smartGoalsService) : super(const SmartGoalsState.initial(SmartGoalsStateData())) {
    on<GetGoals>(_onGetGoals);
  }

  FutureOr<void> _onGetGoals(
    GetGoals event,
    Emitter<SmartGoalsState> emit,
  ) async {
    emit(SmartGoalsState.loading(state.data.copyWith(isLoading: true)));

    // TODO delete after api will be ready
    await Future.delayed(const Duration(seconds: 1));

    final response = await _smartGoalsService.getGoals(categoryId: event.categoryId);

    response.fold(
      (l) => emit(SmartGoalsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(SmartGoalsState.goalsLoaded(state.data.copyWith(goals: r.data, isLoading: false))),
    );
  }
}
