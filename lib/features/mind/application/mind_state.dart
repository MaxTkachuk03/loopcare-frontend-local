part of 'mind_bloc.dart';

@freezed
class MindState with _$MindState {
  const factory MindState.initial(MindStateData data) = MindStateInitial;

  const factory MindState.loading(MindStateData data) = MindStateLoading;

  const factory MindState.error(MindStateData data) = MindStateError;

  const factory MindState.gotTechniques(MindStateData data) = MindStateGotTechniques;

  const factory MindState.gotExercises(MindStateData data) = MindStateGotExercises;

  const factory MindState.exerciseSelected(MindStateData data) = MindStateExerciseSelected;

  const factory MindState.exerciseCompleted(MindStateData data) = MindStateExerciseCompleted;

  const factory MindState.exerciseUnlocked(MindStateData data) = MindStateExerciseUnlocked;
}

@freezed
class MindStateData with _$MindStateData {
  const MindStateData._();

  const factory MindStateData({
    MindInfoResponse? mindInfo,
    MindTechnique? currentTechnique,
    @Default([]) List<MindTechnique> techniques,
    @Default([]) List<MindTechniqueExercise> exercises,
    MindTechniqueExercise? currentExercise,
    @Default(false) bool isLoading,
    RequestError? error,
  }) = _MindStateData;

  MindTechniqueExercise get nextExercise {
    if (isLastExercise) {
      return currentExercise!;
    }

    final currentIndex = exercises.indexWhere((element) => element.id == currentExercise?.id);

    return exercises[currentIndex];
  }

  bool get isLastExercise => currentExercise?.id == exercises.last.id;

  bool get isConsecutiveUnlock => currentTechnique?.exerciseUnlockStyle == TechniqueExerciseUnlockStyle.consecutive;
}
