part of 'barcode_scanner_bloc.dart';

@freezed
class BarcodeScannerState with _$BarcodeScannerState {
  factory BarcodeScannerState.initial() => const BarcodeScannerState.success(
        foodItem: null,
      );

  factory BarcodeScannerState.loading() = _Loading;

  const factory BarcodeScannerState.success({
    FoodItemBarCode? foodItem,
    RequestError? barcodeError,
  }) = _Success;

  const factory BarcodeScannerState.error({required RequestError error}) =
      _Error;
}
