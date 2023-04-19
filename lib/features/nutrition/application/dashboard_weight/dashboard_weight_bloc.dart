import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/dashboard_weight/dto/dashboard_weight_item.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';

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
    on<SetWeight>(_onSetWeight);
    on<UpdateWeight>(_onUpdateWeight);
  }

  FutureOr<void> _onFetchWeights(
    FetchWeights event,
    Emitter<DashboardWeightState> emit,
  ) async {
    emit(const DashboardWeightState.loading());

    final response = await nutritionService.getDashboardWeights(
      DateTime.now(),
      DateTime.now(),
    );

    response.fold(
      (error) {
        emit(DashboardWeightState.error(error));
      },
      (response) {
        emit(
          DashboardWeightState.weights(weights: response.data.toIList()),
        );
      },
    );
  }

  FutureOr<void> _onSetWeight(
    SetWeight event,
    Emitter<DashboardWeightState> emit,
  ) async {
    emit(const DashboardWeightState.loading());

    final response = await nutritionService.saveWeight(
      DateTime.now(),
      '89',
    );

    // response.fold(
    //       (error) {
    //     emit(DashboardWeightState.error(error));
    //   },
    //       (response) {
    //     emit(
    //       DashboardWeightState.weights(weights: response.data),
    //     );
    //   },
    // );
  }

  FutureOr<void> _onUpdateWeight(
    UpdateWeight event,
    Emitter<DashboardWeightState> emit,
  ) async {
    emit(const DashboardWeightState.loading());

    final response = await nutritionService.updateWeight(
      DateTime.now(),
      '89',
    );

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
