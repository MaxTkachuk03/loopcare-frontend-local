import 'package:freezed_annotation/freezed_annotation.dart';

part 'emergency_number_data.freezed.dart';

part 'emergency_number_data.g.dart';

enum EmergencyNumberType {
  phone,
  messenger,
  none,
}

@freezed
abstract class EmergencyNumberData implements _$EmergencyNumberData {
  const EmergencyNumberData._();

  const factory EmergencyNumberData({
    required EmergencyNumberType type,
    required String title,
    required String btnTxt,
    required String number,
  }) = _EmergencyNumberData;

  factory EmergencyNumberData.fromJson(Map<String, dynamic> json) => _$EmergencyNumberDataFromJson(json);
}
