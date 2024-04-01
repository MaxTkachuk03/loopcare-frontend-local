import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_physical_survey.freezed.dart';
part 'add_physical_survey.g.dart';

@freezed
abstract class AddPhysicalSurvey implements _$AddPhysicalSurvey {
  const AddPhysicalSurvey._();

  const factory AddPhysicalSurvey({
    required int height,
    required DateTime birthDate,
    required int weight,
    required double bmi,
  }) = _AddPhysicalSurvey;

  factory AddPhysicalSurvey.fromJson(Map<String, dynamic> json) => _$AddPhysicalSurveyFromJson(json);
}
