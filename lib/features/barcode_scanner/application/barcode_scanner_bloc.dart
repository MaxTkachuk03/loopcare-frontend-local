import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loopcare_frontend/features/barcode_scanner/application/barcode_service.dart';

part 'barcode_scanner_bloc.freezed.dart';

part 'barcode_scanner_bloc.g.dart';

part 'barcode_scanner_event.dart';

part 'barcode_scanner_state.dart';

@singleton
class BarcodeScannerBloc
    extends Bloc<BarcodeScannerEvent, BarcodeScannerState> {
  final BarcodeService barcodeService;

  BarcodeScannerBloc(
    this.barcodeService,
  ) : super(BarcodeScannerState.initial()) {
    on<SetCode>(_onSetCode);
    on<GetInformation>(_onGetInformation);
  }

  FutureOr<void> _onGetInformation(
    GetInformation event,
    Emitter<BarcodeScannerState> emit,
  ) async {
    final response = await barcodeService.getInformation(state.barCode ?? '');

    response.fold(
      (l) => null,
      // emit(
      //   state.copyWith(isCompleted: false),
      // ),
      (r) => emit(
        state.copyWith(information: 'info'),
      ),
    );
  }

  FutureOr<void> _onSetCode(
    SetCode event,
    Emitter<BarcodeScannerState> emit,
  ) {
    emit(
      state.copyWith(
        barCode: event.barCode,
      ),
    );
  }
}
