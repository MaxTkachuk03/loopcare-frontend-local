import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/core/infrastructure/services/logger/logger.dart';

part 'scale_content_value.freezed.dart';
part 'scale_content_value.g.dart';

@freezed
class ScaleContentValue with _$ScaleContentValue {
  const factory ScaleContentValue({
    required int id,
    required String label,
    required int value,
  }) = _ScaleContentValue;

  factory ScaleContentValue.fromJson(Map<String, dynamic> json) =>
      _$ScaleContentValueFromJson(json);

  factory ScaleContentValue.debugFromJson(Map<String, dynamic> json) {
    try {
      log.d('Parsing ScaleContentValue: $json');

      final id = json['id'] is int ? json['id'] as int : int.tryParse(json['id'].toString()) ?? 0;
      log.d('Parsed id: $id');

      final label = json['label'] as String? ?? '';
      log.d('Parsed label: $label');

      final value =
          json['value'] is int ? json['value'] as int : int.tryParse(json['value'].toString()) ?? 0;
      log.d('Parsed value: $value');

      return ScaleContentValue(
        id: id,
        label: label,
        value: value,
      );
    } catch (e, stackTrace) {
      log.e('Error in ScaleContentValue.debugFromJson: $e', error: e, stackTrace: stackTrace);
      log.e('Problematic JSON: $json');
      rethrow;
    }
  }
}
