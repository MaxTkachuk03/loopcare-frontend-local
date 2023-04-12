import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/core/infrastructure/dio_client/request_error.dart';
import 'package:loopcare_frontend/features/nutrition/application/dto/food_item_bar_code/food_item_bar_code.dart';
import 'package:loopcare_frontend/features/nutrition/application/nutrition_service.dart';

part 'barcode_scanner_bloc.freezed.dart';

part 'barcode_scanner_event.dart';

part 'barcode_scanner_state.dart';

@singleton
class BarcodeScannerBloc
    extends Bloc<BarcodeScannerEvent, BarcodeScannerState> {
  final NutritionService barcodeService;

  BarcodeScannerBloc(
    this.barcodeService,
  ) : super(BarcodeScannerState.initial()) {
    on<GetInformation>(_onGetInformation);
  }

  FutureOr<void> _onGetInformation(
    GetInformation event,
    Emitter<BarcodeScannerState> emit,
  ) async {
    emit(BarcodeScannerState.loading());
    final response = await barcodeService
        .getBarcodeInformation(event.barCode); //'020357122682'

    response.fold(
      (l) => emit(BarcodeScannerState.error(error: l)),
      (r) => emit(
        BarcodeScannerState.success(foodItem: r.data),
      ),
    );
  }
}
