import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complete_exercise_data.g.dart';

@immutable
@JsonSerializable()
class CompleteExerciseData {
  final int scaleAfterAnswer;
  final int scaleBeforeAnswer;

  const CompleteExerciseData({
    required this.scaleAfterAnswer,
    required this.scaleBeforeAnswer,
  });

  factory CompleteExerciseData.fromJson(Map<String, dynamic> json) => _$CompleteExerciseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteExerciseDataToJson(this);
}
