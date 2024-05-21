import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';

part 'bmr_event.dart';
part 'bmr_state.dart';
part 'bmr_bloc.freezed.dart';

@singleton
class BmrBloc extends Bloc<BmrEvent, BmrState> {
  final NutritionService _nutritionService;

  BmrBloc(this._nutritionService) : super(const BmrState.initial(BmrStateData())) {
    on<GetBmr>(_onGetBmr);
  }

  FutureOr<void> _onGetBmr(
    GetBmr event,
    Emitter<BmrState> emit,
  ) async {
    emit(BmrState.loading(state.data.copyWith(isLoading: true)));

    final response = await _nutritionService.getBmr(event.date);

    response.fold(
      (l) => emit(BmrState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(BmrState.bmrLoaded(state.data.copyWith(bmr: double.parse(r.bmr), isLoading: false))),
    );
  }
}
