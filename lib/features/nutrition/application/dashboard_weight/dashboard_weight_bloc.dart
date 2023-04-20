import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/dashboard_weight_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';
import 'package:loopcare_frontend/features/physical_fitness/utils/date_time_extensions.dart';

part 'dashboard_weight_event.dart';
part 'dashboard_weight_state.dart';
part 'dashboard_weight_bloc.freezed.dart';

@singleton
class DashboardWeightBloc
    extends Bloc<DashboardWeightEvent, DashboardWeightState> {
  final NutritionService nutritionService;

  DashboardWeightBloc(this.nutritionService)
      : super(const DashboardWeightState.initial()) {
    on<FetchWeights>(_onFetchWeights);
    on<SetDate>(_onSetDate);
    on<UpdateWeight>(_onUpdateWeight);
  }

  Map<String, DashboardWeightItem> _combineWeightsByDate(
    Map<String, DashboardWeightItem>? previousWeightsData,
    List<DashboardWeightItem> data,
  ) {
    final Map<String, DashboardWeightItem> weights = previousWeightsData ?? {};

    for (var element in data) {
      weights[element.date] = element;
    }

    return weights;
  }

  FutureOr<void> _onFetchWeights(
    FetchWeights event,
    Emitter<DashboardWeightState> emit,
  ) async {
    final Map<String, DashboardWeightItem>? weights =
        state.mapOrNull(weights: (s) => s.weights);

    emit(const DashboardWeightState.loading());

    final response = await nutritionService.getDashboardWeights(
      event.startDate.toIso8601String(),
      DateTime.now().toIso8601String(),
    );

    response.fold(
      (error) {
        emit(DashboardWeightState.error(error));
      },
      (response) {
        emit(
          DashboardWeightState.weights(
            weights: _combineWeightsByDate(
              weights,
              response.data,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onSetDate(
    SetDate event,
    Emitter<DashboardWeightState> emit,
  ) async {
    final weights = state.mapOrNull(weights: (s) => s.weights);

    if (weights == null || event.date.isAfter(DateTime.now())) return;

    final isoStringDate = event.date.toIso8601String();

    final bool isAlreadyLoaded =
        weights.containsKey(isoStringDate.split('T')[0]);

    if (isAlreadyLoaded) return;

    emit(const DashboardWeightState.loading());

    final response = await nutritionService.getDashboardWeights(
      isoStringDate,
      isoStringDate,
    );

    response.fold(
      (error) {
        emit(DashboardWeightState.error(error));
      },
      (response) {
        emit(
          DashboardWeightState.weights(
            weights: _combineWeightsByDate(
              weights,
              response.data,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _onUpdateWeight(
    UpdateWeight event,
    Emitter<DashboardWeightState> emit,
  ) async {
    emit(const DashboardWeightState.loading());

    // final response = await nutritionService.updateWeight(
    //   DateTime.now(),
    //   '89',
    // );

    // response.fold(
    //       (error) {
    //     emit(DashboardWeightState.error(error));
    //   },
    //       (response) {
    //     emit(
    //       DashboardWeightState.weights(weights: response.data.toIList()),
    //     );
    //   },
    // );
  }
}
