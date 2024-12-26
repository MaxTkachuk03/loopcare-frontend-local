import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_service.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_category.dart';

part 'smart_goals_categories_event.dart';
part 'smart_goals_categories_state.dart';
part 'smart_goals_categories_bloc.freezed.dart';

@singleton
class SmartGoalsCategoriesBloc extends Bloc<SmartGoalsCategoriesEvent, SmartGoalsCategoriesState> {
  final SmartGoalsService _smartGoalsService;

  SmartGoalsCategoriesBloc(this._smartGoalsService)
      : super(const SmartGoalsCategoriesState.initial(SmartGoalsCategoriesStateData())) {
    on<GetCategories>(_onGetGoalsCategories);
    on<UnlockCategory>(_onUnlockCategory);
  }

  FutureOr<void> _onGetGoalsCategories(
    GetCategories event,
    Emitter<SmartGoalsCategoriesState> emit,
  ) async {
    emit(SmartGoalsCategoriesState.goalsCategoriesLoading(state.data.copyWith(isLoading: true)));

    // Use the stream from the event
    final response = await _smartGoalsService.getGoalsCategories(stream: event.stream);

    response.fold(
      (l) => emit(SmartGoalsCategoriesState.goalsCategoriesError(
          state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(SmartGoalsCategoriesState.goalsCategoriesLoaded(
          state.data.copyWith(goalsCategories: r.data, isLoading: false))),
    );
  }

  FutureOr<void> _onUnlockCategory(
    UnlockCategory event,
    Emitter<SmartGoalsCategoriesState> emit,
  ) async {
    final response = await _smartGoalsService.unlockCategory(id: event.id);

    response.fold(
      (l) => emit(SmartGoalsCategoriesState.goalsCategoriesError(
          state.data.copyWith(error: l, isLoading: false))),
      (r) => null,
    );
  }
}
