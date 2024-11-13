part of 'barcode_scanner_bloc.dart';

@freezed
class BarcodeScannerState with _$BarcodeScannerState {
  const factory BarcodeScannerState.initial(BarcodeScannerStateData data) =
      BarcodeScannerStateInitial;

  const factory BarcodeScannerState.loading(BarcodeScannerStateData data) =
      BarcodeScannerStateLoading;

  const factory BarcodeScannerState.error(BarcodeScannerStateData data) = BarcodeScannerStateError;

  const factory BarcodeScannerState.loaded(BarcodeScannerStateData data) =
      BarcodeScannerStateLoaded;
}

@freezed
class BarcodeScannerStateData with _$BarcodeScannerStateData {
  const BarcodeScannerStateData._();

  const factory BarcodeScannerStateData({
    @Default(null) FoodItemBarCode? foodItem,
    @Default(false) bool isLoading,
    @Default(null) RequestError? error,
  }) = _BarcodeScannerStateData;
}
