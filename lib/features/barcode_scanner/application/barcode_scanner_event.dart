part of 'barcode_scanner_bloc.dart';

@freezed
class BarcodeScannerEvent with _$BarcodeScannerEvent {
  const factory BarcodeScannerEvent.setCode(String barCode) = SetCode;

  const factory BarcodeScannerEvent.getInformation() = GetInformation;
}
