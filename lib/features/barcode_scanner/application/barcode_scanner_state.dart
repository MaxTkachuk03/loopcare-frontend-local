part of 'barcode_scanner_bloc.dart';

@freezed
class BarcodeScannerState with _$BarcodeScannerState {
  factory BarcodeScannerState.initial() => const BarcodeScannerState(
        barCode: null,
        information: null,
      );

  const factory BarcodeScannerState({
    String? barCode,
    String? information,
  }) = _BarcodeScannerState;

  factory BarcodeScannerState.fromJson(Map<String, dynamic> json) =>
      _$BarcodeScannerStateFromJson(json);
}
