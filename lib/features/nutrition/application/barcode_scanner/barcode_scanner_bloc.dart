import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/barcode_scanner/dto/food_item_bar_code.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';

part 'barcode_scanner_bloc.freezed.dart';
part 'barcode_scanner_event.dart';
part 'barcode_scanner_state.dart';

@singleton
class BarcodeScannerBloc extends Bloc<BarcodeScannerEvent, BarcodeScannerState> {
  final NutritionService _nutritionService;

  BarcodeScannerBloc(
    this._nutritionService,
  ) : super(const BarcodeScannerState.initial(BarcodeScannerStateData())) {
    on<GetInformation>(_onGetInformation);
  }

  FutureOr<void> _onGetInformation(
    GetInformation event,
    Emitter<BarcodeScannerState> emit,
  ) async {
    emit(BarcodeScannerState.loading(state.data.copyWith(isLoading: true)));

    final response = await _nutritionService.getBarcodeInformation(event.barCode);

    response.fold(
      (l) => emit(BarcodeScannerState.error(state.data.copyWith(error: l, isLoading: false))),
      (r) => emit(
        BarcodeScannerState.loaded(state.data.copyWith(foodItem: r.data, isLoading: false)),
      ),
    );
  }
}
