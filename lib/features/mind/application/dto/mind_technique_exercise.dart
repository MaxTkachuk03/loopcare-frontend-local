import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loopcare_frontend/features/mind/application/dto/mind_content.dart';
import 'package:loopcare_frontend/features/mind/application/dto/technique_exercise_difficulty.dart';

part 'mind_technique_exercise.g.dart';
part 'mind_technique_exercise.freezed.dart';

@freezed
class MindTechniqueExercise with _$MindTechniqueExercise {
  const MindTechniqueExercise._();

  factory MindTechniqueExercise({
    required int id,
    required String title,
    required String image,
    required String shortDescription,
    required TechniqueExerciseDifficulty difficulty,
    String? scaleBeforeQuestion,
    String? scaleBeforeLowestText,
    String? scaleBeforeHighestText,
    String? scaleAfterQuestion,
    String? scaleAfterLowestText,
    String? scaleAfterHighestText,
    required bool isLocked,
    MindContent? explanation,
    DateTime? completedAt,
    required MindContent exercise,
  }) = _MindTechniqueExercise;

  factory MindTechniqueExercise.fromJson(Map<String, dynamic> json) =>
      _$MindTechniqueExerciseFromJson(json);

  int get stepsDuration => exercise.duration ?? 0;
}
