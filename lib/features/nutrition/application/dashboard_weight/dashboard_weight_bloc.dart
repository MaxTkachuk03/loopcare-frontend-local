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
      event.startDate.toUtc().toIso8601String(),
      DateTime.now().toUtc().toIso8601String(),
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
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onSetDate(
    SetDate event,
    Emitter<DashboardWeightState> emit,
  ) async {
    final weights = state.data.weights;

    if (weights.isEmpty || event.date.isAfter(DateTime.now().toLocal())) return;

    final isoStringDate = event.date.toLocal().isoStringWithoutTime;

    final bool isAlreadyLoaded = weights.containsKey(isoStringDate.split('T')[0]);

    if (isAlreadyLoaded) return;

    emit(DashboardWeightState.loading(state.data.copyWith(isLoading: true)));

    final response = await nutritionService.getDashboardWeights(
      event.date.toUtc().toIso8601String(),
      event.date.toUtc().toIso8601String(),
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
            weights: _combineWeightsByDate(weights, r.data),
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onLogWeight(
    LogWeight event,
    Emitter<DashboardWeightState> emit,
  ) async {
    final Map<String, DashboardWeightItem> weights = Map.from(state.data.weights);

    final data = LogWeightBody(
      date: event.date.toUtc().toIso8601String(),
      weight: event.weight,
    );

    emit(DashboardWeightState.loading(state.data.copyWith(isLoading: false)));

    final response = await nutritionService.logWeight(data);

    response.fold(
      (l) => emit(DashboardWeightState.error(state.data.copyWith(isLoading: false, error: l))),
      (r) {
        weights[r.data.date.toLocal().isoStringWithoutTime] = r.data;

        emit(
          DashboardWeightState.updated(
            state.data.copyWith(
              weights: weights,
              isLoading: false,
              error: null,
            ),
          ),
        );
      },
    );
  }
}
