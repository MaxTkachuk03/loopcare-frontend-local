import 'package:freezed_annotation/freezed_annotation.dart';

part 'mental_health_option.freezed.dart';
part 'mental_health_option.g.dart';

@freezed
abstract class MentalHealthOption implements _$MentalHealthOption {
  const MentalHealthOption._();

  const factory MentalHealthOption({
    required int id,
    required String title,
    required int score,
  }) = _MentalHealthOption;

  factory MentalHealthOption.fromJson(Map<String, dynamic> json) =>
      _$MentalHealthOptionFromJson(json);
}
