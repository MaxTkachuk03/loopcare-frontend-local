import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/smart_goals/application/smart_goals_service.dart';
import 'package:loopcare_frontend/features/smart_goals/domain/smart_goal_statistics.dart';

part 'smart_goals_statistics_bloc.freezed.dart';
part 'smart_goals_statistics_event.dart';
part 'smart_goals_statistics_state.dart';

@singleton
class SmartGoalsStatisticsBloc extends Bloc<SmartGoalsStatisticsEvent, SmartGoalsStatisticsState> {
  final SmartGoalsService _smartGoalsService;

  SmartGoalsStatisticsBloc(this._smartGoalsService)
      : super(const SmartGoalsStatisticsState.initial(SmartGoalsStatisticsStateData())) {
    on<GetSmartGoalsStatistics>(_onGetSmartGoalsStatistics);
  }

  FutureOr<void> _onGetSmartGoalsStatistics(
    GetSmartGoalsStatistics event,
    Emitter<SmartGoalsStatisticsState> emit,
  ) async {
    emit(SmartGoalsStatisticsState.loadind(state.data.copyWith(isLoading: true)));

    final response = await _smartGoalsService.getGoalsStatistics();

    response.fold(
      (l) => emit(SmartGoalsStatisticsState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(SmartGoalsStatisticsState.statisticsLoaded(
          state.data.copyWith(stats: r.data, isLoading: false))),
    );
  }
}
