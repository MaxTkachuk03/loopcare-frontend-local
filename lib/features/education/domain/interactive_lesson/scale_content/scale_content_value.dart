import 'package:freezed_annotation/freezed_annotation.dart';

part 'scale_content_value.freezed.dart';
part 'scale_content_value.g.dart';

@freezed
class ScaleContentValue with _$ScaleContentValue {
  const factory ScaleContentValue({
    required int id,
    required String label,
    required String value,
  }) = _ScaleContentValue;

  factory ScaleContentValue.fromJson(Map<String, dynamic> json) =>
      _$ScaleContentValueFromJson(json);
}
