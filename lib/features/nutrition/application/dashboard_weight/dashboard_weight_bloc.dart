import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/get_measurement_system.dart';
import 'package:loopcare_frontend/core/presentation/widgets/unit_tabs/measurement_system_type.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/dashboard_weight_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/log_weight_body.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/nutrition/domain/weight_units.dart';
import 'package:loopcare_frontend/core/presentation/utils/date_time_extensions.dart';

part 'dashboard_weight_event.dart';

part 'dashboard_weight_state.dart';

part 'dashboard_weight_bloc.freezed.dart';

@singleton
class DashboardWeightBloc extends Bloc<DashboardWeightEvent, DashboardWeightState> {
  final NutritionService nutritionService;

  DashboardWeightBloc(this.nutritionService)
      : super(const DashboardWeightState.initial(DashBoardWeightData())) {
    on<FetchWeights>(_onFetchWeights);
    on<SetDate>(_onSetDate);
    on<LogWeight>(_onLogWeight);
  }

  Map<String, DashboardWeightItem> _combineWeightsByDate(
    Map<String, DashboardWeightItem>? previousWeightsData,
    List<DashboardWeightItem> data,
  ) {
    Map<String, DashboardWeightItem> weights =
        Map<String, DashboardWeightItem>.from(previousWeightsData ?? {});

    for (var element in data) {
      weights[element.date.toLocal().isoStringWithoutTime] = element;
    }

    return weights;
  }

  FutureOr<void> _onFetchWeights(
    FetchWeights event,
    Emitter<DashboardWeightState> emit,
  ) async {
    emit(DashboardWeightState.loading(state.data.copyWith(isLoading: true)));

    final response = await nutritionService.getDashboardWeights(
      event.startDate,
      event.endDate,
    );

    response.fold(
      (l) => emit(
        DashboardWeightState.error(state.data.copyWith(isLoading: false, error: l)),
      ),
      (r) => emit(
        DashboardWeightState.updated(
          state.data.copyWith(
            isLoading: false,
            error: null,
            weights: _combineWeightsByDate(null, r.data),
            weightDifference: r.highlights['weightDifference'],
            showChart: r.data.length >= 3 ? true : false,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onSetDate(
    SetDate event,
    Emitter<DashboardWeightState> emit,
  ) async {
    if (event.endDate.isAfter(DateTime.now().toLocal())) {
      emit(
        DashboardWeightState.updated(
          state.data.copyWith(
            isLoading: false,
            error: null,
            showChart: false,
            weightDifference: 0.0,
          ),
        ),
      );
      return;
    }

    emit(DashboardWeightState.loading(state.data.copyWith(isLoading: true)));

    final response = await nutritionService.getDashboardWeights(
      event.startDate.toString(),
      event.endDate.toString(),
    );

    response.fold(
      (l) => emit(
        DashboardWeightState.error(state.data.copyWith(isLoading: false, error: l)),
      ),
      (r) => emit(
        DashboardWeightState.updated(
          state.data.copyWith(
            isLoading: false,
            error: null,
            weights: _combineWeightsByDate(null, r.data),
            showChart: r.data.length >= 3 ? true : false,
            weightDifference: r.highlights['weightDifference'],
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onLogWeight(
    LogWeight event,
    Emitter<DashboardWeightState> emit,
  ) async {
    emit(DashboardWeightState.loading(state.data.copyWith(isLoading: true)));

    final Map<String, DashboardWeightItem> weights = Map.from(state.data.weights);

    final date = event.date.isToday
        ? event.date.withCurrentTime.toUtc().toIso8601String()
        : event.date.withCurrentTime.toIso8601String();

    final data = LogWeightBody(date: date, weight: event.weight);

    final response = await nutritionService.logWeight(data);

    response.fold(
      (l) => emit(DashboardWeightState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) {
        weights[r.data.date.toLocal().isoStringWithoutTime] = r.data;

        final weightDifference =
            (r.data.weight - state.data.weights.values.first.weight).toStringAsFixed(1);

        emit(
          DashboardWeightState.updated(
            state.data.copyWith(
              weights: weights,
              weightDifference: weights.length <= 1 ? 0.0 : double.parse(weightDifference),
              isLoading: false,
              error: null,
            ),
          ),
        );
      },
    );
  }
}
