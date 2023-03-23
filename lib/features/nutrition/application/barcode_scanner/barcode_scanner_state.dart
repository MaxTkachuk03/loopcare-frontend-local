part of 'barcode_scanner_bloc.dart';

@freezed
class BarcodeScannerState with _$BarcodeScannerState {
  factory BarcodeScannerState.initial() => const BarcodeScannerState.success(
        foodItem: null,
      );

  const factory BarcodeScannerState.success({
    FoodItem? foodItem,
    RequestError? barcodeError,
  }) = _Success;

  const factory BarcodeScannerState.error({required RequestError error}) =
      _Error;
}
