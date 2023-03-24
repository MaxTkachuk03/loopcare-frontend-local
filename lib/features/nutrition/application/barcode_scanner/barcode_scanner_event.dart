part of 'barcode_scanner_bloc.dart';

@freezed
class BarcodeScannerEvent with _$BarcodeScannerEvent {
  const factory BarcodeScannerEvent.getInformation(String barCode) =
      GetInformation;
}
