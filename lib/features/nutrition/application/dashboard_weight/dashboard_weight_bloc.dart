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

  DashboardWeightBloc(this.nutritionService) : super(const DashboardWeightState.initial()) {
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
      weights[element.date] = element;
    }

    return weights;
  }

  FutureOr<void> _onFetchWeights(
    FetchWeights event,
    Emitter<DashboardWeightState> emit,
  ) async {
    emit(const DashboardWeightState.loading());

    final response = await nutritionService.getDashboardWeights(
      event.startDate.isoStringWithoutTime,
      DateTime.now().isoStringWithoutTime,
    );

    response.fold(
      (error) => emit(DashboardWeightState.error(error)),
      (response) => emit(
        DashboardWeightState.weights(
          weights: _combineWeightsByDate(
            null,
            response.data,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onSetDate(
    SetDate event,
    Emitter<DashboardWeightState> emit,
  ) async {
    final weights = state.mapOrNull(weights: (s) => s.weights);

    if (weights == null || event.date.isAfter(DateTime.now())) return;

    final isoStringDate = event.date.isoStringWithoutTime;

    final bool isAlreadyLoaded = weights.containsKey(isoStringDate.split('T')[0]);

    if (isAlreadyLoaded) return;

    emit(const DashboardWeightState.loading());

    final response = await nutritionService.getDashboardWeights(
      isoStringDate,
      isoStringDate,
    );

    response.fold(
      (error) => emit(DashboardWeightState.error(error)),
      (response) => emit(
        DashboardWeightState.weights(
          weights: _combineWeightsByDate(
            weights,
            response.data,
          ),
        ),
      ),
    );
  }

  FutureOr<void> _onLogWeight(
    LogWeight event,
    Emitter<DashboardWeightState> emit,
  ) async {
    final Map<String, DashboardWeightItem> weights = Map.from(state.weights);

    final data = LogWeightBody(
      date: event.date.isoStringWithoutTime,
      weight: event.weight,
    );

    emit(const DashboardWeightState.loading());

    final response = await nutritionService.logWeight(data);

    response.fold(
      (error) => emit(DashboardWeightState.error(error)),
      (response) {
        weights[response.data.date] = response.data;

        emit(
          DashboardWeightState.weights(weights: weights),
        );
      },
    );
  }
}
