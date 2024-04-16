part of 'mind_bloc.dart';

@freezed
class MindEvent with _$MindEvent {
  const factory MindEvent.getTechniques() = GetTechniques;

  const factory MindEvent.gerExercises({required int techniqueId}) = GerExercises;

  const factory MindEvent.completeExercise({required int techniqueId, required int exerciseId}) = CompleteExercise;

  const factory MindEvent.unlockNextExercise({required int exerciseId}) = UnlockNextExercise;

  const factory MindEvent.selectExercise({required MindTechniqueExercise exercise}) = SelectExercise;
}
