import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_technique_exercise.dart';

part 'mind_technique_exercises_response.g.dart';

@immutable
@JsonSerializable()
class MindTechniqueExercisesResponse {
  final List<MindTechniqueExercise> data;

  const MindTechniqueExercisesResponse(this.data);

  static MindTechniqueExercisesResponse fromJson(Map<String, dynamic> json) =>
      _$MindTechniqueExercisesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MindTechniqueExercisesResponseToJson(this);
}
